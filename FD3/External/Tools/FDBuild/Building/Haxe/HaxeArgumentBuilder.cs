using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;
using ProjectManager.Projects.Haxe;
using System.Text.RegularExpressions;

namespace ProjectManager.Building.Haxe
{
    class HaxeArgumentBuilder : ArgumentBuilder
    {
        HaxeProject project;

        public HaxeArgumentBuilder(HaxeProject project)
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
                if (Directory.Exists(classPath)) Add("-cp", "\"" + classPath + "\""); // surround with quotes
        }

        public void AddHeader()
        {
            if (!project.IsFlashOutput) return;

            string htmlColor = project.MovieOptions.Background.Substring(1);

            if (htmlColor.Length > 0)
                htmlColor = ":" + htmlColor;

            Add("-swf-header", string.Format("{0}:{1}:{2}{3}",
                project.MovieOptions.Width,
                project.MovieOptions.Height,
                project.MovieOptions.Fps,
                htmlColor));

            if (!project.UsesInjection && project.LibraryAssets.Count > 0)
                Add("-swf-lib", project.LibrarySWFPath);
        }

        public void AddCompileTargets()
        {
            List<string> classPaths = new List<string>(project.AbsoluteClasspaths);

            // add project files marked as "always compile"
            foreach (string relTarget in project.CompileTargets)
            {
                string absTarget = project.GetAbsolutePath(relTarget);

                if (File.Exists(absTarget))
                {
                    // guess the class name from the file name
                    foreach(string classPath in classPaths)
                        if (absTarget.StartsWith(classPath, StringComparison.OrdinalIgnoreCase))
                        {
                            string className = absTarget.Substring(classPath.Length);
                            className = className.Substring(0, className.LastIndexOf('.'));
                            className = Regex.Replace(className, "[\\\\/]+", ".");
                            if (className.StartsWith(".")) className = className.Substring(1);
                            if (project.CompilerOptions.MainClass != className)
                                Add(className);
                        }
                }
            }
            if (project.CompilerOptions.MainClass != null && project.CompilerOptions.MainClass.Length > 0)
                Add("-main", project.CompilerOptions.MainClass);
        }

        public void AddOutput(string path)
        {
            if (project.IsFlashOutput) Add("-swf", "\"" + path + "\"");
            else if (project.IsJavacriptOutput) Add("-js", "\"" + path + "\"");
            else if (project.IsNekoOutput) Add("-neko", "\"" + path + "\"");
            else if (project.IsPhpOutput) Add("-php", "\"" + path + "\"");
            else if (project.IsCppOutput) Add("-cpp", "\"" + path + "\"");
        }

        public void AddOptions(bool noTrace)
        {
            HaxeOptions options = project.CompilerOptions;

            if (project.IsFlashOutput)
            {
                Add("-swf-version", project.MovieOptions.Version.ToString());
                if (options.FlashStrict) Add("--flash-strict");
                //if (options.FlashUseStage) Add("--flash-use-stage"); // Require "Injection panel"
            }
            if (options.Verbose) Add("-v");
            if (noTrace) Add("--no-traces");
            else
            {
                if (project.MovieOptions.Version == 9 || project.MovieOptions.Version == 10) Add("-D fdb");
                Add("-debug");
            }

            if (options.Directives != "")
            {
                string[] directives = Regex.Split(options.Directives, "\\s+");
                foreach (string directive in directives)
                {
                    Add("-D", directive);
                }
            }

            if (options.Additional != null) Add(options.Additional, noTrace);
        }

        public void AddLibraries(string[] list)
        {
            foreach (string name in list)
            {
                Add("-lib", name);
            }
        }
    }
}
