using System;
using System.Windows.Forms;
using System.Collections;
using PluginCore;
using Win32;
using WeifenLuo.WinFormsUI;

namespace OutputPanel
{
	public class PluginUI : System.Windows.Forms.UserControl
	{
		private System.Windows.Forms.MenuItem menuItemSep;
		private System.Windows.Forms.MenuItem menuItemCl;
		private System.Timers.Timer scrollTimer;
		private System.Windows.Forms.RichTextBox textLog;
		private System.Windows.Forms.MenuItem menuItemWrap;
		private System.Windows.Forms.MenuItem menuItemCop;
		private System.Windows.Forms.ContextMenu contextMenuOutput;
		private PluginMain pluginMain;
		private int logCount;
		// settings
		private readonly string SETTING_ALWAYS_SHOW = "OutputPanel.ShowOnOutput";
		private readonly string SETTING_SHOW_PROCESS_END = "OutputPanel.ShowOnProcessEnd";
		public bool ShowOnOutput;
		public bool ShowOnProcessEnd;
		
		public PluginUI(PluginMain pluginMain)
		{
			this.InitializeComponent();
			this.pluginMain = pluginMain;
			this.logCount = pluginMain.Host.MainForm.EventLog.Count;
			
			// settings
			ISettings settings = pluginMain.MainForm.MainSettings;
			if (!settings.HasKey(SETTING_ALWAYS_SHOW)) settings.AddValue(SETTING_ALWAYS_SHOW, "false");
			if (!settings.HasKey(SETTING_SHOW_PROCESS_END)) settings.AddValue(SETTING_SHOW_PROCESS_END, "true");
			UpdateSettings();
		}
		
		public void UpdateSettings()
		{
			ISettings settings = pluginMain.MainForm.MainSettings;
			ShowOnOutput = settings.GetBool(SETTING_ALWAYS_SHOW);
			ShowOnProcessEnd = settings.GetBool(SETTING_SHOW_PROCESS_END);
		}
		
		#region Windows Forms Designer generated code
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			this.contextMenuOutput = new System.Windows.Forms.ContextMenu();
			this.menuItemCop = new System.Windows.Forms.MenuItem();
			this.menuItemWrap = new System.Windows.Forms.MenuItem();
			this.textLog = new System.Windows.Forms.RichTextBox();
			this.scrollTimer = new System.Timers.Timer();
			this.menuItemCl = new System.Windows.Forms.MenuItem();
			this.menuItemSep = new System.Windows.Forms.MenuItem();
			((System.ComponentModel.ISupportInitialize)(this.scrollTimer)).BeginInit();
			this.SuspendLayout();
			// 
			// contextMenuOutput
			// 
			this.contextMenuOutput.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
						this.menuItemCl,
						this.menuItemCop,
						this.menuItemSep,
						this.menuItemWrap});
			// 
			// menuItemCop
			// 
			this.menuItemCop.Index = 1;
			this.menuItemCop.Text = "&Copy";
			this.menuItemCop.Click += new System.EventHandler(this.MenuItemCopClick);
			// 
			// menuItemWrap
			// 
			this.menuItemWrap.Index = 3;
			this.menuItemWrap.Text = "&Wrap Text";
			this.menuItemWrap.Click += new System.EventHandler(this.MenuItemWrapClick);
			// 
			// textLog
			// 
			this.textLog.ContextMenu = this.contextMenuOutput;
			this.textLog.Dock = System.Windows.Forms.DockStyle.Fill;
			this.textLog.Font = new System.Drawing.Font("Courier New", 8.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.textLog.Location = new System.Drawing.Point(0, 0);
			this.textLog.Name = "textLog";
			this.textLog.ReadOnly = true;
			this.textLog.Size = new System.Drawing.Size(280, 352);
			this.textLog.TabIndex = 1;
			this.textLog.Text = "";
			this.textLog.WordWrap = false;
			// 
			// scrollTimer
			// 
			this.scrollTimer.Interval = 10;
			this.scrollTimer.SynchronizingObject = this;
			this.scrollTimer.Elapsed += new System.Timers.ElapsedEventHandler(this.ScrollTimerElapsed);
			// 
			// menuItemCl
			// 
			this.menuItemCl.Index = 0;
			this.menuItemCl.Text = "Clea&r";
			this.menuItemCl.Click += new System.EventHandler(this.MenuItemClClick);
			// 
			// menuItemSep
			// 
			this.menuItemSep.Index = 2;
			this.menuItemSep.Text = "-";
			// 
			// PluginUI
			// 
			this.Controls.Add(this.textLog);
			this.Name = "PluginUI";
			this.Size = new System.Drawing.Size(280, 352);
			((System.ComponentModel.ISupportInitialize)(this.scrollTimer)).EndInit();
			this.ResumeLayout(false);
		}
		#endregion
				
		#region ContextMenuHandlers
		
		public void MenuItemClClick(object sender, System.EventArgs e)
		{
			this.ClearOutput();
		}
		
		public void MenuItemCopClick(object sender, System.EventArgs e)
		{
			this.textLog.Copy();
		}
		
		void MenuItemWrapClick(object sender, System.EventArgs e)
		{
			this.menuItemWrap.Checked = !this.menuItemWrap.Checked;
			this.textLog.WordWrap = this.menuItemWrap.Checked;
		}
		
		#endregion
		
		#region OutputConsoleMethods
		public void ClearOutput()
		{
			this.textLog.ScrollBars = RichTextBoxScrollBars.None;
			this.textLog.Text = "";
			this.textLog.ScrollBars = RichTextBoxScrollBars.Both;
		}
		
		public void DisplayOutput()
		{
			DockState ds = pluginMain.Panel.VisibleState;
			if (ds == DockState.DockBottomAutoHide || ds == DockState.DockLeftAutoHide 
				    || ds == DockState.DockRightAutoHide || ds == DockState.DockTopAutoHide)
				this.pluginMain.Panel.Show();
		}
		
		public void AddLogEntries()
		{
			ArrayList log = this.pluginMain.MainForm.EventLog;
			int count = log.Count;
			// if no new log entry return
			if (count <= this.logCount) 
			{
				this.logCount = count;
				return;
			}
			// add entries
			ITraceEntry entry;
			int start;
			for (int i = this.logCount; i<count; i++) 
			{
				entry = (ITraceEntry)log[i];
				start = this.textLog.TextLength;
				this.textLog.Select(start, 0);
				switch (entry.State)
				{
					case 0://Info
						this.textLog.SelectionColor = System.Drawing.Color.Black;
						break;
					case 1://Debug
						this.textLog.SelectionColor = System.Drawing.Color.Gray;
						break;
					case 2://Warning
						this.textLog.SelectionColor = System.Drawing.Color.Orange;
						break;
					case 3://Error
						this.textLog.SelectionColor = System.Drawing.Color.Red;
						break;
					case 4://Fatal
						this.textLog.SelectionColor = System.Drawing.Color.Magenta;
						break;
					case -1://ProcessStart
						this.textLog.SelectionColor = System.Drawing.Color.Blue;
						break;
					case -2://ProcessEnd
						this.textLog.SelectionColor = System.Drawing.Color.Blue;
						break;
					case -3://ProcessError
						this.textLog.SelectionColor = (entry.Message.IndexOf("Warning") >= 0) ? System.Drawing.Color.Orange : System.Drawing.Color.Red;
						break;
				}
				this.textLog.AppendText(entry.Message+"\r\n");
			}
			
			this.logCount = count;
			
			// show
			this.scrollTimer.Enabled = true;
		}
		
		private void ScrollTimerElapsed(object sender, System.Timers.ElapsedEventArgs e)
		{
        	scrollTimer.Enabled = false;
        	if (this.ShowOnOutput) this.DisplayOutput();
        	Win32.Scrolling.scrollToLeft(textLog);
        	Win32.Scrolling.scrollToBottom(textLog);
		}
		#endregion
 	}
}
