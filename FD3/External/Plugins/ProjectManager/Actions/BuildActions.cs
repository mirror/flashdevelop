using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Ipc;
using PluginCore;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore.Localization;
using ProjectManager.Helpers;
using ProjectManager.Projects;
using ProjectManager.Projects.AS2;
using ProjectManager.Projects.AS3;
using ProjectManager.Controls;

namespace ProjectManager.Actions
{
	public delegate void BuildCompleteHandler(bool runOutput);

	/// <summary>
	/// Provides methods for building a project inside FlashDevelop
	/// </summary>
	public class BuildActions
	{
		IMainForm mainForm;
        FDMenus menus;
		FDProcessRunner fdProcess;
        string ipcName;
        static bool usingProjectDefinedCompiler;

		public event BuildCompleteHandler BuildComplete;
        public event BuildCompleteHandler BuildFailed;

        public string IPCName { get { return ipcName; } }

		public BuildActions(IMainForm mainForm, FDMenus menus)
		{
			this.mainForm = mainForm;
            this.menus = menus;

			// setup FDProcess helper class
			this.fdProcess = new FDProcessRunner(mainForm);

            // setup remoting service so FDBuild can use our in-memory services like FlexCompilerShell
            this.ipcName = Guid.NewGuid().ToString();
            SetupRemotingServer();
		}

        private void SetupRemotingServer()
        {
            IpcChannel channel = new IpcChannel(ipcName);
            ChannelServices.RegisterChannel(channel, false);
            RemotingConfiguration.RegisterWellKnownServiceType(typeof(FlexCompilerShell), "FlexCompilerShell", WellKnownObjectMode.Singleton);
        }

        public bool Build(Project project, bool runOutput, bool noTrace)
        {
            // save modified files
            mainForm.CallCommand("SaveAllModified", null);
            string compiler = null;
            project.TraceEnabled = !noTrace;
            if (project.NoOutput)
            {
                // get the compiler for as3 projects, or else the FDBuildCommand pre/post command in FDBuild will fail on "No Output" projects
                if (project.Language == "as3") compiler = GetCompilerPath(project);
                
                if (project.PreBuildEvent.Trim().Length == 0 && project.PostBuildEvent.Trim().Length == 0)
                {
                    // no output and no build commands
                    if (project is AS2Project || project is AS3Project) RunFlashIDE(runOutput, noTrace);
                    else
                    {
                        String info = TextHelper.GetString("Info.NoOutputAndNoBuild");
                        ErrorManager.ShowInfo(info);
                    }
                    return false;
                }
            }
            else
            {
                // Ask the project to validate itself
                string error;
                project.ValidateBuild(out error);

                if (error != null)
                {
                    ErrorManager.ShowInfo(TextHelper.GetString(error));
                    return false;
                }

                if (project.OutputPath.Length < 1)
                {
                    String info = TextHelper.GetString("Info.SpecifyValidOutputSWF");
                    ErrorManager.ShowInfo(info);
                    return false;
                }
                compiler = GetCompilerPath(project);
                if (compiler == null || (!Directory.Exists(compiler) && !File.Exists(compiler)))
                {
                    if (usingProjectDefinedCompiler)
                    {
                        string info = TextHelper.GetString("Info.InvalidCustomCompiler");
                        MessageBox.Show(info, TextHelper.GetString("Title.ConfigurationRequired"), MessageBoxButtons.OK);
                    }
                    else
                    {
                        string info = String.Format(TextHelper.GetString("Info.SpecifyCompilerPath"), project.Language.ToUpper());
                        DialogResult result = MessageBox.Show(info, TextHelper.GetString("Title.ConfigurationRequired"), MessageBoxButtons.OKCancel);
                        if (result == DialogResult.OK)
                        {
                            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.ShowSettings", project.Language);
                            EventManager.DispatchEvent(this, de);
                        }
                    }
                    return false;
                }
            }
            return FDBuild(project, runOutput, noTrace, compiler);
        }

        private void RunFlashIDE(bool runOutput, bool noTrace)
        {
            string cmd = (runOutput) ? "testmovie.jsfl" : "buildmovie.jsfl";
            if (!noTrace) cmd = "debug-" + cmd;
            cmd = Path.Combine("Tools", Path.Combine("flashide", cmd));
            cmd = PathHelper.ResolvePath(cmd, null);
            if (cmd == null || !File.Exists(cmd))
            {
                ErrorManager.ShowInfo(TextHelper.GetString("Info.JsflNotFound"));
            }
            else
            {
                DataEvent de = new DataEvent(EventType.Command, "ASCompletion.CallFlashIDE", cmd);
                EventManager.DispatchEvent(this, de);
            }
        }

        public bool FDBuild(Project project, bool runOutput, bool noTrace, string compiler)
		{
			string fdBuildDir = Path.Combine(PathHelper.ToolDir, "fdbuild");
			string fdBuildPath = Path.Combine(fdBuildDir, "fdbuild.exe");

			string arguments = " -ipc " + ipcName;
            if (compiler != null && compiler.Length > 0) arguments += " -compiler \"" + compiler + "\"";
			if (noTrace) arguments += " -notrace";
            arguments += " -library \"" + PathHelper.LibraryDir + "\"";

            foreach (string cp in PluginMain.Settings.GlobalClasspaths)
            {
                arguments += " -cp \"" + Environment.ExpandEnvironmentVariables(cp) + "\"";
            }
			
			arguments = arguments.Replace("\\\"", "\""); // c# console args[] bugfix

            SetStatusBar(TextHelper.GetString("Info.BuildStarted"));
            menus.DisabledForBuild = true;
            menus.ConfigurationSelector.Enabled = false;

            fdProcess.StartProcess(fdBuildPath, "\"" + project.ProjectPath + "\"" + arguments,
                project.Directory, delegate(bool success)
                {
                    menus.DisabledForBuild = false;
                    menus.ConfigurationSelector.Enabled = true; // !project.NoOutput;
                    if (success)
                    {
                        SetStatusBar(TextHelper.GetString("Info.BuildSucceeded"));
                        AddTrustFile(project);
                        OnBuildComplete(runOutput);
                    }
                    else
                    {
                        SetStatusBar(TextHelper.GetString("Info.BuildFailed"));
                        OnBuildFailed(runOutput);
                    }
                });
            return true;
		}

        /// <summary>
        /// Retrieve the project language's default compiler path
        /// </summary>
        /// <param name="project"></param>
        static public string GetCompilerPath(Project project)
        {
            if (project.Language == "as3" && (project as AS3Project).CompilerOptions.CustomSDK.Length > 0)
            {
                usingProjectDefinedCompiler = true;
                return PathHelper.ResolvePath((project as AS3Project).CompilerOptions.CustomSDK, project.Directory);
            }
            usingProjectDefinedCompiler = false;

            Hashtable info = new Hashtable();
            info["language"] = project.Language;
            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.GetCompilerPath", info);
            EventManager.DispatchEvent(project, de);
            if (de.Handled && info.ContainsKey("compiler"))
            {
                return PathHelper.ResolvePath(info["compiler"] as string, project.Directory);
            }
            else return null;
        }

        void OnBuildComplete(bool runOutput)
        {
            if (BuildComplete != null) BuildComplete(runOutput);
        }

        void OnBuildFailed(bool runOutput)
        {
            if (BuildFailed != null) BuildFailed(runOutput);
        }

        void AddTrustFile(Project project)
        {
            string directory = Path.GetDirectoryName(project.OutputPathAbsolute);
            if (!Directory.Exists(directory)) return;
            string trustParams = "FlashDevelop.cfg;" + directory;
            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.CreateTrustFile", trustParams);
            EventManager.DispatchEvent(this, de);
        }

		public void NotifyBuildStarted() { fdProcess.ProcessStartedEventCaught(); }
		public void NotifyBuildEnded(string result) { fdProcess.ProcessEndedEventCaught(result); }
        public void SetStatusBar(string text) { mainForm.StatusLabel.Text = " " + text; }

	}

}
