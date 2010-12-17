using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using PluginCore.Localization;
using PluginCore.Bridge;

namespace BridgeSettings
{
    [Serializable]
    class Settings : IBridgeSettings
    {
        const string DEFAULT_SHARED_FOLDER = "Z:\\.FlashDevelop";
        static private string[] DEFAULT_EXTENSIONS = { ".exe", ".com", ".bat", ".cmd" };

        private bool active = false;
        private bool targetRemoteIDE = true;
        private bool useRemoteExplorer = true;
        private string sharedFolder = DEFAULT_SHARED_FOLDER;
        private string[] alwaysOpenLocal = DEFAULT_EXTENSIONS;

        [LocalizedDescription("BridgeSettings.Description.Active"), DefaultValue(false)]
        public bool Active
        {
            get { return active; }
            set { active = value; }
        }

        [DisplayName("Target Remote IDE"), LocalizedDescription("BridgeSettings.Description.TargetRemoteIDE"), DefaultValue(true)]
        public bool TargetRemoteIDE
        {
            get { return targetRemoteIDE; }
            set { targetRemoteIDE = value; }
        }

        [DisplayName("Use Remote Explorer"), LocalizedDescription("BridgeSettings.Description.UseRemoteExplorer"), DefaultValue(true)]
        public bool UseRemoteExplorer
        {
            get { return useRemoteExplorer; }
            set { useRemoteExplorer = value; }
        }

        [DisplayName("Shared Folder"), LocalizedDescription("BridgeSettings.Description.SharedFolder"), DefaultValue(DEFAULT_SHARED_FOLDER)]
        public string SharedFolder
        {
            get { return sharedFolder ?? DEFAULT_SHARED_FOLDER; }
            set { sharedFolder = value; }
        }

        [DisplayName("Always Open Local"), LocalizedDescription("BridgeSettings.Description.AlwaysOpenLocal")]
        public string[] AlwaysOpenLocal
        {
            get { return alwaysOpenLocal ?? DEFAULT_EXTENSIONS; }
            set { alwaysOpenLocal = value; }
        }

    }

}
