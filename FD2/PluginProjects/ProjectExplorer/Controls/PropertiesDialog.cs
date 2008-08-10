using System;
using System.IO;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using ProjectExplorer.ProjectFormat;
using ProjectExplorer.Helpers;
using PluginCore;

namespace ProjectExplorer.Controls
{
	public class PropertiesDialog : Form
	{
		#region Form Designer

		private System.Windows.Forms.Button btnOK;
		private System.Windows.Forms.Button btnCancel;
		private System.Windows.Forms.Button btnApply;
		private System.Windows.Forms.TabControl tabControl;
		private System.Windows.Forms.TabPage movieTab;
		private System.Windows.Forms.TabPage compilerTab;
		private System.Windows.Forms.Label exportforLabel;
		private System.Windows.Forms.TextBox colorTextBox;
		private System.Windows.Forms.TextBox outputSwfBox;
		private System.Windows.Forms.Label exportinLabel;
		private System.Windows.Forms.Label pxLabel;
		private System.Windows.Forms.Label fpsLabel;
		private System.Windows.Forms.Label bgcolorLabel;
		private System.Windows.Forms.Label colorLabel;
		private System.Windows.Forms.TextBox fpsTextBox;
		private System.Windows.Forms.Label framerateLabel;
		private System.Windows.Forms.Label dimensionsLabel;
		private System.Windows.Forms.Label xLabel;
		private System.Windows.Forms.TextBox heightTextBox;
		private System.Windows.Forms.TextBox widthTextBox;
		private System.Windows.Forms.ComboBox versionCombo;
		private System.Windows.Forms.ColorDialog colorDialog;
		private System.Windows.Forms.Button outputBrowseButton;
		private System.Windows.Forms.PropertyGrid propertyGrid;
		private System.Windows.Forms.GroupBox groupBox2;
		private System.Windows.Forms.GroupBox groupBox1;
		private TabPage classpathsTab;
		private ClasspathControl classpathControl;
		private Label label2;
		private Label label3;
		private Button btnGlobalClasspaths;
		private GroupBox groupBox3;
		private System.Windows.Forms.TabPage buildTab;
		private System.Windows.Forms.GroupBox groupBox4;
		private System.Windows.Forms.TextBox preBuildBox;
		private System.Windows.Forms.Button preBuilderButton;
		private System.Windows.Forms.GroupBox groupBox5;
		private System.Windows.Forms.Button postBuilderButton;
		private System.Windows.Forms.TextBox postBuildBox;
		private System.Windows.Forms.ToolTip agressiveTip;
		private System.Windows.Forms.CheckBox alwaysExecuteCheckBox;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.ComboBox testMovieCombo;
		private System.Windows.Forms.TabPage injectionTab;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.CheckBox injectionCheckBox;
		private System.Windows.Forms.Button inputBrowseButton;
		private System.Windows.Forms.TextBox inputSwfBox;
		private System.Windows.Forms.Label label7;

		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			this.btnOK = new System.Windows.Forms.Button();
			this.btnCancel = new System.Windows.Forms.Button();
			this.btnApply = new System.Windows.Forms.Button();
			this.tabControl = new System.Windows.Forms.TabControl();
			this.movieTab = new System.Windows.Forms.TabPage();
			this.groupBox2 = new System.Windows.Forms.GroupBox();
			this.versionCombo = new System.Windows.Forms.ComboBox();
			this.widthTextBox = new System.Windows.Forms.TextBox();
			this.outputBrowseButton = new System.Windows.Forms.Button();
			this.heightTextBox = new System.Windows.Forms.TextBox();
			this.xLabel = new System.Windows.Forms.Label();
			this.exportforLabel = new System.Windows.Forms.Label();
			this.dimensionsLabel = new System.Windows.Forms.Label();
			this.colorTextBox = new System.Windows.Forms.TextBox();
			this.framerateLabel = new System.Windows.Forms.Label();
			this.outputSwfBox = new System.Windows.Forms.TextBox();
			this.fpsTextBox = new System.Windows.Forms.TextBox();
			this.exportinLabel = new System.Windows.Forms.Label();
			this.colorLabel = new System.Windows.Forms.Label();
			this.pxLabel = new System.Windows.Forms.Label();
			this.bgcolorLabel = new System.Windows.Forms.Label();
			this.fpsLabel = new System.Windows.Forms.Label();
			this.groupBox1 = new System.Windows.Forms.GroupBox();
			this.testMovieCombo = new System.Windows.Forms.ComboBox();
			this.label1 = new System.Windows.Forms.Label();
			this.compilerTab = new System.Windows.Forms.TabPage();
			this.propertyGrid = new System.Windows.Forms.PropertyGrid();
			this.buildTab = new System.Windows.Forms.TabPage();
			this.groupBox5 = new System.Windows.Forms.GroupBox();
			this.alwaysExecuteCheckBox = new System.Windows.Forms.CheckBox();
			this.postBuilderButton = new System.Windows.Forms.Button();
			this.postBuildBox = new System.Windows.Forms.TextBox();
			this.groupBox4 = new System.Windows.Forms.GroupBox();
			this.preBuilderButton = new System.Windows.Forms.Button();
			this.preBuildBox = new System.Windows.Forms.TextBox();
			this.classpathsTab = new System.Windows.Forms.TabPage();
			this.groupBox3 = new System.Windows.Forms.GroupBox();
			this.classpathControl = new ProjectExplorer.Controls.ClasspathControl();
			this.label2 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.btnGlobalClasspaths = new System.Windows.Forms.Button();
			this.injectionTab = new System.Windows.Forms.TabPage();
			this.inputBrowseButton = new System.Windows.Forms.Button();
			this.inputSwfBox = new System.Windows.Forms.TextBox();
			this.label7 = new System.Windows.Forms.Label();
			this.injectionCheckBox = new System.Windows.Forms.CheckBox();
			this.label6 = new System.Windows.Forms.Label();
			this.label5 = new System.Windows.Forms.Label();
			this.label4 = new System.Windows.Forms.Label();
			this.colorDialog = new System.Windows.Forms.ColorDialog();
			this.agressiveTip = new System.Windows.Forms.ToolTip(this.components);
			this.tabControl.SuspendLayout();
			this.movieTab.SuspendLayout();
			this.groupBox2.SuspendLayout();
			this.groupBox1.SuspendLayout();
			this.compilerTab.SuspendLayout();
			this.buildTab.SuspendLayout();
			this.groupBox5.SuspendLayout();
			this.groupBox4.SuspendLayout();
			this.classpathsTab.SuspendLayout();
			this.groupBox3.SuspendLayout();
			this.injectionTab.SuspendLayout();
			this.SuspendLayout();
			// 
			// btnOK
			// 
			this.btnOK.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.btnOK.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnOK.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.btnOK.Location = new System.Drawing.Point(117, 316);
			this.btnOK.Name = "btnOK";
			this.btnOK.TabIndex = 1;
			this.btnOK.Text = "&OK";
			this.btnOK.Click += new System.EventHandler(this.btnOK_Click);
			// 
			// btnCancel
			// 
			this.btnCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.btnCancel.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnCancel.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.btnCancel.Location = new System.Drawing.Point(198, 316);
			this.btnCancel.Name = "btnCancel";
			this.btnCancel.TabIndex = 2;
			this.btnCancel.Text = "&Cancel";
			this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
			// 
			// btnApply
			// 
			this.btnApply.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.btnApply.Enabled = false;
			this.btnApply.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnApply.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.btnApply.Location = new System.Drawing.Point(279, 316);
			this.btnApply.Name = "btnApply";
			this.btnApply.TabIndex = 3;
			this.btnApply.Text = "&Apply";
			this.btnApply.Click += new System.EventHandler(this.btnApply_Click);
			// 
			// tabControl
			// 
			this.tabControl.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tabControl.Controls.Add(this.movieTab);
			this.tabControl.Controls.Add(this.classpathsTab);
			this.tabControl.Controls.Add(this.buildTab);
			this.tabControl.Controls.Add(this.compilerTab);
			this.tabControl.Controls.Add(this.injectionTab);
			this.tabControl.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.tabControl.Location = new System.Drawing.Point(12, 12);
			this.tabControl.Name = "tabControl";
			this.tabControl.SelectedIndex = 0;
			this.tabControl.Size = new System.Drawing.Size(342, 298);
			this.tabControl.TabIndex = 0;
			// 
			// movieTab
			// 
			this.movieTab.Controls.Add(this.groupBox2);
			this.movieTab.Controls.Add(this.groupBox1);
			this.movieTab.Location = new System.Drawing.Point(4, 22);
			this.movieTab.Name = "movieTab";
			this.movieTab.Size = new System.Drawing.Size(334, 272);
			this.movieTab.TabIndex = 0;
			this.movieTab.Text = "Movie";
			// 
			// groupBox2
			// 
			this.groupBox2.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.groupBox2.Controls.Add(this.versionCombo);
			this.groupBox2.Controls.Add(this.widthTextBox);
			this.groupBox2.Controls.Add(this.outputBrowseButton);
			this.groupBox2.Controls.Add(this.heightTextBox);
			this.groupBox2.Controls.Add(this.xLabel);
			this.groupBox2.Controls.Add(this.exportforLabel);
			this.groupBox2.Controls.Add(this.dimensionsLabel);
			this.groupBox2.Controls.Add(this.colorTextBox);
			this.groupBox2.Controls.Add(this.framerateLabel);
			this.groupBox2.Controls.Add(this.outputSwfBox);
			this.groupBox2.Controls.Add(this.fpsTextBox);
			this.groupBox2.Controls.Add(this.exportinLabel);
			this.groupBox2.Controls.Add(this.colorLabel);
			this.groupBox2.Controls.Add(this.pxLabel);
			this.groupBox2.Controls.Add(this.bgcolorLabel);
			this.groupBox2.Controls.Add(this.fpsLabel);
			this.groupBox2.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.groupBox2.Location = new System.Drawing.Point(7, 6);
			this.groupBox2.Name = "groupBox2";
			this.groupBox2.Size = new System.Drawing.Size(321, 200);
			this.groupBox2.TabIndex = 0;
			this.groupBox2.TabStop = false;
			// 
			// versionCombo
			// 
			this.versionCombo.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.versionCombo.Items.AddRange(new object[] {
															  "Flash Player 6",
															  "Flash Player 7",
															  "Flash Player 8"});
			this.versionCombo.Location = new System.Drawing.Point(107, 126);
			this.versionCombo.Name = "versionCombo";
			this.versionCombo.TabIndex = 11;
			this.versionCombo.SelectedIndexChanged += new System.EventHandler(this.versionCombo_SelectedIndexChanged);
			// 
			// widthTextBox
			// 
			this.widthTextBox.Location = new System.Drawing.Point(108, 47);
			this.widthTextBox.MaxLength = 4;
			this.widthTextBox.Name = "widthTextBox";
			this.widthTextBox.Size = new System.Drawing.Size(32, 21);
			this.widthTextBox.TabIndex = 4;
			this.widthTextBox.Text = "500";
			this.widthTextBox.TextChanged += new System.EventHandler(this.widthTextBox_TextChanged);
			// 
			// outputBrowseButton
			// 
			this.outputBrowseButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.outputBrowseButton.Location = new System.Drawing.Point(234, 18);
			this.outputBrowseButton.Name = "outputBrowseButton";
			this.outputBrowseButton.TabIndex = 2;
			this.outputBrowseButton.Text = "&Browse...";
			this.outputBrowseButton.Click += new System.EventHandler(this.outputBrowseButton_Click);
			// 
			// heightTextBox
			// 
			this.heightTextBox.Location = new System.Drawing.Point(162, 47);
			this.heightTextBox.MaxLength = 4;
			this.heightTextBox.Name = "heightTextBox";
			this.heightTextBox.Size = new System.Drawing.Size(32, 21);
			this.heightTextBox.TabIndex = 5;
			this.heightTextBox.Text = "300";
			this.heightTextBox.TextChanged += new System.EventHandler(this.heightTextBox_TextChanged);
			// 
			// xLabel
			// 
			this.xLabel.Location = new System.Drawing.Point(144, 48);
			this.xLabel.Name = "xLabel";
			this.xLabel.Size = new System.Drawing.Size(13, 17);
			this.xLabel.TabIndex = 21;
			this.xLabel.Text = "x";
			this.xLabel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
			// 
			// exportforLabel
			// 
			this.exportforLabel.Location = new System.Drawing.Point(15, 129);
			this.exportforLabel.Name = "exportforLabel";
			this.exportforLabel.Size = new System.Drawing.Size(90, 20);
			this.exportforLabel.TabIndex = 10;
			this.exportforLabel.Text = "&Target version:";
			this.exportforLabel.TextAlign = System.Drawing.ContentAlignment.TopRight;
			// 
			// dimensionsLabel
			// 
			this.dimensionsLabel.Location = new System.Drawing.Point(8, 50);
			this.dimensionsLabel.Name = "dimensionsLabel";
			this.dimensionsLabel.Size = new System.Drawing.Size(96, 13);
			this.dimensionsLabel.TabIndex = 3;
			this.dimensionsLabel.Text = "&Dimensions:";
			this.dimensionsLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
			// 
			// colorTextBox
			// 
			this.colorTextBox.Enabled = false;
			this.colorTextBox.Location = new System.Drawing.Point(139, 72);
			this.colorTextBox.MaxLength = 7;
			this.colorTextBox.Name = "colorTextBox";
			this.colorTextBox.Size = new System.Drawing.Size(55, 21);
			this.colorTextBox.TabIndex = 37;
			this.colorTextBox.Text = "#FFFFFF";
			// 
			// framerateLabel
			// 
			this.framerateLabel.Location = new System.Drawing.Point(16, 99);
			this.framerateLabel.Name = "framerateLabel";
			this.framerateLabel.Size = new System.Drawing.Size(88, 17);
			this.framerateLabel.TabIndex = 8;
			this.framerateLabel.Text = "&Frame rate:";
			this.framerateLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
			// 
			// outputSwfBox
			// 
			this.outputSwfBox.Location = new System.Drawing.Point(107, 20);
			this.outputSwfBox.Name = "outputSwfBox";
			this.outputSwfBox.Size = new System.Drawing.Size(121, 21);
			this.outputSwfBox.TabIndex = 1;
			this.outputSwfBox.Text = "";
			this.outputSwfBox.TextChanged += new System.EventHandler(this.outputSwfBox_TextChanged);
			// 
			// fpsTextBox
			// 
			this.fpsTextBox.Location = new System.Drawing.Point(107, 97);
			this.fpsTextBox.MaxLength = 3;
			this.fpsTextBox.Name = "fpsTextBox";
			this.fpsTextBox.Size = new System.Drawing.Size(27, 21);
			this.fpsTextBox.TabIndex = 9;
			this.fpsTextBox.Text = "30";
			this.fpsTextBox.TextChanged += new System.EventHandler(this.fpsTextBox_TextChanged);
			// 
			// exportinLabel
			// 
			this.exportinLabel.Location = new System.Drawing.Point(8, 21);
			this.exportinLabel.Name = "exportinLabel";
			this.exportinLabel.Size = new System.Drawing.Size(96, 18);
			this.exportinLabel.TabIndex = 0;
			this.exportinLabel.Text = "&Output SWF File:";
			this.exportinLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
			// 
			// colorLabel
			// 
			this.colorLabel.BackColor = System.Drawing.Color.White;
			this.colorLabel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.colorLabel.Cursor = System.Windows.Forms.Cursors.Hand;
			this.colorLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.colorLabel.ForeColor = System.Drawing.SystemColors.ControlText;
			this.colorLabel.Location = new System.Drawing.Point(108, 74);
			this.colorLabel.Name = "colorLabel";
			this.colorLabel.Size = new System.Drawing.Size(17, 16);
			this.colorLabel.TabIndex = 7;
			this.colorLabel.Click += new System.EventHandler(this.colorLabel_Click);
			// 
			// pxLabel
			// 
			this.pxLabel.Location = new System.Drawing.Point(195, 50);
			this.pxLabel.Name = "pxLabel";
			this.pxLabel.Size = new System.Drawing.Size(19, 14);
			this.pxLabel.TabIndex = 30;
			this.pxLabel.Text = "px";
			// 
			// bgcolorLabel
			// 
			this.bgcolorLabel.Location = new System.Drawing.Point(6, 72);
			this.bgcolorLabel.Name = "bgcolorLabel";
			this.bgcolorLabel.Size = new System.Drawing.Size(99, 18);
			this.bgcolorLabel.TabIndex = 6;
			this.bgcolorLabel.Text = "Background &color:";
			this.bgcolorLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
			// 
			// fpsLabel
			// 
			this.fpsLabel.Location = new System.Drawing.Point(140, 100);
			this.fpsLabel.Name = "fpsLabel";
			this.fpsLabel.Size = new System.Drawing.Size(32, 17);
			this.fpsLabel.TabIndex = 28;
			this.fpsLabel.Text = "fps";
			// 
			// groupBox1
			// 
			this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.groupBox1.Controls.Add(this.testMovieCombo);
			this.groupBox1.Controls.Add(this.label1);
			this.groupBox1.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.groupBox1.Location = new System.Drawing.Point(6, 208);
			this.groupBox1.Name = "groupBox1";
			this.groupBox1.Size = new System.Drawing.Size(322, 56);
			this.groupBox1.TabIndex = 1;
			this.groupBox1.TabStop = false;
			this.groupBox1.Text = "Test &Movie";
			// 
			// testMovieCombo
			// 
			this.testMovieCombo.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.testMovieCombo.Items.AddRange(new object[] {
																"New Tab",
																"New Window",
																"External Player"});
			this.testMovieCombo.Location = new System.Drawing.Point(107, 20);
			this.testMovieCombo.Name = "testMovieCombo";
			this.testMovieCombo.TabIndex = 12;
			this.testMovieCombo.SelectedIndexChanged += new System.EventHandler(this.testMovieCombo_SelectedIndexChanged);
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(24, 24);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(80, 16);
			this.label1.TabIndex = 0;
			this.label1.Text = "Open SWF in:";
			this.label1.TextAlign = System.Drawing.ContentAlignment.TopRight;
			// 
			// compilerTab
			// 
			this.compilerTab.Controls.Add(this.propertyGrid);
			this.compilerTab.Location = new System.Drawing.Point(4, 22);
			this.compilerTab.Name = "compilerTab";
			this.compilerTab.Size = new System.Drawing.Size(334, 272);
			this.compilerTab.TabIndex = 1;
			this.compilerTab.Text = "Compiler Options";
			// 
			// propertyGrid
			// 
			this.propertyGrid.CommandsVisibleIfAvailable = true;
			this.propertyGrid.Dock = System.Windows.Forms.DockStyle.Fill;
			this.propertyGrid.HelpVisible = false;
			this.propertyGrid.LargeButtons = false;
			this.propertyGrid.LineColor = System.Drawing.SystemColors.ScrollBar;
			this.propertyGrid.Location = new System.Drawing.Point(0, 0);
			this.propertyGrid.Name = "propertyGrid";
			this.propertyGrid.Size = new System.Drawing.Size(334, 272);
			this.propertyGrid.TabIndex = 0;
			this.propertyGrid.Text = "PropertyGrid";
			this.propertyGrid.ToolbarVisible = false;
			this.propertyGrid.ViewBackColor = System.Drawing.SystemColors.Window;
			this.propertyGrid.ViewForeColor = System.Drawing.SystemColors.WindowText;
			this.propertyGrid.PropertyValueChanged += new System.Windows.Forms.PropertyValueChangedEventHandler(this.propertyGrid_PropertyValueChanged);
			// 
			// buildTab
			// 
			this.buildTab.Controls.Add(this.groupBox5);
			this.buildTab.Controls.Add(this.groupBox4);
			this.buildTab.Location = new System.Drawing.Point(4, 22);
			this.buildTab.Name = "buildTab";
			this.buildTab.Size = new System.Drawing.Size(334, 272);
			this.buildTab.TabIndex = 4;
			this.buildTab.Text = "Build";
			// 
			// groupBox5
			// 
			this.groupBox5.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.groupBox5.Controls.Add(this.alwaysExecuteCheckBox);
			this.groupBox5.Controls.Add(this.postBuilderButton);
			this.groupBox5.Controls.Add(this.postBuildBox);
			this.groupBox5.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.groupBox5.Location = new System.Drawing.Point(15, 144);
			this.groupBox5.Name = "groupBox5";
			this.groupBox5.Size = new System.Drawing.Size(304, 114);
			this.groupBox5.TabIndex = 1;
			this.groupBox5.TabStop = false;
			this.groupBox5.Text = "Post-Build Command Line";
			// 
			// alwaysExecuteCheckBox
			// 
			this.alwaysExecuteCheckBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.alwaysExecuteCheckBox.Location = new System.Drawing.Point(12, 80);
			this.alwaysExecuteCheckBox.Name = "alwaysExecuteCheckBox";
			this.alwaysExecuteCheckBox.Size = new System.Drawing.Size(144, 24);
			this.alwaysExecuteCheckBox.TabIndex = 2;
			this.alwaysExecuteCheckBox.Text = "Always Execute";
			this.agressiveTip.SetToolTip(this.alwaysExecuteCheckBox, "Execute the Post-Build Command Line even after a failed build");
			this.alwaysExecuteCheckBox.CheckedChanged += new System.EventHandler(this.alwaysExecuteCheckBox_CheckedChanged);
			// 
			// postBuilderButton
			// 
			this.postBuilderButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.postBuilderButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.postBuilderButton.Location = new System.Drawing.Point(216, 80);
			this.postBuilderButton.Name = "postBuilderButton";
			this.postBuilderButton.TabIndex = 1;
			this.postBuilderButton.Text = "Builder...";
			this.postBuilderButton.Click += new System.EventHandler(this.postBuilderButton_Click);
			// 
			// postBuildBox
			// 
			this.postBuildBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.postBuildBox.Location = new System.Drawing.Point(12, 31);
			this.postBuildBox.Multiline = true;
			this.postBuildBox.Name = "postBuildBox";
			this.postBuildBox.Size = new System.Drawing.Size(278, 41);
			this.postBuildBox.TabIndex = 0;
			this.postBuildBox.Text = "";
			this.postBuildBox.TextChanged += new System.EventHandler(this.postBuildBox_TextChanged);
			// 
			// groupBox4
			// 
			this.groupBox4.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.groupBox4.Controls.Add(this.preBuilderButton);
			this.groupBox4.Controls.Add(this.preBuildBox);
			this.groupBox4.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.groupBox4.Location = new System.Drawing.Point(14, 18);
			this.groupBox4.Name = "groupBox4";
			this.groupBox4.Size = new System.Drawing.Size(304, 114);
			this.groupBox4.TabIndex = 0;
			this.groupBox4.TabStop = false;
			this.groupBox4.Text = "Pre-Build Command Line";
			// 
			// preBuilderButton
			// 
			this.preBuilderButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.preBuilderButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.preBuilderButton.Location = new System.Drawing.Point(216, 80);
			this.preBuilderButton.Name = "preBuilderButton";
			this.preBuilderButton.TabIndex = 1;
			this.preBuilderButton.Text = "Builder...";
			this.preBuilderButton.Click += new System.EventHandler(this.preBuilderButton_Click);
			// 
			// preBuildBox
			// 
			this.preBuildBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.preBuildBox.Location = new System.Drawing.Point(12, 30);
			this.preBuildBox.Multiline = true;
			this.preBuildBox.Name = "preBuildBox";
			this.preBuildBox.Size = new System.Drawing.Size(278, 42);
			this.preBuildBox.TabIndex = 0;
			this.preBuildBox.Text = "";
			this.preBuildBox.TextChanged += new System.EventHandler(this.preBuildBox_TextChanged);
			// 
			// classpathsTab
			// 
			this.classpathsTab.Controls.Add(this.groupBox3);
			this.classpathsTab.Controls.Add(this.label3);
			this.classpathsTab.Controls.Add(this.btnGlobalClasspaths);
			this.classpathsTab.Location = new System.Drawing.Point(4, 22);
			this.classpathsTab.Name = "classpathsTab";
			this.classpathsTab.Size = new System.Drawing.Size(334, 272);
			this.classpathsTab.TabIndex = 3;
			this.classpathsTab.Text = "Classpaths";
			// 
			// groupBox3
			// 
			this.groupBox3.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.groupBox3.Controls.Add(this.classpathControl);
			this.groupBox3.Controls.Add(this.label2);
			this.groupBox3.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.groupBox3.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.groupBox3.Location = new System.Drawing.Point(14, 18);
			this.groupBox3.Name = "groupBox3";
			this.groupBox3.Size = new System.Drawing.Size(304, 164);
			this.groupBox3.TabIndex = 0;
			this.groupBox3.TabStop = false;
			this.groupBox3.Text = "&Project Classpaths";
			// 
			// classpathControl
			// 
			this.classpathControl.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.classpathControl.Classpaths = new string[] {
																""};
			this.classpathControl.ClasspathString = "";
			this.classpathControl.Location = new System.Drawing.Point(16, 31);
			this.classpathControl.Name = "classpathControl";
			this.classpathControl.Project = null;
			this.classpathControl.Size = new System.Drawing.Size(272, 93);
			this.classpathControl.TabIndex = 0;
			// 
			// label2
			// 
			this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.label2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.label2.ForeColor = System.Drawing.Color.FromArgb(((System.Byte)(64)), ((System.Byte)(64)), ((System.Byte)(64)));
			this.label2.Location = new System.Drawing.Point(8, 136);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(288, 13);
			this.label2.TabIndex = 2;
			this.label2.Text = "(Project classpaths are relative to the project location)";
			this.label2.TextAlign = System.Drawing.ContentAlignment.TopCenter;
			// 
			// label3
			// 
			this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.label3.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.label3.ForeColor = System.Drawing.Color.FromArgb(((System.Byte)(64)), ((System.Byte)(64)), ((System.Byte)(64)));
			this.label3.Location = new System.Drawing.Point(28, 201);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(277, 31);
			this.label3.TabIndex = 1;
			this.label3.Text = "Global classpaths are specific to your machine\r\nand are not stored in the project" +
				" file.";
			// 
			// btnGlobalClasspaths
			// 
			this.btnGlobalClasspaths.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.btnGlobalClasspaths.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnGlobalClasspaths.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.btnGlobalClasspaths.Location = new System.Drawing.Point(29, 232);
			this.btnGlobalClasspaths.Name = "btnGlobalClasspaths";
			this.btnGlobalClasspaths.Size = new System.Drawing.Size(146, 23);
			this.btnGlobalClasspaths.TabIndex = 2;
			this.btnGlobalClasspaths.Text = "&Edit Global Classpaths...";
			this.btnGlobalClasspaths.Click += new System.EventHandler(this.btnGlobalClasspaths_Click);
			// 
			// injectionTab
			// 
			this.injectionTab.Controls.Add(this.inputBrowseButton);
			this.injectionTab.Controls.Add(this.inputSwfBox);
			this.injectionTab.Controls.Add(this.label7);
			this.injectionTab.Controls.Add(this.injectionCheckBox);
			this.injectionTab.Controls.Add(this.label6);
			this.injectionTab.Controls.Add(this.label5);
			this.injectionTab.Controls.Add(this.label4);
			this.injectionTab.Location = new System.Drawing.Point(4, 22);
			this.injectionTab.Name = "injectionTab";
			this.injectionTab.Size = new System.Drawing.Size(334, 272);
			this.injectionTab.TabIndex = 5;
			this.injectionTab.Text = "Injection";
			// 
			// inputBrowseButton
			// 
			this.inputBrowseButton.Enabled = false;
			this.inputBrowseButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.inputBrowseButton.Location = new System.Drawing.Point(240, 208);
			this.inputBrowseButton.Name = "inputBrowseButton";
			this.inputBrowseButton.TabIndex = 7;
			this.inputBrowseButton.Text = "&Browse...";
			this.inputBrowseButton.Click += new System.EventHandler(this.inputBrowseButton_Click);
			// 
			// inputSwfBox
			// 
			this.inputSwfBox.Enabled = false;
			this.inputSwfBox.Location = new System.Drawing.Point(112, 208);
			this.inputSwfBox.Name = "inputSwfBox";
			this.inputSwfBox.Size = new System.Drawing.Size(121, 21);
			this.inputSwfBox.TabIndex = 6;
			this.inputSwfBox.Text = "";
			this.inputSwfBox.TextChanged += new System.EventHandler(this.inputSwfBox_TextChanged);
			// 
			// label7
			// 
			this.label7.Location = new System.Drawing.Point(16, 208);
			this.label7.Name = "label7";
			this.label7.Size = new System.Drawing.Size(96, 18);
			this.label7.TabIndex = 5;
			this.label7.Text = "&Input SWF File:";
			this.label7.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
			// 
			// injectionCheckBox
			// 
			this.injectionCheckBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.injectionCheckBox.Location = new System.Drawing.Point(16, 184);
			this.injectionCheckBox.Name = "injectionCheckBox";
			this.injectionCheckBox.Size = new System.Drawing.Size(168, 16);
			this.injectionCheckBox.TabIndex = 3;
			this.injectionCheckBox.Text = "Enable Code Injection";
			this.injectionCheckBox.CheckedChanged += new System.EventHandler(this.injectionCheckBox_CheckedChanged);
			// 
			// label6
			// 
			this.label6.Location = new System.Drawing.Point(8, 128);
			this.label6.Name = "label6";
			this.label6.Size = new System.Drawing.Size(312, 32);
			this.label6.TabIndex = 2;
			this.label6.Text = "Please note that with injection enabled, you will not be able to use many project" +
				" options, including asset embedding.";
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(8, 72);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(312, 48);
			this.label5.TabIndex = 1;
			this.label5.Text = "If you enable injection, your source will be compiled into an existing SWF file. " +
				" The input SWF will be copied first and the injected file will be your \"Output S" +
				"WF\" name.";
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(8, 16);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(312, 48);
			this.label4.TabIndex = 0;
			this.label4.Text = "Code Injection is a compilation method that is useful for maintaining a workflow " +
				"in conjunction with the Macromedia Flash IDE.";
			// 
			// agressiveTip
			// 
			this.agressiveTip.AutomaticDelay = 0;
			// 
			// PropertiesDialog
			// 
			this.AcceptButton = this.btnOK;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.CancelButton = this.btnCancel;
			this.ClientSize = new System.Drawing.Size(366, 351);
			this.ControlBox = false;
			this.Controls.Add(this.tabControl);
			this.Controls.Add(this.btnApply);
			this.Controls.Add(this.btnCancel);
			this.Controls.Add(this.btnOK);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Name = "PropertiesDialog";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = "Project Properties";
			this.tabControl.ResumeLayout(false);
			this.movieTab.ResumeLayout(false);
			this.groupBox2.ResumeLayout(false);
			this.groupBox1.ResumeLayout(false);
			this.compilerTab.ResumeLayout(false);
			this.buildTab.ResumeLayout(false);
			this.groupBox5.ResumeLayout(false);
			this.groupBox4.ResumeLayout(false);
			this.classpathsTab.ResumeLayout(false);
			this.groupBox3.ResumeLayout(false);
			this.injectionTab.ResumeLayout(false);
			this.ResumeLayout(false);

		}

		#endregion

		#endregion

		Project project;
		bool propertiesChanged;
		bool classpathsChanged;
		bool assetsChanged;

		public event EventHandler OpenGlobalClasspaths;

		public PropertiesDialog(Project project)
		{
			this.project = project;

			InitializeComponent();
			BuildDisplay();
		}

		public bool PropertiesChanged { get { return propertiesChanged; } }
		public bool ClasspathsChanged { get { return classpathsChanged; } }
		public bool AssetsChanged { get { return assetsChanged; } }

		private void BuildDisplay()
		{
			this.Text = project.Name + " Properties";
			this.propertyGrid.HelpVisible = true;

			MovieOptions options = project.MovieOptions;

			outputSwfBox.Text = project.OutputPath;
			widthTextBox.Text = options.Width.ToString();
			heightTextBox.Text = options.Height.ToString();
			
			// bugfix -- direct color assignment doesn't work (copies by ref?)
			colorLabel.BackColor = Color.FromArgb(255,options.BackgroundColor);

			colorTextBox.Text = options.Background;
			fpsTextBox.Text = options.Fps.ToString();
			versionCombo.SelectedIndex = options.Version - 6; // trickery!

			if (options.TestMovieBehavior == TestMovieBehavior.NewTab)
				testMovieCombo.SelectedIndex = 0;
			else if (options.TestMovieBehavior == TestMovieBehavior.NewWindow)
				testMovieCombo.SelectedIndex = 1;
			else
				testMovieCombo.SelectedIndex = 2;

			classpathControl.Changed += new EventHandler(classpathControl_Changed);
			classpathControl.Project = project;
			classpathControl.Classpaths = project.Classpaths.ToArray();

			preBuildBox.Text = project.PreBuildEvent;
			postBuildBox.Text = project.PostBuildEvent;
			alwaysExecuteCheckBox.Checked = project.AlwaysRunPostBuild;

			injectionCheckBox.Checked = project.UsesInjection;
			inputSwfBox.Text = project.InputPath;

			// clone the compiler options object because the PropertyGrid modifies its
			// object directly
			CompilerOptions optionsCopy = new CompilerOptions();
			CopyCompilerOptions(project.CompilerOptions, optionsCopy);
			propertyGrid.SelectedObject = optionsCopy;
			
			propertiesChanged = false;
			classpathsChanged = false;
			assetsChanged = false;
			btnApply.Enabled = false;
		}

		void classpathControl_Changed(object sender, EventArgs e)
		{
			classpathsChanged = true; // keep special track of this, it's a big deal
			Modified();
		}

		private void CopyCompilerOptions(CompilerOptions source, CompilerOptions dest)
		{
			dest.UseMX = source.UseMX;
			dest.Infer = source.Infer;
			dest.Strict = source.Strict;
			dest.TraceMode = source.TraceMode;
			dest.TraceFunction = source.TraceFunction;
			dest.UseMain = source.UseMain;
			dest.Verbose = source.Verbose;
			dest.WarnUnusedImports = source.WarnUnusedImports;
			dest.LibraryPrefix = source.LibraryPrefix;
			dest.IncludePackages = new string[source.IncludePackages.Length];
			dest.ExcludeFile = source.ExcludeFile;
			dest.GroupClasses = source.GroupClasses;
			dest.Frame = source.Frame;
			dest.Keep = source.Keep;
			Array.Copy(source.IncludePackages, dest.IncludePackages, source.IncludePackages.Length);
		}

		private void Modified()
		{
			btnApply.Enabled = true;
		}

		private bool Apply()
		{
			MovieOptions options = project.MovieOptions;

			try
			{
				project.OutputPath = outputSwfBox.Text;
				project.Classpaths.Clear();
				project.Classpaths.AddRange(classpathControl.Classpaths);
				options.Width = int.Parse(widthTextBox.Text);
				options.Height = int.Parse(heightTextBox.Text);
				options.BackgroundColor = Color.FromArgb(255, colorLabel.BackColor);
				options.Fps = int.Parse(fpsTextBox.Text);
				options.Version = versionCombo.SelectedIndex + 6;
				project.PreBuildEvent = preBuildBox.Text;
				project.PostBuildEvent = postBuildBox.Text;
				project.AlwaysRunPostBuild = alwaysExecuteCheckBox.Checked;

				if (testMovieCombo.SelectedIndex == 0)
					options.TestMovieBehavior = TestMovieBehavior.NewTab;
				else if (testMovieCombo.SelectedIndex == 1)
					options.TestMovieBehavior = TestMovieBehavior.NewWindow;
				else
					options.TestMovieBehavior = TestMovieBehavior.ExternalPlayer;

				if (injectionCheckBox.Checked && inputSwfBox.Text.Length < 1)
					throw new Exception("You must specify an input SWF file if you wish to use Code Injection.");
				else if (injectionCheckBox.Checked)
				{
					project.InputPath = inputSwfBox.Text;

					// unassign any existing assets - you've been warned already
					if (project.LibraryAssets.Count > 0)
					{
						project.LibraryAssets.Clear();
						assetsChanged = true;
					}
				}
				else
					project.InputPath = "";
			}
			catch (Exception exception)
			{
				ErrorHandler.ShowInfo("There was a problem with one of the values you entered: " + exception.Message);
				return false;
			}

			CompilerOptions optionsCopy = propertyGrid.SelectedObject as CompilerOptions;
			CopyCompilerOptions(optionsCopy, project.CompilerOptions);
			btnApply.Enabled = false;
			propertiesChanged = true;
			return true;
		}

		private void btnOK_Click(object sender, EventArgs e)
		{
			if (btnApply.Enabled)
				if (!Apply()) return;
			this.Close();
		}

		private void btnCancel_Click(object sender, EventArgs e)
		{
			this.Close();
		}

		private void btnApply_Click(object sender, EventArgs e)
		{
			Apply();
		}

		private void outputSwfBox_TextChanged(object sender, EventArgs e)
		{
			classpathsChanged = true;
			Modified();
		}
		private void widthTextBox_TextChanged(object sender, EventArgs e) { Modified(); }
		private void heightTextBox_TextChanged(object sender, EventArgs e) { Modified(); }
		private void colorTextBox_TextChanged(object sender, EventArgs e) { Modified(); }
		private void fpsTextBox_TextChanged(object sender, EventArgs e) { Modified(); }
		private void preBuildBox_TextChanged(object sender, System.EventArgs e) { Modified(); }
		private void postBuildBox_TextChanged(object sender, System.EventArgs e) { Modified(); }
		private void alwaysExecuteCheckBox_CheckedChanged(object sender, System.EventArgs e) { Modified(); }
		private void testMovieCombo_SelectedIndexChanged(object sender, System.EventArgs e) { Modified(); }
		private void inputSwfBox_TextChanged(object sender, System.EventArgs e)
		{
			classpathsChanged = true;
			Modified();
		}
		private void propertyGrid_PropertyValueChanged(object s, PropertyValueChangedEventArgs e)
		{ Modified(); }

		private void injectionCheckBox_CheckedChanged(object sender, System.EventArgs e)
		{
			if (injectionCheckBox.Checked && project.LibraryAssets.Count > 0)
			{
				DialogResult result = MessageBox.Show(this,"The library assets currently embedded in your project will be removed from the project (but not deleted).  Are you sure you want to proceed?","FlashDevelop",
					MessageBoxButtons.OKCancel);

				if (result == DialogResult.Cancel)
				{
					injectionCheckBox.Checked = false;
					return;
				}
			}

			Modified();
			bool inject = injectionCheckBox.Checked;
			inputSwfBox.Enabled = inject;
			inputBrowseButton.Enabled = inject;
			widthTextBox.Enabled = !inject;
			heightTextBox.Enabled = !inject;
			colorTextBox.Enabled = !inject;
			fpsTextBox.Enabled = !inject;
		}

		private void versionCombo_SelectedIndexChanged(object sender, EventArgs e)
		{
			Modified();
			classpathsChanged = true; // version 8 has an extra classpath
		}

		private void colorLabel_Click(object sender, EventArgs e)
		{
			if (this.colorDialog.ShowDialog() == DialogResult.OK)
			{
				this.colorLabel.BackColor = this.colorDialog.Color;
				this.colorTextBox.Text = this.ToHtml(this.colorLabel.BackColor);
				Modified();
			}
		}

		private string ToHtml(Color c)
		{
			return string.Format("#{0:X6}", (c.R << 16) + (c.G << 8) + c.B);
		}

		private void btnGlobalClasspaths_Click(object sender, EventArgs e)
		{
			if (OpenGlobalClasspaths != null)
				OpenGlobalClasspaths(this,new EventArgs());
		}

		private void outputBrowseButton_Click(object sender, EventArgs e)
		{
			SaveFileDialog dialog = new SaveFileDialog();
			dialog.Filter = "Flash Movies (*.swf)|*.swf";
			dialog.OverwritePrompt = false;
			dialog.InitialDirectory = project.Directory;

			// try pre-setting the current output path
			try
			{
				string path = project.GetAbsolutePath(outputSwfBox.Text);
				if (File.Exists(path)) dialog.FileName = path;
			}
			catch { }

			if (dialog.ShowDialog(this) == DialogResult.OK)
				outputSwfBox.Text = project.GetRelativePath(dialog.FileName);
		}

		private void inputBrowseButton_Click(object sender, System.EventArgs e)
		{
			OpenFileDialog dialog = new OpenFileDialog();
			dialog.Filter = "Flash Movies (*.swf)|*.swf";
			dialog.InitialDirectory = project.Directory;
			
			// try pre-setting the current input path
			try
			{
				string path = project.GetAbsolutePath(inputSwfBox.Text);
				if (File.Exists(path)) dialog.FileName = path;
			}
			catch { }

			if (dialog.ShowDialog(this) == DialogResult.OK)
				inputSwfBox.Text = project.GetRelativePath(dialog.FileName);		
		}

		private void preBuilderButton_Click(object sender, System.EventArgs e)
		{
			using (BuildEventDialog dialog = new BuildEventDialog(project))
			{
				dialog.CommandLine = preBuildBox.Text;
				if (dialog.ShowDialog(this) == DialogResult.OK)
					preBuildBox.Text = dialog.CommandLine;
			}
		}

		private void postBuilderButton_Click(object sender, System.EventArgs e)
		{
			using (BuildEventDialog dialog = new BuildEventDialog(project))
			{
				dialog.CommandLine = postBuildBox.Text;
				if (dialog.ShowDialog(this) == DialogResult.OK)
					postBuildBox.Text = dialog.CommandLine;
			}
		}
	}
}
