using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;
using PluginCore;
using ProjectExplorer.Helpers;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.Actions
{
	public delegate void BuildCompleteHandler(bool runOutput);

	/// <summary>
	/// Provides methods for building a project inside FlashDevelop
	/// </summary>
	public class BuildActions
	{
		IMainForm mainForm;
		FDProcessRunner fdProcess;
		ArrayList missingClasspaths;

		bool runOutput;
		Project project;

		public event EventHandler ClasspathsChanged;
		public event BuildCompleteHandler BuildComplete;

		public BuildActions(IMainForm mainForm)
		{
			this.mainForm = mainForm;
			this.missingClasspaths = new ArrayList();

			// setup FDProcess helper class
			fdProcess = new FDProcessRunner(mainForm);
		}

		public void Build(Project project, bool runOutput, bool noTrace)
		{
			this.runOutput = runOutput;
			this.project = project;

			if (project.CompilerOptions.UseMain && project.CompileTargets.Count == 0)
			{
				ErrorHandler.ShowInfo("In order to build this project, you must mark one or more classes as \"Always Compile\" in the project Explorer, or turn off the 'UseMain' compiler option.");
				return;
			}

			if (project.OutputPath.Length < 1)
			{
				ErrorHandler.ShowInfo("In order to build this project, you must specify a valid Output SWF in the Project Properties.");
				return;
			}

			// save modified files
			mainForm.CallCommand("SaveAllModified",null);

			string toolsPath = Path.Combine(Application.StartupPath, "tools");
			string fdBuildDir = Path.Combine(toolsPath, "fdbuild");
			string fdBuildPath = Path.Combine(fdBuildDir, "fdbuild.exe");

			string arguments = "";

			if (noTrace)
				arguments += " -notrace";

			if (Settings.GlobalClasspaths != null)
				foreach (string cp in Environment.ExpandEnvironmentVariables(Settings.GlobalClasspaths).Split(';'))
					arguments += " -cp \"" + cp + "\"";
			
			arguments = arguments.Replace("\\\"", "\""); // c# console args[] bugfix

			SetStatusBar("Build started...");

			// track what classpaths, if any, were missing before the build
			missingClasspaths.Clear();
			foreach (string cp in project.AbsoluteClasspaths)
				if (!Directory.Exists(cp))
					missingClasspaths.Add(cp);

			fdProcess.StartProcess(fdBuildPath, 
				"\"" + project.ProjectPath + "\"" + arguments,
				project.Directory, new ProcessEndedHandler(BuildCallback));
		}

		void BuildCallback(bool success)
		{
			if (success)
			{
				SetStatusBar("Build succeeded");
				
				// add SWF to trusted files
				// TODO: add an option in the settings
				string directory = Path.GetDirectoryName(project.AbsoluteOutputPath);
				string trustFile = directory.Replace(Path.DirectorySeparatorChar,'_').Remove(1,1);
				while ((trustFile.Length > 100) && (trustFile.IndexOf('_') > 0)) trustFile = trustFile.Substring(trustFile.IndexOf('_'));
				string trustParams = "FlashDevelop_"+trustFile+".cfg;"+directory;

				DataEvent deTrust = new DataEvent(EventType.CustomData, "CreateTrustFile", trustParams);
				mainForm.DispatchEvent(deTrust);

				// it's possible that the build process created classpath directories
				// that weren't there before.  if it did, we have to update ASCompletion
				foreach (string cp in missingClasspaths)
					if (Directory.Exists(cp))
					{
						if (ClasspathsChanged != null)
							ClasspathsChanged(this,new EventArgs());
						break;
					}

				if (BuildComplete != null)
					BuildComplete(runOutput);				
			}
			else SetStatusBar("Build failed");
		}

		public void NotifyBuildStarted() {
			fdProcess.ProcessStartedEventCaught();
		}

		public void NotifyBuildEnded(string result) {
			fdProcess.ProcessEndedEventCaught(result);
		}

		void SetStatusBar(string text) {
			mainForm.StatusBar.Panels[0].Text = "  " + text;
		}
	}
}
