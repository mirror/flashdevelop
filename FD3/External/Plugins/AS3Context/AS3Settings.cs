using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing.Design;
using System.Windows.Forms.Design;
using System.ComponentModel;
using PluginCore.Localization;

namespace AS3Context
{
    public delegate void ClasspathChangedEvent();

    [Serializable]
    public class AS3Settings : ASCompletion.Settings.IContextSettings
    {
        public event ClasspathChangedEvent OnClasspathChanged;

        #region IContextSettings Documentation

        const string DEFAULT_DOC_COMMAND = "http://www.google.com/search?q=%22actionscript 3.0%22+$(ItmTypPkg)+$(ItmTypName)+$(ItmName)+site:livedocs.adobe.com";
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
        const string DEFAULT_AS3LIBRARY = @"Library\AS3\intrinsic";

        protected bool checkSyntaxOnSave = DEFAULT_CHECKSYNTAX;
        protected bool lazyClasspathExploration = DEFAULT_LAZYMODE;
        protected bool completionListAllTypes = DEFAULT_LISTALL;
        protected bool completionShowQualifiedTypes = DEFAULT_QUALIFY;
        protected bool completionEnabled = DEFAULT_COMPLETIONENABLED;
        protected bool generateImports = DEFAULT_GENERATEIMPORTS;
        protected bool playAfterBuild = DEFAULT_PLAY;
        protected string[] userClasspath = null;

        [Browsable(false)]
        public string LanguageId
        {
            get { return "AS3"; }
        }

        [Browsable(false)]
        public string DefaultExtension
        {
            get { return ".as"; }
        }

        [Browsable(false)]
        public string CheckSyntaxRunning
        {
            get { return TextHelper.GetString("Info.MXMLCRunning"); }
        }

        [Browsable(false)]
        public string CheckSyntaxDone
        {
            get { return TextHelper.GetString("Info.MXMLCDone"); }
        }

        [DisplayName("Check Syntax On Save")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.CheckSyntaxOnSave"), DefaultValue(DEFAULT_CHECKSYNTAX)]
        public bool CheckSyntaxOnSave
        {
            get { return checkSyntaxOnSave; }
            set { checkSyntaxOnSave = value; }
        }

        [DisplayName("User Classpath")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.UserClasspath"), DefaultValue(DEFAULT_AS3LIBRARY)]
        public string[] UserClasspath
        {
            get { return userClasspath; }
            set
            {
                userClasspath = value;
                FireChanged();
            }
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

        [DisplayName("List All Types In Completion")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.CompletionListAllTypes"), DefaultValue(DEFAULT_LISTALL)]
        public bool CompletionListAllTypes
        {
            get { return completionListAllTypes; }
            set { completionListAllTypes = value; }
        }

        [DisplayName("Show Qualified Types In Completion")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.CompletionShowQualifiedTypes"), DefaultValue(DEFAULT_QUALIFY)]
        public bool CompletionShowQualifiedTypes
        {
            get { return completionShowQualifiedTypes; }
            set { completionShowQualifiedTypes = value; }
        }

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

        #endregion

        #region AS3 specific members

        const int DEFAULT_FLASHVERSION = 10;

        private int flashVersion = 10;
        private string as3ClassPath;

        [DisplayName("Default Flash Version")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("AS3Context.Description.DefaultFlashVersion"), DefaultValue(DEFAULT_FLASHVERSION)]
        public int DefaultFlashVersion
        {
            get { return flashVersion; }
            set
            {
                if (value == flashVersion) return;
                if (value <= 10)
                {
                    flashVersion = value;
                    FireChanged();
                }
            }
        }

        [DisplayName("AS3 Classpath")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("AS3Context.Description.AS3Classpath"), DefaultValue(DEFAULT_AS3LIBRARY)]
        [Editor(typeof(FolderNameEditor), typeof(UITypeEditor))]
        public string AS3ClassPath
        {
            get { return as3ClassPath; }
            set
            {
                if (value == as3ClassPath) return;
                as3ClassPath = value;
                FireChanged();
            }
        }
        #endregion

        #region Flex SDK settings

        const bool DEFAULT_DISABLEFDB = false;
        const bool DEFAULT_VERBOSEFDB = false;
        const bool DEFAULT_DISABLELIVECHECKING = false;

        private string flexSDK;
        private bool disableFDB;
        private bool verboseFDB;
        private bool disableLiveChecking;

        [DisplayName("Flex SDK Location")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("AS3Context.Description.FlexSDK")]
        [Editor(typeof(FolderNameEditor), typeof(UITypeEditor))]
        public string FlexSDK
        {
            get { return flexSDK; }
            set { flexSDK = value; }
        }

        [DisplayName("Disable Flex Debugger Hosting")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("ASCompletion.Description.DisableFDB"), DefaultValue(DEFAULT_DISABLEFDB)]
        public bool DisableFDB
        {
            get { return disableFDB; }
            set { disableFDB = value; }
        }

        [DisplayName("Verbose Flex Debugger Output")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("ASCompletion.Description.VerboseFDB"), DefaultValue(DEFAULT_VERBOSEFDB)]
        public bool VerboseFDB
        {
            get { return verboseFDB; }
            set { verboseFDB = value; }
        }

        [DisplayName("Disable Live Syntax Checking")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("ASCompletion.Description.DisableLiveSyntaxChecking"), DefaultValue(DEFAULT_DISABLELIVECHECKING)]
        public bool DisableLiveChecking
        {
            get { return disableLiveChecking; }
            set { disableLiveChecking = value; }
        }

        #endregion

        [Browsable(false)]
        private void FireChanged()
        {
            if (OnClasspathChanged != null) OnClasspathChanged();
        }
    }
}
