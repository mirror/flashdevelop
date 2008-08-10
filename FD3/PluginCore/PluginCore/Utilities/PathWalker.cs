using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
using PluginCore;

namespace PluginCore.Utilities
{
    public class PathWalker
    {
        private String basePath;
        private String fileMask;
        private Boolean recursive;
        private List<String> knownPathes;
        private List<String> foundFiles;

        public PathWalker(String basePath, String fileMask, Boolean recursive)
        {
            this.basePath = basePath;
            this.fileMask = fileMask;
            this.recursive = recursive;
        }

        /// <summary>
        /// Gets a list of the files
        /// </summary>
        public List<String> GetFiles()
        {
            this.foundFiles = new List<String>();
            this.knownPathes = new List<String>();
            this.ExploreFolder(basePath);
            return this.foundFiles;
        }
        
        /// <summary>
        /// Explores the content of the folder
        /// </summary> 
        private void ExploreFolder(String path)
        {
            this.knownPathes.Add(path);
            String[] files = Directory.GetFiles(path, fileMask);
            foreach (String file in files)
            {
                this.foundFiles.Add(file);
            }
            if (!recursive) return;
            String[] dirs = Directory.GetDirectories(path);
            foreach (String dir in dirs)
            {
                try
                {
                    if (!this.knownPathes.Contains(dir))
                    {
                        this.ExploreFolder(dir);
                    }
                }
                catch { /* Might be system folder.. */ };
            }
        }

    }

}
