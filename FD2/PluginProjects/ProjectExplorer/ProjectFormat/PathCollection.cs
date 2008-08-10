using System;
using System.Collections;
using System.Text;
using System.IO;

namespace ProjectExplorer.ProjectFormat
{
	public interface IAddPaths
	{
		void Add(string path);
	}

	public class PathCollection : CollectionBase, IAddPaths
	{
		public void Add(string path)
		{
			List.Add(path);
		}

		public void AddRange(string[] paths)
		{
			InnerList.AddRange(paths);
		}

		public void Remove(string path)
		{
			List.Remove(path);
		}

		/// <summary>
		/// Removes any paths equal to or below the gives path.
		/// </summary>
		public void RemoveAtOrBelow(string path)
		{
			if (List.Contains(path))
				List.Remove(path);
			RemoveBelow(path);
		}

		/// <summary>
		/// Removes any paths below the given path.
		/// </summary>
		public void RemoveBelow(string path)
		{
			for (int i = 0; i < List.Count; i++)
			{
				string p = List[i] as string;

				if (p.StartsWith(path + Path.DirectorySeparatorChar) ||
					p == path)
				{
					List.RemoveAt(i--); // search this index again
				}
			}
		}

		public bool Contains(string path)
		{
			return List.Contains(path);
		}

		public string[] ToArray()
		{
			return InnerList.ToArray(typeof(string)) as string[];
		}

		/// <summary>
		/// Returns the closest parent path in this collection to the given path.
		/// </summary>
		public string GetClosestParent(string path)
		{
			string closest = "";
			foreach (string classpath in List)
				if (path.StartsWith(classpath) && classpath.Length > closest.Length)
					closest = classpath;
			return (closest.Length > 0) ? closest : null;
		}
	}
}
