using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;
using PluginCore;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.Controls
{
	public delegate Project ProjectRequestHandler();
	public delegate void ProjectOpenHandler(string projectPath);

	/// <summary>
	/// Provides a drop-down menu with a list of selectable recent open projects.
	/// </summary>
	public class RecentComboBox : CommandBarComboBox
	{
		ComboBox comboBox;

		public event ProjectRequestHandler RequestProject;
		public event ProjectOpenHandler OpenProject;

		public RecentComboBox(ComboBox comboBox) : base("Recent Projects",comboBox)
		{
			this.comboBox = comboBox;
			comboBox.DropDownStyle = ComboBoxStyle.DropDownList;
			comboBox.Font = new System.Drawing.Font("Tahoma", 8.25F);
			comboBox.SelectedIndexChanged += new EventHandler(comboBox_SelectedIndexChanged);
		}

		// we have to do this because you can only feed the CommandBarComboBox class
		// its ComboBox in the constructor, which is lame
		public static RecentComboBox Create()
		{
			ComboBox box = new ComboBox();
			return new RecentComboBox(box);
		}

		public ComboBox ComboBox { get { return comboBox; } }

		public void Add(Project project)
		{
			string recentString = project.Name + "?" + project.ProjectPath;
			foreach (RecentProject recentProject in comboBox.Items)
				if (recentProject.Name != project.Name)
					recentString += ";" + recentProject.Name + "?" + recentProject.Path;
			
			Settings.RecentProjects = recentString;

			Rebuild();
		}

		public void Rebuild()
		{
			Project currentProject = GetCurrentProject();

			int count = 0;
			comboBox.Items.Clear();
			comboBox.SelectedIndex = -1;

			// recent string is something like MyProject?C:\Code\MyProject.fdp;OtherProject?etc...
			foreach (string recentProjectString in Settings.RecentProjects.Split(';'))
			{
				if (recentProjectString.IndexOf("?") > -1) // reality check
				{
					RecentProject recentProject = new RecentProject(recentProjectString);
					if (File.Exists(recentProject.Path) && (count++ < Settings.MaxRecentProjects))
					{
						comboBox.Items.Add(recentProject);
						if (currentProject != null && 
							recentProject.Path == currentProject.ProjectPath)
							comboBox.SelectedItem = recentProject;
					}
				}
			}

			if (comboBox.Items.Count > 0)
				comboBox.Items.Add(new RecentProject("(clear list)?"));

			base.IsEnabled = (comboBox.Items.Count > 0);
		}

		public void SelectNone()
		{
			comboBox.SelectedIndex = -1;
		}

		void comboBox_SelectedIndexChanged(object sender, EventArgs e)
		{
			Project currentProject = GetCurrentProject();

			if (comboBox.SelectedItem != null)
			{
				if ((comboBox.SelectedItem as RecentProject).Name == "(clear list)")
				{
					Settings.RecentProjects = "";
					Rebuild();
					if (currentProject != null)
						Add(currentProject);
					return;
				}

				RecentProject recent = comboBox.SelectedItem as RecentProject;

				if (currentProject != null &&
					recent.Path == currentProject.ProjectPath)
					return; // already loaded

				// common enough to warrant a special check
				if (!File.Exists(recent.Path))
				{
					ErrorHandler.ShowInfo("The project '" + recent.Name + "' could not be located.  It will be removed from the list.");
					Rebuild();
					return;
				}

				if (OpenProject != null)
					OpenProject(recent.Path);
			}
		}

		// ask whoever created us to send us the currently open project so we can be smart
		Project GetCurrentProject()
		{
			if (RequestProject != null)
				return RequestProject();
			else
				return null;	
		}
	}
}
