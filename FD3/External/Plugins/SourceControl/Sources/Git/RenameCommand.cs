using System;
using System.Collections.Generic;
using System.Text;
using PluginCore.Utilities;
using System.IO;
using PluginCore.Managers;

namespace SourceControl.Sources.Git
{
    class RenameCommand : BaseCommand
    {
        public RenameCommand(string path, string newName)
        {
            string args = String.Format("mv \"{0}\" \"{1}\"", Path.GetFileName(path), newName);

            Run(args, Path.GetDirectoryName(path));
        }
    }
}
