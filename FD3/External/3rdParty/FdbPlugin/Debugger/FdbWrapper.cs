using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Windows.Forms;
using ScintillaNet;
using System.Threading;
using PluginCore;
using System.IO;
using System.Text.RegularExpressions;
using ASCompletion.Settings;
using System.Collections;
using PluginCore.PluginCore.Helpers;
using PluginCore.Helpers;

namespace FdbPlugin
{
    public delegate void ContinueEventHandler(object sender, FdbMsg e);
    public delegate void PrintEventHandler(object sender, PrintArg e);
    public delegate void fdbEventHandler(object sender);
    public delegate void TraceEventHandler(object sender, string trace);

    public class FdbWrapper
    {
        public event ContinueEventHandler ContinueEvent;
        public event PrintEventHandler PrintEvent;
        public event ContinueEventHandler LocalValuesEvent;
        public event fdbEventHandler StopEvent;
        public event TraceEventHandler TraceEvent;
        public event fdbEventHandler PauseEvent;
        public event fdbEventHandler ExceptionEvent;
        public event fdbEventHandler PauseNotRespondEvent;
        public event fdbEventHandler StartadlEvent;
        public event fdbEventHandler ConditionErrorEvent;
        public event PrintEventHandler InfoStackEvent;
        public event ContinueEventHandler MoveFrameEvent;

        #region public properties

        public BreakPointManager breakPointManager = null;

        // UI command to execute when fdb prompt is ready
        public string PushCommand;
        public PrintPushArgs PushPrintParams;

        public string Outputfilefullpath
        {
            get { return this.outputfilefullpath; }
            set { this.outputfilefullpath = value; }
        }

        public ProjectManager.Projects.Project CurrentProject
        {
            get { return this.currentProject; }
            set
            {
                this.currentProject = value;
                if (currentProject == null)
                    return;

                if (currentProject.TestMovieCommand != null && currentProject.TestMovieCommand.Contains("adl.exe"))
                {
                    projectType = ProjectType.AIR;
                }
                else
                {
                    projectType = ProjectType.AS3;
                }
            }
        }

        public IContextSettings CurrentSettings
        {
            get { return this.currentSettings; }
            set { this.currentSettings = value; }
        }

        public bool IsDebugStart
        {
            get
            {
                if (process == null)
                    return false;
                else
                    return isDebugStart;
            }
        }

        public FdbState State
        {
            get { return currentfdbState; }
        }

        #endregion

        #region private properties

        private const bool VERBOSE = false;

        private CurrentFileInfo currentFileInfo = new CurrentFileInfo();
        private bool outputstart = false;
        private bool outputend = false;
        private List<string> bufferlist = new List<string>();
        private string flexSDKPath;
        private string fdbPath;
        private Hashtable jvmConfig;
        private Process process;
        private bool isDebugStart = false;
        private bool isprocess = false;

        private ProjectManager.Projects.Project currentProject;
        private IContextSettings currentSettings;

        private string checkstart = string.Empty;
        private string checkend = string.Empty;
        private string outputfilefullpath;

        //test
        enum ProjectType
        {
            AIR,
            AS3
        }

        private int issomecmd = 0;

        private FdbState currentfdbState;
        private ProjectType projectType;

        //key:breakpoint
        private Dictionary<string, FdbBreakPointInfo> breakPointInfoDic = new Dictionary<string, FdbBreakPointInfo>();
        
        //key:output
        private Dictionary<string, MethodInvoker> execdic = new Dictionary<string, MethodInvoker>();

        //key:srcfile num
        private Dictionary<string, SrcFileInfo> srcFileInfoDic = new Dictionary<string, SrcFileInfo>();

        #endregion

        #region regular expressions

        //(fdb) Breakpoint 1: file Test0.as, line 17
        //(fdb) Breakpoint not set; no executable code at line 19 of Test0.as#1
        static Regex RegexSetBreakPoint = null;

        //(fdb) p chi1.
        //$3 = chi1 = [Object 15011577, class='flash.display::Sprite']
        static Regex RegexPrintObject = null;

        //(fdb) $1 = 10 (0xa)
        static Regex RegexPrintVal = null;

        //Variable tmpp unknown
        //Expression could not be evaluated.
        static Regex RegexPrintValUnknown = null;

        //end
        //(fdb) [UnloadSWF] D:\desktop\src\ActionScrip\Test0\bin\Test0.swf
        //Player session terminated
        static Regex RegexUnloadSWF = null;

        //[Fault] exception, information=Error: my error
        //Fault, dy() at Test2.as:21
        // 21                     throw new Error("my error");
        static Regex RegexException = null;

        //Breakpoint 1, Test0$iinit() at Test0.as:17
        //Breakpoint 2, getOra() at Test1.as:19
        //(fdb) Breakpoint 1, Tweener_Test.as:25
        static Regex RegexStopBreakPoint = null;

        static Regex RegexCf = null;

        static Regex RegexShowFiles = null;

        static Regex RegexInfoFunctionsFileInfo = null;
        static Regex RegexInfoFunctionsFunctionInfo = null;

        static Regex RegexDisply =null;
        
        static Regex RegexUnknownCommand = null;

        //add
        static Regex RegexStack = null;

        //add
        //#1   Tweener_Test() å ´æ‰€ :  Tweener_Test.as#1:11
        //#1   Tweener_Test() at Tweener_Test.as#1:11
        static Regex RegexFrame =null;

        //add
        static Regex RegexDelPrompt = new Regex(@"^(\(fdb\) )", RegexOptions.Compiled);

        //(fdb) [trace] ....
        static Regex RegexTrace = null;
        
        //(fdb) Player did not respond to the command as expected; command aborted.
        static Regex RegexNotRespond = null;

        static Regex RegexTerminated = null;

        //pause
        //Execution halted 000095c6at 0xExecution halted 000095c6 (38342)
        //Execution halted in 'test.swf' ffffffffat 0xExecution halted in 'test.swf' ffffffff (-1)
        static Regex RegexPause = null;
       
        //[SWF] D:\ActionScrip\Test0\bin\Test0.swf - 2,931 bytes after decompression
        static Regex RegexLoadSWF = null;
        static Regex RegexCheckStart = null;
     
        //(fdb) Additional ActionScript code has been loaded from a SWF or a frame.
        static Regex RegexLoadSWForFrame = null;

        static Regex RegexAskCondition = null;

        //Breakpoint 2 now unconditional.
        //ãƒ–ãƒ¬ãƒ¼ã‚¯ãƒã‚¤ãƒ³ãƒˆ 2 ãŒè§£é™¤ã•ã‚Œã¾ã—ãŸã€‚
        static Regex RegexClearCondition = null;

        static Regex RegexFinishError = null;

        static string UnknownCommandFormat = null;// = "Unknown command '{0}', ignoring it";

        #endregion

        public FdbWrapper()
        {
            init();
        }

        private void init()
        {
            execdic.Add("stop_breakpoint", exit_Continue);

            execdic.Add(getendtcmd("NonCmd"), exit_Non);
            execdic.Add(getendtcmd("info locals"), exit_infolocals);
            execdic.Add(getendtcmd("print"), exit_Non);
            execdic.Add(getendtcmd("clearbreakpoint"), exit_ClearBreakPoint);
            execdic.Add(getendtcmd("show files"), exit_showfiles);
            execdic.Add(getendtcmd("info functions"), exit_infofunctions);
            execdic.Add(getendtcmd("cf"), exit_cf);
            execdic.Add(getendtcmd("continue"), exit_Continue);
            execdic.Add(getendtcmd("delete"), exit_DeleteBreakPoint);

            execdic.Add(getendtcmd("info stack"), delegate
            {
                if (InfoStackEvent != null)
                {
                    PrintArg arg = new PrintArg(string.Empty, new List<string>(bufferlist));
                    InfoStackEvent(this, arg);
                }
            });

            execdic.Add(getendtcmd("frame"), exit_frame);
            execdic.Add(getendtcmd("break"), exit_Non);
        }

        /// <summary>
        /// Main loop
        /// </summary>
        public void Start()
        {
            isprepause = false;
            isunload = false;
            bufferlist.Clear();

            initFlexSDK();

            currentfdbState = FdbState.INIT;
            if (projectType == ProjectType.AIR)
            {
                FdbPluginTrace.TraceInfo("AIR fdb ProcessStart()");
                ProcessStart();
                process.StandardInput.WriteLine("run");
                if (StartadlEvent != null)
                    StartadlEvent(this);
            }
            else
            {
                FdbPluginTrace.TraceInfo("fdb ProcessStart()");
                ProcessStart('"' + outputfilefullpath + '"');
            }

            while (true)
            {
                if (currentfdbState == FdbState.INIT)
                {
                    Thread.Sleep(10);
                    //Application.DoEvents();
                }
                else
                    break;
            }

            FdbPluginTrace.TraceInfo("fdbState.START");

            if (bufferlist.Count == 0 || !RegexCheckStart.IsMatch(bufferlist[0]))
            {
                throw new Exception("Unable to start Flex SDK interactive debugger (fdb).");
            }

            cmd_showfiles();
            waitCommandFinish();

            CheckBreakPoint();
            List<BreakPointInfo> breakPointList;
            List<BreakPointCondition> breakPointConditionList;
            breakPointManager.GetBreakPoints(out breakPointList, out breakPointConditionList);

            if (breakPointList.Count > 0)
            {
                cmd_Break(breakPointList);
                waitSomeCommandFinish();
            }

            FdbPluginTrace.TraceInfo("start cmd_Break() end");

            cmd_Condition(breakPointConditionList);
            waitSomeCommandFinish();

            if (breakPointManager.IsConditionError)
            {
                currentfdbState = FdbState.CONDITIONERROR;
                if (ConditionErrorEvent != null)
                    ConditionErrorEvent(this);
            }
            else
            {
                //disp
                cmd_Display("stop_breakpoint");

                cmd_Continue();
                waitCommandFinish();

                FdbPluginTrace.TraceInfo("start cmd_Countnue() end");

                //PreLoad
                if (currentfdbState == FdbState.PRELOAD)
                {
                    cmd_showfiles();
                    waitCommandFinish();

                    FdbPluginTrace.TraceInfo("fdbState.PRELOAD");

                    CheckBreakPoint();
                    breakPointManager.GetBreakPoints(out breakPointList, out breakPointConditionList);
                    if (breakPointList.Count > 0)
                    {
                        cmd_DeleteBreakPoint();
                        waitCommandFinish();
                        FdbPluginTrace.TraceInfo("start preload cmd_Delete() end");

                        cmd_Break(breakPointList);
                        waitSomeCommandFinish();
                        FdbPluginTrace.TraceInfo("start preload cmd_Break() end");

                        cmd_Condition(breakPointConditionList);
                        waitSomeCommandFinish();
                    }
                    cmd_Continue();
                    waitCommandFinish();
                    FdbPluginTrace.TraceInfo("start preload cmd_Countnue() end");
                }

                HandleExecutionBreak();
                /*if (currentfdbState == FdbState.EXCEPTION
                    || currentfdbState == FdbState.BREAK)
                {
                    UpDateCurrentFileInfo();

                    FdbMsg msg = new FdbMsg();
                    msg.SetParam(currentFileInfo.filefullpath, currentFileInfo.filename, currentFileInfo.line, false);
                    if (ContinueEvent != null)
                        ContinueEvent(this, msg);
                }*/
            }

            FdbPluginTrace.TraceInfo("fdbWrapper.Start() end");
            FdbPluginTrace.TraceInfo("fdbWrapper.State = " + State.ToString());

            PushCommand = "Start";
            while (true)
            {
                if (PushCommand != null)
                {
                    string cmd = PushCommand;
                    PushCommand = null;
                    switch (cmd)
                    {
                        case "Start": break;
                        case "ExceptionContinue": ExceptionContinue(); continue;
                        case "Next": Next(); break;
                        case "Step": Step(); break;
                        case "Continue": Continue(); continue;
                        case "Pause": Pause(); continue;
                        case "Finish": Finish(); break;
                        case "Stop": return;
                        case "Print": Print(PushPrintParams); PushPrintParams = null; break;
                        case "HandleStopBreak":
                        case "HandleException":
                        case "HandleBreak":
                            HandleExecutionBreak(); break;
                    }

                    if (State != FdbState.CONDITIONERROR
                        && State != FdbState.PAUSE_SET_BREAKPOINT
                        && State != FdbState.CONTINUE
                        && State != FdbState.UNLOAD)
                    {
                        UpdateInfos();
                    }
                }
                else
                {
                    Thread.Sleep(10);
                    continue;
                }
            }
        }

        private void HandleExecutionBreak()
        {
            if (currentfdbState == FdbState.EXCEPTION
                || currentfdbState == FdbState.NEXT
                || currentfdbState == FdbState.STEP
                || currentfdbState == FdbState.BREAK)
            {
                CurrentFileInfo cinfo = currentFileInfo != null ? (CurrentFileInfo)currentFileInfo.Clone() : null;
                UpDateCurrentFileInfo();
                FdbMsg msg = new FdbMsg();
                msg.SetParam(currentFileInfo.filefullpath, currentFileInfo.filename, currentFileInfo.line, isScopeJump(cinfo, currentFileInfo));
                if (ContinueEvent != null)
                    ContinueEvent(this, msg);
            }
        }

        public void Cleanup()
        {
            isunload = true;
            isprocess = false;
            currentfdbState = FdbState.UNLOAD;
            try
            {
                if (process != null && !process.HasExited) process.Kill();
            }
            catch { }
        }

        public void Stop(string ProcessName, bool CheckStop)
        {
            DialogResult res;
            if (!CheckStop)
                res = DialogResult.OK;
            else
                res = MessageBox.Show(string.Format("Close {0} ?", ProcessName), "", MessageBoxButtons.OKCancel);

            if (res == DialogResult.OK)
            {
                FdbPluginTrace.TraceInfo("ProcessStop(string ProcessName, bool CheckStop) process.StandardInput.Close();");

                Process[] allProcesses = Process.GetProcessesByName(ProcessName);
                Process closeprocess = null;
                foreach (Process oneProcess in allProcesses)
                {
                    if (oneProcess.MainWindowHandle != IntPtr.Zero)
                    {
                        closeprocess = oneProcess;
                        break;
                    }
                }

                if (closeprocess == null)
                {
                    try
                    {
                        process.StandardInput.WriteLine("quit");
                        process.StandardInput.WriteLine("y");
                    }
                    catch { }
                }
                else
                {
                    if (currentfdbState == FdbState.BREAK
                        || currentfdbState == FdbState.STEP
                        || currentfdbState == FdbState.NEXT
                        || currentfdbState == FdbState.PAUSE
                        || currentfdbState == FdbState.PAUSE_SET_BREAKPOINT)
                    {
                        currentfdbState = FdbState.UNLOAD;
                        process.StandardInput.WriteLine("quit");
                        process.StandardInput.WriteLine("y");
                    }
                    else
                    {
                        currentfdbState = FdbState.UNLOAD;
                        if (closeprocess.Responding)
                        {
                            closeprocess.CloseMainWindow();
                        }
                        else
                        {
                            process.StandardInput.WriteLine("quit");
                            process.StandardInput.WriteLine("y");
                        }
                    }
                }
            }
        }

        private void ProcessStop()
        {
            isunload = true;
            isprocess = false;
            currentfdbState = FdbState.UNLOAD;

            if(projectType == ProjectType.AIR)
            {
                FdbPluginTrace.TraceInfo("AIR ProcessStop() quit");
                process.StandardInput.WriteLine("quit");
                process.StandardInput.WriteLine("y");
            }
            else
            {
                FdbPluginTrace.TraceInfo("ProcessStop() process.StandardInput.Close();");
                process.StandardInput.Close();
            }
        }

        public void ExceptionContinue()
        {
            isprepause = false;

            List<BreakPointInfo> breakPointList;
            List<BreakPointCondition> breakPointConditionList;
            breakPointManager.GetChangedBreakPoint(out breakPointList, out breakPointConditionList);

            cmd_Break(breakPointList);
            waitSomeCommandFinish();

            cmd_Condition(breakPointConditionList);
            waitSomeCommandFinish();

            currentfdbState = FdbState.CONTINUE;
            writeStartCommand(getstartcmd("continue"));
            writeCommand("continue");
            if (ExceptionEvent != null)
                ExceptionEvent(this);
            writeEndCommand(getendtcmd("continue"));
            //waitCommandFinish();

            /*if (currentfdbState == FdbState.EXCEPTION)
            {
                CurrentFileInfo cinfo = (CurrentFileInfo)currentFileInfo.Clone();
                UpDateCurrentFileInfo();

                FdbMsg msg = new FdbMsg();
                msg.SetParam(currentFileInfo.filefullpath, currentFileInfo.filename, currentFileInfo.line, isScopeJump(cinfo, currentFileInfo));
                if (ContinueEvent != null)
                    ContinueEvent(this, msg);
            }*/
        }

        private Boolean isScopeJump(CurrentFileInfo c1, CurrentFileInfo c2)
        {
            if (c1 == null) return false;
            return c1.filefullpath != c2.filefullpath || c1.function != c2.function;
        }

        public void Continue()
        {
            isprepause = false;

            List<BreakPointInfo> breakPointList;
            List<BreakPointCondition> breakPointConditionList;
            breakPointManager.GetChangedBreakPoint(out breakPointList, out breakPointConditionList);

            cmd_Break(breakPointList);
            waitSomeCommandFinish();

            cmd_Condition(breakPointConditionList);
            waitSomeCommandFinish();

            cmd_Continue();
            //waitCommandFinish();
        }

        public void Step()
        {
            CurrentFileInfo cinfo = (CurrentFileInfo)currentFileInfo.Clone(); 

            //currentfdbState = FdbState.STEP;
            cmd_Step();
            waitCommandFinish();

            UpDateCurrentFileInfo();

            if (currentFileInfo.function == "global$init")
            {
                while (currentFileInfo.function == "global$init")
                {
                    cmd_Step();
                    waitCommandFinish();
                    UpDateCurrentFileInfo();
                }

                cmd_Step();
                waitCommandFinish();
            }

            HandleExecutionBreak();
            /*if (currentfdbState == FdbState.EXCEPTION 
                || currentfdbState == FdbState.STEP
                || currentfdbState == FdbState.BREAK)
            {
                UpDateCurrentFileInfo();

                FdbMsg msg = new FdbMsg();
                msg.SetParam(currentFileInfo.filefullpath, currentFileInfo.filename, currentFileInfo.line, isScopeJump(cinfo, currentFileInfo));
                if (ContinueEvent != null)
                    ContinueEvent(this, msg);
            }*/

            UpdateInfos();
        }

        public void Next()
        {
            CurrentFileInfo cinfo = (CurrentFileInfo)currentFileInfo.Clone();

            //currentfdbState = FdbState.NEXT;
            cmd_Next();
            waitCommandFinish();

            HandleExecutionBreak();
            /*if (currentfdbState == FdbState.EXCEPTION
                || currentfdbState == FdbState.NEXT
                || currentfdbState == FdbState.BREAK)
            {
                UpDateCurrentFileInfo();

                FdbMsg msg = new FdbMsg();
                msg.SetParam(currentFileInfo.filefullpath, currentFileInfo.filename, currentFileInfo.line, isScopeJump(cinfo, currentFileInfo));
                if (ContinueEvent != null)
                    ContinueEvent(this, msg);
            }*/

            UpdateInfos();
        }

        private void UpdateInfos()
        {
            InfoLocals();
            FdbPluginTrace.TraceInfo("Step() fdbWrapper.InfoLocals(); end");
            //UpdatelocalVariablesLeaf();
            FdbPluginTrace.TraceInfo("Step() UpdatelocalVariablesLeaf(); end");

            /*if (stackframePanel.DockState != DockState.Hidden)
            {
                fdbWrapper.InfoStack();
            }*/
        }

        public void InfoLocals()
        {
            //waitCommandFinish();
            switch (currentfdbState)
            {
                case FdbState.START:
                    //cmd_Continue();
                    break;
                case FdbState.UNLOAD:
                case FdbState.PAUSE:
                    return;
                default:
                    cmd_InfoLocals();
                    break;
            }
        }

        private bool isprepause = false;
        public void Pause()
        {
            isprepause = true;
            cmd_Pause();
        }

        public void Finish()
        {
            cmd_Finish();
            waitCommandFinish();

            CurrentFileInfo cinfo = (CurrentFileInfo)currentFileInfo.Clone();
            UpDateCurrentFileInfo();

            FdbMsg msg = new FdbMsg();
            msg.SetParam(currentFileInfo.filefullpath, currentFileInfo.filename, currentFileInfo.line, isScopeJump(cinfo, currentFileInfo));
            if (ContinueEvent != null)
                ContinueEvent(this, msg);

            //UpdateInfos();
        }

        public void DeleteAllBreakPoints()
        {
            cmd_DeleteBreakPoint();
            waitCommandFinish();
            FdbPluginTrace.TraceInfo("DeleteAllBreakPoints() cmd_Delete(); end");
        }

        private bool initFlexSDK()
        {
            flexSDKPath = AS3Context.PluginMain.Settings.FlexSDK;

            flexSDKPath = PathHelper.ResolvePath(flexSDKPath, Path.GetDirectoryName(currentProject.ProjectPath));
            if (flexSDKPath != null && Directory.Exists(flexSDKPath))
            {
                if (flexSDKPath.EndsWith("bin", StringComparison.OrdinalIgnoreCase))
                    flexSDKPath = Path.GetDirectoryName(flexSDKPath);

                fdbPath = Path.Combine(flexSDKPath, "lib\\fdb.jar");
                jvmConfig = JvmConfigHelper.ReadConfig(Path.Combine(flexSDKPath, "bin\\jvm.config"));
                return true;
            }
            else return false;
        }

        private void ProcessStart()
        {
            ProcessStart(null);
        }

        private void ProcessStart(string outputfile)
        {
            process = new Process();
            
            process.StartInfo.FileName = JvmConfigHelper.GetJavaEXE(jvmConfig);
            string args = process.StartInfo.Arguments = jvmConfig["java.args"] +
                " -Dapplication.home=\"" + flexSDKPath + "\" -jar \"" + fdbPath + "\" ";
            if (outputfile != null) args += outputfile;
            process.StartInfo.Arguments = args;

            process.StartInfo.UseShellExecute = false;
            process.StartInfo.RedirectStandardInput = true;
            process.StartInfo.RedirectStandardOutput = true;
            process.StartInfo.RedirectStandardError = true;
            process.StartInfo.CreateNoWindow = true;
            process.EnableRaisingEvents = true;
            process.OutputDataReceived += new DataReceivedEventHandler(process_OutputDataReceived);
            process.Exited += new EventHandler(process_Exited);
            process.Start();
            process.BeginOutputReadLine();
        }

        void process_OutputDataReceived(object sender, DataReceivedEventArgs e)
        {
            if (e.Data == null) return;
            if (VERBOSE && TraceEvent != null) TraceEvent(this, e.Data);
            FdbPluginTrace.Trace(e.Data);
            Match m;

            if ((m = RegexUnknownCommand.Match(e.Data)).Success)
            {
                string cmd = m.Groups["command"].Value;
                if (cmd == checkstart)
                {
                    outputstart = true;
                    outputend = false;
                    bufferlist.Clear();
                }
                else if (execdic.ContainsKey(cmd))
                {
                    outputstart = false;
                    outputend = true;
                    if(bufferlist.Count>0) bufferlist[0] = deletefdbPrompt(bufferlist[0]);
                    execdic[cmd]();
                    isprocess = false;
                }
            }
            else if (RegexTerminated.IsMatch(e.Data))
            {
                outputstart = false;
                outputend = true;
                isprocess = false;
                ProcessStop();
            } 
            else
            {
                if (outputstart)
                {
                    if (RegexTrace.IsMatch(e.Data))
                    {
                        if (TraceEvent != null)
                            TraceEvent(this, e.Data);
                    }
                    else if ((m = RegexDisply.Match(e.Data)).Success)
                    {
                        string cmd = m.Groups["command1"].Value;
                        if (execdic.ContainsKey(cmd))
                        {
                            outputstart = false;
                            outputend = true;
                            execdic[cmd]();
                            isprocess = false;
                        }
                    }
                    else if (RegexPause.IsMatch(e.Data))
                    {
                        isprepause = true;
                        outputstart = false;
                        outputend = true;
                        exit_Pause();
                    }
                    else if (RegexNotRespond.IsMatch(e.Data)
                        && currentfdbState == FdbState.PAUSE)
                    {
                        if (PauseNotRespondEvent != null)
                            PauseNotRespondEvent(this);
                    }
                    else if (RegexLoadSWForFrame.IsMatch(e.Data))
                    {
                        currentfdbState = FdbState.PRELOAD;
                        outputstart = false;
                        outputend = true;
                        isprocess = false;
                    }
                    else if (RegexFinishError.IsMatch(e.Data))
                    {
                        outputstart = false;
                        outputend = true;
                        exit_Continue();
                        isprocess = false;
                    }
                    else if (RegexAskCondition.IsMatch(e.Data))
                    {
                        outputstart = false;
                        outputend = true;
                        exit_Condition(0);
                        isprocess = false;
                    }
                    else
                    {
                        bufferlist.Add(e.Data);
                        outputend = true;
                    }
                }
                else if (RegexLoadSWF.IsMatch(e.Data))
                {
                    bufferlist.Add(e.Data);
                    isDebugStart = true;
                    currentfdbState = FdbState.START;
                }
            }
        }

        void process_Exited(object sender, EventArgs e)
        {
            outputstart = false;
            outputend = true;
            isprocess = false;
            currentfdbState = FdbState.UNLOAD;

            waitCommandFinish();

            try
            {
                process.Close();
                FdbPluginTrace.TraceInfo("process_Exited() process.Close(); end");
            }
            finally
            {
                process.Dispose();
                breakPointInfoDic.Clear();

                isDebugStart = false;

                if (StopEvent != null)
                    StopEvent(this);

                FdbPluginTrace.TraceInfo("process_Exited(); end");
            }
        }

        private void waitCommandFinish()
        {
            while (true)
            {
                if (isprocess && currentfdbState != FdbState.UNLOAD)
                {
                    Thread.Sleep(10);
                    //Application.DoEvents();
                }
                else
                    break;
            }
        }

        private void waitSomeCommandFinish()
        {
            while (true)
            {
                if (issomecmd > 0)
                {
                    Thread.Sleep(10);
                    //Application.DoEvents();
                }
                else
                {
                    isprocess = false;
                    break;
                }
            }
        }
        
        private string getUnknownCommandOutput(string cmd)
        {
            return string.Format(UnknownCommandFormat, cmd);
        }

        private string getstartcmd(string cmd)
        {
            string command = cmd.Trim();
            return command.Replace(" ", "_") + "_start";
        }
        private string getendtcmd(string cmd)
        {
            string command = cmd.Trim();
            return command.Replace(" ", "_") + "_end";
        }

        private void writeStartCommand(string cmd)
        {
            waitCommandFinish();

            isprocess = true;
            checkstart = cmd;
            process.StandardInput.WriteLine(cmd);
        }

        private void writeCommand(string cmd)
        {

            while (true)
            {
                if (!outputstart && currentfdbState != FdbState.UNLOAD)
                {
                    Thread.Sleep(10);
                    //Application.DoEvents();
                }
                else
                    break;
            }

            if (currentfdbState == FdbState.UNLOAD) return;

            if (VERBOSE && TraceEvent != null) TraceEvent(this, "-> " + cmd);
            process.StandardInput.WriteLine(cmd);
        }

        private void writeEndCommand(string cmd)
        {
            while (true)
            {
                if (!outputend && isprocess)
                {
                    Thread.Sleep(10);
                    //Application.DoEvents();
                }
                else
                    break;
            }

            if (isprepause && !isunload)
            {
                isprepause = false;
                return;
            }

            process.StandardInput.WriteLine(cmd);
        }

        private void inputCommand(string cmd)
        {
            inputCommand(cmd, cmd);
        }

        private void inputCommand(string cmd, string start_endCmd)
        {
            if (currentfdbState == FdbState.UNLOAD)
            {
                return;
            }

            writeStartCommand(getstartcmd(start_endCmd));
            writeCommand(cmd);
            writeEndCommand(getendtcmd(start_endCmd));
        }

        private void inputCommand_WithoutEndCommand(string cmd)
        {
            if (currentfdbState == FdbState.UNLOAD)
            {
                return;
            }

            writeStartCommand(getstartcmd(cmd));
            writeCommand(cmd);
        }

        private void inputCommand_NotWaitOutput(string cmd, string start_endCmd)
        {
            if (currentfdbState == FdbState.UNLOAD)
            {
                return;
            }

            writeStartCommand(getstartcmd(start_endCmd));
            writeCommand(cmd);
            outputend = true;
            writeEndCommand(getendtcmd(start_endCmd));
        }
        
        private void cmd_Break(List<BreakPointInfo> list)
        {
            issomecmd = list.Count;
            foreach (BreakPointInfo info in list)
            {
                string filefullpath = info.FileFullPath;
                SrcFileInfo sfinfo = null;
                foreach (SrcFileInfo srcinfo in srcFileInfoDic.Values)
                {
                    if (srcinfo.filefullpath == filefullpath)
                    {
                        sfinfo = srcinfo;
                        break;
                    }
                }
                if (sfinfo == null) continue;

                waitCommandFinish();
                if (!info.Enable || info.IsDelete)
                {
                    execdic[getendtcmd("break")] = delegate
                    {
                        issomecmd--;                     
                    };
                    cmd_ClearBreakPoint(sfinfo.num, info.Line);
                }
                else
                {
                    execdic[getendtcmd("break")] = delegate
                    {
                        exit_Break(sfinfo.num);

                    };
                    cmd_Break(sfinfo.num, info.Line);
                }
            }
        }

        private void cmd_Break(string srcfilenum, int line)
        {
            if (currentfdbState == FdbState.UNLOAD)
            {
                return;
            }
            writeStartCommand(getstartcmd("break"));
            writeCommand(string.Format("break #{0}:{1}", srcfilenum, line));
            writeEndCommand(getendtcmd("break"));
        }

        private void exit_Break(string srcfilenum)
        {
            string buf = bufferlist[0];
            Match m = null;
            if ((m = RegexSetBreakPoint.Match(buf)).Success)
            {
                string breakpointnum = m.Groups["breakpoint"].Value.Trim();
                string filename = m.Groups["filename"].Value;
                int line = int.Parse(m.Groups["line"].Value);

                string filefullpath = srcFileInfoDic[srcfilenum].filefullpath;

                if (!breakPointInfoDic.ContainsKey(breakpointnum))
                {
                    breakPointInfoDic.Add(breakpointnum, new FdbBreakPointInfo(filefullpath, filename, breakpointnum, line));
                }
            }
            issomecmd--;
        }

        private void cmd_ClearBreakPoint(string srcfilenum, int line)
        {
            inputCommand_NotWaitOutput(string.Format("clear #{0}:{1}", srcfilenum, line), "clearbreakpoint");
        }
        private void exit_ClearBreakPoint()
        {
            issomecmd--;
        }
        private void cmd_Continue()
        {
            currentfdbState = FdbState.CONTINUE;
            inputCommand_WithoutEndCommand("continue");
        }
        private bool isunload = false;
        private void exit_Continue()
        {
            string buf = string.Empty;
            if(bufferlist.Count >0)
                buf = bufferlist[0];

            if (RegexUnloadSWF.IsMatch(buf))
            {       
                ProcessStop();
            }
            else if (RegexStopBreakPoint.IsMatch(buf))
            {
                currentfdbState = FdbState.BREAK;
                PushCommand = "HandleStopBreak";
            }
            else if (RegexException.IsMatch(buf))
            {
                currentfdbState = FdbState.EXCEPTION;
                foreach (string s in bufferlist)
                {
                    TraceEvent(this, s);
                }
                PushCommand = "HandleException";
            }
            else
            {
                currentfdbState = FdbState.BREAK;
                PushCommand = "HandleBreak";
            }
        }

        private void cmd_Step()
        {
            currentfdbState = FdbState.STEP;
            inputCommand_WithoutEndCommand("step");
        }

        private void cmd_Next()
        {
            currentfdbState = FdbState.NEXT;
            inputCommand_WithoutEndCommand("next");
        }

        private void cmd_Finish()
        {
            inputCommand_WithoutEndCommand("finish");
        }

        private void exit_Non()
        {
        }

        List<string> LocalExpandUpDateBuffer = new List<string>();

        public void Print(PrintPushArgs printPush)
        {
            if (printPush == null) 
                return;
            if (printPush.objnames != null)
                Print(printPush.sender, printPush.objnames, printPush.option);
            else 
                Print(printPush.sender, printPush.objname, printPush.option);
        }

        public void Print(object sender, string objname)
        {
            cmd_Print(sender, objname, null);
        }
        public void Print(object sender, string objname, object option)
        {
            cmd_Print(sender, objname, option);
        }
        public void Print(object sender, string[] objnames)
        {
            Print(sender, objnames, null);
        }
        public void Print(object sender, string[] objnames, object option)
        {
            issomecmd = objnames.Length;
            LocalExpandUpDateBuffer.Clear();
            foreach (string objname in objnames)
            {
                waitCommandFinish();

                execdic[getendtcmd("print")] = delegate
                {
                    exit_Print(objname);
                };

                inputCommand(string.Format("print {0}", objname), "print");
            }
            waitSomeCommandFinish();
            if (PrintEvent != null)
            {
                PrintArg arg = new PrintArg("objname", LocalExpandUpDateBuffer, option);
                PrintEvent(sender, arg);
            }
        }

        private void cmd_Print(object sender, string objname, object option)
        {
            waitCommandFinish();

            execdic[getendtcmd("print")] = delegate
            {
                exit_Print(sender, objname, option);
            };

            inputCommand(string.Format("print {0}", objname), "print");
        }

        private void exit_Print(object sender, string objname, object option)
        {
            string buf = bufferlist[0];
            Match m = null;
            if (RegexPrintValUnknown.IsMatch(buf))
            {
                bufferlist.Clear();
            }
            else
            {
                if (bufferlist.Count == 1)
                {
                    if ((m = RegexPrintObject.Match(buf)).Success)
                    {
                        bufferlist[0] = string.Format("{0} = {1}", objname, "unknown");
                    }
                    else if ((m = RegexPrintVal.Match(buf)).Success)
                    {
                        bufferlist[0] = string.Format("{0} = {1}", objname, m.Groups["value"].Value);
                    }
                }
                else
                {
                    if ((m = RegexPrintObject.Match(buf)).Success)
                    {
                        bufferlist.RemoveAt(0);
                    }
                }
            }

            PrintArg arg = new PrintArg(objname, bufferlist, option);
            if (PrintEvent != null)
                PrintEvent(sender, arg);
        }


        private void exit_Print(string objname)
        {
            string buf = bufferlist[0];
            Match m = null;
            if ((m = RegexPrintValUnknown.Match(buf)).Success) return;

            if (bufferlist.Count == 1)
            {
                if ((m = RegexPrintObject.Match(buf)).Success)
                {
                    //unknown
                    bufferlist[0] = string.Format("{0} = {1}", objname, "unknown");
                }
                else if ((m = RegexPrintVal.Match(buf)).Success)
                {
                    bufferlist[0] = string.Format("{0} = {1}", objname, m.Groups["value"].Value);
                }
            }
            else
            {
                if ((m = RegexPrintObject.Match(buf)).Success)
                {
                    bufferlist.RemoveAt(0);
                }
            }

            foreach (string tmp in bufferlist)
            {
                LocalExpandUpDateBuffer.Add(objname + tmp.Trim());
            }
            issomecmd--;
        }

        private void cmd_InfoLocals()
        {
            inputCommand("info locals");
        }
        private void exit_infolocals()
        {
            FdbMsg msg = new FdbMsg();
            msg.output = new List<string>(bufferlist);
            if (LocalValuesEvent != null)
                LocalValuesEvent(this, msg);
        }

        private void cmd_Pause()
        {
            currentfdbState = FdbState.PAUSE;
            process.StandardInput.WriteLine("dummy_cmd");
            process.StandardInput.WriteLine("y");
        }
        private void exit_Pause()
        {
            currentfdbState = FdbState.PAUSE_SET_BREAKPOINT;
            if (PauseEvent != null)
                PauseEvent(this);
            isprocess = false;
        }

        private void cmd_DeleteBreakPoint()
        {
            if(breakPointInfoDic.Count==0) return;

            string arg = string.Empty;
            foreach (string breakpointnum in breakPointInfoDic.Keys)
            {
                arg += " " + breakpointnum;
            }

            inputCommand_NotWaitOutput("delete" + arg, "delete");
        }
        private void exit_DeleteBreakPoint()
        {
            breakPointInfoDic.Clear();
        }

        private void cmd_Condition(string breakpointNum, string exp)
        {
            waitCommandFinish();

            execdic["y"] = delegate
            {
                exit_Condition(int.Parse(breakpointNum));
            };

            isprocess = true;
            checkstart = getstartcmd("condition");
            outputstart = true;
            process.StandardInput.WriteLine(checkstart);
            while (true)
            {
                if (!outputstart && currentfdbState != FdbState.UNLOAD)
                {
                    Thread.Sleep(10);
                    //Application.DoEvents();
                }
                else
                    break;
            }
            if (currentfdbState == FdbState.UNLOAD) return;

            writeCommand(string.Format("condition {0} {1}", breakpointNum, exp));
            process.StandardInput.WriteLine("y");
        }
        private void cmd_Condition(List<BreakPointCondition> list)
        {
            breakPointManager.ClearConditionError();

            List<BreakPointCondition> cmdlist = new List<BreakPointCondition>();
            foreach (BreakPointCondition cond in list)
            {
                foreach(string key in breakPointInfoDic.Keys)
                {
                    FdbBreakPointInfo val = breakPointInfoDic[key];
                    if (val.FileFullPath == cond.FileFullPath && val.BreakPoinLine == cond.Line)
                    {
                        cond.BreakPointNum = key;
                        cmdlist.Add(cond);
                        break;
                    }
                }
            }
            issomecmd = cmdlist.Count;

            foreach (BreakPointCondition cond in cmdlist)
            {
                cmd_Condition(cond.BreakPointNum, cond.Exp);
            }
        }

        private void exit_Condition(int breakpointnum)
        {
            if (breakpointnum > 0 && bufferlist.Count > 0
                && !RegexClearCondition.IsMatch(bufferlist[0]))
            {
                string f = breakPointInfoDic[breakpointnum.ToString()].FileFullPath;
                int line = breakPointInfoDic[breakpointnum.ToString()].BreakPoinLine;
                breakPointManager.AddConditionError(f, line);
            }
            issomecmd--;
        }

        private void cmd_Display(string cmd)
        {
            if (VERBOSE && TraceEvent != null) TraceEvent(this, "-> " + "display");
            process.StandardInput.WriteLine(string.Format("display '{0}'", cmd));
        }

        private string getFunction(string filenum, int line)
        {
            string res = string.Empty;
            if (srcFileInfoDic.ContainsKey(filenum))
            {
                SrcFileInfo info = srcFileInfoDic[filenum];
                res = info.GetFunction(line);
            }          
            return res;
        }

        private void cmd_infofunctions()
        {
            issomecmd = srcFileInfoDic.Count;
            foreach (SrcFileInfo info in srcFileInfoDic.Values)
            {
                cmd_infofunctions(info.num);
            }
        }
        private void cmd_infofunctions(string num)
        {
            waitCommandFinish();
            inputCommand(string.Format("info functions #{0}", num), "info functions");
        }
        private void exit_infofunctions()
        {
            //(fdb) info functions #1
            //Functions in Test0.as#1
            // Test0 15
            // global$init 13
            SrcFileInfo info = null;
            Match m = RegexInfoFunctionsFileInfo.Match(bufferlist[0]);
            if (m.Success)
            {
                string num = m.Groups["num"].Value;
                if (srcFileInfoDic.ContainsKey(num))
                {
                    info = srcFileInfoDic[num];
                }
            }

            if (info != null)
            {
                info.functionInfoList.Clear();
                bufferlist.RemoveAt(0);
                foreach (string line in bufferlist)
                {
                    if ((m = RegexInfoFunctionsFunctionInfo.Match(line)).Success)
                    {
                        string function = m.Groups["function"].Value;
                        int startline = int.Parse(m.Groups["line"].Value);
                        info.functionInfoList.Add(new FunctionInfo(function, startline));
                    }
                }

                info.SortFunction();
            }

            issomecmd--;
        }

        private void cmd_showfiles()
        {
            inputCommand("show files");
        }
        private void exit_showfiles()
        {
            srcFileInfoDic.Clear();
            //1 C:\workspace\src\C#\flashdevelop\ActionScrip\Test0\src\Test0.as, Test0.as
            //2 C:\workspace\src\C#\flashdevelop\ActionScrip\Test0\src\Test1.as, Test1.as
            foreach (string line in bufferlist)
            {
                Match m;
                if ((m = RegexShowFiles.Match(line)).Success)
                {
                    string num = m.Groups["num"].Value;
                    string filefullpath = m.Groups["filefullpath"].Value;
                    if(File.Exists(filefullpath))
                        srcFileInfoDic.Add(num, new SrcFileInfo(num, filefullpath));
                }
            }
        }

        private void UpDateCurrentFileInfo()
        {
            string prefullpath = currentFileInfo.filefullpath;
            int preline = currentFileInfo.line;

            cmd_cf();
            waitCommandFinish();

            SrcFileInfo sfinfo = null;
            foreach (SrcFileInfo info in srcFileInfoDic.Values)
            {
                if (info.filefullpath == currentFileInfo.filefullpath)
                {
                    sfinfo = info;
                    break;
                }
            }
            if (sfinfo == null)
            {
                throw new SourceNotFoundException(currentFileInfo.filename, prefullpath, preline);
            }
            if (sfinfo.functionInfoList.Count == 0)
            {
                cmd_infofunctions(sfinfo.num);
                waitCommandFinish();
            }
            currentFileInfo.function = getFunction(sfinfo.num, currentFileInfo.line);
        }


        private void cmd_cf()
        {
            inputCommand("cf");
        }
        private void exit_cf()
        {
            //Test0.as#1:21
            string buf = bufferlist[0];
            Match m;
            if ((m = RegexCf.Match(buf)).Success)
            {
                string filename = m.Groups["filename"].Value;
                string num = m.Groups["num"].Value;
                int line = int.Parse(m.Groups["line"].Value);

                if (srcFileInfoDic.ContainsKey(num))
                {
                    currentFileInfo.filefullpath = srcFileInfoDic[num].filefullpath;
                    currentFileInfo.filename = filename; //Path.GetFileName(currentFileInfo.filefullpath);
                    currentFileInfo.function = getFunction(num, line);
                    currentFileInfo.line = line;
                }
                else
                {
                    currentFileInfo.Clear();
                    currentFileInfo.filename = filename;
                }
            }
            else
            {
                throw new Exception("cf error");
            }

        }

        private void CheckBreakPoint()
        {
            List<string> srcfilelist = new List<string>();
            foreach (SrcFileInfo info in srcFileInfoDic.Values)
            {
                srcfilelist.Add(info.filefullpath);
            }
            breakPointManager.SetSrcFileList(srcfilelist.ToArray());
            breakPointManager.CheckBreakPoint();
        }

        public void InfoStack()
        {
            cmd_infostack();
        }
        //(fdb) info stack
        //#0   this = [Object 16655873, class='Test1'].Test1() at Test1.as:13
        //#1   this = [Object 15965089, class='Test0'].Test0() at Test0.as:42
        private void cmd_infostack()
        {
            inputCommand("info stack");
        }

        public void FrameInfo(string stackinfo)
        {
            Match m;
            if ((m = RegexStack.Match(stackinfo)).Success)
            {
                string framenum = m.Groups["framenum"].Value;
                cmd_frame(framenum);
            }
        }

        //(fdb) frame 0
        //#0   Test1() at Test1.as#2:13
        //(fdb) frame 1
        //#1   Test0() at Test0.as#1:42
        private void cmd_frame(string framenum)
        {
            inputCommand(string.Format("frame {0}", framenum), "frame");
        }

        private void exit_frame()
        {
            if (bufferlist.Count == 0) return;

            Match m;
            if ((m = RegexFrame.Match(bufferlist[0])).Success)
            {
                string srcfilenum = m.Groups["srcfilenum"].Value;
                int line = int.Parse(m.Groups["line"].Value);

                if (srcFileInfoDic.ContainsKey(srcfilenum))
                {
                    SrcFileInfo srcinfo = srcFileInfoDic[srcfilenum];

                    FdbMsg msg = new FdbMsg();
                    msg.SetParam(srcinfo.filefullpath, Path.GetFileName(srcinfo.filefullpath), line, false);
                    if (MoveFrameEvent != null)
                        MoveFrameEvent(this, msg);
                }
            }
        }

        private string deletefdbPrompt(string buf)
        {
            return RegexDelPrompt.Replace(buf, "");
        }
    }
}
