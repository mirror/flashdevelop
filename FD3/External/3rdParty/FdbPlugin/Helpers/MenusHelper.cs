using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using PluginCore;
using PluginCore.Localization;
using FdbPlugin.Properties;
using System.Drawing;
using PluginCore.Managers;

namespace FdbPlugin
{
    internal class MenusHelper
    {
        static public ImageList imageList;

        private ToolStripItem[] toolbarButtons;
        private ToolStripButton PauseButton, StopButton, ContinueButton, StepButton, NextButton, StartNoDebugButton,
            FinishButton;
        private ToolStripDropDownItem StartMenu, StartNoDebugMenu, PauseMenu, StopMenu, ContinueMenu, StepMenu, NextMenu, KillfdbMenu,
            FinishMenu,
            ToggleBreakPointMenu, ToggleBreakPointEnableMenu,
            DeleteAllBreakPointsMenu, DisableAllBreakPointsMenu, EnableAllBreakPointsMenu;
        private ToolStripItem QuickWatchItem;

        /// <summary>
        /// Creates a menu item for the plugin and adds a ignored key
        /// </summary>
        public MenusHelper(Image pluginImage, DebuggerManager debugManager, Settings settingObject)
        {
            imageList = new ImageList();
            imageList.Images.Add("Stop", Resource.Stop);
            imageList.Images.Add("Continue", Resource.Continue);
            imageList.Images.Add("Next", Resource.Next);
            imageList.Images.Add("Step", Resource.Step);
            imageList.Images.Add("Pause", Resource.Pause);
            imageList.Images.Add("NoDebug", Resource.StartNoDebug);
            imageList.Images.Add("Finish", Resource.Finish);

            ToolStripMenuItem viewMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("ViewMenu");
            viewMenu.DropDownItems.Add(new ToolStripMenuItem("Local Variables", pluginImage, new EventHandler(this.OpenLocalVariablesPanel)));
            viewMenu.DropDownItems.Add(new ToolStripMenuItem("Breakpoints", pluginImage, new EventHandler(this.OpenBreakPointPanel)));
            viewMenu.DropDownItems.Add(new ToolStripMenuItem("Stackframe", pluginImage, new EventHandler(this.OpenStackframePanel)));

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
            StartNoDebugMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.StartNoDebug"), imageList.Images["NoDebug"], new EventHandler(StartNoDebug_Click), settingObject.StartNoDebug);
            StopMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Stop"), imageList.Images["Stop"], new EventHandler(debugManager.Stop_Click), settingObject.Stop);
            ContinueMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Continue"), imageList.Images["Continue"], new EventHandler(debugManager.Continue_Click), settingObject.Continue);
            StepMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Step"), imageList.Images["Step"], new EventHandler(debugManager.Step_Click), settingObject.Step);
            NextMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Next"), imageList.Images["Next"], new EventHandler(debugManager.Next_Click), settingObject.Next);
            KillfdbMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Killfdb"), null, new EventHandler(debugManager.Killfdb_Click), settingObject.Next);
            PauseMenu = new ToolStripMenuItem(TextHelper.GetString("FdbPlugin.Label.Pause"), imageList.Images["Pause"], new EventHandler(debugManager.Pause_Click), settingObject.Pause);
            FinishMenu = new ToolStripMenuItem("Finish", imageList.Images["Finish"], new EventHandler(debugManager.Finish_Click), settingObject.Finish);

            ToolStripSeparator spMenu = new ToolStripSeparator();

            ToggleBreakPointMenu = new ToolStripMenuItem("Toggle Breakpoint", null, new EventHandler(ScintillaHelper.ToggleBreakPoint_Click), settingObject.ToggleBreakPoint);
            DeleteAllBreakPointsMenu = new ToolStripMenuItem("Delete All Breakpoints", null, new EventHandler(ScintillaHelper.DeleteAllBreakPoints_Click), settingObject.Finish);
            ToggleBreakPointEnableMenu = new ToolStripMenuItem("Toggle Breakpoint Enabled", null, new EventHandler(ScintillaHelper.ToggleBreakPointEnable_Click), settingObject.ToggleBreakPointEnable);
            DisableAllBreakPointsMenu = new ToolStripMenuItem("Disable All Breakpoints", null, new EventHandler(ScintillaHelper.DisableAllBreakPoints_Click), settingObject.DisableAllBreakPoints);
            EnableAllBreakPointsMenu = new ToolStripMenuItem("Enable All Breakpoints", null, new EventHandler(ScintillaHelper.EnableAllBreakPoints_Click), settingObject.EnableAllBreakPoints);


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
            StopButton = new ToolStripButton(TextHelper.GetString("FdbPlugin.Label.Stop"), imageList.Images["Stop"], new EventHandler(debugManager.Stop_Click));
            StopButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            ContinueButton = new ToolStripButton(TextHelper.GetString("FdbPlugin.Label.Continue"), imageList.Images["Continue"], new EventHandler(debugManager.Continue_Click));
            ContinueButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            StepButton = new ToolStripButton(TextHelper.GetString("FdbPlugin.Label.Step"), imageList.Images["Step"], new EventHandler(debugManager.Step_Click));
            StepButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            NextButton = new ToolStripButton(TextHelper.GetString("FdbPlugin.Label.Next"), imageList.Images["Next"], new EventHandler(debugManager.Next_Click));
            NextButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            PauseButton = new ToolStripButton(TextHelper.GetString("FdbPlugin.Label.Pause"), imageList.Images["Pause"], new EventHandler(debugManager.Pause_Click));
            PauseButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            FinishButton = new ToolStripButton("Finish", imageList.Images["Finish"], new EventHandler(debugManager.Finish_Click));
            FinishButton.DisplayStyle = ToolStripItemDisplayStyle.Image;

            toolbarButtons = new ToolStripItem[] { new ToolStripSeparator(), PauseButton, StopButton, ContinueButton, StepButton, NextButton, FinishButton };

            StartNoDebugButton = new ToolStripButton(TextHelper.GetString("FdbPlugin.Label.StartNoDebug"), imageList.Images["NoDebug"], new EventHandler(StartNoDebug_Click));
            StartNoDebugButton.DisplayStyle = ToolStripItemDisplayStyle.Image;

            //contextmenu
            QuickWatchItem = new ToolStripMenuItem("Quick Watch", null, delegate
            {
                string exp = PluginBase.MainForm.CurrentDocument.SciControl.SelText;
                PanelsHelper.quickWatchForm.Exp = exp;
                PanelsHelper.quickWatchForm.ShowDialog(PluginBase.MainForm);

            });
            PluginBase.MainForm.EditorMenu.Items.Add(QuickWatchItem);

            // update items when debugger state changes
            PluginMain.debugManager.StateChangedEvent += UpdateMenuState;
        }

        public void OpenLocalVariablesPanel(Object sender, System.EventArgs e)
        {
            PanelsHelper.pluginPanel.Show();
        }

        public void OpenBreakPointPanel(Object sender, System.EventArgs e)
        {
            PanelsHelper.breakPointPanel.Show();
        }

        public void OpenStackframePanel(Object sender, System.EventArgs e)
        {
            PanelsHelper.stackframePanel.Show();
        }

        /// <summary>
        /// 
        /// </summary>
        void Start_Click(Object sender, EventArgs e)
        {
            PluginMain.debugManager.Start();
        }

        /// <summary>
        /// 
        /// </summary>
        void StartNoDebug_Click(Object sender, EventArgs e)
        {
            if (PluginMain.debugBuildStart || PluginMain.debugManager.FdbWrapper.IsDebugStart)
                return;

            PluginMain.disableDebugger = true;
            if (PluginMain.debugManager.currentProject != null && !PluginMain.debugManager.currentProject.NoOutput)
            {
                StartNoDebugButton.Enabled = false;
                StartNoDebugMenu.Enabled = false;
                StartMenu.Enabled = false;
            }
            DataEvent de = new DataEvent(EventType.Command, "ProjectManager.TestMovie", null);
            EventManager.DispatchEvent(this, de);
            PluginMain.disableDebugger = false;
        }

        #region menus state management

        /// <summary>
        /// 
        /// </summary>
        public void UpdateMenuState(object sender, FdbState state)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate()
                {
                    UpdateMenuState(sender, state);
                });
                return;
            }

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
                    PanelsHelper.breakPointUI.Enabled = true;

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
                    PanelsHelper.breakPointUI.Enabled = false;

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
                    PanelsHelper.breakPointUI.Enabled = true;

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
                    PanelsHelper.breakPointUI.Enabled = false;

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
                    PanelsHelper.breakPointUI.Enabled = true;

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
                    PanelsHelper.breakPointUI.Enabled = true;

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
                    PanelsHelper.breakPointUI.Enabled = false;

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
                    PanelsHelper.breakPointUI.Enabled = false;

                    QuickWatchItem.Enabled = false;
                    break;
            }
            PluginBase.MainForm.RefreshUI();
        }

        public void AddStartNoDebugButton()
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

        public void RemoveStartNoDebugButton()
        {
            ToolStripItemCollection items = PluginBase.MainForm.ToolStrip.Items;
            if (items.Contains(StartNoDebugButton))
                items.Remove(StartNoDebugButton);
            StartNoDebugMenu.Enabled = false;
            StartMenu.Enabled = false;
        }

        internal void OnBuildFailed()
        {
            StartNoDebugButton.Enabled = true;
            StartNoDebugMenu.Enabled = true;
            StartMenu.Enabled = true;
        }

        internal void OnBuildComplete()
        {
            StartNoDebugButton.Enabled = true;
            StartNoDebugMenu.Enabled = true;
            StartMenu.Enabled = true;
        }

        #endregion
    }
}
