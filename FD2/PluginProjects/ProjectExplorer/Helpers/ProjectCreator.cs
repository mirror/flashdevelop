using System;
using System.Collections;
using System.IO;
using System.Diagnostics;
using ProjectExplorer.ProjectFormat;
using ProjectExplorer.Controls.TreeView;

namespace ProjectExplorer.Helpers
{
	/// <summary>
	/// Contains methods useful for working with project templates.
	/// </summary>
	public class ProjectCreator
	{
		string projectName;

		/// <summary>
		/// Creates a new project based on the specified template directory.
		/// </summary>
		public Project CreateProject(string templateDirectory, 
			string projectLocation, string projectName)
		{
			this.projectName = projectName;
			string projectTemplate = Path.Combine(templateDirectory,"Project.fdp");
			string projectPath = Path.Combine(projectLocation,projectName+".fdp");

			Directory.CreateDirectory(projectLocation);

			// manually copy important files
			CopyFile(projectTemplate,projectPath);

			CopyProjectFiles(templateDirectory,projectLocation,true);
			return Project.Load(projectPath);
		}

		private void CopyProjectFiles(string sourceDir, string destDir, bool filter)
		{
			Directory.CreateDirectory(destDir);

			foreach (string file in Directory.GetFiles(sourceDir))
			{
				if (filter && ShouldSkip(file))
					continue;

				string fileName = Path.GetFileName(file);
				string destFile = Path.Combine(destDir,fileName);

				CopyFile(file,destFile);
			}

			foreach (string dir in Directory.GetDirectories(sourceDir))
			{
				string dirName = Path.GetFileName(dir);
				string destSubDir = Path.Combine(destDir,dirName);

				// don't copy like .svn and stuff
				foreach (string excludedDir in ProjectTreeView.ExcludedDirectories)
					if (excludedDir == dirName.ToLower())
						continue;

				CopyProjectFiles(dir,destSubDir,false); // only filter the top directory
			}
		}

		// copy a file, if it's an .as or .fdp file, replace template keywords
		private void CopyFile(string source, string dest)
		{
			dest = ReplaceKeywords(dest); // you can use keywords in filenames too
			string ext = Path.GetExtension(source);

			if (ext == ".as" || ext == ".fdp")
			{
				using (StreamReader reader = File.OpenText(source))
				using (StreamWriter writer = File.CreateText(dest))
				{
					while (true)
					{
						string line = reader.ReadLine();
						if (line == null) break;
						writer.WriteLine(ReplaceKeywords(line));
					}
					writer.Flush();
				}
			}
			else File.Copy(source,dest);
		}

		private string ReplaceKeywords(string line)
		{
			return line.Replace("$(PROJECTNAME)",projectName);
		}

		private bool ShouldSkip(string path)
		{
			string filename = Path.GetFileName(path).ToLower();
			return filename == "project.fdp"
				|| filename == "project.txt"
				|| filename == "project.png";
		}
	}
}
