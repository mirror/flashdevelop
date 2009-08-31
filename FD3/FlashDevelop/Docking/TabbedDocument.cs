using System;
using System.IO;
using System.Text;
using System.Drawing;
using System.Windows.Forms;
using WeifenLuo.WinFormsUI;
using WeifenLuo.WinFormsUI.Docking;
using PluginCore.Localization;
using FlashDevelop.Managers;
using FlashDevelop.Helpers;
using FlashDevelop.Controls;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore.Controls;
using ScintillaNet;
using PluginCore;

namespace FlashDevelop.Docking
{
    public class TabbedDocument : DockContent, ITabbedDocument
	{
        private Timer focusTimer;
        private Timer backupTimer;
        private String previousText;
        private Boolean useCustomIcon;
        private Timer fileChangeTimer;
        private Boolean isModified;
        private FileInfo fileInfo;

        public TabbedDocument()
		{
            this.focusTimer = new Timer();
            this.focusTimer.Interval = 100;
            this.fileChangeTimer = new Timer();
            this.fileChangeTimer.Interval = 100;
            this.focusTimer.Tick += new EventHandler(this.OnFocusTimer);
            this.fileChangeTimer.Tick += new EventHandler(this.OnFileChangeTimerTick);
            this.ControlAdded += new ControlEventHandler(this.DocumentControlAdded);
            this.DockPanel = Globals.MainForm.DockPanel;
            this.Font = Globals.Settings.DefaultFont;
            this.DockAreas = DockAreas.Document;
            this.BackColor = Color.White;
            this.useCustomIcon = false;
            this.StartBackupTiming();
		}

        /// <summary>
        /// Disables the automatic update of the icon
        /// </summary>
        public Boolean UseCustomIcon
        {
            get { return this.useCustomIcon; }
            set { this.useCustomIcon = value; }
        }

        /// <summary>
        /// Path of the document
        /// </summary>
        public String FileName
        {
            get
            {
                if (this.IsEditable) return this.SciControl.FileName;
                else return null;
            }
        }

        /// <summary>
        /// Do we contain a Browser control?
        /// </summary>
        public Boolean IsBrowsable
        {
            get
            {
                foreach (Control ctrl in this.Controls)
                {
                    if (ctrl is Browser) return true;
                }
                return false;
            }
        }

        /// <summary>
        /// Do we contain a ScintillaControl?
        /// </summary>
        public Boolean IsEditable
        {
            get
            {
                if (this.SciControl == null) return false;
                else return true;
            }
        }

        /// <summary>
        /// ScintillaControl of the document
        /// </summary>
        public ScintillaControl SciControl
        {
            get
            {
                foreach (Control ctrl in this.Controls)
                {
                    if (ctrl is ScintillaControl) return ctrl as ScintillaControl;
                }
                return null;
            }
        }
        
        /// <summary>
        /// Gets if the file is untitled
        /// </summary>
        public Boolean IsUntitled
        {
            get
            {
                String untitledFileStart = TextHelper.GetString("Info.UntitledFileStart");
                if (this.IsEditable) return this.FileName.StartsWith(untitledFileStart);
                else return false;
            }
        }

        /// <summary>
        /// Sets or gets if the file is modified
        /// </summary> 
        public Boolean IsModified
        {
            get { return this.isModified; }
            set 
            {
                if (!this.IsEditable) return;
                if (this.isModified != value)
                {
                    this.isModified = value;
                    ButtonManager.UpdateFlaggedButtons();
                    this.UpdateToolTipText();
                    this.UpdateTabText();
                }
            }
        }

        /// <summary>
        /// Activates the scintilla control after a delay
        /// </summary>
        public new void Activate()
        {
            base.Activate();
            if (this.IsEditable)
            {
                this.focusTimer.Stop();
                this.focusTimer.Start();
            }
        }
        private void OnFocusTimer(Object sender, EventArgs e)
        {
            this.focusTimer.Stop();
            if (this.SciControl != null && this.DockPanel.ActiveContent != null && this.DockPanel.ActiveContent == this)
            {
                this.SciControl.Focus();
            }
        }

        /// <summary>
        /// Adds a new scintilla control to the document
        /// </summary>
        public void AddScintillaControl(ScintillaControl editor)
        {
            editor.SavePointLeft += delegate { this.IsModified = true; };
            editor.SavePointReached += delegate 
            {
                editor.MarkerDeleteAll(2);
                this.IsModified = false;
            };
            this.Controls.Add(editor);
        }

        /// <summary>
        /// If the the file is changed outside fd, reload.
        /// </summary>
        public void CheckFileChange()
        {
            if (!this.IsEditable) return;
            if (this.fileInfo == null) this.fileInfo = new FileInfo(this.FileName);
            if (!Globals.MainForm.ClosingEntirely && File.Exists(this.FileName))
            {
                FileInfo fi = new FileInfo(this.FileName);
                if (this.fileInfo.LastWriteTime != fi.LastWriteTime)
                {
                    this.fileInfo = fi;
                    this.fileChangeTimer.Start();
                }
            }
        }

        /// <summary>
        /// Shows the file change confirmation after a delay
        /// </summary>
        private void OnFileChangeTimerTick(Object sender, EventArgs e)
        {
            this.fileChangeTimer.Stop();
            if (Globals.Settings.AutoReloadModifiedFiles) this.Reload(false); 
            else
            {
                String dlgTitle = TextHelper.GetString("Title.InfoDialog");
                String message = TextHelper.GetString("Info.FileIsModifiedOutside");
                if (MessageBox.Show(Globals.MainForm, message, " " + dlgTitle, MessageBoxButtons.YesNo, MessageBoxIcon.Information) == DialogResult.Yes)
                {
                    this.Reload(false);
                }
            }
        }

        /// <summary>
        /// Saves an editable document
        /// </summary>
        public void Save(String file)
        {
            if (!this.IsEditable) return;
            if (!this.IsUntitled && FileHelper.FileIsReadOnly(this.FileName))
            {
                String dlgTitle = TextHelper.GetString("Title.ConfirmDialog");
                String message = TextHelper.GetString("Info.MakeReadOnlyWritable");
                if (MessageBox.Show(Globals.MainForm, message, dlgTitle, MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    ScintillaManager.MakeFileWritable(this.SciControl);
                }
                else return;
            }
            Boolean otherFile = (this.SciControl.FileName != file);
            if (otherFile)
            {
                RecoveryManager.RemoveTemporaryFile(this.FileName);
                TextEvent close = new TextEvent(EventType.FileClose, this.FileName);
                EventManager.DispatchEvent(this, close);
            }
            TextEvent saving = new TextEvent(EventType.FileSaving, file);
            EventManager.DispatchEvent(this, saving);
            if (!saving.Handled)
            {
                this.UpdateDocumentIcon(file);
                this.SciControl.FileName = file;
                ScintillaManager.CleanUpCode(this.SciControl);
                DataEvent de = new DataEvent(EventType.FileEncode, file, this.SciControl.Text);
                EventManager.DispatchEvent(this, de); // Lets ask if a plugin wants to encode and save the data..
                if (!de.Handled) FileHelper.WriteFile(file, this.SciControl.Text, this.SciControl.Encoding);
                this.IsModified = false;
                this.SciControl.SetSavePoint();
                RecoveryManager.RemoveTemporaryFile(this.FileName);
                this.fileInfo = new FileInfo(this.FileName);
                if (otherFile)
                {
                    ScintillaManager.UpdateControlSyntax(this.SciControl);
                    Globals.MainForm.OnFileSave(this, true);
                }
                else Globals.MainForm.OnFileSave(this, false);
            }
            this.UpdateToolTipText();
            this.UpdateTabText();
        }
        public void Save()
        {
            if (!this.IsEditable) return;
            this.Save(this.FileName);
        }

        /// <summary>
        /// Reloads an editable document
        /// </summary>
        public void Reload(Boolean showQuestion)
        {
            if (!this.IsEditable) return;
            if (showQuestion)
            {
                String dlgTitle = TextHelper.GetString("Title.ConfirmDialog");
                String message = TextHelper.GetString("Info.AreYouSureToReload");
                if (MessageBox.Show(Globals.MainForm, message, " " + dlgTitle, MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No) return;
            }
            Globals.MainForm.ReloadingDocument = true;
            Int32 position = this.SciControl.CurrentPos;
            TextEvent te = new TextEvent(EventType.FileReload, this.FileName);
            EventManager.DispatchEvent(Globals.MainForm, te);
            if (!te.Handled)
            {
                Int32 codepage = FileHelper.GetFileCodepage(this.FileName);
                if (codepage == -1) return; // If the files is locked, stop.
                Encoding encoding = Encoding.GetEncoding(codepage);
                String contents = FileHelper.ReadFile(this.FileName, encoding);
                this.SciControl.IsReadOnly = false;
                this.SciControl.Encoding = encoding;
                this.SciControl.CodePage = ScintillaManager.SelectCodePage(codepage);
                this.SciControl.Text = contents;
                this.SciControl.IsReadOnly = FileHelper.FileIsReadOnly(this.FileName);
                this.SciControl.SetSel(position, position);
                this.SciControl.EmptyUndoBuffer();
                this.SciControl.Focus();
            }
            Globals.MainForm.OnDocumentReload(this);
        }

        /// <summary>
        /// Reverts the document to the orginal state
        /// </summary>
        public void Revert(Boolean showQuestion)
        {
            if (!this.IsEditable) return;
            if (showQuestion)
            {
                String dlgTitle = TextHelper.GetString("Title.ConfirmDialog");
                String message = TextHelper.GetString("Info.AreYouSureToRevert");
                if (MessageBox.Show(Globals.MainForm, message, " " + dlgTitle, MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No) return;
            }
            TextEvent te = new TextEvent(EventType.FileRevert, Globals.SciControl.FileName);
            EventManager.DispatchEvent(this, te);
            if (!te.Handled)
            {
                while (this.SciControl.CanUndo) this.SciControl.Undo();
                ButtonManager.UpdateFlaggedButtons();
            }
        }
        
        /// <summary>
        /// Starts the backup process timing
        /// </summary> 
        private void StartBackupTiming()
        {
            this.backupTimer = new Timer();
            this.backupTimer.Tick += new EventHandler(this.BackupTimerTick);
            this.backupTimer.Interval = Globals.Settings.BackupInterval;
            this.backupTimer.Start();
        }

        /// <summary>
        /// Saves a backup file after an interval
        /// </summary> 
        private void BackupTimerTick(Object sender, EventArgs e)
        {
            if (this.IsEditable && !this.IsUntitled && this.IsModified && this.previousText != this.SciControl.Text)
            {
                RecoveryManager.SaveTemporaryFile(this.FileName, this.SciControl.Text, this.SciControl.Encoding);
                this.previousText = this.SciControl.Text;
            }
        }

        /// <summary>
        /// Automaticly updates the document icon
        /// </summary>
        private void UpdateDocumentIcon(String file)
        {
            if (this.useCustomIcon) return;
            if (!this.IsBrowsable) this.Icon = IconExtractor.GetFileIcon(file, true);
            else
            {
                Image image = Globals.MainForm.FindImage("480");
                this.Icon = ImageKonverter.ImageToIcon(image);
                this.useCustomIcon = true;
            }
        }

        /// <summary>
        /// Updates the document's tooltip
        /// </summary>
        private void UpdateToolTipText()
        {
            if (!this.IsEditable) this.ToolTipText = "";
            else this.ToolTipText = this.FileName;
        }

        /// <summary>
        /// Updates the document's tab text
        /// </summary>
        private void UpdateTabText()
        {
            this.Text = Path.GetFileName(this.FileName);
            if (this.isModified) this.Text += "*";
        }

        /// <summary>
        /// Updates the document icon when a control is added
        /// </summary>
        private void DocumentControlAdded(Object sender, ControlEventArgs e)
        {
            this.UpdateToolTipText();
            this.UpdateDocumentIcon(this.FileName);
        }

    }
	
}
