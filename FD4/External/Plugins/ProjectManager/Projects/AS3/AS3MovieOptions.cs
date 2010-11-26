using System;
using System.Collections.Generic;
using System.Text;

namespace ProjectManager.Projects.AS3
{
    public class AS3MovieOptions : MovieOptions
    {
        public AS3MovieOptions()
        {
            MajorVersion = 10;
            Platform = TargetPlatforms[0];
        }

        public override string[] TargetPlatforms
        {
            get
            {
                return new string[] {
                    "Flash Player",
                    "AIR"
                };
            }
        }

        public override string[] TargetVersions(string platform)
        {
            if (platform == "AIR")
                return new string[] { "1.5", "2.0", "2.5" };
            else
                return new string[] { "9.0", "10.0", "10.1", "10.2" };
        }

        public override bool DebuggerSupported
        {
            get { return true; }
        }
    }
}
