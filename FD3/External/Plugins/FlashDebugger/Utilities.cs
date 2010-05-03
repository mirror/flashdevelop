using System;
using System.IO;
using System.Text;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using System.Xml.Serialization;
using Microsoft.Win32;

namespace FlashDebugger
{
    public class Util
    {
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
			get { return m_bTracelog; }
			set { m_bTracelog = value; }
        }

        public static void init(string LogFileFullPath)
        {
			if (m_Trace == null)
            {
                m_Trace = new TraceSource("FlashDebuggerTrace");
				m_Trace.Switch.Level = System.Diagnostics.SourceLevels.All;
				m_Trace.Listeners.Add(new TextWriterTraceListener(LogFileFullPath, "LogFile"));
            }
        }

        public static void init()
        {
            string path = Path.Combine(Path.GetDirectoryName(Application.ExecutablePath), "FlashDebugger.log");
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
