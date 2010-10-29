using System;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Diagnostics;
using System.Collections;
using System.ComponentModel;
using System.IO;
using System.Windows.Forms;
using System.Reflection;
using ProjectManager.Projects;
using ProjectManager.Helpers;
using PluginCore.Localization;
using PluginCore.Managers;
using PluginCore;
using System.Collections.Generic;

namespace ProjectManager.Controls
{
	public class NewProjectDialog : System.Windows.Forms.Form
	{
		string defaultProjectImage;

		#region Windows Form Designer

		private System.Windows.Forms.Button cancelButton;
        private System.Windows.Forms.Button okButton;
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
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox packageTextBox;
        private System.Windows.Forms.Label label4;
		private System.ComponentModel.IContainer components;
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
            this.components = new System.ComponentModel.Container();
            this.cancelButton = new System.Windows.Forms.Button();
            this.okButton = new System.Windows.Forms.Button();
            this.previewBox = new System.Windows.Forms.PictureBox();
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
            this.label3 = new System.Windows.Forms.Label();
            this.packageTextBox = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.previewBox)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // cancelButton
            // 
            this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.cancelButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.cancelButton.Location = new System.Drawing.Point(451, 336);
            this.cancelButton.Name = "cancelButton";
            this.cancelButton.Size = new System.Drawing.Size(75, 21);
            this.cancelButton.TabIndex = 8;
            this.cancelButton.Text = "&Cancel";
            // 
            // okButton
            // 
            this.okButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.okButton.Enabled = false;
            this.okButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.okButton.Location = new System.Drawing.Point(368, 336);
            this.okButton.Name = "okButton";
            this.okButton.Size = new System.Drawing.Size(75, 21);
            this.okButton.TabIndex = 7;
            this.okButton.Text = "&OK";
            this.okButton.Click += new System.EventHandler(this.okButton_Click);
            // 
            // previewBox
            // 
            this.previewBox.BackColor = System.Drawing.Color.White;
            this.previewBox.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.previewBox.Location = new System.Drawing.Point(313, 13);
            this.previewBox.Name = "previewBox";
            this.previewBox.Size = new System.Drawing.Size(212, 207);
            this.previewBox.TabIndex = 5;
            this.previewBox.TabStop = false;
            // 
            // groupBox2
            // 
            this.groupBox2.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox2.Controls.Add(this.projectListView);
            this.groupBox2.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.groupBox2.Location = new System.Drawing.Point(12, 7);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(293, 213);
            this.groupBox2.TabIndex = 0;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Installed &Templates";
            // 
            // projectListView
            // 
            this.projectListView.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.projectListView.BackColor = System.Drawing.SystemColors.Control;
            this.projectListView.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.projectListView.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1});
            this.projectListView.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None;
            this.projectListView.HideSelection = false;
            this.projectListView.Location = new System.Drawing.Point(7, 15);
            this.projectListView.MultiSelect = false;
            this.projectListView.Name = "projectListView";
            this.projectListView.Size = new System.Drawing.Size(279, 188);
            this.projectListView.SmallImageList = this.imageList;
            this.projectListView.TabIndex = 0;
            this.projectListView.UseCompatibleStateImageBehavior = false;
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
            this.locationTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.locationTextBox.Location = new System.Drawing.Point(67, 284);
            this.locationTextBox.Name = "locationTextBox";
            this.locationTextBox.Size = new System.Drawing.Size(375, 20);
            this.locationTextBox.TabIndex = 3;
            this.locationTextBox.Text = "C:\\Documents and Settings\\Nick\\My Documents";
            this.locationTextBox.TextChanged += new System.EventHandler(this.locationTextBox_TextChanged);
            // 
            // label1
            // 
            this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.label1.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.label1.Location = new System.Drawing.Point(12, 287);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(56, 15);
            this.label1.TabIndex = 3;
            this.label1.Text = "&Location:";
            // 
            // descriptionLabel
            // 
            this.descriptionLabel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.descriptionLabel.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.descriptionLabel.Location = new System.Drawing.Point(12, 230);
            this.descriptionLabel.Name = "descriptionLabel";
            this.descriptionLabel.Size = new System.Drawing.Size(513, 19);
            this.descriptionLabel.TabIndex = 1;
            this.descriptionLabel.Text = "Project description";
            this.descriptionLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // browseButton
            // 
            this.browseButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.browseButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.browseButton.Location = new System.Drawing.Point(451, 282);
            this.browseButton.Name = "browseButton";
            this.browseButton.Size = new System.Drawing.Size(75, 21);
            this.browseButton.TabIndex = 4;
            this.browseButton.Text = "&Browse...";
            this.browseButton.Click += new System.EventHandler(this.browseButton_Click);
            // 
            // label2
            // 
            this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.label2.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.label2.Location = new System.Drawing.Point(12, 260);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(56, 15);
            this.label2.TabIndex = 2;
            this.label2.Text = "&Name:";
            // 
            // nameTextBox
            // 
            this.nameTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.nameTextBox.Location = new System.Drawing.Point(67, 257);
            this.nameTextBox.Name = "nameTextBox";
            this.nameTextBox.Size = new System.Drawing.Size(458, 20);
            this.nameTextBox.TabIndex = 2;
            this.nameTextBox.Text = "New Project";
            this.nameTextBox.TextChanged += new System.EventHandler(this.nameTextBox_TextChanged);
            // 
            // createDirectoryBox
            // 
            this.createDirectoryBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.createDirectoryBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.createDirectoryBox.Location = new System.Drawing.Point(67, 340);
            this.createDirectoryBox.Name = "createDirectoryBox";
            this.createDirectoryBox.Size = new System.Drawing.Size(200, 15);
            this.createDirectoryBox.TabIndex = 6;
            this.createDirectoryBox.Text = " Create &directory for project";
            this.createDirectoryBox.CheckedChanged += new System.EventHandler(this.createDirectoryBox_CheckedChanged);
            // 
            // statusBar
            // 
            this.statusBar.Location = new System.Drawing.Point(0, 364);
            this.statusBar.Name = "statusBar";
            this.statusBar.Size = new System.Drawing.Size(537, 18);
            this.statusBar.SizingGrip = false;
            this.statusBar.TabIndex = 9;
            this.statusBar.Text = "  Will create:  C:\\Documents and Settings\\Nick\\My Documents\\New Project.fdp";
            // 
            // label3
            // 
            this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.label3.Location = new System.Drawing.Point(9, 313);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(59, 12);
            this.label3.TabIndex = 5;
            this.label3.Text = "&Package:";
            // 
            // packageTextBox
            // 
            this.packageTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.packageTextBox.Location = new System.Drawing.Point(67, 310);
            this.packageTextBox.Name = "packageTextBox";
            this.packageTextBox.Size = new System.Drawing.Size(303, 20);
            this.packageTextBox.TabIndex = 5;
            this.packageTextBox.TextChanged += new System.EventHandler(this.textPackage_TextChanged);
            // 
            // label4
            // 
            this.label4.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.label4.Location = new System.Drawing.Point(368, 313);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(158, 12);
            this.label4.TabIndex = 5;
            this.label4.Text = "(not supported in all projects)";
            this.label4.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // NewProjectDialog
            // 
            this.AcceptButton = this.okButton;
            this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
            this.CancelButton = this.cancelButton;
            this.ClientSize = new System.Drawing.Size(537, 386);
            this.Controls.Add(this.packageTextBox);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.previewBox);
            this.Controls.Add(this.statusBar);
            this.Controls.Add(this.createDirectoryBox);
            this.Controls.Add(this.nameTextBox);
            this.Controls.Add(this.locationTextBox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.browseButton);
            this.Controls.Add(this.descriptionLabel);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.cancelButton);
            this.Controls.Add(this.okButton);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "NewProjectDialog";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "New Project";
            ((System.ComponentModel.ISupportInitialize)(this.previewBox)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

		}
		#endregion

		public NewProjectDialog()
		{
            this.Font = PluginBase.Settings.DefaultFont;
            this.InitializeComponent();
            this.InitializeLocalization();

			imageList.Images.Add(Icons.Project.Img);
			defaultProjectImage = Path.Combine(ProjectPaths.ProjectTemplatesDirectory, "Default.png");
			projectListView.Items.Clear();

			if (!Directory.Exists(ProjectPaths.ProjectTemplatesDirectory))
			{
                string info = TextHelper.GetString("Info.TemplateDirNotFound");
                ErrorManager.ShowWarning(info, null);
				return;
			}

            ListViewGroup group = null;
            List<String> templateDirs = ProjectPaths.GetAllProjectDirs();
            foreach (string templateDir in templateDirs)
			{
                // skip hidden folders (read: version control)
                if ((File.GetAttributes(templateDir) & FileAttributes.Hidden) != 0) continue;

				string templateName = Path.GetFileName(templateDir).Substring(3);
                if (templateName.IndexOf('-') < 0) templateName = "-" + templateName;
                string[] parts = templateName.Split('-');

                ListViewItem item = new ListViewItem(" " + parts[1].Trim());
                item.ImageIndex = 0;
                item.Tag = templateDir;

                if (parts[0].Length > 0)
                {
                    if (group == null || group.Header != parts[0])
                    {
                        group = new ListViewGroup(parts[0]);
                        projectListView.Groups.Add(group);
                    }
                    item.Group = group;
                }
				projectListView.Items.Add(item);
			}
            this.Load += new EventHandler(NewProjectDialog_Load);
		}

        void NewProjectDialog_Load(object sender, EventArgs e)
        {
            if (projectListView.Items.Count > 0) projectListView.Items[0].Selected = true;
            else
            {
                string info = TextHelper.GetString("Info.NoTemplatesFound");
                ErrorManager.ShowWarning(info, null);
            }
            nameTextBox.Text = TextHelper.GetString("Info.NewProject");
            createDirectoryBox.Checked = PluginMain.Settings.CreateProjectDirectory;

            string locationDir = PluginMain.Settings.NewProjectDefaultDirectory;
            if (locationDir != null && locationDir.Length > 0 && Directory.Exists(locationDir))
                locationTextBox.Text = locationDir;
            else locationTextBox.Text = ProjectPaths.DefaultProjectsDirectory;
            locationTextBox.SelectionStart = locationTextBox.Text.Length;
        }

		#region Public Properties

		public string ProjectName
		{
			get { return nameTextBox.Text; }
			set { nameTextBox.Text = value; }
		}

        public string PackageName
        {
            get { return packageTextBox.Text; }

            set { packageTextBox.Text = value; }
        }

        public string ProjectExt
        {
            get
            {
                if (TemplateDirectory != null)
                {
                    string templateFile = ProjectCreator.FindProjectTemplate(TemplateDirectory);
                    if (templateFile != null)
                        return Path.GetExtension(templateFile);
                }
                return null;
            }
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

        private void InitializeLocalization()
        {
            this.okButton.Text = TextHelper.GetString("Label.OK");
            this.label2.Text = TextHelper.GetString("Label.Name");
            this.cancelButton.Text = TextHelper.GetString("Label.Cancel");
            this.browseButton.Text = TextHelper.GetString("Label.Browse");
            this.createDirectoryBox.Text = TextHelper.GetString("Info.CreateDirForProject");
            this.groupBox2.Text = TextHelper.GetString("Label.InstalledTemplates");
            this.nameTextBox.Text = TextHelper.GetString("Info.NewProject");
            this.label1.Text = TextHelper.GetString("Label.Location");
            this.label3.Text = TextHelper.GetString("Label.Package");
            this.label4.Text = TextHelper.GetString("Info.AboutPackages");
            this.Text = " " + TextHelper.GetString("Info.NewProject");
        }

		private void okButton_Click(object sender, System.EventArgs e)
		{
			// we want to create a project directory with the same name as the
			// project file, underneath the selected location.
			string projectName = Path.GetFileNameWithoutExtension(ProjectName);
			string projectPath = Path.Combine(ProjectLocation,projectName+ProjectExt);

			// does this directory exist and is NOT empty?
			if (Directory.Exists(ProjectLocation) && Directory.GetFileSystemEntries(ProjectLocation).Length > 0)
			{
                string empty = TextHelper.GetString("Info.EmptyProject");
                if (TemplateName == empty && !createDirectoryBox.Checked)
				{} // don't show the dialog in this case
				else
				{
                    string msg = TextHelper.GetString("Info.TargetDirNotEmpty");
                    string title = TextHelper.GetString("FlashDevelop.Title.WarningDialog");
                    DialogResult result = MessageBox.Show(this, msg, title, MessageBoxButtons.OKCancel,MessageBoxIcon.Warning);
					if (result != DialogResult.OK) return;
				}
			}

			// does this project file already exist?
			if (File.Exists(projectPath))
			{
                string msg = TextHelper.GetString("Info.ProjectFileAlreadyExists");
                string title = TextHelper.GetString("FlashDevelop.Title.WarningDialog");
                DialogResult result = MessageBox.Show(this, msg, title, MessageBoxButtons.OKCancel, MessageBoxIcon.Warning);
				if (result != DialogResult.OK) return;
			}

			PluginMain.Settings.CreateProjectDirectory = createDirectoryBox.Checked;
			if (createDirectoryBox.Checked) PluginMain.Settings.NewProjectDefaultDirectory = locationTextBox.Text;
			else PluginMain.Settings.NewProjectDefaultDirectory = Path.GetDirectoryName(locationTextBox.Text);
			this.DialogResult = DialogResult.OK;
			this.Close();
		}

		private void projectListView_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			if (projectListView.SelectedIndices.Count > 0)
			{
				string projectImage = Path.Combine(TemplateDirectory,"Project.png");
				string projectDescription = Path.Combine(TemplateDirectory,"Project.txt");

				if (previewBox.Image != null) previewBox.Image.Dispose();

                if (File.Exists(projectImage)) SetProjectImage(projectImage);
                else if (File.Exists(defaultProjectImage)) SetProjectImage(defaultProjectImage);
                else previewBox.Image = null;

                if (File.Exists(projectDescription))
                {
                    using (StreamReader reader = File.OpenText(projectDescription))
                    {
                        descriptionLabel.Text = reader.ReadToEnd();
                    }
                }
                else descriptionLabel.Text = "";
				okButton.Enabled = true;
			}
			else okButton.Enabled = false;
            UpdateStatusBar();
		}

        private void SetProjectImage(String projectImage)
        {
            Image image = Image.FromFile(projectImage);
            Bitmap empty = new Bitmap(this.previewBox.Width, this.previewBox.Height);
            Graphics graphics = Graphics.FromImage(empty);
            graphics.DrawImage(image, new Rectangle(empty.Width / 2 - image.Width / 2, empty.Height / 2 - image.Height / 2, image.Width, image.Height));
            previewBox.Image = empty;
            graphics.Dispose();
            image.Dispose();
        }

		private void browseButton_Click(object sender, System.EventArgs e)
		{
			FolderBrowserDialog dialog = new FolderBrowserDialog();
			dialog.RootFolder = Environment.SpecialFolder.Desktop;
            dialog.Description = TextHelper.GetString("Info.SelectProjectDirectory");

			string selectedPath = locationTextBox.Text;
			// try to get as close as we can to the directory you typed in
			try
			{
                while (!Directory.Exists(selectedPath))
                {
                    selectedPath = Path.GetDirectoryName(selectedPath);
                }
			}
			catch
			{
				selectedPath = ProjectPaths.DefaultProjectsDirectory;
			}
			dialog.SelectedPath = selectedPath;
            if (dialog.ShowDialog(this) == DialogResult.OK)
            {
                locationTextBox.Text = dialog.SelectedPath; 
                locationTextBox.SelectionStart = locationTextBox.Text.Length;

                // smart project naming
                if (!this.createDirectoryBox.Checked 
                    && this.nameTextBox.Text == TextHelper.GetString("Info.NewProject"))
                {
                    string name = Path.GetFileName(dialog.SelectedPath);
                    if (name.Length > 5)
                    {
                        this.nameTextBox.Text = name.Substring(0, 1).ToUpper() + name.Substring(1);
                    }
                }
            }
		}

		private void UpdateStatusBar()
		{
			string sep = Path.DirectorySeparatorChar.ToString();
            string ext = ProjectExt;
            if (ext != null)
            {
                statusBar.Text = "  " + TextHelper.GetString("Info.WillCreate") + " ";
                if (createDirectoryBox.Checked) statusBar.Text += locationTextBox.Text + sep + nameTextBox.Text + sep + nameTextBox.Text + ext;
                else statusBar.Text += locationTextBox.Text + sep + nameTextBox.Text + ext;
            }
            else statusBar.Text = "";
		}

		private void locationTextBox_TextChanged(object sender, System.EventArgs e) { UpdateStatusBar(); }
		private void nameTextBox_TextChanged(object sender, System.EventArgs e) { UpdateStatusBar(); }
		private void createDirectoryBox_CheckedChanged(object sender, System.EventArgs e) { UpdateStatusBar(); }

        private void textPackage_TextChanged(object sender, EventArgs e)
        {
            //package name invalid
            if (!Regex.IsMatch(PackageName, "^[_a-zA-Z]([_a-zA-Z0-9])*([\\.][_a-zA-Z]([_a-zA-Z0-9])*)*$") && packageTextBox.Text.Length > 0)
            {
                okButton.Enabled = false;
                packageTextBox.BackColor = System.Drawing.Color.Pink;
            }
            else
            {
                okButton.Enabled = true;
                packageTextBox.BackColor = System.Drawing.Color.White;
            }
        }

	}

}
