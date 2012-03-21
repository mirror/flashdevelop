using System.Diagnostics;
using System.Diagnostics;
using System.IO;
using System.Net.Sockets;
using PluginCore;
using ProjectManager.Projects.Haxe;
using PluginCore.Managers;
using System;

namespace HaXeContext
{
    class CompletionServerCompletionHandler : IHaxeCompletionHandler
    {
        private readonly Process haxeProcess;
        private readonly int port;
        private bool listening;

        public CompletionServerCompletionHandler(Process haxeProcess, int port)
        {
            this.haxeProcess = haxeProcess;
            this.port = port;
            //haxeProcess.Start(); // deferred to first use
        }

        public bool IsRunning()
        {
            try { return !haxeProcess.HasExited; } 
            catch { return false; }
        }

        ~CompletionServerCompletionHandler()
        {
            Stop();
        }

        public string[] GetCompletion(string[] args)
        {
            if (!IsRunning()) StartServer();
            if (args == null)
                return new string[0];
            try
            {
                var client = new TcpClient("127.0.0.1", port);
                var tm = DateTime.Now;
                var writer = new StreamWriter(client.GetStream());
                writer.WriteLine("--cwd " + (PluginBase.CurrentProject as HaxeProject).Directory);
                foreach (var arg in args)
                    writer.WriteLine(arg); //.Replace("\"", "")
                //writer.WriteLine("--times");
                writer.Write("\0");
                writer.Flush();
                var reader = new StreamReader(client.GetStream());
                var lines = reader.ReadToEnd().Split('\n');
                client.Close();
                //TraceManager.Add("time " + (DateTime.Now - tm) + "ms");
                return lines;
            }
            catch
            {
                return new string[0];
            }
        }

        private void StartServer()
        {
            haxeProcess.Start();
        }

        public void Stop()
        {
            if (IsRunning())
                haxeProcess.Kill();
        }
    }
}
