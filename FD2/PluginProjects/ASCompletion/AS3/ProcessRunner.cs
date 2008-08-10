using System;
using System.Text;
using System.Threading;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;

namespace ASCompletion.AS3
{
	public class ProcessRunner
    {
        /**
        * Properties of the class
        */ 
        public Process process;
        public Boolean isRunning;
        public Int32 tasksFinished;
        public StreamReader outputReader;
        public StreamReader errorReader;
        
        /**
        * Events of the class
        */ 
		public event LineOutputHandler Output;
		public event LineOutputHandler Error;
		public event ProcessEndedHandler ProcessEnded;

        /**
        * Runs the specified process
        */ 
		public void Run(String fileName, String arguments)
		{
			this.isRunning = true;
            this.process = new Process();
            this.process.StartInfo.UseShellExecute = false;
            this.process.StartInfo.RedirectStandardOutput = true;
            this.process.StartInfo.RedirectStandardError = true;
            this.process.StartInfo.RedirectStandardInput = true;
            this.process.StartInfo.CreateNoWindow = true;
            this.process.StartInfo.FileName = fileName;
            this.process.StartInfo.Arguments = arguments;
            this.process.StartInfo.WorkingDirectory = Environment.CurrentDirectory;
            this.process.Start();

            this.outputReader = process.StandardOutput;
            this.errorReader = process.StandardError;
			
			// We need to wait for all 3 of our threadpool operations to finish (processexit, readoutput, readerror)
            this.tasksFinished = 0;
			
			// Do our waiting on the threadpool
			ThreadStart waitForExitDel = new ThreadStart(process.WaitForExit);
			waitForExitDel.BeginInvoke(new AsyncCallback(TaskFinished), null);
			
			// Also read outputs on the threadpool
			ThreadStart readOutputDel = new ThreadStart(this.ReadOutput);
            ThreadStart readErrorDel = new ThreadStart(this.ReadError);

            readOutputDel.BeginInvoke(new AsyncCallback(this.TaskFinished), null);
            readErrorDel.BeginInvoke(new AsyncCallback(this.TaskFinished), null);
		}

        /**
        * Is process currently running?
        */ 
        public Boolean IsRunning
        {
            get { return this.isRunning; }
        }

        /**
        * Kills the running process
        */ 
		public void KillProcess()
		{
			try
			{
                this.process.Kill();
			}
			catch (Exception ex)
			{
                MessageBox.Show(ex.Message);
			}
		}

        /**
        * Reads the info output
        */ 
		private void ReadOutput()
		{
            /*char[] buffer = new char[1024];
            int index = 0;
            int c;
			while (true)
			{
                c = outputReader.Read();
                if (c < 0) break;
                if (c == 13 || index == 1024)
                {
                    if (Output != null) Output(this, new String(buffer,0,index));
                    index = 0;
                }
                else if (c == 13) index--;
                else buffer[index++] = (char)c;
                
                if (index > 3 && c == ')' && buffer[index - 5] == '(' && buffer[index - 4] == 'a' && buffer[index - 3] == 's' && buffer[index - 2] == 'h') 
                {
                	if (Output != null) {
                		Output(this, new String(buffer,0,index));
                		//Output(this, "Done");
                	}
                	index = 0;
                	continue;
                }
			}*/
            while (true)
			{
				String line = outputReader.ReadLine();
				if (line == null) break;
				if (Output != null) Output(this,line);
			}
		}

        /**
        * Reads the error output
        */ 
		private void ReadError()
		{
			while (true)
			{
				String line = errorReader.ReadLine();
				if (line == null) break;
				if (Error != null) Error(this, line);
			}
		}

        /**
        * Task finished IAsyncResult handler
        */
        private void TaskFinished(IAsyncResult result)
		{
			lock (this) 
            {
				if (++tasksFinished >= 3) 
                {
					this.isRunning = false;
                    if (ProcessEnded != null)
                    {
                        this.ProcessEnded(this, process.ExitCode);
                    }
				}
			}
		}
	}

    /**
    * Event delegates for the class
    */
    public delegate void LineOutputHandler(Object sender, String line);
    public delegate void ProcessEndedHandler(Object sender, Int32 exitCode);
    public delegate void ProcessOutputHandler(Object sender, String line);
}
