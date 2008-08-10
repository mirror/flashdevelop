using System;
using System.IO;
using System.Collections;
using System.Diagnostics;

namespace ProjectExplorer.Helpers
{
	/// <summary>
	/// Watches a set of paths for any actionscript files that were created,
	/// modified, or deleted.
	/// </summary>
	public class ClasspathWatcher
	{
		bool changed;
		ArrayList watchers;

		public ClasspathWatcher(string[] paths)
		{
			changed = false;
			watchers = new ArrayList();

			foreach (string path in paths)
			{
				// ignore errors, this is a non-critical class
				try
				{
					FileSystemWatcher watcher = new FileSystemWatcher();
					watcher.Path = path;
					watcher.IncludeSubdirectories = true;
					watcher.Filter = "*.as";
					watcher.Created += new FileSystemEventHandler(watcher_Created);
					watcher.Changed += new FileSystemEventHandler(watcher_Changed);
					watcher.Deleted += new FileSystemEventHandler(watcher_Deleted);
					watcher.Renamed += new RenamedEventHandler(watcher_Renamed);
					watchers.Add(watcher);
				}
				catch {}
			}
		}

		public void Start()
		{
			foreach (FileSystemWatcher watcher in watchers)
				try { watcher.EnableRaisingEvents = true; }
				catch {}
		}

		public void Stop()
		{
			foreach (FileSystemWatcher watcher in watchers)
				try { watcher.EnableRaisingEvents = false; }
				catch {}
		}

		public bool Changed
		{
			get { return changed; }
		}

		private void DoChanged()
		{
			lock (this) changed = true;
		}

		private void watcher_Created(object sender, FileSystemEventArgs e) { DoChanged(); }
		private void watcher_Changed(object sender, FileSystemEventArgs e) { DoChanged(); }
		private void watcher_Deleted(object sender, FileSystemEventArgs e) { DoChanged(); }
		private void watcher_Renamed(object sender, RenamedEventArgs e) { DoChanged(); }
	}
}
