using System;
using System.Collections.Generic;
using System.Text;

namespace ProjectManager.Projects.Haxe
{
    public class HaxeMovieOptions : MovieOptions
    {
        public HaxeMovieOptions()
        {
            MajorVersion = 10;
            Platform = TargetPlatforms[0];
        }

        public override bool DebuggerSupported
        {
            get
            {
                return (Platform == "Flash Player" && MajorVersion >= 9) || Platform == "AIR";
            }
        }

        public override string[] TargetPlatforms
        {
            get
            {
                return new string[] {
                    "Flash Player",
                    "AIR",
                    "JavaScript",
                    "Neko",
                    "PHP",
                    "C++"
                };
            }
        }

        public override string[] TargetVersions(string platform)
        {
            if (platform == "AIR")
                return new string[] { "1.5", "2.0", "2.5" };
            else if (platform == "Flash Player")
                return new string[] { "6.0", "7.0", "8.0", "9.0", "10.0", "10.1", "10.2" };
            else 
                return new string[] { "1.0" };
        }

        public override string DefaultVersion(string platform)
        {
            if (platform == "AIR") return "2.0";
            else if (platform == "Flash Player") return "10.0";
            else return "1.0";
        }
    }
}
