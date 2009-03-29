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
                libraryBuilder.BuildLibrarySwf(project, project.CompilerOptions.Verbose);
            }

            string tempFile = Path.GetTempFileName();

            try
            {
                if (File.Exists(tempFile)) File.Delete(tempFile);
                string output = project.FixDebugReleasePath(project.OutputPathAbsolute);

                HaxeArgumentBuilder haxe = new HaxeArgumentBuilder(project);
                haxe.AddLibraries(project.CompilerOptions.Libraries);
                haxe.AddClassPaths(extraClasspaths);
                haxe.AddHeader();
                haxe.AddCompileTargets();
                haxe.AddOutput(project.IsPhpOutput ? output : tempFile);
                haxe.AddOptions(noTrace);

                string haxeArgs = haxe.ToString();

                Console.WriteLine("haxe " + haxeArgs);

                if (!ProcessRunner.Run(haxePath, haxeArgs, false))
                    throw new BuildException("Build halted with errors (haxe.exe).");

                // if we get here, the build was successful
                if (!project.IsPhpOutput)
                    File.Copy(tempFile, output, true);
            }
            finally { File.Delete(tempFile); }
        }
    }
}
