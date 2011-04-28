using System;
using System.Reflection;
using System.IO;
using ProjectManager.Projects;
using ProjectManager.Building;
using ProjectManager.Building.AS3;
using FDBuild.Building;
using System.Text;


namespace FDBuild
{
    /// <summary>
    /// FDBuild.exe is a command-line tool for compiling FlashDevelop project files
    /// </summary>
    public class Program
    {
        public static FDBuildOptions BuildOptions;

        public static int Main(string[] args)
        {
            Console.OutputEncoding = Encoding.Default;

            FDBuildOptions options = new FDBuildOptions(args);
            BuildOptions = new FDBuildOptions(args);

            // save current directory - ProjectBuilder might change it
            if (Path.IsPathRooted(options.ProjectFile))
                Environment.CurrentDirectory = Path.GetDirectoryName(options.ProjectFile);
            string directory = Environment.CurrentDirectory;
            string toolsDir = Path.GetDirectoryName(ProjectPaths.ApplicationDirectory);

            // try and automagically figure out flashdevelop's library path
            // it should be at ..\..\Library
            if (options.LibraryDir == null)
                try
                {
                    string firstRunDir = Path.GetDirectoryName(toolsDir);
                    string libraryDir = Path.Combine(firstRunDir, "Library");
                    if (Directory.Exists(libraryDir))
                        options.LibraryDir = libraryDir;
                }
                catch { }

            string swfmillPath = options.SwfmillPath ?? Path.Combine(toolsDir, "swfmill");
            if (File.Exists(Path.Combine(swfmillPath, "swfmill.exe")))
                SwfmillLibraryBuilder.ExecutablePath = Path.Combine(swfmillPath, "swfmill.exe");
            else
                SwfmillLibraryBuilder.ExecutablePath = "swfmill.exe"; // hope you have it in your environment path!

            try
            {
                if (options.ProjectFile.Length > 0)
                    Build(Path.GetFullPath(options.ProjectFile), options);
                else
                {
                    // build everything in this directory
                    string[] files = Directory.GetFiles(directory, "*.fdp");

                    if (files.Length == 0)
                    {
                        options.DoHelp();
                        return 0;
                    }

                    foreach (string file in files)
                        Build(file, options);
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

        /// <summary>
        /// Build from command line
        /// </summary>
        /// <param name="projectFile"></param>
        /// <param name="options"></param>
        public static void Build(string projectFile, FDBuildOptions options)
        {
            Project project = ProjectLoader.Load(projectFile);
            project.TraceEnabled = !options.NoTrace;
            options.Language = project.Language.ToUpper();
            ProjectBuilder builder = ProjectBuilder.Create(project, options.IpcName, options.CompilerPath);
            builder.Build(options.ExtraClasspaths, options.NoTrace, options.NoPreBuild, options.NoPostBuild);
        }

        /// <summary>
        /// Build from pre/post command: FDBuild
        /// </summary>
        /// <param name="projectFile"></param>
        public static void BuildProject(string projectFile)
        {
            Project project = ProjectLoader.Load(projectFile);
            Program.BuildOptions.Language = project.Language.ToUpper();

            ProjectBuilder builder = ProjectBuilder.Create(project, Program.BuildOptions.IpcName, Program.BuildOptions.CompilerPath);
            builder.BuildCommand(Program.BuildOptions.ExtraClasspaths, Program.BuildOptions.NoTrace);
        }

        /// <summary>
        /// Build from pre/post command: mxmlc
        /// </summary>
        /// <param name="workingdir">the working directory for fsch, to have full optimization make this the same for all calls </param>
        /// <param name="arguments">the mxmlc arguments</param>
        public static void BuildMXMLC( string workingdir, string arguments )
        {
            //Project project = ProjectLoader.Load(projectFile);
            //Program.BuildOptions.Language = project.Language.ToUpper();

            AS3ProjectBuilder builder = new AS3ProjectBuilder(null, Program.BuildOptions.CompilerPath, Program.BuildOptions.IpcName);
            builder.CompileWithMxmlc(workingdir, arguments, true);
            
        }

        /// <summary>
        /// Build from pre/post command: compc
        /// </summary>
        /// <param name="workingdir">the working directory for fsch, to have full optimization make this the same for all calls </param>
        /// <param name="arguments">the compc arguments</param>
        public static void BuildCOMPC( string workingdir, string arguments )
        {
            AS3ProjectBuilder builder = new AS3ProjectBuilder(null, Program.BuildOptions.CompilerPath, Program.BuildOptions.IpcName);
        }
    }
}
