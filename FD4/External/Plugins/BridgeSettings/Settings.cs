﻿using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using PluginCore.Localization;
using PluginCore.Bridge;
using System.Text.RegularExpressions;

namespace BridgeSettings
{
    [Serializable]
    class Settings : IBridgeSettings
    {
        const string DEFAULT_SHARED_DRIVE = "Z:\\";
        const int DEFAULT_PORT_NUM = 8009;
        static private string[] DEFAULT_EXTENSIONS = { ".exe", ".com", ".bat", ".cmd" };

        private bool active = false;
        private string ip;
        private int port = DEFAULT_PORT_NUM;
        private bool targetRemoteIDE = true;
        private bool useRemoteExplorer = true;
        private string sharedDrive = DEFAULT_SHARED_DRIVE;
        private string[] alwaysOpenLocal = DEFAULT_EXTENSIONS;

        [LocalizedDescription("BridgeSettings.Description.Active"), DefaultValue(false)]
        public bool Active
        {
            get { return active; }
            set { active = value; }
        }

        [DisplayName("Custom Bridge IP"), LocalizedDescription("BridgeSettings.Description.CustomBridgeIP"), DefaultValue("")]
        public string CustomIP
        {
            get { return ip ?? ""; }
            set { ip = value; }
        }

        [DisplayName("Bride Port"), LocalizedDescription("BridgeSettings.Description.BridgePort"), DefaultValue(DEFAULT_PORT_NUM)]
        public int Port
        {
            get { return port > 0 ? port : DEFAULT_PORT_NUM; }
            set { port = value; }
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

        [DisplayName("Shared Drive"), LocalizedDescription("BridgeSettings.Description.SharedDrive"), DefaultValue(DEFAULT_SHARED_DRIVE)]
        public string SharedDrive
        {
            get { return sharedDrive ?? DEFAULT_SHARED_DRIVE; }
            set
            {
                if (Regex.IsMatch(value ?? "", "[H-Z]:\\", RegexOptions.IgnoreCase))
                    sharedDrive = Char.ToUpper(value[0]) + ":\\";
            }
        }

        [DisplayName("Always Open Local"), LocalizedDescription("BridgeSettings.Description.AlwaysOpenLocal")]
        public string[] AlwaysOpenLocal
        {
            get { return alwaysOpenLocal ?? DEFAULT_EXTENSIONS; }
            set { alwaysOpenLocal = value; }
        }

    }

}
