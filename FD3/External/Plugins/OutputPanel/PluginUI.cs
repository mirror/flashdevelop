using System;
using System.Drawing;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Windows.Forms;
using WeifenLuo.WinFormsUI.Docking;
using WeifenLuo.WinFormsUI;
using PluginCore.Managers;
using PluginCore.Localization;
using PluginCore;

namespace OutputPanel
{
	public class PluginUI : DockPanelControl
	{
        private Int32 logCount;
        private RichTextBox textLog;
		private PluginMain pluginMain;
        private System.Timers.Timer scrollTimer;
        private ToolStripMenuItem wrapTextItem;
		
		public PluginUI(PluginMain pluginMain)
		{
            this.pluginMain = pluginMain;
            this.logCount = TraceManager.TraceLog.Count;
            this.InitializeComponent();
            this.InitializeContextMenu();
		}
		
		#region Windows Forms Designer Generated Code

		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() 
        {
            this.scrollTimer = new System.Timers.Timer();
            this.textLog = new System.Windows.Forms.RichTextBox();
            this.SuspendLayout();
            // 
            // scrollTimer
            // 
            this.scrollTimer.Interval = 50;
            this.scrollTimer.SynchronizingObject = this;
            this.scrollTimer.Elapsed += new System.Timers.ElapsedEventHandler(this.ScrollTimerElapsed);
            // 
            // textLog
            // 
            this.textLog.Dock = System.Windows.Forms.DockStyle.Fill;
            this.textLog.BackColor = System.Drawing.SystemColors.Window;
            this.textLog.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.textLog.Name = "textLog";
            this.textLog.ReadOnly = true;
            this.textLog.Size = new System.Drawing.Size(278, 352);
            this.textLog.Location = new System.Drawing.Point(0, 0);
            this.textLog.TabIndex = 1;
            this.textLog.Text = "";
            this.textLog.WordWrap = false;
            this.textLog.DetectUrls = true;
            this.textLog.LinkClicked += new LinkClickedEventHandler(this.LinkClicked);
            // 
            // PluginUI
            // 
            this.Name = "PluginUI";
            this.Controls.Add(this.textLog);
            this.Size = new System.Drawing.Size(280, 352);
            this.ResumeLayout(false);

		}

		#endregion
		
		#region Methods and Event Handlers

        /// <summary>
        /// Initializes the context menu
        /// </summary>
        private void InitializeContextMenu()
        {
            ContextMenuStrip menu = new ContextMenuStrip();
            menu.Items.Add(new ToolStripMenuItem(TextHelper.GetString("Label.ClearOutput"), null, new EventHandler(this.ClearOutput)));
            menu.Items.Add(new ToolStripMenuItem(TextHelper.GetString("Label.CopyOutput"), null, new EventHandler(this.CopyOutput)));
            menu.Items.Add(new ToolStripSeparator());
            wrapTextItem = new ToolStripMenuItem(TextHelper.GetString("Label.WrapText"), null, new EventHandler(this.WrapText));
            menu.Items.Add(wrapTextItem);
            menu.Font = PluginBase.Settings.DefaultFont;
            this.textLog.Font = PluginBase.Settings.ConsoleFont;
            this.textLog.ContextMenuStrip = menu;
            this.ApplyWrapText();
        }

        /// <summary>
        /// Opens the clicked link
        /// </summary>
        private void LinkClicked(Object sender, LinkClickedEventArgs e)
        {
            PluginBase.MainForm.CallCommand("Browse", e.LinkText);
        }

        /// <summary>
        /// Changes the wrapping in the control
        /// </summary>
        private void WrapText(Object sender, System.EventArgs e)
        {
            this.pluginMain.PluginSettings.WrapOutput = !this.pluginMain.PluginSettings.WrapOutput;
            this.pluginMain.SaveSettings();
            this.ApplyWrapText();
        }

        /// <summary>
        /// Applies the wrapping in the control
        /// </summary>
        public void ApplyWrapText()
        {
            this.wrapTextItem.Checked = this.pluginMain.PluginSettings.WrapOutput;
            this.textLog.WordWrap = this.pluginMain.PluginSettings.WrapOutput;
        }

        /// <summary>
        /// Copies the text to clipboard
        /// </summary>
        private void CopyOutput(Object sender, System.EventArgs e)
        {
            this.textLog.Copy();
        }

        /// <summary>
        /// Clears the output
        /// </summary>
        public void ClearOutput(Object sender, System.EventArgs e)
		{
			this.textLog.ScrollBars = RichTextBoxScrollBars.None;
			this.textLog.Text = "";
			this.textLog.ScrollBars = RichTextBoxScrollBars.Both;
		}

        /// <summary>
        /// Diplays the output
        /// </summary> 
		public void DisplayOutput()
		{
			DockState ds = this.pluginMain.PluginPanel.VisibleState;
            if (ds == DockState.DockBottomAutoHide || ds == DockState.DockLeftAutoHide || ds == DockState.DockRightAutoHide || ds == DockState.DockTopAutoHide)
            {
                this.pluginMain.PluginPanel.Show();
            }
		}

        /// <summary>
        /// Adds entries to the output if new entries are found
        /// </summary>
        public void AddTraces()
		{
			IList<TraceItem> log = TraceManager.TraceLog;
            if (log.Count <= this.logCount) 
			{
                this.logCount = log.Count;
				return;
			}
            Int32 start;
            TraceItem entry;
            Int32 state;
            String message;
            for (Int32 i = this.logCount; i < log.Count; i++) 
			{
				entry = log[i];
                state = entry.State;
                if (entry.Message == null) message = "";
                else message = entry.Message;
                // automatic state from message
                // ie. "2:message" -> state = 2
                if (state == 1 && message.Length > 2)
                {
                    if (message[1] == ':' && Char.IsDigit(message[0]))
                    {
                        if (int.TryParse(message[0].ToString(), out state))
                            message = message.Substring(2);
                    }
                }
				start = this.textLog.TextLength;
				this.textLog.Select(start, 0);
				switch (state)
				{
                    case 0: // Info
						this.textLog.SelectionColor = Color.Gray;
						break;
					case 1: // Debug
                        this.textLog.SelectionColor = Color.Black;
						break;
					case 2: // Warning
						this.textLog.SelectionColor = Color.Orange;
						break;
					case 3: // Error
						this.textLog.SelectionColor = Color.Red;
						break;
					case 4: // Fatal
						this.textLog.SelectionColor = Color.Magenta;
						break;
					case -1: // ProcessStart
						this.textLog.SelectionColor = Color.Blue;
						break;
					case -2: // ProcessEnd
						this.textLog.SelectionColor = Color.Blue;
						break;
					case -3: // ProcessError
                        this.textLog.SelectionColor = (message.IndexOf("Warning") >= 0) ? Color.Orange : Color.Red;
						break;
				}
				this.textLog.AppendText(message + "\n");
			}
            this.logCount = log.Count;
            this.scrollTimer.Enabled = true;
		}

        /// <summary>
        /// Scrolling fix on RichTextBox
        /// </summary> 
        private void ScrollTimerElapsed(Object sender, System.Timers.ElapsedEventArgs e)
        {
            this.scrollTimer.Enabled = false;
            if (this.pluginMain.PluginSettings.ShowOnProcessEnd)
            {
                this.DisplayOutput();
            }
            this.textLog.ScrollToCaret();
        }

		#endregion

 	}

}
