using System;
using System.Data;
using System.Text;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using PluginCore.Localization;
using FlashDevelop.Utilities;
using FlashDevelop.Dialogs;
using FlashDevelop.Helpers;
using PluginCore;

namespace FlashDevelop.Dialogs
{
    public class SettingDialog : Form
    {
        private System.String helpUrl;
        private System.Windows.Forms.ListView itemListView;
        private System.Windows.Forms.PictureBox infoPictureBox;
        private System.Windows.Forms.PropertyGrid itemPropertyGrid;
        private System.Windows.Forms.ListViewGroup pluginsGroup;
        private System.Windows.Forms.ListViewGroup mainGroup;
        private System.Windows.Forms.CheckBox disableCheckBox;
        private System.Windows.Forms.LinkLabel helpLabel;
        private System.Windows.Forms.Button closeButton;
        private System.Windows.Forms.Label nameLabel;
        private System.Windows.Forms.Label infoLabel;
        private System.Windows.Forms.Label descLabel;

        public SettingDialog(String itemName)
        {
            this.Owner = Globals.MainForm;
            this.Font = Globals.Settings.DefaultFont;
            this.InitializeComponent();
            this.InitializeGraphics(); 
            this.InitializeItemGroups();
            this.PopulatePluginList(itemName);
            this.ApplyLocalizedTexts();
        }

        #region Windows Form Designer Generated Code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.itemListView = new System.Windows.Forms.ListView();
            this.itemPropertyGrid = new System.Windows.Forms.PropertyGrid();
            this.closeButton = new System.Windows.Forms.Button();
            this.nameLabel = new System.Windows.Forms.Label();
            this.infoPictureBox = new System.Windows.Forms.PictureBox();
            this.infoLabel = new System.Windows.Forms.Label();
            this.descLabel = new System.Windows.Forms.Label();
            this.disableCheckBox = new System.Windows.Forms.CheckBox();
            this.helpLabel = new System.Windows.Forms.LinkLabel();
            ((System.ComponentModel.ISupportInitialize)(this.infoPictureBox)).BeginInit();
            this.SuspendLayout();
            // 
            // itemListView
            // 
            this.itemListView.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left)));
            this.itemListView.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None;
            this.itemListView.HideSelection = false;
            this.itemListView.Location = new System.Drawing.Point(12, 12);
            this.itemListView.MultiSelect = false;
            this.itemListView.Name = "itemListView";
            this.itemListView.Size = new System.Drawing.Size(159, 394);
            this.itemListView.TabIndex = 1;
            this.itemListView.UseCompatibleStateImageBehavior = false;
            this.itemListView.View = System.Windows.Forms.View.SmallIcon;
            this.itemListView.SelectedIndexChanged += new System.EventHandler(this.ItemListViewSelectedIndexChanged);
            // 
            // itemPropertyGrid
            // 
            this.itemPropertyGrid.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.itemPropertyGrid.Location = new System.Drawing.Point(183, 54);
            this.itemPropertyGrid.Name = "itemPropertyGrid";
            this.itemPropertyGrid.Size = new System.Drawing.Size(472, 352);
            this.itemPropertyGrid.TabIndex = 3;
            this.itemPropertyGrid.ToolbarVisible = false;
            // 
            // closeButton
            // 
            this.closeButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.closeButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.closeButton.Location = new System.Drawing.Point(556, 413);
            this.closeButton.Name = "closeButton";
            this.closeButton.Size = new System.Drawing.Size(100, 23);
            this.closeButton.TabIndex = 4;
            this.closeButton.Text = "&Close";
            this.closeButton.UseVisualStyleBackColor = true;
            this.closeButton.Click += new System.EventHandler(this.CloseButtonClick);
            // 
            // nameLabel
            // 
            this.nameLabel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.nameLabel.AutoSize = true;
            this.nameLabel.Enabled = false;
            this.nameLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.nameLabel.Location = new System.Drawing.Point(185, 11);
            this.nameLabel.Name = "nameLabel";
            this.nameLabel.Size = new System.Drawing.Size(111, 13);
            this.nameLabel.TabIndex = 0;
            this.nameLabel.Text = "(no item selected)";
            // 
            // infoPictureBox
            //
            this.infoPictureBox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.infoPictureBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.infoPictureBox.Location = new System.Drawing.Point(13, 417);
            this.infoPictureBox.Name = "infoPictureBox";
            this.infoPictureBox.Size = new System.Drawing.Size(16, 16);
            this.infoPictureBox.TabIndex = 5;
            this.infoPictureBox.TabStop = false;
            // 
            // infoLabel
            // 
            this.infoLabel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.infoLabel.AutoSize = true;
            this.infoLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.infoLabel.Location = new System.Drawing.Point(34, 418);
            this.infoLabel.Name = "infoLabel";
            this.infoLabel.Size = new System.Drawing.Size(501, 13);
            this.infoLabel.TabIndex = 0;
            this.infoLabel.Text = "Settings will take effect as soon as you edit them successfully but some may require a program restart.";
            // 
            // descLabel
            // 
            this.descLabel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.descLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.descLabel.Location = new System.Drawing.Point(185, 31);
            this.descLabel.Name = "descLabel";
            this.descLabel.Size = new System.Drawing.Size(470, 13);
            this.descLabel.TabIndex = 6;
            this.descLabel.Text = "Adds a plugin panel to FlashDevelop.";
            // 
            // disableCheckBox
            // 
            this.disableCheckBox.AutoSize = true;
            this.disableCheckBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.disableCheckBox.Location = new System.Drawing.Point(305, 9);
            this.disableCheckBox.Name = "disableCheckBox";
            this.disableCheckBox.Size = new System.Drawing.Size(69, 18);
            this.disableCheckBox.TabIndex = 7;
            this.disableCheckBox.Text = " Disable";
            this.disableCheckBox.UseVisualStyleBackColor = true;
            this.disableCheckBox.Click += new System.EventHandler(this.DisableCheckBoxCheck);
            // 
            // helpLabel
            //
            this.helpLabel.AutoSize = true;
            this.helpLabel.Location = new System.Drawing.Point(369, 11);
            this.helpLabel.Name = "helpLabel";
            this.helpLabel.Size = new System.Drawing.Size(28, 13);
            this.helpLabel.TabIndex = 9;
            this.helpLabel.TabStop = true;
            this.helpLabel.Text = "Help";
            this.helpLabel.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.HelpLabelClick);
            // 
            // SettingDialog
            // 
            this.AcceptButton = this.closeButton;
            this.CancelButton = this.closeButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(667, 448);
            this.Controls.Add(this.helpLabel);
            this.Controls.Add(this.disableCheckBox);
            this.Controls.Add(this.descLabel);
            this.Controls.Add(this.infoPictureBox);
            this.Controls.Add(this.nameLabel);
            this.Controls.Add(this.closeButton);
            this.Controls.Add(this.itemPropertyGrid);
            this.Controls.Add(this.itemListView);
            this.Controls.Add(this.infoLabel);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.MinimumSize = new System.Drawing.Size(490, 350);
            this.Name = "SettingDialog";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = " Settings";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.DialogClosed);
            ((System.ComponentModel.ISupportInitialize)(this.infoPictureBox)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        #region Methods And Event Handlers

        /// <summary>
        /// Initializes the external graphics
        /// </summary>
        private void InitializeGraphics()
        {
            ImageList imageList = new ImageList();
            imageList.ColorDepth = ColorDepth.Depth32Bit;
            imageList.Images.Add(Globals.MainForm.FindImage("341"));
            imageList.Images.Add(Globals.MainForm.FindImage("342"));
            imageList.Images.Add(Globals.MainForm.FindImage("50"));
            this.itemListView.SmallImageList = imageList;
            this.infoPictureBox.Image = Globals.MainForm.FindImage("229");
        }

        /// <summary>
        /// Applies the localized texts to the form
        /// </summary>
        private void ApplyLocalizedTexts()
        {
            this.helpLabel.Text = TextHelper.GetString("Info.Help");
            this.Text = " " + TextHelper.GetString("Title.SettingDialog");
            this.disableCheckBox.Text = " " + TextHelper.GetString("Info.Disable");
            this.infoLabel.Text = TextHelper.GetString("Info.SettingsTakeEffect");
            this.nameLabel.Text = TextHelper.GetString("Info.NoItemSelected");
            this.closeButton.Text = TextHelper.GetString("Label.Close");
            this.nameLabel.Font = new Font(this.Font, FontStyle.Bold);
        }

        /// <summary>
        /// Initializes the setting object groups
        /// </summary>
        private void InitializeItemGroups()
        {
            String mainHeader = TextHelper.GetString("Group.Main");
            String pluginsHeader = TextHelper.GetString("Group.Plugins");
            this.mainGroup = new ListViewGroup(mainHeader, HorizontalAlignment.Left);
            this.pluginsGroup = new ListViewGroup(pluginsHeader, HorizontalAlignment.Left);
            this.itemListView.Groups.Add(this.mainGroup);
            this.itemListView.Groups.Add(this.pluginsGroup);
        }

        /// <summary>
        /// Populates the plugin list
        /// </summary>
        private void PopulatePluginList(String itemName)
        {
            this.itemListView.Items.Clear();
            Int32 count = PluginServices.AvailablePlugins.Count;
            ListViewItem main = new ListViewItem("FlashDevelop", 2);
            this.itemListView.Items.Add(main);
            this.mainGroup.Items.Add(main);
            for (Int32 i = 0; i < count; i++)
            {
                AvailablePlugin plugin = PluginServices.AvailablePlugins[i];
                ListViewItem item = new ListViewItem(plugin.Instance.Name, 0);
                if (Globals.Settings.DisabledPlugins.Contains(plugin.Instance.Guid))
                {
                    item.ImageIndex = 1;
                }
                this.itemListView.Items.Add(item);
                this.pluginsGroup.Items.Add(item);
            }
            this.SelectCorrectItem(itemName);
        }

        /// <summary>
        /// Selects the correct setting item
        /// </summary>
        private void SelectCorrectItem(String itemName)
        {
            for (Int32 i = 0; i < this.itemListView.Items.Count; i++)
            {
                ListViewItem item = this.itemListView.Items[i];
                if (item.Text == itemName)
                {
                    item.Selected = true;
                    return;
                }
            }
        }

        /// <summary>
        /// Shows the selected plugin in the prop grid
        /// </summary>
        private void ItemListViewSelectedIndexChanged(Object sender, EventArgs e)
        {
            if (this.itemListView.SelectedIndices.Count > 0)
            {
                Int32 selectedIndex = this.itemListView.SelectedIndices[0];
                if (selectedIndex == 0)
                {
                    this.itemPropertyGrid.Enabled = true;
                    this.itemPropertyGrid.SelectedObject = Globals.Settings;
                    this.descLabel.Text = TextHelper.GetString("Info.AppDescription");
                    this.helpUrl = "http://www.flashdevelop.org/wikidocs/";
                    this.nameLabel.Text = "FlashDevelop";
                    this.nameLabel.Enabled = true;
                    this.ShowInfoControls(false);
                }
                else
                {
                    IPlugin plugin = PluginServices.AvailablePlugins[selectedIndex - 1].Instance;
                    this.disableCheckBox.Checked = Globals.Settings.DisabledPlugins.Contains(plugin.Guid);
                    this.itemPropertyGrid.SelectedObject = plugin.Settings;
                    this.itemPropertyGrid.Enabled = plugin.Settings != null;
                    this.descLabel.Text = plugin.Description;
                    this.nameLabel.Text = plugin.Name;
                    this.nameLabel.Enabled = true;
                    this.helpUrl = plugin.Help;
                    this.ShowInfoControls(true);
                    this.MoveInfoControls();
                }
            }
            else
            {
                this.nameLabel.Enabled = false;
                this.descLabel.Text = String.Empty;
                this.nameLabel.Text = TextHelper.GetString("Info.NoItemSelected");
                this.itemPropertyGrid.SelectedObject = null;
                this.itemPropertyGrid.Enabled = false;
                this.ShowInfoControls(false);
            }
        }

        /// <summary>
        /// Moves the info controls to correct position
        /// </summary>
        private void MoveInfoControls()
        {
            Int32 dcbY = this.disableCheckBox.Location.Y;
            Int32 dcbX = this.nameLabel.Location.X + this.nameLabel.Width + 13;
            Int32 hlX = dcbX + this.disableCheckBox.Width;
            Int32 hlY = this.helpLabel.Location.Y;
            this.disableCheckBox.Location = new Point(dcbX, dcbY);
            this.helpLabel.Location = new Point(hlX, hlY);
        }

        /// <summary>
        /// Shows or hides the info controls
        /// </summary>
        private void ShowInfoControls(Boolean value)
        {
            this.disableCheckBox.Visible = value;
            this.helpLabel.Visible = value;
        }

        /// <summary>
        /// Toggles the enabled state and saves it to settings
        /// </summary>
        private void DisableCheckBoxCheck(Object sender, EventArgs e)
        {
            Int32 selectedIndex = this.itemListView.SelectedIndices[0];
            if (selectedIndex != 0)
            {
                IPlugin plugin = PluginServices.AvailablePlugins[selectedIndex - 1].Instance;
                if (this.disableCheckBox.Checked)
                {
                    this.itemListView.Items[selectedIndex].ImageIndex = 1;
                    Globals.Settings.DisabledPlugins.Add(plugin.Guid);
                }
                else
                {
                    this.itemListView.Items[selectedIndex].ImageIndex = 0;
                    Globals.Settings.DisabledPlugins.Remove(plugin.Guid);
                }
            }
        }

        /// <summary>
        /// When the form is closed applies settings
        /// </summary>
        private void DialogClosed(Object sender, FormClosedEventArgs e)
        {
            Globals.MainForm.ApplyAllSettings();
        }

        /// <summary>
        /// Browses to the specified help url
        /// </summary>
        private void HelpLabelClick(Object sender, LinkLabelLinkClickedEventArgs e)
        {
            if (this.helpUrl != null)
            {
                Globals.MainForm.CallCommand("Browse", this.helpUrl);
            }
        }

        /// <summary>
        /// Closes the setting dialog
        /// </summary>
        private void CloseButtonClick(Object sender, EventArgs e)
        {
            this.Close();
        }

        /// <summary>
        /// Shows the settings dialog
        /// </summary>
        public static void Show(String itemName)
        {
            SettingDialog settingDialog = new SettingDialog(itemName);
            settingDialog.closeButton.Select();
            settingDialog.ShowDialog();
        }

        #endregion

    }

}