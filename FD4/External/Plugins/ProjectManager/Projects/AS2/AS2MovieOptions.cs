using System;
using System.Collections.Generic;
using System.Text;

namespace ProjectManager.Projects.AS2
{
    public class AS2MovieOptions: MovieOptions
    {
        public AS2MovieOptions()
        {
            MajorVersion = 9;
            Platform = TargetPlatforms[0];
        }

        public override string[] TargetPlatforms
        {
            get
            {
                return new string[] {
                    "Flash Player"
                };
            }
        }

        public override string[] TargetVersions(string platform)
        {
            return new string[] { "6.0", "7.0", "8.0", "9.0" }; 
        }

        public override bool DebuggerSupported
        {
            get { return false; }
        }
    }
}
