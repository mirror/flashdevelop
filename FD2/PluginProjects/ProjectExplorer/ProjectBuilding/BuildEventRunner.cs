using System;
using System.IO;
using System.Collections;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.ProjectBuilding
{
	/// <summary>
	/// Processed pre and post-build steps, filling in project variables
	/// </summary>
	public class BuildEventRunner
	{
		Project project;
		BuildEventVars vars;

		public BuildEventRunner(Project project, string[] extraClasspaths)
		{
			this.project = project;
			this.vars = new BuildEventVars(project,extraClasspaths);
		}

		public void Run(string buildEvents)
		{
			foreach (string buildEvent in buildEvents.Split('\n'))
			{
				Environment.CurrentDirectory = project.Directory;

				string line = buildEvent.Trim();

				if (line.Length <= 0)
					continue; // nothing to do

				foreach (BuildEventInfo info in vars.GetVars())
					line = line.Replace(info.FormattedName,info.Value);

				if (line.StartsWith("\""))
				{
					int endQuote = line.IndexOf("\"",1);
					string command = line.Substring(1,endQuote-1);
					string args = line.Substring(endQuote+2);

					if (project.CompilerOptions.Verbose)
						Console.WriteLine("{0} {1}",command,args);

					if (!ProcessRunner.Run(command,args,false))
						throw new BuildException("Build halted with errors.");
				}
				else
				{
					int space = line.IndexOf(" ");
					string command = (space > -1) ? line.Substring(0,space) : line;
					string args = (space> -1) ? line.Substring(space+1) : "";

					if (project.CompilerOptions.Verbose)
						Console.WriteLine("{0} {1}",command,args);

					if (!ProcessRunner.Run(command,args,false))
						throw new BuildException("Build halted with errors.");
				}
			}
		}
	}
}
