using System;
using System.ComponentModel;
using System.Collections;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using PluginCore;

namespace FileExplorer
{
	public class PluginUI : System.Windows.Forms.UserControl
	{
		private System.ComponentModel.IContainer components;
		private System.Windows.Forms.MenuItem menuItemPro;
		private System.Windows.Forms.MenuItem menuItemFolder;
		private System.Windows.Forms.MenuItem menuItemOp;
		private System.Windows.Forms.ListView fileView;
		private System.Windows.Forms.MenuItem menuItemEd;
		private System.Windows.Forms.Button browseButton;
		private System.Windows.Forms.ColumnHeader fileHeader;
		private System.Windows.Forms.MenuItem menuItemSep3;
		private System.Windows.Forms.Panel infoPanel;
		private System.Windows.Forms.MenuItem menuItemSep2;
		private System.IO.FileSystemWatcher watcher;
		private System.Windows.Forms.ContextMenu filesMenu;
		private System.Windows.Forms.MenuItem menuItemSy;
		private System.Windows.Forms.MenuItem menuItemCre;
		public System.Windows.Forms.ComboBox selectedPath;
		private System.Windows.Forms.ColumnHeader modifiedHeader;
		private System.Windows.Forms.MenuItem menuItemRef;
		private System.Windows.Forms.MenuItem menuItem5;
		private System.Windows.Forms.ColumnHeader sizeHeader;
		private System.Windows.Forms.MenuItem menuItemTrust;
		private System.Windows.Forms.MenuItem menuItemSep;
		private System.Windows.Forms.FolderBrowserDialog folderBrowserDialog;
		private System.Windows.Forms.MenuItem menuItemDel;
		private System.Windows.Forms.MenuItem menuItemEx;
		private System.Windows.Forms.MenuItem menuItemRen;
		private System.Windows.Forms.ColumnHeader typeHeader;
		public System.Windows.Forms.ImageList imageList;
		private ListViewSorter listViewSorter;
		private Hashtable extensionIcons;
		private int prevColumnClick;
		private string previousItemLabel;
		private PluginMain plugin;
		private string autoSelectItem;
		private long lastUpdateTimeStamp;
		readonly private string SETTING_FILEPATH = "FileExplorer.FilePath";
		readonly private string SETTING_SORTCOLUMN = "FileExplorer.SortColumn";
		readonly private string SETTING_SORTORDER = "FileExplorer.SortOrder";

		public PluginUI(PluginMain pluginMain)
		{
			this.extensionIcons = new Hashtable();
			this.listViewSorter = new ListViewSorter();
			this.plugin = pluginMain;
			this.InitializeComponent();
			this.fileView.ListViewItemSorter = this.listViewSorter;
			// load resource icons
			try 
			{
				this.imageList.Images.Clear();
				System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
				this.imageList.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("FolderUp.png")));
				this.imageList.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Folder.png")));
				this.browseButton.Image = new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Folder.png"));
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while loading resources in FileExplorer.DLL", ex);
			}
			// update UI
			this.Initialize(null, null);
		}
		
		#region Windows Forms Designer generated code
		
		/**
		* This method is required for Windows Forms designer support.
		* Do not change the method contents inside the source code editor. The Forms designer might
		* not be able to load this method if it was changed manually.
		*/
		private void InitializeComponent() {
			this.components = new System.ComponentModel.Container();
			this.imageList = new System.Windows.Forms.ImageList(this.components);
			this.typeHeader = new System.Windows.Forms.ColumnHeader();
			this.menuItemRen = new System.Windows.Forms.MenuItem();
			this.menuItemEx = new System.Windows.Forms.MenuItem();
			this.menuItemDel = new System.Windows.Forms.MenuItem();
			this.folderBrowserDialog = new System.Windows.Forms.FolderBrowserDialog();
			this.menuItemSep = new System.Windows.Forms.MenuItem();
			this.menuItemTrust = new System.Windows.Forms.MenuItem();
			this.sizeHeader = new System.Windows.Forms.ColumnHeader();
			this.menuItem5 = new System.Windows.Forms.MenuItem();
			this.menuItemRef = new System.Windows.Forms.MenuItem();
			this.modifiedHeader = new System.Windows.Forms.ColumnHeader();
			this.selectedPath = new System.Windows.Forms.ComboBox();
			this.menuItemCre = new System.Windows.Forms.MenuItem();
			this.menuItemSy = new System.Windows.Forms.MenuItem();
			this.filesMenu = new System.Windows.Forms.ContextMenu();
			this.watcher = new System.IO.FileSystemWatcher();
			this.menuItemSep2 = new System.Windows.Forms.MenuItem();
			this.infoPanel = new System.Windows.Forms.Panel();
			this.menuItemSep3 = new System.Windows.Forms.MenuItem();
			this.fileHeader = new System.Windows.Forms.ColumnHeader();
			this.browseButton = new System.Windows.Forms.Button();
			this.menuItemEd = new System.Windows.Forms.MenuItem();
			this.fileView = new System.Windows.Forms.ListView();
			this.menuItemOp = new System.Windows.Forms.MenuItem();
			this.menuItemFolder = new System.Windows.Forms.MenuItem();
			this.menuItemPro = new System.Windows.Forms.MenuItem();
			((System.ComponentModel.ISupportInitialize)(this.watcher)).BeginInit();
			this.infoPanel.SuspendLayout();
			this.SuspendLayout();
			// 
			// imageList
			// 
			this.imageList.ColorDepth = System.Windows.Forms.ColorDepth.Depth32Bit;
			this.imageList.ImageSize = new System.Drawing.Size(16, 16);
			this.imageList.TransparentColor = System.Drawing.Color.White;
			// 
			// typeHeader
			// 
			this.typeHeader.Text = "Type";
			// 
			// menuItemRen
			// 
			this.menuItemRen.Index = 10;
			this.menuItemRen.Shortcut = System.Windows.Forms.Shortcut.F2;
			this.menuItemRen.Text = "Re&name";
			this.menuItemRen.Click += new System.EventHandler(this.RenameItem);
			// 
			// menuItemEx
			// 
			this.menuItemEx.Index = 6;
			this.menuItemEx.Text = "E&xplore Here..";
			this.menuItemEx.Click += new System.EventHandler(this.ExploreHere);
			// 
			// menuItemDel
			// 
			this.menuItemDel.Index = 11;
			this.menuItemDel.Shortcut = System.Windows.Forms.Shortcut.Del;
			this.menuItemDel.Text = "&Delete";
			this.menuItemDel.Click += new System.EventHandler(this.DeleteFile);
			// 
			// folderBrowserDialog
			// 
			this.folderBrowserDialog.Description = "Open a folder to list the files in the folder";
			// 
			// menuItemSep
			// 
			this.menuItemSep.Index = 2;
			this.menuItemSep.Text = "-";
			// 
			// menuItemTrust
			// 
			this.menuItemTrust.Index = 13;
			this.menuItemTrust.Text = "Add To Flash &Trusted Files";
			this.menuItemTrust.Click += new System.EventHandler(this.MenuItemTrustClick);
			// 
			// sizeHeader
			// 
			this.sizeHeader.Text = "Size";
			// 
			// menuItem5
			// 
			this.menuItem5.Index = -1;
			this.menuItem5.Text = "Open";
			// 
			// menuItemRef
			// 
			this.menuItemRef.Index = 0;
			this.menuItemRef.Shortcut = System.Windows.Forms.Shortcut.F5;
			this.menuItemRef.Text = "&Refresh View";
			this.menuItemRef.Click += new System.EventHandler(this.RefreshFileView);
			// 
			// modifiedHeader
			// 
			this.modifiedHeader.Text = "Modified";
			this.modifiedHeader.Width = 120;
			// 
			// selectedPath
			// 
			this.selectedPath.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
						| System.Windows.Forms.AnchorStyles.Right)));
			this.selectedPath.Location = new System.Drawing.Point(0, 5);
			this.selectedPath.Name = "selectedPath";
			this.selectedPath.Size = new System.Drawing.Size(230, 21);
			this.selectedPath.Sorted = true;
			this.selectedPath.TabIndex = 1;
			this.selectedPath.KeyDown += new System.Windows.Forms.KeyEventHandler(this.SelectedPathKeyDown);
			this.selectedPath.SelectedIndexChanged += new System.EventHandler(this.SelectedPathSelectedIndexChanged);
			// 
			// menuItemCre
			// 
			this.menuItemCre.Index = 3;
			this.menuItemCre.Text = "&Create File Here..";
			this.menuItemCre.Click += new System.EventHandler(this.CreateFileHere);
			// 
			// menuItemSy
			// 
			this.menuItemSy.Index = 1;
			this.menuItemSy.Text = "&Synchronize View";
			this.menuItemSy.Click += new System.EventHandler(this.SynchronizeView);
			// 
			// filesMenu
			// 
			this.filesMenu.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
						this.menuItemRef,
						this.menuItemSy,
						this.menuItemSep,
						this.menuItemCre,
						this.menuItemFolder,
						this.menuItemPro,
						this.menuItemEx,
						this.menuItemSep2,
						this.menuItemOp,
						this.menuItemEd,
						this.menuItemRen,
						this.menuItemDel,
						this.menuItemSep3,
						this.menuItemTrust});
			// 
			// watcher
			// 
			this.watcher.EnableRaisingEvents = true;
			this.watcher.NotifyFilter = ((System.IO.NotifyFilters)((System.IO.NotifyFilters.FileName | System.IO.NotifyFilters.DirectoryName)));
			this.watcher.SynchronizingObject = this;
			this.watcher.Deleted += new System.IO.FileSystemEventHandler(this.WatcherChanged);
			this.watcher.Renamed += new System.IO.RenamedEventHandler(this.WatcherRenamed);
			this.watcher.Changed += new System.IO.FileSystemEventHandler(this.WatcherChanged);
			this.watcher.Created += new System.IO.FileSystemEventHandler(this.WatcherChanged);
			// 
			// menuItemSep2
			// 
			this.menuItemSep2.Index = 7;
			this.menuItemSep2.Text = "-";
			// 
			// infoPanel
			// 
			this.infoPanel.Controls.Add(this.browseButton);
			this.infoPanel.Controls.Add(this.selectedPath);
			this.infoPanel.Dock = System.Windows.Forms.DockStyle.Top;
			this.infoPanel.Location = new System.Drawing.Point(0, 0);
			this.infoPanel.Name = "infoPanel";
			this.infoPanel.Size = new System.Drawing.Size(264, 32);
			this.infoPanel.TabIndex = 0;
			// 
			// menuItemSep3
			// 
			this.menuItemSep3.Index = 12;
			this.menuItemSep3.Text = "-";
			// 
			// fileHeader
			// 
			this.fileHeader.Text = "File";
			this.fileHeader.Width = 192;
			// 
			// browseButton
			// 
			this.browseButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.browseButton.BackColor = System.Drawing.SystemColors.Control;
			this.browseButton.Location = new System.Drawing.Point(235, 4);
			this.browseButton.Name = "browseButton";
			this.browseButton.Size = new System.Drawing.Size(24, 23);
			this.browseButton.TabIndex = 2;
			this.browseButton.Click += new System.EventHandler(this.BrowseButtonClick);
			// 
			// menuItemEd
			// 
			this.menuItemEd.Index = 9;
			this.menuItemEd.Text = "&Edit";
			this.menuItemEd.Click += new System.EventHandler(this.EditItem);
			// 
			// fileView
			// 
			this.fileView.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
						this.fileHeader,
						this.sizeHeader,
						this.typeHeader,
						this.modifiedHeader});
			this.fileView.ContextMenu = this.filesMenu;
			this.fileView.Dock = System.Windows.Forms.DockStyle.Fill;
			this.fileView.LabelEdit = true;
			this.fileView.Location = new System.Drawing.Point(0, 32);
			this.fileView.MultiSelect = false;
			this.fileView.Name = "fileView";
			this.fileView.Size = new System.Drawing.Size(264, 280);
			this.fileView.SmallImageList = this.imageList;
			this.fileView.TabIndex = 3;
			this.fileView.View = System.Windows.Forms.View.Details;
			this.fileView.ItemActivate += new System.EventHandler(this.FileViewItemActivate);
			this.fileView.MouseUp += new System.Windows.Forms.MouseEventHandler(this.FileViewMouseUp);
			this.fileView.AfterLabelEdit += new System.Windows.Forms.LabelEditEventHandler(this.FileViewAfterLabelEdit);
			this.fileView.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.FileViewColumnClick);
			this.fileView.BeforeLabelEdit += new System.Windows.Forms.LabelEditEventHandler(this.FileViewBeforeLabelEdit);
			// 
			// menuItemOp
			// 
			this.menuItemOp.Index = 8;
			this.menuItemOp.Text = "&Run";
			this.menuItemOp.Click += new System.EventHandler(this.OpenItem);
			// 
			// menuItemFolder
			// 
			this.menuItemFolder.Index = 4;
			this.menuItemFolder.Text = "Create &Folder Here..";
			this.menuItemFolder.Click += new System.EventHandler(this.CreateFolderHere);
			// 
			// menuItemPro
			// 
			this.menuItemPro.Index = 5;
			this.menuItemPro.Text = "Command &Prompt Here..";
			this.menuItemPro.Click += new System.EventHandler(this.MenuItemProClick);
			// 
			// PluginUI
			// 
			this.Controls.Add(this.fileView);
			this.Controls.Add(this.infoPanel);
			this.Name = "PluginUI";
			this.Size = new System.Drawing.Size(264, 312);
			((System.ComponentModel.ISupportInitialize)(this.watcher)).EndInit();
			this.infoPanel.ResumeLayout(false);
			this.ResumeLayout(false);
		}
		#endregion
	
		#region MethodsAndEventHandlers
		
		/**
		* Set the selected path
		*/
		public void BrowseTo(string path)
		{
			this.PopulateFileView(path);
		}
		
		/**
		* Add the file's folder to the recent folders list
		*/
		public void AddToMRU(string file)
		{
			string path = System.IO.Path.GetDirectoryName(file);
			if (!this.selectedPath.Items.Contains(path))
			{
				this.selectedPath.Items.Add(path);
			}
		}
		
		/**
		* List last open path on load
		*/
		public void Initialize(object sender, System.EventArgs e)
		{
			string path = "C:\\";
			if (this.plugin.MainForm.MainSettings.HasKey(SETTING_FILEPATH))
			{
				string pathToCheck = this.plugin.MainForm.MainSettings.GetValue(SETTING_FILEPATH);
				if (Directory.Exists(pathToCheck))
				{
					path = pathToCheck;
				}
			}
			if (this.plugin.MainForm.MainSettings.HasKey(SETTING_SORTCOLUMN))
			{
				this.listViewSorter.SortColumn = this.plugin.MainForm.MainSettings.GetInt(SETTING_SORTCOLUMN);
			}
			else this.plugin.MainForm.MainSettings.AddValue(SETTING_SORTCOLUMN, "0");
			//
			if (this.plugin.MainForm.MainSettings.HasKey(SETTING_SORTORDER))
			{
				if (this.plugin.MainForm.MainSettings.GetInt(SETTING_SORTORDER) == 0) this.listViewSorter.Order = SortOrder.Ascending;
				else this.listViewSorter.Order = SortOrder.Descending;
			}
			else this.plugin.MainForm.MainSettings.AddValue(SETTING_SORTORDER, "0");
			//
			this.watcher.Path = path;
			this.watcher.EnableRaisingEvents = true;
			this.PopulateFileView(path);
		}

		/**
		* Update files listview. If the path is invalid, use the last valid path
		*/
		public void PopulateFileView(string path)
		{
			DirectoryInfo directory;
			try
			{
				path = path.Replace(Path.AltDirectorySeparatorChar, Path.DirectorySeparatorChar);
				path = plugin.MainForm.GetLongPathName(path);
				directory = new DirectoryInfo(path);
				directory.GetFileSystemInfos();
				this.plugin.MainForm.MainSettings.ChangeValue(SETTING_FILEPATH, path);
				this.selectedPath.Text = path;
			} 
			catch (System.Security.SecurityException) 
            {
                MessageBox.Show("This user does not have the required permission to access:\n"+path, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }
			catch (System.IO.DirectoryNotFoundException) 
            {
                MessageBox.Show("Path not found:\n"+path, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }
			catch
			{
				MessageBox.Show("File access error:\n"+path, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				return;
			}
			try
			{
				this.fileView.BeginUpdate();
				this.fileView.Items.Clear();
				ListViewItem item;
				if (directory.Parent != null)
				{
					item = new ListViewItem("[..]", 0);
					item.Tag = directory.Parent.FullName;
					item.SubItems.Add("-");
					item.SubItems.Add("-");
					item.SubItems.Add("-");
					this.fileView.Items.Add(item);
				}
				foreach (DirectoryInfo subDir in directory.GetDirectories())
				{
					if((subDir.Attributes & FileAttributes.Hidden) == 0)
					{
						item = new ListViewItem(subDir.Name, 1);
						item.Tag = subDir.FullName;
						item.SubItems.Add("-");
						item.SubItems.Add("-");
						item.SubItems.Add(subDir.LastWriteTime.ToString());
						this.fileView.Items.Add(item); 
					}
				}
				foreach (FileInfo file in directory.GetFiles())
				{
					if((file.Attributes & FileAttributes.Hidden) == 0)
					{
						item = new ListViewItem(file.Name, ExtractIconIfNecessary(file.FullName));
						item.Tag = file.FullName;
						if (file.Length/1024 < 1) item.SubItems.Add("1 KB");
						else item.SubItems.Add((file.Length/1024).ToString()+" KB");
						item.SubItems.Add(file.Extension.ToUpper().Replace(".", ""));
						item.SubItems.Add(file.LastWriteTime.ToString());
						this.fileView.Items.Add(item);
					}
				}
				this.watcher.Path = path;
				this.fileView.Sort();
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while populating file view.", ex);
			}
			finally
			{
				this.fileView.EndUpdate();
			}
		}
		
		/**
		* Open the folder browser dialog
		*/
		public void BrowseButtonClick(object sender, System.EventArgs e)
		{
			try 
			{
				if (Directory.Exists(this.selectedPath.Text)) 
				{
					this.folderBrowserDialog.SelectedPath = this.selectedPath.Text;
				}
				if (this.folderBrowserDialog.ShowDialog((Form)this.plugin.MainForm) == System.Windows.Forms.DialogResult.OK)
				{
					this.PopulateFileView(this.folderBrowserDialog.SelectedPath);
				}
			}
			catch (Exception ex) 
			{
				ErrorHandler.ShowError("An error occured in the Folder Browse dialog:\n"+ex.Message, ex);
			}
		}
		
		/**
		* When the first index is selected opens the folder browser dialog
		*/
		public void SelectedPathSelectedIndexChanged(object sender, System.EventArgs e)
		{
			if (this.selectedPath.SelectedIndex != -1)
			{
				string path = this.selectedPath.SelectedItem.ToString();
				if (System.IO.Directory.Exists(path))
				{
					this.PopulateFileView(path);
				}
			}
		}
		
		/**
		* Key pressed while editing the selected path
		*/
		public void SelectedPathKeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
		{
			if (e.KeyCode == Keys.Enter)
			{
				e.Handled = true;
				string path = this.selectedPath.Text;
				if (System.IO.Directory.Exists(path))
				{
					this.PopulateFileView(path);
				}
			}
		}
		
		/**
		* A file/directory item could be renamed
		*/
		public void FileViewBeforeLabelEdit(object sender, System.Windows.Forms.LabelEditEventArgs e)
		{
			try
			{
				this.previousItemLabel = this.fileView.Items[e.Item].Text;
				if (this.previousItemLabel.StartsWith("[")) e.CancelEdit = true;
				else this.menuItemDel.Enabled = false;
			}
			catch
			{
				e.CancelEdit = true;
			}
		}
		
		/**
		* A file/directory item has been renamed
		*/
		public void FileViewAfterLabelEdit(object sender, System.Windows.Forms.LabelEditEventArgs e)
		{
			this.menuItemDel.Enabled = true;
			ListViewItem item = null;
			try
			{
				// file / directory
				if (e.CancelEdit || (e.Label.Length == 0) || (e.Label == this.previousItemLabel))
				{
					e.CancelEdit = true;
					return;
				}
				item = this.fileView.Items[e.Item];
				string file = (string)item.Tag;
				System.IO.FileInfo info = new System.IO.FileInfo(file);
				string path = info.Directory+Path.DirectorySeparatorChar.ToString();
				// rename
				if (System.IO.File.Exists(file)) 
				{
					System.IO.File.Move(path+this.previousItemLabel, path+e.Label);
				}
				else if (System.IO.Directory.Exists(file)) 
				{
					System.IO.Directory.Move(path+this.previousItemLabel, path+e.Label);
				}
			}
			catch (Exception ex)
			{
				if (item != null) ErrorHandler.ShowError(ex.Message, ex);
				e.CancelEdit = true;
			}
		}
		
		/**
		* Open selected file or browse directory
		*/
		public void FileViewItemActivate(object sender, System.EventArgs e)
		{
			if (this.fileView.SelectedItems.Count == 0) return;
			string file = this.fileView.SelectedItems[0].Tag.ToString();
			// if Shift+Enter
			if (Control.ModifierKeys == Keys.Shift)
			{
				this.OpenItem(null,null);
			}
			else
			{
				if (System.IO.File.Exists(file)) 
				{
					this.plugin.MainForm.OpenSelectedFile(file);
				}
				else 
				{
					this.PopulateFileView(file);
				}
			}
		}
		
		/**
		* Create listview context menu on right button click
		*/
		public void FileViewMouseUp(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			ListView fileView = (ListView)sender;
			if (e.Button == MouseButtons.Right)
			{
				menuItemSep2.Visible = menuItemRen.Visible = menuItemOp.Visible = menuItemDel.Visible = menuItemEd.Visible = ((this.fileView.SelectedItems.Count != 0) && (this.fileView.SelectedItems[0].Text != "[..]"));
				if (menuItemEd.Visible)
				{
					string file = this.fileView.SelectedItems[0].Tag.ToString();
					menuItemEd.Visible = (this.fileView.SelectedIndices[0] > 0) && System.IO.File.Exists(file);
				}
			}
		}
		
		/**
		* Refreshes the file view
		*/
		public void RefreshFileView(object sender, System.EventArgs e)
		{
			string path = this.selectedPath.Text;
			this.PopulateFileView(path);
		}
		
		/**
		* Open Windows explorer in current path
		*/
		public void ExploreHere(object sender, System.EventArgs e)
		{
			System.Diagnostics.Process.Start("explorer.exe", "/e, "+this.selectedPath.Text);
		}
		
		/**
		* Sort items by user column click
		*/
		public void FileViewColumnClick(object sender, System.Windows.Forms.ColumnClickEventArgs e)
		{
			if (this.prevColumnClick == e.Column)
			{
				this.listViewSorter.Order = (this.listViewSorter.Order == SortOrder.Descending) ? SortOrder.Ascending : SortOrder.Descending;
			} 
			else this.listViewSorter.Order = SortOrder.Ascending;
			//
			if (this.listViewSorter.Order == SortOrder.Ascending)
			{
				this.plugin.MainForm.MainSettings.ChangeValue(SETTING_SORTORDER, "0");
			} 
			else this.plugin.MainForm.MainSettings.ChangeValue(SETTING_SORTORDER, "1");
			//
			this.prevColumnClick = e.Column;
			this.plugin.MainForm.MainSettings.ChangeValue(SETTING_SORTCOLUMN, e.Column.ToString());
			this.listViewSorter.SortColumn = e.Column;
			this.fileView.Sort();
		}
		
		/**
		* Creates a new file to the current folder.
		*/
		public void CreateFileHere(object sender, System.EventArgs e)
		{
			string path = this.selectedPath.Text;
			if (!Directory.Exists(path))
			{
				ErrorHandler.ShowInfo("The folder does not exist:\n"+path);
				return;
			}
			try
			{
				int counter = 0;
				string ext = this.plugin.MainForm.MainSettings.GetValue("FlashDevelop.DefaultFileExtension");
				string file = path+Path.DirectorySeparatorChar.ToString()+"New file."+ext;
				while (File.Exists(file))
				{
					counter++;
					file = path+Path.DirectorySeparatorChar.ToString()+"New file"+counter+"."+ext;
				}
				FileStream fs = File.Create(file);
				fs.Flush();
				fs.Close();
				this.autoSelectItem = Path.GetFileName(file);
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while creating a file.", ex);
			}
		}
		
		/**
		* Creates a new folder to the current folder
		*/
		public void CreateFolderHere(object sender, System.EventArgs e)
		{
			string path = this.selectedPath.Text;
			if (!Directory.Exists(path)) 
			{
				ErrorHandler.ShowInfo("The folder does not exist:\n"+path);
				return;
			}
			try
			{
				int counter = 0;
				string forderName = "New Folder";
				string dir = path+Path.DirectorySeparatorChar.ToString()+forderName;
				while (Directory.Exists(dir))
				{
					forderName = "New Folder"+counter++;
					dir = path+Path.DirectorySeparatorChar.ToString()+forderName;
				}
				System.IO.Directory.CreateDirectory(dir);
				this.autoSelectItem = forderName;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Could not create a new folder.", ex);
			}
		}
		
		/**
		* Deletes the selected file
		*/
		public void DeleteFile(object sender, System.EventArgs e)
		{
			if ((this.fileView.SelectedItems.Count != 0) && (this.fileView.SelectedIndices[0] > 0))
			{
				string path = this.fileView.SelectedItems[0].Tag.ToString();
				try 
				{
					if (Directory.Exists(path))
					{
						if (MessageBox.Show("Are you sure you want to delete the folder?", " Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
						{
							Directory.Delete(path);
						}
					} 
					else
					{
						if (MessageBox.Show("Are you sure you want to delete the file?", " Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
						{
							File.Delete(path);
						}
					}
				} 
				catch (Exception ex)
				{
					ErrorHandler.ShowError("Could not delete: "+path, ex);
				}
			}
		}
		
		/**
		* Open command prompt in current path
		*/
		public void MenuItemProClick(object sender, System.EventArgs e)
		{
			System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo("cmd.exe");
			startInfo.WorkingDirectory = this.selectedPath.Text;
			System.Diagnostics.Process.Start(startInfo);
		}
		
		/**
		* Rename current file/directory
		*/
		public void RenameItem(object sender, System.EventArgs e)
		{
			if ((this.fileView.SelectedItems.Count != 0) && (this.fileView.SelectedIndices[0] > 0)) 
			{
				this.fileView.SelectedItems[0].BeginEdit();
			}
		}
		
		/**
		* Open current file/directory with associated program 
		*/
		public void OpenItem(object sender, System.EventArgs e)
		{
			if ((this.fileView.SelectedItems.Count != 0) && (this.fileView.SelectedIndices[0] > 0))
			{
				string file = this.fileView.SelectedItems[0].Tag.ToString();
				try
				{
					System.Diagnostics.Process.Start(file);
				}
				catch (Exception ex)
				{
					ErrorHandler.ShowError("Error while running the process.", ex);
				}
			}
		}
		
		/**
		* Rename current file/directory
		*/
		public void EditItem(object sender, System.EventArgs e)
		{
			if ((this.fileView.SelectedItems.Count != 0) && (this.fileView.SelectedIndices[0] > 0)) 
			{
				string file = this.fileView.SelectedItems[0].Tag.ToString();
				if (System.IO.File.Exists(file)) 
				{
					this.plugin.MainForm.OpenSelectedFile(file);
				}
			}
		}
		
		/**
		* Select current file's folder view
		*/
		public void SynchronizeView(object sender, System.EventArgs e)
		{
			string filename = this.plugin.MainForm.CurFile;
			if (System.IO.File.Exists(filename) && !filename.StartsWith("Untitled"))
			{
				string path = System.IO.Path.GetDirectoryName(filename);
				this.PopulateFileView(path);
			}
		}

		/**
		* Add the current folder or selected file to Flash Player trusted files
		*/ 		
		private void MenuItemTrustClick(object sender, System.EventArgs e)
		{
			string path;
			string trustFile;
			string trustParams;
			// add selected file
			if ((this.fileView.SelectedItems.Count != 0) && (this.fileView.SelectedIndices[0] > 0)) 
			{
				string file = this.fileView.SelectedItems[0].Tag.ToString();
				if (!System.IO.Directory.Exists(file)) return;
				System.IO.DirectoryInfo info = new System.IO.DirectoryInfo(file);
				//
				path = info.FullName;
				trustFile = path.Replace('\\','_').Remove(1,1);
				while ((trustFile.Length > 100) && (trustFile.IndexOf('_') > 0)) trustFile = trustFile.Substring(trustFile.IndexOf('_'));
				//
				trustParams = "FlashDevelop_"+trustFile+".cfg;"+path;
			}
			// add current folder
			else 
			{
				System.IO.FileInfo info = new System.IO.FileInfo(this.selectedPath.Text);
				//
				path = info.FullName;
				trustFile = path.Replace('\\','_').Remove(1,1);
				while ((trustFile.Length > 100) && (trustFile.IndexOf('_') > 0)) trustFile = trustFile.Substring(trustFile.IndexOf('_'));
				//
				trustParams = "FlashDevelop_"+trustFile+".cfg;"+path;
			}
			// add to trusted files
			DataEvent deTrust = new DataEvent(EventType.CustomData, "CreateTrustFile", trustParams);
			this.plugin.MainForm.DispatchEvent(deTrust);
			//
			if (deTrust.Handled)
			{
				ErrorHandler.ShowInfo("'"+path+"'\nwas added to the Flash Player trusted files");
			}
		}
		
		/**
		* The directory we're watching has changed - refresh!
		*/ 		
		private void WatcherChanged(object sender, FileSystemEventArgs e)
		{
			// this event comes in on a separate thread
			if (this.InvokeRequired) this.BeginInvoke(new FileSystemEventHandler(this.WatcherChanged), new object[]{sender, e});
			else
			{
				// ignore multiple update events
				long ts = System.DateTime.Now.Ticks;
				if (ts-lastUpdateTimeStamp < 100) return;
				lastUpdateTimeStamp = ts;
				
				// update view
				string path = this.selectedPath.Text;
				this.PopulateFileView(path);
				
				// select item after update
				if (this.autoSelectItem != null)
				{
					foreach(ListViewItem item in this.fileView.Items)
					{
						if (item.Text == this.autoSelectItem) {
							this.fileView.Focus();
							item.BeginEdit();
							break;
						}
					}
					this.autoSelectItem = null;
				}
			}
		}

		/**
		* The directory we're watching has changed - refresh!
		*/ 		
		private void WatcherRenamed(object sender, RenamedEventArgs e)
		{
			this.WatcherChanged(sender, null);
		}

		#endregion
	
		#region IconManagement

		/**
		* Ask the shell to feed us the appropriate icon for the given file, but
		* first try looking in our cache to see if we've already loaded it.
		*/
		private int ExtractIconIfNecessary(string file)
		{
			string extension = Path.GetExtension(file);
			if (extension != ".exe" && extensionIcons.ContainsKey(extension))
			{
				return (int)extensionIcons[extension];
			}
			else
			{
				Icon icon = ExtractIconClass.GetIcon(file,true);
				imageList.Images.Add(icon);
				int index = imageList.Images.Count - 1; // of the icon we just added
				if (extension != ".exe") extensionIcons.Add(extension,index);
				return index;
			}
		}

		#endregion	
			
	}
	
}
