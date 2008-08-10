using System;
using System.Collections;
using System.Windows.Forms;
using System.Text;
using System.Xml;
using FlashDevelop.Utilities;
using System.Text.RegularExpressions;
using PluginCore;

namespace FlashDevelop.Utilities
{
	public class SettingParser : ISettings
	{
		private ArrayList settings;
		private bool errorFree = true;
		private bool useCDATA = true;
		private string filename;

		public SettingParser(string settingsFile)
		{
			this.filename = settingsFile;
			this.settings = new ArrayList();
			this.Load(this.filename);
		}
		
		/**
		* Access to the UseCDATA property.
		*/
		public bool UseCDATA 
		{
			get { return this.useCDATA; }
			set { this.useCDATA = value; }
		}
		
		/**
		* Access to the settings in an ArrayList.
		*/
		public ArrayList Settings 
		{
			get { return this.settings; }
			set { this.settings = value; }
		}
		
		/**
		* Loads the specified settings file.
		*/
		public void Load(string filename)
		{
			try
			{
				if (!System.IO.File.Exists(filename)) this.Save();
				XmlDocument document = XmlUtils.GetXmlDocument(filename);
				XmlNode declNode = document.FirstChild;
				XmlNode rootNode = declNode.NextSibling;
				for (int i = 0; i<rootNode.ChildNodes.Count; i++)
				{
					XmlNode currentNode = rootNode.ChildNodes[i];
					if (XmlUtils.HasAttribute(currentNode, "key"))
					{
						string key = XmlUtils.GetAttribute(currentNode, "key");
						string val = XmlUtils.GetValue(currentNode);
						if (val == null) val = ""; // No null values :)
						this.settings.Add(new SettingEntry(key, val));
					}
					else
					{
						this.errorFree = false;
						throw new Exception("Invalid XML syntax. Key attribute is missing.");
					}
				}
			}
			catch (Exception ex)
			{
				this.errorFree = false;
				ErrorHandler.ShowError("Could not parse the settings file.", ex);
			}
		}

		/**
		* Saves the specified settings file.
		*/
		public void Save()
		{
			if (!errorFree) return;
			try
			{
				int count = this.settings.Count;
				string settingsFile = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<settings>\r\n";
				for (int i = 0; i<count; i++)
				{
					SettingEntry se = (SettingEntry)this.settings[i];
					if (this.useCDATA) settingsFile += "\t<setting key=\""+se.Key+"\"><![CDATA["+se.Value+"]]></setting>\r\n";
					else settingsFile += "\t<setting key=\""+se.Key+"\">"+se.Value+"</setting>\r\n";
				}
				settingsFile += "</settings>";
				FileSystem.Write(this.filename, settingsFile, Encoding.UTF8);
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while saving settings.", ex);
			}
		}
		
		/**
		* Gets the setting specified by key.
		*/
		public ISettingEntry GetSetting(string settingKey)
		{
			int count = this.settings.Count;
			for (int i = 0; i<count; i++)
			{
				SettingEntry se = (SettingEntry)this.settings[i];
				if (se.Key == settingKey)
				{
					return (ISettingEntry)se;
				}
			}
			return null;
		}
		
		/**
		* Gets the setting specified by value.
		*/
		public ISettingEntry GetSettingByValue(string settingValue)
		{
			int count = this.settings.Count;
			for (int i = 0; i<count; i++)
			{
				SettingEntry se = (SettingEntry)this.settings[i];
				if (se.Value == settingValue)
				{
					return (ISettingEntry)se;
				}
			}
			return null;
		}
		
		/**
		* Creates a new setting from key and value.
		*/
		public ISettingEntry CreateInstance(string settingKey, string settingValue)
		{
			SettingEntry se = new SettingEntry(settingKey, settingValue);
			return (ISettingEntry)se;
		}
		
		/**
		* Inserts the value of the specified setting to specified index.
		*/
		public void InsertValue(int index, string settingKey, string settingValue)
		{
			try 
			{
				SettingEntry se = new SettingEntry(settingKey, settingValue);
				this.settings.Insert(index, se);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while inserting value.", ex);
			}
		}
		
		/**
		* Removes the specified setting by index.
		*/
		public void RemoveValueAt(int index)
		{
			try 
			{
				this.settings.RemoveAt(index);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while removing value at.", ex);
			}
		}
		
		/**
		* Removes all settings specified by key.
		*/
		public void RemoveByKey(string settingKey)
		{
			for (int i = 0; i<this.settings.Count; i++)
			{
				SettingEntry se = (SettingEntry)this.settings[i];
				if (se.Key == settingKey)
				{
					this.settings.RemoveAt(i);
				}
			}
		}
		
		/**
		* Removes all settings specified by value.
		*/
		public void RemoveByValue(string settingValue)
		{
			for (int i = 0; i<this.settings.Count; i++)
			{
				SettingEntry se = (SettingEntry)this.settings[i];
				if (se.Value == settingValue)
				{
					this.settings.RemoveAt(i);
				}
			}			
		}
		
		/**
		* Adds a new key and value pair to the settings.
		*/
		public void AddValue(string settingKey, string settingValue)
		{
			SettingEntry se = new SettingEntry(settingKey, settingValue);
			this.settings.Add(se);
		}
		
		/**
		* Changes the value of the specified setting. If its not found, adds it.
		*/
		public void ChangeValue(string settingKey, string settingValue)
		{
			if (!this.HasKey(settingKey))
			{
				this.AddValue(settingKey, settingValue);
			}
			ISettingEntry se = this.GetSetting(settingKey);
			if (se != null)
			{
				se.Value = settingValue;
			}
		}
		
		/**
		* Gets the string key of the specified setting by value.
		*/
		public string GetKey(string settingValue)
		{
			try 
			{
				ISettingEntry se = this.GetSettingByValue(settingValue);
				if (se != null)
				{
					return se.Key;
				}
				return null;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Could not find the setting key.", ex);
				return null;
			}
		}	
		
		/**
		* Gets the string value of the specified setting by key.
		*/
		public string GetValue(string settingKey)
		{
			try 
			{
				ISettingEntry se = this.GetSetting(settingKey);
				if (se != null)
				{
					return se.Value;
				}
				return null;
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Could not find the setting value.", ex);
				return null;
			}
		}
		
		/**
		* Gets the int value of the specified setting by key.
		*/
		public int GetInt(string settingKey)
		{
			try 
			{
				string settingValue = this.GetValue(settingKey);
				return Convert.ToInt32(settingValue);
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while converting value to integer.", ex);
				return 0;
			}
		}
		
		/**
		* Gets the bool value of the specified setting by key.
		*/
		public bool GetBool(string settingKey)
		{
			try
			{
				string settingValue = this.GetValue(settingKey);
				return Convert.ToBoolean(settingValue);
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while converting value to boolean.", ex);
				return false;
			}
		}
		
		/**
		* Gets the Shortcut value of the specified setting by key.
		*/
		public Keys GetShortcut(string settingKey)
		{
			try
			{
				Shortcut shortcut = (Shortcut)Enum.Parse(typeof(Shortcut), this.GetValue(settingKey));
				return (System.Windows.Forms.Keys)shortcut;
			}
			catch
			{
				return System.Windows.Forms.Keys.None;
			}
		}
		
		/**
		* Checks that does the settings have the specified key.
		*/
		public bool HasKey(string settingKey)
		{
			ISettingEntry se = this.GetSetting(settingKey);
			if (se != null)
			{
				return true;
			}
			return false;
		}
		
		/**
		* Checks that does the settings have the specified value.
		*/
		public bool HasValue(string settingValue)
		{
			ISettingEntry se = this.GetSettingByValue(settingValue);
			if (se != null)
			{
				return true;
			}
			return false;
		}
		
		/**
		* Sorts the settings by setting key.
		*/
		public void SortByKey()
		{
			try 
			{
				ArrayList container = new ArrayList();
				int count = this.settings.Count;
				for (int i = 0; i<count; i++)
				{
					SettingEntry se = (SettingEntry)this.settings[i];
					container.Add(se.Key+"@COMBINED@"+se.Value);
				}
				container.Sort();
				for (int i = 0; i<container.Count; i++)
				{
					string line = container[i].ToString();
					string[] chunks = Regex.Split(line, "@COMBINED@");
					SettingEntry se = new SettingEntry(chunks[0], chunks[1]);
					this.settings[i] = se;
				}
			} 
			catch (Exception ex)
			{
				this.errorFree = false;
				ErrorHandler.ShowError("Error while sorting settings", ex);
			}
		}

	}
	
	public class SettingEntry : ISettingEntry
	{
		private string key;
		private string val;

		public SettingEntry(string key, string val)
		{
			this.key = key;
			this.val = val;
		}
		
		/**
		* Access to the key
		*/
		public string Key
		{
			get { return this.key; }
			set { this.key = value; }
		}
		
		/**
		* Access to the value
		*/
		public string Value
		{
			get { return this.val; }
			set { this.val = value; }
		}
		
	}

}
