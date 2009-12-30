using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.IO;

namespace PluginCore.Localization
{
    // These exist because we want to decorate some of our compiler option classes
    // with localized descriptions for the PropertyGrid, but we don't want fdbuild
    // to have to reference PluginCore.

    class LocalizedDescriptionAttribute : Attribute
    {
        public LocalizedDescriptionAttribute(string fake) { }
    }
    class LocalizedCategoryAttribute : Attribute
    {
        public LocalizedCategoryAttribute(string fake) { }
    }
}

namespace PluginCore
{
    interface IProject { }
}

namespace ProjectManager.Controls
{
    class PropertiesDialog { }
}
namespace ProjectManager.Controls.AS2
{
    class AS2PropertiesDialog : ProjectManager.Controls.PropertiesDialog { }
}
namespace ProjectManager.Controls.AS3
{
    class AS3PropertiesDialog : ProjectManager.Controls.PropertiesDialog { }
}

namespace ProjectManager.Helpers
{
    /// <summary>
    /// Can be extended at runtime by a FlashDevelop plugin, but not in the command line
    /// </summary>
    class ProjectCreator
    {
        private static Hashtable projectTypes = new Hashtable();
        private static bool projectTypesSet = false;

        private static void SetInitialProjectHash()
        {
            projectTypes["project.fdp"] = typeof(ProjectManager.Projects.AS2.AS2Project);
            projectTypes["project.as2proj"] = typeof(ProjectManager.Projects.AS2.AS2Project);
            projectTypes["project.as3proj"] = typeof(ProjectManager.Projects.AS3.AS3Project);
            projectTypes["project.hxproj"] = typeof(ProjectManager.Projects.Haxe.HaxeProject);
            projectTypesSet = true;
        }

        public static bool IsKnownProject(string ext)
        {
            if (!projectTypesSet) SetInitialProjectHash();
            return projectTypes.ContainsKey("project" + ext);
        }

        public static Type GetProjectType(string key)
        {
            if (!projectTypesSet) SetInitialProjectHash();
            if (projectTypes.ContainsKey(key))
                return (Type)projectTypes[key];
            return null;
        }

        public static string KeyForProjectPath(string path)
        {
            return "project" + Path.GetExtension(path).ToLower();
        }
    }
}