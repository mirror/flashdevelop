using System;
using System.IO;
using System.Text;
using System.Drawing;
using System.Reflection;
using System.Collections;
using System.Windows.Forms;
using System.ComponentModel;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.Controls
{
	public class ClasspathControl : UserControl
	{
		#region ClasspathEntry

		private class ClasspathEntry
		{
			public string Classpath;

			public ClasspathEntry(string classpath)
			{
				this.Classpath = classpath;
			}

			public override string ToString()
			{
				return (Classpath == ".") ? "<Project Directory>" : Classpath;
			}

			public override bool Equals(object obj)
			{
				ClasspathEntry entry = obj as ClasspathEntry;
				if (entry != null) return entry.Classpath == Classpath;
				else return base.Equals(obj);
			}

			public override int GetHashCode()
			{
				return base.GetHashCode ();
			}
		}

		#endregion

		Project project; // if not null, use relative paths

		public event EventHandler Changed;

		#region Component Designer

		private ListBox listBox;
		private Button btnNewClasspath;
		private Button btnRemove;
		private System.Windows.Forms.ToolTip toolTip;
		private System.Windows.Forms.Button btnUp;
		private System.Windows.Forms.Button btnDown;

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

		#region Component Designer generated code

		/// <summary> 
		/// Required method for Designer support - do not modify 
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			this.listBox = new System.Windows.Forms.ListBox();
			this.btnNewClasspath = new System.Windows.Forms.Button();
			this.btnRemove = new System.Windows.Forms.Button();
			this.toolTip = new System.Windows.Forms.ToolTip(this.components);
			this.btnUp = new System.Windows.Forms.Button();
			this.btnDown = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// listBox
			// 
			this.listBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.listBox.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.listBox.Location = new System.Drawing.Point(0, 0);
			this.listBox.Name = "listBox";
			this.listBox.Size = new System.Drawing.Size(245, 108);
			this.listBox.TabIndex = 0;
			this.listBox.DoubleClick += new System.EventHandler(this.listBox_DoubleClick);
			this.listBox.MouseMove += new System.Windows.Forms.MouseEventHandler(this.listBox_MouseMove);
			this.listBox.SelectedIndexChanged += new System.EventHandler(this.listBox_SelectedIndexChanged);
			// 
			// btnNewClasspath
			// 
			this.btnNewClasspath.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.btnNewClasspath.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnNewClasspath.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.btnNewClasspath.Location = new System.Drawing.Point(0, 108);
			this.btnNewClasspath.Name = "btnNewClasspath";
			this.btnNewClasspath.Size = new System.Drawing.Size(118, 23);
			this.btnNewClasspath.TabIndex = 1;
			this.btnNewClasspath.Text = "&Add Classpath...";
			this.btnNewClasspath.Click += new System.EventHandler(this.btnNewClasspath_Click);
			// 
			// btnRemove
			// 
			this.btnRemove.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.btnRemove.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnRemove.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.btnRemove.Location = new System.Drawing.Point(168, 108);
			this.btnRemove.Name = "btnRemove";
			this.btnRemove.Size = new System.Drawing.Size(79, 23);
			this.btnRemove.TabIndex = 2;
			this.btnRemove.Text = "&Remove";
			this.btnRemove.Click += new System.EventHandler(this.btnRemove_Click);
			// 
			// btnUp
			// 
			this.btnUp.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.btnUp.Location = new System.Drawing.Point(248, 0);
			this.btnUp.Name = "btnUp";
			this.btnUp.Size = new System.Drawing.Size(24, 24);
			this.btnUp.TabIndex = 3;
			this.btnUp.Click += new System.EventHandler(this.btnUp_Click);
			// 
			// btnDown
			// 
			this.btnDown.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.btnDown.Location = new System.Drawing.Point(248, 24);
			this.btnDown.Name = "btnDown";
			this.btnDown.Size = new System.Drawing.Size(24, 24);
			this.btnDown.TabIndex = 4;
			this.btnDown.Click += new System.EventHandler(this.btnDown_Click);
			// 
			// ClasspathControl
			// 
			this.Controls.Add(this.btnDown);
			this.Controls.Add(this.btnUp);
			this.Controls.Add(this.btnRemove);
			this.Controls.Add(this.btnNewClasspath);
			this.Controls.Add(this.listBox);
			this.Name = "ClasspathControl";
			this.Size = new System.Drawing.Size(272, 131);
			this.ResumeLayout(false);

		}

		#endregion

		#endregion

		public ClasspathControl()
		{
			InitializeComponent();
			btnRemove.Enabled = false;

			Assembly assembly = Assembly.GetExecutingAssembly();
			Image upIcon = new Bitmap(assembly.GetManifestResourceStream("Icons.UpArrow.png"));
			Image downIcon = new Bitmap(assembly.GetManifestResourceStream("Icons.DownArrow.png"));
			btnUp.Image = upIcon;
			btnDown.Image = downIcon;
			SetButtons();
		}

		#region Public Properties

		public Project Project
		{
			get { return project; }
			set { project = value; }
		}

		public string ClasspathString
		{
			get { return string.Join(";", Classpaths); }
			set { Classpaths = value.Split(';'); }
		}

		public string[] Classpaths
		{
			get
			{
				ArrayList classpaths = new ArrayList();
				foreach (ClasspathEntry entry in listBox.Items)
					classpaths.Add(entry.Classpath);
				return classpaths.ToArray(typeof(string)) as string[];
			}
			set
			{
				listBox.Items.Clear();
				foreach (string cp in value)
					listBox.Items.Add(new ClasspathEntry(cp));
			}
		}

		#endregion

		private void OnChanged()
		{
			if (Changed != null)
				Changed(this, new EventArgs());
		}

		private void SetButtons()
		{
			btnRemove.Enabled = (listBox.SelectedIndex > -1);
			btnUp.Enabled = (listBox.SelectedIndex > 0);
			btnDown.Enabled = (listBox.SelectedIndex < listBox.Items.Count -1);
		}

		string lastBrowserPath;

		private void btnNewClasspath_Click(object sender, EventArgs e)
		{
			using (FolderBrowserDialog dialog = new FolderBrowserDialog())
			{
				dialog.RootFolder = Environment.SpecialFolder.Desktop;
				dialog.Description = "Please select a classpath directory.";

				if (project != null)
					dialog.SelectedPath = project.Directory;

				if (lastBrowserPath != null && Directory.Exists(lastBrowserPath))
					dialog.SelectedPath = lastBrowserPath;

				if (dialog.ShowDialog(this) == DialogResult.OK)
				{
					string path = dialog.SelectedPath;

					if (project != null)
					{
						if (!CanBeRelative(path)) return;
						path = project.GetRelativePath(path);
					}

					if (!WarnConflictingPath(path))
						return;

					ClasspathEntry entry = new ClasspathEntry(path);

					if (!listBox.Items.Contains(entry))
						listBox.Items.Add(entry);

					OnChanged();
					lastBrowserPath = dialog.SelectedPath;
				}
			}
		}

		private bool CanBeRelative(string path)
		{
			if (Path.GetPathRoot(path).ToLower() != 
				Path.GetPathRoot(project.ProjectPath).ToLower())
			{
				MessageBox.Show(this,"The path you selected is invalid.  Project classpaths must be relative to the project location and on the same drive.","Invalid Path");
				return false;
			}
			return true;
		}

		private void btnRemove_Click(object sender, EventArgs e)
		{
			listBox.Items.RemoveAt(listBox.SelectedIndex);
			OnChanged();
		}

		private void listBox_SelectedIndexChanged(object sender, EventArgs e)
		{
			SetButtons();
		}

		private void listBox_DoubleClick(object sender, System.EventArgs e)
		{
			ClasspathEntry entry = listBox.SelectedItem as ClasspathEntry;

			if (entry == null) return; // you could have double-clicked on whitespace
						
			using (FolderBrowserDialog dialog = new FolderBrowserDialog())
			{
				dialog.RootFolder = Environment.SpecialFolder.Desktop;
				dialog.Description = "Please select a classpath directory.";

				if (project != null)
				{
					dialog.SelectedPath = project.GetAbsolutePath(entry.Classpath);

					if (!Directory.Exists(dialog.SelectedPath))
						dialog.SelectedPath = project.Directory;
				}
				else
					dialog.SelectedPath = entry.Classpath;

				if (dialog.ShowDialog(this) == DialogResult.OK)
				{
					string selectedPath = dialog.SelectedPath;

					if (project != null)
					{
						if (!CanBeRelative(selectedPath)) return;
						selectedPath = project.GetRelativePath(selectedPath);
					}

					if (selectedPath == entry.Classpath)
						return; // nothing to do!
					
					listBox.Items[listBox.SelectedIndex] = new ClasspathEntry(selectedPath);
					OnChanged();
				}
			}
		}

		private void listBox_MouseMove(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			int selectedIndex = listBox.IndexFromPoint(e.X,e.Y);
			
			if (selectedIndex > -1)
			{
				string path = listBox.Items[selectedIndex].ToString();
				Graphics g = listBox.CreateGraphics();
				if (g.MeasureString(path,listBox.Font).Width > listBox.ClientRectangle.Width)
				{
					toolTip.SetToolTip(listBox,path);
					
					return;
				}
			}

			toolTip.SetToolTip(listBox,"");
		}

		private void btnUp_Click(object sender, System.EventArgs e)
		{
			int index = listBox.SelectedIndex;
			object temp = listBox.Items[index-1];
			listBox.Items[index-1] = listBox.Items[index];
			listBox.Items[index] = temp;
			listBox.SelectedIndex = index-1;
			OnChanged();
		}

		private void btnDown_Click(object sender, System.EventArgs e)
		{
			int index = listBox.SelectedIndex;
			object temp = listBox.Items[index+1];
			listBox.Items[index+1] = listBox.Items[index];
			listBox.Items[index] = temp;
			listBox.SelectedIndex = index+1;
			OnChanged();
		}

		#region WarnConflictingPath

		private bool WarnConflictingPath(string path)
		{
			char sep = Path.DirectorySeparatorChar;

			if (project != null)
				path = project.GetAbsolutePath(path);

			foreach (ClasspathEntry entry in listBox.Items)
			{
				string cp = entry.Classpath;

				if (project != null)
					cp = project.GetAbsolutePath(cp);

				if (path.StartsWith(cp + sep) || cp.StartsWith(path + sep))
				{
					string message = string.Format("The path you selected conflicts with "
						+ "the existing classpath {0}.  Would you still like to add it?",cp);

					DialogResult result = MessageBox.Show(this,message,"Path Conflict",
						MessageBoxButtons.OKCancel,MessageBoxIcon.Warning);

					if (result == DialogResult.Cancel) return false;
				}
			}
			return true;
		}

		#endregion
	}
}
