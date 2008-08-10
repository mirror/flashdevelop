using System;
using System.Drawing;
using System.Windows.Forms;
using System.Collections;
using System.Text.RegularExpressions;
using System.IO;
using PluginCore;
using WeifenLuo.WinFormsUI;

namespace ResultsPanel
{
	public class PluginUI : System.Windows.Forms.UserControl
	{
		private System.ComponentModel.IContainer components;
		private System.Windows.Forms.ColumnHeader entryFile;
		private System.Windows.Forms.ImageList resultsIcons;
		private System.Windows.Forms.ColumnHeader entryDesc;
		private System.Windows.Forms.MenuItem menuItemCl;
		public System.Windows.Forms.ListView entriesView;
		private System.Windows.Forms.MenuItem menuItemCop;
		private System.Windows.Forms.ColumnHeader entryLine;
		private System.Windows.Forms.ColumnHeader entryPath;
		private System.Windows.Forms.ContextMenu contextMenuOutput;
		private System.Windows.Forms.ColumnHeader entryType;
		private PluginMain plugin;
		private int logCount;
		private ToolTip tip;
		
		#region RegularExpressions
		
		/// <summary>
		/// Match standart file entry -- filename:line:description
		/// i.e. C:/Program Files/scite/demo/com/Test.as:15: characters 1-8 : type error class not found : com.YellowBox
		/// </summary>
		private Regex fileEntry = new Regex("^(?<filename>([A-Za-z]:)?[^:*?]+):(?<line>[0-9]+):(?<description>.*)$", RegexOptions.Compiled);
		private Regex fileEntry2 = new Regex("^(?<filename>([A-Za-z]:)?[^:*?]+)\\((?<line>[0-9]+)\\):(?<description>.*)$", RegexOptions.Compiled);

		/// <summary>
		/// Extract error caret position
		/// </summary>
		private Regex errorCharacters = new Regex("characters[\\s]+[^0-9]*(?<start>[0-9]+)-(?<end>[0-9]+)", RegexOptions.Compiled);
		
		#endregion
		
		public PluginUI(PluginMain pluginMain)
		{
			InitializeComponent();
			this.plugin = pluginMain;
			this.logCount = pluginMain.Host.MainForm.EventLog.Count;
			//
			// load resource icons
			//
			resultsIcons.Images.Clear();
			System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
			try {
				resultsIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Question.png")));
				resultsIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Error.png")));
				resultsIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Warning.png")));
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error loading while resources in ResultsPanel.DLL", ex);
			}
		}
		
		#region Windows Forms Designer generated code
		
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			this.components = new System.ComponentModel.Container();
			this.entryType = new System.Windows.Forms.ColumnHeader();
			this.contextMenuOutput = new System.Windows.Forms.ContextMenu();
			this.entryPath = new System.Windows.Forms.ColumnHeader();
			this.entryLine = new System.Windows.Forms.ColumnHeader();
			this.menuItemCop = new System.Windows.Forms.MenuItem();
			this.entriesView = new System.Windows.Forms.ListView();
			this.menuItemCl = new System.Windows.Forms.MenuItem();
			this.entryDesc = new System.Windows.Forms.ColumnHeader();
			this.resultsIcons = new System.Windows.Forms.ImageList(this.components);
			this.entryFile = new System.Windows.Forms.ColumnHeader();
			this.SuspendLayout();
			// 
			// entryType
			// 
			this.entryType.Text = "!";
			this.entryType.Width = 23;
			// 
			// contextMenuOutput
			// 
			this.contextMenuOutput.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
						this.menuItemCl,
						this.menuItemCop});
			// 
			// entryPath
			// 
			this.entryPath.Text = "Path";
			this.entryPath.Width = 286;
			// 
			// entryLine
			// 
			this.entryLine.Text = "Line";
			this.entryLine.Width = 44;
			// 
			// menuItemCop
			// 
			this.menuItemCop.Index = 1;
			this.menuItemCop.Text = "&Copy";
			this.menuItemCop.Click += new System.EventHandler(this.MenuItemCopClick);
			// 
			// entriesView
			// 
			this.entriesView.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
						this.entryType,
						this.entryLine,
						this.entryDesc,
						this.entryFile,
						this.entryPath});
			this.entriesView.ContextMenu = this.contextMenuOutput;
			this.entriesView.Dock = System.Windows.Forms.DockStyle.Fill;
			this.entriesView.FullRowSelect = true;
			this.entriesView.GridLines = true;
			this.entriesView.Location = new System.Drawing.Point(0, 0);
			this.entriesView.Name = "entriesView";
			this.entriesView.Size = new System.Drawing.Size(712, 246);
			this.entriesView.SmallImageList = this.resultsIcons;
			this.entriesView.TabIndex = 1;
			this.entriesView.View = System.Windows.Forms.View.Details;
			this.entriesView.KeyDown += new System.Windows.Forms.KeyEventHandler(this.EntriesViewKeyDown);
			this.entriesView.DoubleClick += new System.EventHandler(this.EntriesViewDoubleClick);
			this.entriesView.MouseMove += new System.Windows.Forms.MouseEventHandler(this.EntriesViewMouseMove);
			// 
			// menuItemCl
			// 
			this.menuItemCl.Index = 0;
			this.menuItemCl.Text = "Clea&r";
			this.menuItemCl.Click += new System.EventHandler(this.MenuItemClClick);
			// 
			// entryDesc
			// 
			this.entryDesc.Text = "Description";
			this.entryDesc.Width = 387;
			// 
			// resultsIcons
			// 
			this.resultsIcons.ImageSize = new System.Drawing.Size(16, 16);
			this.resultsIcons.TransparentColor = System.Drawing.Color.Transparent;
			// 
			// entryFile
			// 
			this.entryFile.Text = "File";
			this.entryFile.Width = 84;
			// 
			// PluginUI
			// 
			this.Controls.Add(this.entriesView);
			this.Name = "PluginUI";
			this.Size = new System.Drawing.Size(712, 246);
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
			if (this.entriesView.SelectedItems.Count > 0)
			{
				Clipboard.SetDataObject( ((Match)this.entriesView.SelectedItems[0].Tag).Value );
			}
			else
			{
				string cpy = "";
				foreach(ListViewItem item in this.entriesView.Items)
					cpy += ((Match)item.Tag).Value+"\n";
				Clipboard.SetDataObject(cpy);
			}
		}
		
		#endregion
		
		#region ResultsMethods
		
		public void ClearOutput()
		{
			this.ClearSquiggles();
			this.entriesView.Items.Clear();
		}
		
		public void DisplayOutput()
		{
			// display errors
			if (this.entriesView.Items.Count > 0)
			{
				DockState ds = this.plugin.Panel.VisibleState;
				if (ds == DockState.Float
				    || ds == DockState.DockBottomAutoHide || ds == DockState.DockLeftAutoHide
				    || ds == DockState.DockRightAutoHide || ds == DockState.DockTopAutoHide)
					this.plugin.Panel.Show();
			}
		}
		
		public void AddLogEntries()
		{
			ArrayList log = this.plugin.MainForm.EventLog;
			int count = log.Count;
			// if no new log entry return
			if (count <= this.logCount) 
			{
				this.logCount = count;
				return;
			}
			// add entries
			ITraceEntry entry;
			Match m;
			string description;
			string fileTest;
			bool inExec;
			int icon;
			int state;
			int newResult = -1;
			for (int i = this.logCount; i<count; i++) 
			{
				entry = (ITraceEntry)log[i];
				// cleanup for ANT output
				fileTest = entry.Message.TrimStart();
				inExec = false;
				if (fileTest.StartsWith("[exec]")) {
					inExec = true;
					fileTest = fileTest.Substring(fileTest.IndexOf(']')+1).TrimStart();
				}
				// check file entry
				m = fileEntry.Match(fileTest);
				if (!m.Success) m = fileEntry2.Match(fileTest);
				
				if (m.Success && File.Exists( m.Groups["filename"].Value )) 
				{
					// add entry if the file exists
					FileInfo fileInfo = new FileInfo(m.Groups["filename"].Value);
					if (fileInfo != null) 
					{
						description = m.Groups["description"].Value.Trim();
						//
						state = (inExec) ? -3 : entry.State;
						if (state > 2) icon = 1;
						else if (state == 2) icon = 2;
						else if (state == -3) icon = (description.IndexOf("Warning") >= 0) ? 2 : 1;
						else icon = 0;
						//
						ListViewItem item = new ListViewItem("", icon);
						item.Tag = m;
						item.SubItems.Add(m.Groups["line"].Value);
						item.SubItems.Add(description);
						item.SubItems.Add(fileInfo.Name);
						item.SubItems.Add(fileInfo.Directory.ToString());
						//
						if (newResult < 0) newResult = this.entriesView.Items.Count;
						this.entriesView.Items.Add(item);
					}
				}
			}
			this.logCount = count;
			
			// squiggle?
			if (newResult >= 0)
			{
				for (int i=newResult; i<this.entriesView.Items.Count; i++)
				{
					this.AddSquiggle(this.entriesView.Items[i]);
				}
				// make sure the last added item is visible
				this.entriesView.EnsureVisible(this.entriesView.Items.Count-1);
			}
		}
		
		#endregion
		
		#region EventHandlers
		
		private void EntriesViewKeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
		{
			if (e.KeyCode == Keys.Enter)
			{
				EntriesViewDoubleClick(null, null);
				e.Handled = true;
			}
		}
		
		private void EntriesViewDoubleClick(object sender, System.EventArgs e)
		{
			if (this.entriesView.SelectedItems.Count < 1) return;
			ListViewItem item = this.entriesView.SelectedItems[0];
			if (item == null) return;
			Match m = (Match)item.Tag;
			string file = item.SubItems[4].Text+"\\"+item.SubItems[3].Text; //m.Groups["filename"].Value;
			
			file = file.Replace(Path.AltDirectorySeparatorChar, Path.DirectorySeparatorChar);
			file = plugin.MainForm.GetLongPathName(file);
			
			if(System.IO.File.Exists(file)) 
			{
				this.plugin.MainForm.OpenSelectedFile(file);
				ScintillaNet.ScintillaControl Sci = this.plugin.MainForm.CurSciControl;
				if (Sci == null) return;
				// find position
				int line = Convert.ToInt16(m.Groups["line"].Value)-1;
				Match mcaret = errorCharacters.Match(m.Groups["description"].Value);
				if (mcaret.Success) 
				{
					int start = Convert.ToInt16(mcaret.Groups["start"].Value);
					int end = Convert.ToInt16(mcaret.Groups["end"].Value);
					int position = Sci.PositionFromLine(line)+start;
					this.GotoPosAndFocus(Sci, position);
				}
				else 
				{
					this.GotoPosAndFocus(Sci, Sci.PositionFromLine(line));
				}
			}
		}
		
		private void GotoPosAndFocus(ScintillaNet.ScintillaControl sci, int position)
		{
			// don't correct to multi-byte safe position (assumed correct)
			sci.GotoPos(position);
			int line = sci.LineFromPosition(position);
			// TODO  The folding makes the line centering fail - solution: expand all folds / make it smarter.
			//sci.EnsureVisible(line);
			sci.ExpandAllFolds();
			int top = sci.FirstVisibleLine;
			int middle = top + sci.LinesOnScreen/2;
			sci.LineScroll(0, line-middle);
			((Control)sci).Focus();
		}
		
		private void EntriesViewMouseMove(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			// create tooltip
			if (tip == null) {
				tip = new ToolTip();
				tip.ShowAlways = true;
				tip.AutoPopDelay = 10000;
			}
			// display entry details (filename, line, description)
			ListViewItem item = entriesView.GetItemAt(e.X, e.Y);
			if (item == null)
			{
				tip.SetToolTip(entriesView, "");
				return;
			}
			tip.SetToolTip(entriesView, String.Format("{1}, line {2}:\n{0}", item.SubItems[2].Text, item.SubItems[3].Text, item.SubItems[1].Text));
		}
		
		#endregion
		
		#region squiggles

		/// <summary>
		/// Squiggle file on open
		/// </summary>
		/// <param name="filename"></param>
		public void AddSquiggles(string filename)
		{
			string fname;
			if (this.entriesView.Items.Count > 0)
			foreach(ListViewItem item in this.entriesView.Items)
			{
				fname = (item.SubItems[4].Text+"\\"+item.SubItems[3].Text).Replace('/','\\');
				if (fname == filename)
					AddSquiggle(item);
			}
		}
		
		/// <summary>
		/// Squiggle a result
		/// </summary>
		/// <param name="item"></param>
		private void AddSquiggle(ListViewItem item)
		{
			Match m = errorCharacters.Match(item.SubItems[2].Text);
			if (m.Success)
			{
				// check if the file is open
				string fname = (item.SubItems[4].Text+"\\"+item.SubItems[3].Text).Replace('/','\\');
				WeifenLuo.WinFormsUI.DockContent[] docs = this.plugin.MainForm.GetDocuments();
				ScintillaNet.ScintillaControl Sci;
				foreach(WeifenLuo.WinFormsUI.DockContent doc in docs)
				{
					Sci = this.plugin.MainForm.GetSciControl(doc);
					if (fname == Sci.Tag.ToString())
					{
						// find position
						int line = Convert.ToInt16( ((Match)item.Tag).Groups["line"].Value )-1;
						int start = Convert.ToInt16(m.Groups["start"].Value);
						int end = Convert.ToInt16(m.Groups["end"].Value);
						if ((start >= 0) && (end > start) && (end < Sci.TextLength))
						{
							int position = Sci.PositionFromLine(line)+start;
							int es = Sci.EndStyled;
							int mask = 1 << Sci.StyleBits;
							Sci.SetIndicStyle(0, /*INDIC_SQUIGGLE*/1);
							Sci.SetIndicFore(0, 0x000000ff);
							Sci.StartStyling(position, mask);
							Sci.SetStyling(end-start, mask);
							Sci.StartStyling(es, mask-1);
						}
						break;
					}
				}
			}
		}
		
		/// <summary>
		/// Clear all squiggles
		/// </summary>
		private void ClearSquiggles()
		{
			// clear all styling
			WeifenLuo.WinFormsUI.DockContent[] docs = this.plugin.MainForm.GetDocuments();
			ScintillaNet.ScintillaControl Sci;
			ArrayList cleared = new ArrayList();
			string fname;
			foreach(WeifenLuo.WinFormsUI.DockContent doc in docs)
			{
				// check if the file was "squiggled"
				foreach(ListViewItem item in this.entriesView.Items)
				{
					fname = (item.SubItems[4].Text+"\\"+item.SubItems[3].Text).Replace('/','\\');
					Sci = this.plugin.MainForm.GetSciControl(doc);
					if (fname == Sci.Tag.ToString() && !cleared.Contains(fname))
					{
						cleared.Add(fname);
						// clear styling
						int es = Sci.EndStyled;
						int mask = (1 << Sci.StyleBits);
						Sci.StartStyling(0, mask);
						Sci.SetStyling(Sci.TextLength, 0);
						Sci.StartStyling(es, mask-1);
						break;
					}
				}
			}
		}
		
		#endregion
	}
	
}
