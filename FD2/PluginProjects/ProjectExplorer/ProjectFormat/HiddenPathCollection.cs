using System;
using System.IO;
using System.Collections;
using System.Text;

namespace ProjectExplorer.ProjectFormat
{
	public class HiddenPathCollection : CollectionBase, IAddPaths
	{
		public void Add(string path)
		{
			// remove any now-redundant paths underneath this one
			for (int i = 0; i < List.Count; i++)
			{
				string hiddenPath = List[i] as string;

				if (hiddenPath.StartsWith(path + Path.DirectorySeparatorChar) ||
					hiddenPath == path)
				{
					List.RemoveAt(i--); // search this index again
				}
			}
			List.Add(path);
		}

		public void Remove(string path)
		{
			// unhide this path and any parent paths
			for (int i = 0; i < List.Count; i++)
			{
				string hiddenPath = List[i] as string;

				if (hiddenPath == path ||
					path.StartsWith(hiddenPath + Path.DirectorySeparatorChar))
				{
					List.RemoveAt(i--); // search this index again
				}
			}
		}

		public bool IsHidden(string path)
		{
			foreach (string hiddenPath in List)
				if (hiddenPath == path ||
					path.StartsWith(hiddenPath + Path.DirectorySeparatorChar))
					return true;
			return false;
		}

		public bool IsHiddenIgnoreCase(string path)
		{
			string lowerPath = path.ToLower();
			foreach (string hiddenPath in List)
			{
				string lowerHiddenPath = hiddenPath.ToLower();
				if (lowerHiddenPath == lowerPath ||
					lowerPath.StartsWith(lowerHiddenPath + Path.DirectorySeparatorChar))
					return true;
			}
			return false;
		}
	}
}
