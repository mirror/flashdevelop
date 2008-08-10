using System;
using System.IO;
using System.Reflection;
using FlashDevelop;
using ScintillaNet;
using System.Collections;
using PluginCore.Controls;
using PluginCore;

namespace FlashDevelop.Utilities 
{
	/**
	* Global class for static entry to the plugins
	*/
	public class Global
	{
		public static PluginServices Plugins = new PluginServices();
	}
	
	/**
	* Manages all things related to the plugins
	*/
	public class PluginServices : IPluginHost
	{
		/**
		* Variables
		*/
		private MainForm mainForm = null;
		private Types.AvailablePlugins colAvailablePlugins = new Types.AvailablePlugins();
		
		/**
		* Access to the MainForm
		*/
		public IMainForm MainForm
		{
			get 
			{
				return this.mainForm; 
			}
		}
		
		/**
		* Access to the currently available plugins
		*/
		public Types.AvailablePlugins AvailablePlugins
		{
			get 
			{
				return this.colAvailablePlugins; 
			}
			set 
			{
				this.colAvailablePlugins = value; 
			}
		}
		
		/**
		* Find plugins from the application folder
		*/
		public void FindPlugins()
		{
			this.FindPlugins(AppDomain.CurrentDomain.BaseDirectory);
		}
		
		/**
		* Find plugins from the specified folder
		*/
		public void FindPlugins(string Path)
		{
			this.colAvailablePlugins.Clear();
			foreach (string fileOn in Directory.GetFiles(Path))
			{
				FileInfo file = new FileInfo(fileOn);
				if (file.Extension.Equals(".dll"))
				{	
					this.AddPlugin(fileOn);
				}
			}
		}
		
		/**
		* Disposes all available plugins
		*/
		public void ClosePlugins()
		{
			foreach(Types.AvailablePlugin pluginOn in colAvailablePlugins)
			{
				try 
				{
					pluginOn.Instance.Dispose(); 
					pluginOn.Instance = null;
				} 
				catch (Exception ex)
				{
					ErrorHandler.AddToLog(ex);
				}
			}
			this.colAvailablePlugins.Clear();
		}
		
		/**
		* Adds a plugin to the plugin collection
		*/
		private void AddPlugin(string fileName)
		{
			try 
			{
				Assembly pluginAssembly = Assembly.LoadFrom(fileName);
				foreach (Type pluginType in pluginAssembly.GetTypes())
				{
					if (pluginType.IsPublic)
					{
						if (!pluginType.IsAbstract)
						{
							Type typeInterface = pluginType.GetInterface("PluginCore.IPlugin", true);
							if (typeInterface != null)
							{
								Types.AvailablePlugin newPlugin = new Types.AvailablePlugin();
								newPlugin.AssemblyPath = fileName;
								newPlugin.Instance = (IPlugin)Activator.CreateInstance(pluginAssembly.GetType(pluginType.ToString()));
								newPlugin.Instance.Host = this;
								newPlugin.Instance.Initialize();
								this.colAvailablePlugins.Add(newPlugin);
								newPlugin = null;
							}
							typeInterface = null;
						}
					}
				}
				pluginAssembly = null;
			}
			catch (Exception ex)
			{
				ErrorHandler.AddToLog(ex);
			}
		}
		
		/**
		* Notifies all plugins from an event
		*/
		public void NotifyPlugins(object sender, NotifyEvent e)
		{
			try 
			{
				EventType type = e.Type;
				if (sender == null) 
				{
					sender = this;
				}
				/**
				* Custom Controls
				*/ 
				if ((UITools.EventMask & type) > 0)
				{
					UITools.HandleEvent(sender, e);
					if (e.Handled) return;
				}
				/**
				* Current Document
				*/ 
				try 
				{
					if ((TabbedDocument.EventMask & type) > 0)
					{
						TabbedDocument td = (TabbedDocument)this.mainForm.CurDocument;
						td.HandleEvent(sender, e);
					}
				} 
				catch {}
				/**
				* External Plugins 
				*/ 
				foreach (Types.AvailablePlugin pluginOn in this.colAvailablePlugins)
				{
					if ((pluginOn.Instance.EventMask & type) > 0)
					{
						pluginOn.Instance.HandleEvent(sender, e);
						if (e.Handled) break;
					}
				}
			}
			catch (Exception ex)
			{
				ErrorHandler.AddToLog(ex);
			}
		}
		
		/**
		* Activates the access to the MainForm
		*/
		public void Initialize(MainForm mainForm)
		{
			this.mainForm = mainForm;
		}
		
	}
	
	namespace Types
	{
		/**
		* Plugin collection class
		*/
		public class AvailablePlugins : CollectionBase
		{
			/**
			* Adds a plugin to the plugin collection
			*/
			public void Add(Types.AvailablePlugin pluginToAdd)
			{
				this.List.Add(pluginToAdd); 
			}
			
			/**
			* Removes a plugin from the plugin collection
			*/
			public void Remove(Types.AvailablePlugin pluginToRemove)
			{
				this.List.Remove(pluginToRemove);
			}
			
			/**
			* Finds a plugin from the plugin collection
			*/
			public Types.AvailablePlugin Find(string guid)
			{
				foreach (Types.AvailablePlugin pluginOn in this)
				{
					if (pluginOn.Instance.Guid == guid)
					{
						return pluginOn;
					}
				}
				return null;
			}
			
			/**
			* Retrieves all plugins
			*/
			public ArrayList GetAll()
			{
				ArrayList plugins = new ArrayList();
				foreach (Types.AvailablePlugin pluginOn in this)
				{
					plugins.Add(pluginOn);
				}
				return plugins;
			}
			
		}
		
		/**
		* Plugin instance class in the plugin collection
		*/
		public class AvailablePlugin
		{
			/**
			* Variables
			*/
			private string assemblyPath = "";
			private IPlugin pluginInstance = null;
			
			/**
			* Access to the plugin AssemblyPath
			*/
			public string AssemblyPath
			{
				get { return this.assemblyPath; }
				set { this.assemblyPath = value; }
			}
			
			/**
			* Access to the plugin itself via interface
			*/
			public IPlugin Instance
			{
				get { return this.pluginInstance; }
				set	{ this.pluginInstance = value; }
			}
			
		}
		
	}
	
}
