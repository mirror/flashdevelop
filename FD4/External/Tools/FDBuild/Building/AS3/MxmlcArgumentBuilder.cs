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
        bool flex45;

        public MxmlcArgumentBuilder(AS3Project project, double sdkVersion)
        {
            this.project = project;
            this.flex45 = sdkVersion >= 4.5;
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

        public void AddOptions(bool releaseMode, bool incremental)
        {
            if (!releaseMode) AddEq("-debug", true);
            if (incremental) AddEq("-incremental", true);

            MxmlcOptions options = project.CompilerOptions;

            if (options.LinkReport.Length > 0) Add("-link-report", options.LinkReport);
            if (options.LoadExterns.Length > 0) Add("-load-externs", options.LoadExterns);

            bool hasConfig = false;
            bool hasVersion = false;
            if (options.Additional != null)
            {
                string all = String.Join(" ", options.Additional);
                if (all.IndexOf("configname") > 0) hasConfig = true;
                if (all.IndexOf("swf-version") > 0) hasVersion = true;
            }

            if (!hasConfig)
            {
                if (project.MovieOptions.Platform == "AIR")
                    AddEq("+configname", "air");
                else if (project.MovieOptions.Platform == "AIR Mobile")
                    AddEq("+configname", "airmobile");
            }
            if (flex45 && !hasVersion)
            {
                string swfVersion = (project.MovieOptions as AS3MovieOptions).GetSWFVersion();
                if (swfVersion != null) AddEq("-swf-version", swfVersion);
            }

            if (options.Additional != null)
                Add(options.Additional, releaseMode);
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
