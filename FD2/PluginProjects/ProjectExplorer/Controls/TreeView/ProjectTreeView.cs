using System;
using System.Collections;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.Controls.TreeView
{
	public delegate void DragPathEventHandler(string fromPath, string toPath);

	/// <summary>
	/// The Project Explorer TreeView
	/// </summary>
	public class ProjectTreeView : ToolTippedTreeView
	{
		Hashtable nodeMap;
		Project project;
		string pathToSelect;

		public static ProjectTreeView Instance;
		public event DragPathEventHandler MovePath;
		public event DragPathEventHandler CopyPath;

		public static string[] ExcludedDirectories = new string[] 
			{ "bin", "obj", ".svn", "_svn", ".cvs", "_cvs", "_sgbak" };

		public static string[] ExcludedFileTypes = new string[] 
			{ ".p", ".abc", ".bak" };
		
		public ProjectTreeView()
		{
			Instance = this;
			MultiSelect = true;
			nodeMap = new Hashtable();
		}

		public void Select(string path)
		{
			if (nodeMap.Contains(path))
				SelectedNode = nodeMap[path] as GenericNode;
		}

		// this is called by GenericNode when a selected node is refreshed, so that
		// the context menu can rebuild itself accordingly.
		public void NotifySelectionChanged()
		{
			OnAfterSelect(new TreeViewEventArgs(SelectedNode));
		}

		#region Properties

		public Hashtable NodeMap
		{
			get { return nodeMap; }
		}

		public GenericNode GetNode(string path)
		{
			return nodeMap[path] as GenericNode;
		}

		public ICollection GetPaths()
		{
			return nodeMap.Keys;
		}

		public Project Project
		{
			get { return project; }
			set
			{
				// store old tree state
				if (project != null)
				{
					PluginData.GetPrefs(project).ExpandedPaths = ExpandedPaths;
					PluginData.Save();
				}

				project = value;
				RebuildTree(false);
			}
		}

		public string PathToSelect
		{
			get { return pathToSelect; }
			set { pathToSelect = value; }
		}

		public new GenericNode SelectedNode
		{
			get { return base.SelectedNode as GenericNode; }
			set { base.SelectedNode = value; }
		}

		public string SelectedPath
		{
			get
			{
				if (SelectedNode != null) return SelectedNode.BackingPath;
				else return null;
			}
		}

		public string[] SelectedPaths
		{
			get
			{
				ArrayList paths = new ArrayList();
				foreach (GenericNode node in SelectedNodes)
					paths.Add(node.BackingPath);
				return paths.ToArray(typeof(string)) as string[];
			}
			set
			{
				ArrayList nodes = new ArrayList();
				foreach (string path in value)
					if (nodeMap.Contains(path))
						nodes.Add(nodeMap[path]);
				SelectedNodes = nodes;
			}
		}

		public LibraryAsset SelectedAsset 
		{ 
			get { return project.GetAsset(SelectedPath); }
		}

		public string[] ExpandedPaths
		{
			get
			{
				ArrayList expanded = new ArrayList();
				AddExpanded(Nodes,expanded); // add in the correct order - top-down
				return expanded.ToArray(typeof(string)) as string[];
			}
			set
			{
				foreach (string path in value)
					if (nodeMap.Contains(path))
					{
						GenericNode node = nodeMap[path] as GenericNode;
						if (!(node is SwfFileNode))
						{
							node.Expand();
							node.Refresh(false);
						}
					}	
			}
		}

		private void AddExpanded(TreeNodeCollection nodes, ArrayList list)
		{
			foreach (GenericNode node in nodes)
				if (node.IsExpanded)
				{
					list.Add(node.BackingPath);
					AddExpanded(node.Nodes,list);
				}
		}

		#endregion

		#region TreeView Population

		/// <summary>
		/// Rebuilds the tree from scratch.
		/// </summary>
		public void RebuildTree(bool saveState)
		{
			// store old tree state
			if (project != null && saveState)
			{
				PluginData.GetPrefs(project).ExpandedPaths = ExpandedPaths;
				PluginData.Save();
			}

			foreach (GenericNode node in Nodes)
				node.Dispose();

			BeginUpdate();

			SelectedNodes = null;
			Nodes.Clear();
			nodeMap.Clear();
			ShowRootLines = false;
			
			if (project == null)
			{
				EndUpdate();
				return;
			}

			// create the top-level project node
			ProjectNode projectNode = new ProjectNode(project);
			Nodes.Add(projectNode);
			projectNode.Refresh(true);
			projectNode.Expand();
			
			ArrayList classpaths = new ArrayList();

			if (Settings.ShowProjectClasspaths)
				classpaths.AddRange(project.Classpaths);

			if (Settings.ShowGlobalClasspaths)
				classpaths.AddRange(Settings.GlobalClasspaths.Split(';'));

			// add classpaths at the top level also
			foreach (string classpath in classpaths)
			{
				string absolute = classpath;

				if (!Path.IsPathRooted(absolute))
					absolute = project.GetAbsolutePath(classpath);
				
				if (absolute.StartsWith(project.Directory))
					continue;

				ClasspathNode cpNode = new ClasspathNode(project,absolute,classpath);
				Nodes.Add(cpNode);
				cpNode.Refresh(true);
				ShowRootLines = true;
			}

			// restore tree state
			if (project != null && Settings.RestoreTreeState)
				ExpandedPaths = PluginData.GetPrefs(project).ExpandedPaths;

			// scroll to the top
			projectNode.EnsureVisible();
			SelectedNode = projectNode;
			Win32.Scrolling.scrollToLeft(this);

			EndUpdate();
		}

		/// <summary>
		/// Refreshes all visible nodes in-place.
		/// </summary>
		public void RefreshTree()
		{
			RefreshTree(null);
		}

		/// <summary>
		/// Refreshes only the nodes representing the given paths, or all nodes if
		/// paths is null.
		/// </summary>
		public void RefreshTree(string[] paths)
		{
			BeginUpdate();

			try
			{
				if (paths == null)
				{
					// full recursive refresh
					foreach (GenericNode node in Nodes)
						node.Refresh(true);
				}
				else
				{
					// selective refresh
					foreach (string path in paths)
						if (nodeMap.Contains(path))
							(nodeMap[path] as GenericNode).Refresh(false);
				}
			}
			finally { EndUpdate(); }
		}

		#endregion

		#region TreeView Overrides

		protected override void OnBeforeExpand(TreeViewCancelEventArgs e)
		{
			// signal the node about to expand that the expansion is coming
			GenericNode node = e.Node as GenericNode;
			if (node != null) node.BeforeExpand();

			base.OnBeforeExpand(e);
		}

		protected override void OnBeforeLabelEdit(NodeLabelEditEventArgs e)
		{
			base.OnBeforeLabelEdit(e);
			GenericNode node = e.Node as GenericNode;

			if (pathToSelect == node.BackingPath)
				e.CancelEdit = false;

			if (!node.IsRenamable)
				e.CancelEdit = true;
		}

		protected override void OnAfterSelect(TreeViewEventArgs e)
		{
			base.OnAfterSelect(e);
			HideSelection = (SelectedNode is ProjectNode);
		}

		protected override void OnItemDrag(ItemDragEventArgs e)
		{
			if ((e.Item as GenericNode).IsDraggable)
				base.OnItemDrag(e);
		}

		protected override void OnMoveNode(TreeNode node, TreeNode targetNode)
		{
			if (MovePath != null)
			{
				string fromPath = (node as GenericNode).BackingPath;
				string toPath = (targetNode as GenericNode).BackingPath;

				MovePath(fromPath,toPath);
			}
		}

		protected override void OnCopyNode(TreeNode node, TreeNode targetNode)
		{
			if (CopyPath != null)
			{
				string fromPath = (node as GenericNode).BackingPath;
				string toPath = (targetNode as GenericNode).BackingPath;

				CopyPath(fromPath,toPath);
			}			
		}

		protected override void OnFileDrop(string[] paths, TreeNode targetNode)
		{
			if (CopyPath != null)
			{
				string toPath = (targetNode as GenericNode).BackingPath;
				foreach (string fromPath in paths)
					CopyPath(fromPath,toPath);
			}
		}

		protected override TreeNode ChangeDropTarget(TreeNode targetNode)
		{
			// you can only drop things into folders
			GenericNode node = targetNode as GenericNode;

			while (node != null && (!node.IsDropTarget || node.IsInvalid))
				node = node.Parent as GenericNode;

			return node;
		}


		#endregion
	}
}
