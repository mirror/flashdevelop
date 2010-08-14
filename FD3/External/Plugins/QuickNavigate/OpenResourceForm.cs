using System;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;
using PluginCore.Localization;
using PluginCore.Helpers;
using PluginCore;

namespace QuickNavigate
{
    public partial class OpenResourceForm : Form
    {
        private PluginMain plugin;
        private Int32 MAX_ITEMS = 100;
        private List<String> projectFiles;
        private List<String> openedFiles;

        public OpenResourceForm(PluginMain plugin)
        {
            this.plugin = plugin;
            this.InitializeComponent();
            this.InitializeLocalization();
            this.Font = PluginBase.Settings.DefaultFont;
            if ((plugin.Settings as Settings).ResourceFormSize.Width > MinimumSize.Width)
            {
                this.Size = (plugin.Settings as Settings).ResourceFormSize;
            }
            this.CreateFileList();
            this.RefreshListBox();
        }

        /// <summary>
        /// 
        /// </summary>
        private void InitializeLocalization()
        {
            this.label1.Text = TextHelper.GetString("Label.SearchString");
            this.Text = " " + TextHelper.GetString("Title.OpenResource");
        }

        /// <summary>
        /// 
        /// </summary>
        private void ListBoxDrawItem(Object sender, DrawItemEventArgs e)
        {
            Boolean selected = (e.State & DrawItemState.Selected) == DrawItemState.Selected;
            if (selected) e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds);
            else e.Graphics.FillRectangle(new SolidBrush(this.listBox.BackColor), e.Bounds);
            if (e.Index >= 0)
            {
                var fullName = (String)this.listBox.Items[e.Index];
                if (!selected)
                {
                    Int32 slashIndex = fullName.LastIndexOf("\\");
                    String path = fullName.Substring(0, slashIndex + 1);
                    String name = fullName.Substring(slashIndex + 1);
                    Int32 pathSize = DrawHelper.MeasureDisplayStringWidth(e.Graphics, path, e.Font) - 2;
                    if (pathSize < 0) pathSize = 0; // No negative padding...
                    e.Graphics.DrawString(path, e.Font, Brushes.Gray, e.Bounds.Left, e.Bounds.Top, StringFormat.GenericDefault);
                    e.Graphics.DrawString(name, e.Font, Brushes.Black, e.Bounds.Left + pathSize, e.Bounds.Top, StringFormat.GenericDefault);
                    e.DrawFocusRectangle();
                }
                else e.Graphics.DrawString(fullName, e.Font, Brushes.White, e.Bounds.Left, e.Bounds.Top, StringFormat.GenericDefault);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void RefreshListBox()
        {
            this.listBox.BeginUpdate();
            this.listBox.Items.Clear();
            this.FillListBox();
            if (this.listBox.Items.Count > 0)
            {
                this.listBox.SelectedIndex = 0;
            }
            this.listBox.EndUpdate();
        }

        /// <summary>
        /// 
        /// </summary>
        private void FillListBox()
        {
            List<String> matchedFiles;
            if (this.textBox.Text.Length > 0)
            {
                matchedFiles = SearchUtil.getMatchedItems(this.openedFiles, this.textBox.Text, "\\", 0);
                if (matchedFiles.Capacity > 0) matchedFiles.Add("-----------------");
                matchedFiles.AddRange(SearchUtil.getMatchedItems(this.projectFiles, this.textBox.Text, "\\", this.MAX_ITEMS));
            }
            else matchedFiles = openedFiles;
            foreach (String file in matchedFiles)
            {
               this.listBox.Items.Add(file);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void CreateFileList()
        {
            openedFiles = new List<String>();
            projectFiles = new List<String>();
            List<String> allFiles = plugin.GetProjectFiles();
            foreach (String file in allFiles)
            {
                if (isFileHidden(file)) continue;
                if (isFileOpened(file)) openedFiles.Add(PluginBase.CurrentProject.GetRelativePath(file));
                else projectFiles.Add(PluginBase.CurrentProject.GetRelativePath(file));
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private Boolean isFileHidden(String file)
        {
            String path = System.IO.Path.GetDirectoryName(file);
            String name = System.IO.Path.GetFileName(file);
            if (path.Contains(".svn") || path.Contains(".cvs") || path.Contains(".git")) return true;
            else if (name.Substring(0, 1) == ".") return true;
            else return false;
        }

        /// <summary>
        /// 
        /// </summary>
        private Boolean isFileOpened(String file)
        {
            foreach (ITabbedDocument doc in PluginBase.MainForm.Documents)
            {
                if (doc.FileName == file) return true;
            }
            return false;
        }

        /// <summary>
        /// 
        /// </summary>
        private void Navigate()
        {
            if (this.listBox.SelectedItem != null)
            {
                String file = PluginBase.CurrentProject.GetAbsolutePath((string)this.listBox.SelectedItem);
                PluginBase.MainForm.OpenEditableDocument(file);
                this.Close();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void OpenResourceKeyDown(Object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Escape) this.Close();
            else if (e.KeyCode == Keys.Enter)
            {
                e.Handled = true;
                this.Navigate();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void TextBoxKeyDown(Object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Down && this.listBox.SelectedIndex < this.listBox.Items.Count - 1)
            {
                this.listBox.SelectedIndex++;
                e.Handled = true;
            }
            else if (e.KeyCode == Keys.Up && this.listBox.SelectedIndex > 0)
            {
                this.listBox.SelectedIndex--;
                e.Handled = true;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void OpenResourceFormClosing(Object sender, FormClosingEventArgs e)
        {
            (plugin.Settings as Settings).ResourceFormSize = Size;
        }

        /// <summary>
        /// 
        /// </summary>
        private void TextBoxTextChanged(Object sender, EventArgs e)
        {
            this.RefreshListBox();
        }

        /// <summary>
        /// 
        /// </summary>
        private void ListBoxDoubleClick(Object sender, EventArgs e)
        {
            this.Navigate();
        }

        /// <summary>
        /// 
        /// </summary>
        private void ListBoxResize(Object sender, EventArgs e)
        {
            this.listBox.Refresh();
        }

    }

}