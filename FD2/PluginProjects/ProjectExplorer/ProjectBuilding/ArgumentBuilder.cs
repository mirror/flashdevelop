using System;
using System.Collections;
using System.Text;

namespace ProjectExplorer.ProjectBuilding
{
	class ArgumentBuilder
	{
		ArrayList args;

		public ArgumentBuilder()
		{
			args = new ArrayList();
		}

		public void Add(string argument, params string[] values)
		{
			args.Add(argument);
			foreach (string value in values)
				args.Add(value);
		}

		public override string ToString()
		{
			string[] argArray = args.ToArray(typeof(string)) as string[];
			return string.Join(" ", argArray);
		}
	}
}
