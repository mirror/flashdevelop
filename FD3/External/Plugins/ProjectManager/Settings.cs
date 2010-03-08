using System;
using System.IO;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing.Design;
using System.Windows.Forms.Design;
using System.Xml.Serialization;
using ProjectManager.Projects;
using PluginCore.Localization;
using PluginCore.Managers;
using PluginCore;
using System.Windows.Forms;

namespace ProjectManager
{
    public delegate void SettingChangeHandler(string setting);

    [Serializable]
    public class ProjectManagerSettings
    {
        public event SettingChangeHandler Changed;

        public const Keys DEFAULT_TESTMOVIE = Keys.F5;
        public const Keys DEFAULT_BUILDPROJECT = Keys.F8;

        List<ProjectPreferences> projectPrefs = new List<ProjectPreferences>();
        List<string> recentProjects = new List<string>();
        bool showProjectClasspaths = true;
        bool showGlobalClasspaths = false;
        int maxRecentProjects = 10;
        string alternateTemplateDir;
        string lastProject = string.Empty;
        bool createProjectDirectory = false;
        bool useProjectSessions = false;
        string newProjectDefaultDirectory = string.Empty;
        bool disableMxmlMapping = false;
        Keys shortcutTestMovie = DEFAULT_TESTMOVIE;
        Keys shortcutBuildProject = DEFAULT_BUILDPROJECT;

        // These are string arrays because they are only edited by the propertygrid (which deals with them nicely)
        string[] excludedFileTypes = new string[] { ".p", ".abc", ".bak", ".tmp" };
        string[] excludedDirectories = new string[] { "obj", ".svn", "_svn", ".cvs", "_cvs", "cvs", "_sgbak" };
        string[] executableFileTypes = new string[] { ".exe", ".lnk", ".fla", ".doc", ".pps", ".psd", ".png", ".jpg", ".gif", 
            ".xls", ".docproj", ".ttf", ".otf", ".wav", ".mp3", ".ppt", ".pptx", ".docx", ".xlsx", ".ai", ".pdf", ".zip", ".rar" };
        string[] filteredDirectoryNames = new string[] { "src", "source", "sources", "as", "as2", "as3", "actionscript", "flash", "classes", "trunk", "svn" };

        #region Properties
        [Browsable(false)]
        public List<ProjectPreferences> ProjectPrefs
        {
            get { return projectPrefs; }
            set { projectPrefs = value; }
        }

        [Browsable(false)]
        public string LastProject
        {
            get { return lastProject; }
            set { lastProject = value; FireChanged("LastProject"); }
        }

        [Browsable(false)]
        public List<string> RecentProjects
        {
            get { return recentProjects; }
        }

        [Browsable(false)]
        public bool CreateProjectDirectory
        {
            get { return createProjectDirectory; }
            set { createProjectDirectory = value; FireChanged("CreateProjectDirectory"); }
        }

        [Browsable(false)]
        public String NewProjectDefaultDirectory
        {
            get { return newProjectDefaultDirectory; }
            set { newProjectDefaultDirectory = value; FireChanged("NewProjectDefaultDirectory"); }
        }

        [DisplayName("Use Project Sessions")]
        [LocalizedDescription("ProjectManager.Description.UseProjectSessions")]
        [LocalizedCategory("ProjectManager.Category.OtherOptions")]
        [DefaultValue(false)]
        public Boolean UseProjectSessions
        {
            get { return useProjectSessions; }
            set { useProjectSessions = value; }
        }

        [DisplayName("Maximum Recent Projects")]
        [LocalizedDescription("ProjectManager.Description.MaxRecentProjects")]
        [LocalizedCategory("ProjectManager.Category.OtherOptions")]
        [DefaultValue(10)]
        public Int32 MaxRecentProjects
		{
            get { return maxRecentProjects; }
            set { maxRecentProjects = value; FireChanged("MaxRecentProjects"); }
		}
        
        [DisplayName("Excluded File Types")]
        [LocalizedDescription("ProjectManager.Description.ExcludedFileTypes")]
        [LocalizedCategory("ProjectManager.Category.Exclusions")]
        public string[] ExcludedFileTypes
		{
            get { return excludedFileTypes; }
            set { excludedFileTypes = value; FireChanged("ExcludedFileTypes"); }
		}

        [DisplayName("Executable File Types")]
        [LocalizedDescription("ProjectManager.Description.ExecutableFileTypes")]
        [LocalizedCategory("ProjectManager.Category.Exclusions")]
        public string[] ExecutableFileTypes
        {
            get { return executableFileTypes; }
            set { executableFileTypes = value; FireChanged("ExecutableFileTypes"); }
        }

        [DisplayName("Excluded Directories")]
        [LocalizedDescription("ProjectManager.Description.ExcludedDirectories")]
        [LocalizedCategory("ProjectManager.Category.Exclusions")]
        public string[] ExcludedDirectories
		{
            get { return excludedDirectories; }
            set { excludedDirectories = value; FireChanged("ExcludedDirectories"); }
		}

        [DisplayName("Filtered Directory Names")]
        [LocalizedDescription("ProjectManager.Description.FilteredDirectoryNames")]
        [LocalizedCategory("ProjectManager.Category.Exclusions")]
        public string[] FilteredDirectoryNames
        {
            get { return filteredDirectoryNames; }
            set { filteredDirectoryNames = value; FireChanged("FilteredDirectoryNames"); }
        }

        [DisplayName("Show Project Classpaths")]
        [LocalizedDescription("ProjectManager.Description.ShowProjectClasspaths")]
        [LocalizedCategory("ProjectManager.Category.ProjectTree")]
        [DefaultValue(true)]
        public bool ShowProjectClasspaths
		{
            get { return showProjectClasspaths; }
            set { showProjectClasspaths = value; FireChanged("ShowProjectClasspaths"); }
		}

        [DisplayName("Show Global Classpaths")]
        [LocalizedDescription("ProjectManager.Description.ShowGlobalClasspaths")]
        [LocalizedCategory("ProjectManager.Category.ProjectTree")]
        [DefaultValue(false)]
        public bool ShowGlobalClasspaths
		{
            get { return showGlobalClasspaths; }
            set { showGlobalClasspaths = value; FireChanged("DisableMxmlMapping"); }
        }

        [DisplayName("Disable Mxml Sources Mapping")]
        [LocalizedDescription("ProjectManager.Description.DisableMxmlMapping")]
        [LocalizedCategory("ProjectManager.Category.ProjectTree")]
        [DefaultValue(false)]
        public bool DisableMxmlMapping
        {
            get { return disableMxmlMapping; }
            set { disableMxmlMapping = value; FireChanged("ShowGlobalClasspaths"); }
        }

        [DisplayName("Alternate Templates Directory")]
        [LocalizedDescription("ProjectManager.Description.AlternateTemplateDir")]
        [LocalizedCategory("ProjectManager.Category.OtherOptions")]
        [Editor(typeof(FolderNameEditor), typeof(UITypeEditor))]
        public string AlternateTemplateDir
        {
            get { return alternateTemplateDir; }
            set { alternateTemplateDir = value; FireChanged("AlternateTemplateDir"); }
        }

        [DisplayName("Test Movie Shortcut")]
        [LocalizedDescription("ProjectManager.Description.ShortcutTestMovie")]
        [LocalizedCategory("ProjectManager.Category.Shortcuts")]
        [DefaultValue(DEFAULT_TESTMOVIE)]
        public Keys ShortcutTestMovie
        {
            get { return shortcutTestMovie; }
            set { shortcutTestMovie = value; }
        }

        [DisplayName("Build Project Shortcut")]
        [LocalizedDescription("ProjectManager.Description.ShortcutBuild")]
        [LocalizedCategory("ProjectManager.Category.Shortcuts")]
        [DefaultValue(DEFAULT_BUILDPROJECT)]
        public Keys ShortcutBuildProject
        {
            get { return shortcutBuildProject; }
            set { shortcutBuildProject = value; }
        }

        #endregion

        [Browsable(false)]
        public string Language;

        [Browsable(false)]
        public List<string> GlobalClasspaths
        {
            get { return this.GetGlobalClasspaths(Language); }
            set { this.SetGlobalClasspaths(Language, value); }
        }

        public void SetGlobalClasspaths(String lang, List<String> classpaths)
        {
            Hashtable info = new Hashtable();
            info["language"] = lang;
            info["cp"] = classpaths;
            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.SetUserClasspath", info);
            EventManager.DispatchEvent(this, de);
            FireChanged("GlobalClasspath");
        }

        public List<string> GetGlobalClasspaths(String lang)
        {
            List<String> cp = null;
            Hashtable info = new Hashtable();
            info["language"] = lang;
            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.GetUserClasspath", info);
            EventManager.DispatchEvent(this, de);
            if (de.Handled && info.ContainsKey("cp")) cp = info["cp"] as List<string>;
            return cp ?? new List<string>();
        }

        /// <summary>
        /// Returns the preferences object for the given project
        /// and creates a new instance if necessary.
        /// </summary>
        public ProjectPreferences GetPrefs(Project project)
        {
            foreach (ProjectPreferences prefs in projectPrefs)
                if (prefs.ProjectPath == project.ProjectPath)
                    return prefs;

            // ok, we haven't seen this project before.  let's take this opportunity
            // to clean out any prefs for projects that don't exist anymore
            CleanOldPrefs();

            ProjectPreferences newPrefs = new ProjectPreferences(project.ProjectPath);
            projectPrefs.Add(newPrefs);
            return newPrefs;
        }

        private void CleanOldPrefs()
        {
            for (int i = 0; i < projectPrefs.Count; i++)
                if (!File.Exists(projectPrefs[i].ProjectPath))
                    projectPrefs.RemoveAt(i--); // search this index again
        }

        private void FireChanged(string setting)
        {
            if (Changed != null)
                Changed(setting);
        }
    }

    [Serializable]
    public class ProjectPreferences
    {
        public Boolean EnableTrace;
        public List<String> ExpandedPaths;
        public String ProjectPath;

        public ProjectPreferences()
        {
            this.EnableTrace = true;
            this.ExpandedPaths = new List<String>();
        }
        public ProjectPreferences(String projectPath) : this()
        {
            this.ProjectPath = projectPath;
        }
    }
}
