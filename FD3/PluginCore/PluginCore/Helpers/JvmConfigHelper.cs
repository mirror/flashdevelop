using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Collections;

namespace PluginCore.PluginCore.Helpers
{
    public class JvmConfigHelper
    {
        private static Dictionary<string, Hashtable> cache = new Dictionary<string, Hashtable>();

        /// <summary>
        /// Read a simple config file and returns its variables as a Hashtable.
        /// </summary>
        public static Hashtable ReadConfig(string configPath)
        {
            if (cache.ContainsKey(configPath)) return cache[configPath];

            Hashtable config = new Hashtable();
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

            // default values
            if (!config.ContainsKey("java.home")) config["java.home"] = "";

            string args = "-Xmx384m -Dsun.io.useCanonCaches=false";
            if (config.ContainsKey("java.args")) args = config["java.args"] as string;
            if (args.IndexOf("-Duser.language") < 0)
                args += " -Duser.language=en -Duser.region=US";
            config["java.args"] = args;

            cache[configPath] = config;
            return config;
        }

        public static string GetJavaEXE(Hashtable jvmConfig)
        {
            string home = jvmConfig["java.home"] as string;
            if (home.Length > 0) return Path.Combine(home, "bin\\java.exe");
            else return "java.exe"; // rely on environment path
        }
    }
}
