using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;
using PluginCore;
using ProjectExplorer.Controls;
using ProjectExplorer.Helpers;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.Actions
{
	public delegate void ProjectModifiedHandler(string[] paths);

	/// <summary>
	/// Provides high-level actions for working with Project files.
	/// </summary>
	public class ProjectActions
	{
		IWin32Window owner; // for dialogs

		//string COMMAND_CLEARCLASSCACHE = "ASCompletion;ClearClassCache";

		public event ProjectModifiedHandler ProjectModified;

		public ProjectActions(IWin32Window owner)
		{
			this.owner = owner;
		}

		#region New/Open Project

		public Project NewProject()
		{
			NewProjectDialog dialog = new NewProjectDialog();
			
			if (dialog.ShowDialog(owner) == DialogResult.OK)
			{
				try
				{
					ProjectCreator creator = new ProjectCreator();
					return creator.CreateProject(dialog.TemplateDirectory,
						dialog.ProjectLocation,dialog.ProjectName);
				}
				catch (Exception exception)
				{
					ErrorHandler.ShowInfo("Could not create the requested project: " + exception.Message);
				}
			}

			return null;
		}

		public Project OpenProject()
		{
			OpenFileDialog dialog = new OpenFileDialog();
			dialog.Filter = "FlashDevelop Projects (*.fdp)|*.fdp";

			if (dialog.ShowDialog(owner) == DialogResult.OK)
				return OpenProjectSilent(dialog.FileName);
			else
				return null;
		}

		public Project OpenProjectSilent(string path)
		{
			try { return Project.Load(path); }
			catch (Exception exception) 
			{
				ErrorHandler.ShowInfo("Could not open the requested project: " + exception.Message);
				return null;
			}
		}

		#endregion

		#region Update ASCompletion

		public void UpdateASCompletion(IMainForm mainForm, Project project)
		{
			if (project == null) return; // nothing to do

			ArrayList classPaths = new ArrayList();

			// add player version
			classPaths.Add(project.MovieOptions.Version.ToString());

			// add project classpaths
			foreach (string cp in project.AbsoluteClasspaths)
				if (Directory.Exists(cp)) classPaths.Add(cp);

			string[] cpArray = classPaths.ToArray(typeof(string)) as string[];
			string cps = string.Join(";", cpArray);

			mainForm.CallCommand("PluginCommand", "ASCompletion;ClassPath;" + cps);
		}

		/*public void ClearASCompletion(IMainForm mainForm)
		{
			mainForm.CallCommand("PluginCommand",COMMAND_CLEARCLASSCACHE);
		}*/

		#endregion

		#region Project File Reference Updating

		public void RemoveAllReferences(Project project, string path)
		{
			if (project.IsLibraryAsset(path))
				project.SetLibraryAsset(path,false);

			if (project.IsCompileTarget(path))
				project.SetCompileTarget(path,false);
		}

		public void MoveReferences(Project project, string fromPath, string toPath)
		{
			if (project.IsCompileTarget(fromPath))
			{
				project.SetCompileTarget(fromPath,false);
				project.SetCompileTarget(toPath,true);
			}
			
			if (project.IsLibraryAsset(fromPath))
			{
				project.ChangeAssetPath(fromPath,toPath);
			}
		}

		#endregion

		#region Working with Project Files

		public void InsertFile(IMainForm mainForm, Project project, string path, 
			string textToInsert)
		{
			bool isInjectionTarget = (project.UsesInjection && 
				path == project.GetAbsolutePath(project.InputPath));

			if (!project.IsLibraryAsset(path) && !isInjectionTarget)
			{
				string caption = "Insert Resource";
				string message = "In order to use this file in your project, "
					+ "you must first embed it as a resource.  "
					+ "Would you like to do this now?";

				DialogResult result = MessageBox.Show(owner, message, caption,
					MessageBoxButtons.OKCancel, MessageBoxIcon.Information);

				if (result == DialogResult.OK)
					ToggleLibraryAsset(project,new string[]{path});
				else
					return; // cancel
			}

			if (textToInsert == null)
				textToInsert = project.GetAsset(path).ID;

			if (mainForm.CurSciControl != null)
			{
				mainForm.CurSciControl.AddText(textToInsert.Length, textToInsert);
				mainForm.CurSciControl.Focus();
			}
			else ErrorHandler.ShowInfo("You must have a document open to insert a resource string.");
		}

		public void ToggleLibraryAsset(Project project, string[] paths)
		{
			foreach (string path in paths)
			{
				bool isResource = project.IsLibraryAsset(path);
				project.SetLibraryAsset(path, !isResource);
			}
			project.Save();
			OnProjectModified(paths);
		}

		public void ToggleShowHidden(Project project)
		{
			project.ShowHiddenPaths = !project.ShowHiddenPaths;
			project.Save();
			OnProjectModified(null);
		}

		public void ToggleAlwaysCompile(Project project, string[] paths)
		{
			foreach (string path in paths)
			{
				bool isTarget = project.IsCompileTarget(path);
				project.SetCompileTarget(path, !isTarget);
			}
			project.Save();
			OnProjectModified(paths);
		}

		public void ToggleHidden(Project project, string[] paths)
		{
			foreach (string path in paths)
			{
				bool isHidden = project.IsPathHidden(path);
				project.SetPathHidden(path, !isHidden);
			}
			project.Save();

			OnProjectModified(null);
		}

		#endregion

		private void OnProjectModified(string[] paths)
		{
			if (ProjectModified != null)
				ProjectModified(paths);
		}
	}
}
