using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Xml;

namespace ProjectManager.Projects.AS3
{
    class FlexProjectReader : ProjectReader
    {
        AS3Project project;
        string mainApp;
        string outputPath;
        PathCollection applications;

        public FlexProjectReader(string filename)
            : base(filename, new AS3Project(filename))
        {
            this.project = base.Project as AS3Project;
        }

        protected override void ProcessRootNode()
        {
            mainApp = GetAttribute("mainApplicationPath");
        }
        
        protected override void ProcessNode(string name)
        {
            if (NodeType == XmlNodeType.Element)
            switch (name)
            {
                case "compiler": ReadCompilerOptions(); break;
                case "applications": ReadApplications(); break;
                case "modules": ReadModules(); break;
            }
        }

        private void ReadCompilerOptions()
        {
            outputPath = GetAttribute("outputFolderPath") ?? "";
            mainApp = (GetAttribute("sourceFolderPath") ?? "") + "/" + mainApp;
            if (mainApp.StartsWith("/")) mainApp = mainApp.Substring(1);
            project.CompileTargets.Add(OSPath(mainApp.Replace('/', '\\')));

            project.TraceEnabled = GetAttribute("enableModuleDebug") == "true";
            project.CompilerOptions.Warnings = GetAttribute("warn") == "true";
            project.CompilerOptions.Strict = GetAttribute("strict") == "true";
            project.CompilerOptions.Accessible = GetAttribute("generateAccessible") == "true";

            string additional = GetAttribute("additionalCompilerArguments") ?? "";
            List<string> api = new List<string>();
            if (GetAttribute("useApolloConfig") == "true")
            {
                if (additional.Length > 0) additional += "\n";
                project.MovieOptions.Platform = AS3MovieOptions.AIR_PLATFORM;
                project.TestMovieBehavior = TestMovieBehavior.Custom;
            }
            else
            {
                project.MovieOptions.Platform = AS3MovieOptions.FLASHPLAYER_PLATFORM;
                project.TestMovieBehavior = TestMovieBehavior.Default;
            }
            project.MovieOptions.Version = project.MovieOptions.DefaultVersion(project.MovieOptions.Platform);

            project.CompilerOptions.Additional = additional.Split('\n');
            if (Path.GetExtension(mainApp).ToLower() == ".mxml")
            {
                int target = 4;
                try
                {
                    string mainFile = ResolvePath(mainApp, project.Directory);
                    if (mainFile != null && File.Exists(mainFile))
                        if (File.ReadAllText(mainFile).IndexOf("http://www.adobe.com/2006/mxml") > 0)
                        {
                            target = 3;
                            if (project.MovieOptions.Platform == AS3MovieOptions.FLASHPLAYER_PLATFORM)
                                project.MovieOptions.Version = "9.0";
                        }
                }
                catch { } 
                api.Add("Library\\AS3\\frameworks\\Flex" + target);
            }
            if (api.Count > 0) project.CompilerOptions.IntrinsicPaths = api.ToArray();

            while (Read() && Name != "compiler")
                ProcessCompilerOptionNode(Name);
        }

        private void ProcessCompilerOptionNode(string name)
        {
            if (NodeType == XmlNodeType.Element)
            switch (name)
            {
                case "compilerSourcePath": ReadCompilerSourcePaths(); break;
                case "libraryPath": ReadLibraryPaths(); break;
            }
        }

        private void ReadCompilerSourcePaths()
        {
            ReadStartElement("compilerSourcePath");
            ReadPaths("compilerSourcePathEntry", project.Classpaths);
        }

        private void ReadLibraryPaths()
        {
            if (!IsStartElement())
                return;
            ReadStartElement("libraryPath");
            LibraryAsset asset;
            bool exclude = false;
            while (Name != "libraryPath")
            {
                switch (Name)
                {
                    case "excludedEntries":
                        exclude = IsStartElement();
                        break;

                    case "libraryPathEntry":
                        string path = GetAttribute("path") ?? "";
                        if (path.Length > 0 && !path.StartsWith("$"))
                        {
                            asset = new LibraryAsset(project, path.Replace('/', '\\'));
                            if (exclude) asset.SwfMode = SwfAssetMode.ExternalLibrary;
                            else asset.SwfMode = SwfAssetMode.Library;
                            project.SwcLibraries.Add(asset);
                        }
                        break;
                }
                Read();
            }
            project.RebuildCompilerOptions();
        }

        public void ReadApplications()
        {
            ReadStartElement("applications");
            applications = new PathCollection();
            ReadPaths("application", applications);
            if (applications.Count > 0)
            {
                project.OutputPath = Path.Combine(outputPath, 
                    Path.GetFileNameWithoutExtension(applications[0]) + ".swf");
            }
        }

        private void ReadModules()
        {
            ReadStartElement("modules");
            PathCollection targets = new PathCollection();
            while (Name == "module")
            {
                string app = GetAttribute("application") ?? "";
                if (app == mainApp)
                {
                    project.OutputPath = Path.Combine(outputPath, GetAttribute("destPath") ?? "");
                }
                Read();
            }
        }

        public static String ResolvePath(String path, String relativeTo)
        {
            if (path == null || path.Length == 0) return null;
            Boolean isPathNetworked = path.StartsWith("\\\\") || path.StartsWith("//");
            if (Path.IsPathRooted(path) || isPathNetworked) return path;
            String resolvedPath = Path.Combine(relativeTo, path);
            if (Directory.Exists(resolvedPath) || File.Exists(resolvedPath)) return resolvedPath;
            return null;
        }
    }
}
