using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using ProjectManager.Helpers;
using ProjectManager.Projects.Haxe;
using FDBuild.Building;

namespace ProjectManager.Building.Haxe
{
    public class HaxeProjectBuilder : ProjectBuilder
    {
        HaxeProject project;

        string haxePath;

        public HaxeProjectBuilder(HaxeProject project, string compilerPath)
            : base(project, compilerPath)
        {
            this.project = project;

            string basePath = compilerPath ?? @"C:\Program Files\Motion-Twin\haxe"; // default installation
            haxePath = Path.Combine(basePath, "haxe.exe");
            if (!File.Exists(haxePath)) 
                haxePath = "haxe.exe"; // hope you have it in your environment path!
        }

        protected override void DoBuild(string[] extraClasspaths, bool noTrace)
        {
            Environment.CurrentDirectory = project.Directory;

            string output = project.FixDebugReleasePath(project.OutputPathAbsolute);
            string outputDir = Path.GetDirectoryName(project.OutputPathAbsolute);
            if (!Directory.Exists(outputDir)) Directory.CreateDirectory(outputDir);

            if (project.IsNmeOutput)
            {
                haxePath = haxePath.Replace("haxe.exe", "haxelib.exe");
                string config = project.TestMovieBehavior == ProjectManager.Projects.TestMovieBehavior.Custom ? project.TestMovieCommand : null;
                if (String.IsNullOrEmpty(config)) config = "flash";
                string haxeNmeArgs = String.Join(" ", BuildNmeCommand(extraClasspaths, output, config, noTrace, null));
                Console.WriteLine("haxelib " + haxeNmeArgs);
                if (!ProcessRunner.Run(haxePath, haxeNmeArgs, false))
                    throw new BuildException("Build halted with errors (haxelib.exe).");
                return;
            }

            // always use relative path for CPP (because it prepends ./)
            if (project.IsCppOutput)
                output = project.FixDebugReleasePath(project.OutputPath);

            if (project.IsFlashOutput)
            {
                SwfmillLibraryBuilder libraryBuilder = new SwfmillLibraryBuilder();

                // before doing anything else, make sure any resources marked as "keep updated"
                // are properly kept up to date if possible
                libraryBuilder.KeepUpdated(project);

                // if we have any resources, build our library file and run swfmill on it
                libraryBuilder.BuildLibrarySwf(project, false);
            }

            string haxeArgs = String.Join(" ", project.BuildHXML(extraClasspaths, output, noTrace));
            
            string serverPort = Environment.ExpandEnvironmentVariables("%FDBUILD_HAXE_PORT%");
            if (!serverPort.StartsWith("%") && serverPort != "0")
                haxeArgs += " --connect " + serverPort;
            
            Console.WriteLine("haxe " + haxeArgs);

            if (!ProcessRunner.Run(haxePath, haxeArgs, false))
                throw new BuildException("Build halted with errors (haxe.exe).");
        }

        private string[] BuildNmeCommand(string[] extraClasspaths, string output, string target, bool noTrace, string extraArgs)
        {
            List<String> pr = new List<String>();

            pr.Add("run nme build");
            pr.Add(Quote(output));
            pr.Add(target);
            if (!noTrace) pr.Add("-debug");
            if (extraArgs != null) pr.Add(extraArgs);

            return pr.ToArray();
        }

        string Quote(string s)
        {
            if (s.IndexOf(" ") >= 0)
                return "\"" + s + "\"";
            return s;
        }
    }
}
