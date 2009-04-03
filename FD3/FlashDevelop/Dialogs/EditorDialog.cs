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
using ICSharpCode.SharpZipLib.Zip;
using System.Collections.Generic;
using FlashDevelop.Utilities;
using PluginCore.Localization;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore;

namespace FlashDevelop.Dialogs
{
    public class EditorDialog : Form
    {
        private String languageFile;
        private XmlDocument languageDoc;
        private XmlElement editorStyleNode;
        private XmlElement defaultStyleNode;
        private XmlElement currentStyleNode;
        private Boolean isItemSaved = true;
        private Boolean isEditorSaved = true;
        private Boolean isLoadingEditor = false;
        private Boolean isLanguageSaved = true;
        private Boolean isLoadingItem = false;
        private System.Windows.Forms.Label sizeLabel;
        private System.Windows.Forms.Label fontLabel;
        private System.Windows.Forms.Button okButton;
        private System.Windows.Forms.Button revertButton;
        private System.Windows.Forms.Button applyButton;
        private System.Windows.Forms.Button exportButton;
        private System.Windows.Forms.Button cancelButton;
        private System.Windows.Forms.ListView itemListView;
        private System.Windows.Forms.ColorDialog colorDialog;
        private System.Windows.Forms.GroupBox itemGroupBox;
        private System.Windows.Forms.GroupBox languageGroupBox;
        private System.Windows.Forms.Label caretForeLabel;
        private System.Windows.Forms.Label caretlineBackLabel;
        private System.Windows.Forms.Label selectionForeLabel;
        private System.Windows.Forms.Label selectionBackLabel;
        private System.Windows.Forms.Button caretForeButton;
        private System.Windows.Forms.Button caretlineBackButton;
        private System.Windows.Forms.Button selectionForeButton;
        private System.Windows.Forms.Button selectionBackButton;
        private System.Windows.Forms.TextBox caretForeTextBox;
        private System.Windows.Forms.TextBox caretlineBackTextBox;
        private System.Windows.Forms.TextBox selectionForeTextBox;
        private System.Windows.Forms.TextBox selectionBackTextBox;
        private System.Windows.Forms.SaveFileDialog saveFileDialog;
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
            this.ApplyLocalizedTexts();
            this.InitializeGraphics();
            this.PopulateControls();
        }

        #region Windows Form Designer Generated Code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.okButton = new System.Windows.Forms.Button();
            this.applyButton = new System.Windows.Forms.Button();
            this.revertButton = new System.Windows.Forms.Button();
            this.cancelButton = new System.Windows.Forms.Button();
            this.itemListView = new System.Windows.Forms.ListView();
            this.colorDialog = new System.Windows.Forms.ColorDialog();
            this.itemGroupBox = new System.Windows.Forms.GroupBox();
            this.italicsCheckBox = new System.Windows.Forms.CheckBox();
            this.backgroundButton = new System.Windows.Forms.Button();
            this.foregroundButton = new System.Windows.Forms.Button();
            this.boldCheckBox = new System.Windows.Forms.CheckBox();
            this.backgroundTextBox = new System.Windows.Forms.TextBox();
            this.foregroundTextBox = new System.Windows.Forms.TextBox();
            this.fontSizeComboBox = new System.Windows.Forms.ComboBox();
            this.fontNameComboBox = new System.Windows.Forms.ComboBox();
            this.caretForeButton = new System.Windows.Forms.Button();
            this.caretlineBackButton = new System.Windows.Forms.Button();
            this.selectionBackButton = new System.Windows.Forms.Button();
            this.selectionForeButton = new System.Windows.Forms.Button();
            this.caretForeTextBox = new System.Windows.Forms.TextBox();
            this.caretlineBackTextBox = new System.Windows.Forms.TextBox();
            this.selectionForeTextBox = new System.Windows.Forms.TextBox();
            this.selectionBackTextBox = new System.Windows.Forms.TextBox();
            this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.backgroundLabel = new System.Windows.Forms.Label();
            this.foregroundLabel = new System.Windows.Forms.Label();
            this.languageGroupBox = new System.Windows.Forms.GroupBox();
            this.sampleTextLabel = new System.Windows.Forms.Label();
            this.languageDropDown = new System.Windows.Forms.ComboBox();
            this.exportButton = new System.Windows.Forms.Button();
            this.columnHeader = new System.Windows.Forms.ColumnHeader();
            this.selectionBackLabel = new System.Windows.Forms.Label();
            this.selectionForeLabel = new System.Windows.Forms.Label();
            this.caretlineBackLabel = new System.Windows.Forms.Label();
            this.caretForeLabel = new System.Windows.Forms.Label();
            this.sizeLabel = new System.Windows.Forms.Label();
            this.fontLabel = new System.Windows.Forms.Label();
            this.itemGroupBox.SuspendLayout();
            this.languageGroupBox.SuspendLayout();
            this.SuspendLayout();
            // 
            // saveFileDialog
            //
            this.saveFileDialog.AddExtension = true;
            this.saveFileDialog.DefaultExt = "fdz";
            this.saveFileDialog.Filter = "FlashDevelop Zip Files|*.fdz";
            // 
            // okButton
            //
            this.okButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.okButton.Location = new System.Drawing.Point(318, 338);
            this.okButton.Name = "okButton";
            this.okButton.Size = new System.Drawing.Size(80, 23);
            this.okButton.TabIndex = 1;
            this.okButton.Text = "&OK";
            this.okButton.UseVisualStyleBackColor = true;
            this.okButton.Click += new System.EventHandler(this.OkButtonClick);
            // 
            // applyButton
            //
            this.applyButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.applyButton.Enabled = false;
            this.applyButton.Location = new System.Drawing.Point(497, 338);
            this.applyButton.Name = "applyButton";
            this.applyButton.Size = new System.Drawing.Size(80, 23);
            this.applyButton.TabIndex = 3;
            this.applyButton.Text = "&Apply";
            this.applyButton.UseVisualStyleBackColor = true;
            this.applyButton.Click += new System.EventHandler(this.SaveButtonClick);
            // 
            // cancelButton
            //
            this.cancelButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.cancelButton.Location = new System.Drawing.Point(408, 338);
            this.cancelButton.Name = "cancelButton";
            this.cancelButton.Size = new System.Drawing.Size(80, 23);
            this.cancelButton.TabIndex = 2;
            this.cancelButton.Text = "&Cancel";
            this.cancelButton.UseVisualStyleBackColor = true;
            this.cancelButton.Click += new System.EventHandler(this.CancelButtonClick);
            // 
            // itemListView
            //
            this.itemListView.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left)));
            this.itemListView.MultiSelect = false;
            this.itemListView.HideSelection = false;
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
            // itemGroupBox
            //
            this.itemGroupBox.Controls.Add(this.sampleTextLabel);
            this.itemGroupBox.Controls.Add(this.italicsCheckBox);
            this.itemGroupBox.Controls.Add(this.backgroundButton);
            this.itemGroupBox.Controls.Add(this.foregroundButton);
            this.itemGroupBox.Controls.Add(this.boldCheckBox);
            this.itemGroupBox.Controls.Add(this.backgroundTextBox);
            this.itemGroupBox.Controls.Add(this.foregroundTextBox);
            this.itemGroupBox.Controls.Add(this.fontSizeComboBox);
            this.itemGroupBox.Controls.Add(this.fontNameComboBox);
            this.itemGroupBox.Controls.Add(this.sizeLabel);
            this.itemGroupBox.Controls.Add(this.backgroundLabel);
            this.itemGroupBox.Controls.Add(this.foregroundLabel);
            this.itemGroupBox.Controls.Add(this.fontLabel);
            this.itemGroupBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.itemGroupBox.Location = new System.Drawing.Point(204, 121);
            this.itemGroupBox.Name = "settingsGroupBox";
            this.itemGroupBox.Size = new System.Drawing.Size(372, 208);
            this.itemGroupBox.TabIndex = 7;
            this.itemGroupBox.TabStop = false;
            this.itemGroupBox.Text = "Item Style";
            // 
            // italicsCheckBox
            // 
            this.italicsCheckBox.AutoSize = true;
            this.italicsCheckBox.Checked = true;
            this.italicsCheckBox.CheckState = System.Windows.Forms.CheckState.Indeterminate;
            this.italicsCheckBox.Location = new System.Drawing.Point(272, 85);
            this.italicsCheckBox.Name = "italicsCheckBox";
            this.italicsCheckBox.Size = new System.Drawing.Size(57, 18);
            this.italicsCheckBox.TabIndex = 12;
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
            this.backgroundButton.TabIndex = 10;
            this.backgroundButton.UseVisualStyleBackColor = true;
            this.backgroundButton.Click += new System.EventHandler(this.ItemBackgroundButtonClick);
            // 
            // foregroundButton
            // 
            this.foregroundButton.Location = new System.Drawing.Point(100, 77);
            this.foregroundButton.Name = "foregroundButton";
            this.foregroundButton.Size = new System.Drawing.Size(28, 23);
            this.foregroundButton.TabIndex = 7;
            this.foregroundButton.UseVisualStyleBackColor = true;
            this.foregroundButton.Click += new System.EventHandler(this.ItemForegroundButtonClick);
            // 
            // boldCheckBox
            // 
            this.boldCheckBox.AutoSize = true;
            this.boldCheckBox.Checked = true;
            this.boldCheckBox.CheckState = System.Windows.Forms.CheckState.Indeterminate;
            this.boldCheckBox.Location = new System.Drawing.Point(272, 66);
            this.boldCheckBox.Name = "boldCheckBox";
            this.boldCheckBox.Size = new System.Drawing.Size(51, 20);
            this.boldCheckBox.TabIndex = 11;
            this.boldCheckBox.Text = "Bold";
            this.boldCheckBox.ThreeState = true;
            this.boldCheckBox.UseVisualStyleBackColor = true;
            this.boldCheckBox.CheckStateChanged += new System.EventHandler(this.LanguageItemChanged);
            // 
            // backgroundTextBox
            // 
            this.backgroundTextBox.Location = new System.Drawing.Point(141, 80);
            this.backgroundTextBox.Name = "backgroundTextBox";
            this.backgroundTextBox.Size = new System.Drawing.Size(81, 22);
            this.backgroundTextBox.TabIndex = 9;
            this.backgroundTextBox.TextChanged += new System.EventHandler(this.LanguageItemChanged);
            // 
            // foregroundTextBox
            // 
            this.foregroundTextBox.Location = new System.Drawing.Point(12, 80);
            this.foregroundTextBox.Name = "foregroundTextBox";
            this.foregroundTextBox.Size = new System.Drawing.Size(81, 22);
            this.foregroundTextBox.TabIndex = 6;
            this.foregroundTextBox.TextChanged += new System.EventHandler(this.LanguageItemChanged);
            // 
            // fontSizeComboBox
            // 
            this.fontSizeComboBox.FormattingEnabled = true;
            this.fontSizeComboBox.Items.AddRange(new object[] { "", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24" });
            this.fontSizeComboBox.Location = new System.Drawing.Point(269, 35);
            this.fontSizeComboBox.Name = "fontSizeComboBox";
            this.fontSizeComboBox.Size = new System.Drawing.Size(92, 22);
            this.fontSizeComboBox.TabIndex = 4;
            this.fontSizeComboBox.TextChanged += new System.EventHandler(this.LanguageItemChanged);
            // 
            // fontNameComboBox
            // 
            this.fontNameComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.fontNameComboBox.FormattingEnabled = true;
            this.fontNameComboBox.Location = new System.Drawing.Point(12, 35);
            this.fontNameComboBox.Name = "fontNameComboBox";
            this.fontNameComboBox.Size = new System.Drawing.Size(245, 24);
            this.fontNameComboBox.TabIndex = 2;
            this.fontNameComboBox.SelectedIndexChanged += new System.EventHandler(this.LanguageItemChanged);
            // 
            // sizeLabel
            // 
            this.sizeLabel.AutoSize = true;
            this.sizeLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.sizeLabel.Location = new System.Drawing.Point(269, 18);
            this.sizeLabel.Name = "sizeLabel";
            this.sizeLabel.Size = new System.Drawing.Size(31, 16);
            this.sizeLabel.TabIndex = 3;
            this.sizeLabel.Text = "Size:";
            // 
            // backgroundLabel
            // 
            this.backgroundLabel.AutoSize = true;
            this.backgroundLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.backgroundLabel.Location = new System.Drawing.Point(141, 63);
            this.backgroundLabel.Name = "backgroundLabel";
            this.backgroundLabel.Size = new System.Drawing.Size(75, 16);
            this.backgroundLabel.TabIndex = 8;
            this.backgroundLabel.Text = "Background:";
            // 
            // foregroundLabel
            //
            this.foregroundLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.foregroundLabel.AutoSize = true;
            this.foregroundLabel.Location = new System.Drawing.Point(12, 63);
            this.foregroundLabel.Name = "foregroundLabel";
            this.foregroundLabel.Size = new System.Drawing.Size(73, 16);
            this.foregroundLabel.TabIndex = 5;
            this.foregroundLabel.Text = "Foreground:";
            // 
            // fontLabel
            //
            this.fontLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.fontLabel.AutoSize = true;
            this.fontLabel.Location = new System.Drawing.Point(12, 18);
            this.fontLabel.Name = "fontLabel";
            this.fontLabel.Size = new System.Drawing.Size(35, 16);
            this.fontLabel.TabIndex = 1;
            this.fontLabel.Text = "Font:";
            // 
            // caretForeButton
            //
            this.caretForeButton.Location = new System.Drawing.Point(151, 32);
            this.caretForeButton.Name = "caretForeButton";
            this.caretForeButton.Size = new System.Drawing.Size(28, 23);
            this.caretForeButton.TabIndex = 3;
            this.caretForeButton.Click += new EventHandler(this.CaretForeButtonClick);
            // 
            // caretlineBackButton
            // 
            this.caretlineBackButton.Location = new System.Drawing.Point(151, 74);
            this.caretlineBackButton.Name = "caretlineBackButton";
            this.caretlineBackButton.Size = new System.Drawing.Size(28, 23);
            this.caretlineBackButton.TabIndex = 6;
            this.caretlineBackButton.Click += new EventHandler(this.CaretlineBackButtonClick);
            // 
            // selectionBackButton
            // 
            this.selectionBackButton.Location = new System.Drawing.Point(329, 74);
            this.selectionBackButton.Name = "selectionBackButton";
            this.selectionBackButton.Size = new System.Drawing.Size(28, 23);
            this.selectionBackButton.TabIndex = 12;
            this.selectionBackButton.Click += new EventHandler(this.SelectionBackButtonClick);
            // 
            // selectionForeButton
            // 
            this.selectionForeButton.Location = new System.Drawing.Point(329, 32);
            this.selectionForeButton.Name = "selectionForeButton";
            this.selectionForeButton.Size = new System.Drawing.Size(28, 23);
            this.selectionForeButton.TabIndex = 9;
            this.selectionForeButton.Click += new EventHandler(this.SelectionForeButtonClick);
            // 
            // caretForeTextBox
            // 
            this.caretForeTextBox.Location = new System.Drawing.Point(12, 35);
            this.caretForeTextBox.Name = "caretForeTextBox";
            this.caretForeTextBox.Size = new System.Drawing.Size(132, 25);
            this.caretForeTextBox.TabIndex = 2;
            this.caretForeTextBox.TextChanged += new EventHandler(this.EditorItemChanged);
            // 
            // caretlineBackTextBox
            // 
            this.caretlineBackTextBox.Location = new System.Drawing.Point(12, 76);
            this.caretlineBackTextBox.Name = "caretlineBackTextBox";
            this.caretlineBackTextBox.Size = new System.Drawing.Size(132, 25);
            this.caretlineBackTextBox.TabIndex = 5;
            this.caretlineBackTextBox.TextChanged += new EventHandler(this.EditorItemChanged);
            // 
            // selectionForeTextBox
            // 
            this.selectionForeTextBox.Location = new System.Drawing.Point(190, 35);
            this.selectionForeTextBox.Name = "selectionForeTextBox";
            this.selectionForeTextBox.Size = new System.Drawing.Size(132, 25);
            this.selectionForeTextBox.TabIndex = 8;
            this.selectionForeTextBox.TextChanged += new EventHandler(this.EditorItemChanged);
            // 
            // selectionBackTextBox
            // 
            this.selectionBackTextBox.Location = new System.Drawing.Point(190, 76);
            this.selectionBackTextBox.Name = "selectionBackTextBox";
            this.selectionBackTextBox.Size = new System.Drawing.Size(132, 25);
            this.selectionBackTextBox.TabIndex = 11;
            this.selectionBackTextBox.TextChanged += new EventHandler(this.EditorItemChanged);
            // 
            // caretForeLabel
            //
            this.caretForeLabel.AutoSize = true;
            this.caretForeLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.caretForeLabel.Location = new System.Drawing.Point(12, 18);
            this.caretForeLabel.Name = "caretForeLabel";
            this.caretForeLabel.Size = new System.Drawing.Size(35, 16);
            this.caretForeLabel.TabIndex = 1;
            this.caretForeLabel.Text = "Caret foreground:";
            // 
            // caretlineBackLabel
            //
            this.caretlineBackLabel.AutoSize = true;
            this.caretlineBackLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.caretlineBackLabel.Location = new System.Drawing.Point(12, 60);
            this.caretlineBackLabel.Name = "caretlineBackLabel";
            this.caretlineBackLabel.Size = new System.Drawing.Size(35, 16);
            this.caretlineBackLabel.TabIndex = 4;
            this.caretlineBackLabel.Text = "Caret line background:";
            // 
            // selectionBackLabel
            //
            this.selectionBackLabel.AutoSize = true;
            this.selectionBackLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.selectionBackLabel.Location = new System.Drawing.Point(190, 60);
            this.selectionBackLabel.Name = "selectionBackLabel";
            this.selectionBackLabel.Size = new System.Drawing.Size(35, 16);
            this.selectionBackLabel.TabIndex = 10;
            this.selectionBackLabel.Text = "Selection background:";
            // 
            // selectionForeLabel
            //
            this.selectionForeLabel.AutoSize = true;
            this.selectionForeLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.selectionForeLabel.Location = new System.Drawing.Point(190, 18);
            this.selectionForeLabel.Name = "selectionForeLabel";
            this.selectionForeLabel.Size = new System.Drawing.Size(35, 16);
            this.selectionForeLabel.TabIndex = 7;
            this.selectionForeLabel.Text = "Selection foreground:";
            // 
            // previewGroupBox
            //
            this.languageGroupBox.Controls.Add(this.caretForeButton);
            this.languageGroupBox.Controls.Add(this.caretForeLabel);
            this.languageGroupBox.Controls.Add(this.caretForeTextBox);
            this.languageGroupBox.Controls.Add(this.caretlineBackButton);
            this.languageGroupBox.Controls.Add(this.caretlineBackLabel);
            this.languageGroupBox.Controls.Add(this.caretlineBackTextBox);
            this.languageGroupBox.Controls.Add(this.selectionBackButton);
            this.languageGroupBox.Controls.Add(this.selectionBackLabel);
            this.languageGroupBox.Controls.Add(this.selectionBackTextBox);
            this.languageGroupBox.Controls.Add(this.selectionForeButton);
            this.languageGroupBox.Controls.Add(this.selectionForeLabel);
            this.languageGroupBox.Controls.Add(this.selectionForeTextBox);
            this.languageGroupBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.languageGroupBox.Location = new System.Drawing.Point(204, 9);
            this.languageGroupBox.Name = "previewGroupBox";
            this.languageGroupBox.Size = new System.Drawing.Size(372, 108);
            this.languageGroupBox.TabIndex = 6;
            this.languageGroupBox.TabStop = false;
            this.languageGroupBox.Text = "Editor Style";
            // 
            // sampleTextLabel
            //
            this.sampleTextLabel.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.sampleTextLabel.BackColor = System.Drawing.Color.White;
            this.sampleTextLabel.Location = new System.Drawing.Point(13, 110);
            this.sampleTextLabel.Name = "sampleTextLabel";
            this.sampleTextLabel.Size = new System.Drawing.Size(347, 85);
            this.sampleTextLabel.TabIndex = 13;
            this.sampleTextLabel.Text = "Sample Text";
            this.sampleTextLabel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // languageDropDown
            // 
            this.languageDropDown.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.languageDropDown.MaxLength = 200;
            this.languageDropDown.Name = "languageDropDown";
            this.languageDropDown.TabIndex = 4;
            this.languageDropDown.Location = new System.Drawing.Point(12, 12);
            this.languageDropDown.Size = new System.Drawing.Size(182, 23);
            this.languageDropDown.SelectedIndexChanged += new System.EventHandler(this.LanguagesSelectedIndexChanged);
            // 
            // exportButton
            //
            this.exportButton.Name = "exportButton";
            this.exportButton.TabIndex = 8;
            this.exportButton.Size = new System.Drawing.Size(30, 23);
            this.exportButton.Location = new System.Drawing.Point(204, 338);
            this.exportButton.Click += new System.EventHandler(this.ExportLanguagesClick);
            // 
            // revertButton
            //
            this.revertButton.Name = "revertButton";
            this.revertButton.TabIndex = 9;
            this.revertButton.Size = new System.Drawing.Size(30, 23);
            this.revertButton.Location = new System.Drawing.Point(244, 338);
            this.revertButton.Click += new System.EventHandler(this.RevertLanguagesClick);
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
            this.Controls.Add(this.languageGroupBox);
            this.Controls.Add(this.itemGroupBox);
            this.Controls.Add(this.languageDropDown);
            this.Controls.Add(this.itemListView);
            this.Controls.Add(this.revertButton);
            this.Controls.Add(this.exportButton);
            this.Controls.Add(this.cancelButton);
            this.Controls.Add(this.applyButton);
            this.Controls.Add(this.okButton);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Name = "EditorDialog";
            this.Text = " Editor Coloring";
            this.itemGroupBox.ResumeLayout(false);
            this.itemGroupBox.PerformLayout();
            this.languageGroupBox.ResumeLayout(false);
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
        private const String coloringStart = "<!-- COLORING_START -->";
        private const String coloringEnd = "<!-- COLORING_END -->";

        /// <summary>
        /// Constant xml file style paths
        /// </summary>
        private const String stylePath = "Scintilla/languages/language/use-styles/style";
        private const String editorStylePath = "Scintilla/languages/language/editor-style";
        private const String defaultStylePath = "Scintilla/languages/language/use-styles/style[@name='default']";

        /// <summary>
        /// Applies the localized texts to the form
        /// </summary>
        private void ApplyLocalizedTexts()
        {
            ToolTip tooltip = new ToolTip();
            this.languageDropDown.Font = Globals.Settings.DefaultFont;
            this.languageDropDown.FlatStyle = Globals.Settings.ComboBoxFlatStyle;
            tooltip.SetToolTip(this.exportButton, TextHelper.GetString("Label.ExportFiles"));
            tooltip.SetToolTip(this.revertButton, TextHelper.GetString("Label.RevertFiles"));
            this.saveFileDialog.Filter = TextHelper.GetString("Info.ZipFilter");
            this.Text = " " + TextHelper.GetString("Title.SyntaxEditDialog");
            this.boldCheckBox.Text = TextHelper.GetString("Info.Bold");
            this.italicsCheckBox.Text = TextHelper.GetString("Info.Italic");
            this.itemGroupBox.Text = TextHelper.GetString("Info.ItemStyle");
            this.languageGroupBox.Text = TextHelper.GetString("Info.EditorStyle");
            this.foregroundLabel.Text = TextHelper.GetString("Info.Foreground");
            this.backgroundLabel.Text = TextHelper.GetString("Info.Background");
            this.sampleTextLabel.Text = TextHelper.GetString("Info.SampleText");
            this.caretForeLabel.Text = TextHelper.GetString("Info.CaretFore");
            this.caretlineBackLabel.Text = TextHelper.GetString("Info.CaretLineBack");
            this.selectionBackLabel.Text = TextHelper.GetString("Info.SelectionBack");
            this.selectionForeLabel.Text = TextHelper.GetString("Info.SelectionFore");
            this.cancelButton.Text = TextHelper.GetString("Label.Cancel");
            this.applyButton.Text = TextHelper.GetString("Label.Apply");
            this.fontLabel.Text = TextHelper.GetString("Info.Font");
            this.sizeLabel.Text = TextHelper.GetString("Info.Size");
            this.okButton.Text = TextHelper.GetString("Label.Ok");
            if (Globals.MainForm.StandaloneMode)
            {
                this.revertButton.Enabled = false;
            }
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
            Image colorImage = PluginBase.MainForm.FindImage("328");
            this.revertButton.Image = PluginBase.MainForm.FindImage("55|24|3|3");
            this.exportButton.Image = PluginBase.MainForm.FindImage("55|9|3|3");
            this.foregroundButton.Image = this.backgroundButton.Image = colorImage;
            this.caretForeButton.Image = this.caretlineBackButton.Image = colorImage;
            this.selectionForeButton.Image = this.selectionBackButton.Image = colorImage;
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
            Boolean foundSyntax = false;
            String curSyntax = ArgsProcessor.GetCurSyntax();
            foreach (Object item in this.languageDropDown.Items)
            {
                if (item.ToString().ToLower() == curSyntax)
                {
                    this.languageDropDown.SelectedItem = item;
                    foundSyntax = true;
                    break;
                }
            }
            if (!foundSyntax) this.languageDropDown.SelectedIndex = 0;
            this.columnHeader.Width = -2;
        }

        /// <summary>
        /// Loads language to be edited
        /// </summary>
        private void LoadLanguage(String newLanguage, Boolean promptToSave)
        {
            if (!this.isLanguageSaved && promptToSave)
            {
                this.PromptToSaveLanguage();
            }
            this.languageDoc = new XmlDocument();
            this.languageFile = Path.Combine(this.LangDir, newLanguage + ".xml");
            this.languageDoc.Load(languageFile);
            this.LoadEditorStyles();
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
            this.applyButton.Enabled = false;
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
        /// Load the editor style items
        /// </summary>
        private void LoadEditorStyles()
        {
            this.isLoadingEditor = true;
            this.caretForeTextBox.Text = "";
            this.caretlineBackTextBox.Text = "";
            this.selectionBackTextBox.Text = "";
            this.selectionForeTextBox.Text = "";
            this.editorStyleNode = this.languageDoc.SelectSingleNode(editorStylePath) as XmlElement;
            if (this.editorStyleNode.Attributes["caret-fore"] != null)
            {
                this.caretForeTextBox.Text = this.editorStyleNode.Attributes["caret-fore"].Value;
            }
            if (this.editorStyleNode.Attributes["caretline-back"] != null)
            {
                this.caretlineBackTextBox.Text = this.editorStyleNode.Attributes["caretline-back"].Value;
            }
            if (this.editorStyleNode.Attributes["selection-back"] != null)
            {
                this.selectionBackTextBox.Text = this.editorStyleNode.Attributes["selection-back"].Value;
            }
            if (this.editorStyleNode.Attributes["selection-fore"] != null)
            {
                this.selectionForeTextBox.Text = this.editorStyleNode.Attributes["selection-fore"].Value;
            }
            this.isLoadingEditor = false;
            this.isEditorSaved = true;
        }

        /// <summary>
        /// Saves the editor style items
        /// </summary>
        private void SaveEditorStyles()
        {
            if (this.caretForeTextBox.Text != "") this.editorStyleNode.SetAttribute("caret-fore", this.caretForeTextBox.Text);
            else this.editorStyleNode.RemoveAttribute("caret-fore");
            if (this.caretlineBackTextBox.Text != "") this.editorStyleNode.SetAttribute("caretline-back", this.caretlineBackTextBox.Text);
            else this.editorStyleNode.RemoveAttribute("caretline-back");
            if (this.selectionForeTextBox.Text != "") this.editorStyleNode.SetAttribute("selection-fore", this.selectionForeTextBox.Text);
            else this.editorStyleNode.RemoveAttribute("selection-fore");
            if (this.selectionBackTextBox.Text != "") this.editorStyleNode.SetAttribute("selection-back", this.selectionBackTextBox.Text);
            else this.editorStyleNode.RemoveAttribute("selection-back");
            this.isEditorSaved = true;
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
        private void ItemForegroundButtonClick(Object sender, EventArgs e)
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
        private void ItemBackgroundButtonClick(Object sender, EventArgs e)
        {
            this.colorDialog.Color = ColorTranslator.FromHtml(this.backgroundTextBox.Text);
            if (this.colorDialog.ShowDialog() == DialogResult.OK)
            {
                this.backgroundTextBox.Text = "0x" + this.colorDialog.Color.ToArgb().ToString("X8").Substring(2, 6);
            }
        }

        /// <summary>
        /// When color has been selected, update controls
        /// </summary>
        private void SelectionForeButtonClick(Object sender, EventArgs e)
        {
            this.colorDialog.Color = ColorTranslator.FromHtml(this.selectionForeTextBox.Text);
            if (this.colorDialog.ShowDialog() == DialogResult.OK)
            {
                this.selectionForeTextBox.Text = "0x" + this.colorDialog.Color.ToArgb().ToString("X8").Substring(2, 6);
            }
        }

        /// <summary>
        /// When color has been selected, update controls
        /// </summary>
        private void SelectionBackButtonClick(Object sender, EventArgs e)
        {
            this.colorDialog.Color = ColorTranslator.FromHtml(this.selectionBackTextBox.Text);
            if (this.colorDialog.ShowDialog() == DialogResult.OK)
            {
                this.selectionBackTextBox.Text = "0x" + this.colorDialog.Color.ToArgb().ToString("X8").Substring(2, 6);
            }
        }

        /// <summary>
        /// When color has been selected, update controls
        /// </summary>
        private void CaretlineBackButtonClick(Object sender, EventArgs e)
        {
            this.colorDialog.Color = ColorTranslator.FromHtml(this.caretlineBackTextBox.Text);
            if (this.colorDialog.ShowDialog() == DialogResult.OK)
            {
                this.caretlineBackTextBox.Text = "0x" + this.colorDialog.Color.ToArgb().ToString("X8").Substring(2, 6);
            }
        }

        /// <summary>
        /// When color has been selected, update controls
        /// </summary>
        private void CaretForeButtonClick(Object sender, EventArgs e)
        {
            this.colorDialog.Color = ColorTranslator.FromHtml(this.caretForeTextBox.Text);
            if (this.colorDialog.ShowDialog() == DialogResult.OK)
            {
                this.caretForeTextBox.Text = "0x" + this.colorDialog.Color.ToArgb().ToString("X8").Substring(2, 6);
            }
        }

        /// <summary>
        /// When style item has been changed, update controls
        /// </summary>
        private void LanguageItemChanged(Object sender, EventArgs e)
        {
            if (!this.isLoadingItem)
            {
                this.isItemSaved = false;
                this.isLanguageSaved = false;
                this.applyButton.Enabled = true;
                this.UpdateSampleText();
            }
        }

        /// <summary>
        /// When editor item has been changed, update controls
        /// </summary>
        private void EditorItemChanged(Object sender, EventArgs e)
        {
            if (!this.isLoadingEditor)
            {
                this.isLanguageSaved = false;
                this.applyButton.Enabled = true;
                this.isEditorSaved = false;
            }
        }

        /// <summary>
        /// Saves the current modified language
        /// </summary>
        private void SaveCurrentLanguage()
        {
            if (!this.isItemSaved) this.SaveCurrentItem();
            if (!this.isEditorSaved) this.SaveEditorStyles();
            XmlTextWriter xmlWriter = new XmlTextWriter(this.languageFile, Encoding.UTF8);
            xmlWriter.Formatting = Formatting.Indented;
            xmlWriter.IndentChar = '\t';
            xmlWriter.Indentation = 1;
            this.languageDoc.Save(xmlWriter);
            this.applyButton.Enabled = false;
            this.isLanguageSaved = true;
            this.isEditorSaved = true;
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
        /// Opens the revert settings dialog
        /// </summary>
        private void RevertLanguagesClick(Object sender, EventArgs e)
        {
            String caption = TextHelper.GetString("Title.ConfirmDialog");
            String message = TextHelper.GetString("Info.RevertSettingsFiles");
            String appSettingDir = Path.Combine(PathHelper.AppDir, "Settings");
            String appLanguageDir = Path.Combine(appSettingDir, "Languages");
            DialogResult result = MessageBox.Show(message, caption, MessageBoxButtons.YesNoCancel, MessageBoxIcon.Information);
            if (result == DialogResult.Yes)
            {
                this.Enabled = false;
                FolderHelper.CopyFolder(appLanguageDir, this.LangDir);
                this.LoadLanguage(this.languageDropDown.Text, true);
                if (this.itemListView.SelectedIndices.Count > 0)
                {
                    String language = this.itemListView.SelectedItems[0].Text;
                    this.LoadLanguageItem(language);
                }
                this.Enabled = true;
            }
            else if (result == DialogResult.No)
            {
                this.Enabled = false;
                String[] userFiles = Directory.GetFiles(this.LangDir);
                foreach (String userFile in userFiles)
                {
                    String appFile = Path.Combine(appLanguageDir, Path.GetFileName(userFile));
                    if (File.Exists(appFile))
                    {
                        try
                        {
                            String appFileContents = FileHelper.ReadFile(appFile);
                            String userFileContents = FileHelper.ReadFile(userFile);
                            Int32 appFileColoringStart = appFileContents.IndexOf(coloringStart);
                            Int32 appFileColoringEnd = appFileContents.IndexOf(coloringEnd);
                            Int32 userFileColoringStart = userFileContents.IndexOf(coloringStart);
                            Int32 userFileColoringEnd = userFileContents.IndexOf(coloringEnd);
                            String replaceTarget = appFileContents.Substring(appFileColoringStart, appFileColoringEnd - appFileColoringStart);
                            String replaceContent = userFileContents.Substring(userFileColoringStart, userFileColoringEnd - userFileColoringStart);
                            String finalContent = appFileContents.Replace(replaceTarget, replaceContent);
                            FileHelper.WriteFile(userFile, finalContent, Encoding.UTF8);
                        }
                        catch (Exception ex)
                        {
                            this.Enabled = true;
                            String desc = TextHelper.GetString("Info.ColoringTagsMissing");
                            ErrorManager.ShowError(desc, ex);
                        }
                    }
                }
                this.LoadLanguage(this.languageDropDown.Text, true);
                if (this.itemListView.SelectedIndices.Count > 0)
                {
                    String language = this.itemListView.SelectedItems[0].Text;
                    this.LoadLanguageItem(language);
                }
                this.Enabled = true;
            }
            Globals.MainForm.RefreshSciConfig();
        }

        /// <summary>
        /// Opens the export settings dialog
        /// </summary>
        private void ExportLanguagesClick(Object sender, EventArgs e)
        {
            if (this.saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                String xmlFile = "";
                String[] langFiles = Directory.GetFiles(this.LangDir);
                ZipFile zipFile = ZipFile.Create(this.saveFileDialog.FileName);
                zipFile.BeginUpdate();
                foreach (String langFile in langFiles)
                {
                    xmlFile = Path.GetFileName(langFile);
                    zipFile.Add(langFile, "$(BaseDir)\\Settings\\Languages\\" + xmlFile);
                }
                zipFile.CommitUpdate();
                zipFile.Close();
            }
        }

        /// <summary>
        /// Saves the current language
        /// </summary>
        private void SaveButtonClick(Object sender, EventArgs e)
        {
            this.SaveCurrentLanguage();
            Globals.MainForm.RefreshSciConfig();
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
