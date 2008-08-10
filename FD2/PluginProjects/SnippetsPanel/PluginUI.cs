using System;
using System.Windows.Forms;
using System.Collections;
using System.Drawing;
using PluginCore;

namespace SnippetsPanel
{
	public class PluginUI : System.Windows.Forms.UserControl
	{
		private System.Windows.Forms.ComboBox snippetsComboBox;
		private System.Windows.Forms.Panel bottomPanel;
		private System.Windows.Forms.RichTextBox snippetTextBox;
		private System.Windows.Forms.Panel topPanel;
		private System.Windows.Forms.Button saveButton;
		private System.Windows.Forms.Button newButton;
		private System.Windows.Forms.Button deleteButton;
		private PluginMain pluginMain;
		private ISettings snippets;
		private IMainForm mainForm;
		
		public PluginUI(PluginMain pluginMain)
		{
			this.pluginMain = pluginMain;
			this.snippets = this.pluginMain.MainForm.MainSnippets;
			this.mainForm = this.pluginMain.MainForm;
			this.InitializeComponent();
			this.PopulateSnippetList();
		}
		
		#region Windows Forms Designer generated code
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			this.deleteButton = new System.Windows.Forms.Button();
			this.newButton = new System.Windows.Forms.Button();
			this.saveButton = new System.Windows.Forms.Button();
			this.topPanel = new System.Windows.Forms.Panel();
			this.snippetTextBox = new System.Windows.Forms.RichTextBox();
			this.bottomPanel = new System.Windows.Forms.Panel();
			this.snippetsComboBox = new System.Windows.Forms.ComboBox();
			this.topPanel.SuspendLayout();
			this.bottomPanel.SuspendLayout();
			this.SuspendLayout();
			// 
			// deleteButton
			// 
			this.deleteButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.deleteButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.deleteButton.Location = new System.Drawing.Point(61, 4);
			this.deleteButton.Name = "deleteButton";
			this.deleteButton.Size = new System.Drawing.Size(67, 23);
			this.deleteButton.TabIndex = 3;
			this.deleteButton.Text = "&Delete";
			this.deleteButton.Click += new System.EventHandler(this.DeleteButtonClick);
			// 
			// newButton
			// 
			this.newButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.newButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.newButton.Location = new System.Drawing.Point(0, 4);
			this.newButton.Name = "newButton";
			this.newButton.Size = new System.Drawing.Size(56, 23);
			this.newButton.TabIndex = 2;
			this.newButton.Text = "&New";
			this.newButton.Click += new System.EventHandler(this.NewButtonClick);
			// 
			// saveButton
			// 
			this.saveButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.saveButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.saveButton.Location = new System.Drawing.Point(133, 4);
			this.saveButton.Name = "saveButton";
			this.saveButton.Size = new System.Drawing.Size(59, 23);
			this.saveButton.TabIndex = 4;
			this.saveButton.Text = "&Save";
			this.saveButton.Click += new System.EventHandler(this.SaveButtonClick);
			// 
			// topPanel
			// 
			this.topPanel.Controls.Add(this.snippetsComboBox);
			this.topPanel.Dock = System.Windows.Forms.DockStyle.Top;
			this.topPanel.Location = new System.Drawing.Point(0, 0);
			this.topPanel.Name = "topPanel";
			this.topPanel.Size = new System.Drawing.Size(240, 32);
			this.topPanel.TabIndex = 8;
			// 
			// snippetTextBox
			// 
			this.snippetTextBox.AcceptsTab = true;
			this.snippetTextBox.AllowDrop = true;
			this.snippetTextBox.DetectUrls = false;
			this.snippetTextBox.Font = new System.Drawing.Font("Courier New", 8.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.snippetTextBox.BackColor = System.Drawing.Color.White;
			this.snippetTextBox.Dock = System.Windows.Forms.DockStyle.Fill;
			this.snippetTextBox.Location = new System.Drawing.Point(0, 32);
			this.snippetTextBox.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical;
			this.snippetTextBox.Name = "snippetTextBox";
			this.snippetTextBox.Size = new System.Drawing.Size(240, 297);
			this.snippetTextBox.TabIndex = 1;
			this.snippetTextBox.Text = "";
			// 
			// bottomPanel
			// 
			this.bottomPanel.Controls.Add(this.saveButton);
			this.bottomPanel.Controls.Add(this.deleteButton);
			this.bottomPanel.Controls.Add(this.newButton);
			this.bottomPanel.Dock = System.Windows.Forms.DockStyle.Bottom;
			this.bottomPanel.Location = new System.Drawing.Point(0, 329);
			this.bottomPanel.Name = "bottomPanel";
			this.bottomPanel.Size = new System.Drawing.Size(240, 31);
			this.bottomPanel.TabIndex = 7;
			// 
			// snippetsComboBox
			// 
			this.snippetsComboBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
			this.snippetsComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.snippetsComboBox.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.snippetsComboBox.Location = new System.Drawing.Point(0, 5);
			this.snippetsComboBox.Name = "snippetsComboBox";
			this.snippetsComboBox.Size = new System.Drawing.Size(240, 21);
			this.snippetsComboBox.TabIndex = 0;
			this.snippetsComboBox.SelectedIndexChanged += new System.EventHandler(this.SnippetsComboBoxSelectedIndexChanged);
			// 
			// PluginUI
			// 
			this.Controls.Add(this.snippetTextBox);
			this.Controls.Add(this.topPanel);
			this.Controls.Add(this.bottomPanel);
			this.Name = "PluginUI";
			this.Size = new System.Drawing.Size(240, 360);
			this.topPanel.ResumeLayout(false);
			this.bottomPanel.ResumeLayout(false);
			this.ResumeLayout(false);
		}
		#endregion
				
		#region MethodsAndEventHandlers
		
		public void PopulateSnippetList()
		{
			this.snippetsComboBox.Items.Clear();
			this.snippetsComboBox.Items.Add("Select...");
			int count = this.snippets.Settings.Count;
			for (int i = 0; i<count; i++)
			{
				ISettingEntry se = (ISettingEntry)this.snippets.Settings[i];
				this.snippetsComboBox.Items.Add(se.Key);
			}
			this.snippetsComboBox.SelectedIndex = 0;
			this.snippetTextBox.Enabled = false;
			this.deleteButton.Enabled = false;
			this.saveButton.Enabled = false;
		}
		
		public void SnippetsComboBoxSelectedIndexChanged(object sender, System.EventArgs e)
		{
			int curIndex = this.snippetsComboBox.SelectedIndex;
			if (curIndex != 0)
			{
				string key = this.snippetsComboBox.Items[curIndex].ToString();
				string val = this.snippets.GetValue(key);
				this.snippetTextBox.Text = val.Trim();
				this.snippetTextBox.Enabled = true;
				this.deleteButton.Enabled = true;
				this.saveButton.Enabled = true;
			} 
			else
			{
				this.snippetTextBox.Text = "Select a snippet from the above drop down list and the contents of the snippet will be displayed here.";
				this.snippetTextBox.Enabled = false;
				this.deleteButton.Enabled = false;
				this.saveButton.Enabled = false;
			}
		}
		
		public void SaveButtonClick(object sender, System.EventArgs e)
		{
			int curIndex = this.snippetsComboBox.SelectedIndex;
			if (curIndex != 0)
			{
				string key = this.snippetsComboBox.Items[curIndex].ToString();
				string eol = this.mainForm.GetNewLineMarker(0);
				string val = eol+this.snippetTextBox.Text+eol;
				this.snippets.ChangeValue(key, val);
				ErrorHandler.ShowInfo("Snippet \""+key+"\" has been saved.");
			}
		}
		
		public void DeleteButtonClick(object sender, System.EventArgs e)
		{
			int curIndex = this.snippetsComboBox.SelectedIndex;
			if (curIndex != 0)
			{
				string key = this.snippetsComboBox.Items[curIndex].ToString();
				this.snippets.RemoveByKey(key);
				this.snippetTextBox.Text = "";
				this.PopulateSnippetList();
				ErrorHandler.ShowInfo("Snippet \""+key+"\" has been deleted.");
			}
		}
		
		public void NewButtonClick(object sender, System.EventArgs e)
		{
			SnippetCreator snippetCreator = new SnippetCreator(this);
			snippetCreator.ShowDialog();
		}
		
		public void SelectItemById(string id)
		{
			int count = this.snippetsComboBox.Items.Count;
			for (int i = 0; i<count; i++)
			{
				if (this.snippetsComboBox.Items[i].ToString() == id)
				{
					this.snippetsComboBox.SelectedIndex = i;
					return;
				}
			}
		}
		
		#endregion
		
		#region GeneralProperties
		
		public ISettings Snippets 
		{
			get { return this.snippets; }
		}
		
		public IMainForm MainForm
		{
			get { return this.mainForm; }
		}
		
		#endregion
	
	}
	
}
