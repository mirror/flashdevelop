/*
    Copyright (C) 2009  Robert Nelson

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/

using System;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using System.Xml.Serialization;
using Microsoft.Win32;

namespace FlexDbg
{
    public class Util
    {
#if false
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
#endif

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

    public sealed class FlexDbgTrace
    {
        private static TraceSource m_Trace = null;
        private static Boolean m_bTracelog = true;

        public static Boolean IsTraceLog
        {
			get
			{
				return m_bTracelog;
			}
			set
			{
				m_bTracelog = value;
			}
        }

        public static void init(string LogFileFullPath)
        {
			if (m_Trace == null)
            {
				m_Trace = new TraceSource("FlexDbgTrace");
				m_Trace.Switch.Level = System.Diagnostics.SourceLevels.All;
				m_Trace.Listeners.Add(new TextWriterTraceListener(LogFileFullPath, "LogFile"));
            }
        }

        public static void init()
        {
            string path = Path.Combine(Path.GetDirectoryName(Application.ExecutablePath), "FlexDbg.log");
            init(path);
        }

        public static void Trace(string msg)
        {
			if (m_bTracelog)
            {
				m_Trace.TraceEvent(TraceEventType.Verbose, 0, msg);
				m_Trace.Flush();
            }
        }

        public static void TraceInfo(string msg)
        {
			if (m_bTracelog)
            {
                m_Trace.TraceInformation(msg);
				m_Trace.Flush();
            }
        }
    }
}
