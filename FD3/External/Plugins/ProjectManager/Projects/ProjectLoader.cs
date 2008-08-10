using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using ProjectManager.Projects.AS2;
using ProjectManager.Projects.AS3;
using ProjectManager.Projects.Haxe;

namespace ProjectManager.Projects
{
    class ProjectLoader
    {
        public static Project Load(string file)
        {
            if (FileInspector.IsAS2Project(file))
                return AS2Project.Load(file);
            else if (FileInspector.IsAS3Project(file))
                return AS3Project.Load(file);
            else if (FileInspector.IsHaxeProject(file))
                return HaxeProject.Load(file);
            else
                throw new Exception("Unknown project extension: " + Path.GetFileName(file));
        }
    }
}
