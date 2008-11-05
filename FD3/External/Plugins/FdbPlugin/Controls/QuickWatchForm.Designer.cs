namespace FdbPlugin.Controls
{
    partial class QuickWatchForm
    {
        /// <summary>
        /// 必要なデザイナ変数です。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 使用中のリソースをすべてクリーンアップします。
        /// </summary>
        /// <param name="disposing">マネージ リソースが破棄される場合 true、破棄されない場合は false です。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows フォーム デザイナで生成されたコード

        /// <summary>
        /// デザイナ サポートに必要なメソッドです。このメソッドの内容を
        /// コード エディタで変更しないでください。
        /// </summary>
        private void InitializeComponent()
        {
            this.InputPanel = new System.Windows.Forms.Panel();
            this.EvaluateButton = new System.Windows.Forms.Button();
            this.ExpTextBox = new System.Windows.Forms.TextBox();
            this.TreePanel = new System.Windows.Forms.Panel();
            this.CloseButton = new System.Windows.Forms.Button();
            this.InputPanel.SuspendLayout();
            this.SuspendLayout();
            // 
            // InputPanel
            // 
            this.InputPanel.Controls.Add(this.EvaluateButton);
            this.InputPanel.Controls.Add(this.ExpTextBox);
            this.InputPanel.Dock = System.Windows.Forms.DockStyle.Top;
            this.InputPanel.Location = new System.Drawing.Point(0, 0);
            this.InputPanel.Name = "InputPanel";
            this.InputPanel.Size = new System.Drawing.Size(288, 47);
            this.InputPanel.TabIndex = 0;
            // 
            // EvaluateButton
            // 
            this.EvaluateButton.Location = new System.Drawing.Point(222, 22);
            this.EvaluateButton.Name = "EvaluateButton";
            this.EvaluateButton.Size = new System.Drawing.Size(63, 22);
            this.EvaluateButton.TabIndex = 1;
            this.EvaluateButton.Text = "Evaluate";
            this.EvaluateButton.UseVisualStyleBackColor = true;
            // 
            // ExpTextBox
            // 
            this.ExpTextBox.AcceptsTab = true;
            this.ExpTextBox.Location = new System.Drawing.Point(0, 22);
            this.ExpTextBox.Name = "ExpTextBox";
            this.ExpTextBox.Size = new System.Drawing.Size(217, 19);
            this.ExpTextBox.TabIndex = 0;
            // 
            // TreePanel
            // 
            this.TreePanel.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.TreePanel.AutoScroll = true;
            this.TreePanel.Location = new System.Drawing.Point(0, 50);
            this.TreePanel.Name = "TreePanel";
            this.TreePanel.Size = new System.Drawing.Size(288, 271);
            this.TreePanel.TabIndex = 1;
            // 
            // CloseButton
            // 
            this.CloseButton.Location = new System.Drawing.Point(211, 327);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(77, 22);
            this.CloseButton.TabIndex = 2;
            this.CloseButton.Text = "Close";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // QuickWatchForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(288, 350);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.TreePanel);
            this.Controls.Add(this.InputPanel);
            this.Name = "QuickWatchForm";
            this.Text = "QuickWatchForm";
            this.InputPanel.ResumeLayout(false);
            this.InputPanel.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel InputPanel;
        private System.Windows.Forms.Panel TreePanel;
        private System.Windows.Forms.TextBox ExpTextBox;
        private System.Windows.Forms.Button EvaluateButton;
        private System.Windows.Forms.Button CloseButton;
    }
}
