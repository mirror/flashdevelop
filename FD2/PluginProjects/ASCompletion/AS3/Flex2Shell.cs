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

namespace ASCompletion.AS3
{
	/// <summary>
	/// Description of Flex2Shell.
	/// </summary>
	public class Flex2Shell
	{
		static private readonly string KEY_FLEX2SDK = "ASCompletion.Flex2Sdk.Path";
		static readonly public Regex re_SplitParams = 
			new Regex("[\\s](?<switch>\\-[A-z\\-\\.]+)", RegexOptions.Compiled | RegexOptions.Singleline);
		static readonly public Regex re_Disk = 
			new Regex("^[a-z]:", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		
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
			"-output","-o","-runtime-shared-libraries","-rsl"};
		
		static private IMainForm mainForm;
		static private string flex2ShellPath = ".";
		static private string flex2Jar = "flex2shell.jar";
		static private string flex2Shell = null;
		static private string flexPath = ".";
		static private bool sdkOk;
		
		static public void Init(IMainForm mainForm)
		{
			Flex2Shell.mainForm = mainForm;
			if (!mainForm.MainSettings.HasKey(KEY_FLEX2SDK))
				mainForm.MainSettings.AddValue(KEY_FLEX2SDK, "c:\\flex_2_sdk");
			
			UpdateSettings();
		}
		
		static private void CheckResource(string id)
		{
			string resPath = Path.Combine(flex2ShellPath, id);
			if (!File.Exists(resPath))
			{
				System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
				using(BinaryReader br = new BinaryReader(assembly.GetManifestResourceStream(id)))
				{
					using(FileStream bw = File.Create(resPath))
					{
						byte[] buffer = br.ReadBytes(1024);
						while(buffer.Length > 0)
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
		
		static public void UpdateSettings()
		{
			flexPath = mainForm.MainSettings.GetValue(KEY_FLEX2SDK);
			sdkOk = Directory.Exists(Path.Combine(flexPath, "lib"));
			if (!sdkOk) return;
			
			flex2ShellPath = Path.GetDirectoryName(Application.ExecutablePath) + "\\Data\\ASCompletion";
			try
			{
				if (!Directory.Exists(flex2ShellPath)) Directory.CreateDirectory(flex2ShellPath);
				CheckResource(flex2Jar);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("ASCompletion: Unable to create resources", ex);
			}
			flex2Shell = Path.Combine(flex2ShellPath, flex2Jar);
		}
		
		static public Flex2Shell Instance 
		{
			get {
				if (instance == null) instance = new Flex2Shell();
				return instance;
			}
		}
		
		static private Flex2Shell instance;

		
		/* Singleton instance */
		
		private Flex2Shell()
		{
			watcher = new FileSystemWatcher();
			watcher.EnableRaisingEvents = false;
			watcher.Filter = "*.p";
			watcher.Created += new FileSystemEventHandler(onCreateFile);
			
			timer = new System.Timers.Timer();
			timer.Enabled = false;
			timer.AutoReset = false;
			timer.Interval = 300;
			timer.Elapsed += new ElapsedEventHandler(onTimedDelete);
		}
		
		private ProcessRunner ascRunner;
		private ProcessRunner mxmlcRunner;
		private FileSystemWatcher watcher;
		private string watchedFile;
		private string fullWatchedPath;
		private System.Timers.Timer timer;
		private string builtSWF;

		public void CheckAS3(string filename)
		{
			if (flex2Shell == null) UpdateSettings();
			if (!sdkOk) {
				ErrorHandler.ShowInfo("Set the path to the Flex 2 SDK in the program settings.");
				return;
			}
			if (!File.Exists(filename)) return;
			mainForm.CallCommand("Save", null);
			
			try
			{
				mainForm.DispatchEvent(new NotifyEvent(EventType.ProcessStart));
				
				if (ascRunner == null || !ascRunner.isRunning) StartAscRunner();
				mainForm.AddTraceLogEntry("AscShell command: "+filename, -1);
				
				StringBuilder sb = new StringBuilder(filename.Length);
				GetShortPathName(filename, sb, (uint)filename.Length);
				string shortname = sb.ToString().Replace(".AS", ".as");
				
				WatchFile(shortname); //filename);
				
				ASContext.SetStatusText("Asc Running");
				notificationSent = false;
				ascRunner.process.StandardInput.WriteLine("clear");
				ascRunner.process.StandardInput.WriteLine("asc -p "+shortname);
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError("Error while running the AS3 syntax checking.", ex);
			}
		}
		
		public void RunMxmlc(string cmd)
		{
			if (flex2Shell == null) UpdateSettings();
			if (!sdkOk) {
				ErrorHandler.ShowInfo("Set the path to the Flex 2 SDK in the program settings.");
				return;
			}
			// save modified files if needed
			bool check = ASContext.CheckOnSave;
			ASContext.CheckOnSave = false;
			mainForm.CallCommand("SaveAllModified", ".as");
			ASContext.CheckOnSave = check;
			
			try
			{
				mainForm.DispatchEvent(new NotifyEvent(EventType.ProcessStart));
				
				if (mxmlcRunner == null || !mxmlcRunner.isRunning) StartMxmlcRunner();
				
				//cmd = mainForm.ProcessArgString(cmd);
				mainForm.AddTraceLogEntry("MxmlcShell command: "+cmd, -1);
				
				ASContext.SetStatusText("Mxmlc Running");
				notificationSent = false;
				mxmlcRunner.process.StandardInput.WriteLine(cmd);
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError("Error while running the Flex 2 compiler.", ex);
			}
		}
		
		public void QuickBuild(string filename)
		{
			// environment
			string currentPath = Directory.GetCurrentDirectory();
			string buildPath = mainForm.ProcessArgString("@PROJECTDIR");
			if (!Directory.Exists(buildPath) || !filename.ToLower().StartsWith(buildPath.ToLower())) 
			{
				buildPath = Path.GetDirectoryName(filename);
			}
			// command
			builtSWF = Path.Combine(buildPath, Path.GetFileNameWithoutExtension(filename)+".swf");
			bool playAfterBuild = true;
			string cmd = "-o;"+builtSWF+";--;";
			Match mCmd = Regex.Match(ASContext.MainForm.CurSciControl.Text, "\\s@mxmlc\\s(?<cmd>.*)");
			if (mCmd.Success)
			{
				try
				{
					bool hasOutput = false;
					
					// cleanup tag
					string tag = mCmd.Groups["cmd"].Value;
					if (tag.IndexOf("-->") > 0) tag = tag.Substring(0, tag.IndexOf("-->"));
					if (tag.IndexOf("]]>") > 0) tag = tag.Substring(0, tag.IndexOf("]]>"));
					tag = " "+tag.Trim()+" --";
					
					// split
					MatchCollection mPar = re_SplitParams.Matches(tag);
					if (mPar.Count > 0)
					{
						cmd = "";
						string op;
						string arg;
						for(int i=0; i<mPar.Count; i++)
						{
							op = mPar[i].Groups["switch"].Value;
							if (op == "-noplay")
							{
								playAfterBuild = false;
								continue;
							}
							int start = mPar[i].Index+mPar[i].Length;
							int end = (i < mPar.Count-1) ? mPar[i+1].Index : 0;
							if (end > start)
							{
								string concat = ";";
								arg = tag.Substring(start,end-start).Trim();
								if (arg.StartsWith("+=") || arg.StartsWith("=")) 
								{
									concat = arg.Substring(0, arg.IndexOf('=')+1);
									arg = arg.Substring(concat.Length);
								}
								bool isPath = false;
								foreach(string pswitch in PATH_SWITCHES)
								{
									if (pswitch.Replace("--","-") == op)
									{
										isPath = true;
										if (!arg.StartsWith("\\") && !re_Disk.IsMatch(arg))
											arg = ASContext.NormalizeSeparators(Path.Combine(buildPath, arg));
									}
								}
								if (op == "-o" || op == "-output")
								{
									builtSWF = arg;
									hasOutput = true;
								}
								if (!isPath) arg = arg.Replace(" ", ";");
								cmd += op+concat+arg+";";
							}
							else cmd += op+";";
						}
					}
					
					// output default 
					if (!hasOutput) cmd = "-o;"+builtSWF+";"+cmd;
				}
				catch
				{
					ErrorHandler.ShowInfo("The @mxmlc tag seem invalid.");
				}
			}
			// build
			cmd = cmd.Replace(";;", ";");
			RunMxmlc(cmd+filename);
			if (!playAfterBuild) builtSWF = null;
			
			// restaure working directory
			Directory.SetCurrentDirectory(currentPath);
		}
		
		
		/* .p files cleanup */
		
		/// <summary>
		/// Set watcher to remove the .p file
		/// </summary>
		private void WatchFile(string filename)
		{
			string folder = Path.GetDirectoryName(filename);
			watchedFile = Path.GetFileNameWithoutExtension(filename).ToLower()+".p";
			fullWatchedPath = Path.Combine(folder, watchedFile);
			if (File.Exists(fullWatchedPath)) File.Delete(fullWatchedPath);
			watcher.Path = folder;
			watcher.EnableRaisingEvents = true;
		}
		
		private void onCreateFile(object source, FileSystemEventArgs e)
		{
			//if (e.Name.ToLower() == watchedFile)
			if (Path.GetExtension(e.Name).ToLower() == ".p")
			{
				watcher.EnableRaisingEvents = false;
				timer.Enabled = true;
			}
		}
		
		private void onTimedDelete(object source, ElapsedEventArgs e)
		{
			Control ctrl = mainForm.CurDocument as Control;
        	if (ctrl != null && ctrl.InvokeRequired) ctrl.BeginInvoke(new ElapsedEventHandler(onTimedDelete), new object[]{source, e});
        	else
        	{
				if (File.Exists(fullWatchedPath)) 
				{
					File.Delete(fullWatchedPath);
	        		mainForm.AddTraceLogEntry("Done(0)", -2);
					mainForm.DispatchEvent(new NotifyEvent(EventType.ProcessEnd));
					ASContext.SetStatusText("Asc Done");
				}
        	}
		}
		
		
		/* Background process */
		
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
			string cmd = "-classpath \""+Path.Combine(flexPath,"lib")+"\\asc.jar;"+flex2Shell+"\" AscShell";
			mainForm.AddTraceLogEntry("Background process: java "+cmd, -1);
			// run asc shell
			ascRunner = new ProcessRunner();
			ascRunner.Run("java", cmd);
            ascRunner.Output += new LineOutputHandler(ascRunner_Output);
            ascRunner.Error += new LineOutputHandler(ascRunner_Error);
            errorState = 0;
		}
		
		/// <summary>
		/// Start background process
		/// </summary>
		private void StartMxmlcRunner()
		{
			string cmd = "-classpath \""+Path.Combine(flexPath,"lib")+"\\mxmlc.jar;"+flex2Shell+"\" MxmlcShell";
			mainForm.AddTraceLogEntry("Background process: java "+cmd, -1);
			// set current directory to the flex framework files
			string currentPath = Directory.GetCurrentDirectory();
			Directory.SetCurrentDirectory(Path.Combine(flexPath,"frameworks"));
			// run compiler shell
			mxmlcRunner = new ProcessRunner();
			mxmlcRunner.Run("java", cmd);
            mxmlcRunner.Output += new LineOutputHandler(mxmlcRunner_Output);
            mxmlcRunner.Error += new LineOutputHandler(mxmlcRunner_Error);
            errorState = 0;
            // restaure current directory
            Directory.SetCurrentDirectory(currentPath);
		}
		
		/* process output capture */
		
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
                	errorDesc = String.Format("{0}:{1}: {2}", filename, mErr.Groups["line"].Value, errorDesc);
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
        	Control ctrl = mainForm.CurDocument as Control;
        	if (ctrl != null && ctrl.InvokeRequired) ctrl.BeginInvoke(new ProcessOutputHandler(ascRunner_OutputError), new object[]{sender, line});
        	else 
        	{
        		mainForm.AddTraceLogEntry(line, -3);
	        	if (!notificationSent) 
	        	{
	        		notificationSent = true;
	        		ASContext.SetStatusText("Asc Done");
	        		mainForm.AddTraceLogEntry("Done(1)", -2);
	        		mainForm.DispatchEvent(new NotifyEvent(EventType.ProcessEnd));
	        		mainForm.DispatchEvent(new TextEvent(EventType.Command, "ShowResults"));
	        	}
        	}
        }

        private void ascRunner_Output(object sender, string line)
        {
        	if (line.StartsWith("(ash)")) return;
        	Control ctrl = mainForm.CurDocument as Control;
        	if (ctrl != null && ctrl.InvokeRequired) ctrl.BeginInvoke(new ProcessOutputHandler(ascRunner_Output), new object[]{sender, line});
			else mainForm.AddTraceLogEntry(line, 0);
        }
        
        private void mxmlcRunner_Error(object sender, string line)
        {
        	Control ctrl = mainForm.CurDocument as Control;
        	if (ctrl != null && ctrl.InvokeRequired) ctrl.BeginInvoke(new ProcessOutputHandler(mxmlcRunner_Error), new object[]{sender, line});
        	else 
        	{
        		mainForm.AddTraceLogEntry(line, -3);
        	}
        }

        private void mxmlcRunner_Output(object sender, string line)
        {
        	Control ctrl = mainForm.CurDocument as Control;
        	if (ctrl != null && ctrl.InvokeRequired) ctrl.BeginInvoke(new ProcessOutputHandler(mxmlcRunner_Output), new object[]{sender, line});
        	else 
        	{
        		if (!notificationSent && line.StartsWith("Done("))
        		{
        			mainForm.AddTraceLogEntry(line, -2);
        			notificationSent = true;
	        		ASContext.SetStatusText("Mxmlc Done");
	        		mainForm.DispatchEvent(new NotifyEvent(EventType.ProcessEnd));
	        		if (Regex.IsMatch(line, "Done\\([1-9]"))
	        		{
	        			mainForm.DispatchEvent(new TextEvent(EventType.Command, "ShowResults"));
	        		}
	        		else RunAfterBuild();
        		}
        		else mainForm.AddTraceLogEntry(line, 0);
        	}
        }
        
        private void RunAfterBuild()
        {
        	if (builtSWF == null || !File.Exists(builtSWF)) return;
        	string swf = builtSWF;
        	builtSWF = null;
        	
   			// other plugin may handle the SWF playing
			DataEvent dePlay = new DataEvent(EventType.CustomData, "PlaySWF", swf);
			mainForm.DispatchEvent(dePlay);
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
				ErrorHandler.ShowError(ex.Message, ex);
			}
	    }

        
        /* WIN32 */
        
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
	}
}
