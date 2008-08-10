using System;
using System.IO;
using System.Collections;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.Controls.TreeView
{
	public class PlaceholderNode : TreeNode {}

	public class DirectoryNode : WatcherNode
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
			foreach (TreeNode node in Nodes)
				if (node is GenericNode)
					(node as GenericNode).Dispose();
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
					Nodes.Add(new PlaceholderNode());

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
			ArrayList nodesToDie = new ArrayList();
			
			// don't remove project output node if it exists - it's annoying when it
			// disappears during a build
			foreach (GenericNode node in Nodes)
				if (node is ProjectOutputNode && !Project.IsPathHidden(node.BackingPath))
					node.Refresh(recursive);
				else
					nodesToDie.Add(node);

			PopulateDirectories(nodesToDie,recursive);
			PopulateFiles(nodesToDie,recursive);

			foreach (GenericNode node in nodesToDie)
			{
				node.Dispose();
				Nodes.Remove(node);
			}
		}

		private void PopulateDirectories(ArrayList nodesToDie, bool recursive)
		{
			foreach (string directory in Directory.GetDirectories(BackingPath))
			{
				if (IsDirectoryExcluded(directory))
					continue;

				if (Tree.NodeMap.Contains(directory))
				{
					DirectoryNode node = Tree.NodeMap[directory] as DirectoryNode;
					
					if (recursive)
						node.Refresh(recursive);
					
					nodesToDie.Remove(node);
				}
				else
				{
					DirectoryNode node = new DirectoryNode(directory);
					InsertNode(node);
					node.Refresh(recursive);
					nodesToDie.Remove(node);
				}
			}
		}

		private void PopulateFiles(ArrayList nodesToDie, bool recursive)
		{
			foreach (string file in Directory.GetFiles(BackingPath))
			{
				if (IsFileExcluded(file))
					continue;

				if (Tree.NodeMap.Contains(file))
				{
					GenericNode node = Tree.NodeMap[file] as GenericNode;
					node.Refresh(recursive);
					nodesToDie.Remove(node);
				}
				else
				{
					FileNode node = FileNode.Create(file);
					InsertNode(node);
					node.Refresh(recursive);
					nodesToDie.Remove(node);
				}
			}
		}

		/// <summary>
		/// Inserts a node in the correct location (sorting alphabetically by
		/// directories first, then files).
		/// </summary>
		/// <param name="node"></param>
		private void InsertNode(GenericNode node)
		{
			bool inserted = false;

			for (int i=0; i<Nodes.Count; i++)
			{
				GenericNode existingNode = Nodes[i] as GenericNode;

				if (node is FileNode && existingNode is DirectoryNode)
					continue;

				if (string.Compare(existingNode.Text,node.Text,true) > 0 ||
					node is DirectoryNode && existingNode is FileNode)
				{
					Nodes.Insert(i,node);
					inserted = true;
					break;
				}
			}

			if (!inserted)
				Nodes.Add(node); // append to the end of the list

			// is the tree looking to have this node selected?
			if (Tree.PathToSelect == node.BackingPath)
			{
				// use SelectedNode so multiselect treeview can handle painting
				Tree.SelectedNodes = new ArrayList(new object[]{node});
				Tree.PathToSelect = null;
				node.EnsureVisible();

				// if you created a new folder, then label edit it!
				if (node.Text.StartsWith("New Folder"))
				{
					Tree.EndUpdate();
					node.BeginEdit();
				}
			}
		}

		bool IsDirectoryExcluded(string path)
		{
			string dirName = Path.GetFileName(path);
			foreach (string excludedDir in ProjectTreeView.ExcludedDirectories)
				if (dirName.ToLower() == excludedDir)
					return true;

			return Project.IsPathHidden(path) && !Project.ShowHiddenPaths;
		}

		bool IsFileExcluded(string path)
		{
			if (path == Project.ProjectPath) return true;

			return (Project.IsPathHidden(path) || path.IndexOf("\\.") >= 0 || IsFileTypeHidden(path)) && !Project.ShowHiddenPaths;
		}
		
		bool IsFileTypeHidden(string path)
		{
			string ext = Path.GetExtension(path).ToLower();
			foreach(string exclude in ProjectTreeView.ExcludedFileTypes)
				if (ext == exclude) return true;
			return false;
		}
	}
}
