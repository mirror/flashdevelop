using System;
using System.Collections;
using System.Diagnostics;
using System.Collections.Generic;
using System.IO;
using System.Windows.Forms;
using PluginCore;
using PluginCore.Managers;
using PluginCore.Localization;
using ProjectManager.Controls;
using ProjectManager.Helpers;
using ProjectManager.Projects;
using ProjectManager.Projects.AS2;
using ProjectManager.Projects.AS3;
using PluginCore.Helpers;
using ProjectManager.Controls.TreeView;

namespace ProjectManager.Actions
{
	public delegate void ProjectModifiedHandler(string[] paths);

	/// <summary>
	/// Provides high-level actions for working with Project files.
	/// </summary>
	public class ProjectActions
	{
        IWin32Window owner; // for dialogs
        string currentLang;

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
                    FlashDevelopActions.CheckAuthorName();
                    ProjectCreator creator = new ProjectCreator();
                    return creator.CreateProject(dialog.TemplateDirectory, dialog.ProjectLocation, dialog.ProjectName, dialog.PackageName);
                }
                catch (Exception exception)
                {
                    string msg = TextHelper.GetString("Info.CouldNotCreateProject");
                    ErrorManager.ShowInfo(msg + " " + exception.Message);
                }
            }

            return null;
        }

        public Project OpenProject()
        {
            OpenFileDialog dialog = new OpenFileDialog();
            dialog.Title = " " + TextHelper.GetString("Title.OpenProjectDialog");
            dialog.Filter = ProjectCreator.GetProjectFilters();

            if (dialog.ShowDialog(owner) == DialogResult.OK)
                return OpenProjectSilent(dialog.FileName);
            else
                return null;
        }

        public Project OpenProjectSilent(string path)
        {
            try 
            {
                String physical = PathHelper.GetPhysicalPathName(path);
                return ProjectLoader.Load(physical); 
            }
            catch (Exception exception)
            {
                string msg = TextHelper.GetString("Info.CouldNotOpenProject");
                ErrorManager.ShowInfo(msg + " " + exception.Message);
                return null;
            }
        }

        public string ImportProject()
        {
            OpenFileDialog dialog = new OpenFileDialog();
            dialog.Title = TextHelper.GetString("Title.ImportProject");
            dialog.Filter = TextHelper.GetString("Info.ImportProjectFilter");
            if (dialog.ShowDialog() == DialogResult.OK && File.Exists(dialog.FileName))
            {
                if (FileInspector.IsFlexBuilderProject(dialog.FileName))
                {
                    try
                    {
                        Project imported = AS3Project.Load(dialog.FileName);
                        string path = Path.GetDirectoryName(imported.ProjectPath);
                        string name = Path.GetFileName(path);
                        string newPath = Path.Combine(path, name + ".as3proj");
                        imported.SaveAs(newPath);
                        return newPath;
                    }
                    catch (Exception exception)
                    {
                        string msg = TextHelper.GetString("Info.CouldNotOpenProject");
                        ErrorManager.ShowInfo(msg + " " + exception.Message);
                    }
                }
            }
            return null;
        }

        #endregion

		#region Update ASCompletion

		public void UpdateASCompletion(IMainForm mainForm, Project project)
		{
            List<string> classPaths = new List<string>();
			
            if (project != null)
            {
                // add player version
                classPaths.Add(project.MovieOptions.Version.ToString());

                // add special features
                if (project is AS3Project)
                {
                    string[] additional = (project.CompilerOptions as MxmlcOptions).Additional;
                    if (additional != null)
                        foreach (string param in additional)
                        {
                            if (param.IndexOf("configname=air") >= 0)
                                classPaths.Add("AIR");
                        }
                }

                // add project classpaths
                foreach (string cp in project.AbsoluteClasspaths)
                    if (Directory.Exists(cp)) classPaths.Add(cp);

                // add AS3 libraries
                if (project is AS3Project)
                {
                    MxmlcOptions options = (project as AS3Project).CompilerOptions;
                    foreach (string relPath in options.IntrinsicPaths)
                    {
                        string absPath = PathHelper.ResolvePath(relPath, project.Directory);
                        if (Directory.Exists(absPath)) classPaths.Add(absPath);
                    }
                    foreach (string relPath in options.LibraryPaths)
                    {
                        string absPath = project.GetAbsolutePath(relPath);
                        if (File.Exists(absPath)) classPaths.Add(absPath);
                        else if (Directory.Exists(absPath))
                        {
                            string[] libs = Directory.GetFiles(absPath, "*.swc");
                            foreach (string lib in libs) classPaths.Add(lib);
                        }
                    }
                    foreach (string relPath in options.IncludeLibraries)
                    {
                        string absPath = project.GetAbsolutePath(relPath);
                        if (Directory.Exists(absPath) || File.Exists(absPath)) classPaths.Add(absPath);
                    }
                    foreach (string relPath in options.ExternalLibraryPaths)
                    {
                        string absPath = project.GetAbsolutePath(relPath);
                        if (Directory.Exists(absPath) || File.Exists(absPath)) classPaths.Add(absPath);
                    }
                    foreach (string relPath in options.RSLPaths)
                    {
                        string[] parts = relPath.Split(',');
                        if (parts.Length < 2) continue;
                        string absPath = project.GetAbsolutePath(parts[0]);
                        if (File.Exists(absPath)) classPaths.Add(absPath);
                    }
                }
            }

            // release old classpath
            DataEvent de;
            if (currentLang != null && (project == null || currentLang != project.Language))
            {
                de = new DataEvent(EventType.Command, "ASCompletion.ClassPath", currentLang + ";");
                EventManager.DispatchEvent(this, de);
            }

            // set new classpath
            if (project != null)
            {
                currentLang = project.Language;
                string cps = currentLang + ";" + string.Join(";", classPaths.ToArray());

                de = new DataEvent(EventType.Command, "ASCompletion.ClassPath", cps);
                EventManager.DispatchEvent(this, de);
            }
            else currentLang = null;
		}

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

        public void InsertFile(IMainForm mainForm, Project project, string path, GenericNode node)
		{
            if (!mainForm.CurrentDocument.IsEditable) return;
            string nodeType = (node != null) ? node.GetType().ToString() : null;
            string export = (node != null && node is ExportNode) ? (node as ExportNode).Export : null;
            string textToInsert = project.GetInsertFileText(mainForm.CurrentDocument.FileName, path, export, nodeType);
            if (textToInsert == null) return;
            if (mainForm.CurrentDocument.IsEditable)
            {
                mainForm.CurrentDocument.SciControl.AddText(textToInsert.Length, textToInsert);
                mainForm.CurrentDocument.Activate();
            }
            else
            {
                string msg = TextHelper.GetString("Info.EmbedNeedsOpenDocument");
                ErrorManager.ShowInfo(msg);
            }
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
            if (project.MaxTargetsCount > 0)
            {
                while (project.CompileTargets.Count > project.MaxTargetsCount)
                {
                    string relPath = project.CompileTargets[0];
                    string path = project.GetAbsolutePath(relPath);
                    project.SetCompileTarget(path, false);
                    OnProjectModified(new string[] { path });
                }
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
