using System;
using System.Collections.Generic;
using System.Text;
using PluginCore.Bridge;
using PluginCore.Managers;
using System.IO;

namespace PluginCore.Bridge
{
    public class BridgeManager
    {
        static private IBridgeSettings settings;
        static private BridgeClient remoteClient;

        #region Properties

        /// <summary>
        /// Enable delegation to host system
        /// </summary>
        static public bool Active
        {
            get { return settings != null ? settings.Active : false; }
        }

        /// <summary>
        /// Bridge configuration is externalized in a plugin
        /// </summary>
        static public IBridgeSettings Settings
        {
            get { return settings; }
            set { settings = value; }
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
            foreach (string item in settings.AlwaysOpenLocal)
                if (ext == item) return true;
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
