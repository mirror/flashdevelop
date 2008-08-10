using System;
using System.Drawing;
using System.Windows.Forms;
using System.Diagnostics;
using PluginCore;

namespace FlashDevelop.Windows
{
	public class AboutDialog : System.Windows.Forms.Form
	{
		private System.Windows.Forms.GroupBox detailsBox;
		private System.Windows.Forms.TextBox buildBox;
		private System.Windows.Forms.TextBox versionBox;
		private System.Windows.Forms.Label copyLabel;
		private System.Windows.Forms.Label buildLabel;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.PictureBox imageBox;
		private System.Windows.Forms.Label versionLabel;
		private System.Windows.Forms.Button okButton;
		private FlashDevelop.MainForm mainForm;

		public AboutDialog(MainForm mainForm)
		{
			this.mainForm = mainForm;
			this.InitializeComponent();
			this.imageBox.Image = ((System.Drawing.Image)(mainForm.Resources.GetObject("Images.AboutBox")));
		}

		#region Windows Forms Designer generated code

		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		public void InitializeComponent() {
			this.okButton = new System.Windows.Forms.Button();
			this.versionLabel = new System.Windows.Forms.Label();
			this.imageBox = new System.Windows.Forms.PictureBox();
			this.label1 = new System.Windows.Forms.Label();
			this.buildLabel = new System.Windows.Forms.Label();
			this.copyLabel = new System.Windows.Forms.Label();
			this.versionBox = new System.Windows.Forms.TextBox();
			this.buildBox = new System.Windows.Forms.TextBox();
			this.detailsBox = new System.Windows.Forms.GroupBox();
			this.detailsBox.SuspendLayout();
			this.SuspendLayout();
			// 
			// okButton
			// 
			this.okButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.okButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.okButton.Location = new System.Drawing.Point(320, 200);
			this.okButton.Name = "okButton";
			this.okButton.Size = new System.Drawing.Size(72, 23);
			this.okButton.TabIndex = 0;
			this.okButton.Text = "&OK";
			this.okButton.Click += new System.EventHandler(this.OkButtonClick);
			// 
			// versionLabel
			// 
			this.versionLabel.Font = new System.Drawing.Font("Tahoma", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.World);
			this.versionLabel.Location = new System.Drawing.Point(16, 24);
			this.versionLabel.Name = "versionLabel";
			this.versionLabel.Size = new System.Drawing.Size(48, 16);
			this.versionLabel.TabIndex = 2;
			this.versionLabel.Text = "Version";
			// 
			// imageBox
			// 
			this.imageBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.imageBox.Location = new System.Drawing.Point(8, 8);
			this.imageBox.Name = "imageBox";
			this.imageBox.Size = new System.Drawing.Size(386, 114);
			this.imageBox.TabIndex = 3;
			this.imageBox.TabStop = false;
			// 
			// label1
			// 
			this.label1.ForeColor = System.Drawing.SystemColors.ControlDarkDark;
			this.label1.Location = new System.Drawing.Point(16, 68);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(272, 16);
			this.label1.TabIndex = 7;
			this.label1.Text = "Devs: Mika Palmu, Philippe Elsass and Nick Farina";
			// 
			// buildLabel
			// 
			this.buildLabel.Location = new System.Drawing.Point(142, 24);
			this.buildLabel.Name = "buildLabel";
			this.buildLabel.Size = new System.Drawing.Size(32, 16);
			this.buildLabel.TabIndex = 4;
			this.buildLabel.Text = "Build";
			// 
			// copyLabel
			// 
			this.copyLabel.Location = new System.Drawing.Point(16, 52);
			this.copyLabel.Name = "copyLabel";
			this.copyLabel.Size = new System.Drawing.Size(240, 16);
			this.copyLabel.TabIndex = 6;
			this.copyLabel.Text = "Copyright (c) Mika Palmu - FlashDevelop.org";
			// 
			// versionBox
			// 
			this.versionBox.Location = new System.Drawing.Point(60, 21);
			this.versionBox.Name = "versionBox";
			this.versionBox.ReadOnly = true;
			this.versionBox.Size = new System.Drawing.Size(72, 21);
			this.versionBox.TabIndex = 3;
			this.versionBox.Text = "";
			// 
			// buildBox
			// 
			this.buildBox.Location = new System.Drawing.Point(174, 21);
			this.buildBox.Name = "buildBox";
			this.buildBox.ReadOnly = true;
			this.buildBox.Size = new System.Drawing.Size(72, 21);
			this.buildBox.TabIndex = 5;
			this.buildBox.Text = "";
			// 
			// detailsBox
			// 
			this.detailsBox.Controls.Add(this.label1);
			this.detailsBox.Controls.Add(this.buildLabel);
			this.detailsBox.Controls.Add(this.buildBox);
			this.detailsBox.Controls.Add(this.versionBox);
			this.detailsBox.Controls.Add(this.versionLabel);
			this.detailsBox.Controls.Add(this.copyLabel);
			this.detailsBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.detailsBox.Location = new System.Drawing.Point(8, 127);
			this.detailsBox.Name = "detailsBox";
			this.detailsBox.Size = new System.Drawing.Size(304, 96);
			this.detailsBox.TabIndex = 1;
			this.detailsBox.TabStop = false;
			this.detailsBox.Text = " Details";
			// 
			// AboutDialog
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.CancelButton = this.okButton;
			this.ClientSize = new System.Drawing.Size(402, 232);
			this.Controls.Add(this.imageBox);
			this.Controls.Add(this.detailsBox);
			this.Controls.Add(this.okButton);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "AboutDialog";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = " About FlashDevelop";
			this.Load += new System.EventHandler(this.AboutDialogLoad);
			this.detailsBox.ResumeLayout(false);
			this.ResumeLayout(false);
		}

		#endregion

		#region MethodsAndEventHandlers
		
		/**
		* Parses the version data for display
		*/
		public void AboutDialogLoad(object sender, System.EventArgs e)
		{
			string[] version = Application.ProductName.Split('.');
			this.versionBox.Text = " "+version[1]+"."+version[2]+"."+version[3];
			this.buildBox.Text = " "+version[4];
		}
		
		/**
		* Closes the about dialog
		*/
		public void OkButtonClick(object sender, System.EventArgs e)
		{
			this.Close();
		}
		
		#endregion

	}
	
}
