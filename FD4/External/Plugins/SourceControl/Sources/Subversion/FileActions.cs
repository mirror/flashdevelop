using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

namespace SourceControl.Sources.Subversion
{
    class FileActions:IVCFileActions
    {
        public bool FileBeforeRename(string path)
        {
            return false; // allow in tree edition
        }

        public bool FileRename(string path, string newName)
        {
            new RenameCommand(path, newName);
            return true; // operation handled
        }

        public bool FileDelete(string[] paths, bool confirm)
        {
            if (confirm)
            {
                new DeleteCommand(paths);
                return true; // operation handled
            }
            else return false; // let cut/paste files
        }

        public bool FileMove(string fromPath, string toPath)
        {
            new MoveCommand(fromPath, toPath);
            return true;
        }
    }
}
