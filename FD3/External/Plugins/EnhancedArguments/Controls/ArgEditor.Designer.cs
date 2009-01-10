namespace EnhancedArguments.Controls
{
	partial class ArgEditor
	{
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
			this.arg = new System.Windows.Forms.Label();
			this.argValue = new System.Windows.Forms.ComboBox();
			this.SuspendLayout();
			// 
			// arg
			// 
			this.arg.Dock = System.Windows.Forms.DockStyle.Left;
			this.arg.Location = new System.Drawing.Point(0, 0);
			this.arg.Margin = new System.Windows.Forms.Padding(0);
			this.arg.Name = "arg";
			this.arg.Size = new System.Drawing.Size(65, 22);
			this.arg.TabIndex = 0;
			this.arg.Text = "Arg";
			this.arg.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
			// 
			// argValue
			// 
			this.argValue.Font = new System.Drawing.Font("Courier New", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.argValue.FormattingEnabled = true;
			this.argValue.Location = new System.Drawing.Point(68, 0);
			this.argValue.Margin = new System.Windows.Forms.Padding(0, 0, 3, 0);
			this.argValue.Name = "argValue";
			this.argValue.Size = new System.Drawing.Size(125, 22);
			this.argValue.TabIndex = 1;
			// 
			// ArgEditor
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.AutoSize = true;
			this.Controls.Add(this.argValue);
			this.Controls.Add(this.arg);
			this.Margin = new System.Windows.Forms.Padding(2);
			this.Name = "ArgEditor";
			this.Size = new System.Drawing.Size(200, 22);
			this.ResumeLayout(false);

		}

		#endregion

        private System.Windows.Forms.Label arg;
        private System.Windows.Forms.ComboBox argValue;
	}
}
