using System;
using System.Collections.Generic;
using System.Text;
using ProjectManager.Projects;

namespace LoomContext.Projects
{
    public class LoomMovieOptions : MovieOptions
    {
        public const string LOOM_PLATFORM = "Loom";
        public const string CUSTOM_PLATFORM = "Custom";

        public LoomMovieOptions()
        {
            MajorVersion = 1;
            Platform = TargetPlatforms[0];
        }

        public override bool DebuggerSupported
        {
            get { return true; }
        }

        public override string[] TargetPlatforms
        {
            get { return new string[] { LOOM_PLATFORM, CUSTOM_PLATFORM }; }
        }

        public override string[] TargetVersions(string platform)
        {
            switch (platform)
            {
                case CUSTOM_PLATFORM: return new string[] { "0.0" };
                default: return new string[] { "1.0" };
            }
        }

        public override string DefaultVersion(string platform)
        {
            switch (platform)
            {
                case CUSTOM_PLATFORM: return "0.0";
                default: return "1.0";
            }
        }

        public override OutputType[] OutputTypes
        {
            get
            {
                return new OutputType[] { 
                    OutputType.CustomBuild, OutputType.Application };
            }
        }

        public override OutputType DefaultOutput(string platform)
        {
            return platform == CUSTOM_PLATFORM ? OutputType.CustomBuild : OutputType.Application;
        }

        public override bool IsGraphical(string platform)
        {
            return platform != CUSTOM_PLATFORM;
        }

    }
}
