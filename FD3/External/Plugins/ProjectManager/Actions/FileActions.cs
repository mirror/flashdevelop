using System;
using System.Collections;
using System.IO;
using System.Text;
using System.Diagnostics;
using System.Windows.Forms;
using ProjectManager.Helpers;
using ProjectManager.Projects;
using PluginCore.Localization;
using WeifenLuo.WinFormsUI;
using PluginCore.Helpers;
using PluginCore.Managers;
using PluginCore;

namespace ProjectManager.Actions
{
    public delegate void FileNameHandler(string path);
    public delegate void FileMovedHandler(string fromPath, string toPath);

    /// <summary>
    /// Provides methods for creating new files and working with existing files in projects.
    /// </summary>
    public class FileActions
    {
        IMainForm mainForm;
        string storedDirectory;
        string lastFileFromTemplate;
        FlashDevelopActions fdActions;

        public event FileNameHandler FileCreated;
        public event ProjectModifiedHandler ProjectModified;
        public event FileNameHandler OpenFile;
        public event FileNameHandler FileDeleted;
        public event FileMovedHandler FileMoved;
        public event FileMovedHandler FileCopied;

        public FileActions(IMainForm mainForm, FlashDevelopActions fdActions)
        {
            this.fdActions = fdActions;
            this.mainForm = mainForm;
        }

        private void PushCurrentDirectory()
        {
            storedDirectory = Environment.CurrentDirectory;
            Environment.CurrentDirectory = Application.StartupPath;
        }

        private void PopCurrentDirectory()
        {
            try { Environment.CurrentDirectory = storedDirectory; }
            catch { }
        }

        #region Add File From Template

        public void AddFileFromTemplate(Project project, string inDirectory, string templatePath)
        {
            try
            {
                // the template could be named something like "MXML.fdt", or maybe "Class.as.fdt"
                string fileName = Path.GetFileNameWithoutExtension(templatePath);
                string extension = "";
                string caption = TextHelper.GetString("Label.AddNew") + " ";

                if (fileName.IndexOf('.') > -1)
                {
                    // it's something like Class.as.fdt
                    extension = Path.GetExtension(fileName); // .as
                    caption += Path.GetFileNameWithoutExtension(fileName);
                    fileName = TextHelper.GetString("Label.New") + Path.GetFileNameWithoutExtension(fileName).Replace(" ", ""); // just Class
                }
                else
                {
                    // something like MXML.fdt
                    extension = "." + fileName.ToLower();
                    caption += fileName + " " + TextHelper.GetString("Label.File");
                    fileName = TextHelper.GetString("Label.NewFile");
                }

                // let plugins handle the file creation
                Hashtable info = new Hashtable();
                info["templatePath"] = templatePath;
                info["inDirectory"] = inDirectory;
                DataEvent de = new DataEvent(EventType.Command, "ProjectManager.CreateNewFile", info);
                EventManager.DispatchEvent(this, de);
                if (de.Handled) return;

                LineEntryDialog dialog = new LineEntryDialog(caption, TextHelper.GetString("Label.FileName"), fileName + extension);
                dialog.SelectRange(0, fileName.Length);

                if (dialog.ShowDialog() == DialogResult.OK)
                {
                    FlashDevelopActions.CheckAuthorName();

                    string newFilePath = Path.Combine(inDirectory, dialog.Line);
                    if (!Path.HasExtension(newFilePath) && extension != ".ext")
                        newFilePath = Path.ChangeExtension(newFilePath, extension);

                    if (!ConfirmOverwrite(newFilePath)) return;

                    // save this so when we are asked to process args, we know what file it's talking about
                    lastFileFromTemplate = newFilePath;

                    mainForm.FileFromTemplate(templatePath, newFilePath);
                }
            }
            catch (UserCancelException) { }
            catch (Exception exception)
            {
                ErrorManager.ShowError(exception);
            }
        }

        public string ProcessArgs(Project project, string args)
        {
            if (lastFileFromTemplate != null)
            {
                string fileName = Path.GetFileNameWithoutExtension(lastFileFromTemplate);

                args = args.Replace("$(FileName)", fileName);

                if (args.Contains("$(FileNameWithPackage)") || args.Contains("$(Package)"))
                {
                    string package = "";
                    string path = lastFileFromTemplate;

                    // Find closest parent
                    string classpath = project.AbsoluteClasspaths.GetClosestParent(path);

                    // Can't find parent, look in global classpaths
                    if (classpath == null)
                    {
                        PathCollection globalPaths = new PathCollection();
                        foreach (string cp in PluginMain.Settings.GlobalClasspaths)
                            globalPaths.Add(cp);
                        classpath = globalPaths.GetClosestParent(path);
                    }
                    if (classpath != null)
                    {
                        // Parse package name from path
                        package = Path.GetDirectoryName(ProjectPaths.GetRelativePath(classpath, path));
                        package = package.Replace(Path.DirectorySeparatorChar, '.');
                    }

                    args = args.Replace("$(Package)", package);

                    if (package != "")
                        args = args.Replace("$(FileNameWithPackage)", package + "." + fileName);
                    else
                        args = args.Replace("$(FileNameWithPackage)", fileName);
                }
            }
            return args;
        }

        #endregion

        #region Adding Other Items

        public void AddLibraryAsset(Project project, string inDirectory)
        {
            OpenFileDialog dialog = new OpenFileDialog();
            dialog.Title = TextHelper.GetString("Label.AddLibraryAsset");
            dialog.Filter = TextHelper.GetString("Info.FileFilter");
            dialog.Multiselect = false;

            if (dialog.ShowDialog() == DialogResult.OK)
            {
                string filePath = CopyFile(dialog.FileName, inDirectory);

                // null means the user cancelled
                if (filePath == null) return;

                // add as an asset
                project.SetLibraryAsset(filePath, true);

                if (!FileInspector.IsSwc(filePath))
                {
                    // ask if you want to keep this file updated
                    string caption = TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
                    string message = TextHelper.GetString("Info.ConfirmFileUpdate");

                    DialogResult result = MessageBox.Show(mainForm, message, caption,
                        MessageBoxButtons.YesNo, MessageBoxIcon.Question);

                    if (result == DialogResult.Yes)
                    {
                        LibraryAsset asset = project.GetAsset(filePath);
                        asset.UpdatePath = project.GetRelativePath(dialog.FileName);
                    }
                }

                project.Save();
                OnProjectModified(new string[] { filePath });
            }
        }

        public void AddExistingFile(string inDirectory)
        {
            OpenFileDialog dialog = new OpenFileDialog();
            dialog.Title = TextHelper.GetString("Label.AddExistingFile");
            dialog.Filter = TextHelper.GetString("Info.FileFilter");
            dialog.Multiselect = false;

            if (dialog.ShowDialog() == DialogResult.OK)
                CopyFile(dialog.FileName, inDirectory);
        }

        public void AddFolder(string inDirectory)
        {
            try
            {
                string label = TextHelper.GetString("Label.NewFolder").Replace("&", "").Replace("...", "");
                string path = Path.Combine(inDirectory, label);

                int i = 2;
                while (Directory.Exists(path))
                    path = Path.Combine(inDirectory, label + " (" + (i++) + ")");

                // this will set off a interesting chain of events that will cause
                // the newly created "New Folder" node to begin label editing.
                OnFileCreated(path);

                Directory.CreateDirectory(path);
            }
            catch (Exception exception)
            {
                String msg = TextHelper.GetString("Info.CouldNotAddFolder");
                ErrorManager.ShowInfo(msg + " " + exception.Message);
            }
        }

        #endregion

        #region Working With Existing Files

        private bool cut;

        public void CutToClipboard(string[] paths)
        {
            CopyToClipboard(paths);
            cut = true;
        }

        public void CopyToClipboard(string[] paths)
        {
            cut = false;
            DataObject o = new DataObject(DataFormats.FileDrop, paths);
            Clipboard.SetDataObject(o);
        }

        public void PasteFromClipboard(string toPath)
        {
            if (File.Exists(toPath)) 
                toPath = Path.GetDirectoryName(toPath);

            DataObject o = Clipboard.GetDataObject() as DataObject;
            if (o.GetDataPresent(DataFormats.FileDrop))
            {
                // the data is in the form of an array of paths
                Array aFiledrop = (Array)o.GetData(DataFormats.FileDrop);

                try
                {
                    foreach (string path in aFiledrop)
                    {
                        Copy(path, toPath);
                        if (cut) Delete(path, false);
                    }
                }
                catch (UserCancelException) { }
            }
            cut = false;
        }

        public void Delete(string path, bool confirm)
        {
            try
            {
                PushCurrentDirectory();

                bool isDirectory = Directory.Exists(path);

                string name = Path.GetFileName(path);
                string caption = " " + TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
                string message = TextHelper.GetString("Info.WillMoveToRecycleBin");

                if (isDirectory)
                {
                    string msg = TextHelper.GetString("Info.AndAllItsContents");
                    message = string.Format("\"{0}\" " + msg + " {1}", name, message);
                }
                else message = string.Format("\"{0}\" {1}", name, message);

                DialogResult result = DialogResult.OK;

                if (confirm)
                    result = MessageBox.Show(mainForm, message, caption,
                    MessageBoxButtons.OKCancel,
                    MessageBoxIcon.Warning);

                if (result == DialogResult.OK)
                {
                    if (!FileHelper.Recycle(path))
                    {
                        String error = TextHelper.GetString("FlashDevelop.Info.CouldNotBeRecycled");
                        throw new Exception(error + " " + path);
                    }
                    OnFileDeleted(path);
                }
            }
            catch (Exception exception)
            {
                ErrorManager.ShowError(exception);
            }
            finally { PopCurrentDirectory(); }
        }

        public void Delete(string[] paths)
        {
            if (paths.Length == 1)
                Delete(paths[0], true);
            else
            {
                try
                {
                    PushCurrentDirectory();

                    string caption = " " + TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
                    string message = TextHelper.GetString("Info.ItemsWillBeMovedToRecycleBin");

                    DialogResult result = MessageBox.Show(mainForm, message, caption,
                        MessageBoxButtons.OKCancel,
                        MessageBoxIcon.Warning);

                    if (result == DialogResult.OK)
                    {
                        foreach (string path in paths)
                        {
                            if (!FileHelper.Recycle(path))
                            {
                                String error = TextHelper.GetString("FlashDevelop.Info.CouldNotBeRecycled");
                                throw new Exception(error + " " + path);
                            }
                            OnFileDeleted(path);
                        }
                    }
                }
                catch (Exception exception)
                {
                    ErrorManager.ShowError(exception);
                }
                finally { PopCurrentDirectory(); }
            }
        }

        public bool Rename(string oldPath, string newName)
        {
            try
            {
                PushCurrentDirectory();

                string oldDir = Path.GetDirectoryName(oldPath);
                string newPath = Path.Combine(oldDir, newName);

                OnFileCreated(newPath);

                if (Directory.Exists(oldPath))
                {
                    // this is required for renaming directories, don't ask me why
                    string oldPathFixed = (oldPath.EndsWith("\\")) ? oldPath : oldPath + "\\";
                    string newPathFixed = (newPath.EndsWith("\\")) ? newPath : newPath + "\\";
                    if (oldPathFixed.Equals(newPathFixed, StringComparison.OrdinalIgnoreCase))
                    {
                        // name casing changed
                        string tmpPath = newPathFixed.Substring(newPathFixed.Length - 1) + "$renaming$\\";
                        Directory.Move(oldPathFixed, tmpPath);
                        oldPathFixed = tmpPath;
                    }
                    Directory.Move(oldPathFixed, newPathFixed);
                }
                else
                {
                    string oldName = Path.GetFileName(oldPath);
                    if (oldName.Equals(newName, StringComparison.OrdinalIgnoreCase))
                    {
                        // name casing changed
                        string tmpPath = newPath + "$renaming$";
                        File.Move(oldPath, tmpPath);
                        oldPath = tmpPath;
                    }
                    File.Move(oldPath, newPath);
                }
                OnFileMoved(oldPath, newPath);
            }
            catch (Exception exception)
            {
                ErrorManager.ShowError(exception);
                return false;
            }
            finally { PopCurrentDirectory(); }
            return true;
        }

        public void Move(string fromPath, string toPath)
        {
            try
            {
                PushCurrentDirectory();

                // try to fix toPath if it's a filename
                if (File.Exists(toPath))
                    toPath = Path.GetDirectoryName(toPath);

                toPath = Path.Combine(toPath, Path.GetFileName(fromPath));

                if (!ConfirmOverwrite(toPath)) return;

                if (File.Exists(toPath))
                {
                    if (!FileHelper.Recycle(toPath))
                    {
                        String message = TextHelper.GetString("FlashDevelop.Info.CouldNotBeRecycled");
                        throw new Exception(message + " " + toPath);
                    }
                }

                OnFileCreated(toPath);

                if (Directory.Exists(fromPath)) MoveDirectory(fromPath, toPath);
                else File.Move(fromPath, toPath);

                OnFileMoved(fromPath, toPath);
            }
            catch (UserCancelException){}
            catch (Exception exception)
            {
                ErrorManager.ShowError(exception);
            }
            finally { PopCurrentDirectory(); }
        }

        private void MoveDirectory(string fromPath, string toPath)
        {
            if (Directory.GetDirectoryRoot(fromPath) == Directory.GetDirectoryRoot(toPath)
                && !Directory.Exists(toPath))
            {
                Directory.Move(fromPath, toPath);
            }
            else
            {
                try
                {
                    CopyDirectory(fromPath, toPath);
                    Directory.Delete(fromPath, true);
                }
                catch (Exception)
                {
                    throw;
                }
            }
        }

        public void Copy(string fromPath, string toPath)
        {
            try
            {
                // try to fix toPath if it's a filename
                if (File.Exists(toPath))
                    toPath = Path.GetDirectoryName(toPath);

                // avoid recursive copy
                if (Directory.Exists(fromPath) && toPath.StartsWith(fromPath, StringComparison.OrdinalIgnoreCase))
                    throw new IOException(TextHelper.GetString("Info.RecursiveCopyDetected"));

                toPath = Path.Combine(toPath, Path.GetFileName(fromPath));

                // create copies of a file
                if (toPath == fromPath)
                {
                    string copyPath = Path.Combine(
                        Path.GetDirectoryName(toPath),
                        String.Format(TextHelper.GetString("Label.CopyOf"), Path.GetFileNameWithoutExtension(fromPath))
                        ) + Path.GetExtension(fromPath);

                    int copies = 1;
                    while (File.Exists(copyPath))
                    {
                        copies++;
                        copyPath = Path.Combine(
                            Path.GetDirectoryName(toPath),
                            String.Format(TextHelper.GetString("Label.CopyOf") + " ({1})", Path.GetFileNameWithoutExtension(fromPath), copies)
                            ) + Path.GetExtension(fromPath);
                    }

                    // offer to choose the new name
                    string label = TextHelper.GetString("Info.NewDuplicateName");
                    string title = String.Format(TextHelper.GetString("Info.DuplicatingFile"), Path.GetFileName(toPath));
                    string suggestion = Path.GetFileNameWithoutExtension(copyPath);
                    LineEntryDialog askName = new LineEntryDialog(title, label, suggestion);
                    DialogResult choice = askName.ShowDialog();
                    if (choice == DialogResult.OK && askName.Line.Trim().Length > 0)
                    {
                        copyPath = Path.Combine(Path.GetDirectoryName(toPath), askName.Line.Trim()) + Path.GetExtension(toPath);
                    }
                    else throw new UserCancelException();
                    toPath = copyPath;
                }

                if (!ConfirmOverwrite(toPath)) return;

                OnFileCreated(toPath);

                if (Directory.Exists(fromPath)) CopyDirectory(fromPath, toPath);
                else File.Copy(fromPath, toPath, true);

                OnFilePasted(fromPath, toPath);
            }
            catch (UserCancelException uex)
            {
                throw uex;
            }
            catch (Exception exception)
            {
                ErrorManager.ShowError(exception);
            }
        }

        private bool ConfirmOverwrite(string path)
        {
            string name = Path.GetFileName(path);

            if (Directory.Exists(path))
            {
                string title = " " + TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
                string message = TextHelper.GetString("Info.FolderAlreadyContainsFolder");

                DialogResult result = MessageBox.Show(mainForm, string.Format(message, name, "\n"),
                    title, MessageBoxButtons.YesNoCancel, MessageBoxIcon.Warning);

                if (result == DialogResult.Cancel) throw new UserCancelException();
                return result == DialogResult.Yes;
            }
            else if (File.Exists(path))
            {
                string title = " " + TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
                string message = TextHelper.GetString("Info.FolderAlreadyContainsFile");

                DialogResult result = MessageBox.Show(mainForm, string.Format(message, name, "\n"),
                    title, MessageBoxButtons.YesNoCancel, MessageBoxIcon.Warning);

                if (result == DialogResult.Cancel) throw new UserCancelException();
                return result == DialogResult.Yes;
            }
            else return true;
        }

        private void CopyDirectory(string fromPath, string toPath)
        {
            if (!Directory.Exists(toPath))
                Directory.CreateDirectory(toPath);

            foreach (string file in Directory.GetFiles(fromPath))
            {
                string name = Path.GetFileName(file);
                string destFile = Path.Combine(toPath, name);
                File.Copy(file, destFile, true);
            }

            foreach (string subdir in Directory.GetDirectories(fromPath))
            {
                string name = Path.GetFileName(subdir);
                string destDir = Path.Combine(toPath, name);
                CopyDirectory(subdir, destDir);
            }
        }

        private string CopyFile(string file, string toDirectory)
        {
            string fileName = Path.GetFileName(file);
            string filePath = Path.Combine(toDirectory, fileName);

            if (File.Exists(filePath))
            {
                string caption = " " + TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
                string message = TextHelper.GetString("Info.FileAlreadyExistsInProject");

                DialogResult result = MessageBox.Show(mainForm, string.Format(message, filePath), 
                   caption, MessageBoxButtons.OKCancel, MessageBoxIcon.Warning);

                if (result == DialogResult.Cancel) return null;
            }
            File.Copy(file, filePath, true);
            return filePath;
        }

        #endregion

        #region Event Helpers

        private void OnFileCreated(string path)
        {
            if (FileCreated != null)
                FileCreated(path);
        }

        private void OnFileMoved(string fromPath, string toPath)
        {
            if (FileMoved != null)
                FileMoved(fromPath, toPath);
        }

        private void OnFilePasted(string fromPath, string toPath)
        {
            if (FileCopied != null)
                FileCopied(fromPath, toPath);
        }

        private void OnFileDeleted(string path)
        {
            if (FileDeleted != null)
                FileDeleted(path);
        }

        private void OnProjectModified(string[] paths)
        {
            if (ProjectModified != null)
                ProjectModified(paths);
        }

        private void OnOpenFile(string path)
        {
            if (OpenFile != null)
                OpenFile(path);
        }

        #endregion

        /// <summary>
        /// Thrown when user cancel a file operation
        /// </summary>
        class UserCancelException : Exception
        {
        }
    }
}
