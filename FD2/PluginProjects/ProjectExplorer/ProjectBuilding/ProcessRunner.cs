using System;
using System.Collections;
using System.IO;
using System.Diagnostics;
using System.Threading;

namespace ProjectExplorer.ProjectBuilding
{
	public class ProcessRunner
	{
		// TODO: Get rid of "suppressImportWarnings" once MTASC releases a new version
		// with that option fixed.

		public static bool Run(string fileName, string arguments, bool ignoreExitCode)
		{
			if (!File.Exists(fileName))
				throw new FileNotFoundException("The program '"+fileName+"' was not found.",fileName);

			Process process = new Process();
			process.StartInfo.UseShellExecute = false;
			process.StartInfo.RedirectStandardOutput = true;
			process.StartInfo.RedirectStandardError = true;
			process.StartInfo.CreateNoWindow = true;
			process.StartInfo.FileName = fileName;
			process.StartInfo.Arguments = arguments;
			process.StartInfo.WorkingDirectory = Environment.CurrentDirectory;
			process.Start();

			// capture output in a separate thread
			LineFilter stdoutFilter = new LineFilter(process.StandardOutput,Console.Out);
			LineFilter stderrFilter = new LineFilter(process.StandardError,Console.Error);

			Thread outThread = new Thread(new ThreadStart(stdoutFilter.Filter));
			Thread errThread = new Thread(new ThreadStart(stderrFilter.Filter));

			outThread.Start();
			errThread.Start();

			process.WaitForExit();

			outThread.Join(1000);
			errThread.Join(1000);
			
			return (ignoreExitCode) ? stderrFilter.Lines == 0 : process.ExitCode == 0;
		}
	}

	class LineFilter
	{
		TextReader reader;
		TextWriter writer;
		public int Lines;

		public LineFilter(TextReader reader, TextWriter writer)
		{
			this.reader = reader;
			this.writer = writer;
		}

		public void Filter()
		{
			while (true)
			{
				string line = reader.ReadLine();
				if (line == null) break;
				
				writer.WriteLine(line);
				writer.Flush();
				
				if (line.Length > 0) Lines++;
			}
		}
	}
}



		// this doesn't really make sense -- it makes you want to double-click the
		// entry which will open up the .fdp file as text which you REALLY don't want.

		/*static void ReformatErrors(string errorString)
		{
			foreach (string line in errorString.Split('\n'))
			{
				if (line.StartsWith("WARNING: "))
					WriteErrorForFD(project, "Warning: " + line.Substring(9));
				else if (line.StartsWith("ERROR: "))
					WriteErrorForFD(project, "Error: " + line.Substring(7));
				else if (line.StartsWith("swft:"))
					WriteErrorForFD(project, "Error: " + line.Substring(5));
				else if (line.StartsWith("Main entry point not found"))
					WriteErrorForFD(project, "Error: Main entry point not found.  Please mark one of your classes as 'Always Compile'.");
			}
		}

		// make a string like:
		// C:\Code\FlashConnect.as:55: characters 25-32 : type error Unknown variable msgNode
		public static void WriteErrorForFD(Project project, string error)
		{
			Console.Error.WriteLine(project.Name + ".fdp:0: " + error);
		}*/
