using System;
using System.Collections;
using System.Diagnostics;
using System.Threading;

namespace ProjectExplorer.Helpers
{
	public class ProcessHelper
	{
		/// <summary>
		/// Starts a process asynchronously so the GUI thread isn't tied up waiting
		/// for the app to start (the app could be the Flash IDE for instance).
		/// </summary>
		public static void StartAsync(string path)
		{
			StartDelegate del = new StartDelegate(Start);
			del.BeginInvoke(path,null,null);
		}

		public static void Start(string path)
		{
			Process.Start(path);
		}

		private delegate void StartDelegate(string path);
	}
}
