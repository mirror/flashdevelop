using System;
using System.Collections.Generic;
using System.Text;
using PluginCore.Utilities;
using System.IO;
using PluginCore.Managers;

namespace SourceControl.Sources.Mercurial
{
    class DeleteCommand : BaseCommand
    {
        public DeleteCommand(string[] paths)
        {
            string args = "rm -f";
            foreach (string path in paths)
            {
                args += " \"" + Path.GetFileName(path) + "\"";
            }

            Run(args, Path.GetDirectoryName(paths[0]));
        }
    }
}
