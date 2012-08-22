﻿using System;
using System.Collections.Generic;
using System.Text;

namespace ProjectManager.Projects.AS3
{
    public class AS3MovieOptions : MovieOptions
    {
        public const string FLASHPLAYER_PLATFORM = "Flash Player";
        public const string AIR_PLATFORM = "AIR";
        public const string AIR_MOBILE_PLATFORM = "AIR Mobile";
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
            get { return new string[] { FLASHPLAYER_PLATFORM, AIR_PLATFORM, AIR_MOBILE_PLATFORM, CUSTOM_PLATFORM }; }
        }

        public override string[] TargetVersions(string platform)
        {
            switch (platform)
            {
                case CUSTOM_PLATFORM: return new string[] { "0.0" };
                case AIR_MOBILE_PLATFORM: return new string[] { "2.5", "2.6", "2.7", "3.0", "3.1", "3.2", "3.3", "3.4" };
                case AIR_PLATFORM: return new string[] { "1.5", "2.0", "2.5", "2.6", "2.7", "3.0", "3.1", "3.2", "3.3", "3.4" };
                default: return new string[] { "9.0", "10.0", "10.1", "10.2", "10.3", "11.0", "11.1", "11.2", "11.3", "11.4" };
            }
        }

        public override string DefaultVersion(string platform)
        {
            switch (platform)
            {
                case CUSTOM_PLATFORM: return "0.0";
                case AIR_PLATFORM: return "3.4";
                case AIR_MOBILE_PLATFORM: return "3.4";
                default: return "10.3";
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

        public string GetSWFVersion()
        {
            if (Platform != FLASHPLAYER_PLATFORM) return null;
            int index = Array.IndexOf(TargetVersions(FLASHPLAYER_PLATFORM), Version);
            if (index < 0) return null;
            string[] versions = new string[] { "9", "10", "10", "11", "12", "13", "14", "15", "16", "17" };
            return versions[index];
        }
    }
}
