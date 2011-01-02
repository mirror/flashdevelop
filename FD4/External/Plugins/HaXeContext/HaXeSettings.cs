using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing.Design;
using System.Windows.Forms.Design;
using System.ComponentModel;
using PluginCore.Localization;
using ProjectManager.Projects.Haxe;
using PluginCore;

namespace HaXeContext
{
    public delegate void ClasspathChangedEvent();

    [Serializable]
    public class HaXeSettings : ASCompletion.Settings.IContextSettings
    {
        [field: NonSerialized]
        public event ClasspathChangedEvent OnClasspathChanged;

        #region IContextSettings Documentation

        const string DEFAULT_DOC_COMMAND = "http://www.google.com/search?q=$(ItmTypPkg)+$(ItmTypName)+$(ItmName)+site:http://haxe.org/api";
        protected string documentationCommandLine = DEFAULT_DOC_COMMAND;

        [DisplayName("Documentation Command Line")]
        [LocalizedCategory("ASCompletion.Category.Documentation"), LocalizedDescription("ASCompletion.Description.DocumentationCommandLine"), DefaultValue(DEFAULT_DOC_COMMAND)]
        public string DocumentationCommandLine
        {
            get { return documentationCommandLine; }
            set { documentationCommandLine = value; }
        }

        #endregion

        #region IContextSettings Members

        const bool DEFAULT_CHECKSYNTAX = false;
        const bool DEFAULT_COMPLETIONENABLED = true;
        const bool DEFAULT_GENERATEIMPORTS = true;
        const bool DEFAULT_PLAY = true;
        const bool DEFAULT_LAZYMODE = false;
        const bool DEFAULT_LISTALL = true;
        const bool DEFAULT_QUALIFY = true;
        const bool DEFAULT_FIXPACKAGEAUTOMATICALLY = true;

        protected bool checkSyntaxOnSave = DEFAULT_CHECKSYNTAX;
        private bool lazyClasspathExploration = DEFAULT_LAZYMODE;
        protected bool completionListAllTypes = DEFAULT_LISTALL;
        protected bool completionShowQualifiedTypes = DEFAULT_QUALIFY;
        protected bool completionEnabled = DEFAULT_COMPLETIONENABLED;
        protected bool generateImports = DEFAULT_GENERATEIMPORTS;
        protected bool playAfterBuild = DEFAULT_PLAY;
        protected bool fixPackageAutomatically = DEFAULT_FIXPACKAGEAUTOMATICALLY;
        protected string[] userClasspath = null;
        protected InstalledSDK[] installedSDKs = null;

        [Browsable(false)]
        public string LanguageId
        {
            get { return "HAXE"; }
        }

        [Browsable(false)]
        public string DefaultExtension
        {
            get { return ".hx"; }
        }

        [Browsable(false)]
        public string CheckSyntaxRunning
        {
            get { return TextHelper.GetString("Info.HaXeRunning"); }
        }

        [Browsable(false)]
        public string CheckSyntaxDone
        {
            get { return TextHelper.GetString("Info.HaXeDone"); }
        }

        [DisplayName("Check Syntax On Save")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.CheckSyntaxOnSave"), DefaultValue(DEFAULT_CHECKSYNTAX)]
        public bool CheckSyntaxOnSave
        {
            get { return checkSyntaxOnSave; }
            set { checkSyntaxOnSave = value; }
        }

        [DisplayName("User Classpath")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.UserClasspath")]
        public string[] UserClasspath
        {
            get { return userClasspath; }
            set
            {
                userClasspath = value;
                FireChanged();
            }
        }

        [DisplayName("Installed haXe SDKs")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("HaXeContext.Description.HaXePath")]
        public InstalledSDK[] InstalledSDKs
        {
            get { return installedSDKs; }
            set
            {
                installedSDKs = value;
                FireChanged();
            }
        }

        public InstalledSDK GetDefaultSDK()
        {
            if (installedSDKs == null || installedSDKs.Length == 0) return null;
            foreach (InstalledSDK sdk in installedSDKs)
                if (sdk.IsValid) return sdk;
            return InstalledSDK.INVALID_SDK;
        }

        [DisplayName("Enable Completion")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.CompletionEnabled"), DefaultValue(DEFAULT_COMPLETIONENABLED)]
        public bool CompletionEnabled
        {
            get { return completionEnabled; }
            set { completionEnabled = value; }
        }

        [DisplayName("Generate Imports")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.GenerateImports"), DefaultValue(DEFAULT_GENERATEIMPORTS)]
        public bool GenerateImports
        {
            get { return generateImports; }
            set { generateImports = value; }
        }

        /// <summary>
        /// In completion, show all known types in project
        /// </summary>
        [DisplayName("List All Types In Completion")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.CompletionListAllTypes"), DefaultValue(DEFAULT_LISTALL)]
        public bool CompletionListAllTypes
        {
            get { return completionListAllTypes; }
            set { completionListAllTypes = value; }
        }

        /// <summary>
        /// In completion, show qualified type names (package + type)
        /// </summary>
        [DisplayName("Show QualifiedTypes In Completion")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.CompletionShowQualifiedTypes"), DefaultValue(DEFAULT_QUALIFY)]
        public bool CompletionShowQualifiedTypes
        {
            get { return completionShowQualifiedTypes; }
            set { completionShowQualifiedTypes = value; }
        }

        /// <summary>
        /// Defines if each classpath is explored immediately (PathExplorer) 
        /// </summary>
        [DisplayName("Lazy Classpath Exploration")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.LazyClasspathExploration"), DefaultValue(DEFAULT_LAZYMODE)]
        public bool LazyClasspathExploration
        {
            get { return lazyClasspathExploration; }
            set { lazyClasspathExploration = value; }
        }

        [DisplayName("Play After Build")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.PlayAfterBuild"), DefaultValue(DEFAULT_PLAY)]
        public bool PlayAfterBuild
        {
            get { return playAfterBuild; }
            set { playAfterBuild = value; }
        }

        [DisplayName("Fix Package Automatically")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.FixPackageAutomatically"), DefaultValue(DEFAULT_FIXPACKAGEAUTOMATICALLY)]
        public bool FixPackageAutomatically
        {
            get { return fixPackageAutomatically; }
            set { fixPackageAutomatically = value; }
        }

        #endregion

        #region haXe specific members

        const int DEFAULT_FLASHVERSION = 10;
        const string DEFAULT_HAXECHECKPARAMS = "";
        const bool DEFAULT_DISABLECOMPILERCOMPLETION = false;
        const bool DEFAULT_DISABLEMIXEDCOMPLETION = false;
        const bool DEFAULT_DISABLECOMPLETIONONDEMAND = true;
        const bool DEFAULT_EXPORTHXML = false;

        private int flashVersion = 10;
        private string haXeCheckParameters = DEFAULT_HAXECHECKPARAMS;
        private bool disableCompilerCompletion = DEFAULT_DISABLECOMPILERCOMPLETION;
        private bool disableMixedCompletion = DEFAULT_DISABLEMIXEDCOMPLETION;
        private bool disableCompletionOnDemand = DEFAULT_DISABLECOMPLETIONONDEMAND;
        private bool exportHXML = DEFAULT_EXPORTHXML;

        [DisplayName("Default Flash Version")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("HaXeContext.Description.DefaultFlashVersion"), DefaultValue(DEFAULT_FLASHVERSION)]
        public int DefaultFlashVersion
        {
            get { return flashVersion; }
            set
            {
                if (value == flashVersion) return;
                if (value >= 6 && value <= 12)
                {
                    flashVersion = value;
                    FireChanged();
                }
            }
        }

        [DisplayName("Check Parameters")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("HaXeContext.Description.HaXeCheckParameters"), DefaultValue(DEFAULT_HAXECHECKPARAMS)]
        public string HaXeCheckParameters
        {
            get { return haXeCheckParameters; }
            set { haXeCheckParameters = value; }
        }

        [DisplayName("Disable Compiler-based Completion")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("HaXeContext.Description.DisableCompilerCompletion"), DefaultValue(DEFAULT_DISABLECOMPILERCOMPLETION)]
        public bool DisableCompilerCompletion
        {
            get { return disableCompilerCompletion; }
            set { disableCompilerCompletion = value; }
        }

        [DisplayName("Disable Mixed Completion")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("HaXeContext.Description.DisableMixedCompletion"), DefaultValue(DEFAULT_DISABLEMIXEDCOMPLETION)]
        public bool DisableMixedCompletion
        {
            get { return disableMixedCompletion; }
            set { disableMixedCompletion = value; }
        }

        [DisplayName("Disable Completion On Demand")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("HaXeContext.Description.DisableCompletionOnDemand"), DefaultValue(DEFAULT_DISABLECOMPLETIONONDEMAND)]
        public bool DisableCompletionOnDemand
        {
            get { return disableCompletionOnDemand; }
            set { disableCompletionOnDemand = value; }
        }

        [DisplayName("Export HXML")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("HaXeContext.Description.ExportHXML"), DefaultValue(DEFAULT_EXPORTHXML)]
        public bool ExportHXML
        {
            get { return exportHXML; }
            set { HaxeProject.saveHXML = exportHXML = value; }
        }

        #endregion

        [Browsable(false)]
        private void FireChanged()
        {
            if (OnClasspathChanged != null) OnClasspathChanged();
        }

        [Browsable(false)]
        public void Init()
        {
            HaxeProject.saveHXML = exportHXML;
        }

    }
}
