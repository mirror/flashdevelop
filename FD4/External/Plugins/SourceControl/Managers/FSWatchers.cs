using System;
using System.Collections.Generic;
using System.Text;
using SourceControl.Sources;
using System.Windows.Forms;
using PluginCore;
using System.IO;
using SourceControl.Actions;
using ProjectManager.Projects;

namespace SourceControl.Managers
{
    class FSWatchers
    {
        Dictionary<FileSystemWatcher, IVCManager> watchers = new Dictionary<FileSystemWatcher, IVCManager>();
        List<IVCManager> dirtyVC = new List<IVCManager>();
        Timer updateTimer;
        string lastDirtyPath;
        bool disposing;

        public FSWatchers()
        {
            updateTimer = new Timer();
            updateTimer.Interval = 1000;
            updateTimer.Tick += updateTimer_Tick;
            updateTimer.Start();
        }

        internal void Dispose()
        {
            disposing = true;
            Clear();
        }

        void Clear()
        {
            try
            {
                if (updateTimer != null) updateTimer.Stop();

                lock (watchers)
                {
                    foreach (FileSystemWatcher watcher in watchers.Keys)
                    {
                        watcher.EnableRaisingEvents = false;
                        watcher.Dispose();
                    }
                    watchers.Clear();
                }
            }
            catch (Exception) { }
        }

        internal WatcherVCResult ResolveVC(string path, bool andStatus)
        {
            WatcherVCResult result = ResolveVC(path);
            if (result != null && andStatus)
                result.Status = result.Manager.GetOverlay(path, result.Watcher.Path);

            return result;
        }

        internal WatcherVCResult ResolveVC(string path)
        {
            foreach (FileSystemWatcher watcher in watchers.Keys)
                if (path.StartsWith(watcher.Path))
                    return new WatcherVCResult(watcher, watchers[watcher]);
            return null;
        }

        internal void SetProject(Project project)
        {
            Clear();
            if (project == null) return;

            CreateWatchers(project.Directory);

            if (project.Classpaths != null)
                foreach (string path in project.AbsoluteClasspaths)
                    CreateWatchers(path);

            if (ProjectManager.PluginMain.Settings.ShowGlobalClasspaths)
                foreach (string path in ProjectManager.PluginMain.Settings.GlobalClasspaths)
                    CreateWatchers(path);

            updateTimer.Interval = 1000;
            updateTimer.Start();
        }

        private void CreateWatchers(string path)
        {
            try
            {
                if (String.IsNullOrEmpty(path) || !Directory.Exists(path))
                    return;

                foreach (FileSystemWatcher watcher in watchers.Keys)
                    if (path.StartsWith(watcher.Path, StringComparison.OrdinalIgnoreCase))
                        return;

                ExploreDirectory(path);
            }
            catch (Exception)
            {
            }
        }

        private void ExploreDirectory(string path)
        {
            foreach (IVCManager manager in ProjectWatcher.VCManagers)
                if (manager.IsPathUnderVC(path))
                {
                    var watcher = new FileSystemWatcher(path);
                    watcher.IncludeSubdirectories = true;
                    watcher.NotifyFilter = NotifyFilters.FileName | NotifyFilters.LastWrite | NotifyFilters.DirectoryName | NotifyFilters.Size;
                    watcher.Changed += new FileSystemEventHandler(watcher_Changed);
                    watcher.Deleted += new FileSystemEventHandler(watcher_Changed);
                    watcher.EnableRaisingEvents = true;
                    watchers.Add(watcher, manager);

                    dirtyVC.Add(manager);
                    return;
                }

            string[] dirs = Directory.GetDirectories(path);
            foreach (string dir in dirs)
            {
                FileInfo info = new FileInfo(dir);
                if ((info.Attributes & FileAttributes.Hidden) == 0)
                    ExploreDirectory(dir);
            }
        }

        private void watcher_Changed(object sender, FileSystemEventArgs e)
        {
            if (lastDirtyPath != null && e.FullPath.StartsWith(lastDirtyPath))
                return;
            if (Path.GetFileName(e.FullPath).StartsWith("hg-checkexec"))
                return;
            lastDirtyPath = e.FullPath;
            
            FileSystemWatcher watcher = (FileSystemWatcher)sender;
            IVCManager manager = watchers[watcher];
            if (manager.SetPathDirty(e.FullPath, watcher.Path))
                Changed(manager);
        }

        public void Changed(IVCManager manager)
        {
            if (disposing || updateTimer == null) return;

            lock (dirtyVC)
            {
                if (!dirtyVC.Contains(manager))
                    dirtyVC.Add(manager);
            }

            (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate
            {
                updateTimer.Stop();
                updateTimer.Start();
            });
        }

        void updateTimer_Tick(object sender, EventArgs e)
        {
            updateTimer.Stop();
            updateTimer.Interval = 2000;
            lastDirtyPath = null;
            if (disposing)
                return;

            lock (dirtyVC)
            {
                foreach (FileSystemWatcher watcher in watchers.Keys)
                {
                    IVCManager manager = watchers[watcher];
                    if (dirtyVC.Contains(manager))
                        manager.GetStatus(watcher.Path);
                }
                dirtyVC.Clear();
            }
        }

        internal void ForceRefresh()
        {
            lock (dirtyVC)
            {
                foreach (FileSystemWatcher watcher in watchers.Keys)
                {
                    IVCManager manager = watchers[watcher];
                    if (!dirtyVC.Contains(manager))
                        dirtyVC.Add(manager);
                }
            }

            (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate
            {
                updateTimer.Stop();
                updateTimer.Interval = 1000;
                updateTimer.Start();
            });
        }
    }

    class WatcherVCResult
    {
        public FileSystemWatcher Watcher;
        public IVCManager Manager;
        public VCItemStatus Status;

        public WatcherVCResult(FileSystemWatcher watcher, IVCManager manager)
        {
            Watcher = watcher;
            Manager = manager;
        }
    }
}
