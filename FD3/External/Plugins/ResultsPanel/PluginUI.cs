using System;
using System.IO;
using System.Drawing;
using System.Windows.Forms;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using WeifenLuo.WinFormsUI.Docking;
using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using ScintillaNet.Configuration;
using ScintillaNet;
using PluginCore;

namespace ResultsPanel
{
	public class PluginUI : DockPanelControl
	{
        private ListView entriesView;
        private ToolStripMenuItem nextEntry;
        private ToolStripMenuItem previousEntry;
        private ToolStripMenuItem ignoreEntryContextMenuItem;
        private ToolStripMenuItem clearIgnoredEntriesContextMenuItem;
        private IDictionary<String, Boolean> ignoredEntries;
        private ColumnHeader entryFile;
		private ColumnHeader entryDesc;
		private ColumnHeader entryLine;
		private ColumnHeader entryPath;
		private ColumnHeader entryType;
		private PluginMain pluginMain;
        private Int32 logCount;
        private Timer autoShow;
		 
        public PluginUI(PluginMain pluginMain)
		{
            this.pluginMain = pluginMain;
            this.logCount = TraceManager.TraceLog.Count;
            this.ignoredEntries = new Dictionary<String, Boolean>();
            this.InitializeComponent();
            this.InitializeContextMenu();
            this.InitializeGraphics();
            this.InitializeTexts();
            this.ApplySettings();
            this.autoShow = new Timer();
            this.autoShow.Interval = 300;
            this.autoShow.Tick += AutoShowPanel;
		}
		
		#region Windows Forms Designer Generated Code
		
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() 
        {
            this.entriesView = new System.Windows.Forms.ListView();
            this.entryType = new System.Windows.Forms.ColumnHeader();
            this.entryLine = new System.Windows.Forms.ColumnHeader();
            this.entryDesc = new System.Windows.Forms.ColumnHeader();
            this.entryFile = new System.Windows.Forms.ColumnHeader();
            this.entryPath = new System.Windows.Forms.ColumnHeader();
            this.SuspendLayout();
            // 
            // entriesView
            //
            this.entriesView.Dock = System.Windows.Forms.DockStyle.Fill;
            this.entriesView.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.entriesView.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.entryType,
            this.entryLine,
            this.entryDesc,
            this.entryFile,
            this.entryPath});
            this.entriesView.ShowGroups = true;
            this.entriesView.ShowItemToolTips = true;
            this.entriesView.FullRowSelect = true;
            this.entriesView.GridLines = true;
            this.entriesView.Name = "entriesView";
            this.entriesView.Size = new System.Drawing.Size(710, 246);
            this.entriesView.TabIndex = 1;
            this.entriesView.UseCompatibleStateImageBehavior = false;
            this.entriesView.View = System.Windows.Forms.View.Details;
            this.entriesView.DoubleClick += new System.EventHandler(this.EntriesViewDoubleClick);
            this.entriesView.KeyDown += new System.Windows.Forms.KeyEventHandler(this.EntriesViewKeyDown);
            // 
            // entryType
            // 
            this.entryType.Text = "!";
            this.entryType.Width = 23;
            // 
            // entryLine
            // 
            this.entryLine.Text = "Line";
            this.entryLine.Width = 55;
            // 
            // entryDesc
            // 
            this.entryDesc.Text = "Description";
            this.entryDesc.Width = 350;
            // 
            // entryFile
            // 
            this.entryFile.Text = "File";
            this.entryFile.Width = 150;
            // 
            // entryPath
            // 
            this.entryPath.Text = "Path";
            this.entryPath.Width = 400;
            // 
            // PluginUI
            //
            this.Name = "PluginUI";
            this.Controls.Add(this.entriesView);
            this.Size = new System.Drawing.Size(712, 246);
            this.ResumeLayout(false);

		}
		#endregion
		
		#region Methods And Event Handlers

        /// <summary>
        /// Accessor for settings
        /// </summary>
        private Settings Settings
        {
            get { return (Settings)this.pluginMain.Settings; }
        }

        /// <summary>
        /// Initializes the image list for entriesView
        /// </summary>
        public void InitializeGraphics()
        {
            ImageList imageList = new ImageList();
            imageList.ColorDepth = ColorDepth.Depth32Bit;
            imageList.TransparentColor = Color.Transparent;
            imageList.Images.Add(PluginBase.MainForm.FindImage("131")); // info
            imageList.Images.Add(PluginBase.MainForm.FindImage("197")); // error
            imageList.Images.Add(PluginBase.MainForm.FindImage("196")); // warning
            this.entriesView.SmallImageList = imageList;
        }

        /// <summary>
        /// Initializes the context menu for entriesView
        /// </summary>
        public void InitializeContextMenu()
        {
            ContextMenuStrip menu = new ContextMenuStrip();
            menu.Items.Add(new ToolStripMenuItem(TextHelper.GetString("Label.CopyEntry"), null, new EventHandler(this.CopyTextClick)));
            menu.Items.Add(new ToolStripMenuItem(TextHelper.GetString("Label.ClearEntries"), null, new EventHandler(this.ClearOutputClick)));
            this.ignoreEntryContextMenuItem = new ToolStripMenuItem(TextHelper.GetString("Label.IgnoreEntry"), null, new EventHandler(this.IgnoreEntryClick));
            menu.Items.Add(this.ignoreEntryContextMenuItem);
            this.clearIgnoredEntriesContextMenuItem = new ToolStripMenuItem(TextHelper.GetString("Label.ClearIgnoredEntries"), null, new EventHandler(this.ClearIgnoredEntries));
            this.clearIgnoredEntriesContextMenuItem.Visible = false;
            menu.Items.Add(this.clearIgnoredEntriesContextMenuItem);
            menu.Items.Add(new ToolStripSeparator());
            this.nextEntry = new ToolStripMenuItem(TextHelper.GetString("Label.NextEntry"), null, new EventHandler(this.NextEntry));
            this.nextEntry.Enabled = false;
            this.nextEntry.ShortcutKeyDisplayString = DataConverter.KeysToString(this.Settings.NextError);
            menu.Items.Add(this.nextEntry);
            this.previousEntry = new ToolStripMenuItem(TextHelper.GetString("Label.PreviousEntry"), null, new EventHandler(this.PreviousEntry));
            this.previousEntry.Enabled = false;
            this.previousEntry.ShortcutKeyDisplayString = DataConverter.KeysToString(this.Settings.PreviousError);
            menu.Items.Add(this.previousEntry);
            this.entriesView.ContextMenuStrip = menu;
            menu.Font = PluginBase.Settings.DefaultFont;
            if (this.Settings.NextError != Keys.None) PluginBase.MainForm.IgnoredKeys.Add(this.Settings.NextError);
            if (this.Settings.NextError != Keys.None) PluginBase.MainForm.IgnoredKeys.Add(this.Settings.PreviousError);
        }

        /// <summary>
        /// Applies the localized texts to the control
        /// </summary>
        public void InitializeTexts()
        {
            this.entryFile.Text = TextHelper.GetString("Header.File");
            this.entryDesc.Text = TextHelper.GetString("Header.Description");
            this.entryLine.Text = TextHelper.GetString("Header.Line");
            this.entryPath.Text = TextHelper.GetString("Header.Path");
            this.entryPath.Width = -2; // Extend last column
        }

        /// <summary>
        /// Applies the settings to the UI
        /// </summary>
        public void ApplySettings()
        {
            Boolean useGrouping = PluginBase.Settings.UseListViewGrouping;
            this.entriesView.ShowGroups = useGrouping;
            this.entriesView.GridLines = !useGrouping;
        }

        /// <summary>
        /// Clears the output on click
        /// </summary>
        public void ClearOutputClick(Object sender, System.EventArgs e)
        {
            this.ClearOutput();
        }

        /// <summary>
        /// Copies the current item or all items to clipboard
        /// </summary>
        public void CopyTextClick(Object sender, System.EventArgs e)
        {
            if (this.entriesView.SelectedItems.Count > 0)
            {
                Match match = (Match)this.entriesView.SelectedItems[0].Tag;
                Clipboard.SetDataObject(match.Value);
            }
            else
            {
                String copy = String.Empty;
                foreach (ListViewItem item in this.entriesView.Items)
                {
                    Match match = (Match)item.Tag;
                    copy += match.Value + "\n";
                }
                Clipboard.SetDataObject(copy);
            }
        }

        /// <summary>
        /// Clears any result entries that are ignored.  Invoked from the context menu.
        /// Note that this doesn't immediately reshow any entries that would come up.
        /// The user must re-invoke the results panel listing again to see the ignored entries.
        /// </summary>
        public void ClearIgnoredEntries(Object sender, System.EventArgs e)
        {
            this.ignoredEntries.Clear();
            this.clearIgnoredEntriesContextMenuItem.Visible = false;
        }

        /// <summary>
        /// Ignores the currently selected entries.
        /// </summary>
        public void IgnoreEntryClick(Object sender, System.EventArgs e)
        {
            List<ListViewItem> newIgnoredEntries = new List<ListViewItem>();
            foreach (ListViewItem item in this.entriesView.SelectedItems)
            {
                Match match = (Match)item.Tag;
                string entryValue = match.Value;
                if (!this.ignoredEntries.ContainsKey(entryValue))
                {
                    this.ignoredEntries.Add(entryValue, false);
                    newIgnoredEntries.Add(item);
                }
            }
            foreach (ListViewItem item in newIgnoredEntries)
            {
                this.entriesView.Items.Remove(item);
            }
            this.clearIgnoredEntriesContextMenuItem.Visible = (this.ignoredEntries.Count > 0);
        }

        /// <summary>
        /// If the user presses Enter, dispatch double click
        /// </summary> 
		private void EntriesViewKeyDown(Object sender, System.Windows.Forms.KeyEventArgs e)
		{
			if (e.KeyCode == Keys.Enter)
			{
				this.EntriesViewDoubleClick(null, null);
				e.Handled = true;
			}
		}

        /// <summary>
        /// Opens the file and goes to the match
        /// </summary>
        private void EntriesViewDoubleClick(Object sender, System.EventArgs e)
		{
			if (this.entriesView.SelectedItems.Count < 1) return;
			ListViewItem item = this.entriesView.SelectedItems[0];
			if (item == null) return; 
            Match match = (Match)item.Tag;
			String file = item.SubItems[4].Text + "\\" + item.SubItems[3].Text;
			file = file.Replace(Path.AltDirectorySeparatorChar, Path.DirectorySeparatorChar);
            file = PathHelper.GetLongPathName(file);
            if (File.Exists(file)) 
			{
                PluginBase.MainForm.OpenEditableDocument(file, false);
                ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
				if (!PluginBase.MainForm.CurrentDocument.IsEditable) return;
                Int32 line = Convert.ToInt32(match.Groups["line"].Value) - 1;
                Match mcaret = this.errorCharacters.Match(match.Groups["description"].Value);
                Match mcaret2 = this.errorCharacter.Match(match.Groups["description"].Value);
                Match mcaret3 = this.errorCharacters2.Match(match.Groups["description"].Value);
                Match mcaret4 = this.lookupRange.Match(match.Groups["description"].Value);
                if (mcaret.Success)
                {
                    Int32 start = Convert.ToInt32(mcaret.Groups["start"].Value);
                    Int32 end = Convert.ToInt32(mcaret.Groups["end"].Value);
                    // An error (!=0) with this pattern is most likely a MTASC error (not multibyte)
                    if (item.ImageIndex == 0)
                    {
                        // start & end columns are multibyte lengths
                        start = this.MBSafeColumn(sci, line, start);
                        end = this.MBSafeColumn(sci, line, end);
                    }
                    Int32 startPosition = sci.PositionFromLine(line) + start;
                    Int32 endPosition = sci.PositionFromLine(line) + end;
                    this.SetSelAndFocus(sci, line, startPosition, endPosition);
                }
                else if (mcaret2.Success)
                {
                    Int32 start = Convert.ToInt32(mcaret2.Groups["start"].Value);
                    // column is a multibyte length
                    start = this.MBSafeColumn(sci, line, start);
                    Int32 position = sci.PositionFromLine(line) + start;
                    this.SetSelAndFocus(sci, line, position, position);
                }
                else if (mcaret3.Success)
                {
                    Int32 start = Convert.ToInt32(mcaret3.Groups["start"].Value);
                    // column is a multibyte length
                    start = this.MBSafeColumn(sci, line, start);
                    Int32 position = sci.PositionFromLine(line) + start;
                    this.SetSelAndFocus(sci, line, position, position);
                }
                else if (mcaret4.Success)
                {
                    // expected: both multibyte lengths
                    Int32 start = Convert.ToInt32(mcaret4.Groups["start"].Value);
                    Int32 end = Convert.ToInt32(mcaret4.Groups["end"].Value);
                    this.MBSafeSetSelAndFocus(sci, line, start, end);
                }
                else
                {
                    Int32 position = sci.PositionFromLine(line);
                    this.SetSelAndFocus(sci, line, position, position);
                }
			}
		}

        /// <summary>
        /// Convert multibyte column to byte length
        /// </summary>
        private int MBSafeColumn(ScintillaControl sci, int line, int length)
        {
            String text = sci.GetLine(line) ?? "";
            length = Math.Min(length, text.Length);
            return sci.MBSafeTextLength(text.Substring(0, length));
        }

        /// <summary>
        /// Goes to the match and ensures that correct fold is opened
        /// </summary>
        private void SetSelAndFocus(ScintillaControl sci, Int32 line, Int32 startPosition, Int32 endPosition)
		{
            sci.SetSel(startPosition, endPosition);
            sci.EnsureVisible(line);
        }

        /// <summary>
        /// Goes to the match and ensures that correct fold is opened
        /// </summary>
        private void MBSafeSetSelAndFocus(ScintillaControl sci, Int32 line, Int32 startPosition, Int32 endPosition)
        {
            sci.MBSafeSetSel(startPosition, endPosition);
            sci.EnsureVisible(line);
        }

        /// <summary>
        /// Clears the output
        /// </summary>
        public void ClearOutput()
        {
            this.ClearSquiggles();
            this.entriesView.Items.Clear();
            this.nextEntry.Enabled = false;
            this.previousEntry.Enabled = false;
            this.entryIndex = -1;
        }

        /// <summary>
        /// Flashes the panel to the user
        /// </summary>
        public void DisplayOutput()
        {
            autoShow.Stop();
            autoShow.Start();
        }

        /// <summary>
        /// Shows the panel
        /// </summary>
        private void AutoShowPanel(Object sender, System.EventArgs e)
        {
            autoShow.Stop();
            if (this.entriesView.Items.Count > 0)
            {
                DockContent panel = this.Parent as DockContent;
                DockState ds = panel.VisibleState;
                if (!panel.Visible || ds.ToString().EndsWith("AutoHide"))
                {
                    panel.Show();
                    if (ds.ToString().EndsWith("AutoHide")) panel.Activate();
                }
            }
        }

        /// <summary>
        /// Adds the log entries to the list view
        /// </summary>
        public void AddLogEntries()
        {
            Int32 count = TraceManager.TraceLog.Count;
            if (count <= this.logCount)
            {
                this.logCount = count;
                return;
            }
            Int32 newResult = -1;
            TraceItem entry; Match match; String description;
            String fileTest; Boolean inExec; Int32 icon; Int32 state;
            for (Int32 i = this.logCount; i < count; i++)
            {
                entry = TraceManager.TraceLog[i];
                if (entry.Message != null && entry.Message.Length > 7 && entry.Message.IndexOf(':') > 0)
                {
                    fileTest = entry.Message.TrimStart();
                    inExec = false;
                    if (fileTest.StartsWith("[mxmlc]") || fileTest.StartsWith("[compc]") || fileTest.StartsWith("[exec]")) // ANT output
                    {
                        inExec = true;
                        fileTest = fileTest.Substring(fileTest.IndexOf(']') + 1).TrimStart();
                    }
                    if (fileTest.StartsWith("~/")) // relative to project root
                    {
                        IProject project = PluginBase.CurrentProject;
                        if (project != null) fileTest = Path.GetDirectoryName(project.ProjectPath) + fileTest.Substring(1);
                    }
                    match = fileEntry.Match(fileTest);
                    if (!match.Success) match = fileEntry2.Match(fileTest);
                    if (match.Success && !this.ignoredEntries.ContainsKey(match.Value))
                    {
                        string filename = match.Groups["filename"].Value;
                        if (!File.Exists(filename)) continue;
                        FileInfo fileInfo = new FileInfo(filename);
                        if (fileInfo != null)
                        {
                            description = match.Groups["description"].Value.Trim();
                            state = (inExec) ? -3 : entry.State;
                            // automatic state from message
                            // ie. "2:message" -> state = 2
                            if (state == 1 && description.Length > 2)
                            {
                                if (description[1] == ':' && Char.IsDigit(description[0]))
                                {
                                    if (int.TryParse(description[0].ToString(), out state))
                                    {
                                        description = description.Substring(2);
                                    }
                                }
                            }
                            if (state > 2) icon = 1;
                            else if (state == 2) icon = 2;
                            else if (state == -3) icon = (description.IndexOf("Warning") >= 0) ? 2 : 1;
                            else icon = 0;
                            ListViewItem item = new ListViewItem("", icon);
                            item.Tag = match;
                            item.SubItems.Add(match.Groups["line"].Value);
                            item.SubItems.Add(description);
                            item.SubItems.Add(fileInfo.Name);
                            item.SubItems.Add(fileInfo.Directory.ToString());
                            if (newResult < 0) newResult = this.entriesView.Items.Count;
                            this.AddToGroup(item, fileInfo.FullName);
                            this.entriesView.Items.Add(item);
                        }
                    }
                }
            }
            this.logCount = count;
            if (newResult >= 0)
            {
                for (Int32 i = newResult; i < this.entriesView.Items.Count; i++)
                {
                    this.AddSquiggle(this.entriesView.Items[i]);
                }
                if (this.Settings.ScrollToBottom)
                {
                    Int32 last = this.entriesView.Items.Count - 1;
                    this.entriesView.EnsureVisible(last);
                }
                else this.entriesView.EnsureVisible(0);
                this.nextEntry.Enabled = true;
                this.previousEntry.Enabled = true;
            }
            this.entryPath.Width = -2; // Extend last column
        }

        /// <summary>
        /// Adds item to the specified group
        /// </summary>
        private void AddToGroup(ListViewItem item, String path)
        {
            String gpname;
            Boolean found = false;
            ListViewGroup gp = null;
            if (File.Exists(path)) gpname = Path.GetFileName(path);
            else gpname = TextHelper.GetString("FlashDevelop.Group.Other");
            foreach (ListViewGroup lvg in this.entriesView.Groups)
            {
                if (lvg.Tag.ToString() == path)
                {
                    found = true;
                    gp = lvg;
                    break;
                }
            }
            if (found) gp.Items.Add(item);
            else
            {
                gp = new ListViewGroup();
                gp.Tag = path;
                gp.Header = gpname;
                this.entriesView.Groups.Add(gp);
                gp.Items.Add(item);
            }
        }

		/// <summary>
		/// Squiggle open file
		/// </summary>
		public void AddSquiggles(String filename)
		{
			String fname;
			if (this.entriesView.Items.Count > 0)
			foreach(ListViewItem item in this.entriesView.Items)
			{
				fname = (item.SubItems[4].Text + "\\" + item.SubItems[3].Text).Replace('/','\\');
				if (fname == filename) AddSquiggle(item);
			}
		}
		
		/// <summary>
		/// Squiggle one result
		/// </summary>
		private void AddSquiggle(ListViewItem item)
		{
            bool fixIndexes = true;
            Match match = errorCharacters.Match(item.SubItems[2].Text);
            if (match.Success)
            {
                // An error with this pattern is most likely a MTASC error (not multibyte)
                if (item.ImageIndex != 0) fixIndexes = false;
            }
            else match = errorCharacter.Match(item.SubItems[2].Text);
            if (!match.Success) match = errorCharacters2.Match(item.SubItems[2].Text);
            if (match.Success)
			{
				String fname = (item.SubItems[4].Text + "\\" + item.SubItems[3].Text).Replace('/','\\');
				ITabbedDocument[] documents = PluginBase.MainForm.Documents;
                foreach (ITabbedDocument document in documents)
				{
					ScintillaControl sci = document.SciControl;
                    Language language = PluginBase.MainForm.SciConfig.GetLanguage(sci.ConfigurationLanguage);
                    Int32 indic = (item.ImageIndex == 0) ? (Int32)ScintillaNet.Enums.IndicatorStyle.RoundBox : (Int32)ScintillaNet.Enums.IndicatorStyle.Squiggle;
                    Int32 fore = (item.ImageIndex == 0) ? language.editorstyle.HighlightBackColor : 0x000000ff;
                    if (fname == document.FileName)
					{
                        Int32 end;
                        Int32 line = Convert.ToInt32(((Match)item.Tag).Groups["line"].Value) - 1;
                        Int32 start = Convert.ToInt32(match.Groups["start"].Value);
                        // start column is (probably) a multibyte length
                        if (fixIndexes) start = this.MBSafeColumn(sci, line, start);
                        if (match.Groups["end"] != null && match.Groups["end"].Success)
                        {
                            end = Convert.ToInt32(match.Groups["end"].Value);
                            // end column is (probably) a multibyte length
                            if (fixIndexes) end = this.MBSafeColumn(sci, line, end);
                        }
                        else
                        { 
                            start--; 
                            end = start + 1;
                        }
                        if ((start >= 0) && (end > start) && (end < sci.TextLength))
						{
                            Int32 position = sci.PositionFromLine(line) + start;
                            Int32 es = sci.EndStyled;
                            Int32 mask = 1 << sci.StyleBits;
							sci.SetIndicStyle(0, indic);
							sci.SetIndicFore(0, fore);
							sci.StartStyling(position, mask);
							sci.SetStyling(end-start, mask);
							sci.StartStyling(es, mask - 1);
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
            String fname; ScintillaControl sci;
            ArrayList cleared = new ArrayList();
            ITabbedDocument[] documents = PluginBase.MainForm.Documents;
            foreach (ITabbedDocument document in documents)
			{
				foreach (ListViewItem item in this.entriesView.Items)
				{
                    sci = document.SciControl;
                    fname = (item.SubItems[4].Text + "\\" + item.SubItems[3].Text).Replace('/','\\');
					if (fname == document.FileName && !cleared.Contains(fname))
					{
						cleared.Add(fname);
						Int32 es = sci.EndStyled;
                        Int32 mask = (1 << sci.StyleBits);
						sci.StartStyling(0, mask);
						sci.SetStyling(sci.TextLength, 0);
						sci.StartStyling(es, mask - 1);
						break;
					}
				}
			}
		}
		
		#endregion

        #region Regular Expressions

        /**
		* Match standard file entry -- filename:line:description
		* i.e. C:/path/to/src/com/Class.as:15: description
		*/
        private Regex fileEntry = new Regex("^(?<filename>([_A-Za-z]:)?[^:*?]+):(?<line>[0-9]+):(?<description>.*)$", RegexOptions.Compiled);

        /**
        * Match MXMLC style errors
        * i.e. C:\path\to\src\Class.as(9): description
        */
        private Regex fileEntry2 = new Regex(@"^(?<filename>[^(]*)\((?<line>[0-9]+)\):(?<description>.*)$", RegexOptions.Compiled);
        
        /**
        * Match find in files style ranges
        */
        private Regex lookupRange = new Regex("lookup range[\\s]+[^0-9]*(?<start>[0-9]+)-(?<end>[0-9]+)", RegexOptions.Compiled);

        /**
        * Extract error caret position
        */
        private Regex errorCharacter = new Regex("character[\\s]+[^0-9]*(?<start>[0-9]+)", RegexOptions.Compiled);
        private Regex errorCharacters = new Regex("characters[\\s]+[^0-9]*(?<start>[0-9]+)-(?<end>[0-9]+)", RegexOptions.Compiled);
        private Regex errorCharacters2 = new Regex(@"col: (?<start>[0-9]+)\s*", RegexOptions.Compiled);

        #endregion

        #region Entries Navigation

        private Int32 entryIndex = -1;

        /// <summary>
        /// Goes to the next entry in the result list.
        /// </summary>
        public void NextEntry(Object sender, System.EventArgs e)
        {
            if (entriesView.Items.Count == 0) return;
            if (entryIndex >= 0 && entryIndex < entriesView.Items.Count)
            {
                entriesView.Items[entryIndex].ForeColor = SystemColors.WindowText;
            }
            entryIndex = (entryIndex + 1) % entriesView.Items.Count;
            entriesView.SelectedItems.Clear();
            entriesView.Items[entryIndex].Selected = true;
            entriesView.Items[entryIndex].ForeColor = Color.Blue;
            entriesView.EnsureVisible(entryIndex);
            EntriesViewDoubleClick(null, null);
        }

        /// <summary>
        /// Goes to the previous entry in the result list.
        /// </summary>
        public void PreviousEntry(Object sender, System.EventArgs e)
        {
            if (entriesView.Items.Count == 0) return;
            if (entryIndex >= 0 && entryIndex < entriesView.Items.Count)
            {
                entriesView.Items[entryIndex].ForeColor = SystemColors.WindowText;
            }
            if (--entryIndex < 0) entryIndex = entriesView.Items.Count - 1;
            entriesView.SelectedItems.Clear();
            entriesView.Items[entryIndex].Selected = true;
            entriesView.Items[entryIndex].ForeColor = Color.Blue;
            entriesView.EnsureVisible(entryIndex);
            EntriesViewDoubleClick(null, null);
        }

        #endregion

    }
	
}
