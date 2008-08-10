using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.Diagnostics;
using ProjectExplorer.Helpers;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.Controls.TreeView
{
	/// <summary>
	/// Represents a file on disk.
	/// </summary>
	public class FileNode : GenericNode
	{
		// store all extension icons we've pulled from the file system
		static Hashtable extensionIcons = new Hashtable();

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
			else if (FileHelper.IsSwf(filePath))
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
			else if (FileHelper.IsActionScript(path))
				ImageIndex = (Project.IsCompileTarget(path)) ? 
					Icons.ActionScriptCompile.Index : Icons.ActionScript.Index;
			else if (FileHelper.IsFont(path))
				ImageIndex = Icons.Font.Index;
			else if (FileHelper.IsImage(path))
				ImageIndex = Icons.ImageResource.Index;
			else if (FileHelper.IsSwf(path))
				ImageIndex = Icons.SwfFile.Index;
			else if (FileHelper.IsHtml(path))
				ImageIndex = Icons.HtmlFile.Index;
			else if (FileHelper.IsXml(path))
				ImageIndex = Icons.XmlFile.Index;
			else if (FileHelper.IsText(path))
				ImageIndex = Icons.TextFile.Index;
			else
				ImageIndex = ExtractIconIfNecessary(path);

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

		private int ExtractIconIfNecessary(string file)
		{
			string extension = Path.GetExtension(file);
			if (extensionIcons.ContainsKey(extension))
			{
				return (int)extensionIcons[extension];
			}
			else
			{
				Icon icon = ExtractIconClass.GetIcon(file, true);
				TreeView.ImageList.Images.Add(icon);
				int index = TreeView.ImageList.Images.Count - 1; // of the icon we just added
				extensionIcons.Add(extension, index);
				return index;
			}
		}
	}

	/// <summary>
	/// A special FileNode that represents the project output file.  It won't disappear
	/// from the treeview while you're building.
	/// </summary>
	public class ProjectOutputNode : FileNode
	{
		public ProjectOutputNode(string filePath) : base(filePath) {}

		public override void Refresh(bool recursive)
		{
			base.Refresh(recursive);

			if (!FileExists)
				ImageIndex = SelectedImageIndex = Icons.SwfFileHidden.Index;
		}

		public bool FileExists { get { return File.Exists(BackingPath); } }
	}
}
