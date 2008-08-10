using System;
using System.IO;
using System.Text;
using System.Reflection;
using System.Collections;

namespace ProjectExplorer.ProjectFormat
{
	public class BuildEventInfo
	{
		public string Name;
		public string Value;

		public BuildEventInfo(string name, string value)
		{
			this.Name = name;
			this.Value = value;
		}

		// SendKeys requires brackets around certain characters which have meaning
		public string SendKeysName { get { return "${(}"+Name+"{)}"; } }
		public string FormattedName { get { return "$("+Name+")"; } }
	}

	public class BuildEventVars
	{
		Project project;
		string[] extraClasspaths;

		public BuildEventVars(Project project, string[] extraClasspaths)
		{
			this.project = project;
			this.extraClasspaths = extraClasspaths;
		}

		public BuildEventInfo[] GetVars()
		{
			ArrayList infos = new ArrayList();
			
			infos.Add(new BuildEventInfo("FDBuild",FDBuild));
			infos.Add(new BuildEventInfo("ToolsDir",ToolsDir));
			infos.Add(new BuildEventInfo("GlobalClasspaths",GlobalClasspaths));
			infos.Add(new BuildEventInfo("Classpaths",Classpaths));
			infos.Add(new BuildEventInfo("OutputDir",Path.GetDirectoryName(project.GetAbsolutePath(project.OutputPath))));
			infos.Add(new BuildEventInfo("OutputName",Path.GetFileName(project.OutputPath)));
			infos.Add(new BuildEventInfo("ProjectName",project.Name));
			infos.Add(new BuildEventInfo("ProjectDir",project.Directory));
			infos.Add(new BuildEventInfo("ProjectPath",project.ProjectPath));

			return infos.ToArray(typeof(BuildEventInfo)) as BuildEventInfo[];
		}

		public string FDBuildDir { get { return Path.GetDirectoryName(FDBuild); } }
		public string ToolsDir { get { return Path.GetDirectoryName(FDBuildDir); } }

		public string FDBuild
		{
			get
			{
				string url = Assembly.GetEntryAssembly().GetName().CodeBase;
				Uri uri = new Uri(url,true);
				
				// special behavior if we're running in flashdevelop.exe
				if (Path.GetFileName(uri.LocalPath).ToLower() == "flashdevelop.exe")
				{
					string startupDir = Path.GetDirectoryName(uri.LocalPath);
					string toolsDir = Path.Combine(startupDir,"tools");
					string fdbuildDir = Path.Combine(toolsDir,"fdbuild");
					return Path.Combine(fdbuildDir,"fdbuild.exe");
				}
				else return uri.LocalPath;
			}
		}

		public string Classpaths
		{
			get
			{
				StringBuilder builder = new StringBuilder();

				foreach (string classpath in project.Classpaths)
					builder.AppendFormat("-cp \"{0}\" ",classpath);
				
				foreach (string classpath in extraClasspaths)
					builder.AppendFormat("-cp \"{0}\" ",classpath);

				// add the top-level classpath(s)
				string mtascPath = Path.Combine(ToolsDir,"mtasc");

				if (project.MovieOptions.Version >= 8)
					builder.AppendFormat("-cp \"{0}\" ",Path.Combine(mtascPath,"std8"));

				builder.AppendFormat("-cp \"{0}\"",Path.Combine(mtascPath,"std"));
				
				return builder.ToString();
			}
		}

		public string GlobalClasspaths
		{
			get
			{
				StringBuilder builder = new StringBuilder();

				foreach (string classpath in extraClasspaths)
					builder.AppendFormat("-cp \"{0}\" ",classpath);

				return builder.ToString();
			}
		}
	}
}
