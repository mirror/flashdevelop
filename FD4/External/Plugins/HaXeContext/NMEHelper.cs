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

namespace HaXeContext
{
    public class NMEHelper
    {
        static WatcherEx watcher;

        static public bool Run(string command)
        {
            if (!string.IsNullOrEmpty(command)) // project has custom run command
                return false;

            HaxeProject project = PluginBase.CurrentProject as HaxeProject;
            if (project == null || project.OutputType != OutputType.Application)
                return false;

            string compiler = project.CurrentSDK;
            if (compiler == null) compiler = "haxelib";
            else if (Directory.Exists(compiler)) compiler = Path.Combine(compiler, "haxelib.exe");
            else compiler = compiler.Replace("haxe.exe", "haxelib.exe");

            string config = project.MovieOptions.TargetBuild;
            if (String.IsNullOrEmpty(config)) config = "flash";
            else if (config.IndexOf("android") >= 0) CheckADB();

            if (project.TraceEnabled)
            {
                config += " -debug -Dfdb";
            }

            if (config.StartsWith("flash") && config.IndexOf("-DSWF_PLAYER") < 0)
                config += GetSwfPlayer();

            string args = "run nme run \"" + project.OutputPathAbsolute + "\" " + config;
            string oldWD = PluginBase.MainForm.WorkingDirectory;
            PluginBase.MainForm.WorkingDirectory = project.Directory;
            PluginBase.MainForm.CallCommand("RunProcessCaptured", compiler + ";" + args);
            PluginBase.MainForm.WorkingDirectory = oldWD;
            return true;
        }

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

        static private string GetSwfPlayer()
        {
            DataEvent de = new DataEvent(EventType.Command, "FlashViewer.GetFlashPlayer", null);
            EventManager.DispatchEvent(null, de);
            if (de.Handled && !String.IsNullOrEmpty((string)de.Data)) return " -DSWF_PLAYER=\"" + de.Data + "\"";
            else return "";
        }

        static public void Monitor(IProject project)
        {
            /*if (watcher != null) 
            {
                watcher.Dispose();
                watcher = null;
            }
            if (project is HaxeProject)
            {
                HaxeProject hxproj = project as HaxeProject;
            }*/
        }
    }
}
