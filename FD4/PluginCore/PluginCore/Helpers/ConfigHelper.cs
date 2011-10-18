using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace PluginCore.Helpers
{
    public class ConfigHelper
    {
        public static Dictionary<string, Dictionary<string, string>> Cache = new Dictionary<string, Dictionary<string, string>>();

        /// <summary>
        /// Read a simple config file and returns its variables as a Hashtable.
        /// </summary>
        public static Dictionary<string, string> Parse(string configPath, bool cache)
        {
            if (cache && Cache.ContainsKey(configPath)) return Cache[configPath];
            Dictionary<string, string> config = new Dictionary<string, string>();
            if (File.Exists(configPath))
            {
                string[] lines = File.ReadAllLines(configPath);
                foreach (string line in lines)
                {
                    if (line.StartsWith("#")) continue;
                    string[] entry = line.Trim().Split(new char[] { '=' }, 2);
                    if (entry.Length < 2) continue;
                    config[entry[0].Trim()] = entry[1].Trim();
                }
            }
            if (cache) Cache[configPath] = config;
            return config;
        }
    }
}
