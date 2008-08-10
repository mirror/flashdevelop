using System;
using System.Drawing;
using System.Windows.Forms;
using System.Diagnostics;
using System.Text;
using System.IO;
using System.Web;

namespace AS2APIGUI
{
	public class MainForm : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Label outputDirLabel;
		private System.Windows.Forms.Button browseOutputDirButton;
		private System.Windows.Forms.Label classPathsLabel;
		private System.Windows.Forms.Button newButton;
		private System.Windows.Forms.ListBox classPathsListBox;
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.Button saveButton;
		private System.Windows.Forms.TextBox titleTextBox;
		private System.Windows.Forms.Label packageLabel;
		private System.Windows.Forms.TextBox packageTextBox;
		private System.Windows.Forms.Button deleteButton;
		private System.Windows.Forms.Button compileButton;
		private System.Windows.Forms.FolderBrowserDialog folderBrowserDialog;
		private System.Windows.Forms.Button browseFolderButton;
		private System.Windows.Forms.TextBox outputDirTextBox;
		private System.Windows.Forms.SaveFileDialog saveFileDialog;
		private System.Windows.Forms.Label titleLabel;
		private System.Windows.Forms.OpenFileDialog openFileDialog;
		private Settings Project = null;
		private string AppVersion = null;
		private string Filename = null;
		private string AppPath = null;
		
		public MainForm()
		{
			this.InitializeComponent();
			int endPos = Application.ProductVersion.LastIndexOf(".");
			this.AppVersion = Application.ProductVersion.Substring(0, endPos);
			this.AppPath = Path.GetDirectoryName(Application.ExecutablePath);
			this.Text = "AS2API GUI "+this.AppVersion+" - FlashDevelop.org";
		}
		
		[STAThread]
		public static void Main(string[] args)
		{
			Application.EnableVisualStyles(); 
  			Application.DoEvents(); // bug fix
			Application.Run(new MainForm());
		}
		
		#region Windows Forms Designer generated code
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(MainForm));
			this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
			this.titleLabel = new System.Windows.Forms.Label();
			this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
			this.outputDirTextBox = new System.Windows.Forms.TextBox();
			this.browseFolderButton = new System.Windows.Forms.Button();
			this.folderBrowserDialog = new System.Windows.Forms.FolderBrowserDialog();
			this.compileButton = new System.Windows.Forms.Button();
			this.deleteButton = new System.Windows.Forms.Button();
			this.packageTextBox = new System.Windows.Forms.TextBox();
			this.packageLabel = new System.Windows.Forms.Label();
			this.titleTextBox = new System.Windows.Forms.TextBox();
			this.saveButton = new System.Windows.Forms.Button();
			this.button1 = new System.Windows.Forms.Button();
			this.classPathsListBox = new System.Windows.Forms.ListBox();
			this.newButton = new System.Windows.Forms.Button();
			this.classPathsLabel = new System.Windows.Forms.Label();
			this.browseOutputDirButton = new System.Windows.Forms.Button();
			this.outputDirLabel = new System.Windows.Forms.Label();
			this.SuspendLayout();
			// 
			// titleLabel
			// 
			this.titleLabel.Location = new System.Drawing.Point(15, 15);
			this.titleLabel.Name = "titleLabel";
			this.titleLabel.Size = new System.Drawing.Size(61, 15);
			this.titleLabel.TabIndex = 16;
			this.titleLabel.Text = "Page title:";
			// 
			// outputDirTextBox
			// 
			this.outputDirTextBox.Location = new System.Drawing.Point(77, 79);
			this.outputDirTextBox.Name = "outputDirTextBox";
			this.outputDirTextBox.Size = new System.Drawing.Size(290, 21);
			this.outputDirTextBox.TabIndex = 12;
			this.outputDirTextBox.Text = "";
			// 
			// browseFolderButton
			// 
			this.browseFolderButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.browseFolderButton.Location = new System.Drawing.Point(375, 127);
			this.browseFolderButton.Name = "browseFolderButton";
			this.browseFolderButton.TabIndex = 4;
			this.browseFolderButton.Text = "Browse..";
			this.browseFolderButton.Click += new System.EventHandler(this.BrowseFolderButtonClick);
			// 
			// compileButton
			// 
			this.compileButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.compileButton.Location = new System.Drawing.Point(308, 211);
			this.compileButton.Name = "compileButton";
			this.compileButton.Size = new System.Drawing.Size(142, 23);
			this.compileButton.TabIndex = 10;
			this.compileButton.Text = "Generate documentation";
			this.compileButton.Click += new System.EventHandler(this.CompileButtonClick);
			// 
			// deleteButton
			// 
			this.deleteButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.deleteButton.Location = new System.Drawing.Point(375, 159);
			this.deleteButton.Name = "deleteButton";
			this.deleteButton.TabIndex = 5;
			this.deleteButton.Text = "Delete";
			this.deleteButton.Click += new System.EventHandler(this.DeleteButtonClick);
			// 
			// packageTextBox
			// 
			this.packageTextBox.Location = new System.Drawing.Point(77, 46);
			this.packageTextBox.Name = "packageTextBox";
			this.packageTextBox.Size = new System.Drawing.Size(372, 21);
			this.packageTextBox.TabIndex = 1;
			this.packageTextBox.Text = "";
			// 
			// packageLabel
			// 
			this.packageLabel.Location = new System.Drawing.Point(15, 48);
			this.packageLabel.Name = "packageLabel";
			this.packageLabel.Size = new System.Drawing.Size(61, 15);
			this.packageLabel.TabIndex = 15;
			this.packageLabel.Text = "Package:";
			// 
			// titleTextBox
			// 
			this.titleTextBox.Location = new System.Drawing.Point(77, 13);
			this.titleTextBox.Name = "titleTextBox";
			this.titleTextBox.Size = new System.Drawing.Size(372, 21);
			this.titleTextBox.TabIndex = 17;
			this.titleTextBox.Text = "";
			// 
			// saveButton
			// 
			this.saveButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.saveButton.Location = new System.Drawing.Point(98, 211);
			this.saveButton.Name = "saveButton";
			this.saveButton.Size = new System.Drawing.Size(78, 23);
			this.saveButton.TabIndex = 8;
			this.saveButton.Text = "Save project";
			this.saveButton.Click += new System.EventHandler(this.SaveButtonClick);
			// 
			// button1
			// 
			this.button1.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.button1.Location = new System.Drawing.Point(14, 211);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(78, 23);
			this.button1.TabIndex = 14;
			this.button1.Text = "Open project";
			this.button1.Click += new System.EventHandler(this.OpenButtonClick);
			// 
			// classPathsListBox
			// 
			this.classPathsListBox.Location = new System.Drawing.Point(15, 127);
			this.classPathsListBox.Name = "classPathsListBox";
			this.classPathsListBox.Size = new System.Drawing.Size(352, 69);
			this.classPathsListBox.TabIndex = 3;
			// 
			// newButton
			// 
			this.newButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.newButton.Location = new System.Drawing.Point(182, 211);
			this.newButton.Name = "newButton";
			this.newButton.Size = new System.Drawing.Size(76, 23);
			this.newButton.TabIndex = 9;
			this.newButton.Text = "New project";
			this.newButton.Click += new System.EventHandler(this.NewButtonClick);
			// 
			// classPathsLabel
			// 
			this.classPathsLabel.Location = new System.Drawing.Point(14, 109);
			this.classPathsLabel.Name = "classPathsLabel";
			this.classPathsLabel.Size = new System.Drawing.Size(71, 15);
			this.classPathsLabel.TabIndex = 8;
			this.classPathsLabel.Text = "Class paths:";
			// 
			// browseOutputDirButton
			// 
			this.browseOutputDirButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.browseOutputDirButton.Location = new System.Drawing.Point(375, 79);
			this.browseOutputDirButton.Name = "browseOutputDirButton";
			this.browseOutputDirButton.TabIndex = 13;
			this.browseOutputDirButton.Text = "Browse..";
			this.browseOutputDirButton.Click += new System.EventHandler(this.BrowseOutputDirButtonClick);
			// 
			// outputDirLabel
			// 
			this.outputDirLabel.Location = new System.Drawing.Point(14, 82);
			this.outputDirLabel.Name = "outputDirLabel";
			this.outputDirLabel.Size = new System.Drawing.Size(61, 15);
			this.outputDirLabel.TabIndex = 11;
			this.outputDirLabel.Text = "Output dir:";
			// 
			// MainForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.ClientSize = new System.Drawing.Size(464, 247);
			this.Controls.Add(this.titleTextBox);
			this.Controls.Add(this.titleLabel);
			this.Controls.Add(this.packageLabel);
			this.Controls.Add(this.button1);
			this.Controls.Add(this.outputDirLabel);
			this.Controls.Add(this.browseOutputDirButton);
			this.Controls.Add(this.outputDirTextBox);
			this.Controls.Add(this.saveButton);
			this.Controls.Add(this.newButton);
			this.Controls.Add(this.classPathsListBox);
			this.Controls.Add(this.compileButton);
			this.Controls.Add(this.deleteButton);
			this.Controls.Add(this.classPathsLabel);
			this.Controls.Add(this.browseFolderButton);
			this.Controls.Add(this.packageTextBox);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
			this.MaximizeBox = false;
			this.Name = "MainForm";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "AS2API GUI";
			this.ResumeLayout(false);
		}
		#endregion
		
		#region MethodsAndEventHandlers
		
		public void OpenButtonClick(object sender, System.EventArgs e)
		{
			this.openFileDialog.FileName = "";
			if (this.openFileDialog.ShowDialog() == DialogResult.OK)
			{
				this.Filename = this.openFileDialog.FileName;
				this.Project = new Settings(this.openFileDialog.FileName);
				this.ProcessProjectFile();
			}
		}
		
		public void NewButtonClick(object sender, System.EventArgs e)
		{
			this.Project = null;
			this.classPathsListBox.Items.Clear();
			this.packageTextBox.Text = "";
			this.outputDirTextBox.Text = "";
			this.titleTextBox.Text = "";
			this.Filename = null;
		}
		
		public void SaveButtonClick(object sender, System.EventArgs e)
		{
			this.saveFileDialog.FileName = "NewProject.xml";
			if (this.Filename != null)
			{
				this.UpdateProjectFile();
				this.Project.Save();
				MessageBox.Show("Project saved.", "Information");
			}
			else if (this.Filename == null && this.saveFileDialog.ShowDialog() == DialogResult.OK)
			{
				this.Filename = this.saveFileDialog.FileName;
				FileSystem.Write(this.saveFileDialog.FileName, "<?xml version=\"1.0\" ?>\n<settings />", Encoding.Default);
				this.Project = new Settings(this.saveFileDialog.FileName);
				this.InitializeProjectFile();
				this.Project.Save();
				MessageBox.Show("Project saved.", "Information");
			}
		}
		
		public void BrowseOutputDirButtonClick(object sender, System.EventArgs e)
		{
			if (this.folderBrowserDialog.ShowDialog() == DialogResult.OK)
			{
				string path = this.folderBrowserDialog.SelectedPath;
				this.outputDirTextBox.Text = path;
			}
		}
		
		public void BrowseFolderButtonClick(object sender, System.EventArgs e)
		{
			if (this.folderBrowserDialog.ShowDialog() == DialogResult.OK)
			{
				string path = this.folderBrowserDialog.SelectedPath;
				this.classPathsListBox.Items.Add(path);
			}
		}
		
		public void DeleteButtonClick(object sender, System.EventArgs e)
		{
			try 
			{
				int index = this.classPathsListBox.SelectedIndex;
				this.classPathsListBox.Items.RemoveAt(index);
			} 
			catch 
			{
				// Do nothing..
			}
		}
		
		public void ProcessProjectFile()
		{
			this.classPathsListBox.Items.Clear();
			string path = this.Project.GetValue("ClassPaths");
			if (path != null)
			{
				string[] paths = path.Split(Convert.ToChar(";"));
				for (int i = 0; i<paths.Length; i++)
				{
					if (paths[i] != null) this.classPathsListBox.Items.Add(paths[i]);
				}
			}
			this.titleTextBox.Text = HttpUtility.HtmlDecode(this.Project.GetValue("PageTitle"));
			this.outputDirTextBox.Text = this.Project.GetValue("OutputDir");
			this.packageTextBox.Text = this.Project.GetValue("Package");
		}
		
		public void UpdateProjectFile()
		{
			string classPaths = "";
			for(int i = 0; i<this.classPathsListBox.Items.Count; i++)
			{
				if (i != this.classPathsListBox.Items.Count-1) classPaths += this.classPathsListBox.Items[i].ToString()+";";
				else classPaths += this.classPathsListBox.Items[i].ToString();
			}
			this.Project.ChangeValue("ClassPaths", classPaths);
			this.Project.ChangeValue("PageTitle", HttpUtility.HtmlEncode(this.titleTextBox.Text));
			this.Project.ChangeValue("OutputDir", this.outputDirTextBox.Text);
			this.Project.ChangeValue("Package", this.packageTextBox.Text);
		}
		
		public void InitializeProjectFile()
		{
			string classPaths = "";
			for(int i = 0; i<this.classPathsListBox.Items.Count; i++)
			{
				if (i != this.classPathsListBox.Items.Count-1) classPaths += this.classPathsListBox.Items[i].ToString()+";";
				else classPaths += this.classPathsListBox.Items[i].ToString();
			}
			this.Project.ChangeValue("ClassPaths", classPaths);
			this.Project.ChangeValue("PageTitle", HttpUtility.HtmlEncode(this.titleTextBox.Text));
			this.Project.ChangeValue("OutputDir", this.outputDirTextBox.Text);
			this.Project.ChangeValue("Package", this.packageTextBox.Text);
		}
		
		public void CompileButtonClick(object sender, System.EventArgs e)
		{
			string arguments = "--progress --encoding iso-8859-1 ";
			if (this.classPathsListBox.Items.Count > 0)
			{
				string classPaths = "";
				for (int i = 0; i<this.classPathsListBox.Items.Count; i++)
				{
					if (i != this.classPathsListBox.Items.Count-1)
					{
						classPaths += this.classPathsListBox.Items[i].ToString()+";";
					} 
					else 
					{
						classPaths += this.classPathsListBox.Items[i].ToString();
					}
				}
				arguments += "--classpath \""+classPaths+"\" ";
			}
			if (this.titleTextBox.Text != "")
			{
				arguments += "--title \""+HttpUtility.HtmlEncode(this.titleTextBox.Text)+"\" ";
			}
			if (this.outputDirTextBox.Text != "")
			{
				arguments += "--output-dir \""+this.outputDirTextBox.Text+"\" ";
			}
			if (this.packageTextBox.Text != "")
			{
				arguments += "\""+this.packageTextBox.Text+"\" ";
			}
			string file = this.AppPath+"\\as2apigui.bat";
			string data = "\""+this.AppPath+"\\as2api.exe\" "+arguments+"\r\npause";
			FileSystem.Write(file, data, Encoding.Default);
			Process.Start(file);
		}
		
		#endregion
		
	}
	
}
