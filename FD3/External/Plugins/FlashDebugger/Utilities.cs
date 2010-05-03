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
