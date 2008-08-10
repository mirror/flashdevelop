using System;
using System.Collections;
using PluginCore;

namespace FlashDevelop.Utilities
{
	public class TraceLog
	{
		public static readonly int ProcessStart = -1;
		public static readonly int ProcessEnd = -2;
		public static readonly int ProcessError = -3;
		public static readonly int Info = 0;
		public static readonly int Debug = 1;
		public static readonly int Warning = 2;
		public static readonly int Error = 3;
		public static readonly int Fatal = 4;
		
		private static ArrayList log = new ArrayList();
		
		/**
		* Adds a new entry to the log
		*/
		public static void AddMessage(string message, int state)
		{
			log.Add(new TraceEntry(message, state));
			//
			NotifyEvent ne = new NotifyEvent(EventType.LogEntry);
			Global.Plugins.NotifyPlugins(null, ne);
		}
		
		/**
		* Adds a group of new entries to the log
		*/
		public static void AddMessage(ArrayList messages, int state)
		{
			int count = messages.Count;
			for (int i = 0; i<count; i++)
			{
				log.Add(new TraceEntry(messages[i].ToString(), state));
			}
			NotifyEvent ne = new NotifyEvent(EventType.LogEntry);
			Global.Plugins.NotifyPlugins(null, ne);
		}
		
		/**
		* Gets the log as an ArrayList
		*/
		public static ArrayList Log
		{
			get { return log; }
		}
		
	}
	
	public class TraceEntry : ITraceEntry
	{
		private int state = 0;
		private DateTime timestamp;
		private string message;
		
		public TraceEntry(string message, int state)
		{
			this.timestamp = DateTime.Now;
			this.message = message;
			this.state = state;
		}
		
		/**
		* Access to the state
		*/
		public int State
		{
			get { return this.state; }
		}
		
		/**
		* Access to the message
		*/
		public string Message 
		{
			get { return this.message; }
		}
		
		/**
		* Access to the Timestamp
		*/
		public DateTime Timestamp
		{
			get  { return this.timestamp; }
		}
		
	}
	
}
