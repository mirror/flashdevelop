using System;
using System.Collections.Generic;
using System.Text;

namespace ProjectManager.Projects.AS3
{
    public class AS3MovieOptions : MovieOptions
    {
        public override string[] TargetPlatforms
        {
            get
            {
                return new string[] {
                    "Flash Player 9",
                    "Flash Player 10",
                    "Flash Player 10.1"
                };
            }
        }
        public override int Platform
        {
            get { return Version - 9; }
            set { Version = value + 9; }
        }
    }
}
