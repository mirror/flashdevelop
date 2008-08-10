using System;
using System.Collections;
using System.IO;
using System.Text;
using System.Diagnostics;
using System.Windows.Forms;
using ProjectExplorer.Helpers;
using ProjectExplorer.ProjectFormat;
using PluginCore;
using WeifenLuo.WinFormsUI;

namespace ProjectExplorer.Actions
{
	public delegate void FileNameHandler(string path);
	public delegate void FileMovedHandler(string fromPath, string toPath);

	/// <summary>
	/// Provides methods for creating new files and working with existing files in projects.
	/// </summary>
	public class FileActions
	{
		IWin32Window owner;
		string storedDirectory;
		FlashDevelopActions fdActions;

		public event FileNameHandler FileCreated;
		public event ProjectModifiedHandler ProjectModified;
		public event FileNameHandler OpenFile;
		public event FileNameHandler FileDeleted;
		public event FileMovedHandler FileMoved;

		public int DocumentSeekRequest;

		public FileActions(IWin32Window owner)
		{
			this.fdActions = new FlashDevelopActions(PluginMain.MainFormRef);
			this.DocumentSeekRequest = 0;
			this.owner = owner;
		}

		private void PushCurrentDirectory()
		{
			storedDirectory = Environment.CurrentDirectory;
			Environment.CurrentDirectory = Application.StartupPath;
		}

		private void PopCurrentDirectory()
		{
			try { Environment.CurrentDirectory = storedDirectory; }
			catch {}
		}

		#region Adding New Files

		public void AddFile(string inDirectory)
		{
			string caption = "Add New File";
			string label = "File Name:";
			string defaultLine = "New File.txt";

			LineEntryDialog dialog = new LineEntryDialog(caption, label, defaultLine);
			if (dialog.ShowDialog() == DialogResult.OK)
			{
				try
				{
					string path = Path.Combine(inDirectory, dialog.Line);

					OnFileCreated(path);
					
					// MIKA: DETECT EOL AND ENCODING
					Encoding encoding = this.fdActions.GetDefaultEncoding();
					string eolMarker = this.fdActions.GetDefaultEOLMarker();
					
					using (FileStream stream = File.Open(path,FileMode.CreateNew))
					{
						StreamWriter writer = new StreamWriter(stream, encoding);
						writer.Write(eolMarker);
						writer.Flush();
					}
					
					DocumentSeekRequest = 0;
					OnOpenFile(path);
				}
				catch (Exception exception)
				{
					ErrorHandler.ShowInfo("Could not add the file: " + exception.Message);
				}
			}
		}

		public void AddXmlFile(string inDirectory)
		{
			string caption = "Add Xml File";
			string label = "File Name:";
			string defaultLine = "New File.xml";

			LineEntryDialog dialog = new LineEntryDialog(caption, label, defaultLine);
			if (dialog.ShowDialog() == DialogResult.OK)
			{
				try
				{
					string xmlDeclaration = "<?xml version=\"1.0\" ?>";
					string path = Path.Combine(inDirectory, dialog.Line);

					OnFileCreated(path);
					
					// MIKA: DETECT EOL AND ENCODING
					Encoding encoding = this.fdActions.GetDefaultEncoding();
					string eolMarker = this.fdActions.GetDefaultEOLMarker();
					
					using (FileStream stream = File.Open(path, FileMode.CreateNew))
					{
						StreamWriter writer = new StreamWriter(stream, encoding);
						writer.Write(xmlDeclaration + eolMarker);
						writer.Flush();
					}

					DocumentSeekRequest = xmlDeclaration.Length + eolMarker.Length;
					OpenFile(path);
				}
				catch (Exception exception)
				{
					ErrorHandler.ShowInfo("Could not add the file: " + exception.Message);
				}
			}
		}

		public void AddLibraryAsset(Project project, string inDirectory)
		{
			OpenFileDialog dialog = new OpenFileDialog();
			dialog.Title = "Add Library Asset";
			dialog.Filter = "All files (*.*)|*.*";
			dialog.Multiselect = false;
			
			if (dialog.ShowDialog() == DialogResult.OK)
			{
				string filePath = CopyFile(dialog.FileName,inDirectory);

				// null means the user cancelled
				if (filePath == null) return;

				// add as an asset
				project.SetLibraryAsset(filePath,true);

				// ask if you want to keep this file updated
				string caption = "FlashDevelop";
				string message = "Would you like to keep this file updated from the source "
					+ "location?  (You can always change this in the 'Options' context menu)";

				DialogResult result = MessageBox.Show(owner,message,caption,
					MessageBoxButtons.YesNo,MessageBoxIcon.Question);

				if (result == DialogResult.Yes)
				{
					LibraryAsset asset = project.GetAsset(filePath);
					asset.UpdatePath = project.GetRelativePath(dialog.FileName);
				}

				project.Save();
				OnProjectModified(new string[]{filePath});
			}
		}

		public void AddExistingFile(string inDirectory)
		{
			OpenFileDialog dialog = new OpenFileDialog();
			dialog.Title = "Add Existing File";
			dialog.Filter = "All files (*.*)|*.*";
			dialog.Multiselect = false;
			
			if (dialog.ShowDialog() == DialogResult.OK)
				CopyFile(dialog.FileName,inDirectory);
		}

		public void AddClass(Project project, string inDirectory)
		{
			string caption = "Add New Class";
			string label = "Class Name:";
			string defaultLine = "NewClass";

			LineEntryDialog dialog = new LineEntryDialog(caption, label, defaultLine);
			if (dialog.ShowDialog() == DialogResult.OK)
			{
				try
				{
					string name = Path.GetFileNameWithoutExtension(dialog.Line);
					string path = Path.Combine(inDirectory, name + ".as");
					OnFileCreated(path);

					// figure out the best classpath to build from
					string classpath = project.AbsoluteClasspaths.GetClosestParent(path);

					// no luck?  try the global classpaths!
					if (classpath == null)
					{
						PathCollection globalPaths = new PathCollection();
						foreach (string cp in Settings.GlobalClasspaths.Split(';'))
							globalPaths.Add(cp);
						classpath = globalPaths.GetClosestParent(path);
					}

					// still no luck?  nothing else we can do
					if (classpath == null)
						throw new Exception("An appropriate project classpath could not be located to create the class from.");

					// figure out the full class name cleverly
					string className = PathHelper.GetRelativePath(classpath,path);
					className = className.Replace(".as", "");
					className = className.Replace(Path.DirectorySeparatorChar, '.');
					
					string constructor = className;
					int p = className.LastIndexOf('.');
					if (p >= 0) constructor = className.Substring(p+1);
					
					// MIKA: DETECT EOL AND ENCODING
					Encoding encoding = this.fdActions.GetDefaultEncoding();
					string eolMarker = this.fdActions.GetDefaultEOLMarker();
					
					using (FileStream stream = File.Open(path,FileMode.CreateNew))
					{
						StreamWriter writer = new StreamWriter(stream, encoding);
						string code = eolMarker;
						code += "class " + className + eolMarker;
						code += "{" + eolMarker;
						code += "\tfunction " + constructor + "()" + eolMarker;
						code += "\t{" + eolMarker;
						code += "\t\t";
						DocumentSeekRequest = code.Length;
						code += eolMarker;
						code += "\t}" + eolMarker;
						code += "}" + eolMarker;
						writer.Write(code);
						writer.Flush();
					}
					OpenFile(path);
				}
				catch (Exception exception)
				{
					ErrorHandler.ShowInfo("Could not add the class: " + exception.Message);
				}
			}
		}

		public void AddFolder(string inDirectory)
		{
			try
			{
				string path = Path.Combine(inDirectory, "New Folder");

				int i = 2;
				while (Directory.Exists(path))
					path = Path.Combine(inDirectory, "New Folder (" + (i++) + ")");

				// this will set off a interesting chain of events that will cause
				// the newly created "New Folder" node to begin label editing.
				OnFileCreated(path);

				Directory.CreateDirectory(path);
			}
			catch (Exception exception)
			{
				ErrorHandler.ShowInfo("Could not add the folder: " + exception.Message);
			}
		}

		#endregion

		#region Existing Files

		private bool cut;

		public void CutToClipboard(string[] paths)
		{
			CopyToClipboard(paths);
			cut = true;
		}

		public void CopyToClipboard(string[] paths)
		{
			cut = false;
			DataObject o = new DataObject(DataFormats.FileDrop,paths);
			Clipboard.SetDataObject(o);
		}

		public void PasteFromClipboard(string toPath)
		{
			DataObject o = Clipboard.GetDataObject() as DataObject;
			if (o.GetDataPresent(DataFormats.FileDrop))
			{
				// the data is in the form of an array of paths
				Array aFiledrop = (Array)o.GetData(DataFormats.FileDrop);

				foreach (string path in aFiledrop)
				{
					// PHILIPPE: fix recursive copy
					if (!toPath.StartsWith(path))
					{
						Copy(path,toPath);
						if (cut)
							Delete(path,false);
					}
				}
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
				string caption = "Confirm Delete";
				string message = "will be deleted permanently.";

				if (isDirectory)
					message = string.Format("'{0}' and all its contents {1}", name, message);
				else
					message = string.Format("'{0}' {1}", name, message);

				DialogResult result = DialogResult.OK;
				
				if (confirm)
					result = MessageBox.Show(owner, message, caption,
					MessageBoxButtons.OKCancel,
					MessageBoxIcon.Warning);

				if (result == DialogResult.OK)
				{
					if (isDirectory)
						Directory.Delete(path, true);
					else
						File.Delete(path);

					OnFileDeleted(path);
				}
			}
			catch (Exception exception)
			{
				ErrorHandler.ShowInfo("Could not delete: " + exception.Message);
			}
			finally { PopCurrentDirectory(); }
		}

		public void Delete(string[] paths)
		{
			if (paths.Length == 1)
				Delete(paths[0],true);
			else
			{
				try
				{
					PushCurrentDirectory();

					string caption = "Confirm Delete";
					string message = "The selected items will be deleted permanently.";

					DialogResult result = MessageBox.Show(owner, message, caption,
						MessageBoxButtons.OKCancel,
						MessageBoxIcon.Warning);

					if (result == DialogResult.OK)
					{
						foreach (string path in paths)
						{
							if (Directory.Exists(path))
								Directory.Delete(path, true);
							else
								File.Delete(path);

							OnFileDeleted(path);
						}
					}
				}
				catch (Exception exception)
				{
					ErrorHandler.ShowInfo("Could not delete: " + exception.Message);
				}
				finally { PopCurrentDirectory(); }
			}
		}

		public void Rename(string oldPath, string newName)
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
					Directory.Move(oldPathFixed, newPathFixed);
				}
				else
					File.Move(oldPath, newPath);

				OnFileMoved(oldPath,newPath);
			}
			catch (Exception exception)
			{
				ErrorHandler.ShowInfo("Could not rename: " + exception.Message);
			}
			finally { PopCurrentDirectory(); }
		}

		public void Move(string fromPath, string toPath)
		{
			try
			{
				PushCurrentDirectory();

				// try to fix toPath if it's a filename
				if (File.Exists(toPath))
					toPath = Path.GetDirectoryName(toPath);

				toPath = Path.Combine(toPath,Path.GetFileName(fromPath));

				OnFileCreated(toPath);

				if (Directory.Exists(fromPath))
					Directory.Move(fromPath, toPath);
				else
					File.Move(fromPath, toPath);

				OnFileMoved(fromPath,toPath);				
			}
			catch (Exception exception)
			{
				ErrorHandler.ShowInfo("Could not move one of the items: " + exception.Message);
			}
			finally { PopCurrentDirectory(); }
		}

		public void Copy(string fromPath, string toPath)
		{
			try
			{
				// try to fix toPath if it's a filename
				if (File.Exists(toPath))
					toPath = Path.GetDirectoryName(toPath);

				toPath = Path.Combine(toPath,Path.GetFileName(fromPath));

				if (!ConfirmOverwrite(toPath))
					return;

				OnFileCreated(toPath);

				if (Directory.Exists(fromPath))
					CopyDirectory(fromPath, toPath);
				else
					File.Copy(fromPath, toPath, true);
			}
			catch (Exception exception)
			{
				ErrorHandler.ShowInfo("Could not copy one of the items: " + exception.Message);
			}
		}

		private bool ConfirmOverwrite(string path)
		{
			string name = Path.GetFileName(path);

			if (Directory.Exists(path))
			{
				string title = "Confirm Folder Replace";
				string message = "This folder already contains a folder named '{0}'.\n\n"
					+ "If the files in the existing folder have the same name as files in the\n"
					+ "folder you are moving or copying, they will be replaced.  Do you still\n"
					+ "want to move or copy the folder?";

				DialogResult result = MessageBox.Show(owner,string.Format(message,name),
					title,MessageBoxButtons.OKCancel,MessageBoxIcon.Warning);

				return result == DialogResult.OK;
			}
			else if (File.Exists(path))
			{
				string title = "Confirm File Replace";
				string message = "This folder already contains a file named '{0}'.\n"
					+ "Would you like to replace the existing file?";

				DialogResult result = MessageBox.Show(owner,string.Format(message,name),
					title,MessageBoxButtons.OKCancel,MessageBoxIcon.Warning);

				return result == DialogResult.OK;
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
				string destFile = Path.Combine(toPath,name);
				File.Copy(file,destFile,true);
			}

			foreach (string subdir in Directory.GetDirectories(fromPath))
			{
				string name = Path.GetFileName(subdir);
				string destDir = Path.Combine(toPath,name);
				CopyDirectory(subdir,destDir);
			}
		}

		private string CopyFile(string file, string toDirectory)
		{
			string fileName = Path.GetFileName(file);
			string filePath = Path.Combine(toDirectory,fileName);

			if (File.Exists(filePath))
			{
				string caption = "FlashDevelop";
				string message = "The file '"+fileName+"' already exists in the project "
					+ "folder.  Would you like to overwrite it?";
				DialogResult result = MessageBox.Show(owner,message,caption,
					MessageBoxButtons.OKCancel,MessageBoxIcon.Warning);
				if (result == DialogResult.Cancel)
					return null;
			}
			File.Copy(file,filePath,true);
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
				FileMoved(fromPath,toPath);
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
	}
}
