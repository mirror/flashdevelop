using System;
using System.Collections;
using System.Diagnostics;
using PluginCore;
using ProjectExplorer.Controls;
using ProjectExplorer.Controls.TreeView;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer
{
	/// <summary>
	/// Manages global settings for Project Explorer, persisted through FlashDevelop's
	/// internal xml-based settings.xml file.
	/// </summary>
	public class Settings
	{
		static IMainForm mainForm;
		static ISettings settings;

		static string SETTING_RECENTPROJECTS = "ProjectExplorer.RecentProjects";
		static string SETTING_MAXRECENTPROJECTS = "ProjectExplorer.MaxRecentProjects";
		static string SETTING_LASTOPENPROJECT = "ProjectExplorer.LastOpenProject";
		static string SETTING_EXCLUDEDDIRECTORIES = "ProjectExplorer.ExcludedDirectories";
		static string SETTING_EXCLUDEDFILETYPES = "ProjectExplorer.ExcludedFileTypes";
		static string SETTING_CREATEPROJECTDIR = "ProjectExplorer.CreateProjectDir";
		static string SETTING_NEWPROJECTDEFAULTDIR = "ProjectExplorer.NewProjectDefaultDir";
		static string SETTING_SHOWPROJECTCLASSPATHS = "ProjectExplorer.Tree.ShowProjectClasspaths";
		static string SETTING_SHOWGLOBALCLASSPATHS = "ProjectExplorer.Tree.ShowGlobalClasspaths";
		static string SETTING_RESTORETREESTATE = "ProjectExplorer.Tree.RestoreState";
		static string SETTING_CLASSPATH = "ASCompletion.ClassPath";

		public static void Initialize(IMainForm mainForm)
		{
			Settings.mainForm = mainForm;
			Settings.settings = mainForm.MainSettings;

			string excludedDirs = string.Join(",",ProjectTreeView.ExcludedDirectories);
			string excludedFileTypes = string.Join(",",ProjectTreeView.ExcludedFileTypes);

			// create keys if necessary with default values

			if (!settings.HasKey(SETTING_RECENTPROJECTS))
				settings.AddValue(SETTING_RECENTPROJECTS, "");

			if (!settings.HasKey(SETTING_MAXRECENTPROJECTS))
				settings.AddValue(SETTING_MAXRECENTPROJECTS,"7");

			if (!settings.HasKey(SETTING_LASTOPENPROJECT))
				settings.AddValue(SETTING_LASTOPENPROJECT, "");

			if (!settings.HasKey(SETTING_EXCLUDEDDIRECTORIES))
				settings.AddValue(SETTING_EXCLUDEDDIRECTORIES, excludedDirs);

			if (!settings.HasKey(SETTING_EXCLUDEDFILETYPES))
				settings.AddValue(SETTING_EXCLUDEDFILETYPES, excludedFileTypes);

			if (!settings.HasKey(SETTING_CREATEPROJECTDIR))
				settings.AddValue(SETTING_CREATEPROJECTDIR,"true");

			if (!settings.HasKey(SETTING_NEWPROJECTDEFAULTDIR))
				settings.AddValue(SETTING_NEWPROJECTDEFAULTDIR,PathHelper.ProjectsDirectory);

			if (!settings.HasKey(SETTING_SHOWPROJECTCLASSPATHS))
				settings.AddValue(SETTING_SHOWPROJECTCLASSPATHS,"true");

			if (!settings.HasKey(SETTING_SHOWGLOBALCLASSPATHS))
				settings.AddValue(SETTING_SHOWGLOBALCLASSPATHS,"false");
			
			if (!settings.HasKey(SETTING_RESTORETREESTATE))
				settings.AddValue(SETTING_RESTORETREESTATE,"true");

			excludedDirs = settings.GetValue(SETTING_EXCLUDEDDIRECTORIES);
			excludedFileTypes = settings.GetValue(SETTING_EXCLUDEDFILETYPES);
			ProjectTreeView.ExcludedDirectories = excludedDirs.Split(',');
			ProjectTreeView.ExcludedFileTypes = excludedFileTypes.Split(',');
		}

		public static void FireSettingsChanged()
		{
			mainForm.DispatchEvent(new NotifyEvent(EventType.SettingUpdate));
		}

		public static string LastProject
		{
			get { return settings.GetValue(SETTING_LASTOPENPROJECT); }
			set { settings.ChangeValue(SETTING_LASTOPENPROJECT,value); }
		}

		public static string RecentProjects
		{
			get { return settings.GetValue(SETTING_RECENTPROJECTS); }
			set { settings.ChangeValue(SETTING_RECENTPROJECTS,value); }
		}

		public static int MaxRecentProjects
		{
			get { return settings.GetInt(SETTING_MAXRECENTPROJECTS); }
			set { settings.ChangeValue(SETTING_MAXRECENTPROJECTS,value.ToString()); }
		}

		public static string GlobalClasspaths
		{
			get { return settings.GetValue(SETTING_CLASSPATH); }
			set { settings.ChangeValue(SETTING_CLASSPATH,value); FireSettingsChanged(); }
		}

		public static bool CreateProjectDirectory
		{
			get { return settings.GetBool(SETTING_CREATEPROJECTDIR); }
			set { settings.ChangeValue(SETTING_CREATEPROJECTDIR,value.ToString()); }
		}

		public static string NewProjectDefaultDirectory
		{
			get { return settings.GetValue(SETTING_NEWPROJECTDEFAULTDIR); }
			set { settings.ChangeValue(SETTING_NEWPROJECTDEFAULTDIR,value); }
		}

		public static bool ShowProjectClasspaths
		{
			get { return settings.GetBool(SETTING_SHOWPROJECTCLASSPATHS); }
			set { settings.ChangeValue(SETTING_SHOWPROJECTCLASSPATHS,value.ToString()); }
		}

		public static bool ShowGlobalClasspaths
		{
			get { return settings.GetBool(SETTING_SHOWGLOBALCLASSPATHS); }
			set { settings.ChangeValue(SETTING_SHOWGLOBALCLASSPATHS,value.ToString()); }
		}
		
		public static bool RestoreTreeState
		{
			get { return settings.GetBool(SETTING_RESTORETREESTATE); }
			set { settings.ChangeValue(SETTING_RESTORETREESTATE,value.ToString()); }
		}
	}
}
