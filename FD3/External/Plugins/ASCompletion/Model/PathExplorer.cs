using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using PluginCore;
using ASCompletion.Context;
using System.Windows.Forms;
using System.Diagnostics;
using PluginCore.Localization;
using System.Runtime.Serialization.Formatters.Binary;
using PluginCore.Utilities;
using PluginCore.Helpers;
using System.Text;

namespace ASCompletion.Model
{
	/// <summary>
	/// Deep classpath exploration & parsing
	/// </summary>
	public class PathExplorer
	{
        public delegate void ExplorationProgressHandler(string state, int value, int max);
		public delegate void ExplorationDoneHandler(string path);

        static public bool IsWorking
        {
            get { return explorerThread != null; }
        }

        static private Stack<PathExplorer> waiting = new Stack<PathExplorer>();
        static private volatile Thread explorerThread;
        static private volatile bool stopExploration;
        static private volatile int toWait = 1000; // initial delay before exploring the filesystem

        static public void StopBackgroundExploration()
        {
            // signal to stop cleanly
            stopExploration = true;

            if (explorerThread != null && explorerThread.IsAlive)
            {
                Debug.WriteLine("Signaling to stop exploration.");

                if (!explorerThread.Join(4000))
                {
                    Debug.WriteLine("Aborting exploration.");
                    explorerThread.Abort();
                }

                explorerThread = null;
                Debug.WriteLine("Explorer exited cleanly.");
            }
            lock (waiting) { waiting.Clear(); }
        }

        public event ExplorationProgressHandler OnExplorationProgress;
		public event ExplorationDoneHandler OnExplorationDone;
        public bool UseCache;

        private IASContext context;
        private PathModel pathModel;
		private List<string> foundFiles;
        private List<string> explored;

        public PathExplorer(IASContext context, PathModel pathModel)
        {
            this.context = context;
            this.pathModel = pathModel;
            pathModel.WasExplored = true;
            foundFiles = new List<string>();
            explored = new List<string>();
            if (context.Settings.LanguageId == "AS2")
            {
                explored.Add(Path.Combine(pathModel.Path, "aso"));
                explored.Add(Path.Combine(pathModel.Path, "FP7"));
                explored.Add(Path.Combine(pathModel.Path, "FP8"));
                explored.Add(Path.Combine(pathModel.Path, "FP9"));
            }
        }

        public void HideDirectories(string[] dirs)
        {
            foreach(string dir in dirs)
                explored.Add(Path.Combine(pathModel.Path, dir));
        }

		public void Run()
		{
            lock (waiting)
            {
                waiting.Push(this);

                if (explorerThread == null)
                {
                    // status
                    NotifyProgress(TextHelper.GetString("Info.Exploring"), 0, 1);

                    explorerThread = new Thread(ExploreInBackground);
                    explorerThread.Name = "ExplorerThread";
                    explorerThread.Priority = ThreadPriority.Lowest;
                    explorerThread.Start();
                }
            }
		}

        private static void ExploreInBackground()
        {
            Thread.Sleep(toWait);
            toWait = 10;

            while (!stopExploration)
            {
                PathExplorer next = null;
                
                lock (waiting)
                {
                    if (waiting.Count > 0) next = waiting.Pop();
                    else explorerThread = null;
                }

                if (next != null)
                    next.BackgroundRun();
                else
                    break;
            }
        }

        /// <summary>
        /// Background search
        /// </summary>
        private void BackgroundRun()
		{
            pathModel.Updating = true;
            try
            {
                if (pathModel.IsVirtual)
                {
                    // let the context explore packaged libraries
                    if (pathModel.Owner != null)
                        try
                        {
                            NotifyProgress(String.Format(TextHelper.GetString("Info.Parsing"), 1), 0, 1);
                            pathModel.Owner.ExploreVirtualPath(pathModel);
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show(ex.Message, TextHelper.GetString("Info.SWCConversionException"));
                        }
                }
                else
                {
                    bool writeCache = false;
                    string cacheFileName = null;
                    if (UseCache)
                    {
                        cacheFileName = GetCacheFileName(pathModel.Path);
                        if (File.Exists(cacheFileName))
                        {
                            NotifyProgress(TextHelper.GetString("Info.ParsingCache"), 0, 1);
                            ASFileParser.ParseCacheFile(pathModel, cacheFileName, context);
                        }
                        if (stopExploration) return;
                    }
                    else writeCache = true;

                    // explore filesystem (populates foundFiles)
                    ExploreFolder(pathModel.Path, "*" + context.Settings.DefaultExtension);
                    if (stopExploration) return;

                    // parse files
                    int n = foundFiles.Count;
                    NotifyProgress(String.Format(TextHelper.GetString("Info.Parsing"), n), 0, n);
                    FileModel aFile = null;
                    string basePath = "";
                    string packagePath = "";
                    int cpt = 0;
                    string filename;
                    for (int i = 0; i < n; i++)
                    {
                        if (stopExploration) return;
                        // parse
                        filename = foundFiles[i] as string;
                        if (!File.Exists(filename))
                            continue;
                        if (pathModel.HasFile(filename))
                        {
                            FileModel cachedModel = pathModel.GetFile(filename);
                            if (cachedModel.OutOfDate)
                            {
                                cachedModel.Check();
                                writeCache = true;
                            }
                            continue;
                        }
                        else writeCache = true;

                        aFile = GetFileModel(filename); //ASContext.Panel.Invoke(new GetFileModelHandler(GetFileModel), new object[] { filename }) as FileModel;

                        if (aFile == null || pathModel.HasFile(filename)) continue;
                        // store model
                        basePath = Path.GetDirectoryName(filename);
                        if (aFile.Package != "")
                        {
                            packagePath = '\\' + aFile.Package.Replace('.', '\\');
                            if (basePath.EndsWith(packagePath))
                                basePath = basePath.Substring(0, basePath.Length - packagePath.Length);
                        }
                        basePath += "\\";
                        lock (pathModel.Files) { pathModel.Files[aFile.FileName.ToUpper()] = aFile; }
                        aFile = null;
                        cpt++;
                        // update status
                        if (stopExploration) return;
                        if (i % 10 == 0) NotifyProgress(String.Format(TextHelper.GetString("Info.Parsing"), n), i, n);
                        Thread.Sleep(1);
                    }

                    // write cache file
                    if (UseCache && writeCache)
                    try
                    {
                        string cacheDir = Path.GetDirectoryName(cacheFileName);
                        if (!Directory.Exists(cacheDir)) Directory.CreateDirectory(cacheDir);
                        else if (File.Exists(cacheFileName)) File.Delete(cacheFileName);

                        if (pathModel.Files.Values.Count > 0)
                        using (StreamWriter sw = new StreamWriter(File.OpenWrite(cacheFileName)))
                        {
                            StringBuilder sb = new StringBuilder();
                            foreach (FileModel model in pathModel.Files.Values)
                            {
                                sb.Append("\n#file-cache ").Append(model.FileName).Append('\n');
                                sb.Append(model.GenerateIntrinsic(true));
                            }
                            sw.Write(sb);
                        }
                    }
                    catch { }
                }
            }
            finally { pathModel.Updating = false; }

            if (!stopExploration && OnExplorationDone != null)
            {
                NotifyProgress(null, 0, 0);
                NotifyDone(pathModel.Path);
            }
		}

        private string GetCacheFileName(string path)
        {
            string pluginDir = Path.Combine(PathHelper.DataDir, "ASCompletion");
            string cacheDir = Path.Combine(pluginDir, "FileCache");
            string hashFileName = HashCalculator.CalculateSHA1(path);
            return Path.Combine(cacheDir, hashFileName + "." + context.Settings.LanguageId.ToLower());
        }

        private void NotifyProgress(string state, int value, int max)
        {
            ExplorationProgressHandler handler = OnExplorationProgress;
            if (handler != null)
                handler(state, value, max);
        }

        private void NotifyDone(string path)
        {
            ExplorationDoneHandler handler = OnExplorationDone;
            if (handler != null)
                handler(path);
        }

        private FileModel GetFileModel(string filename)
        {
            // Going to try just doing this operation on our background thread - if there
            // are any strange exceptions, this should be synchronized
            IASContext ctx = context;
            return (ctx != null) ? ctx.GetFileModel(filename) : null;
        }

		private void ExploreFolder(string path, string mask)
		{
            if (stopExploration || !Directory.Exists(path)) return;
			explored.Add(path);
            Thread.Sleep(1);

            // The following try/catch is used to handle "There are no more files" IOException.
            // For some undocumented reason, on a networks share, and when using a mask, 
            //  Directory.GetFiles() can throw an IOException instead of returning an empty array.
            string[] files = null;
            try
            {
                files = Directory.GetFiles(path, mask);
            }
            catch {} 
            if (files != null) 
                foreach (string file in files) foundFiles.Add(file);

            // explore subfolders
            string[] dirs = Directory.GetDirectories(path);
            foreach (string dir in dirs)
            {
                if (!explored.Contains(dir) && (File.GetAttributes(dir) & FileAttributes.Hidden) == 0
                    && !Path.GetFileName(dir).StartsWith("."))
                    ExploreFolder(dir, mask);
            }
		}
	}
}
