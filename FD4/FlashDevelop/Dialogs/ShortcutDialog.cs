using System;
using System.Data;
using System.Text;
using System.Drawing;
using System.Collections;
using System.Windows.Forms;
using FlashDevelop.Managers;
using System.Text.RegularExpressions;
using PluginCore.Localization;
using PluginCore.Controls;
using PluginCore.Utilities;
using System.Collections.Generic;
using PluginCore.Managers;

namespace FlashDevelop.Dialogs
{
    public class ShortcutDialog : SmartForm
    {
        private System.Windows.Forms.Label infoLabel;
        private System.Windows.Forms.ListView listView;
        private System.Windows.Forms.PictureBox pictureBox;
        private System.Windows.Forms.ColumnHeader idHeader;
        private System.Windows.Forms.ColumnHeader keyHeader;
        private System.Windows.Forms.Button closeButton;
    
        public ShortcutDialog()
        {
            this.Owner = Globals.MainForm;
            this.Font = Globals.Settings.DefaultFont;
            this.FormGuid = "d7837615-77ac-425e-80cd-65515d130913";
            this.InitializeComponent();
            this.InitializeContextMenu();
            this.ApplyLocalizedTexts();
            this.InitializeGraphics();
            this.PopulateListView();
        }

        #region Windows Form Designer Generated Code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.listView = new System.Windows.Forms.ListView();
            this.idHeader = new System.Windows.Forms.ColumnHeader();
            this.keyHeader = new System.Windows.Forms.ColumnHeader();
            this.closeButton = new System.Windows.Forms.Button();
            this.pictureBox = new System.Windows.Forms.PictureBox();
            this.infoLabel = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox)).BeginInit();
            this.SuspendLayout();
            // 
            // idHeader
            // 
            this.idHeader.Text = "Command";
            this.idHeader.Width = 350;
            // 
            // keyHeader
            // 
            this.keyHeader.Text = "Shortcut";
            this.keyHeader.Width = 208;
            // 
            // listView
            //
            this.listView.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.listView.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {this.idHeader, this.keyHeader});
            this.listView.GridLines = true;
            this.listView.FullRowSelect = true;
            this.listView.Location = new System.Drawing.Point(12, 12);
            this.listView.MultiSelect = false;
            this.listView.Name = "listView";
            this.listView.Size = new System.Drawing.Size(562, 363);
            this.listView.TabIndex = 1;
            this.listView.UseCompatibleStateImageBehavior = false;
            this.listView.View = System.Windows.Forms.View.Details;
            this.listView.KeyDown += new KeyEventHandler(this.ListViewKeyDown);
            // 
            // closeButton
            // 
            this.closeButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.closeButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.closeButton.Location = new System.Drawing.Point(485, 381);
            this.closeButton.Name = "closeButton";
            this.closeButton.Size = new System.Drawing.Size(90, 23);
            this.closeButton.TabIndex = 0;
            this.closeButton.Text = "Close";
            this.closeButton.UseVisualStyleBackColor = true;
            this.closeButton.Click += new System.EventHandler(this.CloseButtonClick);
            // 
            // pictureBox
            // 
            this.pictureBox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.pictureBox.Location = new System.Drawing.Point(12, 385);
            this.pictureBox.Name = "pictureBox";
            this.pictureBox.Size = new System.Drawing.Size(16, 16);
            this.pictureBox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox.TabIndex = 2;
            this.pictureBox.TabStop = false;
            // 
            // infoLabel
            // 
            this.infoLabel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.infoLabel.Location = new System.Drawing.Point(33, 386);
            this.infoLabel.Name = "infoLabel";
            this.infoLabel.Size = new System.Drawing.Size(446, 16);
            this.infoLabel.TabIndex = 3;
            this.infoLabel.Text = "Shortcuts can be edited by selecting an item and pressing valid menu item shortcut keys.";
            // 
            // ShortcutDialog
            // 
            this.ShowIcon = false;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.ShowInTaskbar = false;
            this.Text = " Shortcuts";
            this.Name = "ShortcutDialog";
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(586, 416);
            this.Controls.Add(this.infoLabel);
            this.Controls.Add(this.pictureBox);
            this.Controls.Add(this.closeButton);
            this.Controls.Add(this.listView);
            this.FormClosed += new FormClosedEventHandler(this.DialogClosed);
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Show;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox)).EndInit();
            this.ResumeLayout(false);
        }

        #endregion

        #region Methods And Event Handlers

        /// <summary>
        /// Initializes the graphics
        /// </summary>
        private void InitializeGraphics()
        {
            this.pictureBox.Image = Globals.MainForm.FindImage("229");
        }

        /// <summary>
        /// Initializes the ListView context menu
        /// </summary>
        private void InitializeContextMenu()
        {
            ContextMenuStrip cms = new ContextMenuStrip();
            cms.Font = Globals.Settings.DefaultFont;
            cms.Renderer = new DockPanelStripRenderer(false);
            cms.Items.Add(TextHelper.GetString("Label.RemoveShortcut"), null, this.RemoveShortcutClick);
            cms.Items.Add(TextHelper.GetString("Label.RevertToDefault"), null, this.RevertToDefaultClick);
            this.listView.ContextMenuStrip = cms;
        }

        /// <summary>
        /// Applies the localized texts to the form
        /// </summary>
        private void ApplyLocalizedTexts()
        {
            this.idHeader.Text = TextHelper.GetString("Label.Command");
            this.keyHeader.Text = TextHelper.GetString("Label.Shortcut");
            this.infoLabel.Text = TextHelper.GetString("Info.ShortcutEditInfo");
            this.closeButton.Text = TextHelper.GetString("Label.Close");
            this.Text = " " + TextHelper.GetString("Title.Shortcuts");
        }

        /// <summary>
        /// Gets the keys as a string
        /// </summary>
        private String GetKeysAsString(Keys keys)
        {
            return DataConverter.KeysToString(keys);
        }

        /// <summary>
        /// Validates if the shortcut is valid item shortcut
        /// </summary>
        private Boolean IsValidShortcut(Keys keys)
        {
            try
            {
                ToolStripMenuItem tmp = new ToolStripMenuItem();
                tmp.ShortcutKeys = keys;
                return true;
            }
            catch { return false; }
        }

        /// <summary>
        /// Updates the font highlight of the item
        /// </summary>
        private void UpdateItemHighlightFont(ListViewItem lvi, ShortcutItem si)
        {
            Font def = Globals.Settings.DefaultFont;
            if (si.Default != si.Custom) lvi.Font = new Font(def, FontStyle.Bold);
            else lvi.Font = new Font(def, FontStyle.Regular);
        }

        /// <summary>
        /// Populates the shortcut list view
        /// </summary>
        private void PopulateListView()
        {
            this.listView.BeginUpdate();
            this.listView.Items.Clear();
            this.listView.ListViewItemSorter = new ListViewComparer();
            foreach (ShortcutItem item in ShortcutManager.RegistedItems)
            {
                if (!this.listView.Items.ContainsKey(item.Id))
                {
                    ListViewItem lvi = new ListViewItem();
                    lvi.Text = lvi.Name = item.Id; lvi.Tag = item;
                    lvi.SubItems.Add(GetKeysAsString(item.Custom));
                    this.UpdateItemHighlightFont(lvi, item);
                    this.listView.Items.Add(lvi);
                }
            }
            this.listView.Sort();
            this.keyHeader.Width = -2;
            this.listView.EndUpdate();
            if (this.listView.Items.Count > 0)
            {
                ListViewItem item = this.listView.Items[0];
                item.Selected = true;
            }
        }

        /// <summary>
        /// Assign a new valid shortcut when keys are pressed
        /// </summary>
        private void ListViewKeyDown(Object sender, KeyEventArgs e)
        {
            if (this.listView.SelectedItems.Count > 0)
            {
                ListViewItem selected = this.listView.SelectedItems[0];
                ShortcutItem item = selected.Tag as ShortcutItem;
                if (item.Custom != e.KeyData && this.IsValidShortcut(e.KeyData))
                {
                    selected.SubItems[1].Text = GetKeysAsString(e.KeyData);
                    item.Custom = e.KeyData; selected.Selected = true;
                    this.UpdateItemHighlightFont(selected, item);
                    if (this.CountItemsByKey(e.KeyData) > 1)
                    {
                        String message = TextHelper.GetString("Info.ShortcutIsAlreadyUsed");
                        ErrorManager.ShowWarning(message, null);
                    }
                }
            }
        }

        /// <summary>
        /// Gets the count of items with the specified keys
        /// </summary>
        private Int32 CountItemsByKey(Keys keys)
        {
            Int32 counter = 0;
            foreach (ListViewItem item in this.listView.Items)
            {
                ShortcutItem si = item.Tag as ShortcutItem;
                if (si.Custom == keys) counter++;
            }
            return counter;
        }

        /// <summary>
        /// Reverts the shortcut to default value
        /// </summary>
        private void RevertToDefaultClick(Object sender, EventArgs e)
        {
            if (this.listView.SelectedItems.Count > 0)
            {
                ListViewItem selected = this.listView.SelectedItems[0];
                ShortcutItem item = selected.Tag as ShortcutItem;
                selected.SubItems[1].Text = GetKeysAsString(item.Default);
                item.Custom = item.Default;
                this.UpdateItemHighlightFont(selected, item);
            }
        }

        /// <summary>
        /// Removes the shortcut by setting it to Keys.None
        /// </summary>
        private void RemoveShortcutClick(Object sender, EventArgs e)
        {
            if (this.listView.SelectedItems.Count > 0)
            {
                ListViewItem selected = this.listView.SelectedItems[0];
                ShortcutItem item = selected.Tag as ShortcutItem;
                selected.SubItems[1].Text = GetKeysAsString(Keys.None);
                item.Custom = Keys.None;
                this.UpdateItemHighlightFont(selected, item);
            }
        }

        /// <summary>
        /// Closes the shortcut dialog
        /// </summary>
        private void CloseButtonClick(Object sender, EventArgs e)
        {
            this.Close();
        }

        /// <summary>
        /// When the form is closed, applies shortcuts
        /// </summary>
        private void DialogClosed(Object sender, FormClosedEventArgs e)
        {
            Globals.MainForm.ApplyAllSettings();
        }

        /// <summary>
        /// Shows the shortcut dialog
        /// </summary>
        public static new void Show()
        {
            ShortcutDialog shortcutDialog = new ShortcutDialog();
            shortcutDialog.CenterToParent();
            shortcutDialog.Show(Globals.MainForm);
        }

        #endregion

    }

    #region ListViewComparer

    class ListViewComparer : IComparer
    {
        public Int32 Compare(Object x, Object y)
        {
            ListViewItem castX = x as ListViewItem;
            ListViewItem castY = y as ListViewItem;
            return StringComparer.Ordinal.Compare(castX.Text, castY.Text);
        }
    }

    #endregion

}
