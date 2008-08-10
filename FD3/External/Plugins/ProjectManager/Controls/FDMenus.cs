using System;
using System.Collections;
using System.Diagnostics;
using System.Windows.Forms;
using ProjectManager.Controls;
using PluginCore.Localization;
using PluginCore;
using PluginCore.Utilities;

namespace ProjectManager.Controls
{
	public class FDMenus
	{
        public ToolStripMenuItem View;
        public ToolStripMenuItem GlobalClasspaths;
        public ToolStripButton TestMovie;
        public ToolStripButton BuildProject;
        public ToolStripComboBox ConfigurationSelector;
        public RecentProjectsMenu RecentProjects;
		public ProjectMenu ProjectMenu;

		public FDMenus(IMainForm mainForm)
		{
            // modify the file menu
            ToolStripMenuItem fileMenu = (ToolStripMenuItem)mainForm.FindMenuItem("FileMenu");
            RecentProjects = new RecentProjectsMenu();
            fileMenu.DropDownItems.Insert(5, RecentProjects);

            // modify the view menu
            ToolStripMenuItem viewMenu = (ToolStripMenuItem)mainForm.FindMenuItem("ViewMenu");
            View = new ToolStripMenuItem(TextHelper.GetString("Label.MainMenuItem"));
			View.Image = Icons.Project.Img;
			viewMenu.DropDownItems.Add(View);

			// modify the tools menu - add a nice GUI classpath editor
            ToolStripMenuItem toolsMenu = (ToolStripMenuItem)mainForm.FindMenuItem("ToolsMenu");
            GlobalClasspaths = new ToolStripMenuItem(TextHelper.GetString("Label.GlobalClasspaths"));
			GlobalClasspaths.ShortcutKeys = Keys.F9 | Keys.Control;
            GlobalClasspaths.Image = Icons.Classpath.Img;
            toolsMenu.DropDownItems.Insert(toolsMenu.DropDownItems.Count - 2, GlobalClasspaths);
            mainForm.IgnoredKeys.Add(GlobalClasspaths.ShortcutKeys);

			ProjectMenu = new ProjectMenu();

            MenuStrip mainMenu = mainForm.MenuStrip;
            mainMenu.Items.Insert(5, ProjectMenu);

            ToolStrip toolBar = mainForm.ToolStrip;
			toolBar.Items.Add(new ToolStripSeparator());

            toolBar.Items.Add(RecentProjects.ToolbarSelector);

            BuildProject = new ToolStripButton(Icons.Gear.Img);
            BuildProject.Name = "BuildProject";
            BuildProject.ToolTipText = TextHelper.GetString("Label.BuildProject").Replace("&", "");
            toolBar.Items.Add(BuildProject);

            TestMovie = new ToolStripButton(Icons.GreenCheck.Img);
            TestMovie.Name = "TestMovie";
            TestMovie.ToolTipText = TextHelper.GetString("Label.TestMovie").Replace("&", "");
            toolBar.Items.Add(TestMovie);

            ConfigurationSelector = new ToolStripComboBox();
            ConfigurationSelector.Name = "ConfigurationSelector";
            ConfigurationSelector.ToolTipText = TextHelper.GetString("ToolTip.SelectConfiguration");
            ConfigurationSelector.Items.AddRange(new string[] { TextHelper.GetString("Info.Debug"), TextHelper.GetString("Info.Release") });
            ConfigurationSelector.DropDownStyle = ComboBoxStyle.DropDownList;
            ConfigurationSelector.AutoSize = false;
            ConfigurationSelector.Enabled = false;
            ConfigurationSelector.Width = 85;
            ConfigurationSelector.FlatStyle = PluginBase.MainForm.Settings.ComboBoxFlatStyle;
            ConfigurationSelector.Font = PluginBase.Settings.DefaultFont;
            toolBar.Items.Add(ConfigurationSelector);
        }

        public bool DisabledForBuild
        {
            get { return !TestMovie.Enabled; }
            set
            {
                BuildProject.Enabled = TestMovie.Enabled = ProjectMenu.AllItemsEnabled = !value;
            }
        }
	}

	/// <summary>
	/// The "Project" menu for FD's main menu
	/// </summary>
	public class ProjectMenu : ToolStripMenuItem
	{
		public ToolStripMenuItem NewProject;
        public ToolStripMenuItem OpenProject;
        public ToolStripMenuItem ImportProject;
        public ToolStripMenuItem CloseProject;
        public ToolStripMenuItem TestMovie;
        public ToolStripMenuItem BuildProject;
        public ToolStripMenuItem Properties;

		public ProjectMenu()
		{
            NewProject = new ToolStripMenuItem(TextHelper.GetString("Label.NewProject"));
			NewProject.Image = Icons.NewProject.Img;

            OpenProject = new ToolStripMenuItem(TextHelper.GetString("Label.OpenProject"));

            ImportProject = new ToolStripMenuItem(TextHelper.GetString("Label.ImportProject"));

            CloseProject = new ToolStripMenuItem(TextHelper.GetString("Label.CloseProject"));

            TestMovie = new ToolStripMenuItem(TextHelper.GetString("Label.TestMovie"));
			TestMovie.Image = Icons.GreenCheck.Img;
            TestMovie.ShortcutKeyDisplayString = DataConverter.KeysToString(PluginMain.Settings.ShortcutTestMovie);

            BuildProject = new ToolStripMenuItem(TextHelper.GetString("Label.BuildProject"));
			BuildProject.Image = Icons.Gear.Img;
            BuildProject.ShortcutKeyDisplayString = DataConverter.KeysToString(PluginMain.Settings.ShortcutBuildProject);

            Properties = new ToolStripMenuItem(TextHelper.GetString("Label.Properties"));
			Properties.Image = Icons.Options.Img;

            base.Text = TextHelper.GetString("Label.Project");
            base.DropDownItems.Add(NewProject);
            base.DropDownItems.Add(OpenProject);
            base.DropDownItems.Add(ImportProject);
            base.DropDownItems.Add(CloseProject);
            base.DropDownItems.Add(new ToolStripSeparator());
            base.DropDownItems.Add(TestMovie);
            base.DropDownItems.Add(BuildProject);
            base.DropDownItems.Add(new ToolStripSeparator());
            base.DropDownItems.Add(Properties);
		}

		public bool ProjectItemsEnabled
		{
			set
			{
				CloseProject.Enabled = value;
				TestMovie.Enabled = value;
				BuildProject.Enabled = value;
				Properties.Enabled = value;
			}
		}

        public bool AllItemsEnabled
        {
            set
            {
                foreach (ToolStripItem item in DropDownItems)
                    item.Enabled = value;
            }
        }
	}
}
