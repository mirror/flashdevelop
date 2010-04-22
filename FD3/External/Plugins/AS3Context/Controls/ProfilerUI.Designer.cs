namespace AS3Context.Controls
{
    partial class ProfilerUI
    {
        /// <summary> 
        /// Variable nécessaire au concepteur.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Nettoyage des ressources utilisées.
        /// </summary>
        /// <param name="disposing">true si les ressources managées doivent être supprimées ; sinon, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Code généré par le Concepteur de composants

        /// <summary> 
        /// Méthode requise pour la prise en charge du concepteur - ne modifiez pas 
        /// le contenu de cette méthode avec l'éditeur de code.
        /// </summary>
        private void InitializeComponent()
        {
            this.toolStrip = new System.Windows.Forms.ToolStrip();
            this.memLabel = new System.Windows.Forms.ToolStripLabel();
            this.runButton = new System.Windows.Forms.ToolStripButton();
            this.gcButton = new System.Windows.Forms.ToolStripButton();
            this.listView = new System.Windows.Forms.ListView();
            this.typeColumn = new System.Windows.Forms.ColumnHeader();
            this.pkgColumn = new System.Windows.Forms.ColumnHeader();
            this.maxColumn = new System.Windows.Forms.ColumnHeader();
            this.countColumn = new System.Windows.Forms.ColumnHeader();
            this.memColumn = new System.Windows.Forms.ColumnHeader();
            this.toolStrip.SuspendLayout();
            this.SuspendLayout();
            // 
            // toolStrip1
            // 
            this.toolStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.memLabel,
            this.runButton,
            this.gcButton});
            this.toolStrip.Location = new System.Drawing.Point(1, 0);
            this.toolStrip.Name = "toolStrip";
            this.toolStrip.Size = new System.Drawing.Size(488, 25);
            this.toolStrip.TabIndex = 0;
            // 
            // memLabel
            // 
            this.memLabel.Alignment = System.Windows.Forms.ToolStripItemAlignment.Right;
            this.memLabel.Name = "memLabel";
            this.memLabel.Size = new System.Drawing.Size(64, 22);
            this.memLabel.Text = "Memory: 0";
            // 
            // runButton
            // 
            this.runButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.runButton.Name = "runButton";
            this.runButton.Size = new System.Drawing.Size(23, 22);
            this.runButton.Text = "Start Profiler";
            this.runButton.Click += new System.EventHandler(this.runButton_Click);
            // 
            // gcButton
            // 
            this.gcButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.gcButton.Name = "gcButton";
            this.gcButton.Size = new System.Drawing.Size(23, 22);
            this.gcButton.Text = "Run Garbage Collector";
            this.gcButton.Click += new System.EventHandler(this.gcButton_Click);
            // 
            // listView
            // 
            this.listView.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.typeColumn,
            this.pkgColumn,
            this.maxColumn,
            this.countColumn,
            this.memColumn});
            this.listView.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.listView.Dock = System.Windows.Forms.DockStyle.Fill;
            this.listView.FullRowSelect = true;
            this.listView.GridLines = true;
            this.listView.HideSelection = false;
            this.listView.Location = new System.Drawing.Point(1, 25);
            this.listView.MultiSelect = false;
            this.listView.Name = "listView";
            this.listView.Size = new System.Drawing.Size(488, 339);
            this.listView.Sorting = System.Windows.Forms.SortOrder.Ascending;
            this.listView.TabIndex = 1;
            this.listView.UseCompatibleStateImageBehavior = false;
            this.listView.View = System.Windows.Forms.View.Details;
            this.listView.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.listView_ColumnClick);
            // 
            // typeColumn
            // 
            this.typeColumn.Text = "Type";
            this.typeColumn.Width = 200;
            // 
            // pkgColumn
            // 
            this.pkgColumn.Text = "Package";
            this.pkgColumn.Width = 200;
            // 
            // maxColumn
            // 
            this.maxColumn.Text = "Maximum";
            this.maxColumn.Width = 80;
            // 
            // countColumn
            // 
            this.countColumn.Text = "Count";
            this.countColumn.Width = 80;
            // 
            // memColumn
            // 
            this.memColumn.Text = "Memory";
            this.memColumn.Width = 80;
            // 
            // ProfilerUI
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.listView);
            this.Controls.Add(this.toolStrip);
            this.Name = "ProfilerUI";
            this.Size = new System.Drawing.Size(490, 364);
            this.toolStrip.ResumeLayout(false);
            this.toolStrip.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ToolStrip toolStrip;
        private System.Windows.Forms.ListView listView;
        private System.Windows.Forms.ColumnHeader typeColumn;
        private System.Windows.Forms.ColumnHeader countColumn;
        private System.Windows.Forms.ColumnHeader maxColumn;
        private System.Windows.Forms.ToolStripLabel memLabel;
        private System.Windows.Forms.ToolStripButton runButton;
        private System.Windows.Forms.ToolStripButton gcButton;
        private System.Windows.Forms.ColumnHeader memColumn;
        private System.Windows.Forms.ColumnHeader pkgColumn;
    }
}
