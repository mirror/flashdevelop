using System;
using System.Collections.Generic;
using System.Text;

namespace ProjectManager.Projects.Haxe
{
    public class HaxeMovieOptions : MovieOptions
    {
        public const string FLASHPLAYER_PLATFORM = "Flash Player";
        public const string AIR_PLATFORM = "AIR";
        public const string CUSTOM_PLATFORM = "Custom";
        public const string JAVASCRIPT_PLATFORM = "JavaScript";
        public const string NEKO_PLATFORM = "Neko";
        public const string PHP_PLATFORM = "PHP";
        public const string CPP_PLATFORM = "C++";
        
        public HaxeMovieOptions()
        {
            MajorVersion = 10;
            Platform = TargetPlatforms[0];
        }

        public override bool DebuggerSupported
        {
            get
            {
                return (Platform == FLASHPLAYER_PLATFORM && MajorVersion >= 9) || Platform == AIR_PLATFORM;
            }
        }

        public override string[] TargetPlatforms
        {
            get { return new string[] { 
                FLASHPLAYER_PLATFORM, AIR_PLATFORM, JAVASCRIPT_PLATFORM, 
                NEKO_PLATFORM, PHP_PLATFORM, CPP_PLATFORM 
            }; }
        }

        public override string[] TargetVersions(string platform)
        {
            switch (platform)
            {
                case AIR_PLATFORM: return new string[] { "1.5", "2.0", "2.5", "2.6", "2.7", "3.0" };
                case FLASHPLAYER_PLATFORM: return new string[] { "6.0", "7.0", "8.0", "9.0", "10.0", "10.1", "10.2", "10.3", "11.0" };
                default: return new string[] { "1.0" };
            }
        }

        public override string DefaultVersion(string platform)
        {
            switch (platform)
            {
                case AIR_PLATFORM: return "2.0";
                case FLASHPLAYER_PLATFORM: return "10.0";
                default: return "1.0";
            }
        }

        public override OutputType[] OutputTypes
        {
            get
            {
                return new OutputType[] { 
                    OutputType.CustomBuild, OutputType.Application, OutputType.Website };
            }
        }

        public override OutputType DefaultOutput(string platform)
        {
            return OutputType.Application;
        }

        public override bool IsGraphical(string platform)
        {
            return platform == AIR_PLATFORM || platform == FLASHPLAYER_PLATFORM;
        }
    }
}
