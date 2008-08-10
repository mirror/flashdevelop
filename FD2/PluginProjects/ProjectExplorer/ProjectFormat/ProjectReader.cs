using System;
using System.Collections;
using System.Diagnostics;
using System.Text;
using System.Xml;

namespace ProjectExplorer.ProjectFormat
{
	public class ProjectReader : XmlTextReader
	{
		Project project;

		public ProjectReader(string filename) : base(filename)
		{
			project = new Project(filename);
			WhitespaceHandling = WhitespaceHandling.None;
		}

		public Project ReadProject()
		{
			MoveToContent();
			
			while (Read())
			{
				switch (Name) 
				{
					case "classpaths": ReadClasspaths(); break;
					case "output": ReadOutputOptions(); break;
					case "build": ReadBuildOptions(); break;
					case "compileTargets": ReadCompileTargets(); break;
					case "library": ReadLibraryAssets(); break;
					case "hiddenPaths": ReadHiddenPaths(); break;
					case "preBuildCommand": ReadPreBuildCommand(); break;
					case "postBuildCommand": ReadPostBuildCommand(); break;
					case "options": ReadProjectOptions(); break;
				}
			}

			return project;
		}

		public void ReadClasspaths()
		{
			ReadStartElement("classpaths");
			ReadPaths("class",project.Classpaths);
			ReadEndElement();
		}

		public void ReadOutputOptions()
		{
			ReadStartElement("output");
			while (Name == "movie")
			{
				MoveToFirstAttribute();
				switch (Name)
				{
					case "input": project.InputPath = OSPath(Value); break;
					case "path": project.OutputPath = OSPath(Value); break;
					case "fps": project.MovieOptions.Fps = IntValue; break;
					case "width": project.MovieOptions.Width = IntValue; break;
					case "height": project.MovieOptions.Height = IntValue; break;
					case "version": project.MovieOptions.Version = IntValue; break;
					case "background": project.MovieOptions.Background = Value; break;
				}
				Read();
			}
			ReadEndElement();
		}

		public void ReadBuildOptions()
		{
			ArrayList includePackages = new ArrayList();

			ReadStartElement("build");
			while (Name == "option")
			{
				MoveToFirstAttribute();
				switch (Name)
				{
					case "verbose": project.CompilerOptions.Verbose = BoolValue; break;
					case "strict": project.CompilerOptions.Strict = BoolValue; break;
					case "infer": project.CompilerOptions.Infer = BoolValue; break;
					case "includePackage": includePackages.Add(OSPath(Value)); break;
					case "useMain": project.CompilerOptions.UseMain = BoolValue;  break;
					case "useMX": project.CompilerOptions.UseMX = BoolValue; break;
					case "warnUnusedImports": project.CompilerOptions.WarnUnusedImports = BoolValue; break;
					case "traceMode": 
						project.CompilerOptions.TraceMode 
							= (TraceMode)Enum.Parse(typeof(TraceMode),Value,true);
						break;
					case "traceFunction": project.CompilerOptions.TraceFunction = Value; break;
					case "libraryPrefix": project.CompilerOptions.LibraryPrefix = Value; break;
					case "excludeFile": project.CompilerOptions.ExcludeFile = Value; break;
					case "groupClasses": project.CompilerOptions.GroupClasses = BoolValue; break;
					case "frame": project.CompilerOptions.Frame = IntValue; break;
					case "keep": project.CompilerOptions.Keep = BoolValue; break;
				}
				Read();
			}
			ReadEndElement();

			project.CompilerOptions.IncludePackages 
				= includePackages.ToArray(typeof(string)) as string[];
		}

		public void ReadCompileTargets()
		{
			ReadStartElement("compileTargets");
			ReadPaths("compile",project.CompileTargets);
			ReadEndElement();
		}

		public void ReadLibraryAssets()
		{
			ReadStartElement("library");
			while (Name == "asset")
			{
				string path = OSPath(GetAttribute("path"));
				string mode = GetAttribute("mode");
				
				if (path == null)
					throw new Exception("All library assets must have a 'path' attribute.");
				
				LibraryAsset asset = new LibraryAsset(project,path);
				project.LibraryAssets.Add(asset);
				
				asset.ManualID = GetAttribute("id"); // could be null
				asset.UpdatePath = OSPath(GetAttribute("update")); // could be null
				asset.FontGlyphs = GetAttribute("glyphs"); // could be null

				if (mode != null)
					asset.SwfMode = (SwfAssetMode)Enum.Parse(typeof(SwfAssetMode),mode,true);

				if (asset.SwfMode == SwfAssetMode.Shared)
					asset.Sharepoint = GetAttribute("sharepoint"); // could be null

				Read();
			}			
			ReadEndElement();
		}

		public void ReadHiddenPaths()
		{
			ReadStartElement("hiddenPaths");
			ReadPaths("hidden",project.HiddenPaths);
			ReadEndElement();
		}

		public void ReadPreBuildCommand()
		{
			if (!IsEmptyElement)
			{
				ReadStartElement("preBuildCommand");
				project.PreBuildEvent = OSPath(ReadString().Trim());
				ReadEndElement();
			}
		}

		public void ReadPostBuildCommand()
		{
			project.AlwaysRunPostBuild = Convert.ToBoolean(GetAttribute("alwaysRun"));

			if (!IsEmptyElement)
			{
				ReadStartElement("postBuildCommand");
				project.PostBuildEvent = OSPath(ReadString().Trim());
				ReadEndElement();
			}
		}

		public void ReadProjectOptions()
		{
			ReadStartElement("options");
			while (Name == "option")
			{
				MoveToFirstAttribute();
				switch (Name)
				{
					case "showHiddenPaths": project.ShowHiddenPaths = BoolValue; break;
					case "testMovie": 
						project.MovieOptions.TestMovieBehavior 
							= (TestMovieBehavior)Enum.Parse(typeof(TestMovieBehavior),Value,true);
						break;
				}
				Read();
			}
			ReadEndElement();
		}

		public bool BoolValue { get { return Convert.ToBoolean(Value); } }
		public int IntValue { get { return Convert.ToInt32(Value); } }

		public void ReadPaths(string pathNodeName, IAddPaths paths)
		{
			while (Name == pathNodeName)
			{
				paths.Add(OSPath(GetAttribute("path")));
				Read();
			}
		}

		private string OSPath(string path)
		{
			if (path != null)
				return path.Replace('\\',System.IO.Path.DirectorySeparatorChar);
			else
				return null;
		}
	}
}
