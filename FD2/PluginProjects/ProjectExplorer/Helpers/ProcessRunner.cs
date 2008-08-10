using System;
using System.Diagnostics;
using System.IO;
using System.Threading;
using PluginCore;

namespace FlashDevelop.Utilities
{
	public class ProcessRunner
	{
		Process process;
		bool isRunning;
		StreamReader outputReader;
		StreamReader errorReader;
		
		int tasksFinished;
		
		public event LineOutputHandler Output;
		public event LineOutputHandler Error;
		public event ProcessEndedHandler ProcessEnded;
		
		public bool IsRunning { get { return isRunning; } }
		
		public void Run(string fileName, string arguments)
		{
			if (isRunning) throw new Exception("This ProcessRunner is already running a process.");
			if (!File.Exists(fileName)) throw new FileNotFoundException("The program '"+fileName+"' was not found.",fileName);

			isRunning = true;
			process = new Process();
			process.StartInfo.UseShellExecute = false;
			process.StartInfo.RedirectStandardOutput = true;
			process.StartInfo.RedirectStandardError = true;
			process.StartInfo.CreateNoWindow = true;
			process.StartInfo.FileName = fileName;
			process.StartInfo.Arguments = arguments;
			process.StartInfo.WorkingDirectory = Environment.CurrentDirectory;
			process.Start();
			
			outputReader = process.StandardOutput;
			errorReader = process.StandardError;
			
			// we need to wait for all 3 of our threadpool operations to finish
			// (processexit, readoutput, readerror)
			tasksFinished = 0;
			
			// do our waiting on the threadpool
			ThreadStart waitForExitDel = new ThreadStart(process.WaitForExit);
			waitForExitDel.BeginInvoke(new AsyncCallback(TaskFinished),null);
			
			// also read outputs on the threadpool
			ThreadStart readOutputDel = new ThreadStart(ReadOutput);
			ThreadStart readErrorDel = new ThreadStart(ReadError);
			
			readOutputDel.BeginInvoke(new AsyncCallback(TaskFinished),null);
			readErrorDel.BeginInvoke(new AsyncCallback(TaskFinished),null);
		}
		
		public void KillProcess()
		{
			try
			{
				process.Kill();
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while stopping the process: "+ex.Message, ex);
			}
		}
		
		private void ReadOutput()
		{
			while (true)
			{
				string line = outputReader.ReadLine();
				if (line == null) break;
				if (Output != null) Output(this,line);
			}
		}
		
		private void ReadError()
		{
			while (true)
			{
				string line = errorReader.ReadLine();
				if (line == null) break;
				if (Error != null) Error(this,line);
			}
		}
		
		private void TaskFinished(IAsyncResult result)
		{
			lock (this) {
				if (++tasksFinished >= 3) {
					isRunning = false;
					if (ProcessEnded != null) ProcessEnded(this,process.ExitCode);
				}
			}
		}
	}
	
	public delegate void LineOutputHandler(object sender, string line);
	public delegate void ProcessEndedHandler(object sender, int exitCode);
	public delegate void ProcessOutputHandler(object sender, string line);
	
}
