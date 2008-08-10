using System;
using System.Drawing;
using System.Windows.Forms;
using PluginCore;

namespace FlashDevelop.Windows
{
	public class GoToDialog : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Button lineButton;
		private System.Windows.Forms.Button cancelButton;
		private System.Windows.Forms.Label valueLabel;
		private System.Windows.Forms.Button positionButton;
		private System.Windows.Forms.TextBox lineTextBox;
		private FlashDevelop.MainForm mainForm;
		
		public GoToDialog(MainForm mainForm)
		{
			this.mainForm = mainForm;
			this.InitializeComponent();
		}
		
		#region Windows Forms Designer generated code
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			this.lineTextBox = new System.Windows.Forms.TextBox();
			this.positionButton = new System.Windows.Forms.Button();
			this.valueLabel = new System.Windows.Forms.Label();
			this.cancelButton = new System.Windows.Forms.Button();
			this.lineButton = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// lineTextBox
			// 
			this.lineTextBox.Location = new System.Drawing.Point(52, 10);
			this.lineTextBox.Name = "lineTextBox";
			this.lineTextBox.Size = new System.Drawing.Size(150, 21);
			this.lineTextBox.TabIndex = 1;
			this.lineTextBox.Text = "";
			// 
			// positionButton
			// 
			this.positionButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.positionButton.Location = new System.Drawing.Point(77, 39);
			this.positionButton.Name = "positionButton";
			this.positionButton.Size = new System.Drawing.Size(59, 23);
			this.positionButton.TabIndex = 3;
			this.positionButton.Text = "&Position";
			this.positionButton.Click += new System.EventHandler(this.PositionButtonClick);
			// 
			// valueLabel
			// 
			this.valueLabel.Location = new System.Drawing.Point(13, 13);
			this.valueLabel.Name = "valueLabel";
			this.valueLabel.Size = new System.Drawing.Size(36, 15);
			this.valueLabel.TabIndex = 0;
			this.valueLabel.Text = "Value:";
			// 
			// cancelButton
			// 
			this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.cancelButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.cancelButton.Location = new System.Drawing.Point(14, 39);
			this.cancelButton.Name = "cancelButton";
			this.cancelButton.Size = new System.Drawing.Size(53, 23);
			this.cancelButton.TabIndex = 2;
			this.cancelButton.Text = "&Cancel";
			this.cancelButton.Click += new System.EventHandler(this.CancelButtonClick);
			// 
			// lineButton
			// 
			this.lineButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.lineButton.Location = new System.Drawing.Point(147, 39);
			this.lineButton.Name = "lineButton";
			this.lineButton.Size = new System.Drawing.Size(55, 23);
			this.lineButton.TabIndex = 4;
			this.lineButton.Text = "&Line";
			this.lineButton.Click += new System.EventHandler(this.LineButtonClick);
			// 
			// GoToDialog
			// 
			this.AcceptButton = this.lineButton;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.CancelButton = this.cancelButton;
			this.ClientSize = new System.Drawing.Size(216, 71);
			this.Controls.Add(this.valueLabel);
			this.Controls.Add(this.lineButton);
			this.Controls.Add(this.positionButton);
			this.Controls.Add(this.cancelButton);
			this.Controls.Add(this.lineTextBox);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "GoToDialog";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = " Goto";
			this.Closing += new System.ComponentModel.CancelEventHandler(this.GoToDialogClosing);
			this.VisibleChanged += new System.EventHandler(this.OnVisibleChanged);
			this.ResumeLayout(false);
		}
		#endregion
		
		#region MethodsAndEventHandlers
		
		/**
		* Some event handling when showing the form
		*/
		public void OnVisibleChanged(object sender, System.EventArgs e)
		{
			if (this.Visible)
			{
				this.GotoDialogLoad();
			}
		}
		
		/**
		* Selects the textfield
		*/
		public void GotoDialogLoad()
		{
			this.lineTextBox.Select();
			this.lineTextBox.SelectAll();
		}
		
		/**
		* Moves the cursor to the specified line
		*/
		public void LineButtonClick(object sender, System.EventArgs e)
		{
			try 
			{
				int line = Convert.ToInt32(this.lineTextBox.Text)-1;
				this.mainForm.CurSciControl.GotoLine(line);
				this.Close();
			} 
			catch 
			{
				ErrorHandler.ShowInfo("Give a proper value.");
			}
		}
		
		/**
		* Moves the cursor to the specified position
		*/
		public void PositionButtonClick(object sender, System.EventArgs e)
		{
			try
			{
				int pos = Convert.ToInt32(this.lineTextBox.Text)-1;
				this.mainForm.CurSciControl.GotoPos(pos);
				this.Close();
			} 
			catch
			{
				ErrorHandler.ShowInfo("Give a proper value.");
			}
		}
		
		/**
		* Closes the goto dialog
		*/
		public void CancelButtonClick(object sender, System.EventArgs e)
		{
			this.Close();
		}
		
		/**
		* Hides only the dialog when user closes it
		*/
		private void GoToDialogClosing(object sender, System.ComponentModel.CancelEventArgs e)
		{
			e.Cancel = true;
			this.mainForm.Focus(); this.Hide();
			this.mainForm.CurSciControl.Focus();
		}
		
		#endregion
		
	}
	
}
