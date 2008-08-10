using System;
using System.Drawing;
using System.Diagnostics;
using System.Collections;
using System.ComponentModel;
using System.IO;
using System.Windows.Forms;
using System.Reflection;
using ProjectExplorer.ProjectFormat;
using PluginCore;

namespace ProjectExplorer.Controls
{
	public class NewProjectDialog : System.Windows.Forms.Form
	{
		string defaultProjectImage;

		#region Windows Form Designer

		private System.Windows.Forms.Button cancelButton;
		private System.Windows.Forms.Button okButton;
		private System.Windows.Forms.GroupBox groupBox1;
		private System.Windows.Forms.GroupBox groupBox2;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.ImageList imageList;
		private System.Windows.Forms.ColumnHeader columnHeader1;
		private System.Windows.Forms.PictureBox previewBox;
		private System.Windows.Forms.ListView projectListView;
		private System.Windows.Forms.Label descriptionLabel;
		private System.Windows.Forms.Button browseButton;
		private System.Windows.Forms.TextBox locationTextBox;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox nameTextBox;
		private System.Windows.Forms.CheckBox createDirectoryBox;
		private System.Windows.Forms.StatusBar statusBar;
		private System.ComponentModel.IContainer components;
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			System.Windows.Forms.ListViewItem listViewItem1 = new System.Windows.Forms.ListViewItem("Empty Project");
			System.Windows.Forms.ListViewItem listViewItem2 = new System.Windows.Forms.ListViewItem("Project With Preloader");
			System.Windows.Forms.ListViewItem listViewItem3 = new System.Windows.Forms.ListViewItem("Preloader Project");
			System.Windows.Forms.ListViewItem listViewItem4 = new System.Windows.Forms.ListViewItem("Macromedia V2 Components");
			System.Windows.Forms.ListViewItem listViewItem5 = new System.Windows.Forms.ListViewItem("ActionStep Components Project");
			System.Windows.Forms.ListViewItem listViewItem6 = new System.Windows.Forms.ListViewItem("AsWing Components Project");
			this.cancelButton = new System.Windows.Forms.Button();
			this.okButton = new System.Windows.Forms.Button();
			this.previewBox = new System.Windows.Forms.PictureBox();
			this.groupBox1 = new System.Windows.Forms.GroupBox();
			this.groupBox2 = new System.Windows.Forms.GroupBox();
			this.projectListView = new System.Windows.Forms.ListView();
			this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
			this.imageList = new System.Windows.Forms.ImageList(this.components);
			this.locationTextBox = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.descriptionLabel = new System.Windows.Forms.Label();
			this.browseButton = new System.Windows.Forms.Button();
			this.label2 = new System.Windows.Forms.Label();
			this.nameTextBox = new System.Windows.Forms.TextBox();
			this.createDirectoryBox = new System.Windows.Forms.CheckBox();
			this.statusBar = new System.Windows.Forms.StatusBar();
			this.groupBox1.SuspendLayout();
			this.groupBox2.SuspendLayout();
			this.SuspendLayout();
			// 
			// cancelButton
			// 
			this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.cancelButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.cancelButton.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.cancelButton.Location = new System.Drawing.Point(397, 296);
			this.cancelButton.Name = "cancelButton";
			this.cancelButton.TabIndex = 7;
			this.cancelButton.Text = "&Cancel";
			// 
			// okButton
			// 
			this.okButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.okButton.Enabled = false;
			this.okButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.okButton.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.okButton.Location = new System.Drawing.Point(312, 296);
			this.okButton.Name = "okButton";
			this.okButton.TabIndex = 6;
			this.okButton.Text = "&OK";
			this.okButton.Click += new System.EventHandler(this.okButton_Click);
			// 
			// previewBox
			// 
			this.previewBox.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			this.previewBox.Location = new System.Drawing.Point(8, 16);
			this.previewBox.Name = "previewBox";
			this.previewBox.Size = new System.Drawing.Size(192, 168);
			this.previewBox.TabIndex = 5;
			this.previewBox.TabStop = false;
			// 
			// groupBox1
			// 
			this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.groupBox1.Controls.Add(this.previewBox);
			this.groupBox1.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.groupBox1.Location = new System.Drawing.Point(264, 8);
			this.groupBox1.Name = "groupBox1";
			this.groupBox1.Size = new System.Drawing.Size(208, 192);
			this.groupBox1.TabIndex = 6;
			this.groupBox1.TabStop = false;
			// 
			// groupBox2
			// 
			this.groupBox2.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.groupBox2.Controls.Add(this.projectListView);
			this.groupBox2.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.groupBox2.Location = new System.Drawing.Point(8, 8);
			this.groupBox2.Name = "groupBox2";
			this.groupBox2.Size = new System.Drawing.Size(248, 192);
			this.groupBox2.TabIndex = 0;
			this.groupBox2.TabStop = false;
			this.groupBox2.Text = "Installed &Templates";
			// 
			// projectListView
			// 
			this.projectListView.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.projectListView.BackColor = System.Drawing.SystemColors.Control;
			this.projectListView.BorderStyle = System.Windows.Forms.BorderStyle.None;
			this.projectListView.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
																							  this.columnHeader1});
			this.projectListView.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None;
			this.projectListView.HideSelection = false;
			this.projectListView.Items.AddRange(new System.Windows.Forms.ListViewItem[] {
																							listViewItem1,
																							listViewItem2,
																							listViewItem3,
																							listViewItem4,
																							listViewItem5,
																							listViewItem6});
			this.projectListView.Location = new System.Drawing.Point(8, 16);
			this.projectListView.MultiSelect = false;
			this.projectListView.Name = "projectListView";
			this.projectListView.Size = new System.Drawing.Size(232, 168);
			this.projectListView.SmallImageList = this.imageList;
			this.projectListView.TabIndex = 0;
			this.projectListView.View = System.Windows.Forms.View.Details;
			this.projectListView.SelectedIndexChanged += new System.EventHandler(this.projectListView_SelectedIndexChanged);
			// 
			// columnHeader1
			// 
			this.columnHeader1.Width = 183;
			// 
			// imageList
			// 
			this.imageList.ColorDepth = System.Windows.Forms.ColorDepth.Depth32Bit;
			this.imageList.ImageSize = new System.Drawing.Size(16, 16);
			this.imageList.TransparentColor = System.Drawing.Color.Transparent;
			// 
			// locationTextBox
			// 
			this.locationTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.locationTextBox.Location = new System.Drawing.Point(67, 264);
			this.locationTextBox.Name = "locationTextBox";
			this.locationTextBox.Size = new System.Drawing.Size(320, 21);
			this.locationTextBox.TabIndex = 4;
			this.locationTextBox.Text = "C:\\Documents and Settings\\Nick\\My Documents";
			this.locationTextBox.TextChanged += new System.EventHandler(this.locationTextBox_TextChanged);
			// 
			// label1
			// 
			this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.label1.Location = new System.Drawing.Point(8, 266);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(56, 16);
			this.label1.TabIndex = 3;
			this.label1.Text = "&Location:";
			// 
			// descriptionLabel
			// 
			this.descriptionLabel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.descriptionLabel.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			this.descriptionLabel.Location = new System.Drawing.Point(8, 206);
			this.descriptionLabel.Name = "descriptionLabel";
			this.descriptionLabel.Size = new System.Drawing.Size(464, 20);
			this.descriptionLabel.TabIndex = 10;
			this.descriptionLabel.Text = "A project that uses the Macromedia V2 Components (Requires Flash MX/8 Installed)";
			this.descriptionLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// browseButton
			// 
			this.browseButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.browseButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.browseButton.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.browseButton.Location = new System.Drawing.Point(397, 264);
			this.browseButton.Name = "browseButton";
			this.browseButton.Size = new System.Drawing.Size(75, 21);
			this.browseButton.TabIndex = 5;
			this.browseButton.Text = "&Browse...";
			this.browseButton.Click += new System.EventHandler(this.browseButton_Click);
			// 
			// label2
			// 
			this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.label2.Location = new System.Drawing.Point(8, 236);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(56, 16);
			this.label2.TabIndex = 1;
			this.label2.Text = "&Name:";
			// 
			// nameTextBox
			// 
			this.nameTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.nameTextBox.Location = new System.Drawing.Point(67, 234);
			this.nameTextBox.Name = "nameTextBox";
			this.nameTextBox.Size = new System.Drawing.Size(405, 21);
			this.nameTextBox.TabIndex = 2;
			this.nameTextBox.Text = "New Project";
			this.nameTextBox.TextChanged += new System.EventHandler(this.nameTextBox_TextChanged);
			// 
			// createDirectoryBox
			// 
			this.createDirectoryBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.createDirectoryBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.createDirectoryBox.Location = new System.Drawing.Point(67, 296);
			this.createDirectoryBox.Name = "createDirectoryBox";
			this.createDirectoryBox.Size = new System.Drawing.Size(200, 16);
			this.createDirectoryBox.TabIndex = 11;
			this.createDirectoryBox.Text = "Create directory for project";
			this.createDirectoryBox.CheckedChanged += new System.EventHandler(this.createDirectoryBox_CheckedChanged);
			// 
			// statusBar
			// 
			this.statusBar.Location = new System.Drawing.Point(0, 324);
			this.statusBar.Name = "statusBar";
			this.statusBar.Size = new System.Drawing.Size(482, 22);
			this.statusBar.SizingGrip = false;
			this.statusBar.TabIndex = 12;
			this.statusBar.Text = "  Will create:  C:\\Documents and Settings\\Nick\\My Documents\\New Project.fdp";
			// 
			// NewProjectDialog
			// 
			this.AcceptButton = this.okButton;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.CancelButton = this.cancelButton;
			this.ClientSize = new System.Drawing.Size(482, 350);
			this.ControlBox = false;
			this.Controls.Add(this.statusBar);
			this.Controls.Add(this.createDirectoryBox);
			this.Controls.Add(this.nameTextBox);
			this.Controls.Add(this.locationTextBox);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.browseButton);
			this.Controls.Add(this.descriptionLabel);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.groupBox2);
			this.Controls.Add(this.groupBox1);
			this.Controls.Add(this.cancelButton);
			this.Controls.Add(this.okButton);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Name = "NewProjectDialog";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = "New Project";
			this.groupBox1.ResumeLayout(false);
			this.groupBox2.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		public NewProjectDialog()
		{
			InitializeComponent();

			#region Build ImageList

			Assembly assembly = Assembly.GetExecutingAssembly();
			Image projectIcon = new Bitmap(assembly.GetManifestResourceStream("Icons.FlashDevelop Project.png"));
			imageList.Images.Add(projectIcon);

			#endregion

			defaultProjectImage = Path.Combine(PathHelper.TemplatesDirectory,"Default.png");
			projectListView.Items.Clear();

			if (!Directory.Exists(PathHelper.TemplatesDirectory))
			{
				MessageBox.Show("The Templates directory could not be found.  You will not be able to create new projects.  You might try reinstalling FlashDevelop.","FlashDevelop");
				return;
			}

			foreach (string templateDir in Directory.GetDirectories(PathHelper.TemplatesDirectory))
			{
				string templateName = Path.GetFileName(templateDir).Substring(3);

				ListViewItem item = new ListViewItem(templateName);
				item.ImageIndex = 0;
				item.Tag = templateDir;

				projectListView.Items.Add(item);
			}

			if (projectListView.Items.Count > 0)
				projectListView.Items[0].Selected = true;
			else
				MessageBox.Show("No templates were found in the templates directory.  You will not be able to create new projects.  You might try reinstalling FlashDevelop.","FlashDevelop");

			nameTextBox.Text = "New Project";
			locationTextBox.Text = Settings.NewProjectDefaultDirectory;
			createDirectoryBox.Checked = Settings.CreateProjectDirectory;
		}

		#region Public Properties

		public string ProjectName
		{
			get { return nameTextBox.Text; }
			set { nameTextBox.Text = value; }
		}

		public string ProjectLocation
		{
			get
			{
				if (createDirectoryBox.Checked)
					return Path.Combine(locationTextBox.Text,ProjectName);
				else
					return locationTextBox.Text;
			}
			set { locationTextBox.Text = value; }
		}

		public string TemplateDirectory
		{
			get
			{
				if (projectListView.SelectedItems.Count > 0)
					return projectListView.SelectedItems[0].Tag as string;
				else
					return null;
			}
		}

		public string TemplateName
		{
			get
			{
				if (projectListView.SelectedItems.Count > 0)
					return projectListView.SelectedItems[0].Text;
				else
					return null;
			}
		}

		#endregion

		private void okButton_Click(object sender, System.EventArgs e)
		{
			// we want to create a project directory with the same name as the
			// project file, underneath the selected location.
			string projectName = Path.GetFileNameWithoutExtension(ProjectName);
			string projectPath = Path.Combine(ProjectLocation,projectName+".fdp");

			// does this directory exist and is NOT empty?
			if (Directory.Exists(ProjectLocation) &&
				Directory.GetFileSystemEntries(ProjectLocation).Length > 0)
			{
				if (TemplateName == "Empty Project" && !createDirectoryBox.Checked)
				{} // don't show the dialog in this case
				else
				{
					string msg = "The directory is not empty, are you sure you want to "
						+ "copy the template files there?";
				
					DialogResult result = MessageBox.Show(this,msg,"New Project",
						MessageBoxButtons.OKCancel,MessageBoxIcon.Warning);
				
					if (result != DialogResult.OK)
						return;
				}
			}

			// does this project file already exist?
			if (File.Exists(projectPath))
			{
				string msg = "The project file already exists.  Overwrite?";
				
				DialogResult result = MessageBox.Show(this,msg,"New Project",
					MessageBoxButtons.OKCancel,MessageBoxIcon.Warning);
				
				if (result != DialogResult.OK)
					return;
			}

			Settings.CreateProjectDirectory = createDirectoryBox.Checked;

			if (createDirectoryBox.Checked)
				Settings.NewProjectDefaultDirectory = locationTextBox.Text;
			else
				Settings.NewProjectDefaultDirectory = Path.GetDirectoryName(locationTextBox.Text);

			this.DialogResult = DialogResult.OK;
			this.Close();
		}

		private void projectListView_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			if (projectListView.SelectedIndices.Count > 0)
			{
				string projectImage = Path.Combine(TemplateDirectory,"Project.png");
				string projectDescription = Path.Combine(TemplateDirectory,"Project.txt");

				if (previewBox.Image != null)
					previewBox.Image.Dispose();

				if (File.Exists(projectImage))
					previewBox.Image = Image.FromFile(projectImage);
				else
					previewBox.Image = Image.FromFile(defaultProjectImage);

				if (File.Exists(projectDescription))
					using (StreamReader reader = File.OpenText(projectDescription))
						descriptionLabel.Text = reader.ReadToEnd();
				else
					descriptionLabel.Text = "";

				okButton.Enabled = true;
			}
			else
			{
				okButton.Enabled = false;
			}
		}

		private void browseButton_Click(object sender, System.EventArgs e)
		{
			FolderBrowserDialog dialog = new FolderBrowserDialog();
			dialog.RootFolder = Environment.SpecialFolder.Desktop;
			dialog.Description = "Please select the location to place the project directory.";

			string selectedPath = locationTextBox.Text;

			// try to get as close as we can to the directory you typed in
			try
			{
				while (!Directory.Exists(selectedPath))
					selectedPath = Path.GetDirectoryName(selectedPath);
			}
			catch
			{
				selectedPath = PathHelper.ProjectsDirectory;
			}

			dialog.SelectedPath = selectedPath;

			if (dialog.ShowDialog(this) == DialogResult.OK)
				locationTextBox.Text = dialog.SelectedPath;
		}

		private void UpdateStatusBar()
		{
			string sep = Path.DirectorySeparatorChar.ToString();

			statusBar.Text = "  Will create:  ";

			if (createDirectoryBox.Checked)
				statusBar.Text += locationTextBox.Text + sep + nameTextBox.Text + sep + nameTextBox.Text + ".fdp";
			else
				statusBar.Text += locationTextBox.Text + sep + nameTextBox.Text + ".fdp";
		}

		private void locationTextBox_TextChanged(object sender, System.EventArgs e)
		{ UpdateStatusBar(); }
		private void nameTextBox_TextChanged(object sender, System.EventArgs e)
		{ UpdateStatusBar(); }
		private void createDirectoryBox_CheckedChanged(object sender, System.EventArgs e)
		{ UpdateStatusBar(); }
	}
}
