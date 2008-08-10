using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using ProjectManager.Projects;
using ProjectManager.Projects.AS2;
using ProjectManager.Projects.AS3;
using ProjectManager.Projects.Haxe;
using ProjectManager.Building.AS2;
using ProjectManager.Building.AS3;
using ProjectManager.Building.Haxe;

namespace ProjectManager.Building
{
    public abstract class ProjectBuilder
    {
        Project project;
        string compilerPath;

        public string CompilerPath
        {
            get { return compilerPath; }
            set { compilerPath = value; }
        }

        public ProjectBuilder(Project project, string compilerPath)
        {
            this.project = project;
            this.compilerPath = compilerPath;
        }

        public static ProjectBuilder Create(Project project, string ipcName, string compilerPath)
        {
            if (project is AS2Project)
                return new AS2ProjectBuilder(project as AS2Project, compilerPath);
            else if (project is AS3Project)
                return new AS3ProjectBuilder(project as AS3Project, compilerPath, ipcName);
            else if (project is HaxeProject)
                return new HaxeProjectBuilder(project as HaxeProject, compilerPath);
            else
                throw new Exception("FDBuild doesn't know how to build " + project.GetType().Name);
        }

        protected string FDBuildDirectory
        {
            get
            {
                string url = Assembly.GetEntryAssembly().GetName().CodeBase;
                Uri uri = new Uri(url);
                return Path.GetDirectoryName(uri.LocalPath);
            }
        }

        public void Build(string[] extraClasspaths, bool noTrace)
        {
            Console.WriteLine("Building " + project.Name);

            BuildEventRunner runner = new BuildEventRunner(project, compilerPath);
            bool attempedPostBuildEvent = false;

            try
            {
                if (project.PreBuildEvent.Length > 0)
                {
                    Console.WriteLine("Running Pre-Build Command Line...");
                    runner.Run(project.PreBuildEvent);
                }
                if (!project.NoOutput) DoBuild(extraClasspaths, noTrace);
                attempedPostBuildEvent = true;

                if (project.PostBuildEvent.Length > 0)
                {
                    Console.WriteLine("Running Post-Build Command Line...");
                    runner.Run(project.PostBuildEvent);
                }
            }
            finally
            {
                // honor the post-build request on a failed build if you want
                if (!attempedPostBuildEvent && project.AlwaysRunPostBuild &&
                    project.PostBuildEvent.Length > 0)
                {
                    Console.WriteLine("Running Post-Build Command Line...");
                    runner.Run(project.PostBuildEvent);
                }
            }

            Console.WriteLine("Build succeeded");
        }

        public void BuildCommand(string[] extraClasspaths, bool noTrace)
        {
            DoBuild(extraClasspaths, noTrace);
        }

        protected abstract void DoBuild(string[] extraClasspaths, bool noTrace);
    }
}
