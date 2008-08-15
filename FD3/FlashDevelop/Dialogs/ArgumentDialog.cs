using System;
using System.Data;
using System.Text;
using System.Drawing;
using System.ComponentModel;
using System.Windows.Forms;
using System.Collections.Generic;
using PluginCore.Localization;
using FlashDevelop.Settings;
using PluginCore.Utilities;
using PluginCore;

namespace FlashDevelop.Dialogs
{
    public class ArgumentDialog : Form
    {
        private System.Windows.Forms.Label keyLabel;
        private System.Windows.Forms.Label infoLabel;
        private System.Windows.Forms.Label valueLabel;
        private System.Windows.Forms.TextBox keyTextBox;
        private System.Windows.Forms.TextBox valueTextBox;
        private System.Windows.Forms.ListView argsListView;
        private System.Windows.Forms.ListViewGroup argumentGroup;
        private System.Windows.Forms.PictureBox infoPictureBox;
        private System.Windows.Forms.GroupBox detailsGroupBox;
        private System.Windows.Forms.Button deleteButton;
        private System.Windows.Forms.Button closeButton;
        private System.Windows.Forms.Button addButton;

        public ArgumentDialog()
        {
            this.Owner = Globals.MainForm;
            this.Font = Globals.Settings.DefaultFont;
            this.InitializeComponent();
            this.InitializeItemGroups();
            this.InitializeContextMenu();
            this.InitializeGraphics();
            this.ApplyLocalizedTexts();
        }

        #region Windows Form Designer Generated Code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.keyTextBox = new System.Windows.Forms.TextBox();
            this.argsListView = new System.Windows.Forms.ListView();
            this.valueLabel = new System.Windows.Forms.Label();
            this.detailsGroupBox = new System.Windows.Forms.GroupBox();
            this.keyLabel = new System.Windows.Forms.Label();
            this.valueTextBox = new System.Windows.Forms.TextBox();
            this.infoLabel = new System.Windows.Forms.Label();
            this.closeButton = new System.Windows.Forms.Button();
            this.infoPictureBox = new System.Windows.Forms.PictureBox();
            this.addButton = new System.Windows.Forms.Button();
            this.deleteButton = new System.Windows.Forms.Button();
            this.detailsGroupBox.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.infoPictureBox)).BeginInit();
            this.SuspendLayout();
            // 
            // keyTextBox
            // 
            this.keyTextBox.Location = new System.Drawing.Point(17, 38);
            this.keyTextBox.Name = "keyTextBox";
            this.keyTextBox.Size = new System.Drawing.Size(300, 21);
            this.keyTextBox.TabIndex = 2;
            this.keyTextBox.TextChanged += new System.EventHandler(this.TextBoxTextChange);
            // 
            // argsListView
            // 
            this.argsListView.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None;
            this.argsListView.HideSelection = false;
            this.argsListView.Location = new System.Drawing.Point(12, 12);
            this.argsListView.MultiSelect = false;
            this.argsListView.Name = "argsListView";
            this.argsListView.Size = new System.Drawing.Size(182, 307);
            this.argsListView.TabIndex = 1;
            this.argsListView.UseCompatibleStateImageBehavior = false;
            this.argsListView.View = System.Windows.Forms.View.SmallIcon;
            this.argsListView.SelectedIndexChanged += new System.EventHandler(this.ArgsListViewSelectedIndexChanged);
            // 
            // valueLabel
            // 
            this.valueLabel.AutoSize = true;
            this.valueLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.valueLabel.Location = new System.Drawing.Point(18, 70);
            this.valueLabel.Name = "valueLabel";
            this.valueLabel.Size = new System.Drawing.Size(37, 13);
            this.valueLabel.TabIndex = 3;
            this.valueLabel.Text = "Value:";
            // 
            // detailsGroupBox
            //
            this.detailsGroupBox.Controls.Add(this.keyLabel);
            this.detailsGroupBox.Controls.Add(this.valueTextBox);
            this.detailsGroupBox.Controls.Add(this.keyTextBox);
            this.detailsGroupBox.Controls.Add(this.valueLabel);
            this.detailsGroupBox.Location = new System.Drawing.Point(207, 6);
            this.detailsGroupBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.detailsGroupBox.Name = "detailsGroupBox";
            this.detailsGroupBox.Size = new System.Drawing.Size(335, 343);
            this.detailsGroupBox.TabIndex = 4;
            this.detailsGroupBox.TabStop = false;
            this.detailsGroupBox.Text = " Details";
            // 
            // keyLabel
            // 
            this.keyLabel.AutoSize = true;
            this.keyLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.keyLabel.Location = new System.Drawing.Point(18, 23);
            this.keyLabel.Name = "keyLabel";
            this.keyLabel.Size = new System.Drawing.Size(29, 13);
            this.keyLabel.TabIndex = 1;
            this.keyLabel.Text = "Key:";
            // 
            // valueTextBox 
            // Font needs to be set here so that controls resize correctly in high-dpi
            //
            this.valueTextBox.AcceptsTab = true;
            this.valueTextBox.AcceptsReturn = true;
            this.valueTextBox.Font = Globals.Settings.ConsoleFont;
            this.valueTextBox.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.valueTextBox.Location = new System.Drawing.Point(17, 85);
            this.valueTextBox.Multiline = true;
            this.valueTextBox.Name = "valueTextBox";
            this.valueTextBox.Size = new System.Drawing.Size(300, 240);
            this.valueTextBox.TabIndex = 4;
            this.valueTextBox.TextChanged += new System.EventHandler(this.TextBoxTextChange);
            // 
            // infoLabel
            //
            this.infoLabel.AutoSize = true;
            this.infoLabel.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.infoLabel.Location = new System.Drawing.Point(34, 361);
            this.infoLabel.Name = "infoLabel";
            this.infoLabel.Size = new System.Drawing.Size(357, 13);
            this.infoLabel.TabIndex = 5;
            this.infoLabel.Text = "Custom arguments will take effect as soon as you edit them successfully.";
            // 
            // closeButton
            //
            this.closeButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.closeButton.Location = new System.Drawing.Point(443, 356);
            this.closeButton.Name = "closeButton";
            this.closeButton.Size = new System.Drawing.Size(100, 23);
            this.closeButton.TabIndex = 7;
            this.closeButton.Text = "&Close";
            this.closeButton.UseVisualStyleBackColor = true;
            this.closeButton.Click += new System.EventHandler(this.CloseButtonClick);
            // 
            // infoPictureBox
            //
            this.infoPictureBox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.infoPictureBox.Location = new System.Drawing.Point(13, 360);
            this.infoPictureBox.Name = "infoPictureBox";
            this.infoPictureBox.Size = new System.Drawing.Size(16, 16);
            this.infoPictureBox.TabIndex = 7;
            this.infoPictureBox.TabStop = false;
            // 
            // addButton
            //
            this.addButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.addButton.Location = new System.Drawing.Point(11, 326);
            this.addButton.Name = "addButton";
            this.addButton.Size = new System.Drawing.Size(87, 23);
            this.addButton.TabIndex = 2;
            this.addButton.Text = "&Add";
            this.addButton.UseVisualStyleBackColor = true;
            this.addButton.Click += new System.EventHandler(this.AddButtonClick);
            // 
            // deleteButton
            //
            this.deleteButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.deleteButton.Location = new System.Drawing.Point(108, 326);
            this.deleteButton.Name = "deleteButton";
            this.deleteButton.Size = new System.Drawing.Size(87, 23);
            this.deleteButton.TabIndex = 3;
            this.deleteButton.Text = "&Delete";
            this.deleteButton.UseVisualStyleBackColor = true;
            this.deleteButton.Click += new System.EventHandler(this.DeleteButtonClick);
            // 
            // ArgumentDialog
            //
            this.CancelButton = this.closeButton;
            this.AcceptButton = this.closeButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(554, 393);
            this.Controls.Add(this.deleteButton);
            this.Controls.Add(this.addButton);
            this.Controls.Add(this.infoLabel);
            this.Controls.Add(this.infoPictureBox);
            this.Controls.Add(this.detailsGroupBox);
            this.Controls.Add(this.closeButton);
            this.Controls.Add(this.argsListView);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "ArgumentDialog";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = " Custom Arguments";
            this.Load += new System.EventHandler(this.DialogLoad);
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.DialogClosed);
            this.detailsGroupBox.ResumeLayout(false);
            this.detailsGroupBox.PerformLayout();
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
            imageList.Images.Add(Globals.MainForm.FindImage("242"));
            this.infoPictureBox.Image = Globals.MainForm.FindImage("229");
            this.argsListView.SmallImageList = imageList;
        }

        /// <summary>
        /// Initializes the import/export context menu
        /// </summary>
        private void InitializeContextMenu()
        {
            ContextMenuStrip contextMenu = new ContextMenuStrip();
            contextMenu.Items.Add(TextHelper.GetString("Label.ImportArguments"), null, this.ImportArguments);
            contextMenu.Items.Add(TextHelper.GetString("Label.ExportArguments"), null, this.ExportArguments);
            this.argsListView.ContextMenuStrip = contextMenu;
        }

        /// <summary>
        /// Applies the localized texts to the form
        /// </summary>
        private void ApplyLocalizedTexts()
        {
            this.Text = " " + TextHelper.GetString("Title.ArgumentDialog");
            this.infoLabel.Text = TextHelper.GetString("Info.ArgumentsTakeEffect");
            this.detailsGroupBox.Text = TextHelper.GetString("Info.Details");
            this.closeButton.Text = TextHelper.GetString("Label.Close");
            this.deleteButton.Text = TextHelper.GetString("Label.Delete");
            this.addButton.Text = TextHelper.GetString("Label.Add");
            this.valueLabel.Text = TextHelper.GetString("Info.Value");
            this.keyLabel.Text = TextHelper.GetString("Info.Key");
        }

        /// <summary>
        /// Initializes the list view item groups
        /// </summary>
        private void InitializeItemGroups()
        {
            String argumentHeader = TextHelper.GetString("Group.Arguments");
            this.argumentGroup = new ListViewGroup("Arguments", HorizontalAlignment.Left);
            this.argsListView.Groups.Add(this.argumentGroup);
        }

        /// <summary>
        /// Loads the argument list from settings
        /// </summary>
        private void LoadCustomArguments()
        {
            List<Argument> arguments = Globals.Settings.CustomArguments;
            this.PopulateArgumentList(arguments);
        }

        /// <summary>
        /// Saves the argument list to settings
        /// </summary>
        private void SaveCustomArguments()
        {
            List<Argument> arguments = new List<Argument>();
            foreach (ListViewItem item in this.argsListView.Items)
            {
                Argument argument = item.Tag as Argument;
                arguments.Add(argument);
            }
            Globals.Settings.CustomArguments = arguments;
        }

        /// <summary>
        /// Populates the argument list
        /// </summary>
        private void PopulateArgumentList(List<Argument> arguments)
        {
            this.argsListView.Items.Clear();
            String message = TextHelper.GetString("Info.Argument");
            foreach (Argument argument in arguments)
            {
                ListViewItem item = new ListViewItem();
                item.ImageIndex = 0; item.Tag = argument;
                item.Text = message + " $(" + argument.Key + ")";
                this.argsListView.Items.Add(item);
                this.argumentGroup.Items.Add(item);
            }
            if (this.argsListView.Items.Count > 0)
            {
                ListViewItem item = this.argsListView.Items[0];
                item.Selected = true;
            }
        }

        /// <summary>
        /// Adds a new empty argument
        /// </summary>
        private void AddButtonClick(Object sender, EventArgs e)
        {
            Argument argument = new Argument();
            ListViewItem item = new ListViewItem();
            String message = TextHelper.GetString("Info.Argument");
            String undefined = TextHelper.GetString("Info.Undefined");
            item.ImageIndex = 0; argument.Key = undefined;
            item.Text = message + " $(" + undefined + ")";
            item.Tag = argument; item.Selected = true;
            this.argsListView.Items.Add(item);
            this.argumentGroup.Items.Add(item);
        }

        /// <summary>
        /// Removes the select argument
        /// </summary>
        private void DeleteButtonClick(Object sender, EventArgs e)
        {
            ListViewItem item = this.argsListView.SelectedItems[0];
            this.argsListView.Items.Remove(item);
            if (this.argsListView.Items.Count > 0)
            {
                item = this.argsListView.Items[0];
                item.Selected = true;
            }
        }

        /// <summary>
        /// Closes the dialog saving the arguments
        /// </summary>
        private void CloseButtonClick(Object sender, EventArgs e)
        {
            this.Close();
        }

        /// <summary>
        /// Selected item has changed, updates the state
        /// </summary>
        private void ArgsListViewSelectedIndexChanged(Object sender, EventArgs e)
        {
            if (this.argsListView.SelectedIndices.Count > 0)
            {
                this.keyTextBox.Enabled = true;
                this.deleteButton.Enabled = true;
                this.valueTextBox.Enabled = true;
                ListViewItem item = this.argsListView.SelectedItems[0];
                Argument argument = item.Tag as Argument;
                this.valueTextBox.Text = argument.Value;
                this.keyTextBox.Text = argument.Key;
                if (argument.Key == "DefaultUser") this.keyTextBox.ReadOnly = true;
                else this.keyTextBox.ReadOnly = false;
            }
            else
            {
                this.keyTextBox.Text = "";
                this.valueTextBox.Text = "";
                this.deleteButton.Enabled = false;
                this.valueTextBox.Enabled = false;
                this.keyTextBox.Enabled = false;
            }
        }

        /// <summary>
        /// Updates the argument when text changes
        /// </summary>
        private void TextBoxTextChange(Object sender, EventArgs e)
        {
            if (this.keyTextBox.Text == "") return;
            String message = TextHelper.GetString("Info.Argument");
            if (this.argsListView.SelectedIndices.Count > 0)
            {
                ListViewItem item = this.argsListView.SelectedItems[0];
                Argument argument = item.Tag as Argument;
                argument.Value = this.valueTextBox.Text;
                argument.Key = this.keyTextBox.Text;
                item.Text = message + " $(" + argument.Key + ")";
            }
        }

        /// <summary>
        /// Exports the current argument list into a file
        /// </summary>
        private void ExportArguments(Object sender, EventArgs e)
        {
            SaveFileDialog sfd = new SaveFileDialog();
            sfd.Filter = TextHelper.GetString("Info.ArgumentFilter") + "|*.fda";
            sfd.InitialDirectory = Globals.MainForm.WorkingDirectory;
            if (sfd.ShowDialog() == DialogResult.OK)
            {
                List<Argument> arguments = new List<Argument>();
                foreach (ListViewItem item in this.argsListView.Items)
                {
                    arguments.Add((Argument)item.Tag);
                }
                ObjectSerializer.Serialize(sfd.FileName, arguments);
            }
        }

        /// <summary>
        /// Imports an argument list from a file
        /// </summary>
        private void ImportArguments(Object sender, EventArgs e)
        {
            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Filter = TextHelper.GetString("Info.ArgumentFilter") + "|*.fda";
            ofd.InitialDirectory = Globals.MainForm.WorkingDirectory;
            if (ofd.ShowDialog() == DialogResult.OK)
            {
                List<Argument> arguments = new List<Argument>();
                Object argumentsObject = ObjectSerializer.Deserialize(ofd.FileName, arguments);
                arguments = (List<Argument>)argumentsObject;
                this.PopulateArgumentList(arguments);
            }
        }

        /// <summary>
        /// Loads the arguments from the settings
        /// </summary>
        private void DialogLoad(Object sender, EventArgs e)
        {
            this.LoadCustomArguments();
        }

        /// <summary>
        /// Saves the arguments when the dialog is closed
        /// </summary>
        private void DialogClosed(Object sender, FormClosedEventArgs e)
        {
            this.SaveCustomArguments();
        }

        /// <summary>
        /// Shows the argument dialog
        /// </summary>
        public static new void Show()
        {
            ArgumentDialog argumentDialog = new ArgumentDialog();
            argumentDialog.ShowDialog();
        }

        #endregion

    }

}
