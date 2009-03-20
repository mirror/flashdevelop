using System;
using System.Collections;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using ProjectManager.Projects;
using System.Collections.Generic;
using System.Collections.Specialized;
using ProjectManager.Projects.AS3;

namespace ProjectManager.Controls.TreeView
{
	public delegate void DragPathEventHandler(string fromPath, string toPath);

	/// <summary>
	/// The Project Explorer TreeView
	/// </summary>
    public class ProjectTreeView : DragDropTreeView
	{
        Dictionary<string, GenericNode> nodeMap;
		Project project;
		string pathToSelect;

		public static ProjectTreeView Instance;
		public event DragPathEventHandler MovePath;
		public event DragPathEventHandler CopyPath;
        public new event EventHandler DoubleClick;

		public ProjectTreeView()
		{
			Instance = this;
			MultiSelect = true;
            nodeMap = new Dictionary<string, GenericNode>();
		}

		public void Select(string path)
		{
            if (nodeMap.ContainsKey(path))
                SelectedNode = nodeMap[path];
		}

		// this is called by GenericNode when a selected node is refreshed, so that
		// the context menu can rebuild itself accordingly.
		public void NotifySelectionChanged()
		{
			OnAfterSelect(new TreeViewEventArgs(SelectedNode));
		}

        public static bool IsFileTypeHidden(string path)
        {
            if (Path.GetFileName(path).StartsWith("~$")) return true;
            string ext = Path.GetExtension(path).ToLower();
            foreach (string exclude in PluginMain.Settings.ExcludedFileTypes)
                if (ext == exclude) return true;
            return false;
        }

        public void RefreshNode(GenericNode node)
        {
            // refresh the first parent that *can* be refreshed
            while (node != null && !node.IsRefreshable)
            {
                node = node.Parent as GenericNode;
            }
            if (node == null) return;
            // if you refresh a SwfFileNode this way (by asking for it), you get
            // special feedback
            SwfFileNode swfNode = node as SwfFileNode;

            if (swfNode != null) swfNode.RefreshWithFeedback(true);
            else node.Refresh(true);
        }

        #region Custom Double-Click Behavior

        protected override void DefWndProc(ref Message m)
        {
            if (m.Msg == 515 && DoubleClick != null) // WM_LBUTTONDBLCLK - &H203
            {
                // ok, we only want the base treeview to handle double-clicking to expand things
                // if there's one node selected and it's a folder.
                if (SelectedNodes.Count == 1 && SelectedNode is DirectoryNode)
                    base.DefWndProc(ref m);
                else
                    DoubleClick(this, EventArgs.Empty); // let someone else handle it!
            }
            else base.DefWndProc(ref m);
        }

        #endregion

        #region Properties

        public IDictionary<string, GenericNode> NodeMap
		{
			get { return nodeMap; }
		}

		public Project Project
		{
			get { return project; }
			set
			{
				project = value;
				RebuildTree(false);

                if (project != null)
                    ExpandedPaths = PluginMain.Settings.GetPrefs(project).ExpandedPaths;
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
                {
                    paths.Add(node.BackingPath);

                    // if this is a "mapped" file, that is a file that "hides" other related files,
                    // make sure we select the related files also.
                    // DISABLED - causes inconsistent behavior
                    /*if (node is FileNode)
                        foreach (GenericNode mappedNode in node.Nodes)
                            if (mappedNode is FileNode)
                                paths.Add(mappedNode.BackingPath);*/
                }
				return paths.ToArray(typeof(string)) as string[];
			}
			set
			{
				ArrayList nodes = new ArrayList();
				foreach (string path in value)
					if (nodeMap.ContainsKey(path))
						nodes.Add(nodeMap[path]);
				SelectedNodes = nodes;
			}
		}

		public LibraryAsset SelectedAsset 
		{ 
			get { return project.GetAsset(SelectedPath); }
		}

		public List<string> ExpandedPaths
		{
			get
			{
                List<string> expanded = new List<string>();
				AddExpanded(Nodes,expanded); // add in the correct order - top-down
                return expanded;
			}
			set
			{
				foreach (string path in value)
					if (nodeMap.ContainsKey(path))
					{
                        GenericNode node = nodeMap[path];
						if (!(node is SwfFileNode))
						{
							node.Expand();
							node.Refresh(false);
						}
					}	
			}
		}

		private void AddExpanded(TreeNodeCollection nodes, List<string> list)
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
            List<string> previouslyExpanded = ExpandedPaths;
			
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

			if (PluginMain.Settings.ShowProjectClasspaths)
				classpaths.AddRange(project.Classpaths);

			if (PluginMain.Settings.ShowGlobalClasspaths)
				classpaths.AddRange(PluginMain.Settings.GlobalClasspaths);

			// add external classpaths at the top level also
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

            // add external libraries at the top level also
            if (project is AS3Project)
            foreach (LibraryAsset asset in (project as AS3Project).SwcLibraries)
            {
                if (!asset.IsSwc) continue;
                // check if SWC is inside the project or inside a classpath
                string absolute = asset.Path;
                if (!Path.IsPathRooted(absolute))
                    absolute = project.GetAbsolutePath(asset.Path);

                bool showNode = true;
                if (absolute.StartsWith(project.Directory))
                    showNode = false;
                foreach (string path in project.AbsoluteClasspaths)
                    if (absolute.StartsWith(path))
                    {
                        showNode = false;
                        break;
                    }
                foreach (string path in PluginMain.Settings.GlobalClasspaths)
                    if (absolute.StartsWith(path))
                    {
                        showNode = false;
                        break;
                    }

                if (showNode)
                {
                    SwfFileNode swcNode = new SwfFileNode(absolute);
                    Nodes.Add(swcNode);
                    swcNode.Refresh(true);
                    ShowRootLines = true;
                }
            }

			// restore tree state
			ExpandedPaths = previouslyExpanded;

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
						if (nodeMap.ContainsKey(path))
							nodeMap[path].Refresh(false);
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
			if (e.Item is GenericNode && (e.Item as GenericNode).IsDraggable)
				base.OnItemDrag(e);
		}

        protected override DataObject BeginDragNodes(ArrayList nodes)
        {
            DataObject data = base.BeginDragNodes(nodes);

            // we also want to drag files, not just nodes, so that we can drop
            // them on explorer, etc.
            StringCollection paths = new StringCollection();

            foreach (GenericNode node in nodes)
                paths.Add(node.BackingPath);

            data.SetFileDropList(paths);
            return data;
        }

		protected override void OnMoveNode(TreeNode node, TreeNode targetNode)
		{
			if (MovePath != null && node is GenericNode)
			{
				string fromPath = (node as GenericNode).BackingPath;
				string toPath = (targetNode as GenericNode).BackingPath;

				MovePath(fromPath,toPath);
			}
		}

		protected override void OnCopyNode(TreeNode node, TreeNode targetNode)
		{
            if (CopyPath != null && node is GenericNode)
			{
				string fromPath = (node as GenericNode).BackingPath;
				string toPath = (targetNode as GenericNode).BackingPath;

				CopyPath(fromPath,toPath);
			}			
		}

		protected override void OnFileDrop(string[] paths, TreeNode targetNode)
		{
            if (CopyPath != null && targetNode is GenericNode)
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
