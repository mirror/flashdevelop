using System;
using System.Collections;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Text;
using System.IO;
using ASCompletion.Context;
using PluginCore.Managers;
using System.Windows.Forms;

namespace ASCompletion.Model
{
    /// <summary>
    /// Files cache
    /// </summary>
    public class PathModel
    {
        //static private readonly bool cacheEnabled = false;
        static private Dictionary<string, PathModel> pathes = new Dictionary<string, PathModel>();

        /// <summary>
        /// Delete all models and remove all watchers
        /// </summary>
        static public void ClearAll()
        {
            foreach (PathModel model in pathes.Values)
            {
                if (model.watcher != null)
                {
                    model.watcher.EnableRaisingEvents = false;
                    model.watcher.Dispose();
                }
            }
            pathes.Clear();
        }

        /// <summary>
        /// Free models & system watchers
        /// </summary>
        static public void Compact()
        {
            lock (pathes)
            {
                //TimeSpan keep = TimeSpan.FromMinutes(5);
                Dictionary<string, PathModel> clean = new Dictionary<string, PathModel>();
                foreach (string key in pathes.Keys)
                {
                    PathModel model = pathes[key];
                    //TimeSpan span = DateTime.Now.Subtract(model.LastAccess);
                    if (model.InUse/* || span < keep*/) clean.Add(key, model);
                    else model.Cleanup();
                }
                pathes = clean;
            }
        }

        /// <summary>
        /// Retrieve a PathModel from the cache or create a new one
        /// </summary>
        /// <param name="path"></param>
        /// <param name="context">Associated language context</param>
        /// <returns></returns>
        static public PathModel GetModel(string path, IASContext context)
        {
            if (context == null || context.Settings == null) 
                return null;

            string modelName = context.Settings.LanguageId + "|" + path.ToUpper();
            PathModel aPath;
            if (pathes.ContainsKey(modelName))
            {
                aPath = pathes[modelName] as PathModel;
                if (aPath.IsTemporaryPath)
                {
                    pathes[modelName] = aPath = new PathModel(path, context);
                }
                else aPath.Touch();
            }
            else pathes[modelName] = aPath = new PathModel(path, context);
            return aPath;
        }

        public volatile bool Updating;
        public bool WasExplored;
        public bool InUse;
        public bool IsTemporaryPath;
        public Dictionary<string, FileModel> Files;
        public DateTime LastAccess;
        public string Path;
        public IASContext Owner;
        public bool IsValid;
        public bool IsVirtual;
        private FileSystemWatcher watcher;
        private Timer updater;
        private string[] masks;
        private string basePath;
        private List<string> toExplore;
        private List<string> toRemove;

        public PathModel(string path, IASContext context)
        {
            Owner = context;
            Path = path.TrimEnd(new char[] { '\\', '/' });
            Files = new Dictionary<string, FileModel>();
            LastAccess = DateTime.Now;

            updater = new Timer();
            updater.Interval = 2000;
            updater.Tick += new EventHandler(updater_Tick);
            toExplore = new List<string>();
            toRemove = new List<string>();
            
            // generic models container
            if (context == null)
            {
                IsValid = true;
            }
            // watched path
            else if (Directory.Exists(Path) && Path.Length > 3)
            {
                IsValid = true;
                if (Owner != null)
                {
                    try
                    {
                        watcher = new FileSystemWatcher();
                        watcher.Path = System.IO.Path.GetDirectoryName(Path);
                        basePath = path;
                        masks = Owner.GetExplorerMask();
                        watcher.IncludeSubdirectories = true;
                        watcher.NotifyFilter = NotifyFilters.FileName | NotifyFilters.LastWrite | NotifyFilters.DirectoryName | NotifyFilters.Size;
                        watcher.Deleted += new FileSystemEventHandler(watcher_Deleted);
                        watcher.Changed += new FileSystemEventHandler(watcher_Changed);
                        watcher.Renamed += new RenamedEventHandler(watcher_Renamed);
                        watcher.EnableRaisingEvents = true;
                        watcher.InternalBufferSize = 4096 * 8;
                    }
                    catch
                    {
                        watcher = null;
                        IsValid = false;
                    }
                }
            }
            else if (File.Exists(Path) && Owner != null)
            {
                IsValid = true;
                IsVirtual = true;
                try
                {
                    watcher = new FileSystemWatcher();
                    basePath = watcher.Path = System.IO.Path.GetDirectoryName(Path);
                    masks = new string[] { System.IO.Path.GetFileName(path) };
                    watcher.IncludeSubdirectories = false;
                    watcher.NotifyFilter = NotifyFilters.FileName | NotifyFilters.LastWrite | NotifyFilters.DirectoryName | NotifyFilters.Size;
                    watcher.Deleted += new FileSystemEventHandler(watcher_Deleted);
                    watcher.Changed += new FileSystemEventHandler(watcher_Changed);
                    watcher.Renamed += new RenamedEventHandler(watcher_Renamed);
                    watcher.EnableRaisingEvents = true;
                }
                catch
                {
                    watcher = null;
                    IsValid = false;
                }
            }
        }

        /// <summary>
        /// Enable the timer to update the outdated models
        /// </summary>
        void SetTimer()
        {
            if (ASContext.Panel == null) return;
            if (ASContext.Panel.InvokeRequired) ASContext.Panel.BeginInvoke(new MethodInvoker(SetTimer));
            else
            {
                updater.Stop();
                updater.Start();
            }
        }
        void updater_Tick(object sender, EventArgs e)
        {
            if (Updating) return;
            updater.Stop();

            if (IsVirtual)
            {
                lock (Files.Values)
                {
                    Files.Clear();
                    Owner.ExploreVirtualPath(this);
                }
            }
            else
            {
                DoScheduledOperations();

                lock (Files.Values)
                {
                    foreach (FileModel file in Files.Values)
                        if (file != null) file.Check();
                }
            }
            if (Owner != null) Owner.RefreshContextCache(Path);
        }

        #region Watcher events
        private bool maskMatch(string fileName)
        {
            foreach (string mask in masks)
            {
                if (mask[0] == '*')
                {
                    if (fileName.EndsWith(mask.Substring(1))) return true;
                }
                else if (fileName.EndsWith(mask)) return true;
            }
            return false;
        }

        private void watcher_Renamed(object sender, RenamedEventArgs e)
        {
            // possibly renamed the watched folder
            if (!e.FullPath.StartsWith(basePath) && e.FullPath != Path)
                return;
            // folder renamed: flag directory to be removed from models
            if (!maskMatch(e.FullPath))
            {
                if (Directory.Exists(e.FullPath))
                {
                    lock (toRemove)
                    {
                        string path = e.OldFullPath;
                        // add to known removed paths
                        List<string> newSchedule = new List<string>();
                        foreach (string scheduled in toRemove)
                            if (path.StartsWith(scheduled)) return;
                            else if (!scheduled.StartsWith(path)) newSchedule.Add(scheduled);
                        newSchedule.Add(path);
                        toRemove = newSchedule;
                    }
                }
                // explore will be added in parent directory's watcher_Changed event
                return;
            }
            // file renamed: remove old and schedule for parsing
            if (IsVirtual)
            {
                SetTimer();
            }
            else
            {
                if (Files.ContainsKey(e.OldFullPath.ToUpper()))
                {
                    RemoveFile(e.OldFullPath);
                }
                ParseNewFile(e.FullPath);
            }
        }

        private void watcher_Changed(object sender, FileSystemEventArgs e)
        {
            if (!e.FullPath.StartsWith(basePath) && e.FullPath != Path)
                return;
            // directory change: schedule for exploration
            if (!maskMatch(e.FullPath))
            {
                lock (toExplore)
                {
                    string path = e.FullPath;
                    // add path for exploration if not already scheduled
                    List<string> newSchedule = new List<string>();
                    foreach (string scheduled in toExplore)
                        if (path.StartsWith(scheduled)) return;
                        else if (!scheduled.StartsWith(path)) newSchedule.Add(scheduled);
                    newSchedule.Add(path);
                    toExplore = newSchedule;
                }
                SetTimer();
                return;
            }
            // file change: schedule for update
            if (IsVirtual)
            {
                SetTimer();
            }
            else if (Files.ContainsKey(e.FullPath.ToUpper()))
            {
                Files[e.FullPath.ToUpper()].OutOfDate = true;
                SetTimer();
            }
            else ParseNewFile(e.FullPath);
        }

        private void watcher_Deleted(object sender, FileSystemEventArgs e)
        {
            if (!e.FullPath.StartsWith(basePath) && e.FullPath != Path)
                return;
            // (possibly) folder deleted
            if (!maskMatch(e.FullPath))
            {
                lock (toRemove)
                {
                    string path = e.FullPath;
                    // add to known removed paths
                    List<string> newSchedule = new List<string>();
                    foreach (string scheduled in toRemove)
                        if (path.StartsWith(scheduled)) return;
                        else if (!scheduled.StartsWith(path)) newSchedule.Add(scheduled);
                    newSchedule.Add(path);
                    toRemove = newSchedule;
                }
                return;
            }
            // file deleted
            if (IsVirtual)
            {
                SetTimer();
            }
            else if (Files.ContainsKey(e.FullPath.ToUpper()))
            {
                RemoveFile(e.FullPath);
                SetTimer();
            }
        }

        private void ParseNewFile(string fileName)
        {
            if (Owner != null && !Owner.Settings.LazyClasspathExploration && File.Exists(fileName))
            {
                FileModel newModel = new FileModel(fileName);
                newModel.Context = Owner;
                newModel.OutOfDate = true;
                Files[fileName.ToUpper()] = newModel;
                SetTimer();
            }
        }

        private void DoScheduledOperations()
        {
            // copy scheduled paths
            string[] _toCheck;
            string[] _toExplore;
            lock (toExplore)
            {
                if (toExplore.Count == 0) return;
                _toCheck = new string[toExplore.Count];
                _toExplore = new string[toExplore.Count];
                for (int i = 0; i < _toExplore.Length; i++)
                {
                    _toCheck[i] = toExplore[i].ToUpper() + System.IO.Path.DirectorySeparatorChar;
                    _toExplore[i] = toExplore[i];
                }
                toExplore.Clear();
            }
            List<string> _toRemove;
            lock (toRemove)
            {
                _toRemove = new List<string>(toRemove.Count);
                for (int i = 0; i < _toRemove.Count; i++)
                    _toRemove[i] = toRemove[i].ToUpper() + System.IO.Path.DirectorySeparatorChar;
                toRemove.Clear();
            }

            Dictionary<string, FileModel> newFiles = new Dictionary<string, FileModel>();
            lock (Files.Keys)
            {
                // cleanup files
                foreach (string file in Files.Keys)
                {
                    bool drop = false;
                    foreach (string remPath in _toRemove)
                        if (file.StartsWith(remPath))
                        {
                            //TraceManager.Add("drop: " + Files[file].FileName);
                            drop = true;
                            break;
                        }
                    if (drop) continue;

                    FileModel model = Files[file];
                    foreach (string checkPath in _toCheck)
                    {
                        if (!File.Exists(model.FileName))
                        {
                            if (!Directory.Exists(System.IO.Path.GetDirectoryName(model.FileName)))
                            {
                                string newRemPath = System.IO.Path.GetDirectoryName(model.FileName).ToUpper() + System.IO.Path.DirectorySeparatorChar;
                                _toRemove.Add(newRemPath);
                            }
                            //TraceManager.Add("drop2: " + Files[file].FileName);
                            drop = true;
                            break;
                        }
                    }
                    if (drop) continue;
                    newFiles[file] = model;
                }
                Files = newFiles;
            }
            lock(Files) // re-lock the new Files dictionnary
            {
                // add new files
                foreach (string path in _toExplore)
                {
                    AddNewFilesIn(path);
                }
            }
        }

        private void AddNewFilesIn(string path)
        {
            if (Directory.Exists(path) && (File.GetAttributes(path) & FileAttributes.Hidden) == 0)
            {
                List<string> explored = new List<string>();
                List<string> foundFiles = new List<string>();
                ExploreFolder(path, masks, explored, foundFiles);
                foreach (string fileName in foundFiles)
                    if (!Files.ContainsKey(fileName.ToUpper()))
                    {
                        //TraceManager.Add("add: " + fileName);
                        FileModel newModel = new FileModel(fileName);
                        newModel.Context = Owner;
                        newModel.OutOfDate = true;
                        Files[fileName.ToUpper()] = newModel;
                    }
            }
        }

        private void ExploreFolder(string path, string[] masks, List<string> explored, List<string> foundFiles)
        {
            if (!Directory.Exists(path)) return;
            explored.Add(path);

            // convert classes
            try
            {
                foreach (string mask in masks)
                {
                    string[] files = Directory.GetFiles(path, mask);
                    if (files != null)
                        foreach (string file in files) foundFiles.Add(file);
                }
            }
            catch { }

            // explore subfolders
            string[] dirs = Directory.GetDirectories(path);
            foreach (string dir in dirs)
            {
                if (!explored.Contains(dir) && (File.GetAttributes(dir) & FileAttributes.Hidden) == 0)
                    ExploreFolder(dir, masks, explored, foundFiles);
            }
        }
        #endregion

        public void ReleaseWatcher()
        {
            if (watcher != null)
            {
                watcher.EnableRaisingEvents = false;
                watcher.Dispose();
                watcher = null;
                //TraceManager.Add("Release: " + Path);
            }
        }

        public bool HasFile(string fileName)
        {
            if (!IsValid) return false;
            return Files.ContainsKey(fileName.ToUpper());
        }

        public FileModel GetFile(string fileName)
        {
            if (!IsValid)
            {
                FileModel model = new FileModel(fileName);
                model.Context = Owner;
                model.OutOfDate = true;
                return model;
            }
            Touch();
            return Files[fileName.ToUpper()];
        }

        public void AddFile(FileModel aFile)
        {
            if (!IsValid) return;
            Touch();
            Files[aFile.FileName.ToUpper()] = aFile;
        }

        public void RemoveFile(string fileName)
        {
            if (!IsValid) return;
            Touch();
            Files.Remove(fileName.ToUpper());
        }

        public void Touch()
        {
            LastAccess = DateTime.Now;
        }

        public void Cleanup()
        {
            Files.Clear();
            ReleaseWatcher();
        }
    }
}
