using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;

namespace ASCompletion.Settings
{
    public interface IContextSettings
    {
        /// <summary>
        /// Language short name (ie. AS2, AS3, JS, etc)
        /// </summary>
        string LanguageId { get; }

        /// <summary>
        /// Default file extension of the language, including dot
        /// </summary>
        string DefaultExtension { get; }

        /// <summary>
        /// Command to execute for help search
        /// </summary>
        string DocumentationCommandLine { get; set; }

        /// <summary>
        /// Completion engine enabled
        /// </summary>
        bool CompletionEnabled { get; set; }

        /// <summary>
        /// User global classpath
        /// </summary>
        string[] UserClasspath { get; set; }

        /// <summary>
        /// Imports statements automatic generation
        /// </summary>
        bool GenerateImports { get; set; }

        /// <summary>
        /// Defines if each classpath is explored immediately (PathExplorer) 
        /// </summary>
        bool LazyClasspathExploration { get; set; }

        /// <summary>
        /// In completion, show all known types in project
        /// </summary>
        bool CompletionListAllTypes { get; set; }

        /// <summary>
        /// In completion, show qualified type names (package + type)
        /// </summary>
        bool CompletionShowQualifiedTypes { get; set; }

        /// <summary>
        /// Run syntax checking on file save
        /// </summary>
        bool CheckSyntaxOnSave { get; set; }

        bool PlayAfterBuild { get; set; }

        bool FixPackageAutomatically { get; set; }

        string CheckSyntaxRunning { get; }
        string CheckSyntaxDone { get; }

    }
}
