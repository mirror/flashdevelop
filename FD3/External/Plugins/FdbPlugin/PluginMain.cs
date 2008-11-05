using System;
using System.IO;
using System.Drawing;
using System.Diagnostics;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using WeifenLuo.WinFormsUI.Docking;
using System.Text.RegularExpressions;
using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Controls;
using PluginCore.Managers;
using PluginCore.Helpers;
using ASCompletion.Context;
using ProjectManager.Projects.AS3;
using ProjectManager.Projects;
using FdbPlugin.Properties;
using FdbPlugin.Controls;
using ScintillaNet;
using PluginCore;
using System.Text;

namespace FdbPlugin
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "FdbPlugin";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginGuid = "3721fb83-114f-46dc-b022-27c63cc9e878";
        private String pluginDesc = "Hosts the ActionScript 3 debugger in FlashDevelop.";
        private String pluginAuth = "FlashDevelop Team";
        private DockContent pluginPanel;
        private String settingFilename;
        private Settings settingObject;
        private PluginUI pluginUI;
        private Image pluginImage;

        //break
        private String breakPointGuid = "59518ab2-83f8-44cd-953f-66731aaff3c7";
        private DockContent breakPointPanel;
        private BreakPointUI breakPointUI;

        private String stackframeGuid = "e5dac885-3d0f-47bb-ae77-86bd8da44983";
        private DockContent stackframePanel;
        private StackframeUI stackframeUI;

        private Point dataTipPoint;
        private ImageList imageList;
        private FdbWrapper fdbWrapper;
        private Project currentProject;
        private ToolStripItem[] toolbarButtons;
        private MouseMessageFilter mouseMessageFilter;
        private String AssociateExecutableFilePath, processname;
        private ToolStripButton PauseButton, StopButton, ContinueButton, StepButton, NextButton, StartNoDebugButton,
            FinishButton;
        private ToolStripDropDownItem StartMenu, StartNoDebugMenu, PauseMenu, StopMenu, ContinueMenu, StepMenu, NextMenu, KillfdbMenu,
            FinishMenu, 
            ToggleBreakPointMenu, ToggleBreakPointEnableMenu, 
            DeleteAllBreakPointsMenu, DisableAllBreakPointsMenu, EnableAllBreakPointsMenu;

        private ToolStripItem QuickWatchItem;
        private Boolean debugBuildStart = false;
        private Boolean buildCmpFlg = false;
        private Boolean disableDebugger = false;

        private BreakPointManager breakPointManager;

        private static DataTip dataTip;
        private static QuickWatchForm quickWatchForm;
        private static String exclude = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM0123456789_$.";
        private static Char[] chTrims = { '.' };

        private const int markerNumBreakPoint = 1;
        private const int markerNumBreakPointEnable = 3;
        private const int markerNumBreakPointDisable = 4;


        private static class CurrentDebugPostion
        {
            public static string fullpath;
        }

	    #region Required Properties

        /// <summary>
        /// Name of the plugin
        /// </summary> 
        public String Name
		{
			get { return this.pluginName; }
		}

        /// <summary>
        /// GUID of the plugin
        /// </summary>
        public String Guid
		{
			get { return this.pluginGuid; }
		}

        /// <summary>
        /// Author of the plugin
        /// </summary> 
        public String Author
		{
			get { return this.pluginAuth; }
		}

        /// <summary>
        /// Description of the plugin
        /// </summary> 
        public String Description
		{
			get { return this.pluginDesc; }
		}

        /// <summary>
        /// Web address for help
        /// </summary> 
        public String Help
		{
			get { return this.pluginHelp; }
		}

        /// <summary>
        /// Object that contains the settings
        /// </summary>
        [Browsable(false)]
        public Object Settings
        {
            get { return this.settingObject; }
        }
		
		#endregion
		
		#region Required Methods
		
		/// <summary>
		/// Initializes the plugin
		/// </summary>
		public void Initialize()
		{
            this.InitBasics();
            this.LoadSettings();
            this.AddEventHandlers();
            this.InitLocalization();
            this.CreatePluginPanel();
            this.CreateMenuItem();

            SetFlexSDKLocale(settingObject.FlexSdkLocale);

            //debug
            FdbPluginTrace.init();
            FdbPluginTrace.IsTraceLog = settingObject.IsTraceLog;
            FdbPluginTrace.Trace("--------------------------");
            FdbPluginTrace.Trace("---fdbPluginTrace Start---");
        }
		
		/// <summary>
		/// Disposes the plugin
		/// </summary>
		public void Dispose()
		{
            this.SaveSettings();
            fdbWrapper.Cleanup();
		}

		/// <summary>
		/// Handles the incoming events
		/// </summary>
		public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
		{
            switch (e.Type)
            {
                case EventType.FileOpen :
                    TextEvent evnt = (TextEvent)e;
                    AddSciEvent(evnt.Value); // TODO make a centralized event in UITools

                    //break
                    breakPointManager.SetBreakPointsToEditor(evnt.Value);

                    break;

                case EventType.UIStarted:
                    CheckValidFile(!disableDebugger);
                    break;
                
                case EventType.UIClosing:
                    breakPointManager.Save();
                    break;

                case EventType.FileSwitch:
                    CheckValidFile(!disableDebugger);
                    break;

                case EventType.ProcessEnd:
                    TextEvent textevnt = (TextEvent)e;
                    if (buildCmpFlg && (textevnt.Value != "Done (0)"))
                    {
                        buildCmpFlg = false;
                        UpdateMenuState(FdbState.INIT);
                    }
                    break;

                case EventType.Command:
                    PluginCore.DataEvent buildevnt = (PluginCore.DataEvent)e;

                    if (buildevnt.Action == "AS3Context.StartDebugger")
                    {
                        // TODO handle this event to debug external Flash player instances (like in webbrowser, AIR)
                        return;
                    }

                    if (!buildevnt.Action.StartsWith("ProjectManager"))
                        return;

                    if (buildevnt.Action == "ProjectManager.Project")
                    {
                        IProject project = PluginBase.CurrentProject;
                        if (project != null && project is AS3Project)
                        {
                            disableDebugger = false;
                            AddStartNoDebugButton();
                            CheckValidFile(true);

                            breakPointUI.Clear();
                            breakPointManager.Project = project;
                            breakPointManager.Load();
                            breakPointManager.SetBreakPointsToEditor(PluginBase.MainForm.Documents);
                        }
                        else
                        {
                            disableDebugger = true;
                            RemoveStartNoDebugButton();
                            CheckValidFile(false);

                            if(breakPointManager.Project != null)
                            {
                                breakPointManager.Save();
                            }
                            breakPointUI.Clear();
                        }
                    }
                    else if (disableDebugger) return;

                    if (debugBuildStart && buildevnt.Action == "ProjectManager.BuildFailed")
                    {
                        debugBuildStart = false;
                        buildCmpFlg = false;
                        UpdateMenuState(FdbState.INIT);
                    }
                    else if (buildevnt.Action == "ProjectManager.TestingProject")
                    {
                        // no new build while debugging
                        if (debugBuildStart || (fdbWrapper != null && fdbWrapper.IsDebugStart)) 
                        {
                            buildevnt.Handled = true;
                            return;
                        }
                        currentProject = PluginBase.CurrentProject as AS3Project;
                        if (currentProject != null && !currentProject.NoOutput 
                            && buildevnt.Data.ToString() == "Debug")
                        {
                            buildevnt.Handled = true;
                            Start_Click(null, null);
                            buildCmpFlg = true;
                        }
                        else currentProject = null;
                    }
                    else if (debugBuildStart && buildevnt.Action == "ProjectManager.BuildingProject" && buildevnt.Data.ToString() == "Debug")
                    {
                        buildCmpFlg = true;
                    }
                    else if (buildevnt.Action == "ProjectManager.BuildFailed")
                    {
                        StartNoDebugButton.Enabled = true;
                        StartNoDebugMenu.Enabled = true;
                        StartMenu.Enabled = true;
                        debugBuildStart = false;
                        buildCmpFlg = false;
                    }
                    else if (buildevnt.Action == "ProjectManager.BuildComplete")
                    {
                        if (buildCmpFlg)
                        {
                            Start(currentProject.OutputPathAbsolute);
                        }
                        else
                        {
                            StartNoDebugButton.Enabled = true;
                            StartNoDebugMenu.Enabled = true;
                            StartMenu.Enabled = true;
                        }
                        debugBuildStart = false;
                        buildCmpFlg = false;
                    }
                    break;
            }
		}

        private void AddStartNoDebugButton()
        {
            ToolStripItemCollection items = PluginBase.MainForm.ToolStrip.Items;
            if (items.Contains(StartNoDebugButton))
                items.Remove(StartNoDebugButton);
            ToolStripItem[] testMovie = items.Find("TestMovie", true);
            if (testMovie.Length > 0)
            {
                items.Insert(items.IndexOf(testMovie[0]), StartNoDebugButton);
            }
            StartNoDebugMenu.Enabled = true;
            StartMenu.Enabled = true;
        }
        private void RemoveStartNoDebugButton()
        {
            ToolStripItemCollection items = PluginBase.MainForm.ToolStrip.Items;
            if (items.Contains(StartNoDebugButton))
                items.Remove(StartNoDebugButton);
            StartNoDebugMenu.Enabled = false;
            StartMenu.Enabled = false;
        }
		
		#endregion

        #region FdbWrapper Event Handling


        void fdbWrapper_PrintEvent(object sender, PrintArg e)
        {
            if (sender is ISetData)
            {
                ISetData si = sender as ISetData;
                if (si.TargetControl == null)
                {
                    si.SetData(e.valname, e.output, e.option);
                }
                else
                {
                    si.TargetControl.Invoke((MethodInvoker)delegate()
                    {
                        si.SetData(e.valname, e.output, e.option);
                    });
                }
            }
        }

        void fdbWrapper_MoveFrameEvent(object sender, FdbMsg e)
        {
            (PluginBase.MainForm as Form).Invoke((MethodInvoker)delegate()
            {
                ActiveDocument(e.filefillpath, e.line - 1, true);
            });

            stackframeUI.Invoke((MethodInvoker)delegate()
            {
                stackframeUI.ActiveItem();
            });
        }

        void fdbWrapper_PrintStackfremaEvent(object sender, PrintArg e)
        {
            stackframeUI.Invoke((MethodInvoker)delegate()
            {
                stackframeUI.AddItem(e.output);
            });
        }

        void fdbWrapper_ConditionErrorEvent(object sender)
        {
            fdbWrapper.Stop(processname, false);

            (PluginBase.MainForm as Form).Invoke((MethodInvoker)delegate()
            {
                MessageBox.Show("Condition Error");
            });
            breakPointPanel.Invoke((MethodInvoker)delegate()
            {
                breakPointPanel.Show();
            });
        }

        /// <summary>
        /// 
        /// </summary>
        void fdbWrapper_ExceptionEvent(object sender)
        {
            targetHwnd = IntPtr.Zero;
            Process[] allProcesses = Process.GetProcessesByName(processname);
            foreach (Process oneProcess in allProcesses)
            {
                targetProcess = oneProcess;
            }
            Util.EnumWindows(new Util.EnumerateWindowsCallback(EnumerateWindows), 0);
            if (targetHwnd == IntPtr.Zero)
            {
                return;
            }
            Util.SetForegroundWindow(targetHwnd);
            UpdateMenuState(FdbState.WAIT);
        }

        /// <summary>
        /// 
        /// </summary>
        private void fdbWrapper_PauseEvent(Object sender)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate()
                {
                    UpdateMenuState(fdbWrapper.State);
                });
            }
            else UpdateMenuState(fdbWrapper.State);
        }

        /// <summary>
        /// 
        /// </summary>
        private void fdbWrapper_TraceEvent(Object sender, String trace)
        {
            Int32 p = trace.IndexOf(']');
            if (p > 0) TraceManager.AddAsync(trace.Substring(p + 1).TrimStart(), 1);
            else TraceManager.AddAsync(trace, 1);
        }

        /// <summary>
        /// 
        /// </summary>
        private void fdbWrapper_StopEvent(Object sender)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate()
                {
                    RemoveHighlights(GetScintillaControl(CurrentDebugPostion.fullpath));
                    UpdateMenuState(FdbState.INIT);
                });
            }
            else
            {
                RemoveHighlights(GetScintillaControl(CurrentDebugPostion.fullpath));
                UpdateMenuState(FdbState.INIT);
            }
            if (pluginUI.TreeControl.InvokeRequired)
            {
                pluginUI.TreeControl.BeginInvoke((MethodInvoker)delegate()
                {
                    pluginUI.TreeControl.Nodes.Clear();
                });
            }
            else pluginUI.TreeControl.Nodes.Clear();

            stackframeUI.Invoke((MethodInvoker)delegate()
            {
                stackframeUI.ClearItem();
            });

            //Close window(AIR)
            if (adlProcess != null && !adlProcess.HasExited)
            {
                adlProcess.CloseMainWindow();
                adlProcess.WaitForExit();
                adlProcess = null;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void fdbWrapper_LocalValuesEvent(Object sender, FdbMsg e)
        {
            if (pluginUI.TreeControl.Nodes.Count == 0)
            {
                pluginUI.TreeControl.Invoke((MethodInvoker)delegate()
                {
                    foreach (String data in e.output)
                    {
                        Match m = null;
                        if ((m = RegexManager.RegexNameValue.Match(data)).Success)
                        {
                            pluginUI.TreeControl.AddRootNode(new DataNode(m.Groups["name"].Value.Trim(), m.Groups["value"].Value.Trim()));
                        }
                    }
                });
            }
            else
            {
                pluginUI.TreeControl.Invoke((MethodInvoker)delegate()
                {
                    pluginUI.TreeControl.Tree.BeginUpdate();
                    foreach (String data in e.output)
                    {
                        Match m;
                        if ((m = RegexManager.RegexNameValue.Match(data)).Success)
                        {
                            String name = m.Groups["name"].Value.Trim();
                            name = name.TrimEnd(chTrims);
                            String value = m.Groups["value"].Value.Trim();
                            DataNode node = pluginUI.TreeControl.GetNode(name);//.Value = value;
                            if (node != null)
                            {
                                if (node.Nodes.Count == 0 && node.IsLeaf && RegexManager .RegexObject.IsMatch(value))
                                {
                                    node.Parent.Nodes.Insert(node.Index, new DataNode(name, value));
                                    node.Parent.Nodes.Remove(node);
                                }
                                else node.Value = value;
                            }
                        }
                    }
                    pluginUI.TreeControl.Tree.EndUpdate();
                });
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void fdbWrapper_ContinueEvent(Object sender, FdbMsg e)
        {
            if (e.ismove)
            {
                pluginUI.TreeControl.BeginInvoke((MethodInvoker)delegate()
                {
                    pluginUI.TreeControl.Nodes.Clear();
                });
            }
            (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate()
            {
                ScintillaControl sci = GetScintillaControl(e.filefillpath);
                if (sci == null)
                {
                    PluginBase.MainForm.OpenEditableDocument(e.filefillpath);
                    sci = GetScintillaControl(e.filefillpath);
                }

                CurrentDebugPostion.fullpath = e.filefillpath;
                Int32 i = GetScintillaControlIndex(sci);
                PluginBase.MainForm.Documents[i].Activate();
                Int32 line = e.line - 1;
                sci.GotoLine(line);
                AddHighlights(sci, line);
            });
        }

        #endregion

        #region MenuItem Event Handling
        
        /// <summary>
        /// 
        /// </summary>
        private void Start(String filename)
        {
            try
            {
                FdbPluginTrace.TraceInfo("----Start(string filename)----");
                UpdateMenuState(FdbState.START);
                TraceManager.Add("[Debugging with FDB]");
                OpenLocalVariablesPanel(null, null);
                Application.DoEvents();
                fdbWrapper.CurrentProject = currentProject;
                fdbWrapper.CurrentSettings = AS3Context.PluginMain.Settings;
                fdbWrapper.Outputfilefullpath = filename;
                fdbWrapper.Start();

                FdbPluginTrace.TraceInfo("fdbWrapper.Start() end");
                FdbPluginTrace.TraceInfo("fdbWrapper.State = " + fdbWrapper.State.ToString());

                if (fdbWrapper.State != FdbState.CONDITIONERROR 
                    && fdbWrapper.State != FdbState.PAUSE_SET_BREAKPOINT
                    && fdbWrapper.State != FdbState.CONTINUE
                    && fdbWrapper.State != FdbState.UNLOAD)
                {
                    fdbWrapper.InfoLocals();
                    FdbPluginTrace.TraceInfo("Start(string filename) fdbWrapper.InfoLocals(); end");
                    UpdatelocalVariablesLeaf();
                    FdbPluginTrace.TraceInfo("Start(string filename) UpdatelocalVariablesLeaf(); end");

                    if (stackframePanel.DockState != DockState.Hidden)
                    {
                        fdbWrapper.InfoStack();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                fdbWrapper.Stop(processname, false);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void Start_Click(Object sender, EventArgs e)
        {
            try
            {
                FdbPluginTrace.Trace("CheckCurrent()");
                CheckCurrent();
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return;
            }

            debugBuildStart = true;
            UpdateMenuState(FdbState.WAIT);
            if (settingObject.DebugWithCompile 
                || !File.Exists(Path.Combine(Path.GetDirectoryName(currentProject.ProjectPath), currentProject.OutputPath)))
            {
                try
                {
                    BuildCurrentProject();
                }
                catch
                {
                    String message = TextHelper.GetString("FdbPlugin.Info.DebugWithoutCompiler");
                    String title = " " + TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
                    if (MessageBox.Show(message, title, MessageBoxButtons.OKCancel) == DialogResult.OK)
                    {
                        Start(currentProject.OutputPathAbsolute);
                    }
                }
            }
            else Start(currentProject.OutputPathAbsolute);
        }

        /// <summary>
        /// 
        /// </summary>
        private void StartNoDebug_Click(Object sender, EventArgs e)
        {
            if (debugBuildStart || (fdbWrapper != null && fdbWrapper.IsDebugStart))
                return;
            disableDebugger = true;
            StartNoDebugButton.Enabled = false;
            StartNoDebugMenu.Enabled = false;
            StartMenu.Enabled = false;
            DataEvent de = new DataEvent(EventType.Command, "ProjectManager.TestMovie", null);
            EventManager.DispatchEvent(this, de);
            disableDebugger = false;
        }

        /// <summary>
        /// 
        /// </summary>
        private void Stop_Click(Object sender, EventArgs e)
        {
            dataTip.Hide();
            fdbWrapper.Stop(processname, settingObject.AlwaysCheckDebugStop);
            FdbPluginTrace.TraceInfo("Stop() fdbWrapper.Stop; end");
        }

        /// <summary>
        /// 
        /// </summary>
        private void Next_Click(Object sender, EventArgs e)
        {
            if (fdbWrapper.State == FdbState.EXCEPTION)
            {
                FdbPluginTrace.TraceInfo("Next() fdbWrapper.ExceptionContinue(); start");
                fdbWrapper.ExceptionContinue();
                FdbPluginTrace.TraceInfo("Next() fdbWrapper.ExceptionContinue(); end");
            }
            else
            {
                UpdateMenuState(FdbState.NEXT);
                RemoveHighlights(GetScintillaControl(CurrentDebugPostion.fullpath));
                fdbWrapper.Next(); 
                fdbWrapper.InfoLocals();
                FdbPluginTrace.TraceInfo("Next() fdbWrapper.InfoLocals(); end");
                UpdatelocalVariablesLeaf();
                FdbPluginTrace.TraceInfo("Next() UpdatelocalVariablesLeaf(); end");
                
                if (stackframePanel.DockState != DockState.Hidden)
                {
                    fdbWrapper.InfoStack();
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void Step_Click(Object sender, EventArgs e)
        {
            try
            {
                if (fdbWrapper.State == FdbState.EXCEPTION)
                {
                    FdbPluginTrace.TraceInfo("Step() fdbWrapper.ExceptionContinue(); start");
                    fdbWrapper.ExceptionContinue();
                    FdbPluginTrace.TraceInfo("Step() fdbWrapper.ExceptionContinue(); end");
                }
                else
                {
                    UpdateMenuState(FdbState.STEP);
                    RemoveHighlights(GetScintillaControl(CurrentDebugPostion.fullpath));
                    fdbWrapper.Step();
                    fdbWrapper.InfoLocals();
                    FdbPluginTrace.TraceInfo("Step() fdbWrapper.InfoLocals(); end");
                    UpdatelocalVariablesLeaf();
                    FdbPluginTrace.TraceInfo("Step() UpdatelocalVariablesLeaf(); end");

                    if (stackframePanel.DockState != DockState.Hidden)
                    {
                        fdbWrapper.InfoStack();
                    }
                }
            }
            catch (NotFindSourceException ex)
            {
                MessageBox.Show(ex.Message);
                UpdateMenuState(FdbState.BREAK);


                ITabbedDocument doc = GetDocument(ex.PreFileFullPath);
                if(doc != null)
                {
                    ScintillaControl sci = doc.SciControl;
                    AddHighlights(sci, ex.PreLine-1);
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void Continue_Click(Object sender, EventArgs e)
        {
            try
            {
                if (fdbWrapper.State == FdbState.EXCEPTION)
                {
                    FdbPluginTrace.TraceInfo("Continue() fdbWrapper.ExceptionContinue(); start");
                    fdbWrapper.ExceptionContinue();
                    FdbPluginTrace.TraceInfo("Continue() fdbWrapper.ExceptionContinue(); end");
                }
                else
                {
                    //break
                    UpdateMenuState(FdbState.CONTINUE);
                    RemoveHighlights(GetScintillaControl(CurrentDebugPostion.fullpath));
                    fdbWrapper.Continue();
                    if (fdbWrapper.State != FdbState.PAUSE_SET_BREAKPOINT)
                    {
                        fdbWrapper.InfoLocals();
                        FdbPluginTrace.TraceInfo("Continue() fdbWrapper.InfoLocals(); end");
                        UpdatelocalVariablesLeaf();
                        FdbPluginTrace.TraceInfo("Continue() UpdatelocalVariablesLeaf(); end");

                        if (stackframePanel.DockState != DockState.Hidden)
                        {
                            fdbWrapper.InfoStack();
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void Pause_Click(Object sender, EventArgs e)
        {
            UpdateMenuState(FdbState.WAIT);
            RemoveHighlights(GetScintillaControl(CurrentDebugPostion.fullpath));
            FdbPluginTrace.TraceInfo("Pause() fdbWrapper.Pause();");
            fdbWrapper.Pause();
        }

        /// <summary>
        /// 
        /// </summary>
        private void Killfdb_Click(Object sender, EventArgs e)
        {
            fdbWrapper.Cleanup();
        }

        private void Finish_Click(Object sender, EventArgs e)
        {
            UpdateMenuState(FdbState.CONTINUE);
            RemoveHighlights(GetScintillaControl(CurrentDebugPostion.fullpath));
            FdbPluginTrace.TraceInfo("Finish() fdbWrapper.Pause();");
            fdbWrapper.Finish();

            RemoveHighlights(GetScintillaControl(CurrentDebugPostion.fullpath));
            fdbWrapper.InfoLocals();
            FdbPluginTrace.TraceInfo("Finish() fdbWrapper.InfoLocals(); end");
            UpdatelocalVariablesLeaf();
            FdbPluginTrace.TraceInfo("Finish() UpdatelocalVariablesLeaf(); end");

            if (stackframePanel.DockState != DockState.Hidden)
            {
                fdbWrapper.InfoStack();
            }
        }
        
        private void ToggleBreakPoint_Click(Object sender, EventArgs e)
        {
            ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
            int line = sci.LineFromPosition(sci.CurrentPos);
            this.ToggleMarker(sci, markerNumBreakPoint, line);
        }

        private void DeleteAllBreakPoints_Click(Object sender, EventArgs e)
        {
            foreach (ITabbedDocument doc in PluginBase.MainForm.Documents)
            {
                doc.SciControl.MarkerDeleteAll(markerNumBreakPoint);
                doc.SciControl.MarkerDeleteAll(markerNumBreakPointDisable);
                doc.SciControl.MarkerDeleteAll(markerNumBreakPointEnable);
            }
            breakPointManager.ClearAll();
            breakPointUI.Clear();
        }

        private void ToggleBreakPointEnable_Click(Object sender, EventArgs e)
        {
            ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;       
            Int32 line = sci.LineFromPosition(sci.CurrentPos);

            if (IsMarker(sci, markerNumBreakPointEnable, line))
            {
                ToggleMarker(sci, markerNumBreakPointDisable, line);
            }
        }

        private void DisableAllBreakPoints_Click(Object sender, EventArgs e)
        {
            foreach (ITabbedDocument doc in PluginBase.MainForm.Documents)
            {
                List<int> list = breakPointManager.GetMarkers(doc.SciControl, markerNumBreakPoint);
                foreach (int line in list)
                {
                    doc.SciControl.MarkerAdd(line, markerNumBreakPointDisable);
                }
            }

            breakPointManager.DisableAllBreakPoints(fdbWrapper.IsDebugStart);
        }

        private void EnableAllBreakPoints_Click(Object sender, EventArgs e)
        {
            foreach (ITabbedDocument doc in PluginBase.MainForm.Documents)
            {
                List<int> list = breakPointManager.GetMarkers(doc.SciControl, markerNumBreakPoint);
                foreach (int line in list)
                {
                    if (IsMarker(doc.SciControl, markerNumBreakPointDisable, line))
                    {
                        ToggleMarker(doc.SciControl, markerNumBreakPointDisable, line);
                    }
                }
            }

            breakPointManager.EnableAllBreakPoints(fdbWrapper.IsDebugStart);
        }

        #endregion

        #region Custom Methods

        /// <summary>
        /// 
        /// </summary>
        public FdbWrapper FdbWrapper
        {
            get { return this.fdbWrapper; }
        }

        /// <summary>
        /// Initializes important variables
        /// </summary>
        public void InitBasics()
        {
            imageList = new ImageList();
            imageList.Images.Add("Stop", Resource.Stop);
            imageList.Images.Add("Continue", Resource.Continue);
            imageList.Images.Add("Next", Resource.Next);
            imageList.Images.Add("Step", Resource.Step);
            imageList.Images.Add("Pause", Resource.Pause);
            imageList.Images.Add("NoDebug", Resource.StartNoDebug);
            imageList.Images.Add("Finish", Resource.Finish);

            String dataPath = Path.Combine(PathHelper.DataDir, "FdbPlugin");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            this.pluginImage = PluginBase.MainForm.FindImage("51");

            UITools.Manager.OnMouseHover += new UITools.MouseHoverHandler(Manager_OnMouseHover);
            PluginBase.MainForm.BreakpointsEnabled = true;

            fdbWrapper = new FdbWrapper();
            fdbWrapper.ContinueEvent += new ContinueEventHandler(fdbWrapper_ContinueEvent);
            fdbWrapper.LocalValuesEvent += new ContinueEventHandler(fdbWrapper_LocalValuesEvent);
            fdbWrapper.StopEvent += new fdbEventHandler(fdbWrapper_StopEvent);
            fdbWrapper.TraceEvent += new TraceEventHandler(fdbWrapper_TraceEvent);
            fdbWrapper.PauseEvent += new fdbEventHandler(fdbWrapper_PauseEvent);
            fdbWrapper.ExceptionEvent += new fdbEventHandler(fdbWrapper_ExceptionEvent);
            fdbWrapper.PuaseNotRespondEvent += new fdbEventHandler(fdbWrapper_PuaseNotRespondEvent);

            fdbWrapper.PrintEvent += new PrintEventHandler(fdbWrapper_PrintEvent);
            fdbWrapper.ConditionErrorEvent += new fdbEventHandler(fdbWrapper_ConditionErrorEvent);
            fdbWrapper.StartadlEvent += new fdbEventHandler(fdbWrapper_StartadlEvent);
            fdbWrapper.InfoStackEvent += new PrintEventHandler(fdbWrapper_PrintStackfremaEvent);
            fdbWrapper.MoveFrameEvent += new ContinueEventHandler(fdbWrapper_MoveFrameEvent);

            //break
            breakPointManager = new BreakPointManager();
            fdbWrapper.breakPointManager = breakPointManager;

            if (dataTip == null) dataTip = new DataTip(PluginBase.MainForm);
            mouseMessageFilter = new MouseMessageFilter();
            mouseMessageFilter.AddControls(dataTip.Controls);
            mouseMessageFilter.MouseDownEvent += new MouseDownEventHandler(mouseMessageFilter_MouseDownEvent);
            Application.AddMessageFilter(mouseMessageFilter);

            quickWatchForm = new QuickWatchForm();
            quickWatchForm.StartPosition = FormStartPosition.CenterParent;
            //quickWatchForm.EvaluateEvent += new EvaluateEventHandler(quickWatchForm_EvaluateEvent);
            //quickWatchForm.DataTreeExpandingEvent += new EvaluateEventHandler(quickWatchForm_DataTreeExpandingEvent)

            quickWatchForm.EvaluateEvent += new EvaluateEventHandler(delegate(object sender, EvaluateArgs e)
                {
                    fdbWrapper.Print(quickWatchForm, e.Exp, "evaluate");                 
                });
            quickWatchForm.DataTreeExpandingEvent += new EvaluateEventHandler(delegate(object sender, EvaluateArgs e)
                {
                    fdbWrapper.Print(quickWatchForm, e.Exp, "expand");
                });
        }

        //void quickWatchForm_DataTreeExpandingEvent(object sender, EvaluateArgs e)
        //{
        //    fdbWrapper.Print(quickWatchForm, e.Exp, "expand");
        //}

        //void quickWatchForm_EvaluateEvent(object sender, EvaluateArgs e)
        //{
        //    fdbWrapper.Print(quickWatchForm, e.Exp, "exp");
        //}


        void fdbWrapper_PrintQuickWatchEvent(object sender, PrintArg e)
        {
            dataTip.DataTree.Invoke((MethodInvoker)delegate()
            {
                Point p = new Point(200, 200);
                dataTip.Show(p, e.valname, e.output);
            });
        }

        private void SetFlexSDKLocale(FlexSDKLocale locate)
        {
            RegexManager regexManager = new RegexManager();
            switch (locate)
            {
                case FlexSDKLocale.en_US:
                    regexManager.Load(Resource.FdbRegex_en_US);
                    break;
                case FlexSDKLocale.ja_JP:
                    regexManager.Load(Resource.FdbRegex_ja_JP);
                    break;
            }
            regexManager.SetRegex(fdbWrapper);
        }


        //test
        Process adlProcess = null;
        void fdbWrapper_StartadlEvent(object sender)
        {
            FdbPluginTrace.TraceInfo("fdbWrapper_StartadlEvent start");
            string cmd = PluginBase.MainForm.ProcessArgString(currentProject.TestMovieCommand);
            string[] args = (cmd + ';').Split(';');
            ProcessStartInfo psi = new ProcessStartInfo(args[0], args[1]);
            psi.CreateNoWindow = true;
            psi.UseShellExecute = false;
            psi.WorkingDirectory = currentProject.Directory;
            FdbPluginTrace.Trace("psi.WorkingDirectory = " + psi.WorkingDirectory);
            adlProcess = Process.Start(psi);
        }

        /// <summary>
        /// Initializes the localization of the plugin
        /// </summary>
        public void InitLocalization()
        {
            this.pluginDesc = TextHelper.GetString("FdbPlugin.Info.Description");
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            EventManager.AddEventHandler(this, EventType.FileEmpty | EventType.FileOpen | EventType.FileSwitch | EventType.ProcessStart | EventType.ProcessEnd | EventType.Command | EventType.UIClosing);
            EventManager.AddEventHandler(this, EventType.UIStarted, HandlingPriority.Low);
        }

        /// <summary>
        /// Creates a menu item for the plugin and adds a ignored key
        /// </summary>
        public void CreateMenuItem()
        {
            ToolStripMenuItem viewMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("ViewMenu");
            viewMenu.DropDownItems.Add(new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.ViewLocalVariablesPanelMenuItem"), this.pluginImage, new EventHandler(this.OpenLocalVariablesPanel)));

            //break
            viewMenu.DropDownItems.Add(new ToolStripMenuItem("BreakPointList", this.pluginImage, new EventHandler(this.OpenBreakPointPanel)));
            viewMenu.DropDownItems.Add(new ToolStripMenuItem("Stackframe", this.pluginImage, new EventHandler(this.OpenStackframePanel)));
            
            //Menu           
            ToolStripMenuItem debugMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("DebugMenu");
            if (debugMenu == null)
            {
                debugMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.DebugMenuItem"));
                ToolStripMenuItem toolsMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("ToolsMenu");
                Int32 idx = PluginBase.MainForm.MenuStrip.Items.IndexOf(toolsMenu);
                if (idx < 0) idx = PluginBase.MainForm.MenuStrip.Items.Count - 1;
                PluginBase.MainForm.MenuStrip.Items.Insert(idx, debugMenu);
            }
            StartMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Start"), imageList.Images["Continue"], new EventHandler(Start_Click));
            StartNoDebugMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.StartNoDebug"), imageList.Images["NoDebug"], new EventHandler(StartNoDebug_Click), this.settingObject.StartNoDebug);
            StopMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Stop"), imageList.Images["Stop"], new EventHandler(Stop_Click), this.settingObject.Stop);
            ContinueMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Continue"), imageList.Images["Continue"], new EventHandler(Continue_Click), this.settingObject.Continue);
            StepMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Step"), imageList.Images["Step"], new EventHandler(Step_Click), this.settingObject.Step);
            NextMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Next"), imageList.Images["Next"], new EventHandler(Next_Click), this.settingObject.Next);
            KillfdbMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Killfdb"), null, new EventHandler(Killfdb_Click), this.settingObject.Next);
            PauseMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Pause"), imageList.Images["Pause"], new EventHandler(Pause_Click), this.settingObject.Pause);

            //break
            FinishMenu = new ToolStripMenuItem("Finish", imageList.Images["Finish"], new EventHandler(Finish_Click), this.settingObject.Finish);

            ToolStripSeparator spMenu = new ToolStripSeparator();

            ToggleBreakPointMenu = new ToolStripMenuItem("ToggleBreakPoint", null, new EventHandler(ToggleBreakPoint_Click), this.settingObject.ToggleBreakPoint);
            DeleteAllBreakPointsMenu = new ToolStripMenuItem("DeleteAllBreakPoints", null, new EventHandler(DeleteAllBreakPoints_Click), this.settingObject.Finish);
            ToggleBreakPointEnableMenu = new ToolStripMenuItem("ToggleBreakPointEnable", null, new EventHandler(ToggleBreakPointEnable_Click), this.settingObject.ToggleBreakPointEnable);

            DisableAllBreakPointsMenu = new ToolStripMenuItem("DisableAllBreakPoints", null, new EventHandler(DisableAllBreakPoints_Click), this.settingObject.DisableAllBreakPoints);
            EnableAllBreakPointsMenu = new ToolStripMenuItem("EnableAllBreakPoints", null, new EventHandler(EnableAllBreakPoints_Click), this.settingObject.EnableAllBreakPoints);


            List<ToolStripItem> items = new List<ToolStripItem>(new ToolStripItem[] { StartMenu, StartNoDebugMenu, PauseMenu, StopMenu, ContinueMenu, StepMenu, NextMenu, FinishMenu, KillfdbMenu, 
                spMenu, ToggleBreakPointMenu, DeleteAllBreakPointsMenu, ToggleBreakPointEnableMenu ,DisableAllBreakPointsMenu, EnableAllBreakPointsMenu});
            
            foreach (ToolStripItem item in items)
            {
                if (item is ToolStripMenuItem)
                {
                    if ((item as ToolStripMenuItem).ShortcutKeys != Keys.None)
                        PluginBase.MainForm.IgnoredKeys.Add((item as ToolStripMenuItem).ShortcutKeys);
                }
            }
            //if (debugMenu.DropDownItems.Count > 0)
            //{
            //    items.Add(new ToolStripSeparator());
            //    foreach (ToolStripItem item in debugMenu.DropDownItems) items.Add(item);
            //    debugMenu.DropDownItems.Clear();
            //}
            debugMenu.DropDownItems.AddRange(items.ToArray());

            //ToolStrip
            StopButton = new ToolStripButton(TextHelper.GetString("FdbPlugin.Label.Stop"), imageList.Images["Stop"], new EventHandler(Stop_Click));
            StopButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            ContinueButton = new ToolStripButton(TextHelper.GetString("FdbPlugin.Label.Continue"), imageList.Images["Continue"], new EventHandler(Continue_Click));
            ContinueButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            StepButton = new ToolStripButton(TextHelper.GetString("FdbPlugin.Label.Step"), imageList.Images["Step"], new EventHandler(Step_Click));
            StepButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            NextButton = new ToolStripButton(TextHelper.GetString("FdbPlugin.Label.Next"), imageList.Images["Next"], new EventHandler(Next_Click));
            NextButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            PauseButton = new ToolStripButton(TextHelper.GetString("FdbPlugin.Label.Pause"), imageList.Images["Pause"], new EventHandler(Pause_Click));
            PauseButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            
            //break
            FinishButton = new ToolStripButton("Finish", imageList.Images["Finish"], new EventHandler(Finish_Click));
            FinishButton.DisplayStyle = ToolStripItemDisplayStyle.Image;

            toolbarButtons = new ToolStripItem[] { new ToolStripSeparator(), PauseButton, StopButton, ContinueButton, StepButton, NextButton, FinishButton };

            StartNoDebugButton = new ToolStripButton(TextHelper.GetString("FdbPlugin.Label.StartNoDebug"), imageList.Images["NoDebug"], new EventHandler(StartNoDebug_Click));
            StartNoDebugButton.DisplayStyle = ToolStripItemDisplayStyle.Image;

            if (dataTip == null) dataTip = new DataTip(PluginBase.MainForm);
            dataTip.DataTree.Tree.Expanding += new EventHandler<Aga.Controls.Tree.TreeViewAdvEventArgs>(DataTipTree_Expanding);
            
            //contextmenu
            QuickWatchItem = new ToolStripMenuItem("QuickWatch", null, delegate
                {
                    string exp = PluginBase.MainForm.CurrentDocument.SciControl.SelText;
                    quickWatchForm.Exp = exp;
                    quickWatchForm.ShowDialog(PluginBase.MainForm);

                });
            PluginBase.MainForm.EditorMenu.Items.Add(QuickWatchItem);

            UpdateMenuState(FdbState.INIT);
        }

        /// <summary>
        /// Creates a plugin panel for the plugin
        /// </summary>
        public void CreatePluginPanel()
        {
            this.pluginUI = new PluginUI(this);
            this.pluginUI.Text = TextHelper.GetString("FdbPlugin.Title.LocalVariables");
            this.pluginPanel = PluginBase.MainForm.CreateDockablePanel(this.pluginUI, this.pluginGuid, this.pluginImage, DockState.Hidden);

            this.pluginUI.TreeControl.Tree.Expanding += new EventHandler<Aga.Controls.Tree.TreeViewAdvEventArgs>(LocalVariablesTreeExpanding);

            //break
            this.breakPointUI = new BreakPointUI(this, breakPointManager);
            this.breakPointUI.Text = "BreakPointList";
            this.breakPointPanel = PluginBase.MainForm.CreateDockablePanel(this.breakPointUI, this.breakPointGuid, this.pluginImage, DockState.Hidden);

            this.stackframeUI = new StackframeUI(this, imageList);
            this.stackframeUI.Text = "Stackframe";
            this.stackframeUI.CallFrameEvent += new Action<string>(stackframeUI_CallFrameEvent);
            this.stackframePanel = PluginBase.MainForm.CreateDockablePanel(this.stackframeUI, this.stackframeGuid, this.pluginImage, DockState.Hidden);
        }

        void stackframeUI_CallFrameEvent(string obj)
        {
            fdbWrapper.FrameInfo(obj);
        }

        /// <summary>
        /// Loads the plugin settings
        /// </summary>
        public void LoadSettings()
        {
            this.settingObject = new Settings();
            if (!File.Exists(this.settingFilename)) this.SaveSettings();
            else
            {
                Object obj = ObjectSerializer.Deserialize(this.settingFilename, this.settingObject);
                this.settingObject = (Settings)obj;
            }
            AddSettingsListeners();
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            RemoveSettingsListeners();
            ObjectSerializer.Serialize(this.settingFilename, this.settingObject);
            AddSettingsListeners();
        }

        /// <summary>
        /// 
        /// </summary>
        private void CheckValidFile(bool state)
        {
            ITabbedDocument document = PluginBase.MainForm.CurrentDocument;
            if (document != null && document.IsEditable && (document.FileName.EndsWith(".as") || document.FileName.EndsWith(".mxml")) && ASContext.Context.IsFileValid ) //&& ASContext.Context.CurrentModel.Version == 3)
            {
                PluginBase.MainForm.BreakpointsEnabled = state;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void CheckCurrent()
        {
            String errormsg = String.Empty;
            try
            {
                String filename = PluginBase.CurrentProject.ProjectPath;
                ProjectManager.Projects.ProjectReader reader = new ProjectManager.Projects.ProjectReader(filename, new AS3Project(filename));
                currentProject = reader.ReadProject();
            }
            catch (Exception e)
            {
                errormsg = e.Message + System.Environment.NewLine;
            }
            if (!(currentProject.CompileTargets != null && currentProject.CompileTargets.Count != 0))
            {
                errormsg += TextHelper.GetString("FdbPlugin.Info.NoMainClass") + System.Environment.NewLine;
            }
            if (currentProject.Language != "as3")
            {
                errormsg += TextHelper.GetString("FdbPlugin.Info.LanguageNotAS3") + System.Environment.NewLine;
            }
            if (AS3Context.PluginMain.Settings.FlexSDK == null || AS3Context.PluginMain.Settings.FlexSDK == string.Empty || !Directory.Exists(AS3Context.PluginMain.Settings.FlexSDK))
            {
                errormsg += TextHelper.GetString("FdbPlugin.Info.CheckFlexSDKSetting") + System.Environment.NewLine;
            }
            try
            {
                //$(FlexSDK)\bin\adl.exe;application.xml bin
                if (currentProject.TestMovieCommand != null && currentProject.TestMovieCommand.Contains("adl.exe"))
                {
                    //AIR
                    processname = "adl";
                }
                else
                {
                    String cmd = Util.FindAssociatedExecutableFile(".swf", "open");
                    if (cmd != AssociateExecutableFilePath)
                    {
                        processname = Util.GetAssociateAppFileName(cmd);
                        AssociateExecutableFilePath = cmd;
                    }
                }
            }
            catch (Exception e)
            {
                errormsg += e.Message + System.Environment.NewLine;
            }
            if (errormsg != String.Empty) throw new Exception(errormsg);
        }

        /// <summary>
        /// 
        /// </summary>
        private void UpdatelocalVariablesLeaf()
        {
            List<DataNode> nodelist = pluginUI.TreeControl.AllHasChildNodes;
            if (nodelist.Count == 0)
            {
                UpdateMenuState(fdbWrapper.State);
                return;
            }
            List<string> objlist = new List<string>();
            foreach (DataNode node in nodelist)
            {
                String fullpath = pluginUI.TreeControl.GetFullPath(node);
                objlist.Add(fullpath + ".");
            }
            fdbWrapper.Print(pluginUI, objlist.ToArray());
        }

        /// <summary>
        /// 
        /// </summary>
        private void mouseMessageFilter_MouseDownEvent(MouseButtons button, Point e)
        {
            if (dataTip.Visible && !dataTip.contextMenuStrip.Visible && !dataTip.DataTree.Viewer.Visible)
            {
                dataTip.Hide();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void Manager_OnMouseHover(ScintillaControl sender, Int32 position)
        {
            if (!PluginBase.MainForm.EditorMenu.Visible
                && fdbWrapper != null && fdbWrapper.IsDebugStart 
                && (fdbWrapper.State == FdbState.BREAK || fdbWrapper.State == FdbState.NEXT || fdbWrapper.State == FdbState.STEP || fdbWrapper.State == FdbState.EXCEPTION))
            {
                if (CurrentDebugPostion.fullpath != PluginBase.MainForm.CurrentDocument.FileName) return;
                if (UITools.Tip.Visible)
                {
                    UITools.Tip.Hide();
                    Application.DoEvents();
                }
                dataTipPoint = ((Form)PluginBase.MainForm).PointToClient(Control.MousePosition);
                if (dataTip.Visible && dataTip.Location.X <= dataTipPoint.X && (dataTip.Location.X + dataTip.Width) >= dataTipPoint.X && dataTip.Location.Y <= dataTipPoint.Y && (dataTip.Location.Y + dataTip.Height) >= dataTipPoint.Y)
                {
                    return;
                }
                position = sender.WordEndPosition(position, true);
                String leftword = GetWordRes(sender, position);
                if (leftword != String.Empty)
                {
                    dataTip.Location = dataTipPoint;
                    fdbWrapper.Print(dataTip, leftword);
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void AddSciEvent(String value)
        {
            ScintillaControl sci = GetScintillaControl(value);
            sci.ModEventMask |= (Int32)ScintillaNet.Enums.ModificationFlags.ChangeMarker;
            sci.MarkerChanged += new MarkerChangedHandler(SciControl_MarkerChanged);

            sci.MarkerSetBack(markerNumBreakPointEnable, DataConverter.ColorToInt32(settingObject.BreakPointEnableLineColor)); //enable
            sci.MarkerSetBack(markerNumBreakPointDisable, DataConverter.ColorToInt32(settingObject.BrekPointDisableLineColor)); //dis

            sci.Modified += new ModifiedHandler(sci_Modified);
        }

        void sci_Modified(ScintillaControl sender, int position, int modificationType, string text, int length, int linesAdded, int line, int foldLevelNow, int foldLevelPrev)
        {
            if (linesAdded != 0)
            {
                int modline = sender.LineFromPosition(position);
                breakPointManager.UpDateBrekPoint(sender.FileName, modline, linesAdded);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void SciControl_MarkerChanged(ScintillaControl sender, Int32 line)
        {
            if (line < 0) return;

            Boolean breakPointMark = IsMarker(sender, markerNumBreakPoint, line);
            if ((breakPointMark)
                || (!breakPointMark && breakPointManager.IsContainBrekPoint(sender.FileName, line)))
            {
                Boolean enable = !IsMarker(sender, markerNumBreakPointDisable, line);

                if (fdbWrapper.IsDebugStart)
                {
                    breakPointManager.SetBreakPointInfoInDeubg(sender.FileName, line, !breakPointMark, enable);
                }
                else
                {
                    breakPointManager.SetBreakPointInfo(sender.FileName, line, !breakPointMark, enable);
                }
            }

            if (breakPointMark)
            {
                if(!IsMarker(sender, markerNumBreakPointEnable, line))
                    sender.MarkerAdd(line, markerNumBreakPointEnable);
            }
            else
            {
                if(IsMarker(sender, markerNumBreakPointEnable, line))
                {
                    sender.MarkerDelete(line, markerNumBreakPointEnable);
                }
                if(IsMarker(sender, markerNumBreakPointDisable, line))
                {
                    sender.MarkerDelete(line, markerNumBreakPointDisable);
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void RemoveSciEvent(String value)
        {
            ScintillaControl sci = GetScintillaControl(Path.GetFileName(value));
            sci.ModEventMask |= (Int32)ScintillaNet.Enums.ModificationFlags.ChangeMarker;
            sci.MarkerChanged -= new MarkerChangedHandler(SciControl_MarkerChanged);
        }

        /// <summary>
        /// 
        /// </summary>
        private void BuildCurrentProject()
        {
            DataEvent de = new DataEvent(EventType.Command, "ProjectManager.BuildProject", null);
            EventManager.DispatchEvent(this, de);
        }

        /// <summary>
        /// 
        /// </summary>
        private void UpdateMenuState(FdbState state)
        {
            switch (state)
            {
                case FdbState.INIT:
                    foreach (ToolStripItem item in toolbarButtons)
                    {
                        if (PluginBase.MainForm.ToolStrip.Items.Contains(item))
                        {
                            PluginBase.MainForm.ToolStrip.Items.Remove(item);
                        }
                    }
                    StartNoDebugButton.Enabled = true;
                    StartNoDebugMenu.Enabled = true;
                    StartMenu.Enabled = true;
                    PauseButton.Enabled = false;
                    PauseMenu.Enabled = false;
                    StopButton.Enabled = false;
                    StopMenu.Enabled = false;
                    ContinueButton.Enabled = false;
                    ContinueMenu.Enabled = false;
                    StepButton.Enabled = false;
                    StepMenu.Enabled = false;
                    NextButton.Enabled = false;
                    NextMenu.Enabled = false;
                    PluginBase.MainForm.BreakpointsEnabled = true;

                    FinishButton.Enabled = false;
                    FinishMenu.Enabled = false;
                    ToggleBreakPointMenu.Enabled = true;
                    ToggleBreakPointEnableMenu.Enabled = true;
                    DeleteAllBreakPointsMenu.Enabled = true;
                    DisableAllBreakPointsMenu.Enabled = true;
                    EnableAllBreakPointsMenu.Enabled = true;
                    breakPointUI.Enabled = true;

                    QuickWatchItem.Enabled = false;
                    break;

                case FdbState.START:
                    PauseButton.Enabled = true;
                    PauseMenu.Enabled = true;
                    StopButton.Enabled = true;
                    StopMenu.Enabled = true;
                    ContinueButton.Enabled = false;
                    ContinueMenu.Enabled = false;
                    StepButton.Enabled = false;
                    StepMenu.Enabled = false;
                    NextButton.Enabled = false;
                    NextMenu.Enabled = false;
                    PluginBase.MainForm.BreakpointsEnabled = false;

                    FinishButton.Enabled = false;
                    FinishMenu.Enabled = false;
                    ToggleBreakPointMenu.Enabled = false;
                    ToggleBreakPointEnableMenu.Enabled = false;
                    DeleteAllBreakPointsMenu.Enabled = false;
                    DisableAllBreakPointsMenu.Enabled = false;
                    EnableAllBreakPointsMenu.Enabled = false;
                    breakPointUI.Enabled = false;

                    QuickWatchItem.Enabled = false;
                    break;

                case FdbState.STEP:
                case FdbState.NEXT:
                case FdbState.BREAK:
                    PauseButton.Enabled = false;
                    PauseMenu.Enabled = false;
                    StopButton.Enabled = true;
                    StopMenu.Enabled = true;
                    ContinueButton.Enabled = true;
                    ContinueMenu.Enabled = true;
                    StepButton.Enabled = true;
                    StepMenu.Enabled = true;
                    NextButton.Enabled = true;
                    NextMenu.Enabled = true;
                    PluginBase.MainForm.BreakpointsEnabled = true;

                    FinishButton.Enabled = true;
                    FinishMenu.Enabled = true;
                    ToggleBreakPointMenu.Enabled = true;
                    ToggleBreakPointEnableMenu.Enabled = true;
                    DeleteAllBreakPointsMenu.Enabled = true;
                    DisableAllBreakPointsMenu.Enabled = true;
                    EnableAllBreakPointsMenu.Enabled = true;
                    breakPointUI.Enabled = true;

                    QuickWatchItem.Enabled = true;
                    break;

                case FdbState.CONTINUE:
                    PauseButton.Enabled = true;
                    PauseMenu.Enabled = true;
                    StopButton.Enabled = true;
                    StopMenu.Enabled = true;
                    ContinueButton.Enabled = false;
                    ContinueMenu.Enabled = false;
                    StepButton.Enabled = false;
                    StepMenu.Enabled = false;
                    NextButton.Enabled = false;
                    NextMenu.Enabled = false;
                    PluginBase.MainForm.BreakpointsEnabled = false;

                    FinishButton.Enabled = false;
                    FinishMenu.Enabled = false;
                    ToggleBreakPointMenu.Enabled = false;
                    ToggleBreakPointEnableMenu.Enabled = false;
                    DeleteAllBreakPointsMenu.Enabled = false;
                    DisableAllBreakPointsMenu.Enabled = false;
                    EnableAllBreakPointsMenu.Enabled = false;
                    breakPointUI.Enabled = false;

                    QuickWatchItem.Enabled = false;
                    break;

                case FdbState.PAUSE:
                    PauseButton.Enabled = false;
                    PauseMenu.Enabled = false;
                    StopButton.Enabled = true;
                    StopMenu.Enabled = true;
                    ContinueButton.Enabled = true;
                    ContinueMenu.Enabled = true;
                    StepButton.Enabled = false;
                    StepMenu.Enabled = false;
                    NextButton.Enabled = false;
                    NextMenu.Enabled = false;
                    PluginBase.MainForm.BreakpointsEnabled = true;

                    FinishButton.Enabled = false;
                    FinishMenu.Enabled = false;
                    ToggleBreakPointMenu.Enabled = true;
                    ToggleBreakPointEnableMenu.Enabled = true;
                    DeleteAllBreakPointsMenu.Enabled = true;
                    DisableAllBreakPointsMenu.Enabled = true;
                    EnableAllBreakPointsMenu.Enabled = true;
                    breakPointUI.Enabled = true;

                    QuickWatchItem.Enabled = true;
                    break;
                case FdbState.PAUSE_SET_BREAKPOINT:
                    StartMenu.Enabled = false;
                    StartMenu.Enabled = false;
                    PauseButton.Enabled = false;
                    PauseMenu.Enabled = false;
                    StopButton.Enabled = true;
                    StopMenu.Enabled = true;
                    ContinueButton.Enabled = true;
                    ContinueMenu.Enabled = true;
                    StepButton.Enabled = false;
                    StepMenu.Enabled = false;
                    NextButton.Enabled = false;
                    NextMenu.Enabled = false;
                    PluginBase.MainForm.BreakpointsEnabled = true;

                    FinishButton.Enabled = false;
                    FinishMenu.Enabled = false;
                    ToggleBreakPointMenu.Enabled = true;
                    ToggleBreakPointEnableMenu.Enabled = true;
                    DeleteAllBreakPointsMenu.Enabled = true;
                    DisableAllBreakPointsMenu.Enabled = true;
                    EnableAllBreakPointsMenu.Enabled = true;
                    breakPointUI.Enabled = true;

                    QuickWatchItem.Enabled = true;
                    break;
                case FdbState.EXCEPTION:
                    StartMenu.Enabled = false;
                    PauseButton.Enabled = false;
                    PauseMenu.Enabled = false;
                    StopButton.Enabled = true;
                    StopMenu.Enabled = true;
                    ContinueButton.Enabled = true;
                    ContinueMenu.Enabled = true;
                    StepButton.Enabled = false;
                    StepMenu.Enabled = false;
                    NextButton.Enabled = false;
                    NextMenu.Enabled = false;
                    PluginBase.MainForm.BreakpointsEnabled = false;

                    FinishButton.Enabled = false;
                    FinishMenu.Enabled = false;
                    ToggleBreakPointMenu.Enabled = false;
                    ToggleBreakPointEnableMenu.Enabled = false;
                    DeleteAllBreakPointsMenu.Enabled = false;
                    DisableAllBreakPointsMenu.Enabled = false;
                    EnableAllBreakPointsMenu.Enabled = false;
                    breakPointUI.Enabled = false;

                    QuickWatchItem.Enabled = true;
                    break;

                case FdbState.WAIT:
                    PluginBase.MainForm.ToolStrip.Items.AddRange(toolbarButtons);
                    StartNoDebugButton.Enabled = false;
                    StartNoDebugMenu.Enabled = false;
                    StartMenu.Enabled = false;
                    PauseButton.Enabled = false;
                    PauseMenu.Enabled = false;
                    StopButton.Enabled = false;
                    StopMenu.Enabled = false;
                    ContinueButton.Enabled = false;
                    ContinueMenu.Enabled = false;
                    StepButton.Enabled = false;
                    StepMenu.Enabled = false;
                    NextButton.Enabled = false;
                    NextMenu.Enabled = false;
                    PluginBase.MainForm.BreakpointsEnabled = false;

                    FinishButton.Enabled = false;
                    FinishMenu.Enabled = false;
                    ToggleBreakPointMenu.Enabled = false;
                    ToggleBreakPointEnableMenu.Enabled = false;
                    DeleteAllBreakPointsMenu.Enabled = false;
                    DisableAllBreakPointsMenu.Enabled = false;
                    EnableAllBreakPointsMenu.Enabled = false;
                    breakPointUI.Enabled = false;

                    QuickWatchItem.Enabled = false;
                    break;
            }
            PluginBase.MainForm.RefreshUI();
        }

        /// <summary>
        /// 
        /// </summary>
        private void DataTipTree_Expanding(Object sender, Aga.Controls.Tree.TreeViewAdvEventArgs e)
        {
            if (e.Node.Index >= 0)
            {
                DataNode node = e.Node.Tag as DataNode;
                if (RegexManager.RegexObject.IsMatch(node.Value))
                {
                    String path = dataTip.DataTree.GetFullPath(node) + ".";
                    fdbWrapper.Print(dataTip, path, "expand");
                }
            }
        }

        private void LocalVariablesTreeExpanding(Object sender, Aga.Controls.Tree.TreeViewAdvEventArgs e)
        {
            if (e.Node.Index >= 0)
            {
                DataNode node = e.Node.Tag as DataNode;
                if (node.Nodes.Count == 0 && RegexManager.RegexObject.IsMatch(node.Value))
                {
                    this.pluginUI.TreeControl.Enabled = false;
                    String path = this.pluginUI.TreeControl.GetFullPath(node) + ".";
                    fdbWrapper.Print(pluginUI, path, "expand");
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void settingObject_PathChangedEvent(String path)
        {
            if (File.Exists(path))
            {
                String title = " " + TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
                String message = String.Format(TextHelper.GetString("FdbPlugin.Info.AssociateFilesWith"), path);
                if (MessageBox.Show(message, title, MessageBoxButtons.OKCancel) == DialogResult.OK)
                {
                    Util.RegAssociatedExecutable(".swf", "open", path);
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        public void OpenLocalVariablesPanel(Object sender, System.EventArgs e)
        {
            this.pluginPanel.Show();
        }

        //break
        /// <summary>
        /// 
        /// </summary>
        public void OpenBreakPointPanel(Object sender, System.EventArgs e)
        {
            this.breakPointPanel.Show();
        }

        public void OpenStackframePanel(Object sender, System.EventArgs e)
        {
            this.stackframePanel.Show();
        }

        /// <summary>
        /// 
        /// </summary>
        private void AddSettingsListeners()
        {
            settingObject.PathChangedEvent += settingObject_PathChangedEvent;
            settingObject.FlexSDKLocaleChangedEvent += settingObject_FlexSDKLocaleChangedEvent;
        }

        void settingObject_FlexSDKLocaleChangedEvent(FlexSDKLocale locate)
        {
            SetFlexSDKLocale(locate);
        }

        /// <summary>
        /// 
        /// </summary>
        private void RemoveSettingsListeners()
        {
            settingObject.PathChangedEvent -= settingObject_PathChangedEvent;
            settingObject.FlexSDKLocaleChangedEvent -= settingObject_FlexSDKLocaleChangedEvent;

        }

		#endregion

        #region Helper Methods

        /// <summary>
        /// 
        /// </summary>
        private String GetWordRes(ScintillaControl sci, Int32 position)
        {
            Char c; String word = "";
            position--;
            while (position >= 0)
            {
                c = (Char)sci.CharAt(position);
                if (exclude.IndexOf(c) < 0) break;
                else word = c + word;
                position--;
            }
            return word;
        }

        /// <summary>
        /// 
        /// </summary>
        public void ToggleMarker(ScintillaControl sci, Int32 marker, Int32 line)
        {
            Int32 lineMask = sci.MarkerGet(line);
            if ((lineMask & GetMarkerMask(marker)) == 0)
                sci.MarkerAdd(line, marker);
            else
                sci.MarkerDelete(line, marker);
        }

        private Boolean IsBreakPointEnable(ScintillaControl sci, Int32 line)
        {
            Int32 lineMask = sci.MarkerGet(line);
            return (lineMask & GetMarkerMask(markerNumBreakPoint)) !=0  ? true : false;
        }

        private Boolean IsMarker(ScintillaControl sci, Int32 marker, Int32 line)
        {
            Int32 lineMask = sci.MarkerGet(line);
            return (lineMask & GetMarkerMask(marker)) != 0 ? true : false;
        }

        /// <summary>
        /// 
        /// </summary>
        private Int32 GetMarkerMask(Int32 marker)
        {
            return 1 << marker;
        }

        /// <summary>
        /// 
        /// </summary>
        private void AddHighlights(ScintillaControl sci, Int32 line)
        {
            Int32 start = sci.PositionFromLine(line);
            Int32 end = start + sci.LineLength(line);
            Int32 position = start;
            Int32 es = sci.EndStyled;
            Int32 mask = 1 << sci.StyleBits;
            sci.SetIndicStyle(0, (Int32)ScintillaNet.Enums.IndicatorStyle.Max);
            sci.SetIndicFore(0, DataConverter.ColorToInt32(settingObject.DebugLineColor));
            sci.StartStyling(position, mask);
            sci.SetStyling(end - start, mask);
            sci.StartStyling(es, mask - 1);
        }

        /// <summary>
        /// 
        /// </summary>
        private void RemoveHighlights(ScintillaControl sci)
        {
            if (sci == null) return;
            Int32 es = sci.EndStyled;
            Int32 mask = (1 << sci.StyleBits);
            sci.StartStyling(0, mask);
            sci.SetStyling(sci.TextLength, 0);
            sci.StartStyling(es, mask - 1);
        }

        /// <summary>
        /// 
        /// </summary>
        private ScintillaControl GetScintillaControl(string name)
        {
            ITabbedDocument[] documents = PluginBase.MainForm.Documents;
            foreach (ITabbedDocument docment in documents)
            {
                ScintillaControl sci = docment.SciControl;
                if (sci != null && name == sci.FileName) return sci;
            }
            return null;
        }

        /// <summary>
        /// 
        /// </summary>
        private Int32 GetScintillaControlIndex(ScintillaControl sci)
        {
            ITabbedDocument[] documents = PluginBase.MainForm.Documents;
            for (Int32 i = 0; i < documents.Length; i++)
            {
                if (documents[i].SciControl == sci) return i;
            }
            return -1;
        }

        void fdbWrapper_PuaseNotRespondEvent(object sender)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate()
                {
                    DialogResult res = MessageBox.Show(PluginBase.MainForm, "Close Process?", "Not Respond", MessageBoxButtons.OKCancel);
                    if (res == DialogResult.OK)
                    {
                        fdbWrapper.Stop(processname, false);
                    }
                    else
                    {
                        UpdateMenuState(FdbState.CONTINUE);
                    }
                });
            }
            else
            {
                DialogResult res = MessageBox.Show(PluginBase.MainForm, "Close Process?", "Not Respond", MessageBoxButtons.OKCancel);
                if (res == DialogResult.OK)
                {
                    fdbWrapper.Stop(processname, false);
                }
                else
                {
                    UpdateMenuState(FdbState.CONTINUE);
                }
            }
        }

        private static Process targetProcess = null;
        private static IntPtr targetHwnd = IntPtr.Zero;

        /// <summary>
        /// find player exception dialog
        /// </summary>
        public static int EnumerateWindows(IntPtr hWnd, int lParam)
        {
            uint procId = 0;
            uint result = Util.GetWindowThreadProcessId(hWnd, out procId);
            if (procId == targetProcess.Id)
            {
                StringBuilder sb = new StringBuilder(0x1000);
                if (Util.GetWindowText(hWnd, sb, 0x1000) != 0)
                {
                    if (sb.ToString().Contains("Adobe Flash Player"))
                    {
                        targetHwnd = hWnd;
                        return 0;
                    }
                }
            }
            return 1;
        }

        public ITabbedDocument GetDocument(string filefullpath)
        {
            ITabbedDocument[] documents = PluginBase.MainForm.Documents;
            foreach (ITabbedDocument docment in documents)
            {
                ScintillaControl sci = docment.SciControl;
                if (sci != null && filefullpath == sci.FileName) return docment;
            }

            return null;
        }

        public void ActiveDocument(string filefullpath)
        {
            ActiveDocument(filefullpath, -1, false);
        }

        public void ActiveDocument(string filefullpath, int line, Boolean selectline)
        {
            ScintillaControl sci = GetScintillaControl(filefullpath);
            if (sci == null)
            {
                PluginBase.MainForm.OpenEditableDocument(filefullpath);
                sci = GetScintillaControl(filefullpath);
            }

            CurrentDebugPostion.fullpath = filefullpath;
            Int32 i = GetScintillaControlIndex(sci);
            PluginBase.MainForm.Documents[i].Activate();
            if (line >= 0)
            {
                sci.GotoLine(line);
                if (selectline)
                {
                    Int32 start = sci.PositionFromLine(line);
                    Int32 end = start + sci.LineLength(line);
                    sci.SelectionStart = start;
                    sci.SelectionEnd = end;
                }
            }
        }

        #endregion

    }
	
}
