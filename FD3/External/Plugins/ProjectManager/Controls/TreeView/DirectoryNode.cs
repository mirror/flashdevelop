using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using PluginCore;
using PluginCore.Managers;
using ProjectManager.Projects;
using ProjectManager.Projects.AS3;
using ProjectManager.Controls.AS3;
using PluginCore.Localization;

namespace ProjectManager.Controls.TreeView
{
    public class PlaceholderNode : GenericNode
    {
        public PlaceholderNode(string backingPath) : base(backingPath) { }
    }

    public class DirectoryNode : GenericNode
	{
		bool dirty;

		public DirectoryNode(string directory) : base(directory)
		{
			isDraggable = true;
			isDropTarget = true;
			isRenamable = true;
		}

		public override void Dispose()
		{
			base.Dispose();
			// dispose children
			foreach (GenericNode node in Nodes)
                node.Dispose();
		}

		public override void Refresh(bool recursive)
		{
			if (IsInvalid) return;

			base.Refresh(recursive);

			if (Project.IsPathHidden(BackingPath))
				ImageIndex = Icons.HiddenFolder.Index;
			else if (Project.IsCompileTarget(BackingPath))
				ImageIndex = Icons.FolderCompile.Index;
			else
				ImageIndex = Icons.Folder.Index;

			SelectedImageIndex = ImageIndex;

			// make the plus/minus sign correct
			bool empty = Directory.GetFileSystemEntries(BackingPath).Length == 0;
			
			if (!empty)
			{
				// we want the plus sign because we have *something* in here
				if (Nodes.Count == 0)
					Nodes.Add(new PlaceholderNode(Path.Combine(BackingPath,"placeholder")));

				// we're already expanded, so refresh our children
				if (IsExpanded || Path.GetDirectoryName(Tree.PathToSelect) == BackingPath)
					PopulateChildNodes(recursive);
				else
					dirty = true; // refresh on demand
			}
			else
			{
				// we just became empty!
				if (Nodes.Count > 0)
					PopulateChildNodes(recursive);
			}
		}

		/// <summary>
		/// Signal this node that it is about to expand.
		/// </summary>
		public override void BeforeExpand()
		{
			if (dirty) PopulateChildNodes(false);
		}

		private void PopulateChildNodes(bool recursive)
		{
			dirty = false;

			// nuke the placeholder
			if (Nodes.Count == 1 && Nodes[0] is PlaceholderNode)
				Nodes.RemoveAt(0);

			// do a nice stateful update against the filesystem
            GenericNodeList nodesToDie = new GenericNodeList();
			
			// don't remove project output node if it exists - it's annoying when it
			// disappears during a build
            foreach (GenericNode node in Nodes)
            {
                if (node is ProjectOutputNode && !Project.IsPathHidden((node as ProjectOutputNode).BackingPath))
                    (node as ProjectOutputNode).Refresh(recursive);
                else
                    nodesToDie.Add(node);

                // add any mapped nodes
                if (node is FileNode && !(node is SwfFileNode))
                    nodesToDie.AddRange(node.Nodes);
            }

			PopulateDirectories(nodesToDie,recursive);
			PopulateFiles(nodesToDie,recursive);

			foreach (GenericNode node in nodesToDie)
			{
                node.Dispose();
				Nodes.Remove(node);
			}
		}

        private void PopulateDirectories(GenericNodeList nodesToDie, bool recursive)
		{
			foreach (string directory in Directory.GetDirectories(BackingPath))
			{
				if (IsDirectoryExcluded(directory))
					continue;

				if (Tree.NodeMap.ContainsKey(directory))
				{
					DirectoryNode node = Tree.NodeMap[directory] as DirectoryNode;
					
					if (recursive)
						node.Refresh(recursive);
					
					nodesToDie.Remove(node);
				}
				else
				{
					DirectoryNode node = new DirectoryNode(directory);
					InsertNode(Nodes, node);
					node.Refresh(recursive);
					nodesToDie.Remove(node);
				}
			}
		}

        private void PopulateFiles(GenericNodeList nodesToDie, bool recursive)
		{
            string[] files = Directory.GetFiles(BackingPath);

			foreach (string file in files)
			{
				if (IsFileExcluded(file))
					continue;

				if (Tree.NodeMap.ContainsKey(file))
				{
                    GenericNode node = Tree.NodeMap[file];
					node.Refresh(recursive);
					nodesToDie.Remove(node);
				}
				else
				{
					FileNode node = FileNode.Create(file);
					InsertNode(Nodes, node);
					node.Refresh(recursive);
					nodesToDie.Remove(node);
				}
			}

            FileMapping mapping = GetFileMapping(files);

            foreach (string file in files)
            {
                if (IsFileExcluded(file))
                    continue;

                GenericNode node = Tree.NodeMap[file];

                // ensure this file is in the right spot
                if (mapping.ContainsKey(file) && Tree.NodeMap.ContainsKey(mapping[file]))
                    EnsureParentedBy(node, Tree.NodeMap[mapping[file]]);
                else
                    EnsureParentedBy(node, this);
            }
		}

        private void EnsureParentedBy(GenericNode child, GenericNode parent)
        {
            if (child.Parent != parent)
            {
                child.Parent.Nodes.Remove(child);
                InsertNode(parent.Nodes, child);
            }
        }

        // Let another plugin extend the tree by specifying mapping
        private FileMapping GetFileMapping(string[] files)
        {
            // Give plugins a chance to respond first
            FileMappingRequest request = new FileMappingRequest(files);
            DataEvent e = new DataEvent(EventType.Command, ProjectManagerEvents.FileMapping, request);
            EventManager.DispatchEvent(this, e);

            // No one cares?  ok, well we do know one thing: Mxml
            if (request.Mapping.Count == 0 && Tree.Project is AS3Project && !PluginMain.Settings.DisableMxmlMapping)
                MxmlFileMapping.AddMxmlMapping(request);

            return request.Mapping;
        }

		/// <summary>
		/// Inserts a node in the correct location (sorting alphabetically by
		/// directories first, then files).
		/// </summary>
		/// <param name="node"></param>
		private static void InsertNode(TreeNodeCollection nodes, GenericNode node)
		{
			bool inserted = false;

			for (int i=0; i<nodes.Count; i++)
			{
                GenericNode existingNode = nodes[i] as GenericNode;

				if (node is FileNode && existingNode is DirectoryNode)
					continue;

				if (string.Compare(existingNode.Text,node.Text,true) > 0 ||
					node is DirectoryNode && existingNode is FileNode)
				{
					nodes.Insert(i,node);
					inserted = true;
					break;
				}
			}

			if (!inserted)
				nodes.Add(node); // append to the end of the list

			// is the tree looking to have this node selected?
			if (Tree.PathToSelect == node.BackingPath)
			{
				// use SelectedNode so multiselect treeview can handle painting
				Tree.SelectedNodes = new ArrayList(new object[]{node});
				Tree.PathToSelect = null;
				node.EnsureVisible();

				// if you created a new folder, then label edit it!
                string label = TextHelper.GetString("Label.NewFolder").Replace("&", "").Replace("...", "");
                if (node.Text.StartsWith(label))
				{
					Tree.EndUpdate();
					node.BeginEdit();
				}
			}
		}

		bool IsDirectoryExcluded(string path)
		{
			string dirName = Path.GetFileName(path);
			foreach (string excludedDir in PluginMain.Settings.ExcludedDirectories)
				if (dirName.Equals(excludedDir, StringComparison.OrdinalIgnoreCase))
					return true;

			return Project.IsPathHidden(path) && !Project.ShowHiddenPaths;
		}

		bool IsFileExcluded(string path)
		{
			if (path == Project.ProjectPath) return true;

			return (Project.IsPathHidden(path) || path.IndexOf("\\.") >= 0 || ProjectTreeView.IsFileTypeHidden(path)) && !Project.ShowHiddenPaths;
		}
	}
}
