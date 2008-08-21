using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.Diagnostics;
using ProjectManager.Projects;

namespace ProjectManager.Controls.TreeView
{
	public class ProjectNode : WatcherNode
	{
		public ProjectNode(Project project) : base(project.Directory)
		{
			isDraggable = false;
			isRenamable = false;
		}

		public override void Refresh(bool recursive)
		{
			base.Refresh(recursive);
            Text = Project.Name + " (" + Project.Language.ToUpper() + ")";
			ImageIndex = Icons.Project.Index;
			SelectedImageIndex = ImageIndex;
			NodeFont = new System.Drawing.Font(PluginCore.PluginBase.Settings.DefaultFont, FontStyle.Bold);
            Expand();
		}
	}

	public class ClasspathNode : DirectoryNode
	{
		public ClasspathNode(Project project, string classpath, string text) : base(classpath)
		{
			isDraggable = false;
			isRenamable = false;

            // shorten text
            char sep = Path.DirectorySeparatorChar;
            string[] parts = text.Split(sep);
            if (parts.Length > 0)
            {
                int index = parts.Length - 1;
                text = parts[index--];
                while (index >= 0 && text.Length < 30 && parts[index] != "..")
                    text = parts[index--] + sep + text;
            }

			Text = text;
            ToolTipText = classpath;
		}

		public override void Refresh(bool recursive)
		{
			base.Refresh(recursive);

			ImageIndex = Icons.Classpath.Index;
			SelectedImageIndex = ImageIndex;
		}
	}
}
