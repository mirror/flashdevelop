using System;
using System.IO;
using System.Collections;
using System.Diagnostics;
using System.Windows.Forms;
using System.Xml.Serialization;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer
{
	/// <summary>
	/// Supports serializing various useful data into XML in the
	/// FlashDevelop "plugindata" folder.
	/// </summary>
	public class PluginData
	{
		static XmlSerializer serializer;
		static Hashtable preferences;

		static PluginData()
		{
			serializer = new XmlSerializer(typeof(PluginData));
			preferences = new Hashtable();
		}

		#region Non-static members (will be serialized)

		// this is a little tricky.  we never keep an instance of PluginData around because
		// the non-static members exist only as entry points for XmlSerializer to read/write
		// the static members.

		public ProjectPreferences[] Preferences
		{
			get 
			{
				return new ArrayList(preferences.Values).ToArray(typeof(ProjectPreferences))
					  as ProjectPreferences[];
			}
			set
			{
				foreach (ProjectPreferences prefs in value)
					if (File.Exists(prefs.ProjectPath)) // cull missing projects
						preferences.Add(prefs.ProjectPath,prefs);
			}
		}

		#endregion

		/// <summary>
		/// Returns the preferences object for the given project, creates a new one
		/// if necessary.
		/// </summary>
		public static ProjectPreferences GetPrefs(Project project)
		{
			string path = project.ProjectPath;

			if (!preferences.Contains(path))
				preferences.Add(path,new ProjectPreferences(path));
			
			return preferences[path] as ProjectPreferences;
		}

		public static void Load()
		{
			if (File.Exists(XmlPath))
				using (FileStream stream = File.OpenRead(XmlPath))
					serializer.Deserialize(stream);
		}

		public static void Save()
		{
			if (!Directory.Exists(PluginDataPath))
				Directory.CreateDirectory(PluginDataPath);

			using (StreamWriter writer = File.CreateText(XmlPath))
				serializer.Serialize(writer,new PluginData());
		}

		static string PluginDataPath
		{ get { return Path.Combine(Application.StartupPath, "Data"); } }

		static string XmlPath
		{ get { return Path.Combine(PluginDataPath,"ProjectExplorer.xml"); } }
	}

	public class ProjectPreferences
	{
		public string ProjectPath;
		public string[] ExpandedPaths;
		public bool EnableTrace;

		// we need a parameterless contructor for XmlSerializer
		public ProjectPreferences()
		{
			ExpandedPaths = new string[]{};
			EnableTrace = true;
		}

		public ProjectPreferences(string projectPath) : this()
		{
			ProjectPath = projectPath;
		}
	}
}
