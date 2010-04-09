/*
    Copyright (C) 2009  Robert Nelson

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/

using System;
using System.ComponentModel;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using ASCompletion.Context;
using FlexDbg.Localization;
using PluginCore;
using PluginCore.Helpers;
using PluginCore.Managers;
using PluginCore.Utilities;
using ProjectManager.Projects;
using ProjectManager.Projects.AS3;

namespace FlexDbg
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "FlexDbg";
		private String pluginHelp = "http://www.flashdevelop.org/community/viewtopic.php?f=4&t=4660";
        private String pluginDesc = "Hosts the ActionScript 3 debugger in FlashDevelop.";
        private String pluginAuth = "Robert Nelson";
        private String settingFilename;
        private Image pluginImage;

        private MenusHelper menusHelper;
        private PanelsHelper panelsHelpers;

		static internal LiveDataTip liveDataTip;
		static internal Settings settingObject;
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
            InitBasics();
            LoadSettings();
            AddEventHandlers();
            InitLocalization();
            CreateMenuItems();
            CreatePluginPanel();

            //debug
            FlexDbgTrace.init();
            FlexDbgTrace.IsTraceLog = settingObject.EnableLogging;
            FlexDbgTrace.Trace("--------------------------");
            FlexDbgTrace.Trace("---FlexDbgTrace Start---");
        }
		
		/// <summary>
		/// Disposes the plugin
		/// </summary>
		public void Dispose()
		{
            SaveSettings();
            
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
                case EventType.FileOpen:
                    TextEvent evnt = (TextEvent)e;
                    ScintillaHelper.AddSciEvent(evnt.Value);
                    breakPointManager.SetBreakPointsToEditor(evnt.Value);
                    break;

                case EventType.UIStarted:
                    menusHelper.UpdateMenuState(this, DebuggerState.Initializing);
                    CheckValidFile(!disableDebugger);
                    break;
                
                case EventType.UIClosing:
					if (debugManager.FlashInterface.isDebuggerStarted)
					{
						String title = " " + PluginCore.Localization.TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
						switch (MessageBox.Show(TextHelper.GetString("Info.PlayerStillRunning"), title, MessageBoxButtons.YesNoCancel))
						{
							case DialogResult.Yes:
							default:
								debugManager.FlashInterface.Stop();
								break;

							case DialogResult.No:
								debugManager.FlashInterface.Detach();
								break;

							case DialogResult.Cancel:
								e.Handled = true;
								break;
						}
					}

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
						menusHelper.UpdateMenuState(this, DebuggerState.Initializing);
                    }
                    break;

                case EventType.Command:
                    PluginCore.DataEvent buildevnt = (PluginCore.DataEvent)e;

                    if (buildevnt.Action == "AS3Context.StartDebugger")
                    {
                        if (settingObject.StartDebuggerOnTestMovie)
                        {
                            // TODO Detect what sort of TestMovieBehavior is set (or some other way) to disable debugging of ActiveX player
                            buildevnt.Handled = true;
                            debugManager.Start();
                        }
                        return;
                    }

                    if (!buildevnt.Action.StartsWith("ProjectManager"))
                        return;

                    if (buildevnt.Action == ProjectManager.ProjectManagerEvents.Project)
                    {
                        IProject project = PluginBase.CurrentProject;
                        if (project != null && project is AS3Project)
                        {
                            disableDebugger = false;
                            CheckValidFile(true);

                            PanelsHelper.breakPointUI.Clear();
                            breakPointManager.Project = project;
                            breakPointManager.Load();
                            breakPointManager.SetBreakPointsToEditor(PluginBase.MainForm.Documents);
                        }
                        else
                        {
                            disableDebugger = true;
                            CheckValidFile(false);

                            if (breakPointManager.Project != null)
                            {
                                breakPointManager.Save();
                            }
                            PanelsHelper.breakPointUI.Clear();
                        }
                    }
                    else if (disableDebugger)
						return;

                    if (debugBuildStart && buildevnt.Action == ProjectManager.ProjectManagerEvents.BuildFailed)
                    {
                        debugBuildStart = false;
                        buildCmpFlg = false;
                        menusHelper.UpdateMenuState(this, DebuggerState.Initializing);
                    }

                    else if (buildevnt.Action == ProjectManager.ProjectManagerEvents.TestProject)
                    {
                        if (debugManager.FlashInterface.isDebuggerStarted)
                        {
                            if (debugManager.FlashInterface.isDebuggerSuspended)
                            {
                                debugManager.Continue_Click(null, null);
                            }
                            e.Handled = true;
                            return;
                        }
                        debugBuildStart = false;
                        buildCmpFlg = false;
                        menusHelper.UpdateMenuState(this, DebuggerState.Initializing);
                    }

#if false
                    else if (buildevnt.Action == "ProjectManager.TestingProject")
                    {
                        // no new build while debugging
                        if (debugBuildStart || debugManager.FlashInterface.isDebuggerStarted)
                        {
                            buildevnt.Handled = true;
                            return;
                        }
                        Project newProject = PluginBase.CurrentProject as AS3Project;
                        if (newProject != null && !newProject.NoOutput && 
							buildevnt.Data.ToString() == "Debug")
                        {
                            buildevnt.Handled = true;
                            debugManager.currentProject = newProject;
                            debugManager.Start();
                            buildCmpFlg = true;
                        }
                        else debugManager.currentProject = null;
                    }
#endif
                    else if (debugBuildStart && buildevnt.Action == ProjectManager.ProjectManagerEvents.BuildProject
                        && buildevnt.Data.ToString() == "Debug")
                    {
                        buildCmpFlg = true;
                    }
                    else if (buildevnt.Action == ProjectManager.ProjectManagerEvents.BuildFailed)
                    {
                        menusHelper.OnBuildFailed();
                        debugBuildStart = false;
                        buildCmpFlg = false;
                    }
                    else if (buildCmpFlg && buildevnt.Action == ProjectManager.ProjectManagerEvents.BuildComplete)
                    {
                        if (buildCmpFlg)
                        {
                            debugManager.Start(debugManager.currentProject.OutputPathAbsolute);
                        }
                        else menusHelper.OnBuildComplete();

                        debugBuildStart = false;
                        buildCmpFlg = false;
                        menusHelper.UpdateMenuState(this, DebuggerState.Stopped);
                    }
                    break;
            }
        }

        private void CheckValidFile(bool state)
        {
            ITabbedDocument document = PluginBase.MainForm.CurrentDocument;
            if (document != null && document.IsEditable &&
				(document.FileName.EndsWith(".as") || document.FileName.EndsWith(".mxml")) &&
				ASContext.Context.IsFileValid)
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
            String dataPath = Path.Combine(PathHelper.DataDir, "FlexDbg");

			if (!Directory.Exists(dataPath))
				Directory.CreateDirectory(dataPath);

			this.settingFilename = Path.Combine(dataPath, "Settings.FlexDbg");
            String bkPath = Path.Combine(dataPath, "Breakpoints");

			if (!Directory.Exists(bkPath))
				Directory.CreateDirectory(bkPath);

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
            pluginDesc = TextHelper.GetString("Info.Description");
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            EventManager.AddEventHandler(this, EventType.FileEmpty | EventType.FileOpen | EventType.FileSwitch | EventType.ProcessStart | EventType.ProcessEnd | EventType.Command | EventType.UIClosing);
            EventManager.AddEventHandler(this, EventType.UIStarted, HandlingPriority.Low);
            EventManager.AddEventHandler(this, EventType.Command, HandlingPriority.High);
        }

        #endregion

        #region settings management

        /// <summary>
        /// Loads the plugin settings
        /// </summary>
        public void LoadSettings()
        {
            settingObject = new Settings();

            if (!File.Exists(this.settingFilename))
				SaveSettings();
            else
            {
                Object obj = ObjectSerializer.Deserialize(this.settingFilename, settingObject);
                settingObject = (Settings)obj;
            }

#if false
            if (settingObject.DebugFlashPlayerPath == null || settingObject.DebugFlashPlayerPath.Length == 0)
                settingObject.DebugFlashPlayerPath = DetectFlashPlayer();
#endif
            // AddSettingsListeners();
        }

#if false
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
#endif

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            // RemoveSettingsListeners();
            ObjectSerializer.Serialize(this.settingFilename, settingObject);
            // AddSettingsListeners();
        }

#if false
        /// <summary>
        /// 
        /// </summary>
        private void settingObject_PathChangedEvent(String path)
        {
            if (File.Exists(path))
            {
				String title = " " + PluginCore.Localization.TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
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
#endif

		#endregion
	}
}
