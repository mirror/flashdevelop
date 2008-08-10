using System;
using System.Collections;
using System.Diagnostics;
using System.Windows.Forms;
using ProjectExplorer.Controls;
using PluginCore;

namespace ProjectExplorer.Controls
{
	public class FDMenus
	{
		public CommandBarButton View;
		public CommandBarButton GlobalClasspaths;
		public RecentComboBox RecentComboBox;
		public ProjectMenu ProjectMenu;

		public FDMenus(IMainForm mainForm)
		{
			// modify the view menu
			CommandBarMenu viewMenu = mainForm.GetCBMenu("ViewMenu");
			View = new CommandBarButton("&Project Explorer");
			View.Image = Icons.Project.Img;
			viewMenu.Items.Add(View);

			// modify the tools menu - add a nice GUI classpath editor
			GlobalClasspaths = new CommandBarButton("&Global Classpaths...");
			GlobalClasspaths.Shortcut = Keys.F9 | Keys.Control;

			mainForm.IgnoredKeys.Add(GlobalClasspaths.Shortcut);

			CommandBarMenu toolsMenu = mainForm.GetCBMenu("ToolsMenu");
			toolsMenu.Items.AddSeparator();
			toolsMenu.Items.Add(GlobalClasspaths);

			ProjectMenu = new ProjectMenu();

			CommandBar mainMenu = mainForm.GetCBMainMenu();
			mainMenu.Items.Insert(5, ProjectMenu);

			RecentComboBox = RecentComboBox.Create();

			CommandBar toolBar = mainForm.GetCBToolbar();

			if (toolBar != null) // you might have turned off the toolbar
			{
				toolBar.Items.AddSeparator();
				toolBar.Items.Add(ProjectMenu.TestMovie);
				toolBar.Items.Add(RecentComboBox);
			}
		}
	}

	/// <summary>
	/// The "Project" menu for FD's main menu
	/// </summary>
	public class ProjectMenu : CommandBarMenu
	{
		public CommandBarButton NewProject;
		public CommandBarButton OpenProject;
		public CommandBarButton CloseProject;
		public CommandBarButton TestMovie;
		public CommandBarButton BuildProject;
		public CommandBarButton Properties;

		public ProjectMenu()
		{
			NewProject = new CommandBarButton("&New Project..");
			NewProject.Image = Icons.NewProject.Img;

			OpenProject = new CommandBarButton("&Open Project..");

			CloseProject = new CommandBarButton("&Close Project");

			TestMovie = new CommandBarButton("&Test Movie");
			TestMovie.Image = Icons.GreenCheck.Img;

			BuildProject = new CommandBarButton("&Build Project");
			BuildProject.Image = Icons.Gear.Img;

			Properties = new CommandBarButton("&Properties");
			Properties.Image = Icons.Options.Img;

			base.Text = "&Project";
			base.Items.Add(NewProject);
			base.Items.Add(OpenProject);
			base.Items.Add(CloseProject);
			base.Items.AddSeparator();
			base.Items.Add(TestMovie);
			base.Items.Add(BuildProject);
			base.Items.AddSeparator();
			base.Items.Add(Properties);
		}

		public bool ItemsEnabled
		{
			set
			{
				CloseProject.IsEnabled = value;
				TestMovie.IsEnabled = value;
				TestMovie.Shortcut = (value) ? Keys.F5 : Keys.None;
				BuildProject.IsEnabled = value;
				BuildProject.Shortcut = (value) ? Keys.F8 : Keys.None;
				Properties.IsEnabled = value;
			}
		}
	}
}
