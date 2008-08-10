using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.Diagnostics;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.Controls.TreeView
{
	public class ProjectNode : DirectoryNode
	{
		public ProjectNode(Project project) : base(project.Directory)
		{
			isDraggable = false;
			isRenamable = false;
		}

		public override void Refresh(bool recursive)
		{
			base.Refresh(recursive);

			Text = Project.Name;
			ImageIndex = Icons.Project.Index;
			SelectedImageIndex = ImageIndex;
			NodeFont = new System.Drawing.Font("Tahoma", 8.25F, FontStyle.Bold);
		}
	}

	public class ClasspathNode : DirectoryNode
	{
		public ClasspathNode(Project project, string classpath, string text) : base(classpath)
		{
			isDraggable = false;
			isRenamable = false;
			Text = text;
		}

		public override void Refresh(bool recursive)
		{
			base.Refresh(recursive);

			ImageIndex = Icons.Classpath.Index;
			SelectedImageIndex = ImageIndex;
		}
	}
}
