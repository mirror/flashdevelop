using System;
using System.Collections;
using System.Collections.Generic;
using PluginCore;
using System.Windows.Forms;

namespace PluginCore.Managers
{
	public class TraceManager
	{
        private const int MAX_QUEUE = 200;
        private const string OVERFLOW = "FlashDevelop: Trace overflow";
        private static List<TraceItem> traceLog;
        private static List<TraceItem> asyncQueue;
        private static System.Timers.Timer asyncTimer;
        private static bool synchronizing;

        static TraceManager()
        {
            traceLog = new List<TraceItem>();
            asyncQueue = new List<TraceItem>();
            asyncTimer = new System.Timers.Timer();
            asyncTimer.Interval = 100;
            asyncTimer.AutoReset = false;
            asyncTimer.Elapsed += new System.Timers.ElapsedEventHandler(asyncTimer_Elapsed);
        }

        /// <summary>
        /// Adds a new entry to the log
        /// </summary>
        public static void Add(String message)
        {
            Add(message, 0);
        }

        /// <summary>
		/// Adds a new entry to the log
		/// </summary>
		public static void Add(String message, Int32 state)
        {
            Add(new TraceItem(message, state));
        }

        /// <summary>
        /// Adds a new entry to the log
        /// </summary>
        public static void Add(TraceItem traceItem)
        {
            lock (asyncQueue)
            {
                int count = asyncQueue.Count;
                if (count < MAX_QUEUE)
                {
                    asyncQueue.Add(traceItem);
                    asyncTimer.Start();
                }
                else if (count == MAX_QUEUE)
                {
                    asyncQueue.Add(new TraceItem(OVERFLOW, 4));
                    asyncTimer.Stop();
                    asyncTimer.Start();
                }
            }
        }


        /// <summary>
        /// Adds a new entry to the log in an unsafe threading context
        /// </summary>
        public static void AddAsync(String message)
        {
            AddAsync(message, 0);
        }

        /// <summary>
        /// Adds a new entry to the log in an unsafe threading context
        /// </summary>
        public static void AddAsync(String message, Int32 state)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                lock (asyncQueue)
                {
                    int count = asyncQueue.Count;
                    if (count < MAX_QUEUE)
                    {
                        asyncQueue.Add(new TraceItem(message, state));
                        asyncTimer.Start();
                    }
                    else if (count == MAX_QUEUE)
                    {
                        asyncQueue.Add(new TraceItem(OVERFLOW, 4));
                        asyncTimer.Stop();
                        asyncTimer.Start();
                    }
                }
                return;
            }
            Add(new TraceItem(message, state));
        }

        static void asyncTimer_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            lock (asyncQueue)
            {
                if (PluginBase.MainForm.ClosingEntirely)
                    return;
                if (!synchronizing)
                {
                    synchronizing = true;
                    (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate { ProcessQueue(); });
                }
            }
        }

        private static void ProcessQueue()
        {
            lock (asyncQueue)
            {
                if (PluginBase.MainForm.ClosingEntirely)
                    return;
                traceLog.AddRange(asyncQueue);
                asyncQueue.Clear();
                synchronizing = false;
            }
            NotifyEvent ne = new NotifyEvent(EventType.Trace);
            EventManager.DispatchEvent(null, ne);
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
