using System;
using System.IO;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using System.Diagnostics;
using Microsoft.Win32;
using System.Text;
using System.Runtime.InteropServices;

namespace FdbPlugin
{
    public class Util
    {
        public static string FindAssociatedExecutableFile(string fileName, string extra)
        {
            string extName = System.IO.Path.GetExtension(fileName);
            RegistryKey regKey = Registry.ClassesRoot.OpenSubKey(extName);
            if (regKey == null) throw new Exception("Not Find Associate .swf");
            string fileType = (string)regKey.GetValue("");
            regKey.Close();
            RegistryKey regKey2 = Registry.ClassesRoot.OpenSubKey(string.Format(@"{0}\shell\{1}\command", fileType, extra));
            if (regKey2 == null) throw new Exception("Not Find Associate .swf");
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
    }
}
