using System;
using System.Collections.Generic;
using System.Text;
using PluginCore;
using System.Windows.Forms;
using PluginCore.Managers;
using System.IO;

namespace AS3Context.Compiler
{
    class FlexDebugger
    {
        #region Public interface

        public static bool Start(string projectPath, string flex2Path, DataEvent message)
        {
            if (ignoreMessage) return false;
            try
            {
                if (debugger != null) debugger.Cleanup();
                startMessage = message;
                debugger = new FdbWrapper();
                debugger.OnStarted += new LineEvent(debugger_OnStarted);
                debugger.OnTrace += new LineEvent(debugger_OnTrace);
                debugger.OnError += new LineEvent(debugger_OnError);
                if (PluginMain.Settings.VerboseFDB)
                    debugger.OnOutput += new LineEvent(debugger_OnOutput);
                debugger.Run(projectPath, flex2Path);
                TraceManager.AddAsync("[Capturing traces with FDB]");
                return true;
            }
            catch
            {
                TraceManager.AddAsync("[Failed to launch FBD]", 3);
            }
            return false;
        }

        public static void Stop()
        {
            if (debugger != null)
            {
                debugger.Cleanup();
                debugger = null;
                startMessage = null;
                ignoreMessage = false;
            }
        }

        #endregion

        static private bool ignoreMessage;
        static private FdbWrapper debugger;
        static private DataEvent startMessage;

        static void debugger_OnStarted(string line)
        {
            if (startMessage == null) 
                return;
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke(new LineEvent(debugger_OnStarted), new object[] { line });
                return;
            }
            // send message again
            ignoreMessage = true;
            EventManager.DispatchEvent(null, startMessage);
            startMessage = null;
            ignoreMessage = false;
        }

        static void debugger_OnError(string line)
        {
            TraceManager.AddAsync(line, 3);
        }

        static void debugger_OnOutput(string line)
        {
            TraceManager.AddAsync(line, 1);
        }

        static void debugger_OnTrace(string line)
        {
            TraceManager.AddAsync(line, 1);
        }
    }
}
