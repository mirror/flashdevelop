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

        public void AddOptions(bool releaseMode, bool incremental)
        {
            if (!releaseMode) AddEq("-debug", true);
            if (incremental) AddEq("-incremental", true);

            MxmlcOptions options = project.CompilerOptions;

            if (options.LinkReport.Length > 0) Add("-link-report", options.LinkReport);
            if (options.LoadExterns.Length > 0) Add("-load-externs", options.LoadExterns);

            bool hasConfig = false;
            if (options.Additional != null)
            {
                Add(options.Additional, releaseMode);
                foreach (string line in options.Additional)
                    if (line.IndexOf("configname=") > 0) { hasConfig = true; }
            }

            if (!hasConfig)
            {
                if (project.MovieOptions.Platform == "AIR")
                    AddEq("+configname", "air");
                else if (project.MovieOptions.Platform == "AIR Mobile")
                    AddEq("+configname", "airmobile");
            }
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
