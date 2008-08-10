using System;
using System.IO;
using System.Text;
using System.Drawing;
using System.Collections;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.ProjectBuilding
{
	class MtascArgumentBuilder : ArgumentBuilder
	{
		Project project;

		public MtascArgumentBuilder(Project project)
		{
			this.project = project;
		}

		public void AddClassPaths(params string[] extraClassPaths)
		{
			// build classpaths
			ArrayList classPaths = new ArrayList(project.AbsoluteClasspaths);

			foreach (string extraClassPath in extraClassPaths)
				classPaths.Add(extraClassPath);

			foreach (string classPath in classPaths)
				Add("-cp", "\"" + classPath + "\""); // surround with quotes
		}

		public void AddHeader()
		{
			string htmlColor = project.MovieOptions.Background.Substring(1);

			if (htmlColor.Length > 0)
				htmlColor = ":" + htmlColor;

			Add("-header", string.Format("{0}:{1}:{2}{3}",
				project.MovieOptions.Width,
				project.MovieOptions.Height,
				project.MovieOptions.Fps,
				htmlColor));
		}

		public void AddCompileTargets()
		{
			// add project files marked as "always compile"
			foreach (string target in project.CompileTargets)
			{
				// TODO: this is a crappy workaround for the general problem of
				// project "cruft" accumulating.  This will be removed once
				// I add support in the treeview for displaying "missing" project items
				if (File.Exists(target))
					Add("\"" + target + "\"");
			}
		}

		public void AddInput()
		{
			Add("-swf", "\"" + project.InputPath + "\"");
		}

		public void AddOutput()
		{
			if (project.UsesInjection)
				Add("-out", "\"" + project.OutputPath + "\"");
			else
				Add("-swf", "\"" + project.OutputPath + "\"");
		}

		public void AddFrame(int frame)
		{
			Add("-frame",frame.ToString());
		}
		
		public void AddKeep()
		{
			// always keep existing source - if you add .swf files to the library, expected
			// behavior is to add *everything* in them.
			Add("-keep");			
		}

		public void AddOptions(bool noTrace)
		{
			Add("-version", project.MovieOptions.Version.ToString());
			
			if (project.CompilerOptions.UseMX)
				Add("-mx");
			
			if (project.CompilerOptions.Infer)
				Add("-infer");

			if (project.CompilerOptions.Strict)
				Add("-strict");

			if (project.CompilerOptions.UseMain)
				Add("-main");

			if (project.CompilerOptions.Verbose)
				Add("-v");

			if (project.CompilerOptions.WarnUnusedImports)
				Add("-wimp");

			if (project.CompilerOptions.ExcludeFile.Length > 0)
				Add("-exclude","\""+project.CompilerOptions.ExcludeFile+"\"");

			if (project.CompilerOptions.GroupClasses)
				Add("-group");

			if (project.UsesInjection)
			{
				Add("-frame",project.CompilerOptions.Frame.ToString());

				if (project.CompilerOptions.Keep)
					Add("-keep");
			}

			// add project directories marked as "always compile"
			foreach (string target in project.CompileTargets)
				if (Directory.Exists(target))
				{
					string cp = project.Classpaths.GetClosestParent(target);
					string relTarget = target.Substring(cp.Length+1);
					Add("-pack","\"" + relTarget + "\"");
				}

			foreach (string pack in project.CompilerOptions.IncludePackages)
				Add("-pack", pack);

			if (noTrace)
			{
				Add("-trace no");
				return;
			}

			switch (project.CompilerOptions.TraceMode)
			{
				case TraceMode.Disable:
					Add("-trace no");
					break;
				case TraceMode.FlashOut:
					Add("-trace org.flashdevelop.utils.FlashOut.trace");
					Add("-pack org/flashdevelop/utils");
					break;
				case TraceMode.FlashConnect:
					Add("-trace org.flashdevelop.utils.FlashConnect.trace");
					Add("-pack org/flashdevelop/utils");
					break;
				case TraceMode.FlashConnectExtended:
					Add("-trace org.flashdevelop.utils.FlashConnect.mtrace");
					Add("-pack org/flashdevelop/utils");
					break;
				case TraceMode.CustomFunction:
					Add("-trace", project.CompilerOptions.TraceFunction);
					break;
			}
		}
	}
}
