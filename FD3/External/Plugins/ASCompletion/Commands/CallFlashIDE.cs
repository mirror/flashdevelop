using System;
using System.Text;
using System.Windows.Forms;
using PluginCore;
using PluginCore.Managers;
using ASCompletion;
using PluginCore.Localization;
using System.IO;
using ASCompletion.Context;
using PluginCore.Helpers;

namespace ASCompletion.Commands
{
    public class CallFlashIDE
    {
        private delegate void RunBackgroundInvoker(string exe, string args);

        static readonly private string[] MACROMEDIA_FLASHIDE_PATH = {
            @"C:\Program Files\Adobe\Adobe Flash CS5\Flash.exe",
            @"C:\Program Files\Adobe\Adobe Flash CS4\Flash.exe",
            @"C:\Program Files\Adobe\Adobe Flash CS3\Flash.exe",
            @"C:\Program Files\Macromedia\Flash 8\Flash.exe",
            @"C:\Program Files\Macromedia\Flash MX 2004\Flash.exe"
        };
        static private DateTime lastRun;

        /// <summary>
        /// Return the directory of the most recent Flash.exe 
        /// </summary>
        /// <returns></returns>
        static public string FindFlashIDE()
        {
            string found = null;
            foreach (string flashexe in MACROMEDIA_FLASHIDE_PATH)
            {
                if (System.IO.File.Exists(flashexe))
                {
                    found = flashexe;
                    break;
                }
            }
            return Path.GetDirectoryName(found);
        }

        /// <summary>
        /// Run the Flash IDE with the additional parameters provided
        /// </summary>
        /// <param name="parameters"></param>
        /// <returns>Operation successful</returns>
        static public bool Run(string pathToIDE, string cmdData)
        {
            if (pathToIDE != null && !pathToIDE.EndsWith(".exe", StringComparison.OrdinalIgnoreCase))
                pathToIDE = Path.Combine(pathToIDE, "Flash.exe");
            if (pathToIDE == null || !System.IO.File.Exists(pathToIDE))
            {
                string msg = TextHelper.GetString("Info.ConfigureFlashPath");
                string title = TextHelper.GetString("Info.ConfigurationRequired");
                DialogResult result = MessageBox.Show(msg, title, MessageBoxButtons.OKCancel);
                if (result == DialogResult.OK)
                {
                    PluginBase.MainForm.ShowSettingsDialog("ASCompletion");
                }
                return false;
            }
            
            TimeSpan diff = DateTime.Now.Subtract(lastRun);
            if (diff.Seconds < 1) return false;
            lastRun = DateTime.Now;

            string args = null;
            if (cmdData != null)
            {
                args = PluginBase.MainForm.ProcessArgString(cmdData);
                if (args.IndexOf('"') < 0) args = '"' + args + '"';
            }

            // execution
            ASContext.SetStatusText(TextHelper.GetString("Info.CallingFlashIDE"));
            PluginBase.MainForm.CallCommand("SaveAllModified", null);
            EventManager.DispatchEvent(null, new NotifyEvent(EventType.ProcessStart));
            if (args != null) ProcessHelper.StartAsync(pathToIDE, args);
            else ProcessHelper.StartAsync(pathToIDE);
            return true;
        }
    }
}
