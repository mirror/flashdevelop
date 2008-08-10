using System;
using System.Drawing;
using System.Diagnostics;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.Controls
{
	public class BuildEventDialog : System.Windows.Forms.Form
	{
		Project project;
		BuildEventVars vars;

		#region Windows Form Designer

		private System.Windows.Forms.StatusBar statusBar;
		private System.Windows.Forms.Panel panel1;
		private System.Windows.Forms.ListView listView;
		private System.Windows.Forms.Button cancelButton;
		private System.Windows.Forms.Button okButton;
		private System.Windows.Forms.Splitter splitter1;
		private System.Windows.Forms.ColumnHeader nameColumn;
		private System.Windows.Forms.ColumnHeader valueColumn;
		private System.Windows.Forms.TextBox textBox;
		private System.Windows.Forms.ToolTip toolTip;
		private System.ComponentModel.IContainer components;
		private System.Windows.Forms.Button insertButton;

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			this.statusBar = new System.Windows.Forms.StatusBar();
			this.panel1 = new System.Windows.Forms.Panel();
			this.insertButton = new System.Windows.Forms.Button();
			this.textBox = new System.Windows.Forms.TextBox();
			this.splitter1 = new System.Windows.Forms.Splitter();
			this.okButton = new System.Windows.Forms.Button();
			this.listView = new System.Windows.Forms.ListView();
			this.nameColumn = new System.Windows.Forms.ColumnHeader();
			this.valueColumn = new System.Windows.Forms.ColumnHeader();
			this.cancelButton = new System.Windows.Forms.Button();
			this.toolTip = new System.Windows.Forms.ToolTip(this.components);
			this.panel1.SuspendLayout();
			this.SuspendLayout();
			// 
			// statusBar
			// 
			this.statusBar.Location = new System.Drawing.Point(0, 320);
			this.statusBar.Name = "statusBar";
			this.statusBar.Size = new System.Drawing.Size(384, 22);
			this.statusBar.TabIndex = 0;
			// 
			// panel1
			// 
			this.panel1.Controls.Add(this.insertButton);
			this.panel1.Controls.Add(this.textBox);
			this.panel1.Controls.Add(this.splitter1);
			this.panel1.Controls.Add(this.okButton);
			this.panel1.Controls.Add(this.listView);
			this.panel1.Controls.Add(this.cancelButton);
			this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.panel1.DockPadding.Bottom = 38;
			this.panel1.DockPadding.Left = 8;
			this.panel1.DockPadding.Right = 8;
			this.panel1.DockPadding.Top = 8;
			this.panel1.Location = new System.Drawing.Point(0, 0);
			this.panel1.Name = "panel1";
			this.panel1.Size = new System.Drawing.Size(384, 320);
			this.panel1.TabIndex = 1;
			// 
			// insertButton
			// 
			this.insertButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.insertButton.Enabled = false;
			this.insertButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.insertButton.Location = new System.Drawing.Point(8, 288);
			this.insertButton.Name = "insertButton";
			this.insertButton.Size = new System.Drawing.Size(72, 23);
			this.insertButton.TabIndex = 4;
			this.insertButton.Text = "&Insert";
			this.insertButton.Click += new System.EventHandler(this.insertButton_Click);
			// 
			// textBox
			// 
			this.textBox.AcceptsReturn = true;
			this.textBox.AcceptsTab = true;
			this.textBox.Dock = System.Windows.Forms.DockStyle.Fill;
			this.textBox.Location = new System.Drawing.Point(8, 8);
			this.textBox.Multiline = true;
			this.textBox.Name = "textBox";
			this.textBox.Size = new System.Drawing.Size(368, 116);
			this.textBox.TabIndex = 0;
			this.textBox.Text = "";
			this.textBox.TextChanged += new System.EventHandler(this.textBox_TextChanged);
			// 
			// splitter1
			// 
			this.splitter1.Dock = System.Windows.Forms.DockStyle.Bottom;
			this.splitter1.Location = new System.Drawing.Point(8, 124);
			this.splitter1.Name = "splitter1";
			this.splitter1.Size = new System.Drawing.Size(368, 6);
			this.splitter1.TabIndex = 3;
			this.splitter1.TabStop = false;
			// 
			// okButton
			// 
			this.okButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.okButton.DialogResult = System.Windows.Forms.DialogResult.OK;
			this.okButton.Enabled = false;
			this.okButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.okButton.Location = new System.Drawing.Point(216, 288);
			this.okButton.Name = "okButton";
			this.okButton.TabIndex = 2;
			this.okButton.Text = "&OK";
			// 
			// listView
			// 
			this.listView.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
																					   this.nameColumn,
																					   this.valueColumn});
			this.listView.Dock = System.Windows.Forms.DockStyle.Bottom;
			this.listView.FullRowSelect = true;
			this.listView.GridLines = true;
			this.listView.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable;
			this.listView.HideSelection = false;
			this.listView.Location = new System.Drawing.Point(8, 130);
			this.listView.MultiSelect = false;
			this.listView.Name = "listView";
			this.listView.Size = new System.Drawing.Size(368, 152);
			this.listView.TabIndex = 1;
			this.listView.View = System.Windows.Forms.View.Details;
			this.listView.DoubleClick += new System.EventHandler(this.listView_DoubleClick);
			this.listView.MouseMove += new System.Windows.Forms.MouseEventHandler(this.listView_MouseMove);
			this.listView.SelectedIndexChanged += new System.EventHandler(this.listView_SelectedIndexChanged);
			// 
			// nameColumn
			// 
			this.nameColumn.Text = "Name";
			this.nameColumn.Width = 94;
			// 
			// valueColumn
			// 
			this.valueColumn.Text = "Value";
			this.valueColumn.Width = 254;
			// 
			// cancelButton
			// 
			this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.cancelButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.cancelButton.Location = new System.Drawing.Point(301, 288);
			this.cancelButton.Name = "cancelButton";
			this.cancelButton.TabIndex = 0;
			this.cancelButton.Text = "&Cancel";
			// 
			// BuildEventDialog
			// 
			this.AcceptButton = this.okButton;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.CancelButton = this.cancelButton;
			this.ClientSize = new System.Drawing.Size(384, 342);
			this.ControlBox = false;
			this.Controls.Add(this.panel1);
			this.Controls.Add(this.statusBar);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.Name = "BuildEventDialog";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = "Command-Line Builder";
			this.panel1.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		public BuildEventDialog(Project project)
		{
			InitializeComponent();

			this.project = project;
			this.vars = new BuildEventVars(project,Settings.GlobalClasspaths.Split(';'));

			foreach (BuildEventInfo info in vars.GetVars())
				Add(info);
		}

		public string CommandLine
		{
			get { return textBox.Text; }
			set { textBox.Text = value; }
		}

		private void Add(BuildEventInfo info)
		{
			ListViewItem item = new ListViewItem(info.Name);
			item.SubItems.Add(info.Value);
			item.Tag = info;
			listView.Items.Add(item);
		}

		private void textBox_TextChanged(object sender, System.EventArgs e)
		{
			okButton.Enabled = true;
		}

		private void listView_DoubleClick(object sender, System.EventArgs e)
		{
			if (listView.SelectedItems.Count > 0)
				DoInsert();
		}

		private void insertButton_Click(object sender, System.EventArgs e)
		{
			DoInsert();
		}

		private void DoInsert()
		{
			BuildEventInfo info = listView.SelectedItems[0].Tag as BuildEventInfo;
			
			textBox.Focus();
			SendKeys.Send(info.SendKeysName);
		}

		private void listView_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			insertButton.Enabled = (listView.SelectedItems.Count > 0);
		}

		protected override void OnResize(EventArgs e)
		{
			base.OnResize(e);
			valueColumn.Width = listView.Width - 10 - nameColumn.Width;
		}

		private void listView_MouseMove(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			ListViewItem item = listView.GetItemAt(e.X,e.Y);
			
			if (item != null && e.X >= nameColumn.Width)
			{
				BuildEventInfo info = item.Tag as BuildEventInfo;
				Graphics g = listView.CreateGraphics();
				if (g.MeasureString(info.Value,listView.Font).Width > valueColumn.Width)
				{
					toolTip.SetToolTip(listView,info.Value);
					return;
				}
			}

			toolTip.SetToolTip(listView,"");
		}
	}
}
