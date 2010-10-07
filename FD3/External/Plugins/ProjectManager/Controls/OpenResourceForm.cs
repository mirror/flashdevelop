using System;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;
using PluginCore.Localization;
using PluginCore.Helpers;
using ProjectManager;
using PluginCore;
using System.IO;

namespace ProjectManager.Controls
{
    public class OpenResourceForm : Form
    {
        private PluginMain plugin;
        private Int32 MAX_ITEMS = 100;
        private List<String> openedFiles;
        private List<String> projectFiles;
        private System.Windows.Forms.Label infoLabel;
        private System.Windows.Forms.TextBox textBox;
        private System.Windows.Forms.ListBox listBox;

        public OpenResourceForm(PluginMain plugin)
        {
            this.plugin = plugin;
            this.InitializeComponent();
            this.InitializeLocalization();
            this.Font = PluginBase.Settings.DefaultFont;
            if (PluginMain.Settings.ResourceFormSize.Width > MinimumSize.Width)
            {
                this.Size = PluginMain.Settings.ResourceFormSize;
            }
            this.CreateFileList();
            this.RefreshListBox();
        }

        #region Windows Form Designer Generated Code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.infoLabel = new System.Windows.Forms.Label();
            this.textBox = new System.Windows.Forms.TextBox();
            this.listBox = new System.Windows.Forms.ListBox();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.infoLabel.AutoSize = true;
            this.infoLabel.Location = new System.Drawing.Point(11, 8);
            this.infoLabel.Name = "label1";
            this.infoLabel.Size = new System.Drawing.Size(271, 13);
            this.infoLabel.TabIndex = 0;
            this.infoLabel.Text = "Search string: (UPPERCASE for search by abbreviation)";
            // 
            // textBox
            // 
            this.textBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.textBox.Location = new System.Drawing.Point(12, 25);
            this.textBox.Name = "textBox";
            this.textBox.Size = new System.Drawing.Size(355, 22);
            this.textBox.TabIndex = 1;
            this.textBox.TextChanged += new System.EventHandler(this.TextBoxTextChanged);
            this.textBox.KeyDown += new System.Windows.Forms.KeyEventHandler(this.TextBoxKeyDown);
            // 
            // listBox
            // 
            this.listBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.listBox.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawFixed;
            this.listBox.FormattingEnabled = true;
            this.listBox.ItemHeight = this.listBox.Font.Height + 2;
            this.listBox.Location = new System.Drawing.Point(12, 53);
            this.listBox.Name = "listBox";
            this.listBox.Size = new System.Drawing.Size(355, 194);
            this.listBox.TabIndex = 2;
            this.listBox.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.ListBoxDrawItem);
            this.listBox.Resize += new System.EventHandler(this.ListBoxResize);
            this.listBox.DoubleClick += new System.EventHandler(this.ListBoxDoubleClick);
            // 
            // OpenResourceForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(379, 250);
            this.Controls.Add(this.listBox);
            this.Controls.Add(this.textBox);
            this.Controls.Add(this.infoLabel);
            this.KeyPreview = true;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.MinimumSize = new System.Drawing.Size(320, 200);
            this.Name = "OpenResourceForm";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Open Resource";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.OpenResourceFormClosing);
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.OpenResourceKeyDown);
            this.ResumeLayout(false);
            this.PerformLayout();
        }

        #endregion

        #region Methods And Event Handlers

        /// <summary>
        /// 
        /// </summary>
        private void InitializeLocalization()
        {
            this.infoLabel.Text = TextHelper.GetString("Label.SearchString");
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
            List<String> allFiles = this.GetProjectFiles();
            foreach (String file in allFiles)
            {
                if (isFileHidden(file)) continue;
                if (isFileOpened(file)) openedFiles.Add(PluginBase.CurrentProject.GetRelativePath(file));
                else projectFiles.Add(PluginBase.CurrentProject.GetRelativePath(file));
            }
        }

        /// <summary>
        /// Gets a list of project related files
        /// </summary>
        public List<String> GetProjectFiles()
        {
            List<String> files = new List<String>();
            List<String> folders = this.GetProjectFolders();
            foreach (String folder in folders)
            {
                if (Directory.Exists(folder))
                {
                    files.AddRange(Directory.GetFiles(folder, "*.*", SearchOption.AllDirectories));
                }
            }
            return files;
        }

        /// <summary>
        /// Gets a list of project related folders
        /// </summary>
        public List<String> GetProjectFolders()
        {
            String projectFolder = Path.GetDirectoryName(PluginBase.CurrentProject.ProjectPath);
            List<String> folders = new List<String>();
            folders.Add(projectFolder);
            if (!PluginMain.Settings.SearchExternalClassPath) return folders;
            foreach (String path in PluginBase.CurrentProject.SourcePaths)
            {
                if (Path.IsPathRooted(path)) folders.Add(path);
                else
                {
                    String folder = Path.GetFullPath(Path.Combine(projectFolder, path));
                    if (!folder.StartsWith(projectFolder)) folders.Add(folder);
                }
            }
            return folders;
        }

        /// <summary>
        /// 
        /// </summary>
        private Boolean isFileHidden(String file)
        {
            String name = System.IO.Path.GetFileName(file);
            String path = System.IO.Path.GetDirectoryName(file);
            String dirSep = System.IO.Path.DirectorySeparatorChar.ToString();
            if (path.Contains(".svn") || path.Contains(dirSep + "_svn") || path.Contains(".cvs") || path.Contains(dirSep + "_cvs") || path.Contains(".git")) return true;
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
            PluginMain.Settings.ResourceFormSize = Size;
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

        #endregion

    }

    #region Helpers

    class SearchUtil
    {
        public delegate Boolean Comparer(String value1, String value2, String value3);

        public static List<String> getMatchedItems(List<String> source, String searchText, String pathSeparator, Int32 limit)
        {
            Int32 i = 0;
            List<String> matchedItems = new List<String>();
            String firstChar = searchText.Substring(0, 1);
            Comparer searchMatch = (firstChar == firstChar.ToUpper()) ? new Comparer(AdvancedSearchMatch) : new Comparer(SimpleSearchMatch);
            foreach (String item in source)
            {
                if (searchMatch(item, searchText, pathSeparator))
                {
                    matchedItems.Add(item);
                    if (limit > 0 && i++ > limit) break;
                }
            }
            return matchedItems;
        }

        static private bool AdvancedSearchMatch(String file, String searchText, String pathSeparator)
        {
            int i = 0; int j = 0;
            if (file.Length < searchText.Length) return false;
            Char[] text = file.Substring(file.LastIndexOf(pathSeparator) + 1).ToCharArray();
            Char[] pattern = searchText.ToCharArray();
            while (i < pattern.Length)
            {
                while (i < pattern.Length && j < text.Length && pattern[i] == text[j])
                {
                    i++;
                    j++;
                }
                if (i == pattern.Length) return true;
                if (Char.IsLower(pattern[i])) return false;
                while (j < text.Length && Char.IsLower(text[j]))
                {
                    j++;
                }
                if (j == text.Length) return false;
                if (pattern[i] != text[j]) return false;
            }
            return (i == pattern.Length);
        }

        private static Boolean SimpleSearchMatch(String file, String searchText, String pathSeparator)
        {
            String fileName = file.Substring(file.LastIndexOf(pathSeparator) + 1).ToLower();
            return fileName.IndexOf(searchText.ToLower()) > -1;
        }

    }

    #endregion

}