using System;
using System.Drawing;
using System.Windows.Forms;

namespace FlashDevelop.Windows
{
	public class ValueChanger : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Button changeButton;
		private System.Windows.Forms.TextBox valueBox;
		private System.Windows.Forms.Button cancelButton;
		private System.Windows.Forms.Label valueLabel;
		private SettingsDlg settingsDlg;
		private ListViewItem item;

		public ValueChanger(SettingsDlg settingsDlg, ListViewItem item)
		{
			this.InitializeComponent();
			this.settingsDlg = settingsDlg;
			this.valueBox.Text = item.SubItems[1].Text;
			this.item = item;
		}

		#region Windows Forms Designer generated code
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			this.valueLabel = new System.Windows.Forms.Label();
			this.cancelButton = new System.Windows.Forms.Button();
			this.valueBox = new System.Windows.Forms.TextBox();
			this.changeButton = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// valueLabel
			// 
			this.valueLabel.Location = new System.Drawing.Point(9, 13);
			this.valueLabel.Name = "valueLabel";
			this.valueLabel.Size = new System.Drawing.Size(36, 12);
			this.valueLabel.TabIndex = 0;
			this.valueLabel.Text = "Value:";
			// 
			// cancelButton
			// 
			this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.cancelButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.cancelButton.Location = new System.Drawing.Point(48, 40);
			this.cancelButton.Name = "cancelButton";
			this.cancelButton.TabIndex = 2;
			this.cancelButton.Text = "&Cancel";
			this.cancelButton.Click += new System.EventHandler(this.CancelButtonClick);
			// 
			// valueBox
			// 
			this.valueBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
						| System.Windows.Forms.AnchorStyles.Left) 
						| System.Windows.Forms.AnchorStyles.Right)));
			this.valueBox.Location = new System.Drawing.Point(48, 10);
			this.valueBox.Name = "valueBox";
			this.valueBox.Size = new System.Drawing.Size(198, 20);
			this.valueBox.TabIndex = 1;
			this.valueBox.Text = "";
			// 
			// changeButton
			// 
			this.changeButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.changeButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.changeButton.Location = new System.Drawing.Point(128, 40);
			this.changeButton.Name = "changeButton";
			this.changeButton.TabIndex = 3;
			this.changeButton.Text = "C&hange";
			this.changeButton.Click += new System.EventHandler(this.ChangeButtonClick);
			// 
			// ValueChanger
			// 
			this.AcceptButton = this.changeButton;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.CancelButton = this.cancelButton;
			this.ClientSize = new System.Drawing.Size(256, 76);
			this.Controls.Add(this.cancelButton);
			this.Controls.Add(this.valueLabel);
			this.Controls.Add(this.changeButton);
			this.Controls.Add(this.valueBox);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.MinimumSize = new System.Drawing.Size(264, 100);
			this.Name = "ValueChanger";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = " Change Value";
			this.Resize += new System.EventHandler(this.ValueChangerResize);
			this.ResumeLayout(false);
		}
		#endregion

		#region MethodsAndEventHandlers

		/**
		* Adapts valueBox textfield from single line to multiline
		*/
		public void ValueChangerResize(object sender, System.EventArgs e)
		{
			int h = cancelButton.Top - valueBox.Top-10;
			if (h < 40) 
			{
				valueBox.WordWrap = false;
				valueBox.Multiline = false;
				valueBox.Height = 21;
			}
			else 
			{
				valueBox.WordWrap = true;
				valueBox.Multiline = true;
				valueBox.Height = h;
			}
		}
		
		/**
		* Changes the specified value and closes the dialog
		*/
		public void ChangeButtonClick(object sender, System.EventArgs e)
		{
			this.item.SubItems[1].Text = this.valueBox.Text;
			this.Close();
		}
		
		/**
		* Closes the ValueChanges dialog
		*/
		public void CancelButtonClick(object sender, System.EventArgs e)
		{
			this.Close();
		}
		
		#endregion

	}
	
}
