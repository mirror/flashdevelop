using System;
using System.Collections;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using System.Text;
using System.Xml;

namespace AS2APIGUI
{
	public class Settings
	{
		public ArrayList Keys;
		public ArrayList Values;
		public string Filename;

		public Settings(string settingsFile)
		{
			this.Keys = new ArrayList();
			this.Values = new ArrayList();
			this.Filename = settingsFile;
			this.Load(this.Filename);
		}
		
		/**
		* Gets the all keys in an ArrayList.
		*/
		public ArrayList GetKeys()
		{
			return this.Keys;
		}
		
		/**
		* Gets the all values in an ArrayList.
		*/
		public ArrayList GetValues()
		{
			return this.Values;
		}
		
		/**
		* Loads the specified settings file.
		*/
		public void Load(string filename)
		{
			XmlDocument document = XmlUtils.GetXmlDocument(filename);
			try
			{
				XmlNode declNode = document.FirstChild;
				XmlNode rootNode = declNode.NextSibling;
				int count = rootNode.ChildNodes.Count;
				for(int i = 0; i<count; i++)
				{
					XmlNode currentNode = rootNode.ChildNodes[i];
					if(XmlUtils.HasAttribute(currentNode, "key"))
					{
						string key = XmlUtils.GetAttribute(currentNode, "key");
						string val = XmlUtils.GetValue(currentNode);
						this.Values.Add(val);
						this.Keys.Add(key);
					}
					else
					{
						MessageBox.Show("Invalid XML syntax", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
					}
				}
			}
			catch
			{
				MessageBox.Show("Could not parse the settings file", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}

		/**
		* Saves the specified settings file.
		*/
		public void Save()
		{
			int count = this.Keys.Count;
			string settingsFile = "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>\r\n<as2apiproject>\r\n";
			for(int i = 0; i<count; i++)
			{
				settingsFile += "\t<setting key=\""+this.Keys[i]+"\">"+this.Values[i]+"</setting>\r\n";
			}
			settingsFile += "</as2apiproject>";
			FileSystem.Write(this.Filename, settingsFile, Encoding.Default);
		}
		
		/**
		* Removes the specified setting by index.
		*/
		public void RemoveValueAt(int index)
		{
			this.Keys.RemoveAt(index);
			this.Values.RemoveAt(index);
		}
		
		/**
		* Removes the specified setting by key.
		*/
		public void RemoveByKey(string settingKey)
		{
			int count = this.Keys.Count;
			for(int i = 0; i<count; i++)
			{
				if((string)this.Keys[i] == settingKey)
				{
					this.Keys.RemoveAt(i);
					this.Values.RemoveAt(i);
				}
			}
		}
		
		/**
		* Removes the specified setting by value.
		*/
		public void RemoveByValue(string settingValue)
		{
			int count = this.Values.Count;
			for(int i = 0; i<count; i++)
			{
				if((string)this.Values[i] == settingValue)
				{
					this.Keys.RemoveAt(i);
					this.Values.RemoveAt(i);
				}
			}
		}
		
		/**
		* Adds a new key and value pair to the settings.
		*/
		public void AddValue(string settingKey, string settingValue)
		{
			this.Keys.Add(settingKey);
			this.Values.Add(settingValue);
		}
		
		/**
		* Inserts the value of the specified setting to specified index.
		*/
		public void InsertValue(int index, string settingKey, string settingValue)
		{
			this.Keys.Insert(index, settingKey);
			this.Values.Insert(index, settingValue);
		}
		
		/**
		* Changes the value of the specified setting. If its not found, adds it.
		*/
		public void ChangeValue(string settingKey, string settingValue)
		{
			if(!this.HasKey(settingKey))
			{
				this.Keys.Add(settingKey);
				this.Values.Add(settingValue);
				return;
			}
			int count = this.Keys.Count;
			for(int i = 0; i<count; i++)
			{
				if((string)this.Keys[i] == settingKey)
				{
					this.Values[i] = settingValue;
				}
			}
		}
		
		/**
		* Gets the string key of the specified setting by value.
		*/
		public string GetKey(string settingValue)
		{
			int count = this.Values.Count;
			for(int i = 0; i<count; i++)
			{
				if((string)this.Values[i] == settingValue)
				{
					return this.Keys[i].ToString();
				}
			}
			return null;
		}	
		
		/**
		* Gets the string value of the specified setting by key.
		*/
		public string GetValue(string settingKey)
		{
			int count = this.Keys.Count;
			for(int i = 0; i<count; i++)
			{
				if((string)this.Keys[i] == settingKey)
				{
					return this.Values[i].ToString();
				}
			}
			return null;
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
			catch
			{
				MessageBox.Show("The setting "+settingKey+" could not be converted to int.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
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
			catch
			{
				MessageBox.Show("The setting "+settingKey+" could not be converted to bool.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return false;
			}
		}
		
		/**
		* Checks that does the settings have the specified key.
		*/
		public bool HasKey(string settingKey)
		{
			int count = this.Keys.Count;
			for(int i = 0; i<count; i++)
			{
				if((string)this.Keys[i] == settingKey) 
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		* Checks that does the settings have the specified value.
		*/
		public bool HasValue(string settingValue)
		{
			int count = this.Keys.Count;
			for(int i = 0; i<count; i++)
			{
				if((string)this.Values[i] == settingValue) 
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		* Sorts the settings by setting key.
		*/
		public void SortByKey()
		{
			int count = this.Keys.Count;
			ArrayList container = new ArrayList();
			for(int i = 0; i<count; i++)
			{
				container.Add(this.Keys[i]+"@COMBINED@"+this.Values[i]);
			}
			container.Sort();
			count = container.Count;
			for(int i = 0; i<count; i++)
			{
				string line = container[i].ToString();
				string[] chunks = Regex.Split(line, "@COMBINED@");
				this.Keys[i] = chunks[0];
				this.Values[i]= chunks[1];
			}
		}

	}

}
