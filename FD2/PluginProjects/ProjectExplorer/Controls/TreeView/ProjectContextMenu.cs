using System;
using System.Collections;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.Controls.TreeView
{
	/// <summary>
	/// Provides a smart context menu for a ProjectTreeView.
	/// </summary>
	public class ProjectContextMenu : CommandBarContextMenu
	{
		FDMenus menus;
		Project project;

		public CommandBarMenu AddMenu;
		public CommandBarButton Open;
		public CommandBarButton Execute;
		public CommandBarButton Insert;
		public CommandBarButton Cut;
		public CommandBarButton Copy;
		public CommandBarButton Paste;
		public CommandBarButton Delete;
		public CommandBarButton Rename;
		public CommandBarButton LibraryOptions;
		public CommandBarButton AddNewClass;
		public CommandBarButton AddNewXml;
		public CommandBarButton AddNewFile;
		public CommandBarButton AddNewFolder;
		public CommandBarButton AddLibraryAsset;
		public CommandBarButton AddExistingFile;
		public CommandBarButton NothingToDo;
		public CommandBarButton NoProjectOutput;
		public CommandBarCheckBox Hide;
		public CommandBarCheckBox ShowHidden;
		public CommandBarCheckBox AlwaysCompile;
		public CommandBarCheckBox AddLibrary;

		public ProjectContextMenu(FDMenus menus)
		{
			this.menus = menus;

			AddNewClass = CreateButton("New &Class..",Icons.ActionScript.Img);
			AddNewXml = CreateButton("New &Xml File..",Icons.XmlFile.Img);
			AddNewFile = CreateButton("New &File..",Icons.AddFile.Img);
			AddNewFolder = CreateButton("New F&older",Icons.Folder.Img);
			AddLibraryAsset = CreateButton("Library &Asset..",Icons.ImageResource.Img);
			AddExistingFile = CreateButton("&Existing File..",Icons.HiddenFile.Img);
			Open = CreateButton("&Open",Icons.OpenFile.Img);
			Insert = CreateButton("&Insert Into Document",Icons.EditFile.Img);
			Execute = CreateButton("&Execute");
			Cut = CreateButton("Cu&t",Icons.Cut.Img);
			Copy = CreateButton("Cop&y");
			Paste = CreateButton("&Paste",Icons.Paste.Img);
			Delete = CreateButton("&Delete",Icons.Delete.Img);
			Rename = CreateButton("Rena&me");
			AlwaysCompile = new CommandBarCheckBox("Always &Compile");
			AddLibrary = new CommandBarCheckBox("Add to &Library");
			LibraryOptions = CreateButton("&Options...",Icons.Options.Img);
			Hide = new CommandBarCheckBox("&Hide File");
			ShowHidden = new CommandBarCheckBox(Icons.HiddenFile.Img,"&Show Hidden Items");
			NothingToDo = new CommandBarButton("Not a valid group");
			NothingToDo.IsEnabled = false;
			NoProjectOutput = new CommandBarButton("(Project output not built)");
			NoProjectOutput.IsEnabled = false;

			AddMenu = new CommandBarMenu("&Add");
			AddMenu.Items.Add(AddNewClass);
			AddMenu.Items.Add(AddNewXml);
			AddMenu.Items.Add(AddNewFile);
			AddMenu.Items.Add(AddNewFolder);
			AddMenu.Items.AddSeparator();
			AddMenu.Items.Add(AddLibraryAsset);
			AddMenu.Items.Add(AddExistingFile);
		}

		public Project Project
		{
			get { return project; }
			set { project = value; }
		}

		#region Configure

		/// <summary>
		/// Configure ourself to be a menu relevant to the given Project with the
		/// given selected treeview nodes.
		/// </summary>
		public void Configure(ArrayList nodes)
		{
			base.Items.Clear();

			MergableMenu menu = new MergableMenu();

			foreach (GenericNode node in nodes)
			{
				MergableMenu newMenu = new MergableMenu();
				AddItems(newMenu,node);
				menu = (menu.Count > 0) ? menu.Combine(newMenu) : newMenu;
			}

			menu.Apply(this.Items);

			// deal with special menu items that can't be applied to multiple paths
			bool singleFile = (nodes.Count == 1);
			AddMenu.IsEnabled = singleFile;
			Rename.IsEnabled = singleFile;
			Insert.IsEnabled = singleFile;
			Paste.IsEnabled = singleFile;

			// deal with naming the "Hide" button correctly
			if (nodes.Count > 1 || nodes.Count == 0) Hide.Text = "&Hide Items";
			else Hide.Text = (nodes[0] is DirectoryNode) ? "&Hide Folder" : "&Hide File";

			// deal with shortcuts
			AssignShortcuts();

			if (base.Items.Count == 0)
				base.Items.Add(NothingToDo);
		}

		protected override void OnPopup(EventArgs e)
		{
			// only enable paste if there is filedrop data in the clipboard
			if (!Clipboard.GetDataObject().GetDataPresent(DataFormats.FileDrop))
				Paste.IsEnabled = false;

			base.OnPopup(e);
		}

		public void AssignShortcuts()
		{
			Open.Shortcut = Keys.None;
			Insert.Shortcut = Keys.None;
			Rename.Shortcut = (Rename.IsEnabled) ? Keys.F2 : Keys.None;

			// PHILIPPE: Del/CtrlC/CtrlX/CtrlV shortcuts replaced by a KeyEvent handler
			
			//Delete.Shortcut = Keys.Delete;
			//Cut.Shortcut = Keys.Control | Keys.X;
			//Copy.Shortcut = Keys.Control | Keys.C;
			// Paste is special because we enable/disable it on popup instead of after
			// select.  We do this because its state depends on the clipboard, and once
			// the item is selected we don't know if the clipboard is changed.
			// So whoever listens to Paste.click needs to deal with ignoring garbage.
			//Paste.Shortcut = Keys.Control | Keys.V;
			
			if (base.Items.Contains(Open))
				Open.Shortcut = Keys.Enter;
			else
				Insert.Shortcut = Keys.Enter;			
		}
	
		#endregion

		#region Add Menu Items

		private void AddItems(MergableMenu menu, GenericNode node)
		{
			if (node.IsInvalid) return;

			string path = node.BackingPath;

			if (node is ProjectNode)
				AddProjectItems(menu);
			
			else if (node is ClasspathNode)
				AddClasspathItems(menu);

			else if (node is DirectoryNode)
				AddFolderItems(menu,path);
			
			else if (node is ProjectOutputNode)
				AddProjectOutputItems(menu,node as ProjectOutputNode);

			else if (node is ExportNode)
				AddExportItems(menu,node as ExportNode);

			else if (node is FileNode)
			{
				if (FileHelper.IsActionScript(path)) AddActionScriptItems(menu,path);
				else if (FileHelper.IsSwf(path)) AddSwfItems(menu,path);
				else if (FileHelper.IsResource(path)) AddOtherResourceItems(menu,path);
				else AddGenericFileItems(menu,path);
			}
		}

		private void AddExportItems(MergableMenu menu, ExportNode node)
		{
			// it DOES make sense to allow insert of assets inside the injection target!
			if (project.UsesInjection && 
				project.GetRelativePath(node.ContainingSwfPath) != project.InputPath)
				return;

			menu.Add(Insert,0);
		}

		private void AddProjectItems(MergableMenu menu)
		{
			bool showHidden = project.ShowHiddenPaths;

			menu.Add(menus.ProjectMenu.TestMovie,0);
			menu.Add(menus.ProjectMenu.BuildProject,0);
			menu.Add(AddMenu,1);
			menu.Add(Paste,2);
			menu.Add(ShowHidden,3,showHidden);
			menu.Add(menus.ProjectMenu.Properties,4);
		}

		private void AddClasspathItems(MergableMenu menu)
		{
			menu.Add(AddMenu,0);
			menu.Add(Paste,1);
		}

		private void AddFolderItems(MergableMenu menu, string path)
		{
			bool alwaysCompile = project.IsCompileTarget(path);

			menu.Add(AddMenu,0);
			menu.Add(AlwaysCompile,2,alwaysCompile);
			AddFileItems(menu,path,true);
		}

		private void AddActionScriptItems(MergableMenu menu, string path)
		{
			bool alwaysCompile = project.IsCompileTarget(path);
			bool addLibrary = project.IsLibraryAsset(path);

			menu.Add(Open,0);
			menu.Add(Execute,0);
			menu.Add(AlwaysCompile,2,alwaysCompile);
			
			AddFileItems(menu,path);
		}

		private void AddOtherResourceItems(MergableMenu menu, string path)
		{
			bool addLibrary = project.IsLibraryAsset(path);

			if (!project.UsesInjection)
				menu.Add(Insert,0);

			menu.Add(Execute,0);
			
			if (!project.UsesInjection)
				menu.Add(AddLibrary,2,addLibrary);

			if (addLibrary)
				menu.Add(LibraryOptions,2);

			AddFileItems(menu,path);
		}

		private void AddSwfItems(MergableMenu menu, string path)
		{
			bool addLibrary = project.IsLibraryAsset(path);

			menu.Add(Open,0);

			if (addLibrary)
			{
				LibraryAsset asset = project.GetAsset(path);
				if (asset.SwfMode == SwfAssetMode.Library)
					menu.Add(Insert,0);
			}

			menu.Add(Execute,0);

			if (!project.UsesInjection)
				menu.Add(AddLibrary,2,addLibrary);

			if (addLibrary) 
				menu.Add(LibraryOptions,2);

			AddFileItems(menu,path);
		}

		private void AddProjectOutputItems(MergableMenu menu, ProjectOutputNode node)
		{
			if (node.FileExists)
			{
				menu.Add(Open,0);
				menu.Add(Execute,0);
				AddFileItems(menu,node.BackingPath);
			}
			else menu.Add(NoProjectOutput,0);
		}

		private void AddFileItems(MergableMenu menu, string path, bool addPaste)
		{
			bool hidden = project.IsPathHidden(path);
			bool showHidden = project.ShowHiddenPaths;

			menu.Add(Cut,1);
			menu.Add(Copy,1);

			if (addPaste)
				menu.Add(Paste,1);

			menu.Add(Delete,1);
			menu.Add(Rename,1);
			menu.Add(Hide,3,hidden);
			menu.Add(ShowHidden,3,showHidden);
		}

		private void AddFileItems(MergableMenu menu, string path)
		{
			AddFileItems(menu,path,false);
		}

		private void AddGenericFileItems(MergableMenu menu, string path)
		{
			menu.Add(Open,0);
			menu.Add(Execute,0);
			AddFileItems(menu,path);
		}

		#endregion

		#region Helpers

		// there's no good override for CommandBarButton's constructor
		private static CommandBarButton CreateButton(string text, Image image)
		{
			CommandBarButton button = CreateButton(text);
			button.Image = image;
			return button;
		}

		private static CommandBarButton CreateButton(string text)
		{ return new CommandBarButton(text); }

		#endregion
	}
}
