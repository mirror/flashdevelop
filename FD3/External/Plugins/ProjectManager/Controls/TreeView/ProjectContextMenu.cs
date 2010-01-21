using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;
using ProjectManager.Projects;
using ProjectManager.Projects.AS2;
using PluginCore.Localization;
using PluginCore.Helpers;

namespace ProjectManager.Controls.TreeView
{
    public delegate void FileAddHandler(string templatePath);

    /// <summary>
    /// Provides a smart context menu for a ProjectTreeView.
    /// </summary>
    public class ProjectContextMenu : ContextMenuStrip
    {
        Project project;
        ProjectTreeView projectTree;
        static Image newFolderImg = Icons.Overlay(Icons.Folder.Img, Icons.BulletAdd.Img, 5, -3);
        public ToolStripMenuItem AddMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Add"));
        public ToolStripMenuItem AddNewFolder = new ToolStripMenuItem(TextHelper.GetString("Label.NewFolder"), newFolderImg);
        public ToolStripMenuItem AddLibraryAsset = new ToolStripMenuItem(TextHelper.GetString("Label.LibraryAsset"), Icons.ImageResource.Img);
        public ToolStripMenuItem AddExistingFile = new ToolStripMenuItem(TextHelper.GetString("Label.ExistingFile"), Icons.SilkPage.Img);
        public ToolStripMenuItem Open = new ToolStripMenuItem(TextHelper.GetString("Label.Open"), Icons.OpenFile.Img);
        public ToolStripMenuItem Execute = new ToolStripMenuItem(TextHelper.GetString("Label.Execute"));
        public ToolStripMenuItem Browse = new ToolStripMenuItem(TextHelper.GetString("Label.BrowseDirectory"));
        public ToolStripMenuItem Insert = new ToolStripMenuItem(TextHelper.GetString("Label.InsertIntoDocument"), Icons.EditFile.Img);
        public ToolStripMenuItem Cut = new ToolStripMenuItem(TextHelper.GetString("Label.Cut"), Icons.Cut.Img);
        public ToolStripMenuItem Copy = new ToolStripMenuItem(TextHelper.GetString("Label.Copy"));
        public ToolStripMenuItem Paste = new ToolStripMenuItem(TextHelper.GetString("Label.Paste"), Icons.Paste.Img);
        public ToolStripMenuItem Delete = new ToolStripMenuItem(TextHelper.GetString("Label.Delete"), Icons.Delete.Img);
        public ToolStripMenuItem Rename = new ToolStripMenuItem(TextHelper.GetString("Label.Rename"));
        public ToolStripMenuItem LibraryOptions = new ToolStripMenuItem(TextHelper.GetString("Label.Options"), Icons.Options.Img);
        public ToolStripMenuItem NothingToDo = new ToolStripMenuItem(TextHelper.GetString("Label.NotValidGroup"));
        public ToolStripMenuItem NoProjectOutput = new ToolStripMenuItem(TextHelper.GetString("Label.NoProjectOutput"));
        public ToolStripMenuItem HideItem = new ToolStripMenuItem(TextHelper.GetString("Label.HideFile"));
        public ToolStripMenuItem ShowHidden = new ToolStripMenuItem(TextHelper.GetString("Label.ShowHiddenItems"), Icons.HiddenItems.Img);
        public ToolStripMenuItem AlwaysCompile = new ToolStripMenuItem(TextHelper.GetString("Label.AlwaysCompile"));
        public ToolStripMenuItem AddLibrary = new ToolStripMenuItem(TextHelper.GetString("Label.AddToLibrary"));
        public ToolStripMenuItem TestMovie = new ToolStripMenuItem(TextHelper.GetString("Label.TestMovie"), Icons.GreenCheck.Img);
        public ToolStripMenuItem BuildProject = new ToolStripMenuItem(TextHelper.GetString("Label.BuildProject"), Icons.Gear.Img);
        public ToolStripMenuItem CloseProject = new ToolStripMenuItem(TextHelper.GetString("Label.CloseProject"));
        public ToolStripMenuItem Properties = new ToolStripMenuItem(TextHelper.GetString("Label.Properties"), Icons.Options.Img);
        public ToolStripMenuItem ShellMenu = new ToolStripMenuItem(TextHelper.GetString("Label.ShellMenu"));
        public ToolStripMenuItem BuildProjectFile = new ToolStripMenuItem(TextHelper.GetString("Label.BuildProjectFile"));
        public ToolStripMenuItem BuildProjectFiles = new ToolStripMenuItem(TextHelper.GetString("Label.BuildProjectFiles"));
        public ToolStripMenuItem FindInFiles = new ToolStripMenuItem(TextHelper.GetString("Label.FindHere"));
        public event FileAddHandler AddFileFromTemplate;

        public ProjectContextMenu()
        {
            this.Font = PluginCore.PluginBase.Settings.DefaultFont;
            NothingToDo.Enabled = false;
            NoProjectOutput.Enabled = false;
        }

        public Project Project
        {
            get { return project; }
            set { project = value; }
        }

        public ProjectTreeView ProjectTree
        {
            get { return projectTree; }
            set { projectTree = value; }
        }

        public Boolean Contains(string menuName)
        {
            ToolStripItem item = this.GetType().GetField(menuName).GetValue(this) as ToolStripItem;
            return item != null && Items.Contains(item) && item.Enabled;
        }

        #region File Templates

        private ToolStripItem[] GetAddFileTemplates()
        {
            List<ToolStripItem> items = new List<ToolStripItem>();
            // the custom project file templates are in a subdirectory named after the project class name
            string customDir = Path.Combine(ProjectPaths.FileTemplatesDirectory, project.GetType().Name);
            if (Directory.Exists(customDir))
            {
                foreach (string file in Directory.GetFiles(customDir, "*.fdt"))
                {
                    items.Add(GetCustomAddFile(file));
                }
                List<string> excludedDirs = new List<string>(PluginMain.Settings.ExcludedDirectories);
                foreach (string dir in Directory.GetDirectories(customDir))
                {
                    // don't copy like .svn and stuff
                    if (excludedDirs.Contains(Path.GetFileName(dir).ToLower())) continue;
                    items.Add(GetCustomAddFileDirectory(dir));
                }
            }
            if (items.Count > 0) items.Add(new ToolStripSeparator());
            // get all the generic FD templates
            foreach (string file in Directory.GetFiles(PathHelper.TemplateDir, "*.fdt"))
            {
                string name = Path.GetFileNameWithoutExtension(file).ToLower();
                if (name != "as2" && name != "as3") items.Add(GetGenericAddFile(file));
            }
            return items.ToArray();
        }

        private ToolStripMenuItem GetCustomAddFileDirectory(string customDir)
        {
            List<ToolStripItem> items = new List<ToolStripItem>();
            List<string> excludedDirs = new List<string>(PluginMain.Settings.ExcludedDirectories);
            foreach (string dir in Directory.GetDirectories(customDir))
            {
                string dirName = Path.GetFileName(dir);
                // don't copy like .svn and stuff
                if (excludedDirs.Contains(dirName.ToLower())) continue;
                items.Add(GetCustomAddFileDirectory(dir));
            }
            foreach (string file in Directory.GetFiles(customDir,"*.fdt"))
            {
                items.Add(GetCustomAddFile(file));
            }
            string[] dirNames = customDir.Split('\\');
            return new ToolStripMenuItem((string)dirNames.GetValue(dirNames.Length - 1), null, items.ToArray());
        }

        private ToolStripMenuItem GetCustomAddFile(string file)
        {
            string actualFile = Path.GetFileNameWithoutExtension(file); // strip .fdt
            string actualName = Path.GetFileNameWithoutExtension(actualFile); // strip ext
            Image image = Icons.GetImageForFile(actualFile).Img;
            image = Icons.Overlay(image, Icons.BulletAdd.Img, 5, 4);
            String label = TextHelper.GetString("Label.New");
            ToolStripMenuItem item = new ToolStripMenuItem("New " + actualName + "...", image);
            item.Click += delegate
            {
                if (AddFileFromTemplate != null)
                    AddFileFromTemplate(file);
            };
            return item;
        }

        private ToolStripMenuItem GetGenericAddFile(string file)
        {
            string ext = "." + Path.GetFileNameWithoutExtension(file);
            Image image = Icons.GetImageForFile(ext).Img;
            image = Icons.Overlay(image, Icons.BulletAdd.Img, 5, 4);
            String nlabel = TextHelper.GetString("Label.New");
            String flabel = TextHelper.GetString("Label.File");
            ToolStripMenuItem item = new ToolStripMenuItem(nlabel + " " + Path.GetFileNameWithoutExtension(file) + " " + flabel + "...", image);
            item.Click += delegate
            {
                if (AddFileFromTemplate != null) AddFileFromTemplate(file);
            };
            return item;
        }

        #endregion

        #region Configure

        /// <summary>
        /// Configure ourself to be a menu relevant to the given Project with the
        /// given selected treeview nodes.
        /// </summary>
        public void Configure(ArrayList nodes)
        {
            base.Items.Clear();
            MergableMenu menu = new MergableMenu();
            foreach (GenericNode node in nodes)
            {
                MergableMenu newMenu = new MergableMenu();
                AddItems(newMenu, node);
                menu = (menu.Count > 0) ? menu.Combine(newMenu) : newMenu;
            }
            menu.Apply(this.Items);

            // deal with special menu items that can't be applied to multiple paths
            bool singleFile = (nodes.Count == 1);
            AddMenu.Enabled = singleFile;
            Rename.Enabled = singleFile;
            Insert.Enabled = singleFile;
            Paste.Enabled = singleFile;

            // deal with naming the "Hide" button correctly
            if (nodes.Count > 1 || nodes.Count == 0) HideItem.Text = TextHelper.GetString("Label.HideItems");
            else HideItem.Text = (nodes[0] is DirectoryNode) ? TextHelper.GetString("Label.HideFolder") : TextHelper.GetString("Label.HideFile");

            // deal with shortcuts
            AssignShortcuts();
            if (this.Items.Contains(AddMenu) && AddMenu.Enabled) BuildAddMenu();
            if (base.Items.Count == 0) base.Items.Add(NothingToDo);
        }

        protected override void OnOpening(CancelEventArgs e)
        {
            // only enable paste if there is filedrop data in the clipboard
            if (!Clipboard.GetDataObject().GetDataPresent(DataFormats.FileDrop)) Paste.Enabled = false;
            base.OnOpening(e);
        }

        public void AssignShortcuts()
        {
            Rename.ShortcutKeys = (Rename.Enabled) ? Keys.F2 : Keys.None;
        }

        #endregion

        #region Add Menu Items

        private void BuildAddMenu()
        {
            AddMenu.DropDownItems.Clear();
            AddMenu.DropDownItems.AddRange(GetAddFileTemplates());
            AddMenu.DropDownItems.Add(new ToolStripSeparator());
            AddMenu.DropDownItems.Add(AddNewFolder);
            AddMenu.DropDownItems.Add(new ToolStripSeparator());
            AddMenu.DropDownItems.Add(AddLibraryAsset);
            AddMenu.DropDownItems.Add(AddExistingFile);
        }

        private void AddItems(MergableMenu menu, GenericNode node)
        {
            if (node.IsInvalid) return;
            string path = node.BackingPath;
            if (node is ProjectNode) AddProjectItems(menu);
            else if (node is ClasspathNode) AddClasspathItems(menu);
            else if (node is DirectoryNode) AddFolderItems(menu, path);
            else if (node is ProjectOutputNode) AddProjectOutputItems(menu, node as ProjectOutputNode);
            else if (node is ExportNode) AddExportItems(menu, node as ExportNode);
            else if (node is FileNode)
            {
                string ext = Path.GetExtension(path).ToLower();
                if (FileInspector.IsActionScript(path, ext)) AddActionScriptItems(menu, path);
                else if (FileInspector.IsHaxeFile(path, ext)) AddHaxeFileItems(menu, path);
                else if (FileInspector.IsMxml(path, ext)) AddMxmlItems(menu, path);
                else if (FileInspector.IsCss(path, ext)) AddCssItems(menu, path);
                else if (FileInspector.IsSwf(path, ext)) AddSwfItems(menu, path);
                else if (FileInspector.IsSwc(path, ext)) AddSwcItems(menu, path);
                else if (FileInspector.IsResource(path, ext)) AddOtherResourceItems(menu, path);
                else AddGenericFileItems(menu, path);
            }
        }

        private void AddExportItems(MergableMenu menu, ExportNode node)
        {
            // it DOES make sense to allow insert of assets inside the injection target!
            if (project.UsesInjection && project.GetRelativePath(node.ContainingSwfPath) != project.InputPath) return;
            if (node is ClassExportNode) menu.Add(Open, 0);
            menu.Add(Insert, 0);
        }

        private void AddProjectItems(MergableMenu menu)
        {
            bool showHidden = project.ShowHiddenPaths;
            menu.Add(TestMovie, 0);
            menu.Add(BuildProject, 0);
            menu.Add(CloseProject, 0);
            menu.Add(AddMenu, 1);
            menu.Add(Browse, 1);
            menu.Add(FindInFiles, 1);
            menu.Add(ShellMenu, 1);
            menu.Add(Paste, 2);
            menu.Add(ShowHidden, 3, showHidden);
            menu.Add(Properties, 4);
        }

        private void AddClasspathItems(MergableMenu menu)
        {
            menu.Add(AddMenu, 0);
            menu.Add(Browse, 0);
            menu.Add(FindInFiles, 0);
            menu.Add(ShellMenu, 0);
            menu.Add(Paste, 1);
        }

        private void AddFolderItems(MergableMenu menu, string path)
        {
            bool alwaysCompile = project.IsCompileTarget(path);
            menu.Add(AddMenu, 0);
            menu.Add(Browse, 0);
            menu.Add(FindInFiles, 0);
            menu.Add(ShellMenu, 0);
            if (project.Language == "as2") menu.Add(AlwaysCompile, 2, alwaysCompile);
            AddFileItems(menu, path, true);
        }

        private void AddActionScriptItems(MergableMenu menu, string path)
        {
            bool alwaysCompile = project.IsCompileTarget(path);
            menu.Add(Open, 0);
            menu.Add(Execute, 0);
            menu.Add(ShellMenu, 0);
            menu.Add(AlwaysCompile, 2, alwaysCompile);
            AddFileItems(menu, path);
        }

        private void AddHaxeFileItems(MergableMenu menu, string path)
        {
            bool alwaysCompile = project.IsCompileTarget(path);
            menu.Add(Open, 0);
            menu.Add(Execute, 0);
            menu.Add(ShellMenu, 0);
            menu.Add(AlwaysCompile, 2, alwaysCompile);
            AddFileItems(menu, path);
        }

        private void AddMxmlItems(MergableMenu menu, string path)
        {
            bool alwaysCompile = project.IsCompileTarget(path);
            menu.Add(Open, 0);
            menu.Add(Execute, 0);
            menu.Add(ShellMenu, 0);
            menu.Add(AlwaysCompile, 2, alwaysCompile);
            AddFileItems(menu, path);
        }

        private void AddCssItems(MergableMenu menu, string path)
        {
            if (project.Language != "as3")
            {
                AddGenericFileItems(menu, path);
                return;
            }
            bool alwaysCompile = project.IsCompileTarget(path);
            menu.Add(Open, 0);
            menu.Add(Execute, 0);
            menu.Add(ShellMenu, 0);
            menu.Add(AlwaysCompile, 2, alwaysCompile);
            AddFileItems(menu, path);
        }

        private void AddOtherResourceItems(MergableMenu menu, string path)
        {
            bool addLibrary = project.HasLibraries && project.IsLibraryAsset(path);
            menu.Add(Open, 0);
            menu.Add(Execute, 0);
            menu.Add(ShellMenu, 0);
            menu.Add(Insert, 0);
            if (project.HasLibraries) menu.Add(AddLibrary, 2, addLibrary);
            if (addLibrary) menu.Add(LibraryOptions, 2);
            AddFileItems(menu, path);
        }

        private void AddSwfItems(MergableMenu menu, string path)
        {
            bool addLibrary = project.HasLibraries && project.IsLibraryAsset(path);
            menu.Add(Open, 0);
            menu.Add(Execute, 0);
            menu.Add(ShellMenu, 0);
            menu.Add(Insert, 0);
            if (addLibrary)
            {
                LibraryAsset asset = project.GetAsset(path);
                if (asset.SwfMode == SwfAssetMode.Library) menu.Add(Insert, 0);
            }
            if (project.HasLibraries) menu.Add(AddLibrary, 2, addLibrary);
            if (addLibrary) menu.Add(LibraryOptions, 2);
            AddFileItems(menu, path);
        }

        private void AddSwcItems(MergableMenu menu, string path)
        {
            bool addLibrary = project.IsLibraryAsset(path);
            menu.Add(Execute, 0);
            menu.Add(ShellMenu, 0);
            menu.Add(AddLibrary, 2, addLibrary);
            if (addLibrary) menu.Add(LibraryOptions, 2);
            if (!this.IsExternalSwc(path)) AddFileItems(menu, path);
            else
            {
                menu.Add(Copy, 1);
                menu.Add(Delete, 1);
            }
        }

        private void AddProjectOutputItems(MergableMenu menu, ProjectOutputNode node)
        {
            if (node.FileExists)
            {
                menu.Add(Open, 0);
                menu.Add(Execute, 0);
                menu.Add(ShellMenu, 0);
                AddFileItems(menu, node.BackingPath);
            }
            else menu.Add(NoProjectOutput, 0);
        }

        private void AddFileItems(MergableMenu menu, string path, bool addPaste)
        {
            bool hidden = project.IsPathHidden(path);
            bool showHidden = project.ShowHiddenPaths;
            menu.Add(Cut, 1);
            menu.Add(Copy, 1);
            if (addPaste) menu.Add(Paste, 1);
            menu.Add(Delete, 1);
            menu.Add(Rename, 1);
            menu.Add(ShowHidden, 3, showHidden);
            menu.Add(HideItem, 3, hidden);
        }

        private void AddFileItems(MergableMenu menu, string path)
        {
            AddFileItems(menu, path, true);
        }

        private void AddGenericFileItems(MergableMenu menu, string path)
        {
            menu.Add(Open, 0);
            menu.Add(Execute, 0);
            menu.Add(ShellMenu, 0);
            menu.Add(Insert, 0);
            if (IsBuildable(path) && projectTree.SelectedPaths.Length == 1) menu.Add(BuildProjectFile, 0);
            if (IsBuildable(path) && projectTree.SelectedPaths.Length > 1) menu.Add(BuildProjectFiles, 0);
            AddFileItems(menu, path);
        }

        private bool IsBuildable(String path)
        {
            String ext = Path.GetExtension(path).ToLower();
            if (FileInspector.IsAS2Project(path, ext)) return true;
            else if (FileInspector.IsAS3Project(path, ext)) return true;
            else if (FileInspector.IsHaxeProject(path, ext)) return true;
            else return false;
        }

        private bool IsExternalSwc(string file)
        {
            if (!Path.IsPathRooted(file))
            {
                file = project.GetAbsolutePath(file);
            }
            if (file.StartsWith(project.Directory)) return false;
            foreach (string path in project.AbsoluteClasspaths)
            {
                if (file.StartsWith(path)) return false;
            }
            foreach (string path in PluginMain.Settings.GlobalClasspaths)
            {
                if (file.StartsWith(path)) return false;
            }
            return true;
        }

        #endregion

    }

}
