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
            this.tabControl = new System.Windows.Forms.TabControl();
            this.liveObjectsPage = new System.Windows.Forms.TabPage();
            this.objectsPage = new System.Windows.Forms.TabPage();
            this.listView = new AS3Context.Controls.ListViewXP();
            this.typeColumn = new System.Windows.Forms.ColumnHeader();
            this.pkgColumn = new System.Windows.Forms.ColumnHeader();
            this.maxColumn = new System.Windows.Forms.ColumnHeader();
            this.countColumn = new System.Windows.Forms.ColumnHeader();
            this.memColumn = new System.Windows.Forms.ColumnHeader();
            this.toolStrip.SuspendLayout();
            this.tabControl.SuspendLayout();
            this.liveObjectsPage.SuspendLayout();
            this.SuspendLayout();
            // 
            // toolStrip
            // 
            this.toolStrip.CanOverflow = false;
            this.toolStrip.GripStyle = System.Windows.Forms.ToolStripGripStyle.Hidden;
            this.toolStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.memLabel,
            this.runButton,
            this.gcButton});
            this.toolStrip.Location = new System.Drawing.Point(1, 0);
            this.toolStrip.Name = "toolStrip";
            this.toolStrip.Padding = new System.Windows.Forms.Padding(1, 0, 1, 0);
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
            // tabControl
            // 
            this.tabControl.Controls.Add(this.liveObjectsPage);
            this.tabControl.Controls.Add(this.objectsPage);
            this.tabControl.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl.Location = new System.Drawing.Point(1, 25);
            this.tabControl.Name = "tabControl";
            this.tabControl.SelectedIndex = 0;
            this.tabControl.Size = new System.Drawing.Size(488, 339);
            this.tabControl.TabIndex = 2;
            // 
            // liveObjectsPage
            // 
            this.liveObjectsPage.Controls.Add(this.listView);
            this.liveObjectsPage.Location = new System.Drawing.Point(4, 22);
            this.liveObjectsPage.Name = "liveObjectsPage";
            this.liveObjectsPage.Padding = new System.Windows.Forms.Padding(3);
            this.liveObjectsPage.Size = new System.Drawing.Size(480, 313);
            this.liveObjectsPage.TabIndex = 0;
            this.liveObjectsPage.Text = "Live Objects Count";
            this.liveObjectsPage.UseVisualStyleBackColor = true;
            // 
            // snapshotPage
            // 
            this.objectsPage.Location = new System.Drawing.Point(4, 22);
            this.objectsPage.Name = "objectsPage";
            this.objectsPage.Padding = new System.Windows.Forms.Padding(3);
            this.objectsPage.Size = new System.Drawing.Size(480, 313);
            this.objectsPage.TabIndex = 1;
            this.objectsPage.Text = "Objects";
            this.objectsPage.UseVisualStyleBackColor = true;
            // 
            // listView
            // 
            this.listView.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.listView.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.typeColumn,
            this.pkgColumn,
            this.maxColumn,
            this.countColumn,
            this.memColumn});
            this.listView.Dock = System.Windows.Forms.DockStyle.Fill;
            this.listView.FullRowSelect = true;
            this.listView.GridLines = true;
            this.listView.HideSelection = false;
            this.listView.Location = new System.Drawing.Point(3, 3);
            this.listView.MultiSelect = false;
            this.listView.Name = "listView";
            this.listView.Size = new System.Drawing.Size(474, 307);
            this.listView.Sorting = System.Windows.Forms.SortOrder.Ascending;
            this.listView.TabIndex = 2;
            this.listView.UseCompatibleStateImageBehavior = false;
            this.listView.View = System.Windows.Forms.View.Details;
            // 
            // typeColumn
            // 
            this.typeColumn.Text = "Type";
            this.typeColumn.Width = 200;
            // 
            // pkgColumn
            // 
            this.pkgColumn.Text = "Package";
            this.pkgColumn.Width = 250;
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
            this.Controls.Add(this.tabControl);
            this.Controls.Add(this.toolStrip);
            this.Name = "ProfilerUI";
            this.Size = new System.Drawing.Size(490, 364);
            this.toolStrip.ResumeLayout(false);
            this.toolStrip.PerformLayout();
            this.tabControl.ResumeLayout(false);
            this.liveObjectsPage.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ToolStrip toolStrip;
        private System.Windows.Forms.ToolStripLabel memLabel;
        private System.Windows.Forms.ToolStripButton runButton;
        private System.Windows.Forms.ToolStripButton gcButton;
        private System.Windows.Forms.TabControl tabControl;
        private System.Windows.Forms.TabPage liveObjectsPage;
        private System.Windows.Forms.TabPage objectsPage;
        private ListViewXP listView;
        private System.Windows.Forms.ColumnHeader typeColumn;
        private System.Windows.Forms.ColumnHeader pkgColumn;
        private System.Windows.Forms.ColumnHeader maxColumn;
        private System.Windows.Forms.ColumnHeader countColumn;
        private System.Windows.Forms.ColumnHeader memColumn;
    }
}
