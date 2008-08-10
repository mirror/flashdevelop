using System;
using System.Collections;
using System.IO;
using System.Text;
using System.Reflection;
using System.Runtime.CompilerServices;
using Mono.GetOptions;
using ProjectExplorer.ProjectFormat;
using ProjectExplorer.ProjectBuilding;

[assembly: AssemblyTitle("FDBuild")]
[assembly: AssemblyDescription("Command-Line compiler for FlashDevelop project files")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("www.spotlightmobile.com")]
[assembly: AssemblyProduct("FDBuild")]
[assembly: AssemblyCopyright("Nick Farina - 2005")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]
[assembly: AssemblyVersion("1.0.0.*")]

// This is text that goes after "<program-name/> [options]" in help output.
[assembly: Mono.UsageComplement ("<.fdp project file>")]

// Attributes visible in "<program-name/> -V"
[assembly: Mono.About ("")]
[assembly: Mono.Author ("Nick Farina")]

namespace FDBuild
{
	/// <summary>
	/// FDBuild.exe is a command-line tool for compiling .fdp project files using
	/// MTASC and Swfmill.
	/// </summary>
	public class MainClass
	{
		public static int Main(string[] args)
		{
			FDBuildOptions options = new FDBuildOptions(args);

			// save current directory - ProjectBuilder might change it
			string directory = Environment.CurrentDirectory;
		
			// try and automagically figure out flashdevelop's library path
			// it should be at ..\..\Library
			try
			{
				string toolsDir = Path.GetDirectoryName(PathHelper.ApplicationDirectory);
				string fdDir = Path.GetDirectoryName(toolsDir);
				string libraryDir = Path.Combine(fdDir,"Library");
				if (Directory.Exists(libraryDir))
					options.ExtraClasspath = libraryDir;
			}
			catch {}

			try
			{
				if (options.ProjectFile.Length > 0)
					Build(Path.GetFullPath(options.ProjectFile),
						options.ExtraClasspaths,options.NoTrace);
				else
				{
					// build everything in this directory
					string[] files = Directory.GetFiles(directory,"*.fdp");

					if (files.Length == 0)
					{
						options.DoHelp();
						return 0;
					}

					foreach (string file in files)
						Build(file,options.ExtraClasspaths,options.NoTrace);
				}

				return 0;
			}
			catch (BuildException exception)
			{
				Console.Error.WriteLine(exception.Message);
				return 1;
			}
			catch (Exception exception)
			{
				Console.Error.WriteLine("Exception: " + exception.Message);
				return 1;
			}
			finally
			{
				Environment.CurrentDirectory = directory;

				if (options.PauseAtEnd)
				{
					Console.WriteLine();
					Console.WriteLine("Press enter to continue...");
					Console.ReadLine();
				}
			}
		}

		public static void Build(string projectFile, string[] extraClasspaths, bool noTrace)
		{
			Project project = Project.Load(projectFile);
			ProjectBuilder builder = new ProjectBuilder(project);
			builder.Build(extraClasspaths,noTrace);
		}
	}

	class FDBuildOptions : Options
	{
		ArrayList extraClasspaths;
		public string ProjectFile;

		public FDBuildOptions(string[] args)
		{
			NoTrace = false;
			ProjectFile = "";
			extraClasspaths = new ArrayList();
			ProcessArgs(args);
		}

		[ArgumentProcessor]
		public void SetProject(string file) 
		{
			ProjectFile = file;
		}

		[Option(99, "Add extra classpath", "cp")]
		public string ExtraClasspath
		{
			set { if (!extraClasspaths.Contains(value)) extraClasspaths.Add(value); }
		}

		[Option("Disable tracing for this build","notrace")]
		public bool NoTrace = false;

		[Option("Pause the console after building","pause")]
		public bool PauseAtEnd = false;

		public string[] ExtraClasspaths
		{
			get { return extraClasspaths.ToArray(typeof(string)) as string[]; }
		}
	}
}
