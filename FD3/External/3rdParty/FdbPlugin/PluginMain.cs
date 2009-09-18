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
        private String pluginDesc = "Hosts the ActionScript 3 debugger in FlashDevelop.";
        private String pluginAuth = "FlashDevelop Team";
        private String settingFilename;
        static internal Settings settingObject;
        private Image pluginImage;

        private MenusHelper menusHelper;
        private PanelsHelper panelsHelpers;
        private LiveDataTip liveDataTip;

        static internal BreakPointManager breakPointManager;
        static internal DebuggerManager debugManager;
        static internal Boolean disableDebugger = false;
        static internal Boolean debugBuildStart;

        private Boolean buildCmpFlg = false;

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
			get { return PanelsHelper.pluginGuid; }
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
            get { return settingObject; }
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
            this.CreateMenuItems();
            this.CreatePluginPanel();

            //debug
            FdbPluginTrace.init();
            FdbPluginTrace.IsTraceLog = settingObject.EnableLogging;
            FdbPluginTrace.Trace("--------------------------");
            FdbPluginTrace.Trace("---fdbPluginTrace Start---");
        }
		
		/// <summary>
		/// Disposes the plugin
		/// </summary>
		public void Dispose()
		{
            this.SaveSettings();
            debugManager.Cleanup();
		}

		/// <summary>
		/// Handles the incoming events
		/// </summary>
		public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
		{
            if (debugManager == null)
                return;

            switch (e.Type)
            {
                case EventType.FileOpen :
                    TextEvent evnt = (TextEvent)e;
                    ScintillaHelper.AddSciEvent(evnt.Value); // TODO make a centralized event in UITools

                    //break
                    breakPointManager.SetBreakPointsToEditor(evnt.Value);

                    break;

                case EventType.UIStarted:
                    menusHelper.UpdateMenuState(this, FdbState.INIT);
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
                        menusHelper.UpdateMenuState(this, FdbState.INIT);
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
                            menusHelper.AddStartNoDebugButton();
                            CheckValidFile(true);

                            PanelsHelper.breakPointUI.Clear();
                            breakPointManager.Project = project;
                            breakPointManager.Load();
                            breakPointManager.SetBreakPointsToEditor(PluginBase.MainForm.Documents);
                        }
                        else
                        {
                            disableDebugger = true;
                            menusHelper.RemoveStartNoDebugButton();
                            CheckValidFile(false);

                            if(breakPointManager.Project != null)
                            {
                                breakPointManager.Save();
                            }
                            PanelsHelper.breakPointUI.Clear();
                        }
                    }
                    else if (disableDebugger) return;

                    if (debugBuildStart && buildevnt.Action == "ProjectManager.BuildFailed")
                    {
                        debugBuildStart = false;
                        buildCmpFlg = false;
                        menusHelper.UpdateMenuState(this, FdbState.INIT);
                    }

                    else if (buildevnt.Action == "ProjectManager.TestingProject")
                    {
                        // no new build while debugging
                        if (debugBuildStart || debugManager.FdbWrapper.IsDebugStart)
                        {
                            buildevnt.Handled = true;
                            return;
                        }
                        Project newProject = PluginBase.CurrentProject as AS3Project;
                        if (newProject != null && !newProject.NoOutput 
                            && buildevnt.Data.ToString() == "Debug")
                        {
                            buildevnt.Handled = true;
                            debugManager.currentProject = newProject;
                            debugManager.Start();
                            buildCmpFlg = true;
                        }
                        else debugManager.currentProject = null;
                    }

                    else if (debugBuildStart && buildevnt.Action == "ProjectManager.BuildingProject" 
                        && buildevnt.Data.ToString() == "Debug")
                    {
                        buildCmpFlg = true;
                    }
                    else if (buildevnt.Action == "ProjectManager.BuildFailed")
                    {
                        menusHelper.OnBuildFailed();
                        debugBuildStart = false;
                        buildCmpFlg = false;
                    }
                    else if (buildevnt.Action == "ProjectManager.BuildComplete")
                    {
                        if (buildCmpFlg)
                        {
                            debugManager.Start(debugManager.currentProject.OutputPathAbsolute);
                        }
                        else menusHelper.OnBuildComplete();

                        debugBuildStart = false;
                        buildCmpFlg = false;
                    }
                    break;
            }
        }

        private void CheckValidFile(bool state)
        {
            ITabbedDocument document = PluginBase.MainForm.CurrentDocument;
            if (document != null && document.IsEditable && (document.FileName.EndsWith(".as") || document.FileName.EndsWith(".mxml")) && ASContext.Context.IsFileValid) //&& ASContext.Context.CurrentModel.Version == 3)
            {
                PluginBase.MainForm.BreakpointsEnabled = state;
            }
        }
		
		#endregion

        #region Custom Methods

        /// <summary>
        /// Initializes important variables
        /// </summary>
        void InitBasics()
        {
            String dataPath = Path.Combine(PathHelper.DataDir, "FdbPlugin");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            String bkPath = Path.Combine(dataPath, "Breakpoints");
            if (!Directory.Exists(bkPath)) Directory.CreateDirectory(bkPath);
            this.pluginImage = PluginBase.MainForm.FindImage("51");

            PluginBase.MainForm.BreakpointsEnabled = true;
            breakPointManager = new BreakPointManager();

            debugManager = new DebuggerManager();
            liveDataTip = new LiveDataTip();
        }

        void CreateMenuItems()
        {
            menusHelper = new MenusHelper(pluginImage, debugManager, settingObject);
        }

        /// <summary>
        /// Creates a plugin panel for the plugin
        /// </summary>
        public void CreatePluginPanel()
        {
            panelsHelpers = new PanelsHelper(this, pluginImage);
        }

        /// <summary>
        /// Initializes the localization of the plugin
        /// </summary>
        public void InitLocalization()
        {
            this.pluginDesc = TextHelper.GetString("FdbPlugin.Info.Description");

            SetFlexSDKLocale(settingObject.FlexSdkLocale);
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
            regexManager.SetRegex(debugManager.FdbWrapper);
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            EventManager.AddEventHandler(this, EventType.FileEmpty | EventType.FileOpen | EventType.FileSwitch | EventType.ProcessStart | EventType.ProcessEnd | EventType.Command | EventType.UIClosing);
            EventManager.AddEventHandler(this, EventType.UIStarted, HandlingPriority.Low);
        }

        #endregion

        #region settings management

        /// <summary>
        /// Loads the plugin settings
        /// </summary>
        public void LoadSettings()
        {
            settingObject = new Settings();
            if (!File.Exists(this.settingFilename)) this.SaveSettings();
            else
            {
                Object obj = ObjectSerializer.Deserialize(this.settingFilename, settingObject);
                settingObject = (Settings)obj;
            }
            if (settingObject.DebugFlashPlayerPath == null || settingObject.DebugFlashPlayerPath.Length == 0)
                settingObject.DebugFlashPlayerPath = DetectFlashPlayer();
            AddSettingsListeners();
        }

        private string DetectFlashPlayer()
        {
            String cmd;
            String path = String.Empty;
            try
            {
                cmd = Util.FindAssociatedExecutableFile(".swf", "open");
                path = Util.GetAssociateAppFullPath(cmd);

                if (path != null && path != string.Empty)
                {
                    path = path.Trim().Trim(new char[] { '"' });
                }
            }
            catch
            {
                path = String.Empty;
            }
            return path;
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            RemoveSettingsListeners();
            ObjectSerializer.Serialize(this.settingFilename, settingObject);
            AddSettingsListeners();
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

    }
	
}
