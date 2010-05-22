using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using PluginCore.Helpers;
using ASCompletion.Context;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using PluginCore.Managers;
using PluginCore;
using PluginCore.Localization;

namespace ASCompletion.Helpers
{
    public class FlashErrorsWatcher
    {
        private string logFile;
        private string docInfo;
        private string publishInfo;
        private FileSystemWatcher fsWatcher;
        private Timer updater;

        private Regex reError = new Regex(
            @"^\*\*Error\*\*\s(?<file>.*\.as)[^0-9]+(?<line>[0-9]+)[:\s]+(?<desc>.*)$",
            RegexOptions.Compiled | RegexOptions.Multiline);

        private Regex reFlashFile = new Regex(
            "<flashFileName>(?<output>[^<]+)</flashFileName>",
            RegexOptions.Compiled);

        public FlashErrorsWatcher()
        {
            try
            {
                string appData = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
                string logLocation = Path.Combine(appData, Path.Combine("Adobe", "FlashDevelop"));
                Directory.CreateDirectory(logLocation);
                logFile = Path.Combine(logLocation, "FlashErrors.log");
                docInfo = Path.Combine(logLocation, "FlashDocument.log");
                publishInfo = Path.Combine(logLocation, "FlashPublish.log");

                fsWatcher = new FileSystemWatcher(logLocation, "*.log");
                fsWatcher.EnableRaisingEvents = true;
                fsWatcher.Changed += new FileSystemEventHandler(fsWatcher_Changed);

                updater = new Timer();
                updater.Interval = 200;
                updater.Tick += new EventHandler(updater_Tick);
            }
            catch { }
        }

        void updater_Tick(object sender, EventArgs e)
        {
            updater.Stop();
            string src = File.ReadAllText(logFile);
            MatchCollection matches = reError.Matches(src);

            TextEvent te;
            if (matches.Count == 0)
            {
                te = new TextEvent(EventType.ProcessEnd, "Done(0)");
                EventManager.DispatchEvent(this, te);
                if (!te.Handled) PlaySWF();
                return;
            }

            NotifyEvent ne = new NotifyEvent(EventType.ProcessStart);
            EventManager.DispatchEvent(this, ne);
            foreach (Match m in matches)
            {
                string file = m.Groups["file"].Value;
                string line = m.Groups["line"].Value;
                string desc = m.Groups["desc"].Value.Trim();
                TraceManager.Add(String.Format("{0}:{1}: {2}", file, line, desc), -3);
            }
            te = new TextEvent(EventType.ProcessEnd, "Done(" + matches.Count + ")");
            EventManager.DispatchEvent(this, te);

            (PluginBase.MainForm as Form).Activate();
            (PluginBase.MainForm as Form).Focus();
        }

        private void PlaySWF()
        {
            if (File.Exists(docInfo) && File.Exists(publishInfo))
            {
                string fla = File.ReadAllText(docInfo);
                if (!File.Exists(fla)) 
                    return;

                string src = File.ReadAllText(publishInfo);
                Match m = reFlashFile.Match(src);
                if (m.Success)
                {
                    string output = m.Groups["output"].Value.Replace(Path.AltDirectorySeparatorChar, Path.DirectorySeparatorChar);
                    output = PathHelper.ResolvePath(output, Path.GetDirectoryName(fla));
                    if (File.Exists(output))
                    {
                        DataEvent de = new DataEvent(EventType.Command, "ProjectManager.PlayOutput", output);
                        EventManager.DispatchEvent(this, de);
                    }
                }
            }
        }

        private void fsWatcher_Changed(object sender, FileSystemEventArgs e)
        {
            if (!File.Exists(e.FullPath)) return;
            else if (e.FullPath.Equals(logFile, StringComparison.OrdinalIgnoreCase))
            {
                // remove Flahs publish information so we get it only on Test Movie
                try
                {
                    if (File.Exists(publishInfo)) File.Delete(publishInfo);
                    if (File.Exists(docInfo)) File.Delete(docInfo);
                }
                catch (Exception) { }
            }
            SetTimer();
        }

        private void SetTimer()
        {
            if (ASContext.Panel.InvokeRequired) ASContext.Panel.BeginInvoke(new MethodInvoker(SetTimer));
            else
            {
                updater.Stop();
                updater.Start();
            }
        }
    }
}
