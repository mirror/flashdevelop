using System;
using System.Collections;
using System.IO;
using System.Text;
using ProjectManager.Projects.AS3;
using System.Runtime.InteropServices;

namespace ProjectManager.Building.AS3
{
    class MxmlcArgumentBuilder : ArgumentBuilder
    {
        AS3Project project;

        public MxmlcArgumentBuilder(AS3Project project)
        {
            this.project = project;
        }

        public void AddConfig(string path)
        {
            Add("-load-config+=" + path);

            MxmlcOptions options = project.CompilerOptions;
            if (options.LoadConfig != "")
                Add("-load-config+=" + options.LoadConfig);
        }

        public void AddOutput(string path)
        {
            Add("-o", path);
        }

        public void AddOptions(bool debug, bool incremental)
        {
            if (debug) AddEq("-debug", "true");
            if (incremental) AddEq("-incremental", "true");

            MxmlcOptions options = project.CompilerOptions;
            if (options.Locale.Length > 0) AddEq("-locale", options.Locale);
            if (options.Accessible) AddEq("-accessible", "true");
            if (options.AllowSourcePathOverlap) AddEq("-allow-source-path-overlap", "true");
            if (!options.Benchmark) AddEq("-benchmark", "false");
            if (options.ES)
            {
                AddEq("-es", "true");
                AddEq("-as3", "false");
            }
            if (!debug && options.Optimize) AddEq("-optimize", "true");
            if (!options.ShowActionScriptWarnings) AddEq("-show-actionscript-warnings", "false");
            if (!options.ShowBindingWarnings) AddEq("-show-binding-warnings", "false");
            if (!options.ShowDeprecationWarnings) AddEq("-show-deprecation-warnings", "false");
            if (!options.ShowUnusedTypeSelectorWarnings) AddEq("-show-unused-type-selector-warnings", "false");
            if (!options.Strict) AddEq("-strict", "false");
            if (!options.UseNetwork) AddEq("-use-network", "false");
            if (!options.UseResourceBundleMetadata) AddEq("-use-resource-bundle-metadata", "false");
            if (!options.Warnings) AddEq("-warnings", "false");
            if (options.StaticLinkRSL) AddEq("-static-link-runtime-shared-libraries", "true");
            if (debug && options.VerboseStackTraces) AddEq("-verbose-stacktraces", "true");
            
            if (options.LinkReport.Length > 0) AddEq("-link-report", options.LinkReport);
            if (options.LoadExterns.Length > 0) AddEq("-load-externs", options.LoadExterns);

            if (options.Additional != null) Add(options.Additional);
        }

        void AddEq(string argument, string value)
        {
            Add(argument + "=" + value);
        }

        void AddEq(string argument, bool value)
        {
            AddEq(argument, value ? "true" : "false");
        }
    }
}
