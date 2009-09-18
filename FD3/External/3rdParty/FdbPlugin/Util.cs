using System;
using System.IO;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using System.Diagnostics;
using Microsoft.Win32;
using System.Text;
using System.Runtime.InteropServices;
using System.Xml.Serialization;

namespace FdbPlugin
{
    public class Util
    {
        public static string FindAssociatedExecutableFile(string fileName, string extra)
        {
            string extName = System.IO.Path.GetExtension(fileName);
            RegistryKey regKey = Registry.ClassesRoot.OpenSubKey(extName);
            if (regKey == null) throw new Exception("Could not find application associated with SWF files.");
            string fileType = (string)regKey.GetValue("");
            regKey.Close();
            RegistryKey regKey2 = Registry.ClassesRoot.OpenSubKey(string.Format(@"{0}\shell\{1}\command", fileType, extra));
            if (regKey2 == null) throw new Exception("Could not find application associated with SWF files.");
            string command = (string)regKey2.GetValue("");
            regKey2.Close();
            return command;
        }

        static Regex regAssociate = new Regex(@"(?<filefullpath>.*).*?(\s*%\s*\d)", RegexOptions.Compiled);
        public static string GetAssociateAppFileName(string cmd)
        {
            Match m;
            if ((m = regAssociate.Match(cmd)).Success)
            {
                string filefullpath = m.Groups["filefullpath"].Value;
                filefullpath = filefullpath.Replace('"', ' ');
                filefullpath = filefullpath.Trim();
                return Path.GetFileNameWithoutExtension(filefullpath);
            }
            return string.Empty;
        }

        public static string GetAssociateAppFullPath(string cmd)
        {
            Match m;
            if ((m = regAssociate.Match(cmd)).Success)
            {
                return m.Groups["filefullpath"].Value;
            }
            return string.Empty;
        }

        public static void RegAssociatedExecutable(string ext, string verb, string ExecutableFullPath)
        {
            string commandline = "\"" + ExecutableFullPath + "\" %1";
            string fileType = "ShockwaveFlash.ShockwaveFlash";
            RegistryKey regkey = Registry.ClassesRoot.CreateSubKey(ext);
            regkey.SetValue("", fileType);
            regkey.Close();
            RegistryKey shellkey = Registry.ClassesRoot.CreateSubKey(fileType);
            shellkey = shellkey.CreateSubKey("shell\\" + verb);
            shellkey = shellkey.CreateSubKey("command");
            shellkey.SetValue("", commandline);
            shellkey.Close();
        }

        public static void UnRegAssociatedExecutable(string ext)
        {
            string fileType = Application.ProductName;
            Registry.ClassesRoot.DeleteSubKeyTree(ext);
            Registry.ClassesRoot.DeleteSubKeyTree(fileType);
        }

        public static void CloseWindow(string ProcessName, bool CheckStop)
        {
            DialogResult res;
            Process[] allProcesses = Process.GetProcessesByName(ProcessName);
            foreach (Process oneProcess in allProcesses)
            {
                if (!CheckStop) res = DialogResult.OK;
                else res = MessageBox.Show(string.Format("Close {0} ?", ProcessName), "", MessageBoxButtons.OKCancel);
                if (res == DialogResult.OK)
                {
                    if (oneProcess.Responding) oneProcess.CloseMainWindow();
                    else oneProcess.Kill();
                }
            }
        }

        [DllImport("user32.dll")]
        public extern static bool SetForegroundWindow(IntPtr hWnd);

        [DllImport("user32.dll")]
        public extern static IntPtr FindWindow(string lpClassName, string lpWindowName);

        [DllImport("user32.dll")]
        public extern static int GetWindowText(IntPtr hWnd, StringBuilder lpStr, int nMaxCount);


        public delegate int EnumerateWindowsCallback(IntPtr hWnd, int lParam);

        [DllImport("user32", EntryPoint = "EnumWindows")]
        public static extern int EnumWindows(EnumerateWindowsCallback lpEnumFunc, int lParam);

        [DllImport("user32", EntryPoint = "IsWindowVisible")]
        public static extern int IsWindowVisible(IntPtr hWnd);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);

        public class SerializeXML<T>
        {
            public static void SaveFile(string filename, T obj)
            {
                XmlSerializer serializer1 = new XmlSerializer(typeof(T));
                FileStream fs1 = new FileStream(filename, FileMode.Create);
                serializer1.Serialize(fs1, obj);
                fs1.Close();
            }

            public static T LoadFile(string filename)
            {
                XmlSerializer serializer2 = new XmlSerializer(typeof(T));
                FileStream fs2 = new FileStream(filename, FileMode.Open);
                T loadClasses = (T)serializer2.Deserialize(fs2);
                fs2.Close();
                return loadClasses;
            }

            public static T LoadString(string s)
            {
                XmlSerializer serializer = new XmlSerializer(typeof(T));
                StringReader str = new StringReader(s);
                T loadClasses = (T)serializer.Deserialize(str);
                str.Close();
                return loadClasses;
            }
        }
    }

    public sealed class FdbPluginTrace
    {
        private static TraceSource trace = null;
        private static Boolean istracelog = false;

        public static Boolean IsTraceLog
        {
            get { return istracelog; }
            set { istracelog = value; }
        }

        public static void init(string LogFileFullPath)
        {
            if (trace == null)
            {
                trace = new TraceSource("FdbPluginTrace");
                trace.Switch.Level = System.Diagnostics.SourceLevels.All;
                trace.Listeners.Add(new TextWriterTraceListener(LogFileFullPath, "LogFile"));
            }
        }

        public static void init()
        {
            string path = Path.Combine(Path.GetDirectoryName(Application.ExecutablePath), "fdbPlugin.log");
            init(path);
        }

        public static void Trace(string msg)
        {
            if (istracelog)
            {
                trace.TraceEvent(TraceEventType.Verbose, 0, msg);
                trace.Flush();
            }
        }

        public static void TraceInfo(string msg)
        {
            if (istracelog)
            {
                trace.TraceInformation(msg);
                trace.Flush();
            }
        }
    }
}
