using System;
using System.IO;
using System.Xml;
using System.Text;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using System.Xml.Serialization;
using PluginCore.Localization;
using PluginCore.Managers;
using PluginCore.Utilities;
using PluginCore.Helpers;
using PluginCore;

namespace DataEncoder
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "DataEncoder";
        private String pluginGuid = "ca182923-bcdc-46bf-905c-aaa0bf64eebd";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "Converts the file data for specific files to view them properly in FlashDevelop.";
        private String pluginAuth = "FlashDevelop Team";
        private List<TypeData> objectTypes = new List<TypeData>();

	    #region Required Properties

        /// <summary>
        /// Name of the plugin
        /// </summary> 
        public String Name
		{
			get { return this.pluginName; }
		}

        /// <summary>
        /// GUID of the plugin
        /// </summary>
        public String Guid
		{
			get { return this.pluginGuid; }
		}

        /// <summary>
        /// Author of the plugin
        /// </summary> 
        public String Author
		{
			get { return this.pluginAuth; }
		}

        /// <summary>
        /// Description of the plugin
        /// </summary> 
        public String Description
		{
			get { return this.pluginDesc; }
		}

        /// <summary>
        /// Web address for help
        /// </summary> 
        public String Help
		{
			get { return this.pluginHelp; }
		}

        /// <summary>
        /// Object that contains the settings
        /// </summary>
        [Browsable(false)]
        public Object Settings
        {
            get { return null; }
        }
		
		#endregion
		
		#region Required Methods
		
		/// <summary>
		/// Initializes the plugin
		/// </summary>
		public void Initialize()
		{
            this.AddEventHandlers();
            this.pluginDesc = TextHelper.GetString("Info.Description");
        }
		
		/// <summary>
		/// Disposes the plugin
		/// </summary>
		public void Dispose()
		{
            // Nothing here..
		}
		
		/// <summary>
		/// Handles the incoming events
		/// </summary>
		public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
		{
            switch (e.Type)
            {
                case EventType.FileEncode :
                    DataEvent fe = (DataEvent)e;
                    if (Path.GetExtension(fe.Action) == ".fdb" || Path.GetExtension(fe.Action) == ".fda")
                    {
                        this.SaveBinaryFile(fe.Action, fe.Data as String);
                        fe.Handled = true;
                    }
                    break;

                case EventType.FileDecode:
                    DataEvent fd = (DataEvent)e;
                    if (Path.GetExtension(fd.Action) == ".fdb" || Path.GetExtension(fd.Action) == ".fda")
                    {
                        String text = this.LoadBinaryFile(fd.Action);
                        if (text != null)
                        {
                            fd.Data = text;
                            fd.Handled = true;
                        }
                    }
                    break;

                case EventType.FileSaving:
                    TextEvent te = (TextEvent)e;
                    if (this.IsFileOpen(te.Value))
                    {
                        if (!this.IsXmlSaveable(te.Value))
                        {
                            te.Handled = true;
                        }
                    }
                    break;
            }
		}
		
		#endregion

        #region Custom Methods

        /**
        * Information messages.
        */
        private readonly String CANT_SAVE_FILE = TextHelper.GetString("Info.CantSaveFile");

        /// <summary>
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            EventManager.AddEventHandler(this, EventType.FileSaving);
            EventManager.AddEventHandler(this, EventType.FileEncode);
            EventManager.AddEventHandler(this, EventType.FileDecode);
        }

        /// <summary>
        /// Loads the serialized binary file
        /// </summary>
        public String LoadBinaryFile(String file)
        {
            try
            {
                Object settings = new Object();
                MemoryStream stream = new MemoryStream();
                settings = ObjectSerializer.Deserialize(file, settings);
                XmlSerializer xs = new XmlSerializer(settings.GetType());
                xs.Serialize(stream, settings);
                XmlTextWriter xw = new XmlTextWriter(stream, Encoding.UTF8);
                xw.Formatting = Formatting.Indented; stream.Close();
                this.objectTypes.Add(new TypeData(file, settings.GetType()));
                return Encoding.UTF8.GetString(stream.ToArray());
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return null;
            }
        }

        /// <summary>
        /// Saves the serialized binary file
        /// </summary>
        public void SaveBinaryFile(String file, String text)
        {
            try
            {
                Object settings = new Object();
                Byte[] buffer = Encoding.UTF8.GetBytes(text);
                MemoryStream stream = new MemoryStream(buffer);
                TypeData typeData = this.GetFileObjectType(file);
                XmlSerializer xs = new XmlSerializer(typeData.Type);
                settings = xs.Deserialize(stream);
                ObjectSerializer.ForcedSerialize(file, settings);
                stream.Close();
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Checks if the syntax is ok to save
        /// </summary>
        private Boolean IsXmlSaveable(String file)
        {
            foreach (ITabbedDocument document in PluginBase.MainForm.Documents)
            {
                if (document.IsEditable && document.FileName == file)
                {
                    try
                    {
                        XmlDocument xmlDoc = new XmlDocument();
                        xmlDoc.LoadXml(document.SciControl.Text);
                        return true;
                    }
                    catch (Exception ex)
                    {
                        ErrorManager.ShowWarning(CANT_SAVE_FILE, ex);
                        return false;
                    }
                }
            }
            return false;
        }

        /// <summary>
        /// Checks if a file is open already
        /// </summary>
        /// <returns></returns>
        private Boolean IsFileOpen(String file)
        {
            foreach (TypeData objType in this.objectTypes)
            {
                if (file == objType.File) return true;
            }
            return false;
        }

        /// <summary>
        /// Gets the file type for file
        /// </summary>
        public TypeData GetFileObjectType(String file)
        {
            foreach (TypeData objType in this.objectTypes)
            {
                if (file == objType.File) return objType;
            }
            return null;
        }

		#endregion

	}

    #region Structures

    public class TypeData
    {
        public Type Type;
        public String File;

        public TypeData(String file, Type type)
        {
            this.File = file;
            this.Type = type;
        }
    }

    #endregion

}
