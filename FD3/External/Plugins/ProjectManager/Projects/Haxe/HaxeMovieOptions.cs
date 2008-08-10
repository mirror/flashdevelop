using System;
using System.Collections.Generic;
using System.Text;

namespace ProjectManager.Projects.Haxe
{
    public class HaxeMovieOptions : MovieOptions
    {
        public override string[] TargetPlatforms
        {
            get
            {
                return new string[] {
                    "Flash Player 6", 
                    "Flash Player 7",
                    "Flash Player 8",
                    "Flash Player 9",
                    "JavaScript",
                    "Neko"
                };
            }
        }
        public override int Platform
        {
            get { return Version - 6; }
            set { Version = value + 6; }
        }
    }
}
