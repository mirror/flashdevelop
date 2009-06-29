using System;
using System.IO;
using System.Reflection;
using System.Collections;
using System.Collections.Generic;
using FlashDevelop.Managers;
using PluginCore.Managers;
using FlashDevelop;
using PluginCore;

namespace FlashDevelop.Utilities 
{
	class PluginServices
	{
        public static List<String> KnownDLLs;
        public static List<AvailablePlugin> AvailablePlugins;
        
        static PluginServices()
        {
            KnownDLLs = new List<String>();
            AvailablePlugins = new List<AvailablePlugin>();
        }

		/// <summary>
		/// Finds plugins from the specified folder
		/// </summary>
        public static void FindPlugins(String path)
		{
            EnsureUpdatedPlugins(path);
            foreach (String fileOn in Directory.GetFiles(path, "*.dll"))
			{
                String name = Path.GetFileNameWithoutExtension(fileOn);
                if (name != "PluginCore" && !KnownDLLs.Contains(name))
                {
                    KnownDLLs.Add(name);
                    AddPlugin(fileOn);
                }
			}
		}

        /// <summary>
        /// Ensures that the plugins are updated before init
        /// </summary>
        public static void EnsureUpdatedPlugins(String path)
        {
            foreach (String newFile in Directory.GetFiles(path, "*.new"))
            {
                String pluginFile = Path.GetFileNameWithoutExtension(newFile);
                if (File.Exists(pluginFile))
                {
                    File.Copy(newFile, pluginFile, true);
                    File.Delete(newFile);
                }
                else File.Move(newFile, pluginFile);
            }
        }

        /// <summary>
        /// Finds a plugin from the plugin collection
        /// </summary>
        public static AvailablePlugin Find(String guid)
        {
            foreach (AvailablePlugin plugin in AvailablePlugins)
            {
                if (plugin.Instance.Guid == guid)
                {
                    return plugin;
                }
            }
            return null;
        }

		/// <summary>
		/// Disposes all available plugins that are active
		/// </summary>
        public static void DisposePlugins()
		{
			foreach (AvailablePlugin pluginOn in AvailablePlugins)
			{
				try
                {
                    if (pluginOn.IsActive)
                    {
                        pluginOn.Instance.Dispose();
                    }
				} 
				catch (Exception ex)
				{
                    ErrorManager.ShowError(ex);
				}
			}
			AvailablePlugins.Clear();
		}
		
		/// <summary>
		/// Adds a plugin to the plugin collection
		/// </summary>
        private static void AddPlugin(String fileName)
		{
			Assembly pluginAssembly = Assembly.LoadFrom(fileName);
            try
            {
                foreach (Type pluginType in pluginAssembly.GetTypes())
                {
                    if (pluginType.IsPublic && !pluginType.IsAbstract)
                    {
                        Type typeInterface = pluginType.GetInterface("PluginCore.IPlugin", true);
                        if (typeInterface != null)
                        {
                            AvailablePlugin newPlugin = new AvailablePlugin(fileName);
                            newPlugin.Instance = (IPlugin)Activator.CreateInstance(pluginAssembly.GetType(pluginType.ToString()));
                            if (!Globals.Settings.DisabledPlugins.Contains(newPlugin.Instance.Guid))
                            {
                                newPlugin.Instance.Initialize();
                                newPlugin.IsActive = true;
                            }
                            if (!AvailablePlugins.Contains(newPlugin))
                            {
                                AvailablePlugins.Add(newPlugin);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
		}
	}

	public class AvailablePlugin
	{
        public Boolean IsActive = false;
        public String Assembly = String.Empty;
        public IPlugin Instance = null;

        public AvailablePlugin(String assembly)
        {
            this.Assembly = assembly;
        }
		
	}
	
}
