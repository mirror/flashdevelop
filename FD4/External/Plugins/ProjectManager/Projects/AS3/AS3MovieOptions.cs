using System;
using System.Collections.Generic;
using System.Text;

namespace ProjectManager.Projects.AS3
{
    public class AS3MovieOptions : MovieOptions
    {
        public const string FLASHPLAYER_PLATFORM = "Flash Player";
        public const string AIR_PLATFORM = "AIR";
        public const string CUSTOM_PLATFORM = "Custom";

        public AS3MovieOptions()
        {
            MajorVersion = 10;
            Platform = TargetPlatforms[0];
        }

        public override bool DebuggerSupported
        {
            get { return true; }
        }

        public override string[] TargetPlatforms
        {
            get { return new string[] { FLASHPLAYER_PLATFORM, AIR_PLATFORM, CUSTOM_PLATFORM }; }
        }

        public override string[] TargetVersions(string platform)
        {
            switch (platform)
            {
                case CUSTOM_PLATFORM: return new string[] { "0.0" };
                case AIR_PLATFORM: return new string[] { "1.5", "2.0", "2.5" };
                default: return new string[] { "9.0", "10.0", "10.1", "10.2", "10.3", "11.0" };
            }
        }

        public override string DefaultVersion(string platform)
        {
            switch (platform)
            {
                case CUSTOM_PLATFORM: return "0.0";
                case AIR_PLATFORM: return "2.0";
                default: return "10.0";
            }
        }

        public override OutputType[] OutputTypes
        {
            get
            {
                return new OutputType[] { 
                    OutputType.OtherIDE, OutputType.CustomBuild, OutputType.Application/*, OutputType.Library*/ };
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
