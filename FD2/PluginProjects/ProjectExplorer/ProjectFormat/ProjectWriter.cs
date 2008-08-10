using System;
using System.Collections;
using System.IO;
using System.Diagnostics;
using System.Text;
using System.Xml;

namespace ProjectExplorer.ProjectFormat
{
	class ProjectWriter : XmlTextWriter
	{
		Project project;

		public ProjectWriter(Project project, string filename) : base(filename,Encoding.UTF8)
		{
			this.project = project;
			this.Formatting = Formatting.Indented;
		}

		public void WriteProject()
		{
			WriteStartDocument();
			WriteStartElement("project");
			WriteClasspaths();
			WriteOutputOptions();
			WriteBuildOptions();
			WriteCompileTargets();
			WriteLibraryAssets();
			WriteHiddenPaths();
			WritePreBuildCommand();
			WritePostBuildCommand();
			WriteProjectOptions();
			WriteEndElement();
			WriteEndDocument();
		}

		public void WriteClasspaths()
		{
			WriteComment(" Other classes to be compiled into your SWF ");
			WriteStartElement("classpaths");
			WritePaths(project.Classpaths,"class");
			WriteEndElement();
		}

		public void WriteCompileTargets()
		{
			WriteComment(" Class files to compile (other referenced classes will automatically be included) ");
			WriteStartElement("compileTargets");
			WritePaths(project.CompileTargets,"compile");
			WriteEndElement();			
		}

		public void WriteHiddenPaths()
		{
			WriteComment(" Paths to exclude from the Project Explorer tree ");
			WriteStartElement("hiddenPaths");
			WritePaths(project.HiddenPaths,"hidden");
			WriteEndElement();			
		}

		public void WritePreBuildCommand()
		{
			WriteComment(" Executed before build ");
			WriteStartElement("preBuildCommand");
			if (project.PreBuildEvent.Length > 0)
				WriteString(project.PreBuildEvent);
			WriteEndElement();
		}

		public void WritePostBuildCommand()
		{
			WriteComment(" Executed after build ");
			WriteStartElement("postBuildCommand");
			WriteAttributeString("alwaysRun",project.AlwaysRunPostBuild.ToString());
			if (project.PostBuildEvent.Length > 0)
				WriteString(project.PostBuildEvent);
			WriteEndElement();

		}

		public void WriteProjectOptions()
		{
			WriteComment(" Other project options ");
			WriteStartElement("options");
			WriteOption("showHiddenPaths",project.ShowHiddenPaths);
			WriteOption("testMovie",project.MovieOptions.TestMovieBehavior);
			WriteEndElement();
		}

		public void WriteLibraryAssets()
		{
			WriteComment(" Assets to embed into the output SWF ");
			WriteStartElement("library");

			if (project.LibraryAssets.Count > 0)
			{
				foreach (LibraryAsset asset in project.LibraryAssets)
				{
					WriteStartElement("asset");
					WriteAttributeString("path",asset.Path);

					if (asset.ManualID != null)
						WriteAttributeString("id",asset.ManualID);

					if (asset.UpdatePath != null)
						WriteAttributeString("update",asset.UpdatePath);

					if (asset.FontGlyphs != null)
						WriteAttributeString("glyphs",asset.FontGlyphs);

					if (asset.IsSwf && asset.SwfMode != SwfAssetMode.Library)
						WriteAttributeString("mode",asset.SwfMode.ToString());

					if (asset.SwfMode == SwfAssetMode.Shared)
					{
						if (asset.Sharepoint != null)
							WriteAttributeString("sharepoint",asset.Sharepoint);
					}

					WriteEndElement();
				}
			}
			else WriteExample("asset","path","id","update","glyphs","mode","place","sharepoint"); 

			WriteEndElement();			
		}

		public void WriteOutputOptions()
		{
			WriteComment(" Output SWF options ");
			WriteStartElement("output");
			WriteOption("movie","input",project.InputPath);
			WriteOption("movie","path",project.OutputPath);
			WriteOption("movie","fps",project.MovieOptions.Fps);
			WriteOption("movie","width",project.MovieOptions.Width);
			WriteOption("movie","height",project.MovieOptions.Height);
			WriteOption("movie","version",project.MovieOptions.Version);
			WriteOption("movie","background",project.MovieOptions.Background);
			WriteEndElement();
		}

		public void WriteBuildOptions()
		{
			WriteComment(" Build options ");
			WriteStartElement("build");
			WriteOption("verbose",project.CompilerOptions.Verbose);
			WriteOption("strict",project.CompilerOptions.Strict);
			WriteOption("infer",project.CompilerOptions.Infer);

			foreach (string pack in project.CompilerOptions.IncludePackages)
				WriteOption("includePackage",pack);

			WriteOption("useMain",project.CompilerOptions.UseMain);
			WriteOption("useMX",project.CompilerOptions.UseMX);
			WriteOption("warnUnusedImports",project.CompilerOptions.WarnUnusedImports);
			WriteOption("traceMode",project.CompilerOptions.TraceMode);
			WriteOption("traceFunction",project.CompilerOptions.TraceFunction);
			WriteOption("libraryPrefix",project.CompilerOptions.LibraryPrefix);
			WriteOption("excludeFile",project.CompilerOptions.ExcludeFile);
			WriteOption("groupClasses",project.CompilerOptions.GroupClasses);
			WriteOption("frame",project.CompilerOptions.Frame);
			WriteOption("keep",project.CompilerOptions.Keep);
			WriteEndElement();
		}

		public void WriteOption(string optionName, object optionValue)
		{
			WriteOption("option",optionName,optionValue);
		}

		public void WriteOption(string nodeName, string optionName, object optionValue)
		{
			WriteStartElement(nodeName);
			WriteAttributeString(optionName,optionValue.ToString());
			WriteEndElement();
		}

		public void WritePaths(ICollection paths, string pathNodeName)
		{
			if (paths.Count > 0)
			{
				foreach (string path in paths)
				{
					WriteStartElement(pathNodeName);
					WriteAttributeString("path",path);
					WriteEndElement();
				}
			}
			else WriteExample(pathNodeName,"path");
		}

		public void WriteExample(string nodeName, params string[] attributes)
		{
			StringBuilder example = new StringBuilder();
			example.Append(" example: <"+nodeName);
			foreach (string attribute in attributes)
				example.Append(" " + attribute + "=\"...\"");
			example.Append(" /> ");
			WriteComment(example.ToString());
		}
	}
}
