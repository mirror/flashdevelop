using System;
using System.ComponentModel;
using System.Collections;
using System.Diagnostics;
using System.Drawing;
using System.Data;
using System.IO;
using System.Text;
using System.Windows.Forms;
using PluginCore;
using ProjectExplorer.Actions;
using ProjectExplorer.Helpers;
using ProjectExplorer.Controls;
using ProjectExplorer.Controls.TreeView;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer
{
	public delegate void RenameEventHandler(string path, string newName);

	public class PluginUI : UserControl
	{
		PluginMain plugin;
		FDMenus menus;
		TreeBar treeBar;
		Project project;
		ProjectTreeView tree;
		ProjectContextMenu menu;
		bool isEditingLabel;

		public event EventHandler NewProject;
		public event EventHandler OpenProject;
		public event RenameEventHandler Rename;

		public PluginUI(PluginMain plugin, FDMenus menus, 
			FileActions fileActions, ProjectActions projectActions)
		{
			this.plugin = plugin;
			this.menus = menus;
			this.Tag = "Project";
			this.Text = "Project Explorer";

			#region Build TreeView

			menu = new ProjectContextMenu(menus);
			menu.Rename.Click += new EventHandler(RenameNode);

			treeBar = new TreeBar(menus,menu);
			treeBar.Dock = DockStyle.Top;
			treeBar.Visible = false;

			tree = new ProjectTreeView();
			tree.Visible = false;
			tree.Dock = DockStyle.Fill;
			tree.ImageIndex = 0;
			tree.ImageList = Icons.ImageList;
			tree.LabelEdit = true;
			tree.SelectedImageIndex = 0;
			tree.ShowRootLines = false;
			tree.HideSelection = false;
			tree.ContextMenu = menu;
			tree.DoubleClick += new EventHandler(tree_DoubleClick);
			tree.AfterLabelEdit += new NodeLabelEditEventHandler(tree_AfterLabelEdit);
			tree.BeforeLabelEdit += new NodeLabelEditEventHandler(tree_BeforeLabelEdit);
			tree.AfterSelect += new TreeViewEventHandler(tree_AfterSelect);
			
			this.Controls.Add(tree);
			this.Controls.Add(treeBar);

			#endregion

			#region Instructions

			LinkLabel link = new LinkLabel();
			link.Text = "Create a new project\nor\nOpen an existing project";
			link.Links.Add(0,20,"create");
			link.Links.Add(24,24,"open");
			link.LinkClicked += new LinkLabelLinkClickedEventHandler(link_LinkClicked);
			link.TextAlign = ContentAlignment.MiddleCenter;
			link.Dock = DockStyle.Fill;
			link.ContextMenu = new ContextMenu();
			this.Controls.Add(link);

			#endregion

			// we care about some of these events
			fileActions.FileCreated += new FileNameHandler(NewFileCreated);
			fileActions.ProjectModified += new ProjectModifiedHandler(ProjectModified);
			projectActions.ProjectModified += new ProjectModifiedHandler(ProjectModified);
		}

		#region Properties

		public Project Project
		{
			get { return project; }
			set
			{
				if (project == value)
					return;

				project = value;
				menu.Project = project;
				tree.Project = project;
				tree.Visible = project != null;
				treeBar.Visible = project != null;
			}
		}

		public ProjectTreeView Tree { get { return tree; } }
		public ProjectContextMenu Menu { get { return menu; } }
		public TreeBar TreeBar { get { return treeBar; } }
		
		public bool IsTraceDisabled { get { return !treeBar.EnableTrace.IsChecked; } }

		// PHILIPPE: a label of the project tree is currently beeing edited
		public bool IsEditingLabel { 
			get { return isEditingLabel; }
			set {
				isEditingLabel = value;
			}
		}
		
		#endregion

		// instructions panel
		private void link_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
		{
			if (e.Link.LinkData as string == "create" && NewProject != null)
				NewProject(sender,e);
			else if (e.Link.LinkData as string == "open" && OpenProject != null)
				OpenProject(sender,e);
		}

		/// <summary>
		/// Look for a parent node of the given path (if it exists) and 
		/// ask it to refresh.  This is necessary because filesystemwatcher 
		/// doesn't always work over network shares.
		/// </summary>
		public void WatchParentOf(string path)
		{
			string parent = Path.GetDirectoryName(path);
			WatcherNode node = tree.NodeMap[parent] as WatcherNode;
			if (node != null) node.UpdateLater();
		}

		#region TreeView Events

		void tree_BeforeLabelEdit(object sender, NodeLabelEditEventArgs e)
		{
			// we don't want to trigger these while editing
			if (!e.CancelEdit)
			{
				menu.Open.Shortcut = menu.Insert.Shortcut = /*menu.Delete.Shortcut =*/ Keys.None;
				isEditingLabel = true;
			}
		}

		void tree_AfterLabelEdit(object sender, NodeLabelEditEventArgs e)
		{
			if (e.Label != null && Rename != null) // happens if you back out
				Rename((e.Node as GenericNode).BackingPath, e.Label);
			else
			{
				e.CancelEdit = true;
				menu.AssignShortcuts(); // restore shortcuts
			}
			isEditingLabel = false;
		}

		void tree_DoubleClick(object sender, EventArgs e)
		{
			if (tree.SelectedNode.Nodes.Count == 0)
			{
				// PHILIPPE: Vista doesn't let us use SendKeys...
				//SendKeys.Send("\r"); // simulate "enter"
				if (menu.Open.Shortcut == Keys.Enter)
					plugin.TreeOpenItems(sender, e);
				else if (menu.Insert.Shortcut == Keys.Enter)
					plugin.TreeInsertItem(sender, e);
			}
		}

		void tree_AfterSelect(object sender, TreeViewEventArgs e)
		{
			menu.Configure(tree.SelectedNodes);
		}

		#endregion

		private void NewFileCreated(string path)
		{
			// a new file was created and we want it to be selected after
			// the filesystemwatcher finds it and makes us refresh
			tree.PathToSelect = path;
			WatchParentOf(path);
		}

		private void RenameNode(object sender, EventArgs e)
		{
			tree.ForceLabelEdit();
		}

		private void ProjectModified(string[] paths)
		{
			// the project has changed, so refresh the tree
			tree.RefreshTree(paths);
		}
	}
}
