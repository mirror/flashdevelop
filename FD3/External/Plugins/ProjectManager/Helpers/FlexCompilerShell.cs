using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Threading;
using System.Text.RegularExpressions;
using System.Runtime.InteropServices;

namespace ProjectManager.Helpers
{
    /// <summary>
    /// Runs FSCH and keeps it around in memory to interact with and work with incremental builds.
    /// </summary>
    public class FlexCompilerShell : MarshalByRefObject
    {
        public static string FcshPath;

        //C:\...\Main.as(17): col: 15 Warning: variable 'yc' has no type declaration.
        private static readonly Regex reWarning
            = new Regex("\\([0-9]+\\): col: [0-9]+ Warning:", RegexOptions.Compiled);

        // fcsh.exe process
        static Process process;
        static string workingDir;

        // error handling
        static Thread errorThread;
        static List<string> errorList;
		static List<string> warningList;
        static volatile bool foundErrors;

        // incremental compilation
        static string lastArguments;
        static int lastCompileID;

        string Initialize(string jvmarg, string projectPath)
        {
            errorList = new List<string>();
			warningList = new List<string>();

            if (jvmarg == null)
            {
                //  || !File.Exists(fcshPath)
                // removed! how can i guess file existence using jvm arguments?
                process = null;
                return "Failed, no compiler configured";
            }

            workingDir = projectPath;
            process = new Process();
            process.StartInfo.UseShellExecute = false;
            process.StartInfo.RedirectStandardInput = true;
            process.StartInfo.RedirectStandardOutput = true;
            process.StartInfo.RedirectStandardError = true;
            process.StartInfo.StandardOutputEncoding = Encoding.Default;
            process.StartInfo.StandardErrorEncoding = Encoding.Default;
            process.StartInfo.CreateNoWindow = true;
            process.StartInfo.FileName = "java.exe";
            process.StartInfo.Arguments = jvmarg;
            process.StartInfo.WorkingDirectory = workingDir;
            try
            {
                process.Start();
            }
            catch (Exception ex)
            {
                process = null;
                errorList.Add("Unable to start java.exe: " + ex.Message);
                return "Failed, unable to run compiler";
            }

            errorThread = new Thread(ReadErrors);
            errorThread.Start();
            
            return ReadUntilPrompt();
        }

        void process_Exited(object sender, EventArgs e)
        {
            throw new Exception("Process Exited");
        }

        public void Compile(string projectPath, bool configChanged, string arguments,
            out string output, out string[] errors, out string[] warnings, string jvmarg)
        {
            StringBuilder o = new StringBuilder();
            
            // shut down fcsh if our working path has changed
            if (projectPath != workingDir) Cleanup();
            
            // start up fcsh if necessary
			if (process == null || process.HasExited)
				o.AppendLine("INITIALIZING: " + Initialize(jvmarg, projectPath));
			else
			{
				errorList.Clear();
				warningList.Clear();
			}

            // success?
            if (process == null)
            {
                output = o.ToString();
                errorList.Add("Could not compile because the fcsh process could not be started.");
                errors = errorList.ToArray();
				warnings = warningList.ToArray();
                return;
            }

            if (arguments != lastArguments)
            {
                if (lastCompileID != 0)
                    ClearOldCompile();

                o.AppendLine("Starting new compile.");
                process.StandardInput.WriteLine("mxmlc " + arguments);

                // remember this for next time
                lastCompileID = ReadCompileID();
                lastArguments = arguments;
            }
            else
            {
                // incrementally build the last compiled ID
                o.AppendLine("Incremental compile of " + lastCompileID);
                process.StandardInput.WriteLine("compile " + lastCompileID);
            }

            o.Append(ReadUntilPrompt());
            
            // this is hacky.  allow some time for errors to accumulate in our separate thread.
            do { foundErrors = false; Thread.Sleep(100); }
            while (foundErrors);

            output = o.ToString();
            if (Regex.IsMatch(output, "fcsh: Target " + lastCompileID + " not found"))
            {
                // force a fresh compile
                lastCompileID = 0;
                lastArguments = null;
                Compile(projectPath, true, arguments, out output, out errors, out warnings, jvmarg);
                return;
            }
            
            lock (errorList)
				lock (warningList)
				{
					errors = errorList.ToArray();
					warnings = warningList.ToArray();
				}
        }

        void ClearOldCompile()
        {
            process.StandardInput.WriteLine("clear " + lastCompileID);
            ReadUntilPrompt();
            lastCompileID = 0;
            lastArguments = null;
        }

        // Run in a separate thread to read errors as they accumulate
        static void ReadErrors()
        {
            bool skipWarning = false;
            while (process != null && !process.StandardError.EndOfStream)
            {
                string line = process.StandardError.ReadLine().Trim();
                lock (errorList)
				lock (warningList)
                {
					if (line.Length > 0)
					{
                        if (skipWarning)
                        {
                            if (line == "^") skipWarning = false;
                        }
						else if (line.Contains("Warning:"))
						{
							warningList.Add(line);
                            if (reWarning.IsMatch(line)) skipWarning = true;
						}
						else
						{
							errorList.Add(line);
							foundErrors = true;
						}
					}
                }
            }
        }

        public static void Cleanup()
        {
            lastCompileID = 0;
            lastArguments = null;
            // this will free up our error-reading thread as well.
            try
            {
                if (process != null && !process.HasExited)
                    process.Kill();
            }
            catch { }
        }

        #region FCSH Output Parsing

        /// <summary>
        /// Read the compile id fsch returns
        /// </summary>
        /// <returns></returns>
        private int ReadCompileID()
        {
            string line = "";
            lock (typeof(FlexCompilerShell))
                line = process.StandardOutput.ReadLine();

            if (line == null)
                return 0;

            // loop through all lines, regex matching phrase
            Match m = Regex.Match(line, "Assigned ([0-9]+) as the compile target id");
            while (!m.Success)
            {
                lock (typeof(FlexCompilerShell))
                    line = process.StandardOutput.ReadLine();

                if (line == null) return 0;
                else m = Regex.Match(line, "Assigned ([0-9]+) as the compile target id");
            }

            if (m.Groups.Count == 2) return int.Parse(m.Groups[1].Value);
            else throw new Exception("Couldn't find the compile ID assigned by fcsh!");
        }

        /// <summary>
        /// Read until fcsh is in idle state, displaying its (fcsh) prompt
        /// </summary>
        /// <returns></returns>
        private string ReadUntilPrompt()
        {
            return ReadUntilToken("(fcsh)");
        }

        private string ReadUntilToken(string token)
        {
            StringBuilder output = new StringBuilder();
            Queue<char> queue = new Queue<char>();

            lock (typeof(FlexCompilerShell))
            {
                bool keepProcessing = true;
                while (keepProcessing)
                {
                    if (process.HasExited)
                        keepProcessing = false;
                    else
                    {
                        char c = (char)process.StandardOutput.Read();
                        output.Append(c);

                        queue.Enqueue(c);
                        if (queue.Count > token.Length)
                            queue.Dequeue();

                        if (new string(queue.ToArray()).Equals(token))
                            keepProcessing = false;
                    }
                }
            }
            return output.ToString();
        }

        #endregion
    }
}
