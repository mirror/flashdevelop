using System;
using System.Drawing;
using System.Windows.Forms;
using FlashDevelop.Utilities;
using PluginCore;

namespace FlashDevelop.Windows
{
	public class SettingAdder : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Button createButton;
		private System.Windows.Forms.Label valueLabel;
		private System.Windows.Forms.Label idLabel;
		private System.Windows.Forms.Button cancelButton;
		private System.Windows.Forms.TextBox valueTextBox;
		private System.Windows.Forms.TextBox idTextBox;
		private SettingsDlg settingsDlg;
		
		public SettingAdder(SettingsDlg settingsDlg)
		{
			this.settingsDlg = settingsDlg;
			this.InitializeComponent();
		}
		
		#region Windows Forms Designer generated code
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			this.idTextBox = new System.Windows.Forms.TextBox();
			this.valueTextBox = new System.Windows.Forms.TextBox();
			this.cancelButton = new System.Windows.Forms.Button();
			this.idLabel = new System.Windows.Forms.Label();
			this.valueLabel = new System.Windows.Forms.Label();
			this.createButton = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// idTextBox
			// 
			this.idTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
						| System.Windows.Forms.AnchorStyles.Left) 
						| System.Windows.Forms.AnchorStyles.Right)));
			this.idTextBox.Location = new System.Drawing.Point(49, 12);
			this.idTextBox.Name = "idTextBox";
			this.idTextBox.Size = new System.Drawing.Size(334, 20);
			this.idTextBox.TabIndex = 0;
			this.idTextBox.Text = "FlashDevelop.UserDefined.@SAMPLE";
			// 
			// valueTextBox
			// 
			this.valueTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
						| System.Windows.Forms.AnchorStyles.Left) 
						| System.Windows.Forms.AnchorStyles.Right)));
			this.valueTextBox.Location = new System.Drawing.Point(49, 44);
			this.valueTextBox.Multiline = true;
			this.valueTextBox.Name = "valueTextBox";
			this.valueTextBox.Size = new System.Drawing.Size(334, 102);
			this.valueTextBox.TabIndex = 1;
			this.valueTextBox.Text = "Contents of the setting";
			// 
			// cancelButton
			// 
			this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.cancelButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.cancelButton.Location = new System.Drawing.Point(224, 155);
			this.cancelButton.Name = "cancelButton";
			this.cancelButton.TabIndex = 3;
			this.cancelButton.Text = "&Cancel";
			this.cancelButton.Click += new System.EventHandler(this.CancelButtonClick);
			// 
			// idLabel
			// 
			this.idLabel.Location = new System.Drawing.Point(6, 15);
			this.idLabel.Name = "idLabel";
			this.idLabel.Size = new System.Drawing.Size(39, 15);
			this.idLabel.TabIndex = 4;
			this.idLabel.Text = "ID:";
			this.idLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
			// 
			// valueLabel
			// 
			this.valueLabel.Location = new System.Drawing.Point(5, 46);
			this.valueLabel.Name = "valueLabel";
			this.valueLabel.Size = new System.Drawing.Size(40, 15);
			this.valueLabel.TabIndex = 5;
			this.valueLabel.Text = "Value:";
			this.valueLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
			// 
			// createButton
			// 
			this.createButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.createButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.createButton.Location = new System.Drawing.Point(308, 155);
			this.createButton.Name = "createButton";
			this.createButton.TabIndex = 2;
			this.createButton.Text = "Cr&eate";
			this.createButton.Click += new System.EventHandler(this.CreateButtonClick);
			// 
			// SettingAdder
			// 
			this.AcceptButton = this.createButton;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.CancelButton = this.cancelButton;
			this.ClientSize = new System.Drawing.Size(392, 187);
			this.Controls.Add(this.valueLabel);
			this.Controls.Add(this.idLabel);
			this.Controls.Add(this.cancelButton);
			this.Controls.Add(this.createButton);
			this.Controls.Add(this.valueTextBox);
			this.Controls.Add(this.idTextBox);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.MinimumSize = new System.Drawing.Size(300, 200);
			this.Name = "SettingAdder";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = " Create New Setting";
			this.Load += new System.EventHandler(this.SettingAdderLoad);
			this.ResumeLayout(false);
		}
		#endregion
	
		#region MethodsAndEventHandlers
		
		public void SettingAdderLoad(object sender, System.EventArgs e)
		{
			// Do nothing..
		}
		
		public void CancelButtonClick(object sender, System.EventArgs e)
		{
			this.Close();
		}
		
		public void CreateButtonClick(object sender, System.EventArgs e)
		{
			string key = this.idTextBox.Text;
			string val = this.valueTextBox.Text;
			if (this.settingsDlg.MainForm.Settings.HasKey(key))
			{
				ErrorHandler.ShowInfo("The settings already contains the key.");
				return;
			}
			ListViewItem item = new ListViewItem(key);
			item.SubItems.Add(val);
			this.settingsDlg.SettingView.Items.Add(item);
			this.Close();
		}
		
		#endregion
		
	}
	
}
