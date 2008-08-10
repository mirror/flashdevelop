using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.Diagnostics;
using ProjectManager.Helpers;
using ProjectManager.Projects;
using PluginCore.Utilities;

namespace ProjectManager.Controls.TreeView
{
	/// <summary>
	/// Represents a file on disk.
	/// </summary>
	public class FileNode : GenericNode
	{
		protected FileNode(string filePath) : base(filePath)
		{
			isDraggable = true;
			isRenamable = true;
		}

		/// <summary>
		/// Creates the correct type of FileNode based on the file name.
		/// </summary>
		public static FileNode Create(string filePath)
		{
            if (Project.IsOutput(filePath))
                return new ProjectOutputNode(filePath);
            else if (Project.IsInput(filePath))
                return new InputSwfNode(filePath);
            else if (FileInspector.IsSwf(filePath) || FileInspector.IsSwc(filePath))
                return new SwfFileNode(filePath);
            else
                return new FileNode(filePath);
		}

		public override void Refresh(bool recursive)
		{
			base.Refresh(recursive);

			string path = BackingPath;

            if (Project.IsPathHidden(path))
                ImageIndex = Icons.HiddenFile.Index;
            else if ((FileInspector.IsActionScript(path) || FileInspector.IsHaxeFile(path))
                    && Project.IsCompileTarget(path))
                ImageIndex = Icons.ActionScriptCompile.Index;
            else if (FileInspector.IsMxml(path) && Project.IsCompileTarget(path))
                ImageIndex = Icons.MxmlFileCompile.Index;
            else
                ImageIndex = Icons.GetImageForFile(path).Index;

			SelectedImageIndex = ImageIndex;

			Text = Path.GetFileName(path);

			if (Project.IsLibraryAsset(path))
			{
				ForeColorRequest = Color.Blue;
				LibraryAsset asset = Project.GetAsset(path);

				if (asset != null && asset.HasManualID)
					Text += " ("+asset.ManualID+")";
			}
			else ForeColorRequest = Color.Black;
		}
	}

	/// <summary>
	/// A special FileNode that represents the project output file.  It won't disappear
	/// from the treeview while you're building.
	/// </summary>
	public class ProjectOutputNode : SwfFileNode
	{
		public ProjectOutputNode(string filePath) : base(filePath) {}

		public override void Refresh(bool recursive)
		{
			base.Refresh(recursive);

			if (!FileExists)
				ImageIndex = SelectedImageIndex = Icons.SwfFileHidden.Index;
		}
	}
}
