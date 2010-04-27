using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
using PluginCore.Localization;
using FlashDebugger.Properties;
using PluginCore;

namespace FlashDebugger
{
    internal class MenusHelper
    {
        static public ImageList imageList;
		private ToolStrip m_DebuggerToolStrip;
        private ToolStripItem[] m_ToolStripButtons;
		private ToolStripButton StartContinueButton, PauseButton, StopButton, CurrentButton, RunToCursorButton, StepButton, NextButton, FinishButton;
		private ToolStripDropDownItem StartContinueMenu, PauseMenu, StopMenu, CurrentMenu, RunToCursorMenu, StepMenu, NextMenu, FinishMenu, ToggleBreakPointMenu, ToggleBreakPointEnableMenu, DeleteAllBreakPointsMenu, DisableAllBreakPointsMenu, EnableAllBreakPointsMenu;

        /// <summary>
        /// Creates a menu item for the plugin and adds a ignored key
        /// </summary>
        public MenusHelper(Image pluginImage, DebuggerManager debugManager, Settings settingObject)
        {
            imageList = new ImageList();
			imageList.Images.Add("StartContinue", Resource.StartContinue);
			imageList.Images.Add("Pause", Resource.Pause);
			imageList.Images.Add("Stop", Resource.Stop);
			imageList.Images.Add("Current", Resource.Current);
			imageList.Images.Add("RunToCursor", Resource.RunToCursor);
			imageList.Images.Add("Step", Resource.Step);
			imageList.Images.Add("Next", Resource.Next);
			imageList.Images.Add("Finish", Resource.Finish);

            ToolStripMenuItem viewMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("ViewMenu");
            viewMenu.DropDownItems.Add(new ToolStripMenuItem(TextHelper.GetString("Label.ViewLocalVariablesPanel"), pluginImage, new EventHandler(this.OpenLocalVariablesPanel)));
            viewMenu.DropDownItems.Add(new ToolStripMenuItem(TextHelper.GetString("Label.ViewBreakpointsPanel"), pluginImage, new EventHandler(this.OpenBreakPointPanel)));
            viewMenu.DropDownItems.Add(new ToolStripMenuItem(TextHelper.GetString("Label.ViewStackframePanel"), pluginImage, new EventHandler(this.OpenStackframePanel)));

            // Menu           
            ToolStripMenuItem debugMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("DebugMenu");
            if (debugMenu == null)
            {
                debugMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Debug"));
                ToolStripMenuItem toolsMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("ToolsMenu");
                Int32 idx = PluginBase.MainForm.MenuStrip.Items.IndexOf(toolsMenu);
                if (idx < 0) idx = PluginBase.MainForm.MenuStrip.Items.Count - 1;
                PluginBase.MainForm.MenuStrip.Items.Insert(idx, debugMenu);
            }

			StartContinueMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Start"), imageList.Images["StartContinue"], new EventHandler(StartContinue_Click), settingObject.StartContinue);
			PauseMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Pause"), imageList.Images["Pause"], new EventHandler(debugManager.Pause_Click), settingObject.Pause);
			StopMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Stop"), imageList.Images["Stop"], new EventHandler(debugManager.Stop_Click), settingObject.Stop);
			CurrentMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Current"), imageList.Images["Current"], new EventHandler(debugManager.Current_Click), settingObject.Current);
			RunToCursorMenu = new ToolStripMenuItem(TextHelper.GetString("Label.RunToCursor"), imageList.Images["RunToCursor"], new EventHandler(ScintillaHelper.RunToCursor_Click), settingObject.RunToCursor);
			StepMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Step"), imageList.Images["Step"], new EventHandler(debugManager.Step_Click), settingObject.Step);
			NextMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Next"), imageList.Images["Next"], new EventHandler(debugManager.Next_Click), settingObject.Next);
            FinishMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Finish"), imageList.Images["Finish"], new EventHandler(debugManager.Finish_Click), settingObject.Finish);

            ToggleBreakPointMenu = new ToolStripMenuItem(TextHelper.GetString("Label.ToggleBreakpoint"), null, new EventHandler(ScintillaHelper.ToggleBreakPoint_Click), settingObject.ToggleBreakPoint);
            DeleteAllBreakPointsMenu = new ToolStripMenuItem(TextHelper.GetString("Label.DeleteAllBreakpoints"), null, new EventHandler(ScintillaHelper.DeleteAllBreakPoints_Click), settingObject.Finish);
            ToggleBreakPointEnableMenu = new ToolStripMenuItem(TextHelper.GetString("Label.ToggleBreakpointEnabled"), null, new EventHandler(ScintillaHelper.ToggleBreakPointEnable_Click), settingObject.ToggleBreakPointEnable);
            DisableAllBreakPointsMenu = new ToolStripMenuItem(TextHelper.GetString("Label.DisableAllBreakpoints"), null, new EventHandler(ScintillaHelper.DisableAllBreakPoints_Click), settingObject.DisableAllBreakPoints);
            EnableAllBreakPointsMenu = new ToolStripMenuItem(TextHelper.GetString("Label.EnableAllBreakpoints"), null, new EventHandler(ScintillaHelper.EnableAllBreakPoints_Click), settingObject.EnableAllBreakPoints);

			List<ToolStripItem> items = new List<ToolStripItem>(new ToolStripItem[]
			{
				StartContinueMenu, PauseMenu, StopMenu, new ToolStripSeparator(),
				CurrentMenu, RunToCursorMenu, StepMenu, NextMenu, FinishMenu, new ToolStripSeparator(),
				ToggleBreakPointMenu, DeleteAllBreakPointsMenu, ToggleBreakPointEnableMenu ,DisableAllBreakPointsMenu, EnableAllBreakPointsMenu
            });

            foreach (ToolStripItem item in items)
            {
                if (item is ToolStripMenuItem)
                {
                    if ((item as ToolStripMenuItem).ShortcutKeys != Keys.None)
                    {
                        PluginBase.MainForm.IgnoredKeys.Add((item as ToolStripMenuItem).ShortcutKeys);
                    }
                }
            }
			debugMenu.DropDownItems.AddRange(items.ToArray());

            // ToolStrip
            StartContinueButton = new ToolStripButton(TextHelper.GetString("Label.Start"), imageList.Images["StartContinue"], new EventHandler(StartContinue_Click));
			StartContinueButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
			PauseButton = new ToolStripButton(TextHelper.GetString("Label.Pause"), imageList.Images["Pause"], new EventHandler(debugManager.Pause_Click));
			PauseButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
			StopButton = new ToolStripButton(TextHelper.GetString("Label.Stop"), imageList.Images["Stop"], new EventHandler(debugManager.Stop_Click));
			StopButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
			CurrentButton = new ToolStripButton(TextHelper.GetString("Label.Current"), imageList.Images["Current"], new EventHandler(debugManager.Current_Click));
			CurrentButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
			RunToCursorButton = new ToolStripButton(TextHelper.GetString("Label.RunToCursor"), imageList.Images["RunToCursor"], new EventHandler(ScintillaHelper.RunToCursor_Click));
			RunToCursorButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
			StepButton = new ToolStripButton(TextHelper.GetString("Label.Step"), imageList.Images["Step"], new EventHandler(debugManager.Step_Click));
            StepButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
			NextButton = new ToolStripButton(TextHelper.GetString("Label.Next"), imageList.Images["Next"], new EventHandler(debugManager.Next_Click));
            NextButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            FinishButton = new ToolStripButton(TextHelper.GetString("Label.Finish"), imageList.Images["Finish"], new EventHandler(debugManager.Finish_Click));
            FinishButton.DisplayStyle = ToolStripItemDisplayStyle.Image;

			m_ToolStripButtons = new ToolStripItem[] { StartContinueButton, PauseButton, StopButton, new ToolStripSeparator(), CurrentButton, RunToCursorButton, StepButton, NextButton, FinishButton };
			m_DebuggerToolStrip = new ToolStrip(m_ToolStripButtons);
            m_DebuggerToolStrip.Renderer = new DockPanelStripRenderer(false);

			PluginBase.MainForm.ToolStrip.Stretch = false;
            PluginMain.debugManager.StateChangedEvent += UpdateMenuState;
        }

        public void AddToolStrip()
        {
            // add debug toolbar right to the main toolbar
            ToolStripPanel tsp = PluginBase.MainForm.ToolStripPanel;
            if (tsp.Rows.Length > 1)
            {
                int idx = tsp.Rows.Length - 1;
                Control[] row = tsp.Rows[idx].Controls;
                foreach (Control c in row) tsp.Controls.Remove(c);
                tsp.Join(m_DebuggerToolStrip, idx);
                for (int i = row.Length - 1; i >= 0; i--)
                {
                    tsp.Join(row[0] as ToolStrip, idx);
                }
            }
            else tsp.Join(m_DebuggerToolStrip);
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
        void StartContinue_Click(Object sender, EventArgs e)
        {
			if (PluginMain.debugManager.FlashInterface.isDebuggerStarted)
			{
				PluginMain.debugManager.Continue_Click(sender, e);
			}
			else PluginMain.debugManager.Start();
		}

		#region Menus State Management

		/// <summary>
        /// 
        /// </summary>
        public void UpdateMenuState(object sender, DebuggerState state)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate()
                {
                    UpdateMenuState(sender, state);
                });
                return;
            }
			if (state == DebuggerState.Initializing || 
                state == DebuggerState.Stopped)
			{
				StartContinueButton.Text = StartContinueMenu.Text = TextHelper.GetString("Label.Start");
			}
			else
			{
				StartContinueButton.Text = StartContinueMenu.Text = TextHelper.GetString("Label.Continue");
			}
			StopButton.Enabled = StopMenu.Enabled = (state != DebuggerState.Initializing && state != DebuggerState.Stopped);
            PauseButton.Enabled = PauseMenu.Enabled = (state == DebuggerState.Running);

			if (state == DebuggerState.Initializing ||
				state == DebuggerState.Stopped ||
				state == DebuggerState.BreakHalt ||
				state == DebuggerState.ExceptionHalt ||
				state == DebuggerState.PauseHalt)
			{
				StartContinueButton.Enabled = StartContinueMenu.Enabled = true;
			}
			else
			{
				StartContinueButton.Enabled = StartContinueMenu.Enabled = false;
			}

            CurrentButton.Enabled = CurrentMenu.Enabled = RunToCursorButton.Enabled =
                RunToCursorMenu.Enabled = StepButton.Enabled = StepMenu.Enabled =
                NextButton.Enabled = NextMenu.Enabled = FinishButton.Enabled =
                FinishMenu.Enabled = (state == DebuggerState.BreakHalt || state == DebuggerState.PauseHalt);

			if (state == DebuggerState.Running)
			{
				PanelsHelper.pluginUI.TreeControl.Nodes.Clear();
				PanelsHelper.stackframeUI.ClearItem();
			}
			PluginBase.MainForm.BreakpointsEnabled = ToggleBreakPointMenu.Enabled = ToggleBreakPointEnableMenu.Enabled =
                DeleteAllBreakPointsMenu.Enabled = DisableAllBreakPointsMenu.Enabled = EnableAllBreakPointsMenu.Enabled =
                PanelsHelper.breakPointUI.Enabled = (state != DebuggerState.Running);

			PluginBase.MainForm.RefreshUI();
        }

        internal void OnBuildFailed()
        {
            StartContinueMenu.Enabled = true;
        }

        internal void OnBuildComplete()
        {
			StartContinueMenu.Enabled = true;
        }

        #endregion

    }

}
