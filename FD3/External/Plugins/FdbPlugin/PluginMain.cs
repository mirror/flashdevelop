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
using ASCompletion.Completion;
using ProjectManager.Projects.AS3;
using ProjectManager.Projects;
using ASCompletion.Model;
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

        private Point dataTipPoint;
        private ImageList imageList;
        private FdbWrapper fdbWrapper;
        private Project currentProject;
        private ToolStripItem[] toolbarButtons;
        private MouseMessageFilter mouseMessageFilter;
        private String AssociateExecutableFilePath, processname;
        private ToolStripButton PauseButton, StopButton, ContinueButton, StepButton, NextButton, StartNoDebugButton;
        private ToolStripDropDownItem StartMenu, StartNoDebugMenu, PauseMenu, StopMenu, ContinueMenu, StepMenu, NextMenu, KillfdbMenu;
        private Boolean debugBuildStart = false;
        private Boolean buildCmpFlg = false;
        private Boolean disableDebugger = false;

        private static DataTip dataTip;
        private static String exclude = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM0123456789_$.";
        private static Regex reNameValue = new Regex(@"(?<name>.*).*?(\s=\s)(?<value>.*)", RegexOptions.Compiled);
        private static Regex reObject = new Regex(@".*\[Object\s\d*, class='.*'\]", RegexOptions.Compiled);
        private static Char[] chTrims = { '.' };

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
                    break;

                case EventType.UIStarted:
                    CheckValidFile(!disableDebugger);
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
                        }
                        else
                        {
                            disableDebugger = true;
                            RemoveStartNoDebugButton();
                            CheckValidFile(false);
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

        /// <summary>
        /// 
        /// </summary>
        void fdbWrapper_ExceptionEvent(object sender)
        {
            //UpdateMenuState(FdbState.EXCEPTION_CONTINUE);
            Util.EnumWindows(new Util.EnumerateWindowsCallback(EnumerateWindows), 0);
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
        }

        /// <summary>
        /// 
        /// </summary>
        private void fdbWrapper_PrintEvent(Object sender, PrintArg e)
        {
            String name = e.valname;
            if (e.printtype == (int)PrintType.LOCAL)
            {
                pluginUI.TreeControl.Invoke((MethodInvoker)delegate()
                {
                    pluginUI.TreeControl.Tree.BeginUpdate();
                    DataNode node = pluginUI.TreeControl.GetNode(name.Trim(chTrims));
                    if (node.Nodes.Count == 0) return;
                    for (Int32 i = 0; i < node.Nodes.Count; i++)
                    {
                        Match m = reNameValue.Match(e.output[i]);
                        DataNode n = node.Nodes[i] as DataNode;
                        n.Text = m.Groups["name"].Value.Trim();
                        n.Value = m.Groups["value"].Value.Trim();
                    }
                    pluginUI.TreeControl.Tree.EndUpdate();
                });
            }
            else if (e.printtype == PrintType.LOCALEXPAND)
            {
                pluginUI.TreeControl.Invoke((MethodInvoker)delegate()
                {
                    DataNode node = pluginUI.TreeControl.GetNode(name.Trim(chTrims));
                    if (node.Nodes.Count > 0) return;
                    foreach (String data in e.output)
                    {
                        Match m = reNameValue.Match(data);
                        node.Nodes.Add(new DataNode(m.Groups["name"].Value, m.Groups["value"].Value));
                    }
                });
            }
            else if (e.printtype == PrintType.LOCALEXPANDUPDATE)
            {
                pluginUI.TreeControl.Invoke((MethodInvoker)delegate()
                {
                    pluginUI.TreeControl.Tree.BeginUpdate();
                    DataNode node = pluginUI.TreeControl.GetNode(name.Trim(chTrims));
                    if (node.Nodes.Count == 0) return;
                    for (int i = 0; i < node.Nodes.Count; i++)
                    {
                        Match m = reNameValue.Match(e.output[i]);
                        DataNode n = node.Nodes[i] as DataNode;
                        n.Text = m.Groups["name"].Value.Trim();
                        n.Value = m.Groups["value"].Value.Trim();
                    }
                    pluginUI.TreeControl.Tree.EndUpdate();
                });
                leafCount--;
                if (leafCount == 0)
                {
                    (PluginBase.MainForm as Form).Invoke((MethodInvoker)delegate()
                    {
                        UpdateMenuState(fdbWrapper.State);
                    });
                }
            }
            else if (e.printtype == PrintType.DATATIP)
            {
                dataTip.DataTree.Invoke((MethodInvoker)delegate()
                {
                    dataTipPoint.Y += 8;
                    dataTip.Show(dataTipPoint, e.valname, e.output);
                });
            }
            else if (e.printtype == PrintType.DATATIPEXPAND)
            {
                dataTip.DataTree.Invoke((MethodInvoker)delegate()
                {
                    dataTip.AddNodes(e.valname, e.output);
                });
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
                        if ((m = reNameValue.Match(data)).Success)
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
                        if ((m = reNameValue.Match(data)).Success)
                        {
                            String name = m.Groups["name"].Value.Trim();
                            name = name.TrimEnd(chTrims);
                            String value = m.Groups["value"].Value.Trim();
                            DataNode node = pluginUI.TreeControl.GetNode(name);//.Value = value;
                            if (node != null)
                            {
                                if (node.Nodes.Count == 0 && node.IsLeaf && reObject.IsMatch(value))
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
            UpdateMenuState(FdbState.START);
            TraceManager.Add("[Debugging with FDB]");
            OpenLocalVariablesPanel(null, null);
            Application.DoEvents();
            fdbWrapper.CurrentProject = currentProject;
            fdbWrapper.CurrentSettings = AS3Context.PluginMain.Settings;
            fdbWrapper.Outputfilefullpath = filename;
            fdbWrapper.GetBreakPointMark(PluginBase.MainForm.Documents);
            fdbWrapper.Start();
            if (fdbWrapper.State != FdbState.PAUSE_SET_BREAKPOINT
                 && fdbWrapper.State != FdbState.CONTINUE
                && fdbWrapper.State != FdbState.UNLOAD)
            {
                fdbWrapper.InfoLocals();
                UpdatelocalVariablesLeaf();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void Start_Click(Object sender, EventArgs e)
        {
            try
            {
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
                    String message = TextHelper.GetString("Info.DebugWithoutCompiler");
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
        }

        /// <summary>
        /// 
        /// </summary>
        private void Next_Click(Object sender, EventArgs e)
        {
            if (fdbWrapper.State == FdbState.EXCEPTION)
            {
                fdbWrapper.ExceptionContinue();
            }
            else
            {
                UpdateMenuState(FdbState.CONTINUE);
                RemoveHighlights(GetScintillaControl(CurrentDebugPostion.fullpath));
                leafCount = pluginUI.TreeControl.AllHasChildNodes.Count;
                fdbWrapper.Next();
                fdbWrapper.InfoLocals();
                UpdatelocalVariablesLeaf();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void Step_Click(Object sender, EventArgs e)
        {
            if (fdbWrapper.State == FdbState.EXCEPTION)
            {
                fdbWrapper.ExceptionContinue();
            }
            else
            {
                UpdateMenuState(FdbState.CONTINUE);
                RemoveHighlights(GetScintillaControl(CurrentDebugPostion.fullpath));
                fdbWrapper.Step();
                fdbWrapper.InfoLocals();
                UpdatelocalVariablesLeaf();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void Continue_Click(Object sender, EventArgs e)
        {
            if (fdbWrapper.State == FdbState.EXCEPTION)
            {
                fdbWrapper.ExceptionContinue();
            }
            else
            {
                UpdateMenuState(FdbState.CONTINUE);
                RemoveHighlights(GetScintillaControl(CurrentDebugPostion.fullpath));
                fdbWrapper.Continue();
                if (fdbWrapper.State != FdbState.PAUSE_SET_BREAKPOINT)
                {
                    fdbWrapper.InfoLocals();
                    UpdatelocalVariablesLeaf();
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void Pause_Click(Object sender, EventArgs e)
        {
            UpdateMenuState(FdbState.WAIT);
            RemoveHighlights(GetScintillaControl(CurrentDebugPostion.fullpath));
            fdbWrapper.Pause();
        }

        /// <summary>
        /// 
        /// </summary>
        private void Killfdb_Click(Object sender, EventArgs e)
        {
            /*string ProcessName = "fdb";
            Process[] allProcesses = Process.GetProcessesByName(ProcessName);
            foreach (Process oneProcess in allProcesses)
            {
                DialogResult res = MessageBox.Show("Kill fdb Process?", "", MessageBoxButtons.OKCancel);
                if (res == DialogResult.OK)
                {
                    oneProcess.Kill();
                }
            }*/
            fdbWrapper.Cleanup();
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

            String dataPath = Path.Combine(PathHelper.DataDir, "FdbPlugin");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            this.pluginImage = PluginBase.MainForm.FindImage("51");

            UITools.Manager.OnMouseHover += new UITools.MouseHoverHandler(Manager_OnMouseHover);
            PluginBase.MainForm.BreakpointsEnabled = true;

            fdbWrapper = new FdbWrapper();
            fdbWrapper.ContinueEvent += new ContinueEventHandler(fdbWrapper_ContinueEvent);
            fdbWrapper.LocalValuesEvent += new ContinueEventHandler(fdbWrapper_LocalValuesEvent);
            fdbWrapper.PrintEvent += new PrintEventHandler(fdbWrapper_PrintEvent);
            fdbWrapper.StopEvent += new fdbEventHandler(fdbWrapper_StopEvent);
            fdbWrapper.TraceEvent += new TraceEventHandler(fdbWrapper_TraceEvent);
            fdbWrapper.PauseEvent += new fdbEventHandler(fdbWrapper_PauseEvent);
            fdbWrapper.ExceptionEvent += new fdbEventHandler(fdbWrapper_ExceptionEvent);
            fdbWrapper.PuaseNotRespondEvent += new fdbEventHandler(fdbWrapper_PuaseNotRespondEvent);

            if (dataTip == null) dataTip = new DataTip(PluginBase.MainForm);
            mouseMessageFilter = new MouseMessageFilter();
            mouseMessageFilter.AddControls(dataTip.Controls);
            mouseMessageFilter.MouseDownEvent += new MouseDownEventHandler(mouseMessageFilter_MouseDownEvent);
            Application.AddMessageFilter(mouseMessageFilter);
        }

        /// <summary>
        /// Initializes the localization of the plugin
        /// </summary>
        public void InitLocalization()
        {
            this.pluginDesc = TextHelper.GetString("Info.Description");
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            EventManager.AddEventHandler(this, EventType.FileEmpty | EventType.FileOpen | EventType.FileSwitch | EventType.ProcessStart | EventType.ProcessEnd | EventType.Command);
            EventManager.AddEventHandler(this, EventType.UIStarted, HandlingPriority.Low);
        }

        /// <summary>
        /// Creates a menu item for the plugin and adds a ignored key
        /// </summary>
        public void CreateMenuItem()
        {
            ToolStripMenuItem viewMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("ViewMenu");
            viewMenu.DropDownItems.Add(new ToolStripMenuItem(TextHelper.GetString("Label.ViewLocalVariablesPanelMenuItem"), this.pluginImage, new EventHandler(this.OpenLocalVariablesPanel)));

            //Menu           
            ToolStripMenuItem debugMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("DebugMenu");
            if (debugMenu == null)
            {
                debugMenu = new ToolStripMenuItem(TextHelper.GetString("Label.DebugMenuItem"));
                ToolStripMenuItem toolsMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("ToolsMenu");
                Int32 idx = PluginBase.MainForm.MenuStrip.Items.IndexOf(toolsMenu);
                if (idx < 0) idx = PluginBase.MainForm.MenuStrip.Items.Count - 1;
                PluginBase.MainForm.MenuStrip.Items.Insert(idx, debugMenu);
            }
            StartMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Start"), imageList.Images["Continue"], new EventHandler(Start_Click));
            StartNoDebugMenu = new ToolStripMenuItem(TextHelper.GetString("Label.StartNoDebug"), imageList.Images["NoDebug"], new EventHandler(StartNoDebug_Click), this.settingObject.StartNoDebug);
            StopMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Stop"), imageList.Images["Stop"], new EventHandler(Stop_Click), this.settingObject.Stop);
            ContinueMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Continue"), imageList.Images["Continue"], new EventHandler(Continue_Click), this.settingObject.Continue);
            StepMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Step"), imageList.Images["Step"], new EventHandler(Step_Click), this.settingObject.Step);
            NextMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Next"), imageList.Images["Next"], new EventHandler(Next_Click), this.settingObject.Next);
            KillfdbMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Killfdb"), null, new EventHandler(Killfdb_Click), this.settingObject.Next);
            PauseMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Pause"), imageList.Images["Pause"], new EventHandler(Pause_Click), this.settingObject.Pause);

            List<ToolStripItem> items = new List<ToolStripItem>(new ToolStripItem[] { StartMenu, StartNoDebugMenu, PauseMenu, StopMenu, ContinueMenu, StepMenu, NextMenu, KillfdbMenu });
            foreach (ToolStripMenuItem item in items)
            {
                if (item.ShortcutKeys != Keys.None) PluginBase.MainForm.IgnoredKeys.Add(item.ShortcutKeys);
            }
            if (debugMenu.DropDownItems.Count > 0)
            {
                items.Add(new ToolStripSeparator());
                foreach (ToolStripItem item in debugMenu.DropDownItems) items.Add(item);
                debugMenu.DropDownItems.Clear();
            }
            debugMenu.DropDownItems.AddRange(items.ToArray());

            //ToolStrip
            StopButton = new ToolStripButton(TextHelper.GetString("Label.Stop"), imageList.Images["Stop"], new EventHandler(Stop_Click));
            StopButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            ContinueButton = new ToolStripButton(TextHelper.GetString("Label.Continue"), imageList.Images["Continue"], new EventHandler(Continue_Click));
            ContinueButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            StepButton = new ToolStripButton(TextHelper.GetString("Label.Step"), imageList.Images["Step"], new EventHandler(Step_Click));
            StepButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            NextButton = new ToolStripButton(TextHelper.GetString("Label.Next"), imageList.Images["Next"], new EventHandler(Next_Click));
            NextButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            PauseButton = new ToolStripButton(TextHelper.GetString("Label.Pause"), imageList.Images["Pause"], new EventHandler(Pause_Click));
            PauseButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            toolbarButtons = new ToolStripItem[] { new ToolStripSeparator(), PauseButton, StopButton, ContinueButton, StepButton, NextButton };

            StartNoDebugButton = new ToolStripButton(TextHelper.GetString("Label.StartNoDebug"), imageList.Images["NoDebug"], new EventHandler(StartNoDebug_Click));
            StartNoDebugButton.DisplayStyle = ToolStripItemDisplayStyle.Image;

            if (dataTip == null) dataTip = new DataTip(PluginBase.MainForm);
            dataTip.DataTree.Tree.Expanding += new EventHandler<Aga.Controls.Tree.TreeViewAdvEventArgs>(Tree_Expanding);
            UpdateMenuState(FdbState.INIT);
        }

        /// <summary>
        /// Creates a plugin panel for the plugin
        /// </summary>
        public void CreatePluginPanel()
        {
            this.pluginUI = new PluginUI(this);
            this.pluginUI.Text = TextHelper.GetString("Title.LocalVariables");
            this.pluginPanel = PluginBase.MainForm.CreateDockablePanel(this.pluginUI, this.pluginGuid, this.pluginImage, DockState.DockBottom);
        }

        /// <summary>
        /// Loads the plugin settings
        /// </summary>
        public void LoadSettings()
        {
            settingObject = ObjectSerializer.Deserialize<Settings>(this.settingFilename);
            AddSettingsListeners();
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            if (settingObject != null) RemoveSettingsListeners();
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
                errormsg += TextHelper.GetString("Info.NoMainClass") + System.Environment.NewLine;
            }
            if (currentProject.Language != "as3")
            {
                errormsg += TextHelper.GetString("Info.LanguageNotAS3") + System.Environment.NewLine;
            }
            if (AS3Context.PluginMain.Settings.FlexSDK == null || AS3Context.PluginMain.Settings.FlexSDK == string.Empty || !Directory.Exists(AS3Context.PluginMain.Settings.FlexSDK))
            {
                errormsg += TextHelper.GetString("Info.CheckFlexSDKSetting") + System.Environment.NewLine;
            }
            try
            {
                String cmd = Util.FindAssociatedExecutableFile(".swf", "open");
                if (cmd != AssociateExecutableFilePath)
                {
                    processname = Util.GetAssociateAppFileName(cmd);
                    AssociateExecutableFilePath = cmd;
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
        Int32 leafCount = 0;
        private void UpdatelocalVariablesLeaf()
        {
            List<DataNode> list = pluginUI.TreeControl.AllHasChildNodes;
            leafCount = list.Count;
            if (leafCount == 0)
            {
                UpdateMenuState(fdbWrapper.State);
                return;
            }
            foreach (DataNode node in list)
            {
                String fullpath = pluginUI.TreeControl.GetFullPath(node);
                fdbWrapper.Print(fullpath + ".", PrintType.LOCALEXPANDUPDATE);
            }
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
            if (fdbWrapper != null && fdbWrapper.IsDebugStart && (fdbWrapper.State == FdbState.BREAK || fdbWrapper.State == FdbState.NEXT || fdbWrapper.State == FdbState.STEP || fdbWrapper.State == FdbState.EXCEPTION))
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
                    fdbWrapper.Print(leftword, PrintType.DATATIP);
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
        }

        /// <summary>
        /// 
        /// </summary>
        private void SciControl_MarkerChanged(ScintillaControl sender, Int32 line)
        {
            if (line >= 0)
            {
                fdbWrapper.MarkBreakPoint(sender, line);
            }
            else if (fdbWrapper.IsDebugStart)//Delete all breakpoints
            {
                fdbWrapper.DeleteAllBreakPoints();
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
                    break;
            }
            PluginBase.MainForm.RefreshUI();
        }

        /// <summary>
        /// 
        /// </summary>
        private void Tree_Expanding(Object sender, Aga.Controls.Tree.TreeViewAdvEventArgs e)
        {
            if (e.Node.Index >= 0)
            {
                DataNode node = e.Node.Tag as DataNode;
                if (reObject.IsMatch(node.Value))
                {
                    String path = dataTip.DataTree.GetFullPath(node) + ".";
                    fdbWrapper.Print(path, PrintType.DATATIPEXPAND);
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
                String message = String.Format(TextHelper.GetString("Info.AssociateFilesWith"), path);
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

        /// <summary>
        /// 
        /// </summary>
        private void AddSettingsListeners()
        {
            settingObject.PathChangedEvent += settingObject_PathChangedEvent;
        }

        /// <summary>
        /// 
        /// </summary>
        private void RemoveSettingsListeners()
        {
            settingObject.PathChangedEvent -= settingObject_PathChangedEvent;
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
            if ((lineMask & GetMarkerMask(marker)) == 0) sci.MarkerAdd(line, marker);
            else sci.MarkerDelete(line, marker);
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

        /// <summary>
        /// find player exception dialog
        /// </summary>
        public int EnumerateWindows(IntPtr hWnd, int lParam)
        {
            //window isnt visible
            if (Util.IsWindowVisible(hWnd) == 0)
            {
                StringBuilder sb = new StringBuilder(0x1000);
                //get caption
                if (Util.GetWindowText(hWnd, sb, 0x1000) != 0)
                {

                    if (sb.ToString().Contains("Adobe Flash Player"))
                    {
                        Util.SetForegroundWindow(hWnd);
                        UpdateMenuState(FdbState.WAIT);
                        return 0;
                    }
                }
            }
            return 1;
        }

        #endregion

    }
	
}
