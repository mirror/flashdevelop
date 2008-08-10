using System;
using System.Drawing;
using System.Windows.Forms;
using PluginCore;
using ScintillaNet;
using FlashDevelop.Utilities;

namespace FlashDevelop.Windows
{
	public class FindInFilesDialog : System.Windows.Forms.Form
	{
		private System.Windows.Forms.GroupBox optionsGroupBox;
		private System.Windows.Forms.CheckBox checkBoxCase;
		private System.Windows.Forms.CheckBox checkBoxWord;
		private System.Windows.Forms.ComboBox findComboBox;
		private System.Windows.Forms.Label inFolderLabel;
		private System.Windows.Forms.Button findButton;
		private System.Windows.Forms.FolderBrowserDialog folderBrowserDialog;
		private System.Windows.Forms.ComboBox filterComboBox;
		private System.Windows.Forms.Label findLabel;
		private System.Windows.Forms.Button closeButton;
		private System.Windows.Forms.CheckBox checkBoxSub;
		private System.Windows.Forms.ComboBox folderComboBox;
		private System.Windows.Forms.Label inFilesLabel;
		private System.Windows.Forms.Button browseButton;
		private System.Windows.Forms.CheckBox checkBoxRegex;
		private FlashDevelop.MainForm mainForm;
		
		public FindInFilesDialog(MainForm mainForm)
		{
			this.mainForm = mainForm;
			this.InitializeComponent();
			this.Owner = mainForm;
		}
		
		#region Windows Forms Designer generated code
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			this.checkBoxRegex = new System.Windows.Forms.CheckBox();
			this.browseButton = new System.Windows.Forms.Button();
			this.inFilesLabel = new System.Windows.Forms.Label();
			this.folderComboBox = new System.Windows.Forms.ComboBox();
			this.checkBoxSub = new System.Windows.Forms.CheckBox();
			this.closeButton = new System.Windows.Forms.Button();
			this.findLabel = new System.Windows.Forms.Label();
			this.filterComboBox = new System.Windows.Forms.ComboBox();
			this.folderBrowserDialog = new System.Windows.Forms.FolderBrowserDialog();
			this.findButton = new System.Windows.Forms.Button();
			this.inFolderLabel = new System.Windows.Forms.Label();
			this.findComboBox = new System.Windows.Forms.ComboBox();
			this.checkBoxWord = new System.Windows.Forms.CheckBox();
			this.checkBoxCase = new System.Windows.Forms.CheckBox();
			this.optionsGroupBox = new System.Windows.Forms.GroupBox();
			this.optionsGroupBox.SuspendLayout();
			this.SuspendLayout();
			// 
			// checkBoxRegex
			// 
			this.checkBoxRegex.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.checkBoxRegex.Location = new System.Drawing.Point(17, 38);
			this.checkBoxRegex.Name = "checkBoxRegex";
			this.checkBoxRegex.Size = new System.Drawing.Size(130, 24);
			this.checkBoxRegex.TabIndex = 2;
			this.checkBoxRegex.Text = " &Regular Expression";
			// 
			// browseButton
			// 
			this.browseButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.browseButton.Location = new System.Drawing.Point(290, 75);
			this.browseButton.Name = "browseButton";
			this.browseButton.TabIndex = 7;
			this.browseButton.Text = "&Browse";
			this.browseButton.Click += new System.EventHandler(this.BrowseButtonClick);
			// 
			// inFilesLabel
			// 
			this.inFilesLabel.Location = new System.Drawing.Point(23, 50);
			this.inFilesLabel.Name = "inFilesLabel";
			this.inFilesLabel.Size = new System.Drawing.Size(34, 12);
			this.inFilesLabel.TabIndex = 16;
			this.inFilesLabel.Text = "Filter:";
			// 
			// folderComboBox
			// 
			this.folderComboBox.Location = new System.Drawing.Point(57, 76);
			this.folderComboBox.Name = "folderComboBox";
			this.folderComboBox.Size = new System.Drawing.Size(223, 21);
			this.folderComboBox.TabIndex = 3;
			// 
			// checkBoxSub
			// 
			this.checkBoxSub.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.checkBoxSub.Location = new System.Drawing.Point(17, 15);
			this.checkBoxSub.Name = "checkBoxSub";
			this.checkBoxSub.Size = new System.Drawing.Size(130, 24);
			this.checkBoxSub.TabIndex = 1;
			this.checkBoxSub.Text = " &Search Subdirectories";
			// 
			// closeButton
			// 
			this.closeButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.closeButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.closeButton.Location = new System.Drawing.Point(290, 45);
			this.closeButton.Name = "closeButton";
			this.closeButton.TabIndex = 6;
			this.closeButton.Text = "&Close";
			this.closeButton.Click += new System.EventHandler(this.CloseButtonClick);
			// 
			// findLabel
			// 
			this.findLabel.Location = new System.Drawing.Point(27, 20);
			this.findLabel.Name = "findLabel";
			this.findLabel.Size = new System.Drawing.Size(29, 12);
			this.findLabel.TabIndex = 10;
			this.findLabel.Text = "Find:";
			// 
			// filterComboBox
			// 
			this.filterComboBox.Location = new System.Drawing.Point(57, 46);
			this.filterComboBox.Name = "filterComboBox";
			this.filterComboBox.Size = new System.Drawing.Size(223, 21);
			this.filterComboBox.TabIndex = 2;
			this.filterComboBox.Text = "*.as";
			// 
			// findButton
			// 
			this.findButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.findButton.Location = new System.Drawing.Point(290, 15);
			this.findButton.Name = "findButton";
			this.findButton.TabIndex = 5;
			this.findButton.Text = "&Find";
			this.findButton.Click += new System.EventHandler(this.FindButtonClick);
			// 
			// inFolderLabel
			// 
			this.inFolderLabel.Location = new System.Drawing.Point(17, 79);
			this.inFolderLabel.Name = "inFolderLabel";
			this.inFolderLabel.Size = new System.Drawing.Size(39, 12);
			this.inFolderLabel.TabIndex = 18;
			this.inFolderLabel.Text = "Folder:";
			// 
			// findComboBox
			// 
			this.findComboBox.Location = new System.Drawing.Point(57, 16);
			this.findComboBox.Name = "findComboBox";
			this.findComboBox.Size = new System.Drawing.Size(223, 21);
			this.findComboBox.TabIndex = 1;
			// 
			// checkBoxWord
			// 
			this.checkBoxWord.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.checkBoxWord.Location = new System.Drawing.Point(148, 38);
			this.checkBoxWord.Name = "checkBoxWord";
			this.checkBoxWord.Size = new System.Drawing.Size(86, 24);
			this.checkBoxWord.TabIndex = 4;
			this.checkBoxWord.Text = " &Whole Word";
			// 
			// checkBoxCase
			// 
			this.checkBoxCase.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.checkBoxCase.Location = new System.Drawing.Point(148, 15);
			this.checkBoxCase.Name = "checkBoxCase";
			this.checkBoxCase.Size = new System.Drawing.Size(86, 24);
			this.checkBoxCase.TabIndex = 3;
			this.checkBoxCase.Text = " &Match Case";
			// 
			// optionsGroupBox
			// 
			this.optionsGroupBox.Controls.Add(this.checkBoxSub);
			this.optionsGroupBox.Controls.Add(this.checkBoxRegex);
			this.optionsGroupBox.Controls.Add(this.checkBoxCase);
			this.optionsGroupBox.Controls.Add(this.checkBoxWord);
			this.optionsGroupBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.optionsGroupBox.Location = new System.Drawing.Point(24, 106);
			this.optionsGroupBox.Name = "optionsGroupBox";
			this.optionsGroupBox.Size = new System.Drawing.Size(256, 68);
			this.optionsGroupBox.TabIndex = 4;
			this.optionsGroupBox.TabStop = false;
			this.optionsGroupBox.Text = "Options";
			// 
			// FindInFilesDialog
			// 
			this.AcceptButton = this.findButton;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.CancelButton = this.closeButton;
			this.ClientSize = new System.Drawing.Size(380, 191);
			this.Controls.Add(this.optionsGroupBox);
			this.Controls.Add(this.browseButton);
			this.Controls.Add(this.inFolderLabel);
			this.Controls.Add(this.folderComboBox);
			this.Controls.Add(this.inFilesLabel);
			this.Controls.Add(this.filterComboBox);
			this.Controls.Add(this.closeButton);
			this.Controls.Add(this.findLabel);
			this.Controls.Add(this.findComboBox);
			this.Controls.Add(this.findButton);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "FindInFilesDialog";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = " Find In Files";
			this.Closing += new System.ComponentModel.CancelEventHandler(this.FindInFilesClosing);
			this.VisibleChanged += new System.EventHandler(this.OnVisibleChanged);
			this.optionsGroupBox.ResumeLayout(false);
			this.ResumeLayout(false);
		}
		#endregion
	
		#region EventHandlersAndMethods
		
		/**
		* Some event handling when showing the form
		*/
		public void OnVisibleChanged(object sender, System.EventArgs e)
		{
			if (this.Visible)
			{
				this.CenterToParent();
				this.FindInFilesLoad();
			}
		}
		
		/**
		* If there is a word selected, insert it to the find box
		*/
		public void FindInFilesLoad()
		{
			this.folderComboBox.Text = System.IO.Directory.GetCurrentDirectory();
			ScintillaControl sci = this.mainForm.CurSciControl;
			if (sci.SelText.Length>0)
			{
				this.findComboBox.Text = this.mainForm.CurSciControl.SelText;
			}
			this.SelectText();
		}
		
		/**
		* Selects the text in the textfield.
		*/
		public void SelectText()
		{
			this.findComboBox.Select();
			this.findComboBox.SelectAll();
		}
		
		/**
		* Adds the items to ComboBox items
		*/
		public void AddItemsToComboBoxes()
		{
			string find = this.findComboBox.Text;
			if (!this.findComboBox.Items.Contains((string)find))
			{
				this.findComboBox.Items.Insert(0, find);
				this.findComboBox.SelectedIndex = 0;
			}
			string filter = this.filterComboBox.Text;
			if (!this.filterComboBox.Items.Contains((string)filter))
			{
				this.filterComboBox.Items.Insert(0, filter);
				this.filterComboBox.SelectedIndex = 0;
			}
			string folder = this.folderComboBox.Text;
			if (!this.folderComboBox.Items.Contains((string)folder))
			{
				this.folderComboBox.Items.Insert(0, folder);
				this.folderComboBox.SelectedIndex = 0;
			}
		}
		
		/**
		* Closes the find dialog
		*/
		public void CloseButtonClick(object sender, System.EventArgs e)
		{
			this.Close();
		}
		
		/**
		* Hides only the dialog when user closes it
		*/
		private void FindInFilesClosing(object sender, System.ComponentModel.CancelEventArgs e)
		{
			e.Cancel = true;
			this.mainForm.CurSciControl.Focus();
			this.Hide();
		}
		
		/**
		* Show the browse folder dialog
		*/
		private void BrowseButtonClick(object sender, System.EventArgs e)
		{
			if (System.IO.Directory.Exists(this.folderComboBox.Text))
			{
				this.folderBrowserDialog.SelectedPath = this.folderComboBox.Text;
			}
			if (this.folderBrowserDialog.ShowDialog() == DialogResult.OK)
			{
				this.folderComboBox.Text = this.folderBrowserDialog.SelectedPath;
			}
		}
		
		/**
		* Search files
		*/
		private void FindButtonClick(object sender, System.EventArgs e)
		{
			if (this.findComboBox.Text.Length > 0)
			{
				// set search root
				string currentPath = System.IO.Directory.GetCurrentDirectory();
				System.IO.Directory.SetCurrentDirectory(this.folderComboBox.Text);
				// find files
				string findStr = FilePaths.ToolsDir+"findtool"+System.IO.Path.DirectorySeparatorChar+"findtool.exe;";
				string pattern = this.findComboBox.Text.Replace("\"","\\\"");
				if (this.checkBoxSub.Checked) findStr += "-r ";
				if (!this.checkBoxCase.Checked) findStr += "-i ";
				if (this.checkBoxRegex.Checked) findStr += "-e ";
				if (this.checkBoxWord.Checked) findStr += "-w ";
				string path = this.folderComboBox.Text.Trim().TrimEnd(new char[] {'\\'});
				findStr += "\""+path+"\" \""+pattern+"\" "+this.filterComboBox.Text;
				this.mainForm.CallCommand("RunProcessCaptured", findStr);
				this.AddItemsToComboBoxes();
				this.Close();
			}
		}
		
		#endregion
		
	}
	
}
