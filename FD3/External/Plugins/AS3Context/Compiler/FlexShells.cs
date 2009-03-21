using System;
using System.Windows.Forms;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Diagnostics;
using System.Timers;
using System.Runtime.InteropServices;
using PluginCore;
using PluginCore.Helpers;
using ASCompletion.Context;
using PluginCore.Managers;
using PluginCore.Utilities;
using PluginCore.Localization;
using ASCompletion.Model;
using System.Collections;
using PluginCore.PluginCore.Helpers;

namespace AS3Context.Compiler
{
    public delegate void SyntaxErrorHandler(string error);

	/// <summary>
	/// Wrappers for Flex SDK integration
	/// </summary>
	public class FlexShells
	{
        static public event SyntaxErrorHandler SyntaxError;

		static readonly public Regex re_SplitParams = 
			new Regex("[\\s](?<switch>\\-[A-z\\-\\.]+)", RegexOptions.Compiled | RegexOptions.Singleline);

		static private readonly string[] PATH_SWITCHES = { 
			"-compiler.context-root","-context-root",
			"-compiler.defaults-css-url","-defaults-css-url",
			"-compiler.external-library-path","-external-library-path","-el",
			"-compiler.fonts.system-search-path","-system-search-path",
			"-compiler.include-libraries","-include-libraries",
			"-compiler.library-path","-library-path","-l",
			"-compiler.source-path","-source-path","-sp",
			"-compiler.services","-services",
			"-compiler.theme","-theme",
			"-dump-config","-file-specs","resource-bundle-list",
			"-link-report","-load-config","-load-externs",
			"-output","-o","-runtime-shared-libraries","-rsl",
            "-namespace","-compiler.namespaces.namespace"};
		
        static private string ascPath;
        static private string mxmlcPath;
		static private string flexShellsJar = "FlexShells.jar";
		static private string flexShellsPath;
        static private bool running;
        static private bool silentChecking;
		
		static private void CheckResource(string filename)
		{
            string path = Path.Combine(PathHelper.DataDir, "AS3Context");
            flexShellsPath = Path.Combine(path, flexShellsJar);
            if (!File.Exists(flexShellsPath))
			{
                string id = "AS3Context.Compiler." + filename;
				System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
                using (BinaryReader br = new BinaryReader(assembly.GetManifestResourceStream(id)))
                {
                    using (FileStream bw = File.Create(flexShellsPath))
                    {
                        byte[] buffer = br.ReadBytes(1024);
                        while (buffer.Length > 0)
                        {
                            bw.Write(buffer, 0, buffer.Length);
                            buffer = br.ReadBytes(1024);
                        }
                        bw.Close();
                    }
                    br.Close();
                }
			}
		}

        static public FlexShells Instance 
		{
			get {
				if (instance == null) instance = new FlexShells();
				return instance;
			}
		}
		
		static private FlexShells instance;

        private FlexShells()
		{
		}

        private ProcessRunner ascRunner;
		private ProcessRunner mxmlcRunner;
		private string builtSWF;
        private bool debugMode;
        private Hashtable jvmConfig;

        public void CheckAS3(string filename, string flexPath)
        {
            CheckAS3(filename, flexPath, null);
        }

        public void CheckAS3(string filename, string flexPath, string src)
		{
            if (running) return;
            string basePath = null;
            if (PluginBase.CurrentProject != null)
                basePath = Path.GetDirectoryName(PluginBase.CurrentProject.ProjectPath);
            flexPath = PathHelper.ResolvePath(flexPath, basePath);
            // asc.jar in Flex2SDK
            if (flexPath != null && Directory.Exists(flexPath))
            {
                if (flexPath.EndsWith("bin", StringComparison.OrdinalIgnoreCase))
                    flexPath = Path.GetDirectoryName(flexPath);
                ascPath = Path.Combine(flexPath, "lib\\asc.jar");
            }
            // asc_authoring.jar in Flash CS3
            if (ascPath == null) ascPath = FindAscAuthoring();

            if (ascPath == null)
            {
                if (src != null) return; // silent checking
                DialogResult result = MessageBox.Show(TextHelper.GetString("Info.SetFlex2OrCS3Path"), TextHelper.GetString("Title.ConfigurationRequired"), MessageBoxButtons.YesNoCancel);
                if (result == DialogResult.Yes)
                {
                    IASContext context = ASContext.GetLanguageContext("as3");
                    if (context == null) return;
                    PluginBase.MainForm.ShowSettingsDialog("AS3Context");
                }
                else if (result == DialogResult.No)
                {
                    PluginBase.MainForm.ShowSettingsDialog("ASCompletion");
                }
                return;
            }

            CheckResource(flexShellsJar);
            if (!File.Exists(flexShellsPath))
            {
                if (src != null) return; // silent checking
                ErrorManager.ShowInfo(TextHelper.GetString("Info.ResourceError"));
                return;
            }

            jvmConfig = JvmConfigHelper.ReadConfig(Path.Combine(flexPath, "bin\\jvm.config"));
			
			try
			{
                running = true;
                if (src == null) EventManager.DispatchEvent(this, new NotifyEvent(EventType.ProcessStart));
				if (ascRunner == null || !ascRunner.IsRunning) StartAscRunner();

				notificationSent = false;
                if (src == null)
                {
                    silentChecking = false;
                    TraceManager.Add("Checking: " + filename, -1);
                    ASContext.SetStatusText("Asc Running");
                    ascRunner.HostedProcess.StandardInput.WriteLine(filename);
                }
                else
                {
                    silentChecking = true;
                    ascRunner.HostedProcess.StandardInput.WriteLine(filename + "$raw$");
                    ascRunner.HostedProcess.StandardInput.WriteLine(src);
                    ascRunner.HostedProcess.StandardInput.WriteLine(filename + "$raw$");
                }
			}
			catch(Exception ex)
			{
                ErrorManager.ShowError(TextHelper.GetString("Info.CheckError"), ex);
			}
		}

        public void RunMxmlc(string cmd, string flexPath)
		{
            if (running) return;
            string basePath = null;
            if (PluginBase.CurrentProject != null)
                basePath = Path.GetDirectoryName(PluginBase.CurrentProject.ProjectPath);
            flexPath = PathHelper.ResolvePath(flexPath, basePath);

            if (flexPath != null && Directory.Exists(flexPath))
            {
                if (flexPath.EndsWith("bin", StringComparison.OrdinalIgnoreCase))
                    flexPath = Path.GetDirectoryName(flexPath);
                mxmlcPath = Path.Combine(Path.Combine(flexPath, "lib"), "mxmlc.jar");
            }
			if (mxmlcPath == null || !File.Exists(mxmlcPath)) 
            {
                DialogResult result = MessageBox.Show(TextHelper.GetString("Info.OpenCompilerSettings"), TextHelper.GetString("Title.ConfigurationRequired"), MessageBoxButtons.OKCancel);
                if (result == DialogResult.OK)
                {
                    IASContext context = ASContext.GetLanguageContext("as3");
                    if (context == null) return;
                    PluginBase.MainForm.ShowSettingsDialog("AS3Context");
                }
				return;
			}

            CheckResource(flexShellsJar);
            if (!File.Exists(flexShellsPath))
            {
                ErrorManager.ShowInfo(TextHelper.GetString("Info.ResourceError"));
                return;
            }

            jvmConfig = JvmConfigHelper.ReadConfig(Path.Combine(flexPath, "bin\\jvm.config"));
			
			try
			{
                running = true;
				EventManager.DispatchEvent(this, new NotifyEvent(EventType.ProcessStart));
				
				if (mxmlcRunner == null || !mxmlcRunner.IsRunning) StartMxmlcRunner(flexPath);
				
				//cmd = mainForm.ProcessArgString(cmd);
				TraceManager.Add("MxmlcShell command: "+cmd, -1);
				
				ASContext.SetStatusText("Mxmlc Running");
				notificationSent = false;
				mxmlcRunner.HostedProcess.StandardInput.WriteLine(cmd);
			}
			catch(Exception ex)
			{
				ErrorManager.ShowError(ex);
			}
		}

        public void QuickBuild(FileModel theFile, string flex2Path, bool requireTag, bool playAfterBuild)
		{
            if (running) return;
			// environment
            string filename = theFile.FileName;
            string currentPath = Environment.CurrentDirectory;
            string buildPath = PluginBase.MainForm.ProcessArgString("$(ProjectDir)");
			if (!Directory.Exists(buildPath) 
                || !filename.StartsWith(buildPath, StringComparison.OrdinalIgnoreCase)) 
			{
                buildPath = theFile.BasePath;
                if (!Directory.Exists(buildPath))
				    buildPath = Path.GetDirectoryName(filename);
			}
			// command
            debugMode = false;
            bool hasOutput = false;
            string cmd = "";
			Match mCmd = Regex.Match(PluginBase.MainForm.CurrentDocument.SciControl.Text, "\\s@mxmlc\\s(?<cmd>.*)");
            if (mCmd.Success)
            {
                try
                {

                    // cleanup tag
                    string tag = mCmd.Groups["cmd"].Value;
                    if (tag.IndexOf("-->") > 0) tag = tag.Substring(0, tag.IndexOf("-->"));
                    if (tag.IndexOf("]]>") > 0) tag = tag.Substring(0, tag.IndexOf("]]>"));
                    tag = " " + tag.Trim() + " --";

                    // split
                    MatchCollection mPar = re_SplitParams.Matches(tag);
                    if (mPar.Count > 0)
                    {
                        cmd = "";
                        string op;
                        string arg;
                        for (int i = 0; i < mPar.Count; i++)
                        {
                            op = mPar[i].Groups["switch"].Value;
                            if (op == "--") break;
                            if (op == "-noplay")
                            {
                                playAfterBuild = false;
                                continue;
                            }
                            if (op == "-debug") debugMode = true;

                            int start = mPar[i].Index + mPar[i].Length;
                            int end = (i < mPar.Count - 1) ? mPar[i + 1].Index : 0;
                            if (end > start)
                            {
                                string concat = ";";
                                arg = tag.Substring(start, end - start).Trim();
                                if (arg.StartsWith("+=") || arg.StartsWith("="))
                                {
                                    concat = arg.Substring(0, arg.IndexOf('=') + 1);
                                    arg = arg.Substring(concat.Length);
                                }
                                bool isPath = false;
                                foreach (string pswitch in PATH_SWITCHES)
                                {
                                    if (pswitch == op)
                                    {
                                        if (op.EndsWith("namespace"))
                                        {
                                            int sp = arg.IndexOf(' ');
                                            if (sp > 0)
                                            {
                                                concat += arg.Substring(0, sp) + ";";
                                                arg = arg.Substring(sp + 1).TrimStart();
                                            }
                                        }
                                        isPath = true;
                                        if (!arg.StartsWith("\\") && !Path.IsPathRooted(arg))
                                            arg = Path.Combine(buildPath, arg);
                                    }
                                }
                                if (op == "-o" || op == "-output")
                                {
                                    builtSWF = arg;
                                    hasOutput = true;
                                }
                                if (!isPath) arg = arg.Replace(" ", ";");
                                cmd += op + concat + arg + ";";
                            }
                            else cmd += op + ";";
                        }
                    }
                }
                catch
                {
                    ErrorManager.ShowInfo(TextHelper.GetString("Info.InvalidForQuickBuild"));
                }
            }
            else if (requireTag) return;

            // add current class sourcepath and global classpaths
            cmd += ";-sp+=" + theFile.BasePath;
            if (Context.Context.Settings.UserClasspath != null)
                foreach (string cp in Context.Context.Settings.UserClasspath)
                    cmd += ";-sp+=" + cp;
            // add output filename
            if (!hasOutput) 
            {
                builtSWF = Path.Combine(buildPath, Path.GetFileNameWithoutExtension(filename)+".swf");
                cmd = "-o;" + builtSWF + ";" + cmd;
            }
            // add current file
            cmd += ";--;" + filename;

            // build
			cmd = cmd.Replace(";;", ";");
            RunMxmlc(cmd, flex2Path);
			if (!playAfterBuild) builtSWF = null;
			
			// restaure working directory
			Environment.CurrentDirectory = currentPath;
        }

        private string FindAscAuthoring()
        {
            string flashPath = ASContext.CommonSettings.PathToFlashIDE;
            if (flashPath == null) return null;
            string configPath = PluginMain.FindCS3ConfigurationPath(flashPath);
            if (configPath == null) return null;
            string ascJar = Path.Combine(configPath, "ActionScript 3.0\\asc_authoring.jar");
            if (File.Exists(ascJar)) return ascJar;
            else return null;
        }

        #region Background process

        /// <summary>
		/// Stop background processes
		/// </summary>
		public void Stop()
		{
			if (ascRunner != null && ascRunner.IsRunning) ascRunner.KillProcess();
			ascRunner = null;
			if (mxmlcRunner != null && mxmlcRunner.IsRunning) mxmlcRunner.KillProcess();
			mxmlcRunner = null;
		}
		
		/// <summary>
		/// Start background process
		/// </summary>
		private void StartAscRunner()
		{
            string cmd = "-Duser.language=en -Duser.region=US"
                + " -classpath \"" + ascPath + ";" + flexShellsPath + "\" AscShell";
            TraceManager.Add("Syntax checking process starting: java " + cmd, -1);
			// run asc shell
			ascRunner = new ProcessRunner();
            ascRunner.WorkingDirectory = Path.GetDirectoryName(ascPath);
            ascRunner.RedirectInput = true;
            ascRunner.Run(JvmConfigHelper.GetJavaEXE(jvmConfig), cmd, true);
            ascRunner.Output += ascRunner_Output;
            ascRunner.Error += ascRunner_Error;
            errorState = 0;
            Thread.Sleep(100);
		}
		
		/// <summary>
		/// Start background process
		/// </summary>
		private void StartMxmlcRunner(string flex2Path)
		{
            string cmd = jvmConfig["java.args"] 
                + " -classpath \"" + mxmlcPath + ";" + flexShellsPath + "\" MxmlcShell";
            TraceManager.Add("Flex compiler process starting: java " + cmd, -1);
			// run compiler shell
            mxmlcRunner = new ProcessRunner();
            mxmlcRunner.WorkingDirectory = Path.Combine(flex2Path, "frameworks");
            mxmlcRunner.RedirectInput = true;
            mxmlcRunner.Run(JvmConfigHelper.GetJavaEXE(jvmConfig), cmd, true);
            mxmlcRunner.Output += mxmlcRunner_Output;
            mxmlcRunner.Error += mxmlcRunner_Error;
            errorState = 0;
            Thread.Sleep(100);
        }
        #endregion

        #region process output capture

        private int errorState;
        private string errorDesc;
        private bool notificationSent;

        private void ascRunner_Error(object sender, string line)
        {
            if (line.StartsWith("[Compiler] Error"))
            {
                errorState = 1;
                errorDesc = line.Substring(10);
            }
            else if (errorState == 1)
            {
                line = line.Trim();
                Match mErr = Regex.Match(line, @"(?<file>[^,]+), Ln (?<line>[0-9]+), Col (?<col>[0-9]+)");
                if (mErr.Success)
                {
                	string filename = mErr.Groups["file"].Value;
            		try 
            		{
	                	if (File.Exists(filename))
	                	{
		                	StringBuilder sb = new StringBuilder(1024);
		                	GetLongPathName(filename, sb, (uint)1024);
							filename = sb.ToString();
	                	}
            		}
            		catch {}
                    errorDesc = String.Format("{0}:{1}: col: {2}: {3}", filename, mErr.Groups["line"].Value, mErr.Groups["col"].Value, errorDesc);
                    ascRunner_OutputError(sender, errorDesc);
                }
                errorState++;
            }
            else if (errorState > 0)
            {
            	if (line.IndexOf("error found") > 0) errorState = 0;
            }
            else if (line.Trim().Length > 0) ascRunner_OutputError(sender, line);
        }
        
        private void ascRunner_OutputError(object sender, string line)
        {
        	Control ctrl = ASContext.Panel as Control;
        	if (ctrl != null && ctrl.InvokeRequired)
                ctrl.BeginInvoke((MethodInvoker)delegate { ascRunner_OutputError(sender, line); });
        	else 
        	{
                if (silentChecking) 
                {
                    if (SyntaxError != null) SyntaxError(line);
                    return;
                }
                TraceManager.Add(line, -3);
	        	if (!notificationSent) 
	        	{
	        		notificationSent = true;
                    TraceManager.Add("Done(1)", -2);
                    EventManager.DispatchEvent(this, new TextEvent(EventType.ProcessEnd, "Done(1)"));
                    ASContext.SetStatusText("Asc Done");
                    EventManager.DispatchEvent(this, new DataEvent(EventType.Command, "ResultsPanel.ShowResults", null));
	        	}
        	}
        }

        private void ascRunner_Output(object sender, string line)
        {
            if (line.StartsWith("(ash)"))
            {
                if (line.IndexOf("Done") > 0)
                {
                    running = false;
                    if (!silentChecking && !notificationSent)
                    {
                        notificationSent = true;
                        ascRunner_End();
                    }
                }
                return;
            }
            Control ctrl = ASContext.Panel as Control;
            if (ctrl != null && ctrl.InvokeRequired)
                ctrl.BeginInvoke((MethodInvoker)delegate { ascRunner_Output(sender, line); });
            else
            {
                if (!silentChecking) TraceManager.Add(line, 0);
            }
        }

        private void ascRunner_End()
        {
            Control ctrl = ASContext.Panel as Control;
            if (ctrl != null && ctrl.InvokeRequired)
                ctrl.BeginInvoke((MethodInvoker)delegate
                {
                    ascRunner_End();
                });
            else
            {
                TraceManager.Add("Done(0)", -2);
            }
        }
        
        private void mxmlcRunner_Error(object sender, string line)
        {
            Control ctrl = ASContext.Panel as Control;
        	if (ctrl != null && ctrl.InvokeRequired)
                ctrl.BeginInvoke((MethodInvoker)delegate { mxmlcRunner_Error(sender, line); });
        	else 
        	{
                TraceManager.Add(line, -3);
        	}
        }

        private void mxmlcRunner_Output(object sender, string line)
        {
            Control ctrl = ASContext.Panel as Control;
        	if (ctrl != null && ctrl.InvokeRequired) 
                ctrl.BeginInvoke((MethodInvoker)delegate { mxmlcRunner_Output(sender, line); });
        	else 
        	{
        		if (!notificationSent && line.StartsWith("Done("))
        		{
                    running = false;
                    TraceManager.Add(line, -2);
        			notificationSent = true;
	        		ASContext.SetStatusText("Mxmlc Done");
                    EventManager.DispatchEvent(this, new TextEvent(EventType.ProcessEnd, line));
	        		if (Regex.IsMatch(line, "Done\\([1-9]"))
	        		{
                        EventManager.DispatchEvent(this, new DataEvent(EventType.Command, "ResultsPanel.ShowResults", null));
	        		}
	        		else RunAfterBuild();
        		}
                else TraceManager.Add(line, 0);
        	}
        }
        
        private void RunAfterBuild()
        {
            if (builtSWF == null || !File.Exists(builtSWF))
            {
                debugMode = false;
                return;
            }
        	string swf = builtSWF;
        	builtSWF = null;

            // debugger
            if (debugMode)
            {
                DataEvent de = new DataEvent(EventType.Command, "AS3Context.StartDebugger", null);
                EventManager.DispatchEvent(this, de);
            }

   			// other plugin may handle the SWF playing
            DataEvent dePlay = new DataEvent(EventType.Command, "FlashViewer.Default", swf);
            EventManager.DispatchEvent(this, dePlay);
			if (dePlay.Handled) return;
			
			try 
			{
				// change current directory
				string currentPath = System.IO.Directory.GetCurrentDirectory();
				System.IO.Directory.SetCurrentDirectory(Path.GetDirectoryName(swf));
				// run
				System.Diagnostics.Process.Start(swf);
				// restaure current directory
				System.IO.Directory.SetCurrentDirectory(currentPath);
			}
			catch (Exception ex)
			{
				ErrorManager.ShowError(ex.Message, ex);
			}
        }
        #endregion

        #region Win32

        [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError=true)]
		static extern uint GetShortPathName(
		   [MarshalAs(UnmanagedType.LPTStr)]
		   string lpszLongPath,
		   [MarshalAs(UnmanagedType.LPTStr)]
		   StringBuilder lpszShortPath,
		   uint cchBuffer);
        
        [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Auto)]
		static extern uint GetLongPathName(
		    string lpszShortPath,
		    [Out] StringBuilder lpszLongPath,
		    uint cchBuffer);

        #endregion
    }
}
