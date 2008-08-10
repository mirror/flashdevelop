using System;
using System.Collections;
using System.IO;
using System.Text;

namespace ProjectExplorer.ProjectFormat
{
	public class Project
	{
		string path; // full path to this project, including filename
		MovieOptions movieOptions;
		PathCollection classpaths;
		PathCollection compileTargets;
		AssetCollection libraryAssets;
		CompilerOptions compilerOptions;
		HiddenPathCollection hiddenPaths;

		public string InputPath;
		public string OutputPath;
		public string PreBuildEvent;
		public string PostBuildEvent;
		public bool AlwaysRunPostBuild;
		public bool ShowHiddenPaths;

		public Project(string path)
		{
			this.path = path;

			movieOptions = new MovieOptions();
			classpaths = new PathCollection();
			compileTargets = new PathCollection();
			libraryAssets = new AssetCollection(this);
			compilerOptions = new CompilerOptions();
			hiddenPaths = new HiddenPathCollection();

			InputPath = "";
			OutputPath = "";
			PreBuildEvent = "";
			PostBuildEvent = "";
		}

		#region Simple Properties

		public string ProjectPath { get { return path; } }
		public string Name { get { return Path.GetFileNameWithoutExtension(path); } }
		public string Directory { get { return Path.GetDirectoryName(path); } }
		public bool UsesInjection { get { return InputPath != ""; } }
		
		// we only provide getters for these to preserve the original pointer
		public PathCollection Classpaths { get { return classpaths; } }
		public AssetCollection LibraryAssets { get { return libraryAssets; } }
		public PathCollection CompileTargets { get { return compileTargets; } }
		public HiddenPathCollection HiddenPaths { get { return hiddenPaths; } }
		public MovieOptions MovieOptions { get { return movieOptions; } }
		public CompilerOptions CompilerOptions { get { return compilerOptions; } }

		public PathCollection AbsoluteClasspaths
		{
			get
			{
				PathCollection absolute = new PathCollection();
				foreach (string cp in classpaths)
					absolute.Add(GetAbsolutePath(cp));
				return absolute;
			}
		}

		public string AbsoluteOutputPath { get { return GetAbsolutePath(OutputPath); } }

		#endregion

		#region Load/Save

		public static Project Create(string path)
		{
			Project project = new Project(path);

			// default values
			project.OutputPath = project.Name + ".swf";
			project.Classpaths.Add(".");
			project.Save();
			return project;
		}

		public static Project Load(string path)
		{
			ProjectReader reader = new ProjectReader(path);

			try
			{
				return reader.ReadProject();
			}
			catch (System.Xml.XmlException exception)
			{
				string format = string.Format("Error in XML Document line {0}, position {1}.",
					exception.LineNumber,exception.LinePosition);
				throw new Exception(format,exception);
			}
			finally { reader.Close(); }
		}

		public void Save()
		{
			ProjectWriter writer = new ProjectWriter(this,this.path);
			try
			{
				writer.WriteProject();
				writer.Flush();
			}
			finally { writer.Close(); }
		}

		#endregion

		#region Methods

		// all the Set/Is methods expect absolute paths (as opposed to the way they're
		// actually stored)

		public void SetPathHidden(string path, bool isHidden)
		{
			path = GetRelativePath(path);

			if (isHidden)
			{
				hiddenPaths.Add(path);				
				compileTargets.RemoveAtOrBelow(path); // can't compile hidden files
				libraryAssets.RemoveAtOrBelow(path); // can't embed hidden resources
			}
			else hiddenPaths.Remove(path);
		}

		public bool IsPathHidden(string path)
		{
			return hiddenPaths.IsHidden(GetRelativePath(path));
		}
		
		public void SetCompileTarget(string path, bool isCompileTarget)
		{
			if (isCompileTarget)
				compileTargets.Add(GetRelativePath(path));
			else
				compileTargets.Remove(GetRelativePath(path));
		}

		public bool IsCompileTarget(string path) { return compileTargets.Contains(GetRelativePath(path)); }

		public void SetLibraryAsset(string path, bool isLibraryAsset)
		{
			if (isLibraryAsset)
				libraryAssets.Add(GetRelativePath(path));
			else
				libraryAssets.Remove(GetRelativePath(path));
		}

		public bool IsLibraryAsset(string path) { return libraryAssets.Contains(GetRelativePath(path)); }
		public LibraryAsset GetAsset(string path) { return libraryAssets[GetRelativePath(path)]; }

		public void ChangeAssetPath(string fromPath, string toPath)
		{
			if (IsLibraryAsset(fromPath))
			{
				LibraryAsset asset = libraryAssets[GetRelativePath(fromPath)];
				libraryAssets.Remove(asset);
				asset.Path = GetRelativePath(toPath);
				libraryAssets.Add(asset);
			}
		}

		public bool IsOutput(string path) { return GetRelativePath(path) == OutputPath; }
		public bool IsInput(string path) { return GetRelativePath(path) == InputPath; }

		/// <summary>
		/// Call this when you delete a path so we can remove all our references to it
		/// </summary>
		public void NotifyPathsDeleted(string path)
		{
			path = GetRelativePath(path);
			hiddenPaths.Remove(path);
			compileTargets.RemoveAtOrBelow(path);
			libraryAssets.RemoveAtOrBelow(path);
		}

		/// <summary>
		/// Returns the path to the "obj\" subdirectory, creating it if necessary.
		/// </summary>
		public string GetObjDirectory()
		{
			string objPath = Path.Combine(this.Directory, "obj");
			if (!System.IO.Directory.Exists(objPath))
				System.IO.Directory.CreateDirectory(objPath);
			return objPath;
		}

		#endregion

		#region Relative Path Helpers

		public string GetRelativePath(string path)
		{
			return PathHelper.GetRelativePath(this.Directory,path);
		}

		public string GetAbsolutePath(string path)
		{
			return PathHelper.GetAbsolutePath(this.Directory,path);
		}

		#endregion
	}
}
