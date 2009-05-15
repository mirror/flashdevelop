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

	public class ClasspathNode : WatcherNode
	{
        public string classpath;

		public ClasspathNode(Project project, string classpath, string text) : base(classpath)
		{
			isDraggable = false;
			isRenamable = false;

            this.classpath = classpath;

            // shorten text
            char sep = Path.DirectorySeparatorChar;
            string[] parts = text.Split(sep);
            string label = "";

            if (parts.Length > 0)
            {
                int index = parts.Length - 1;
                label = parts[parts.Length - 1];
            }

            Text = label;
            ToolTipText = classpath;
		}

		public override void Refresh(bool recursive)
		{

			base.Refresh(recursive);

            base.isInvalid = !Directory.Exists(BackingPath);

            if (!isInvalid)
            {
                ImageIndex = Icons.Classpath.Index;
            }
            else
            {
                ImageIndex = Icons.ClasspathError.Index;
            }

			SelectedImageIndex = ImageIndex;
		}
	}

    public class ProjectClasspathNode : ClasspathNode
    {
        public ProjectClasspathNode(Project project, string classpath, string text) : base(project, classpath, text)
        {
            if (text != Text)
            {
                ToolTipText = text;
            }
            else
            {
                ToolTipText = "";
            }
        }

        public override void Refresh(bool recursive)
        {
            base.Refresh(recursive);

            if (!IsInvalid)
            {
                ImageIndex = Icons.ProjectClasspath.Index;
            }
            else
            {
                ImageIndex = Icons.ProjectClasspathError.Index;
            }

            SelectedImageIndex = ImageIndex;
        }
    }
}
