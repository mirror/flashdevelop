using System;
using System.Collections;
using System.Text;

namespace ProjectManager.Building
{
	class ArgumentBuilder
	{
		ArrayList args;

		public ArgumentBuilder()
		{
			args = new ArrayList();
        }

        public void Add(string[] arguments, bool noTrace)
        {
            foreach (string argument in arguments)
                if (argument != null && argument.Length > 0)
                {
                    string line = argument.Trim();
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
			return string.Join(" ", argArray);
		}
	}
}
