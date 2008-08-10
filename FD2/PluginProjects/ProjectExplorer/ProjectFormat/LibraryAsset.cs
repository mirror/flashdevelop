using System;
using System.IO;
using System.Collections;
using System.Diagnostics;

namespace ProjectExplorer.ProjectFormat
{
	/// <summary>
	/// Represents an "asset" or project resource to be embedded/referenced in a Project.
	/// </summary>
	public class LibraryAsset
	{
		public Project Project;
		public string Path;
		public string ManualID;
		public string UpdatePath;
		public string FontGlyphs;
		public string Sharepoint;
		public SwfAssetMode SwfMode;

		public LibraryAsset(Project project, string path)
		{
			Project = project;
			Path = path;
			ManualID = null;
			UpdatePath = null;
			FontGlyphs = null;
			Sharepoint = null;
			SwfMode = SwfAssetMode.Library;
		}

		public bool IsImage { get { return FileHelper.IsImage(Path); } }
		public bool IsFont { get { return FileHelper.IsFont(Path); } }
		public bool IsSwf { get { return FileHelper.IsSwf(Path); } }
		
		public string ID { get { return (ManualID != null) ? ManualID : GetAutoID(); } }

		public string GetAutoID()
		{
			// build an ID based on the relative path and library prefix project setting
			string autoID = Path.Replace(System.IO.Path.DirectorySeparatorChar,'.');
			if (Project.CompilerOptions.LibraryPrefix.Length > 0)
				autoID = Project.CompilerOptions.LibraryPrefix + "." + autoID;
			return autoID;
		}

		public bool HasManualID { get { return ManualID != null; } }

		/*public string GetClassName()
		{
			string cp = Project.Classpaths.GetClosestParent(Path);
			string className = Path.Substring(cp.Length+1);
			className = className.Substring(0,className.Length-3); // cut off .as
			return className.Replace(System.IO.Path.DirectorySeparatorChar,'.');
		}*/
	}

	public enum SwfAssetMode
	{
		Library,
		Preloader,
		Shared
	}

	#region AssetCollection

	public class AssetCollection : CollectionBase
	{
		Project project;

		public AssetCollection(Project project)
		{
			this.project = project;
		}

		public void Add(LibraryAsset asset)
		{
			List.Add(asset);
		}

		public void Add(string path)
		{
			Add(new LibraryAsset(project,path));
		}

		public bool Contains(string path)
		{
			return this[path] != null;
		}

		public LibraryAsset this[string path]
		{
			get
			{
				foreach (LibraryAsset asset in List)
					if (asset.Path == path)
						return asset;
				return null;
			}
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
				LibraryAsset asset = List[i] as LibraryAsset;

				if (asset.Path.StartsWith(path + Path.DirectorySeparatorChar) ||
					asset.Path == path)
				{
					List.RemoveAt(i--); // search this index again
				}
			}
		}

		public void Remove(LibraryAsset asset)
		{
			List.Remove(asset);
		}

		public void Remove(string path)
		{
			foreach (LibraryAsset asset in List)
				if (asset.Path == path)
				{
					List.Remove(asset);
					return;
				}
		}
	}

	#endregion
}
