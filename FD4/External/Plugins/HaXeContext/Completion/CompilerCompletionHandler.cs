using System;
using System.Diagnostics;

namespace HaXeContext
{
    class CompilerCompletionHandler : IHaxeCompletionHandler
    {
        private Process haxeProcess;

        public CompilerCompletionHandler(Process haxeProcess)
        {
            this.haxeProcess = haxeProcess;
        }

        public string[] GetCompletion(string[] args)
        {
            if (args == null)
                return new string[0];
            var tm = DateTime.Now;
            haxeProcess.StartInfo.Arguments = String.Join(" ", args);
            haxeProcess.Start();
            var lines = haxeProcess.StandardError.ReadToEnd().Split('\n');
            haxeProcess.Close();
            //PluginCore.Managers.TraceManager.Add("time " + (DateTime.Now - tm) + "ms");
            return lines;
        }

        public void Stop()
        {
            
        }
    }
}
