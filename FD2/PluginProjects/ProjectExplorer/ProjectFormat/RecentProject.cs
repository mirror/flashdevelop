using System;

namespace ProjectExplorer.ProjectFormat
{
	class RecentProject
	{
		public string Name;
		public string Path;

		public RecentProject(string serialized)
		{
			string[] split = serialized.Split('?');
			Name = split[0];
			Path = split[1];
		}

		public override string ToString()
		{
			return Name;
		}
	}
}
