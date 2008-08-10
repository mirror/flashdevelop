using System;
using System.Collections;
using System.IO;
using System.Reflection;

namespace ProjectExplorer.ProjectFormat
{
	public class PathHelper
	{
		public static string GetRelativePath(string baseDirectory, string path)
		{
			if (!Path.IsPathRooted(path))
				throw new ArgumentException("The path is already relative."); // already relative!

			char slash = Path.DirectorySeparatorChar;
			string[] a = baseDirectory.Trim(slash).Split(slash);
			string[] b = path.Trim(slash).Split(slash);

			ArrayList relPath = new ArrayList();
			int i = 0;

			// skip equal parts
			for (i = 0; i < a.Length && i < b.Length; i++)
			{
				if (string.Compare(a[i],b[i],true) != 0)
					break;
			}

			// at this point, i is the index of the first diverging element of the two paths
			int backtracks = a.Length - i;
			for (int j = 0; j < backtracks; j++)
				relPath.Add("..");

			for (int j = i; j < b.Length; j++)
				relPath.Add(b[j]);

			string relativePath = 
				string.Join(slash.ToString(), relPath.ToArray(typeof(string)) as string[]);

			return (relativePath.Length > 0) ? relativePath : "."; // special case
		}

		public static string GetAbsolutePath(string baseDirectory, string path)
		{
			if (Path.IsPathRooted(path))
				throw new ArgumentException("The path is already absolute.");

			string combinedPath = Path.Combine(baseDirectory, path);
			return Path.GetFullPath(combinedPath);
		}

		public static string ApplicationDirectory
		{
			get
			{
				string url = Assembly.GetEntryAssembly().GetName().CodeBase;
				Uri uri = new Uri(url,true);
				return Path.GetDirectoryName(uri.LocalPath);
			}
		}

		public static string TemplatesDirectory
		{
			get 
			{
				string path = Path.Combine(ApplicationDirectory, "Data");
				return Path.Combine(path, "ProjectTemplates");
			}
		}

		public static string ProjectsDirectory 
		{
			get { return Environment.GetFolderPath(Environment.SpecialFolder.Personal); }
		}
	}
}
