using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using PluginCore.Managers;
using System.Diagnostics;
using PluginCore.Helpers;
using PluginCore;
using System.Text.RegularExpressions;

namespace CssCompletion
{
    public class Optimizer
    {
        static public void ProcessFile(string fileName, CssFeatures features, Settings settings)
        {
            if (settings.DisableCompileOnSave) return;
            if (!string.IsNullOrEmpty(features.Compile)) CompileFile(fileName, features, settings);
            else CompressFile(fileName, features, settings);
        }

        static public void CompressFile(string fileName, CssFeatures features, Settings settings)
        {
            if (settings.DisableMinifyOnSave) return;
            try
            {
                string min = CssMinifier.Minify(File.ReadAllText(fileName));
                string outFile = Path.Combine(Path.GetDirectoryName(fileName), Path.GetFileNameWithoutExtension(fileName)) + ".min.css";
                File.WriteAllText(outFile, min);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowInfo(ex.Message);
            }
        }

        static public void CompileFile(string fileName, CssFeatures features, Settings settings)
        {
            EventManager.DispatchEvent(features, new NotifyEvent(EventType.ProcessStart));

            string cmd = PathHelper.ResolvePath(features.Compile, Path.Combine(PathHelper.ToolDir, "css"));
            string outFile = Path.GetFileNameWithoutExtension(fileName) + ".css";
            ProcessStartInfo info = new ProcessStartInfo();
            info.FileName = cmd;
            info.Arguments = Path.GetFileName(fileName) + " " + outFile;
            info.CreateNoWindow = true;
            info.WorkingDirectory = Path.GetDirectoryName(fileName);
            info.UseShellExecute = false;
            info.RedirectStandardOutput = true;
            info.RedirectStandardError = true;
            Process p = Process.Start(info);
            p.WaitForExit();

            string res = p.StandardOutput.ReadToEnd() ?? "";
            string err = p.StandardError.ReadToEnd() ?? "";
            if (settings.EnableVerboseCompilation)
            {
                if (res.Trim().Length > 0) TraceManager.Add(res);
                if (err.Trim().Length > 0) TraceManager.Add(err, 3);
            }

            MatchCollection matches = features.ErrorPattern.Matches(err);
            if (matches.Count > 0)
                foreach (Match m in matches)
                    TraceManager.Add(fileName + ":" + m.Groups["line"] + ": " + m.Groups["desc"].Value.Trim(), -3);

            EventManager.DispatchEvent(features, new TextEvent(EventType.ProcessEnd, "Done(" + p.ExitCode + ")"));

            if (p.ExitCode == 0)
            {
                outFile = Path.Combine(Path.GetDirectoryName(fileName), outFile);
                CompressFile(outFile, features, settings);
            }
        }
    }
}
