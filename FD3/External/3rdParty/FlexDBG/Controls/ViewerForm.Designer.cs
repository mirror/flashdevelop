/*
    Copyright (C) 2009  Robert Nelson

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/

namespace FlexDbg.Controls
{
    partial class ViewerForm
    {
        /// <summary>
        /// 
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 
        /// </summary>
        /// <param name="disposing"></param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows

        /// <summary>
        /// </summary>
        private void InitializeComponent()
        {
            this.ExptextBox = new System.Windows.Forms.TextBox();
            this.ValuetextBox = new System.Windows.Forms.TextBox();
            this.WordWrapcheckBox = new System.Windows.Forms.CheckBox();
            this.Closebutton = new System.Windows.Forms.Button();
            this.CopyExpbutton = new System.Windows.Forms.Button();
            this.CopyValuebutton = new System.Windows.Forms.Button();
            this.CopyAllbutton = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // ExptextBox
            // 
            this.ExptextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.ExptextBox.Location = new System.Drawing.Point(0, 26);
            this.ExptextBox.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.ExptextBox.Name = "ExptextBox";
            this.ExptextBox.ReadOnly = true;
            this.ExptextBox.Size = new System.Drawing.Size(328, 22);
            this.ExptextBox.TabIndex = 0;
            // 
            // ValuetextBox
            // 
            this.ValuetextBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.ValuetextBox.Location = new System.Drawing.Point(0, 91);
            this.ValuetextBox.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.ValuetextBox.Multiline = true;
            this.ValuetextBox.Name = "ValuetextBox";
            this.ValuetextBox.ReadOnly = true;
            this.ValuetextBox.Size = new System.Drawing.Size(328, 314);
            this.ValuetextBox.TabIndex = 1;
            this.ValuetextBox.WordWrap = false;
            // 
            // WordWrapcheckBox
            // 
            this.WordWrapcheckBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.WordWrapcheckBox.AutoSize = true;
            this.WordWrapcheckBox.Location = new System.Drawing.Point(0, 419);
            this.WordWrapcheckBox.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.WordWrapcheckBox.Name = "WordWrapcheckBox";
            this.WordWrapcheckBox.Size = new System.Drawing.Size(87, 19);
            this.WordWrapcheckBox.TabIndex = 2;
            this.WordWrapcheckBox.Text = "WordWrap";
            this.WordWrapcheckBox.UseVisualStyleBackColor = true;
            this.WordWrapcheckBox.CheckedChanged += new System.EventHandler(this.WordWrapcheckBox_CheckedChanged);
            // 
            // Closebutton
            // 
            this.Closebutton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.Closebutton.Location = new System.Drawing.Point(341, 379);
            this.Closebutton.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.Closebutton.Name = "Closebutton";
            this.Closebutton.Size = new System.Drawing.Size(96, 28);
            this.Closebutton.TabIndex = 3;
            this.Closebutton.Text = "Close";
            this.Closebutton.UseVisualStyleBackColor = true;
            this.Closebutton.Click += new System.EventHandler(this.Closebutton_Click);
            // 
            // CopyExpbutton
            // 
            this.CopyExpbutton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.CopyExpbutton.Location = new System.Drawing.Point(341, 26);
            this.CopyExpbutton.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.CopyExpbutton.Name = "CopyExpbutton";
            this.CopyExpbutton.Size = new System.Drawing.Size(96, 28);
            this.CopyExpbutton.TabIndex = 4;
            this.CopyExpbutton.Text = "Copy Exp";
            this.CopyExpbutton.UseVisualStyleBackColor = true;
            this.CopyExpbutton.Click += new System.EventHandler(this.CopyExpbutton_Click);
            // 
            // CopyValuebutton
            // 
            this.CopyValuebutton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.CopyValuebutton.Location = new System.Drawing.Point(341, 62);
            this.CopyValuebutton.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.CopyValuebutton.Name = "CopyValuebutton";
            this.CopyValuebutton.Size = new System.Drawing.Size(96, 28);
            this.CopyValuebutton.TabIndex = 5;
            this.CopyValuebutton.Text = "Copy Value";
            this.CopyValuebutton.UseVisualStyleBackColor = true;
            this.CopyValuebutton.Click += new System.EventHandler(this.CopyValuebutton_Click);
            // 
            // CopyAllbutton
            // 
            this.CopyAllbutton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.CopyAllbutton.Location = new System.Drawing.Point(341, 98);
            this.CopyAllbutton.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.CopyAllbutton.Name = "CopyAllbutton";
            this.CopyAllbutton.Size = new System.Drawing.Size(96, 28);
            this.CopyAllbutton.TabIndex = 6;
            this.CopyAllbutton.Text = "Copy All";
            this.CopyAllbutton.UseVisualStyleBackColor = true;
            this.CopyAllbutton.Click += new System.EventHandler(this.CopyAllbutton_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(4, 8);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(29, 15);
            this.label1.TabIndex = 7;
            this.label1.Text = "Exp";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(4, 70);
            this.label2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(42, 15);
            this.label2.TabIndex = 8;
            this.label2.Text = "Value";
            // 
            // ViewerForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(453, 440);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.CopyAllbutton);
            this.Controls.Add(this.CopyValuebutton);
            this.Controls.Add(this.CopyExpbutton);
            this.Controls.Add(this.Closebutton);
            this.Controls.Add(this.WordWrapcheckBox);
            this.Controls.Add(this.ValuetextBox);
            this.Controls.Add(this.ExptextBox);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
            this.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.Name = "ViewerForm";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.Text = "ViewerForm";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.ViewerForm_FormClosing);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox ExptextBox;
        private System.Windows.Forms.TextBox ValuetextBox;
        private System.Windows.Forms.CheckBox WordWrapcheckBox;
        private System.Windows.Forms.Button Closebutton;
        private System.Windows.Forms.Button CopyExpbutton;
        private System.Windows.Forms.Button CopyValuebutton;
        private System.Windows.Forms.Button CopyAllbutton;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
    }
}
