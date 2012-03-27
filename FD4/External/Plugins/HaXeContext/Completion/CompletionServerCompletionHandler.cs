﻿using System.Diagnostics;
using System.IO;
using System.Net.Sockets;
using PluginCore;
using ProjectManager.Projects.Haxe;
using PluginCore.Managers;
using System;
using System.Text.RegularExpressions;

namespace HaXeContext
{
    delegate void FallbackNeededHandler(bool notSupported);

    class CompletionServerCompletionHandler : IHaxeCompletionHandler
    {
        public event FallbackNeededHandler FallbackNeeded;

        private readonly Process haxeProcess;
        private readonly int port;
        private bool listening;
        private bool failure;

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
                var writer = new StreamWriter(client.GetStream());
                writer.WriteLine("--cwd " + (PluginBase.CurrentProject as HaxeProject).Directory);
                foreach (var arg in args)
                    writer.WriteLine(arg);
                writer.Write("\0");
                writer.Flush();
                var reader = new StreamReader(client.GetStream());
                var lines = reader.ReadToEnd().Split('\n');
                client.Close();
                return lines;
            }
            catch(Exception ex)
            {
                TraceManager.AddAsync(ex.Message);
                if (!failure && FallbackNeeded != null)
                    FallbackNeeded(false);
                failure = true;
                return new string[0];
            }
        }

        private void StartServer()
        {
            haxeProcess.Start();
            if (!listening)
            {
                listening = true;
                haxeProcess.BeginErrorReadLine();
                haxeProcess.ErrorDataReceived += new DataReceivedEventHandler(haxeProcess_ErrorDataReceived);
            }
        }

        void haxeProcess_ErrorDataReceived(object sender, DataReceivedEventArgs e)
        {
            if (e.Data == null) return;
            //TraceManager.AddAsync(e.Data);
            if (Regex.IsMatch(e.Data, "Error.*--wait"))
            {
                if (!failure && FallbackNeeded != null) 
                    FallbackNeeded(true);
                failure = true;
            }
        }

        public void Stop()
        {
            if (IsRunning())
                haxeProcess.Kill();
        }
    }
}
