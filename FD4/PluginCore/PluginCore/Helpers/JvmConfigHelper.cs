using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace PluginCore.PluginCore.Helpers
{
    public class JvmConfigHelper
    {
        /// <summary>
        /// Read a jvm.config file and returns its variables as a Dictionnary.
        /// </summary>
        public static Dictionary<string, string> ReadConfig(string configPath)
        {
            if (configPath == null) configPath = "";
            if (ConfigHelper.Cache.ContainsKey(configPath))
                return ConfigHelper.Cache[configPath];

            Dictionary<string, string> config = ConfigHelper.Parse(configPath, true);

            // default values
            if (!config.ContainsKey("java.home")) config["java.home"] = "";

            string args = "-Xmx384m -Dsun.io.useCanonCaches=false";
            if (config.ContainsKey("java.args")) args = config["java.args"];
            if (args.IndexOf("-Duser.language") < 0)
                args += " -Duser.language=en -Duser.region=US";
            config["java.args"] = args;

            return config;
        }

        public static string GetJavaEXE()
        {
            return GetJavaEXE(null, null);
        }
        public static string GetJavaEXE(Dictionary<string, string> jvmConfig)
        {
            return GetJavaEXE(jvmConfig, null);
        }
        public static string GetJavaEXE(Dictionary<string, string> jvmConfig, string flexSdkPath)
        {
            string defaultExe = "java.exe";
            string home = null;
            
            if (jvmConfig != null && jvmConfig.ContainsKey("java.home"))
                home = ResolvePath(jvmConfig["java.home"], flexSdkPath, true);
            if (home == null) home = Environment.ExpandEnvironmentVariables("%JAVA_HOME%");
 
            if (!String.IsNullOrEmpty(home) && !home.StartsWith("%")) 
                return Path.Combine(home, "bin\\java.exe");
            return defaultExe;
        }

		// Duplicated from 'PluginCore.PathHelper.ResolvePath()'
		// because JvmConfigHelper is used in external tool 'FDBuild'
        private static string ResolvePath(String path, String relativeTo, Boolean checkResolvedPathExisting)
        {
            if (path == null || path.Length == 0)
                return null;

            Boolean isPathNetworked = path.StartsWith("\\\\") || path.StartsWith("//");
            Boolean isPathAbsSlashed = (path.StartsWith("\\") || path.StartsWith("/")) && !isPathNetworked;
            if (isPathAbsSlashed) path = Path.GetPathRoot(AppDir) + path.Substring(1);

            if (Path.IsPathRooted(path) || isPathNetworked)
                return path;

            String resolvedPath;
            if (relativeTo != null)
            {
                resolvedPath = Path.Combine(relativeTo, path);
                if (Directory.Exists(resolvedPath) || File.Exists(resolvedPath))
                    return resolvedPath;
            }
            resolvedPath = Path.Combine(AppDir, path);
            if (Directory.Exists(resolvedPath) || File.Exists(resolvedPath))
                return resolvedPath;
            return null;
        }

        private static String AppDir
        {
            get
            {
                return Path.GetDirectoryName(System.Diagnostics.Process.GetCurrentProcess().MainModule.FileName);
            }
        }

    }
}
