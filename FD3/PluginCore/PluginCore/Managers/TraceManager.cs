using System;
using System.Collections;
using System.Collections.Generic;
using PluginCore;
using System.Windows.Forms;

namespace PluginCore.Managers
{
	public class TraceManager
	{
        private static List<TraceItem> traceLog;

        static TraceManager()
        {
            traceLog = new List<TraceItem>();
        }

        /// <summary>
        /// Adds a new entry to the log
        /// </summary>
        public static void Add(TraceItem traceItem)
        {
            if (PluginBase.MainForm.ClosingEntirely) return;
            traceLog.Add(traceItem); // Add to log...
            if ((PluginBase.MainForm as Form).InvokeRequired) return;
            NotifyEvent ne = new NotifyEvent(EventType.Trace);
            EventManager.DispatchEvent(null, ne);
        }

        /// <summary>
        /// Adds a new entry to the log
        /// </summary>
        public static void Add(String message)
        {
            Add(new TraceItem(message, 0));
        }

        /// <summary>
		/// Adds a new entry to the log
		/// </summary>
		public static void Add(String message, Int32 state)
		{
            Add(new TraceItem(message, state));
		}

        /// <summary>
        /// Adds a new entry to the log in an unsafe threading context
        /// </summary>
        public static void AddAsync(String message)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate { Add(message); });
                return;
            }
            Add(new TraceItem(message, 0));
        }

        /// <summary>
        /// Adds a new entry to the log in an unsafe threading context
        /// </summary>
        public static void AddAsync(String message, Int32 state)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate { Add(message, state); });
                return;
            }
            Add(new TraceItem(message, state));
        }
        
        /// <summary>
        /// Gets a read only list from trace log
        /// </summary>
        public static IList<TraceItem> TraceLog
        {
            get { return traceLog.AsReadOnly(); }
        }

	}

    public class TraceItem
    {
        private Int32 state = 0;
        private DateTime timestamp;
        private String message;

        public TraceItem(String message, Int32 state)
        {
            this.timestamp = DateTime.Now;
            this.message = message;
            this.state = state;
        }

        /// <summary>
        /// Gets the state (TraceType enum)
        /// </summary>
        public Int32 State
        {
            get { return this.state; }
        }

        /// <summary>
        /// Gets the logged trace message
        /// </summary>
        public String Message
        {
            get { return this.message; }
        }

        /// <summary>
        /// Gets the timestamp of the trace
        /// </summary>
        public DateTime Timestamp
        {
            get { return this.timestamp; }
        }

    }

}
