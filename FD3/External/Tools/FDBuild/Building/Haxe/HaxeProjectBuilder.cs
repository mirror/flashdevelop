using System;
using System.IO;
using System.Collections.Generic;
using System.Runtime.Remoting.Channels.Ipc;
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

            string outputDir = Path.GetDirectoryName(project.OutputPathAbsolute);
            if (!Directory.Exists(outputDir)) Directory.CreateDirectory(outputDir);

            if (project.IsFlashOutput)
            {
                SwfmillLibraryBuilder libraryBuilder = new SwfmillLibraryBuilder();

                // before doing anything else, make sure any resources marked as "keep updated"
                // are properly kept up to date if possible
                libraryBuilder.KeepUpdated(project);

                // if we have any resources, build our library file and run swfmill on it
                libraryBuilder.BuildLibrarySwf(project, false);
            }

            string output = project.FixDebugReleasePath(project.OutputPathAbsolute);
            // always use relative path for CPP (because it prepends ./)
            if (project.IsCppOutput)
                output = project.OutputPath;

            string haxeArgs = String.Join(" ",project.BuildHXML(extraClasspaths, output, noTrace));
            Console.WriteLine("haxe " + haxeArgs);

            if (!ProcessRunner.Run(haxePath, haxeArgs, false))
                throw new BuildException("Build halted with errors (haxe.exe).");
        }
    }
}
