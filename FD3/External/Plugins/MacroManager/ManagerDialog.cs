using System;
using System.Data;
using System.Text;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using PluginCore.Localization;
using PluginCore;

namespace MacroManager
{
    public class ManagerDialog : Form
    {
        private Label infoLabel;
        private ListView listView;
        private PictureBox pictureBox;
        private PropertyGrid propertyGrid;
        private ColumnHeader columnHeader;
        private ListViewGroup macroGroup;
        private PluginMain pluginMain;
        private Button deleteButton;
        private Button closeButton;
        private Button addButton;
    
        public ManagerDialog(PluginMain pluginMain)
        {
            this.pluginMain = pluginMain;
            this.Font = PluginBase.Settings.DefaultFont;
            this.InitializeComponent();
            this.InitializeItemGroups();
            this.ApplyLocalizedTexts();
            this.InitializeGraphics();
        }

        #region Windows Form Designer Generated Code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.propertyGrid = new System.Windows.Forms.PropertyGrid();
            this.listView = new System.Windows.Forms.ListView();
            this.addButton = new System.Windows.Forms.Button();
            this.deleteButton = new System.Windows.Forms.Button();
            this.closeButton = new System.Windows.Forms.Button();
            this.pictureBox = new System.Windows.Forms.PictureBox();
            this.columnHeader = new System.Windows.Forms.ColumnHeader();
            this.infoLabel = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox)).BeginInit();
            this.SuspendLayout();
            // 
            // propertyGrid
            // 
            this.propertyGrid.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.propertyGrid.HelpVisible = false;
            this.propertyGrid.Location = new System.Drawing.Point(182, 12);
            this.propertyGrid.Name = "propertyGrid";
            this.propertyGrid.Size = new System.Drawing.Size(355, 299);
            this.propertyGrid.TabIndex = 1;
            this.propertyGrid.ToolbarVisible = false;
            this.propertyGrid.PropertyValueChanged += new System.Windows.Forms.PropertyValueChangedEventHandler(this.PropertyValueChanged);
            // 
            // listView
            // 
            this.listView.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left)));
            this.listView.Location = new System.Drawing.Point(12, 12);
            this.listView.Name = "listView";
            this.listView.MultiSelect = false;
            this.listView.HideSelection = false;
            this.listView.View = System.Windows.Forms.View.Details;
            this.listView.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None;
            this.listView.Size = new System.Drawing.Size(160, 270);
            this.listView.TabIndex = 2;
            this.listView.UseCompatibleStateImageBehavior = false;
            this.listView.SelectedIndexChanged += new System.EventHandler(this.ListViewIndexChanged);
            this.listView.Columns.Add(this.columnHeader);
            // 
            // addButton
            // 
            this.addButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.addButton.Location = new System.Drawing.Point(11, 289);
            this.addButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.addButton.Name = "addButton";
            this.addButton.Size = new System.Drawing.Size(75, 23);
            this.addButton.TabIndex = 3;
            this.addButton.Text = "&Add";
            this.addButton.UseVisualStyleBackColor = true;
            this.addButton.Click += new System.EventHandler(this.AddButtonClick);
            // 
            // deleteButton
            // 
            this.deleteButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.deleteButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.deleteButton.Location = new System.Drawing.Point(97, 289);
            this.deleteButton.Name = "deleteButton";
            this.deleteButton.Size = new System.Drawing.Size(75, 23);
            this.deleteButton.TabIndex = 4;
            this.deleteButton.Text = "&Delete";
            this.deleteButton.UseVisualStyleBackColor = true;
            this.deleteButton.Click += new System.EventHandler(this.DeleteButtonClick);
            // 
            // closeButton
            // 
            this.closeButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.closeButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.closeButton.Location = new System.Drawing.Point(438, 319);
            this.closeButton.Name = "closeButton";
            this.closeButton.Size = new System.Drawing.Size(100, 23);
            this.closeButton.TabIndex = 5;
            this.closeButton.Text = "&Close";
            this.closeButton.UseVisualStyleBackColor = true;
            this.closeButton.Click += new System.EventHandler(this.CloseButtonClick);
            // 
            // pictureBox
            //
            this.pictureBox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.pictureBox.Location = new System.Drawing.Point(13, 324);
            this.pictureBox.Name = "pictureBox";
            this.pictureBox.Size = new System.Drawing.Size(16, 16);
            this.pictureBox.TabIndex = 6;
            this.pictureBox.TabStop = false;
            // 
            // infoLabel
            // 
            this.infoLabel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.infoLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.infoLabel.AutoSize = true;
            this.infoLabel.Location = new System.Drawing.Point(34, 325);
            this.infoLabel.Name = "infoLabel";
            this.infoLabel.Size = new System.Drawing.Size(358, 20);
            this.infoLabel.TabIndex = 7;
            this.infoLabel.Text = "Macros will take effect soon as you edit them successfully.";
            // 
            // ManagerDialog
            //
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.AcceptButton = this.closeButton;
            this.CancelButton = this.closeButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(549, 353);
            this.Controls.Add(this.infoLabel);
            this.Controls.Add(this.pictureBox);
            this.Controls.Add(this.closeButton);
            this.Controls.Add(this.deleteButton);
            this.Controls.Add(this.addButton);
            this.Controls.Add(this.listView);
            this.Controls.Add(this.propertyGrid);
            this.Name = "ManagerDialog";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.Load += new System.EventHandler(this.DialogLoad);
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.DialogClosed);
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Text = "Macros";
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        #region Methods And Event Handlers

        /// <summary>
        /// Initializes the graphics used in the control
        /// </summary>
        private void InitializeGraphics()
        {
            ImageList imageList = new ImageList();
            imageList.ColorDepth = ColorDepth.Depth32Bit;
            imageList.Images.Add(PluginBase.MainForm.FindImage("338|13|0|0"));
            this.pictureBox.Image = PluginBase.MainForm.FindImage("229");
            this.listView.SmallImageList = imageList;
            this.columnHeader.Width = -2;
        }

        /// <summary>
        /// Initializes the list view item groups
        /// </summary>
        private void InitializeItemGroups()
        {
            this.macroGroup = new ListViewGroup("Macros", HorizontalAlignment.Left);
            this.listView.Groups.Add(this.macroGroup);
        }

        /// <summary>
        /// Applies the localized texts to the form
        /// </summary>
        private void ApplyLocalizedTexts()
        {
            this.Text = " Macros";
        }

        /// <summary>
        /// Loads the macro list from settings
        /// </summary>
        private void LoadUserMacros()
        {
            List<Macro> macros = this.pluginMain.Macros;
            this.PopulateMacroList(macros);
        }

        /// <summary>
        /// Saves the macro list to settings
        /// </summary>
        private void SaveUserMacros()
        {
            List<Macro> macros = new List<Macro>();
            foreach (ListViewItem item in this.listView.Items)
            {
                Macro macro = item.Tag as Macro;
                macros.Add(macro);
            }
            this.pluginMain.Macros = macros;
        }

        /// <summary>
        /// Populates the macro list
        /// </summary>
        private void PopulateMacroList(List<Macro> macros)
        {
            this.listView.Items.Clear();
            foreach (Macro macro in macros)
            {
                ListViewItem item = new ListViewItem(macro.Label, 0);
                item.Tag = macro;
                this.macroGroup.Items.Add(item);
                this.listView.Items.Add(item);
            }
            if (this.listView.Items.Count > 0)
            {
                ListViewItem item = this.listView.Items[0];
                item.Selected = true;
            }
        }

        /// <summary>
        /// Adds a new empty macro to the list
        /// </summary>
        private void AddButtonClick(Object sender, EventArgs e)
        {
            ListViewItem item = new ListViewItem("Untitled", 0);
            item.Tag = new Macro("Untitled", new string[0], Keys.None);
            this.macroGroup.Items.Add(item);
            this.listView.Items.Add(item);
        }

        /// <summary>
        /// Deletes the delected macro from the list
        /// </summary>
        private void DeleteButtonClick(Object sender, EventArgs e)
        {
            ListViewItem item = this.listView.SelectedItems[0];
            Int32 previousIndex = item.Index - 1;
            this.listView.Items.Remove(item);
            if (this.listView.Items.Count > 0)
            {
                if (previousIndex >= 0 && previousIndex <= this.listView.Items.Count - 1)
                {
                    item = this.listView.Items[previousIndex];
                    item.Selected = true;
                }
                else
                {
                    item = this.listView.Items[0];
                    item.Selected = true;
                }
            }
        }

        /// <summary>
        /// Activates correct macros and controls
        /// </summary>
        private void ListViewIndexChanged(Object sender, EventArgs e)
        {
            if (this.listView.SelectedIndices.Count > 0)
            {
                ListViewItem item = this.listView.SelectedItems[0];
                this.propertyGrid.SelectedObject = item.Tag;
                this.deleteButton.Enabled = true;
            }
            else
            {
                this.propertyGrid.SelectedObject = null;
                this.deleteButton.Enabled = false;
            }
        }

        /// <summary>
        /// Updates the label of the selected macro
        /// </summary>
        private void PropertyValueChanged(Object sender, PropertyValueChangedEventArgs e)
        {
            if (this.listView.SelectedIndices.Count > 0)
            {
                ListViewItem item = this.listView.SelectedItems[0];
                item.Text = ((Macro)item.Tag).Label;
            }
        }

        /// <summary>
        /// Closes the macro editoe dialog
        /// </summary>
        private void CloseButtonClick(Object sender, EventArgs e)
        {
            this.Close();
        }

        /// <summary>
        /// Loads the macros from the settings
        /// </summary>
        private void DialogLoad(Object sender, EventArgs e)
        {
            this.LoadUserMacros();
        }

        /// <summary>
        /// Saves the macros when the dialog is closed
        /// </summary>
        private void DialogClosed(Object sender, FormClosedEventArgs e)
        {
            this.SaveUserMacros();
            this.pluginMain.RefreshMacroMenuItems();
        }

        /// <summary>
        /// Shows the macro editing dialog
        /// </summary>
        public static void Show(PluginMain pluginMain)
        {
            ManagerDialog managerDialog = new ManagerDialog(pluginMain);
            managerDialog.ShowDialog();
        }

        #endregion

    }

}
