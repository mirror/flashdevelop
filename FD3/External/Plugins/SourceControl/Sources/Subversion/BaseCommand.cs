using System;
using System.Collections.Generic;
using System.Text;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using System.Threading;
using PluginCore;
using System.Windows.Forms;

namespace SourceControl.Sources.Subversion
{
    class BaseCommand
    {
        protected ProcessRunner runner;
        protected List<string> errors = new List<string>();

        protected virtual void Run(string args, string workingDirectory)
        {
            try
            {
                if (!args.StartsWith("status")) TraceManager.AddAsync("svn " + args);

                runner = new ProcessRunner();
                runner.WorkingDirectory = workingDirectory;
                runner.Run(GetSvnCmd(), args);
                runner.Output += new LineOutputHandler(runner_Output);
                runner.Error += new LineOutputHandler(runner_Error);
                runner.ProcessEnded += new ProcessEndedHandler(runner_ProcessEnded);
            }
            catch (Exception ex)
            {
                runner = null;
                TraceManager.AddAsync("Unable to start SVN command:\n" + ex.Message);
            }
        }

        protected virtual string GetSvnCmd()
        {
            string cmd = PluginMain.SCSettings.SvnPath;
            if (cmd == "null") cmd = "svn";
            string resolve = PathHelper.ResolvePath(cmd);
            return resolve ?? cmd;
        }

        protected virtual void runner_ProcessEnded(object sender, int exitCode)
        {
            runner = null;
            DisplayErrors();
        }

        protected virtual void DisplayErrors()
        {
            if (errors.Count > 0)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate
                {
                    ErrorManager.ShowInfo(String.Join("\n", errors.ToArray()));
                });
            }
        }

        protected virtual void runner_Error(object sender, string line)
        {
            errors.Add(line.StartsWith("svn: ") ? line.Substring(5) : line);
        }

        protected virtual void runner_Output(object sender, string line)
        {
        }
    }
}
