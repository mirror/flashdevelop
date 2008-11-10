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
            string ext = Path.GetExtension(file).ToLower();
            if (FileInspector.IsAS2Project(file, ext))
                return AS2Project.Load(file);
            else if (FileInspector.IsAS3Project(file, ext))
                return AS3Project.Load(file);
            else if (FileInspector.IsHaxeProject(file, ext))
                return HaxeProject.Load(file);
            else
                throw new Exception("Unknown project extension: " + Path.GetFileName(file));
        }
    }
}
