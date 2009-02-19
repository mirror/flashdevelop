using System;
using System.IO;
using System.Xml;
using System.Data;
using System.Text;
using System.Drawing;
using System.Xml.XPath;
using System.Drawing.Text;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using PluginCore.Localization;
using PluginCore.Helpers;
using PluginCore;

namespace FlashDevelop.Dialogs
{
    public class EditorDialog : Form
    {
		private String languageFile;
        private XmlDocument languageDoc;
        private XmlElement defaultStyleNode;
        private XmlElement currentStyleNode;
        private Boolean isItemSaved = true;
        private Boolean isLanguageSaved = true;
        private Boolean isLoadingItem = false;
        private System.Windows.Forms.Label sizeLabel;
        private System.Windows.Forms.Label fontLabel;
        private System.Windows.Forms.Button okButton;
        private System.Windows.Forms.Button saveButton;
        private System.Windows.Forms.Button exportButton;
        private System.Windows.Forms.Button cancelButton;
        private System.Windows.Forms.ListView itemListView;
        private System.Windows.Forms.ColorDialog colorDialog;
        private System.Windows.Forms.GroupBox settingsGroupBox;
        private System.Windows.Forms.GroupBox previewGroupBox;
        private System.Windows.Forms.Label sampleTextLabel;
        private System.Windows.Forms.ComboBox fontSizeComboBox;
        private System.Windows.Forms.ComboBox fontNameComboBox;
        private System.Windows.Forms.TextBox foregroundTextBox;
        private System.Windows.Forms.CheckBox boldCheckBox;
        private System.Windows.Forms.CheckBox italicsCheckBox;
        private System.Windows.Forms.TextBox backgroundTextBox;
        private System.Windows.Forms.Button backgroundButton;
        private System.Windows.Forms.Button foregroundButton;
        private System.Windows.Forms.ComboBox languageDropDown;
        private System.Windows.Forms.ColumnHeader columnHeader;
        private System.Windows.Forms.Label backgroundLabel;
        private System.Windows.Forms.Label foregroundLabel;

        public EditorDialog()
        {
            this.Owner = Globals.MainForm;
            this.Font = Globals.Settings.DefaultFont;
            this.InitializeComponent();
            this.PopulateControls();
            this.InitializeGraphics();
            this.InitializeTexts();
        }

        #region Windows Form Designer Generated Code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.okButton = new System.Windows.Forms.Button();
            this.saveButton = new System.Windows.Forms.Button();
            this.cancelButton = new System.Windows.Forms.Button();
            this.itemListView = new System.Windows.Forms.ListView();
            this.colorDialog = new System.Windows.Forms.ColorDialog();
            this.settingsGroupBox = new System.Windows.Forms.GroupBox();
            this.italicsCheckBox = new System.Windows.Forms.CheckBox();
            this.backgroundButton = new System.Windows.Forms.Button();
            this.foregroundButton = new System.Windows.Forms.Button();
            this.boldCheckBox = new System.Windows.Forms.CheckBox();
            this.backgroundTextBox = new System.Windows.Forms.TextBox();
            this.foregroundTextBox = new System.Windows.Forms.TextBox();
            this.fontSizeComboBox = new System.Windows.Forms.ComboBox();
            this.fontNameComboBox = new System.Windows.Forms.ComboBox();
            this.sizeLabel = new System.Windows.Forms.Label();
            this.backgroundLabel = new System.Windows.Forms.Label();
            this.foregroundLabel = new System.Windows.Forms.Label();
            this.fontLabel = new System.Windows.Forms.Label();
            this.previewGroupBox = new System.Windows.Forms.GroupBox();
            this.sampleTextLabel = new System.Windows.Forms.Label();
            this.languageDropDown = new System.Windows.Forms.ComboBox();
            this.exportButton = new System.Windows.Forms.Button();
            this.columnHeader = new System.Windows.Forms.ColumnHeader();
            this.settingsGroupBox.SuspendLayout();
            this.previewGroupBox.SuspendLayout();
            this.SuspendLayout();
            // 
            // okButton
            // 
            this.okButton.Location = new System.Drawing.Point(497, 338);
            this.okButton.Name = "okButton";
            this.okButton.Size = new System.Drawing.Size(80, 23);
            this.okButton.TabIndex = 0;
            this.okButton.Text = "&OK";
            this.okButton.UseVisualStyleBackColor = true;
            this.okButton.Click += new System.EventHandler(this.OkButtonClick);
            // 
            // saveButton
            //
            this.saveButton.Enabled = false;
            this.saveButton.Location = new System.Drawing.Point(318, 338);
            this.saveButton.Name = "saveButton";
            this.saveButton.Size = new System.Drawing.Size(80, 23);
            this.saveButton.TabIndex = 0;
            this.saveButton.Text = "&Save";
            this.saveButton.UseVisualStyleBackColor = true;
            this.saveButton.Click += new System.EventHandler(this.SaveButtonClick);
            // 
            // cancelButton
            // 
            this.cancelButton.Location = new System.Drawing.Point(408, 338);
            this.cancelButton.Name = "cancelButton";
            this.cancelButton.Size = new System.Drawing.Size(80, 23);
            this.cancelButton.TabIndex = 0;
            this.cancelButton.Text = "&Cancel";
            this.cancelButton.UseVisualStyleBackColor = true;
            this.cancelButton.Click += new System.EventHandler(this.CancelButtonClick);
            // 
            // itemListView
            //
            this.itemListView.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left)));
            this.itemListView.MultiSelect = false;
            this.itemListView.FullRowSelect = true;
            this.itemListView.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None;
            this.itemListView.Location = new System.Drawing.Point(12, 40);
            this.itemListView.Name = "itemListView";
            this.itemListView.Size = new System.Drawing.Size(182, 322);
            this.itemListView.TabIndex = 5;
            this.itemListView.View = System.Windows.Forms.View.Details;
            this.itemListView.Alignment = System.Windows.Forms.ListViewAlignment.Left;
            this.itemListView.SelectedIndexChanged += new System.EventHandler(this.ItemsSelectedIndexChanged);
            this.itemListView.Columns.Add(this.columnHeader);
            // 
            // settingsGroupBox
            // 
            this.settingsGroupBox.Controls.Add(this.italicsCheckBox);
            this.settingsGroupBox.Controls.Add(this.backgroundButton);
            this.settingsGroupBox.Controls.Add(this.foregroundButton);
            this.settingsGroupBox.Controls.Add(this.boldCheckBox);
            this.settingsGroupBox.Controls.Add(this.backgroundTextBox);
            this.settingsGroupBox.Controls.Add(this.foregroundTextBox);
            this.settingsGroupBox.Controls.Add(this.fontSizeComboBox);
            this.settingsGroupBox.Controls.Add(this.fontNameComboBox);
            this.settingsGroupBox.Controls.Add(this.sizeLabel);
            this.settingsGroupBox.Controls.Add(this.backgroundLabel);
            this.settingsGroupBox.Controls.Add(this.foregroundLabel);
            this.settingsGroupBox.Controls.Add(this.fontLabel);
            this.settingsGroupBox.Location = new System.Drawing.Point(204, 9);
            this.settingsGroupBox.Name = "settingsGroupBox";
            this.settingsGroupBox.Size = new System.Drawing.Size(372, 112);
            this.settingsGroupBox.TabIndex = 6;
            this.settingsGroupBox.TabStop = false;
            this.settingsGroupBox.Text = "Item Settings";
            // 
            // italicsCheckBox
            // 
            this.italicsCheckBox.AutoSize = true;
            this.italicsCheckBox.Checked = true;
            this.italicsCheckBox.CheckState = System.Windows.Forms.CheckState.Indeterminate;
            this.italicsCheckBox.Location = new System.Drawing.Point(272, 84);
            this.italicsCheckBox.Name = "italicsCheckBox";
            this.italicsCheckBox.Size = new System.Drawing.Size(57, 18);
            this.italicsCheckBox.TabIndex = 3;
            this.italicsCheckBox.Text = "Italics";
            this.italicsCheckBox.ThreeState = true;
            this.italicsCheckBox.UseVisualStyleBackColor = true;
            this.italicsCheckBox.CheckStateChanged += new System.EventHandler(this.LanguageItemChanged);
            // 
            // backgroundButton
            // 
            this.backgroundButton.Location = new System.Drawing.Point(229, 77);
            this.backgroundButton.Name = "backgroundButton";
            this.backgroundButton.Size = new System.Drawing.Size(28, 23);
            this.backgroundButton.TabIndex = 7;
            this.backgroundButton.UseVisualStyleBackColor = true;
            this.backgroundButton.Click += new System.EventHandler(this.ItemBackgroundPickerClick);
            // 
            // foregroundButton
            // 
            this.foregroundButton.Location = new System.Drawing.Point(100, 77);
            this.foregroundButton.Name = "foregroundButton";
            this.foregroundButton.Size = new System.Drawing.Size(28, 23);
            this.foregroundButton.TabIndex = 7;
            this.foregroundButton.UseVisualStyleBackColor = true;
            this.foregroundButton.Click += new System.EventHandler(this.ItemForegroundPickerClick);
            // 
            // boldCheckBox
            // 
            this.boldCheckBox.AutoSize = true;
            this.boldCheckBox.Checked = true;
            this.boldCheckBox.CheckState = System.Windows.Forms.CheckState.Indeterminate;
            this.boldCheckBox.Location = new System.Drawing.Point(272, 65);
            this.boldCheckBox.Name = "boldCheckBox";
            this.boldCheckBox.Size = new System.Drawing.Size(51, 20);
            this.boldCheckBox.TabIndex = 3;
            this.boldCheckBox.Text = "Bold";
            this.boldCheckBox.ThreeState = true;
            this.boldCheckBox.UseVisualStyleBackColor = true;
            this.boldCheckBox.CheckStateChanged += new System.EventHandler(this.LanguageItemChanged);
            // 
            // backgroundTextBox
            // 
            this.backgroundTextBox.Location = new System.Drawing.Point(141, 81);
            this.backgroundTextBox.Name = "backgroundTextBox";
            this.backgroundTextBox.Size = new System.Drawing.Size(81, 22);
            this.backgroundTextBox.TabIndex = 2;
            this.backgroundTextBox.TextChanged += new System.EventHandler(this.LanguageItemChanged);
            // 
            // foregroundTextBox
            // 
            this.foregroundTextBox.Location = new System.Drawing.Point(12, 81);
            this.foregroundTextBox.Name = "foregroundTextBox";
            this.foregroundTextBox.Size = new System.Drawing.Size(81, 22);
            this.foregroundTextBox.TabIndex = 2;
            this.foregroundTextBox.TextChanged += new System.EventHandler(this.LanguageItemChanged);
            // 
            // fontSizeComboBox
            // 
            this.fontSizeComboBox.FormattingEnabled = true;
            this.fontSizeComboBox.Items.AddRange(new object[] {"", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"});
            this.fontSizeComboBox.Location = new System.Drawing.Point(269, 35);
            this.fontSizeComboBox.Name = "fontSizeComboBox";
            this.fontSizeComboBox.Size = new System.Drawing.Size(92, 22);
            this.fontSizeComboBox.TabIndex = 1;
            this.fontSizeComboBox.TextChanged += new System.EventHandler(this.LanguageItemChanged);
            // 
            // fontNameComboBox
            // 
            this.fontNameComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.fontNameComboBox.FormattingEnabled = true;
            this.fontNameComboBox.Location = new System.Drawing.Point(12, 35);
            this.fontNameComboBox.Name = "fontNameComboBox";
            this.fontNameComboBox.Size = new System.Drawing.Size(245, 24);
            this.fontNameComboBox.TabIndex = 1;
            this.fontNameComboBox.SelectedIndexChanged += new System.EventHandler(this.LanguageItemChanged);
            // 
            // sizeLabel
            // 
            this.sizeLabel.AutoSize = true;
            this.sizeLabel.Location = new System.Drawing.Point(266, 18);
            this.sizeLabel.Name = "sizeLabel";
            this.sizeLabel.Size = new System.Drawing.Size(31, 16);
            this.sizeLabel.TabIndex = 0;
            this.sizeLabel.Text = "Size:";
            // 
            // backgroundLabel
            // 
            this.backgroundLabel.AutoSize = true;
            this.backgroundLabel.Location = new System.Drawing.Point(138, 62);
            this.backgroundLabel.Name = "backgroundLabel";
            this.backgroundLabel.Size = new System.Drawing.Size(75, 16);
            this.backgroundLabel.TabIndex = 0;
            this.backgroundLabel.Text = "Background:";
            // 
            // foregroundLabel
            // 
            this.foregroundLabel.AutoSize = true;
            this.foregroundLabel.Location = new System.Drawing.Point(9, 62);
            this.foregroundLabel.Name = "foregroundLabel";
            this.foregroundLabel.Size = new System.Drawing.Size(73, 16);
            this.foregroundLabel.TabIndex = 0;
            this.foregroundLabel.Text = "Foreground:";
            // 
            // fontLabel
            // 
            this.fontLabel.AutoSize = true;
            this.fontLabel.Location = new System.Drawing.Point(9, 18);
            this.fontLabel.Name = "fontLabel";
            this.fontLabel.Size = new System.Drawing.Size(35, 16);
            this.fontLabel.TabIndex = 0;
            this.fontLabel.Text = "Font:";
            // 
            // previewGroupBox
            // 
            this.previewGroupBox.Controls.Add(this.sampleTextLabel);
            this.previewGroupBox.Location = new System.Drawing.Point(204, 125);
            this.previewGroupBox.Name = "previewGroupBox";
            this.previewGroupBox.Size = new System.Drawing.Size(372, 204);
            this.previewGroupBox.TabIndex = 6;
            this.previewGroupBox.TabStop = false;
            this.previewGroupBox.Text = "Item Preview";
            // 
            // sampleTextLabel
            //
            this.sampleTextLabel.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.sampleTextLabel.BackColor = System.Drawing.Color.White;
            this.sampleTextLabel.Location = new System.Drawing.Point(12, 18);
            this.sampleTextLabel.Name = "sampleTextLabel";
            this.sampleTextLabel.Size = new System.Drawing.Size(347, 174);
            this.sampleTextLabel.TabIndex = 0;
            this.sampleTextLabel.Text = "Sample Text";
            this.sampleTextLabel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // languageDropDown
            // 
            this.languageDropDown.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.languageDropDown.MaxLength = 200;
            this.languageDropDown.Name = "languageDropDown";
            this.languageDropDown.Location = new System.Drawing.Point(12, 12);
            this.languageDropDown.Size = new System.Drawing.Size(182, 23);
            this.languageDropDown.SelectedIndexChanged += new System.EventHandler(this.LanguagesSelectedIndexChanged);
            // 
            // exportButton
            //
            this.exportButton.Name = "exportButton";
            this.exportButton.Size = new System.Drawing.Size(30, 23);
            this.exportButton.Location = new System.Drawing.Point(204, 338);
            this.exportButton.Click += new System.EventHandler(this.ExportLanguagesClick);
            // 
            // EditorDialog
            //
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.ShowInTaskbar = false;
            this.AcceptButton = this.okButton;
            this.CancelButton = this.cancelButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(589, 372);
            this.Controls.Add(this.previewGroupBox);
            this.Controls.Add(this.settingsGroupBox);
            this.Controls.Add(this.languageDropDown);
            this.Controls.Add(this.itemListView);
            this.Controls.Add(this.exportButton);
            this.Controls.Add(this.cancelButton);
            this.Controls.Add(this.saveButton);
            this.Controls.Add(this.okButton);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Name = "EditorDialog";
            this.Text = " Editor Coloring";
            this.settingsGroupBox.ResumeLayout(false);
            this.settingsGroupBox.PerformLayout();
            this.previewGroupBox.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();
        }

        #endregion

        #region Methods And Event Handlers

        /// <summary>
        /// Gets the path to the language directory
        /// </summary>
        private String LangDir
        {
            get { return Path.Combine(PathHelper.SettingDir, "Languages"); }
        }

        /// <summary>
        /// Constant xml file style paths
        /// </summary>
        private const String stylePath = "Scintilla/languages/language/use-styles/style";
        private const String defaultStylePath = "Scintilla/languages/language/use-styles/style[@name='default']";

        /// <summary>
        /// Initializes the localized texts
        /// </summary>
        private void InitializeTexts()
        {
            ToolTip tooltip = new ToolTip();
            this.languageDropDown.Font = Globals.Settings.DefaultFont;
            this.languageDropDown.FlatStyle = Globals.Settings.ComboBoxFlatStyle;
            tooltip.SetToolTip(this.exportButton, TextHelper.GetString("Label.ExportFiles"));
            this.Text = " " + TextHelper.GetString("Title.SyntaxEditDialog");
            this.boldCheckBox.Text = TextHelper.GetString("Info.Bold");
            this.italicsCheckBox.Text = TextHelper.GetString("Info.Italic");
            this.settingsGroupBox.Text = TextHelper.GetString("Info.ItemSettings");
            this.previewGroupBox.Text = TextHelper.GetString("Info.ItemPreview");
            this.foregroundLabel.Text = TextHelper.GetString("Info.Foreground");
            this.backgroundLabel.Text = TextHelper.GetString("Info.Background");
            this.sampleTextLabel.Text = TextHelper.GetString("Info.SampleText");
            this.cancelButton.Text = TextHelper.GetString("Label.Cancel");
            this.fontLabel.Text = TextHelper.GetString("Info.Font");
            this.sizeLabel.Text = TextHelper.GetString("Info.Size");
            this.saveButton.Text = TextHelper.GetString("Label.Save");
            this.okButton.Text = TextHelper.GetString("Label.Ok");
        }

        /// <summary>
        /// Initializes the graphics
        /// </summary>
        private void InitializeGraphics()
        {
            ImageList imageList = new ImageList();
            imageList.Images.Add(PluginBase.MainForm.FindImage("129"));
            this.itemListView.SmallImageList = imageList;
        }

        /// <summary>
        /// Initializes all ui components
        /// </summary>
        private void PopulateControls()
        {
            this.exportButton.Image = PluginBase.MainForm.FindImage("328|9|3|3");
            this.foregroundButton.Image = PluginBase.MainForm.FindImage("328");
            this.backgroundButton.Image = PluginBase.MainForm.FindImage("328");
            String[] languageFiles = Directory.GetFiles(this.LangDir, "*.xml");
            foreach (String language in languageFiles)
            {
                String languageName = Path.GetFileNameWithoutExtension(language);
                this.languageDropDown.Items.Add(languageName);
            }
            InstalledFontCollection fonts = new InstalledFontCollection();
            this.fontNameComboBox.Items.Add("");
            foreach (FontFamily font in fonts.Families)
            {
                this.fontNameComboBox.Items.Add(font.Name);
            }
            this.languageDropDown.SelectedIndex = 0;
            this.columnHeader.Width = -1;
        }

        /// <summary>
        /// Loads language to be edited
        /// </summary>
        private void LoadLanguage(String newLanguage, Boolean promptToSave)
        {
			if (!isLanguageSaved && promptToSave) this.PromptToSaveLanguage();
			this.languageDoc = new XmlDocument();
            this.languageFile = Path.Combine(this.LangDir, newLanguage + ".xml");
            this.languageDoc.Load(languageFile);
            this.defaultStyleNode = this.languageDoc.SelectSingleNode(defaultStylePath) as XmlElement;
            XmlNodeList styles = this.languageDoc.SelectNodes(stylePath);
            this.itemListView.Items.Clear();
            foreach (XmlNode style in styles)
            {
                this.itemListView.Items.Add(style.Attributes["name"].Value, 0);
            }
            if (this.itemListView.Items.Count > 0)
            {
                this.itemListView.Items[0].Selected = true;
            }
            this.saveButton.Enabled = false;
            this.isLanguageSaved = true;
        }

        /// <summary>
        /// Loads the language item
        /// </summary>
        private void LoadLanguageItem(String item)
        {
            if (!this.isItemSaved) this.SaveCurrentItem();
            this.isLoadingItem = true;
            this.currentStyleNode = this.languageDoc.SelectSingleNode(stylePath + "[@name=\"" + item + "\"]") as XmlElement;
            this.fontNameComboBox.SelectedIndex = 0;
            this.fontSizeComboBox.Text = "";
            this.foregroundTextBox.Text = "";
            this.backgroundTextBox.Text = "";
            this.boldCheckBox.CheckState = CheckState.Indeterminate;
            this.italicsCheckBox.CheckState = CheckState.Indeterminate;
            if (this.currentStyleNode.Attributes["font"] != null)
            {
                this.fontNameComboBox.Text = this.currentStyleNode.Attributes["font"].Value;
            }
            if (this.currentStyleNode.Attributes["size"] != null)
            {
                this.fontSizeComboBox.Text = this.currentStyleNode.Attributes["size"].Value;
            }
            if (this.currentStyleNode.Attributes["fore"] != null)
            {
                this.foregroundTextBox.Text = this.currentStyleNode.Attributes["fore"].Value;
            }
            if (this.currentStyleNode.Attributes["back"] != null)
            {
                this.backgroundTextBox.Text = this.currentStyleNode.Attributes["back"].Value;
            }
            if (this.currentStyleNode.Attributes["bold"] != null)
            {
                this.boldCheckBox.CheckState = CheckState.Unchecked;
                this.boldCheckBox.Checked = Boolean.Parse(this.currentStyleNode.Attributes["bold"].Value);
            }
            if (this.currentStyleNode.Attributes["italics"] != null)
            {
                this.italicsCheckBox.CheckState = CheckState.Unchecked;
                this.italicsCheckBox.Checked = Boolean.Parse(this.currentStyleNode.Attributes["italics"].Value);
            }
            this.UpdateSampleText();
            this.isLoadingItem = false;
            this.isItemSaved = true;
        }

        /// <summary>
        /// Saves the current item being edited
        /// </summary>
        private void SaveCurrentItem()
        {
            if (this.fontNameComboBox.Text != "") this.currentStyleNode.SetAttribute("font", fontNameComboBox.Text);
            else this.currentStyleNode.RemoveAttribute("font");
            if (this.fontSizeComboBox.Text != "") this.currentStyleNode.SetAttribute("size", fontSizeComboBox.Text);
            else this.currentStyleNode.RemoveAttribute("size");
            if (this.foregroundTextBox.Text != "") this.currentStyleNode.SetAttribute("fore", foregroundTextBox.Text);
            else this.currentStyleNode.RemoveAttribute("fore");
            if (this.backgroundTextBox.Text != "") this.currentStyleNode.SetAttribute("back", backgroundTextBox.Text);
            else this.currentStyleNode.RemoveAttribute("back");
            if (this.boldCheckBox.CheckState == CheckState.Checked) this.currentStyleNode.SetAttribute("bold", "true");
            else if (this.boldCheckBox.CheckState == CheckState.Unchecked) this.currentStyleNode.SetAttribute("bold", "false");
            else this.currentStyleNode.RemoveAttribute("bold");
            if (this.italicsCheckBox.CheckState == CheckState.Checked) this.currentStyleNode.SetAttribute("italics", "true");
            else if (this.italicsCheckBox.CheckState == CheckState.Unchecked) this.currentStyleNode.SetAttribute("italics", "false");
            else this.currentStyleNode.RemoveAttribute("italics");
            this.isItemSaved = true;
        }

        /// <summary>
        /// Updates the Sample Item from settings in dialog
        /// </summary>
        private void UpdateSampleText()
        {
			try
			{
                FontStyle fs = FontStyle.Regular;
                String fontName = this.fontNameComboBox.Text;
                if (fontName == "") fontName = this.defaultStyleNode.Attributes["font"].Value;
                String fontSize = this.fontSizeComboBox.Text;
                if (fontSize == "") fontSize = this.defaultStyleNode.Attributes["size"].Value;
                String foreColor = this.foregroundTextBox.Text;
                if (foreColor == "") foreColor = this.defaultStyleNode.Attributes["fore"].Value;
                String backColor = this.backgroundTextBox.Text;
                if (backColor == "") backColor = this.defaultStyleNode.Attributes["back"].Value;
                if (this.boldCheckBox.CheckState == CheckState.Checked) fs |= FontStyle.Bold;
                else if (this.boldCheckBox.CheckState == CheckState.Indeterminate)
                {
                    if (this.defaultStyleNode.Attributes["bold"] != null)
                    {
                        if (this.defaultStyleNode.Attributes["bold"].Value == "true") fs |= FontStyle.Bold;
                    }
                }
                if (this.italicsCheckBox.CheckState == CheckState.Checked) fs |= FontStyle.Bold;
                else if (this.italicsCheckBox.CheckState == CheckState.Indeterminate)
                {
                    if (this.defaultStyleNode.Attributes["italics"] != null)
                    {
                        if (this.defaultStyleNode.Attributes["italics"].Value == "true") fs |= FontStyle.Italic;
                    }
                }
                this.sampleTextLabel.Text = TextHelper.GetString("Info.SampleText");
                this.sampleTextLabel.Font = new Font(fontName, float.Parse(fontSize), fs);
                this.sampleTextLabel.ForeColor = ColorTranslator.FromHtml(foreColor);
                this.sampleTextLabel.BackColor = ColorTranslator.FromHtml(backColor);
			}
			catch (Exception)
			{
                this.sampleTextLabel.Font = PluginBase.Settings.ConsoleFont;
                this.sampleTextLabel.Text = "Preview not available...";
			}
        }

        /// <summary>
        /// Asks the user to save the changes
        /// </summary>
		private void PromptToSaveLanguage()
		{
            String message = TextHelper.GetString("Info.SaveCurrentLanguage");
            String caption = TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
            if (MessageBox.Show(message, caption, MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                this.SaveCurrentLanguage();
            }
		}

        /// <summary>
        /// After item has been changed, update controls
        /// </summary>
        private void ItemsSelectedIndexChanged(Object sender, EventArgs e)
        {
            if (this.itemListView.SelectedIndices.Count > 0)
            {
                String language = this.itemListView.SelectedItems[0].Text;
                this.LoadLanguageItem(language);
            }
        }

        /// <summary>
        /// When color has been selected, update controls
        /// </summary>
        private void ItemForegroundPickerClick(Object sender, EventArgs e)
        {
            this.colorDialog.Color = ColorTranslator.FromHtml(this.foregroundTextBox.Text);
            if (this.colorDialog.ShowDialog() == DialogResult.OK)
            {
                this.foregroundTextBox.Text = "0x" + this.colorDialog.Color.ToArgb().ToString("X8").Substring(2, 6);
            }
        }

        /// <summary>
        /// When color has been selected, update controls
        /// </summary>
        private void ItemBackgroundPickerClick(Object sender, EventArgs e)
        {
            this.colorDialog.Color = ColorTranslator.FromHtml(this.backgroundTextBox.Text);
            if (this.colorDialog.ShowDialog() == DialogResult.OK)
            {
                this.backgroundTextBox.Text = "0x" + this.colorDialog.Color.ToArgb().ToString("X8").Substring(2, 6);
            }
        }

        /// <summary>
        /// When item has been changed, update controls
        /// </summary>
        private void LanguageItemChanged(Object sender, EventArgs e)
        {
            if (!this.isLoadingItem)
            {
                this.isItemSaved = false;
                this.isLanguageSaved = false;
                this.saveButton.Enabled = true;
                this.UpdateSampleText();
            }
        }

        /// <summary>
        /// Saves the current modified language
        /// </summary>
		private void SaveCurrentLanguage()
		{
            if (!this.isItemSaved) this.SaveCurrentItem();
            XmlTextWriter xmlWriter = new XmlTextWriter(this.languageFile, Encoding.UTF8);
            xmlWriter.Formatting = Formatting.Indented;
            xmlWriter.IndentChar = '\t';
            xmlWriter.Indentation = 1;
            this.languageDoc.Save(xmlWriter);
            this.saveButton.Enabled = false;
            this.isLanguageSaved = true;
            xmlWriter.Close();
		}

        /// <summary>
        /// After index has been changed, load the selected language
        /// </summary>
        private void LanguagesSelectedIndexChanged(Object sender, EventArgs e)
		{
            this.LoadLanguage(this.languageDropDown.Text, true);
		}

        /// <summary>
        /// Opens the export settings dialog
        /// </summary>
        private void ExportLanguagesClick(Object sender, EventArgs e)
        {
            ExportDialog.CreateDialog(this.LangDir).ShowDialog();
        }

        /// <summary>
        /// Saves the current language
        /// </summary>
        private void SaveButtonClick(Object sender, EventArgs e)
        {
            Globals.MainForm.RefreshSciConfig();
            this.SaveCurrentLanguage();
        }

        /// <summary>
        /// Closes the dialog without saving
        /// </summary>
        private void CancelButtonClick(Object sender, EventArgs e)
        {
            this.Close();
        }

        /// <summary>
        /// Closes the dialog and saves changes
        /// </summary>
		private void OkButtonClick(Object sender, EventArgs e)
		{
            if (!this.isLanguageSaved) this.SaveCurrentLanguage();
            Globals.MainForm.RefreshSciConfig();
			this.Close();
        }

        /// <summary>
        /// Shows the syntax edit dialog
        /// </summary>
        public static new void Show()
        {
            EditorDialog sp = new EditorDialog();
            sp.ShowDialog();
        }

        #endregion

    }

}
