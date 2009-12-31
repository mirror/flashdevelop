using System;
using System.Collections;
using System.Text;
using ProjectManager.Projects;

namespace ProjectManager.Building
{
	class ArgumentBuilder
	{
		ArrayList args;
        BuildEventVars vars;

		public ArgumentBuilder(Project project)
		{
			args = new ArrayList();
            vars = new BuildEventVars(project);
        }

        public void Add(string[] arguments, bool noTrace)
        {
            foreach (string argument in arguments)
                if (argument != null && argument.Length > 0)
                {
                    string line = argument.Trim();
                    if (line.Length == 0) 
                        continue;
                    // conditional arguments
                    if (line.StartsWith("DEBUG:"))
                    {
                        if (noTrace) continue;
                        else line = line.Substring("DEBUG:".Length).Trim();
                    }
                    if (line.StartsWith("RELEASE:"))
                    {
                        if (!noTrace) continue;
                        else line = line.Substring("RELEASE:".Length).Trim();
                    }

                    args.Add(line);
                }
        }

		public void Add(string argument, params string[] values)
		{
			args.Add(argument);
			foreach (string value in values)
                if (value != null && value.Length > 0) args.Add(value);
		}

		public override string ToString()
		{
			string[] argArray = args.ToArray(typeof(string)) as string[];
            string line = string.Join(" ", argArray);

            // expand variables
            BuildEventInfo[] infos = vars.GetVars();
            foreach (BuildEventInfo info in infos)
                line = line.Replace(info.FormattedName, info.Value);

            return line;
		}
	}
}
