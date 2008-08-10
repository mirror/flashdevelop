using System;
using System.Drawing;
using System.Windows.Forms;
using PluginCore;

namespace SnippetsPanel
{
	public class SnippetCreator : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Button createButton;
		private System.Windows.Forms.TextBox snippetTextBox;
		private System.Windows.Forms.Button cancelButton;
		private System.Windows.Forms.Label valueLabel;
		private System.Windows.Forms.Label idLabel;
		private System.Windows.Forms.TextBox snippetIdTextBox;
		private PluginUI pluginUI;
		
		public SnippetCreator(PluginUI pluginUI)
		{
			this.pluginUI = pluginUI;
			this.InitializeComponent();
		}
		
		#region Windows Forms Designer generated code
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			this.snippetIdTextBox = new System.Windows.Forms.TextBox();
			this.idLabel = new System.Windows.Forms.Label();
			this.valueLabel = new System.Windows.Forms.Label();
			this.cancelButton = new System.Windows.Forms.Button();
			this.snippetTextBox = new System.Windows.Forms.TextBox();
			this.createButton = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// snippetIdTextBox
			// 
			this.snippetIdTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
						| System.Windows.Forms.AnchorStyles.Right)));
			this.snippetIdTextBox.Location = new System.Drawing.Point(48, 11);
			this.snippetIdTextBox.Name = "snippetIdTextBox";
			this.snippetIdTextBox.Size = new System.Drawing.Size(317, 21);
			this.snippetIdTextBox.TabIndex = 1;
			this.snippetIdTextBox.Text = "SnippetID";
			// 
			// idLabel
			// 
			this.idLabel.Location = new System.Drawing.Point(5, 14);
			this.idLabel.Name = "idLabel";
			this.idLabel.Size = new System.Drawing.Size(39, 15);
			this.idLabel.TabIndex = 6;
			this.idLabel.Text = "ID:";
			this.idLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
			// 
			// valueLabel
			// 
			this.valueLabel.Location = new System.Drawing.Point(4, 45);
			this.valueLabel.Name = "valueLabel";
			this.valueLabel.Size = new System.Drawing.Size(40, 15);
			this.valueLabel.TabIndex = 7;
			this.valueLabel.Text = "Value:";
			this.valueLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
			// 
			// cancelButton
			// 
			this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.cancelButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.cancelButton.Location = new System.Drawing.Point(207, 149);
			this.cancelButton.Name = "cancelButton";
			this.cancelButton.TabIndex = 3;
			this.cancelButton.Text = "&Cancel";
			this.cancelButton.Click += new System.EventHandler(this.CancelButtonClick);
			// 
			// snippetTextBox
			// 
			this.snippetTextBox.AcceptsReturn = true;
			this.snippetTextBox.AcceptsTab = true;
			this.snippetTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
						| System.Windows.Forms.AnchorStyles.Left) 
						| System.Windows.Forms.AnchorStyles.Right)));
			this.snippetTextBox.Location = new System.Drawing.Point(48, 43);
			this.snippetTextBox.Multiline = true;
			this.snippetTextBox.Name = "snippetTextBox";
			this.snippetTextBox.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.snippetTextBox.Size = new System.Drawing.Size(317, 96);
			this.snippetTextBox.TabIndex = 2;
			this.snippetTextBox.Text = "Contents of the snippet here.";
			// 
			// createButton
			// 
			this.createButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.createButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.createButton.Location = new System.Drawing.Point(290, 149);
			this.createButton.Name = "createButton";
			this.createButton.TabIndex = 4;
			this.createButton.Text = "Cr&eate";
			this.createButton.Click += new System.EventHandler(this.CreateButtonClick);
			// 
			// SnippetCreator
			// 
			this.AcceptButton = this.createButton;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.CancelButton = this.cancelButton;
			this.ClientSize = new System.Drawing.Size(375, 180);
			this.Controls.Add(this.valueLabel);
			this.Controls.Add(this.idLabel);
			this.Controls.Add(this.snippetTextBox);
			this.Controls.Add(this.cancelButton);
			this.Controls.Add(this.createButton);
			this.Controls.Add(this.snippetIdTextBox);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
			this.MinimumSize = new System.Drawing.Size(300, 200);
			this.Name = "SnippetCreator";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = " Create New Snippet";
			this.ResumeLayout(false);
		}
		#endregion
	
		#region MethodsAndEventHandlers
		
		public void CancelButtonClick(object sender, System.EventArgs e)
		{
			this.Close();
		}
		
		public void CreateButtonClick(object sender, System.EventArgs e)
		{
			ISettings snippets = this.pluginUI.Snippets;
			string key = this.snippetIdTextBox.Text;
			string eol = this.pluginUI.MainForm.GetNewLineMarker(0);
			string val = eol+this.snippetTextBox.Text+eol;
			if (snippets.HasKey(key))
			{
				ErrorHandler.ShowInfo("Snippets already contains the id.");
				return;
			}
			snippets.AddValue(key, val);
			snippets.SortByKey();
			snippets.Save();
			this.pluginUI.PopulateSnippetList();
			this.pluginUI.SelectItemById(key);
			this.Close();
		}
		
		#endregion
		
	}

}
