using System;
using System.Collections.Generic;
using System.Text;
using PluginCore.PluginCore.System.Bridge;
using PluginCore.Managers;
using System.IO;

namespace PluginCore.PluginCore.System
{
    public class BridgeManager
    {
        static private BridgeClient remoteClient;

        #region Properties

        /// <summary>
        /// FlashDevelop should delegate most of the cpu/application load 
        /// to a host system running the FlashDevelop Bridge
        /// </summary>
        static public bool Active
        {
            get
            {
                return false; // TODO add to global settings
            }
        }

        /// <summary>
        /// Use Flash CS from the host system
        /// </summary>
        static public bool TargetRemoteIDE
        {
            get
            {
                return Active && true; // TODO add to global settings
            }
        }

        /// <summary>
        /// Use file explorer of the host system
        /// </summary>
        public static bool UseRemoteExplorer
        {
            get
            {
                if (!Active) return false;
                return true; // TODO add to settings
            }
        }

        static public string SharedFolder
        {
            get
            {
                return "Z:\\.FlashDevelop"; // TODO add to global settings
            }
        }

        #endregion

        #region Tool functions

        /// <summary>
        /// Check if the provided file type should always be executed under Windows
        /// </summary>
        static public bool AlwaysOpenLocal(string path)
        {
            if (!Active) return true;
            string ext = Path.GetExtension(path).ToLower();
            if (ext == ".exe" || ext == ".com" || ext == ".bat" || ext == ".cmd") // TODO add to settings
                return true;
            return false;
        }

        /// <summary>
        /// Open a shared document by the associated application of the host
        /// </summary>
        static public void RemoteOpen(string shared)
        {
            if (remoteClient == null || !remoteClient.Connected)
                remoteClient = new BridgeClient();
            if (remoteClient != null && remoteClient.Connected)
            {
                PluginBase.MainForm.StatusStrip.Items[0].Text = "  Opening document in host system...";
                remoteClient.Send("open:" + GetSharedPath(shared));
            }
            else TraceManager.AddAsync("Unable to connect to host bridge.");
        }

        /// <summary>
        /// Convert a local mapped path to a network location
        /// </summary>
        static public string GetSharedPath(string path)
        {
            if (path.StartsWith("\\\\")) return path;
            if (path[0] > 'H' && path[1] == ':')
            {
                UNCInfo realPath = WinOS.GetUNC(path);
                if (realPath != null)
                    if (Directory.Exists(path)) return realPath.UniversalName + "\\";
                    else return realPath.UniversalName;
            }
            else if (path[0] == '~' || path[0] == '/') return path;
            return null;
        }

        #endregion
    }
}
