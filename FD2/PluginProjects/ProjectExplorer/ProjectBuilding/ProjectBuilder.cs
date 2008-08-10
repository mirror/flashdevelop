using System;
using System.IO;
using System.Text;
using System.Reflection;
using System.Diagnostics;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.ProjectBuilding
{
	public class BuildException : Exception
	{
		public BuildException(string message) : base(message) { }
	}

	public class ProjectBuilder
	{
		Project project;

		#region Path Helpers

		string FDBuildDirectory
		{
			get
			{
				string uriString =
					Path.GetDirectoryName(Assembly.GetCallingAssembly().GetName().EscapedCodeBase);
				Uri uri = new Uri(uriString);
				return uri.LocalPath;
			}
		}

		string MtascPath
		{
			get
			{
				// assume that mtasc.exe is probably in a directory alongside fdbuild
				string upDirectory = Path.GetDirectoryName(FDBuildDirectory);
				string mtascDir = Path.Combine(upDirectory, "mtasc");
				string mtascPath = Path.Combine(mtascDir, "mtasc.exe");

				if (File.Exists(mtascPath))
					return mtascPath;
				else
					return "mtasc.exe"; // hope you have it in your environment path!
			}
		}

		string SwfmillPath
		{
			get
			{
				// assume that swfmill.exe is probably in a directory alongside fdbuild
				string upDirectory = Path.GetDirectoryName(FDBuildDirectory);
				string swfmillDir = Path.Combine(upDirectory, "swfmill");
				string swfmillPath = Path.Combine(swfmillDir, "swfmill.exe");

				if (File.Exists(swfmillPath))
					return swfmillPath;
				else
					return "swfmill.exe"; // hope you have it in your environment path!
			}
		}

		#endregion

		public ProjectBuilder(Project project)
		{
			this.project = project;
		}

		public void Build(string[] extraClasspaths, bool noTrace)
		{
			Console.WriteLine("Building " + project.Name);

			BuildEventRunner runner = new BuildEventRunner(project, extraClasspaths);
			bool attempedPostBuildEvent = false;

			try
			{
				if (project.PreBuildEvent.Length > 0)
				{
					Console.WriteLine("Running Pre-Build Command Line...");
					runner.Run(project.PreBuildEvent);
				}
				DoBuild(extraClasspaths,noTrace);
				attempedPostBuildEvent = true;

				if (project.PostBuildEvent.Length > 0)
				{
					Console.WriteLine("Running Post-Build Command Line...");
					runner.Run(project.PostBuildEvent);
				}
			}
			finally
			{
				// honor the post-build request on a failed build if you want
				if (!attempedPostBuildEvent && project.AlwaysRunPostBuild &&
					project.PostBuildEvent.Length > 0)
				{
					Console.WriteLine("Running Post-Build Command Line...");
					runner.Run(project.PostBuildEvent);
				}
			}

			Console.WriteLine("Build succeeded");
		}

		public void DoBuild(string[] extraClasspaths, bool noTrace)
		{
			// compile into frame 1 unless you're using shared libraries or preloaders
			int frame = 1;

			Environment.CurrentDirectory = project.Directory;

			// before doing anything else, make sure any resources marked as "keep updated"
			// are properly kept up to date if possible
			KeepUpdated();

			// delete existing output file if it exists
			if (File.Exists(project.OutputPath))
				File.Delete(project.OutputPath);

			// if we have any resources, build our library file and run swfmill on it
			if (!project.UsesInjection && project.LibraryAssets.Count > 0)
			{
				// ensure obj directory exists
				if (!Directory.Exists("obj"))
					Directory.CreateDirectory("obj");

				string backupLibraryPath = Path.Combine("obj", project.Name+"Library.old");
				string relLibraryPath = Path.Combine("obj", project.Name+"Library.xml");
				string backupSwfPath = Path.Combine("obj", project.Name+"Resources.swf");
				string arguments = string.Format("simple \"{0}\" \"{1}\"",
					relLibraryPath,project.OutputPath);

				// backup the old Library.xml to Library.old so we can reference it
				if (File.Exists(relLibraryPath))
					File.Copy(relLibraryPath, backupLibraryPath, true);

				SwfmillLibraryWriter swfmill = new SwfmillLibraryWriter(relLibraryPath);
				swfmill.WriteProject(project);

				if (swfmill.NeedsMoreFrames) frame = 3;

				// compare the Library.xml with the one we generated last time.
				// if they're identical, and we have a Resources.swf, then we can
				// just assume that Resources.swf is up to date.
				if (File.Exists(backupSwfPath) && File.Exists(backupLibraryPath) &&
					FileComparer.IsEqual(relLibraryPath, backupLibraryPath))
				{
					// just copy the old one over!
					File.Copy(backupSwfPath, project.OutputPath, true);
				}
				else
				{
					// delete old resource SWF as it's not longer valid
					if (File.Exists(backupSwfPath))
						File.Delete(backupSwfPath);

					Console.WriteLine("Compiling resources");

					if (project.CompilerOptions.Verbose)
						Console.WriteLine("swfmill " + arguments);
					
					if (!ProcessRunner.Run(SwfmillPath, arguments, true))
						throw new BuildException("Build halted with errors (swfmill).");

					// ok, we just generated a swf with all our resources ... save it for
					// reuse if no resources changed next time we compile
					try { File.Copy(project.OutputPath, backupSwfPath, true); }
					catch (Exception exception) { Console.Error.WriteLine("Could not backup the resources SWF: " + exception.Message); }
				}
			}

			// do we have anything to compile?
			if (project.CompileTargets.Count > 0 || 
				project.CompilerOptions.IncludePackages.Length > 0)
			{
				MtascArgumentBuilder mtasc = new MtascArgumentBuilder(project);
				mtasc.AddCompileTargets();
				mtasc.AddOutput();
				mtasc.AddClassPaths(extraClasspaths);
				mtasc.AddOptions(noTrace);

				if (project.UsesInjection)
				{
					mtasc.AddInput();
				}
				else
				{
					mtasc.AddFrame(frame);

					if (project.LibraryAssets.Count == 0)
						mtasc.AddHeader(); // mtasc will have to generate its own output SWF
					else
						mtasc.AddKeep(); // keep everything you added with swfmill
				}
				
				string mtascArgs = mtasc.ToString();

				if (project.CompilerOptions.Verbose)
					Console.WriteLine("mtasc " + mtascArgs);

				if (!ProcessRunner.Run(MtascPath, mtascArgs, false))
					throw new BuildException("Build halted with errors (mtasc).");
			}
		}

		private void KeepUpdated()
		{
			foreach (LibraryAsset asset in project.LibraryAssets)
				if (asset.UpdatePath != null)
				{
					string assetName = Path.GetFileName(asset.Path);
					string assetPath = project.GetAbsolutePath(asset.Path);
					string updatePath = project.GetAbsolutePath(asset.UpdatePath);
					if (File.Exists(updatePath))
					{
						// check size/modified
						FileInfo source = new FileInfo(updatePath);
						FileInfo dest = new FileInfo(assetPath);

						if (source.LastWriteTime != dest.LastWriteTime ||
							source.Length != dest.Length)
						{
							Console.WriteLine("Updating asset '" + assetName + "'");
							File.Copy(updatePath,assetPath,true);
						}
					}
					else
					{
						Console.Error.WriteLine("Warning: asset '"+assetName+"' could "
							+ " not be updated, as the source file could does not exist.");
					}
				}
		}
	}
}
