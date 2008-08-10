using System;
using System.ComponentModel;
using System.Collections.Generic;
using PluginCore.Localization;
using System.Text;

namespace ProjectManager.Projects.Haxe
{
    [Serializable]
    public class HaxeOptions : CompilerOptions
    {
        string directives = "";
        string mainClass = "";
        bool verbose = false;
        bool flashStrict = false;
        //bool flashUseStage = false;
        bool declareOverride = false;
        string[] additional = new string[] { };
        string[] libraries = new string[] { };

        [LocalizedCategory("ProjectManager.Category.CompilerOptions")]
        [DisplayName("Additional Compiler Options")]
        [LocalizedDescription("ProjectManager.Description.Additional")]
        [DefaultValue(new string[] { })]
        public string[] Additional { get { return additional; } set { additional = value; } }

        [LocalizedCategory("ProjectManager.Category.CompilerOptions")]
        [DisplayName("Directives")]
        [LocalizedDescription("ProjectManager.Description.Directives")]
        [DefaultValue("")]
        public string Directives { get { return directives; } set { directives = value; } }

        [DisplayName("Libraries")]
        [LocalizedCategory("ProjectManager.Category.CompilerOptions")]
        [LocalizedDescription("ProjectManager.Description.HaXeLibraries")]
        [DefaultValue(new string[] { })]
        public string[] Libraries
        {
            get { return libraries; }
            set { libraries = value; }
        }

        [LocalizedCategory("ProjectManager.Category.CompilerOptions")]
        [DisplayName("Main Class")]
        [LocalizedDescription("ProjectManager.Description.MainClass")]
        [DefaultValue("")]
        public string MainClass { get { return mainClass; } set { mainClass = value; } }

        [LocalizedCategory("ProjectManager.Category.CompilerOptions")]
        [DisplayName("Flash Strict")]
        [LocalizedDescription("ProjectManager.Description.FlashStrict")]
        [DefaultValue(false)]
        public bool FlashStrict { get { return flashStrict; } set { flashStrict = value; } }

        // Require "Injection panel"
        /*[Category("Compiler Options")]
        [DisplayName("Flash Use Stage")]
        [Description("Place objects found on the stage of the SWF library.")]
        [DefaultValue(false)]
        public bool FlashUseStage { get { return flashUseStage; } set { flashUseStage = value; } }*/

        [LocalizedCategory("ProjectManager.Category.CompilerOptions")]
        [DisplayName("Declare Override")]
        [LocalizedDescription("ProjectManager.Description.DeclareOverride")]
        [DefaultValue(false)]
        public bool DeclareOverride { get { return declareOverride; } set { declareOverride = value; } }

        [LocalizedCategory("ProjectManager.Category.CompilerOptions")]
        [DisplayName("Verbose Output")]
        [LocalizedDescription("ProjectManager.Description.Verbose")]
        [DefaultValue(false)]
        public bool Verbose { get { return verbose; } set { verbose = value; } }
    }
}
