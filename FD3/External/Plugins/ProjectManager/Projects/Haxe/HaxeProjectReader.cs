using System;
using System.Collections.Generic;
using System.Text;

namespace ProjectManager.Projects.Haxe
{
    public class HaxeProjectReader : ProjectReader
    {
        HaxeProject project;

        public HaxeProjectReader(string filename)
            : base(filename, new HaxeProject(filename))
        {
            this.project = base.Project as HaxeProject;
        }

        public new HaxeProject ReadProject()
        {
            return base.ReadProject() as HaxeProject;
        }

        // process HaXe-specific stuff
        protected override void ProcessNode(string name)
        {
            switch (name)
            {
                case "build": ReadBuildOptions(); break;
                case "library": ReadLibraryAssets(); break;
                case "haxelib": ReadLibraries(); break;
                default: base.ProcessNode(name); break;
            }
        }

        public void ReadLibraries()
        {
            List<string> libraries = new List<string>();

            ReadStartElement("haxelib");
            while (Name == "library")
            {
                libraries.Add(GetAttribute("name"));
                Read();
            }
            ReadEndElement();

            project.CompilerOptions.Libraries = new string[libraries.Count];
            libraries.CopyTo(project.CompilerOptions.Libraries);
        }

        public void ReadBuildOptions()
        {
            HaxeOptions options = project.CompilerOptions;

            ReadStartElement("build");
            while (Name == "option")
            {
                MoveToFirstAttribute();
                switch (Name)
                {
                    case "directives": options.Directives = (Value=="") ? new string[]{} : Value.Split('\n'); break;
                    case "flashStrict": options.FlashStrict = BoolValue; break;
                    case "mainClass": options.MainClass = Value; break;
                    case "forcetraces": options.ForceTraces = BoolValue; break;
                    case "additional": options.Additional = Value.Split('\n'); break;
                }
                Read();
            }
            ReadEndElement();
        }

        public void ReadLibraryAssets()
        {
            ReadStartElement("library");
            while (Name == "asset")
            {
                string path = OSPath(GetAttribute("path"));
                string mode = GetAttribute("mode");

                if (path == null)
                    throw new Exception("All library assets must have a 'path' attribute.");

                LibraryAsset asset = new LibraryAsset(project, path);
                project.LibraryAssets.Add(asset);

                asset.ManualID = GetAttribute("id"); // could be null
                asset.UpdatePath = OSPath(GetAttribute("update")); // could be null
                asset.FontGlyphs = GetAttribute("glyphs"); // could be null

                if (mode != null)
                    asset.SwfMode = (SwfAssetMode)Enum.Parse(typeof(SwfAssetMode), mode, true);

                if (asset.SwfMode == SwfAssetMode.Shared)
                    asset.Sharepoint = GetAttribute("sharepoint"); // could be null

                if (asset.IsImage && GetAttribute("bitmap") != null)
                    asset.BitmapLinkage = Boolean.Parse(GetAttribute("bitmap"));

                Read();
            }
            ReadEndElement();
        }
    }
}
