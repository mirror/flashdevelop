using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using PluginCore.Helpers;

namespace ProjectManager.Projects
{
    // This class is split off because FDBuild doesn't know what "PluginMain" is
    public partial class ProjectPaths
    {
        public static string ProjectTemplatesDirectory
        {
            get
            {
                string altpath = PluginMain.Settings.AlternateTemplateDir;
                if (altpath != null && altpath.Length > 0) return altpath;
                else return PathHelper.ProjectsDir;
            }
        }

        public static string FileTemplatesDirectory
        {
            get { return Path.Combine(PathHelper.TemplateDir, "ProjectFiles"); }
        }
    }
}
