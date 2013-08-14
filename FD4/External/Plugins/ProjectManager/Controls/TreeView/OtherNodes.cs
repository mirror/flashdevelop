using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.Diagnostics;
using ProjectManager.Projects;
using System.Text.RegularExpressions;
using System.Collections.Generic;

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

            NotifyRefresh();
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
            string[] excludes = PluginMain.Settings.FilteredDirectoryNames;
            char sep = Path.DirectorySeparatorChar;
            string[] parts = text.Split(sep);
            List<string> label = new List<string>();
            Regex reVersion = new Regex("^[0-9]+[.,-][0-9]+");

            if (parts.Length > 0)
            {
                for (int i = parts.Length - 1; i > 0; --i)
                {
                    String part = parts[i] as String;
                    if (part != "" && part != "." && part != ".." && Array.IndexOf(excludes, part.ToLower()) == -1)
                    {
                        if (Char.IsDigit(part[0]) && reVersion.IsMatch(part)) label.Add(part);
                        else
                        {
                            label.Add(part);
                            break;
                        }
                    }
                    else label.Add(part);
                }
            }
            label.Reverse();
            Text = String.Join("/", label.ToArray());
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

            NotifyRefresh();
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

            NotifyRefresh();
        }
    }
}
