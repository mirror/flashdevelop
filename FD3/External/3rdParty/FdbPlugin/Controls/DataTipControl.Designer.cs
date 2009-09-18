namespace FdbPlugin.Controls
{
    partial class DataTipControl
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

        #region コンポーネント デザイナで生成されたコード

        /// <summary> 
        /// デザイナ サポートに必要なメソッドです。このメソッドの内容を 
        /// コード エディタで変更しないでください。
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(DataTipControl));
            this.panel1 = new System.Windows.Forms.Panel();
            this.ResizepictureBox = new System.Windows.Forms.PictureBox();
            this.dataTreeControl = new FdbPlugin.Controls.DataTreeControl();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ResizepictureBox)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.SystemColors.Control;
            this.panel1.Controls.Add(this.ResizepictureBox);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel1.Location = new System.Drawing.Point(0, 183);
            this.panel1.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(206, 21);
            this.panel1.TabIndex = 1;
            // 
            // ResizepictureBox
            // 
            this.ResizepictureBox.BackColor = System.Drawing.SystemColors.Control;
            this.ResizepictureBox.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("ResizepictureBox.BackgroundImage")));
            this.ResizepictureBox.Dock = System.Windows.Forms.DockStyle.Right;
            this.ResizepictureBox.InitialImage = null;
            this.ResizepictureBox.Location = new System.Drawing.Point(185, 0);
            this.ResizepictureBox.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.ResizepictureBox.Name = "ResizepictureBox";
            this.ResizepictureBox.Size = new System.Drawing.Size(21, 21);
            this.ResizepictureBox.TabIndex = 0;
            this.ResizepictureBox.TabStop = false;
            // 
            // dataTreeControl
            // 
            this.dataTreeControl.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataTreeControl.Location = new System.Drawing.Point(0, 0);
            this.dataTreeControl.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.dataTreeControl.Name = "dataTreeControl";
            this.dataTreeControl.Size = new System.Drawing.Size(206, 183);
            this.dataTreeControl.TabIndex = 2;
            // 
            // DataTipControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.dataTreeControl);
            this.Controls.Add(this.panel1);
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.Name = "DataTipControl";
            this.Size = new System.Drawing.Size(206, 204);
            this.panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ResizepictureBox)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private DataTreeControl dataTreeControl;
        private System.Windows.Forms.Panel panel1;
        public System.Windows.Forms.PictureBox ResizepictureBox;
    }
}
