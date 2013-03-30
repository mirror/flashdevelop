using System;
using System.Collections.Generic;
using System.Text;
using ProjectManager.Projects.Haxe;
using PluginCore;
using System.Diagnostics;
using System.IO;
using PluginCore.Managers;
using PluginCore.Bridge;
using ProjectManager.Projects;
using PluginCore.Helpers;
using System.Text.RegularExpressions;

namespace HaXeContext
{
    public class NMEHelper
    {
        static string nmmlPath;
        static WatcherEx watcher;
        static HaxeProject hxproj;
        static System.Timers.Timer updater;

        /// <summary>
        /// Run NME project (after build)
        /// </summary>
        /// <param name="command">Project's custom run command</param>
        /// <returns>Execution handled</returns>
        static public bool Run(string command)
        {
            if (!string.IsNullOrEmpty(command)) // project has custom run command
                return false;

            HaxeProject project = PluginBase.CurrentProject as HaxeProject;
            if (project == null || project.OutputType != OutputType.Application)
                return false;

            string config = project.TargetBuild;
            if (String.IsNullOrEmpty(config)) config = "flash";
            else if (config.IndexOf("android") >= 0) CheckADB();

            if (project.TraceEnabled)
            {
                config += " -debug -Dfdb";
            }
            if (config.StartsWith("flash") && config.IndexOf("-DSWF_PLAYER") < 0)
                config += GetSwfPlayer();

            string args = "run nme run \"" + project.OutputPathAbsolute + "\" " + config;
            string haxelib = GetHaxelib(project);

            if (config.StartsWith("flash") || config.StartsWith("html5")) // no capture
            {
                var infos = new ProcessStartInfo(haxelib, args);
                infos.WorkingDirectory = project.Directory;
                infos.WindowStyle = ProcessWindowStyle.Hidden;
                Process.Start(infos);
            }
            else
            {
                string oldWD = PluginBase.MainForm.WorkingDirectory;
                PluginBase.MainForm.WorkingDirectory = project.Directory;
                PluginBase.MainForm.CallCommand("RunProcessCaptured", haxelib + ";" + args);
                PluginBase.MainForm.WorkingDirectory = oldWD;
            }
            return true;
        }

        /// <summary>
        /// Start Android ADB server in the background
        /// </summary>
        static private void CheckADB()
        {
            if (Process.GetProcessesByName("adb").Length > 0)
                return;

            string adb = Environment.ExpandEnvironmentVariables("%ANDROID_SDK%/platform-tools");
            if (adb.StartsWith("%") || !Directory.Exists(adb))
                adb = Path.Combine(PathHelper.ToolDir, "android/platform-tools");
            if (Directory.Exists(adb))
            {
                adb = Path.Combine(adb, "adb.exe");
                ProcessStartInfo p = new ProcessStartInfo(adb, "get-state");
                p.UseShellExecute = true;
                p.WindowStyle = ProcessWindowStyle.Hidden;
                Process.Start(p);
            }
        }

        /// <summary>
        /// Provide FD-configured Flash player
        /// </summary>
        static private string GetSwfPlayer()
        {
            DataEvent de = new DataEvent(EventType.Command, "FlashViewer.GetFlashPlayer", null);
            EventManager.DispatchEvent(null, de);
            if (de.Handled && !String.IsNullOrEmpty((string)de.Data)) return " -DSWF_PLAYER=\"" + de.Data + "\"";
            else return "";
        }

        static public void Clean(IProject project)
        {
            if (!(project is HaxeProject))
                return;
            HaxeProject hxproj = project as HaxeProject;
            if (hxproj.MovieOptions.Platform != HaxeMovieOptions.NME_PLATFORM)
                return;
            string nmmlProj = hxproj.OutputPathAbsolute;
            if (!File.Exists(nmmlProj))
                return;

            string haxelib = GetHaxelib(hxproj);
            string config = hxproj.TargetBuild;
            if (String.IsNullOrEmpty(config)) config = "flash";

            ProcessStartInfo pi = new ProcessStartInfo();
            pi.FileName = haxelib;
            pi.Arguments = " run nme clean \"" + hxproj.GetRelativePath(nmmlProj) + "\" " + config;
            pi.UseShellExecute = false;
            pi.CreateNoWindow = true;
            pi.WorkingDirectory = Path.GetDirectoryName(hxproj.ProjectPath);
            pi.WindowStyle = ProcessWindowStyle.Hidden;
            Process p = Process.Start(pi);
            p.WaitForExit(5000);
            p.Close();
        }

        /// <summary>
        /// Watch NME projects to update the configuration & HXML command using 'nme display'
        /// </summary>
        /// <param name="project"></param>
        static public void Monitor(IProject project)
        {
            if (updater == null)
            {
                updater = new System.Timers.Timer();
                updater.Interval = 200;
                updater.SynchronizingObject = PluginCore.PluginBase.MainForm as System.Windows.Forms.Form;
                updater.Elapsed += updater_Elapsed;
                updater.AutoReset = false;
            }

            hxproj = null;
            StopWatcher();
            if (project is HaxeProject)
            {
                hxproj = project as HaxeProject;
                hxproj.ProjectUpdating += new ProjectUpdatingHandler(hxproj_ProjectUpdating);
                hxproj_ProjectUpdating();
            }
        }

        internal static void StopWatcher()
        {
            if (watcher != null)
            {
                watcher.Dispose();
                watcher = null;
                nmmlPath = null;
            }
        }

        static void hxproj_ProjectUpdating()
        {
            if (hxproj.MovieOptions.Platform == HaxeMovieOptions.NME_PLATFORM)
            {
                string nmmlProj = hxproj.OutputPathAbsolute;
                if (nmmlPath != nmmlProj)
                {
                    nmmlPath = nmmlProj;
                    StopWatcher();
                    if (File.Exists(nmmlPath))
                    {
                        watcher = new WatcherEx(Path.GetDirectoryName(nmmlPath), Path.GetFileName(nmmlPath));
                        watcher.Changed += watcher_Changed;
                        watcher.EnableRaisingEvents = true;
                        UpdateProject();
                    }
                }
                else UpdateProject();
            }
            else StopWatcher();
        }

        static void updater_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            UpdateProject();
            hxproj.PropertiesChanged();
        }

        static void watcher_Changed(object sender, FileSystemEventArgs e)
        {
            updater.Enabled = false;
            updater.Enabled = true;
        }

        private static void UpdateProject()
        {
            string haxelib = GetHaxelib(hxproj);
            if (haxelib == "haxelib")
            {
                TraceManager.AddAsync("Haxelib not found", -3);
                return;
            }

            string config = hxproj.TargetBuild;
            if (String.IsNullOrEmpty(config)) config = "flash";

            ProcessStartInfo pi = new ProcessStartInfo();
            pi.FileName = haxelib;
            pi.Arguments = "run nme display \"" + hxproj.GetRelativePath(nmmlPath) + "\" " + config;
            pi.RedirectStandardError = true;
            pi.RedirectStandardOutput = true;
            pi.UseShellExecute = false;
            pi.CreateNoWindow = true;
            pi.WorkingDirectory = Path.GetDirectoryName(hxproj.ProjectPath);
            pi.WindowStyle = ProcessWindowStyle.Hidden;
            Process p = Process.Start(pi);
            p.WaitForExit(5000);

            string hxml = p.StandardOutput.ReadToEnd();
            string err = p.StandardError.ReadToEnd();
            p.Close();

            if (string.IsNullOrEmpty(hxml))
            {
                if (string.IsNullOrEmpty(err)) err = "Haxelib error: no response";
                TraceManager.AddAsync(err, -3);
                hxproj.RawHXML = null;
            }
            else hxproj.RawHXML = Regex.Split(hxml, "[\r\n]+");
        }

        private static string GetHaxelib(IProject project)
        {
            string haxelib = project.CurrentSDK;
            if (haxelib == null) return "haxelib";
            else if (Directory.Exists(haxelib)) haxelib = Path.Combine(haxelib, "haxelib.exe");
            else haxelib = haxelib.Replace("haxe.exe", "haxelib.exe");

            // fix environment for command line tools
            string currentSDK = Path.GetDirectoryName(haxelib);
            Environment.SetEnvironmentVariable("HAXEPATH", currentSDK);
            string path = Environment.ExpandEnvironmentVariables("%PATH%");
            path = path.Replace(currentSDK + ";", "");
            Environment.SetEnvironmentVariable("PATH", currentSDK + ";" + path);
            path = Environment.ExpandEnvironmentVariables("%PATH%");

            return haxelib;
        }
    }
}
