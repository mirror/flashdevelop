namespace FdbPlugin.Controls
{
    partial class DataTreeControl
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
            this._tree = new Aga.Controls.Tree.TreeViewAdv();
            this.NametreeColumn = new Aga.Controls.Tree.TreeColumn();
            this.ValuetreeColumn = new Aga.Controls.Tree.TreeColumn();
            this.NamenodeTextBox = new Aga.Controls.Tree.NodeControls.NodeTextBox();
            this.ValuenodeTextBox = new Aga.Controls.Tree.NodeControls.NodeTextBox();
            this.SuspendLayout();
            // 
            // _tree
            //
            this._tree.UseColumns = true;
            this._tree.BackColor = System.Drawing.SystemColors.Window;
            this._tree.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this._tree.Columns.Add(this.NametreeColumn);
            this._tree.Columns.Add(this.ValuetreeColumn);
            this._tree.DefaultToolTipProvider = null;
            this._tree.Dock = System.Windows.Forms.DockStyle.Fill;
            this._tree.DragDropMarkColor = System.Drawing.Color.Black;
            this._tree.GridLineStyle = Aga.Controls.Tree.GridLineStyle.HorizontalAndVertical;
            this._tree.LineColor = System.Drawing.SystemColors.Control;
            this._tree.Location = new System.Drawing.Point(0, 0);
            this._tree.Model = null;
            this._tree.Name = "_tree";
            this._tree.NodeControls.Add(this.NamenodeTextBox);
            this._tree.NodeControls.Add(this.ValuenodeTextBox);
            this._tree.SelectedNode = null;
            this._tree.ShowNodeToolTips = true;
            this._tree.Size = new System.Drawing.Size(282, 155);
            this._tree.TabIndex = 0;
            this._tree.Text = "treeViewAdv1";
            this._tree.UseColumns = true;
            // 
            // NametreeColumn
            // 
            this.NametreeColumn.Header = "Name";
            this.NametreeColumn.SortOrder = System.Windows.Forms.SortOrder.None;
            this.NametreeColumn.TooltipText = null;
            this.NametreeColumn.Width = 100;
            // 
            // ValuetreeColumn
            // 
            this.ValuetreeColumn.Header = "Value";
            this.ValuetreeColumn.SortOrder = System.Windows.Forms.SortOrder.None;
            this.ValuetreeColumn.TooltipText = null;
            this.ValuetreeColumn.Width = 100;
            // 
            // NamenodeTextBox
            // 
            this.NamenodeTextBox.DataPropertyName = "Text";
            this.NamenodeTextBox.IncrementalSearchEnabled = true;
            this.NamenodeTextBox.LeftMargin = 3;
            this.NamenodeTextBox.ParentColumn = this.NametreeColumn;
            // 
            // ValuenodeTextBox
            // 
            this.ValuenodeTextBox.DataPropertyName = "Value";
            this.ValuenodeTextBox.IncrementalSearchEnabled = true;
            this.ValuenodeTextBox.LeftMargin = 3;
            this.ValuenodeTextBox.ParentColumn = this.ValuetreeColumn;
            // 
            // DataTreeControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this._tree);
            this.Name = "DataTreeControl";
            this.Size = new System.Drawing.Size(282, 155);
            this.ResumeLayout(false);

        }

        #endregion

        private Aga.Controls.Tree.TreeViewAdv _tree;
        private Aga.Controls.Tree.TreeColumn NametreeColumn;
        private Aga.Controls.Tree.TreeColumn ValuetreeColumn;
        private Aga.Controls.Tree.NodeControls.NodeTextBox NamenodeTextBox;
        private Aga.Controls.Tree.NodeControls.NodeTextBox ValuenodeTextBox;
    }
}
