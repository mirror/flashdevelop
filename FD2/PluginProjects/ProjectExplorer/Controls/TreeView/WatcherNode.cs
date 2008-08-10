using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.Diagnostics;
using System.Windows.Forms;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer.Controls.TreeView
{
	/// <summary>
	/// Represents a node that watches for changes to its children using a FileSystemWatcher.
	/// </summary>
	public class WatcherNode : GenericNode
	{
		FileSystemWatcher watcher;
		Timer updateTimer;
		bool updateNeeded;

		public WatcherNode(string directory) : base(directory)
		{
			isRefreshable = true;
			// safe-check
			try
			{
				if (Directory.Exists(directory))
				{
					watcher = new FileSystemWatcher(directory);
					watcher.Created += new FileSystemEventHandler(watcher_Created);
					watcher.Deleted += new FileSystemEventHandler(watcher_Deleted);
					watcher.Renamed += new RenamedEventHandler(watcher_Renamed);
					watcher.EnableRaisingEvents = true;
					
					// Use a timer for FileSystemWatcher updates so they don't do lots of redrawing
					updateTimer = new Timer();
					updateTimer.Interval = 500;
					updateTimer.Tick += new EventHandler(updateTimer_Tick);
					return;
				}
			}
			catch {}
			// invalid node
			ForeColorRequest = Color.Red;
			isInvalid = true;
		}
		
		public override void Dispose()
		{
			base.Dispose();

			if (updateTimer != null)
			{
				updateTimer.Stop();
				updateTimer.Dispose();
			}

			if (watcher != null)
			{
				watcher.EnableRaisingEvents = false;
				watcher.Dispose();
			}
		}

		public void UpdateLater()
		{
			updateNeeded = true;
			updateTimer.Enabled = true;
		}

		private void watcher_Created(object sender, FileSystemEventArgs e) { Changed(); }
		private void watcher_Deleted(object sender, FileSystemEventArgs e) { Changed(); }
		private void watcher_Renamed(object sender, RenamedEventArgs e) { Changed(); }

		private void Changed()
		{
			if (Tree.InvokeRequired)
				Tree.BeginInvoke(new MethodInvoker(Changed));
			else
			{
				updateNeeded = true;
				Update();
			}
		}

		private void Update()
		{
			// we're waiting for the next opportunity
			if (updateTimer.Enabled || !updateNeeded)
				return;

			try
			{
				Tree.BeginUpdate();
				Refresh(false);
				updateNeeded = false;
			}
			catch {}
			finally
			{
				Tree.EndUpdate();
				// prevent further calls to Update() until after 1 second
				updateTimer.Enabled = true;
			}
		}

		void updateTimer_Tick(object sender, EventArgs e)
		{
			updateTimer.Enabled = false;
			Update();
		}
	}
}
