using System;
using System.IO;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using WeifenLuo.WinFormsUI.Docking;
using PluginCore.Localization;
using CodeFormatter.Handlers;
using CodeFormatter.Utilities;
using ASCompletion.Context;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using ScintillaNet;
using PluginCore;

namespace CodeFormatter
{
	public class PluginMain : IPlugin
	{
		private String pluginName = "CodeFormatter";
        private String pluginGuid = "f7f1e15b-282a-4e55-ba58-5f2c02765247";
		private String pluginDesc = "Adds an MXML and ActionScript code formatter to FlashDevelop.";
        private String pluginHelp = "www.flashdevelop.org/community/";
		private String pluginAuth = "FlashDevelop Team";
		private String settingFilename;
		private Settings settingObject;

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
			get { return this.settingObject; }
		}
		
		#endregion
		
		#region Required Methods
		
		/// <summary>
		/// Initializes the plugin
		/// </summary>
		public void Initialize()
		{
			this.InitBasics();
			this.LoadSettings();
		}
		
		/// <summary>
		/// Disposes the plugin
		/// </summary>
		public void Dispose()
		{
			this.SaveSettings();
		}
		
		/// <summary>
		/// Handles the incoming events
		/// </summary>
		public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
		{
			switch (e.Type)
            {
                case EventType.Command:
                    DataEvent de = (DataEvent)e;
                    if (de.Action == "CodeRefactor.Menu")
                    {
                        ToolStripMenuItem refactorMenu = (ToolStripMenuItem)de.Data;
                        this.CreateMenuItem(refactorMenu);
                    }
                    break;
            }
		}
		
		#endregion

		#region Custom Methods
		
		/// <summary>
		/// Initializes important variables
		/// </summary>
		public void InitBasics()
		{
            EventManager.AddEventHandler(this, EventType.Command);
            String dataPath = Path.Combine(PathHelper.DataDir, "CodeFormatter");
			if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
			this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            this.pluginDesc = TextHelper.GetString("Info.Description");
		}

		/// <summary>
		/// Creates a menu item for the plugin
		/// </summary>
		public void CreateMenuItem(ToolStripMenuItem refactorMenu)
		{
            String label = TextHelper.GetString("Label.CodeFormatter");
            ToolStripMenuItem menuItem = new ToolStripMenuItem(label, null, new EventHandler(this.Format), Keys.Control | Keys.Shift | Keys.D2);
            PluginBase.MainForm.RegisterShortcutItem("RefactorMenu.CodeFormatter", menuItem);
            refactorMenu.DropDownItems.Insert(7, menuItem);
		}

		/// <summary>
		/// Loads the plugin settings
		/// </summary>
		public void LoadSettings()
		{
			this.settingObject = new Settings();
			if (!File.Exists(this.settingFilename)) 
            {
				this.settingObject.InitializeDefaultPreferences();
				this.SaveSettings();
			}
			else
			{
				Object obj = ObjectSerializer.Deserialize(this.settingFilename, this.settingObject);
				this.settingObject = (Settings)obj;
			}
		}

		/// <summary>
		/// Saves the plugin settings
		/// </summary>
		public void SaveSettings()
		{
			ObjectSerializer.Serialize(this.settingFilename, this.settingObject);
        }

        #endregion

        #region Code Format

        private const int TYPE_AS3PURE = 0;
		private const int TYPE_MXML = 1;
		private const int TYPE_XML = 2;
		private const int TYPE_UNKNOWN = 3;
		
		/// <summary>
		/// 
		/// </summary>
		public void Format(Object sender, System.EventArgs e)
		{
			ITabbedDocument doc = PluginBase.MainForm.CurrentDocument;
			if (doc.IsEditable)
			{
				doc.SciControl.BeginUndoAction();
				Int32 oldPos = CurrentPos;
				String source = doc.SciControl.Text;
				switch (DocumentType)
                {
					case TYPE_AS3PURE:
						ASPrettyPrinter asPrinter = new ASPrettyPrinter(true, source);
                        FormatUtility.ConfigureASPrinter(asPrinter, this.settingObject, PluginBase.Settings.TabWidth);
						String asResultData = asPrinter.Print(0);
						if (asResultData == null)
						{
                            TraceManager.Add(TextHelper.GetString("Info.CouldNotFormat"), -3);
							PluginBase.MainForm.CallCommand("PluginCommand", "ResultsPanel.ShowResults");
						}
						else doc.SciControl.Text = asResultData;
						break;

					case TYPE_MXML:
					case TYPE_XML:
						MXMLPrettyPrinter mxmlPrinter = new MXMLPrettyPrinter(source);
                        FormatUtility.ConfigureMXMLPrinter(mxmlPrinter, this.settingObject, PluginBase.Settings.TabWidth);
						String mxmlResultData = mxmlPrinter.Print(0);
						if (mxmlResultData == null)
						{
                            TraceManager.Add(TextHelper.GetString("Info.CouldNotFormat"), -3);
							PluginBase.MainForm.CallCommand("PluginCommand", "ResultsPanel.ShowResults");
						}
						else doc.SciControl.Text = mxmlResultData;
						break;
				}
				CurrentPos = oldPos;
				doc.SciControl.EndUndoAction();
			}
		}

        /// <summary>
        /// 
        /// </summary>
		public int CurrentPos
		{
			get
			{
				ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
                String compressedText = CompressText(sci.Text.Substring(0, sci.CurrentPos));
				return compressedText.Length;
			}
			set 
            {
                Boolean found = false;
                ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
                String documentText = sci.Text;
                Int32 low = 0; Int32 midpoint = 0;
                Int32 high = documentText.Length - 1;
				while (low < high)
				{
					midpoint = (low + high) / 2;
                    String compressedText = CompressText(documentText.Substring(0, midpoint));
					if (value == compressedText.Length)
					{
						found = true;
						sci.SetSel(midpoint, midpoint);
						break;
					}
					else if (value < compressedText.Length) high = midpoint - 1;
					else low = midpoint + 1;
				}
				if (!found) 
                {
					sci.SetSel(documentText.Length, documentText.Length);
				}
			}
		}

        /// <summary>
        /// 
        /// </summary>
		public Int32 DocumentType
        {
			get 
            {
				ITabbedDocument document = PluginBase.MainForm.CurrentDocument;
				if (!document.IsEditable) return TYPE_UNKNOWN;
				if (ASContext.Context.CurrentModel.Context != null && ASContext.Context.CurrentModel.Context.GetType().ToString().Equals("AS3Context.Context")) 
                {
					if (GetFileExtension(document.FileName).Equals("as")) return TYPE_AS3PURE;
					else if(GetFileExtension(document.FileName).Equals("mxml")) return TYPE_MXML;
				}
				if (GetFileExtension(document.FileName).Equals("xml")) return TYPE_XML;
				return TYPE_UNKNOWN;
			}
		}

        /// <summary>
        /// 
        /// </summary>
        public String CompressText(String originalText)
        {
            String compressedText = originalText.Replace(" ", "");
            compressedText = compressedText.Replace("\t", "");
            compressedText = compressedText.Replace("\n", "");
            compressedText = compressedText.Replace("\r", "");
            return compressedText;
        }

        /// <summary>
        /// 
        /// </summary>
		public String GetFileExtension(String filename) 
        {
            String extension = "";
            Int32 lastDot = filename.LastIndexOf('.');
			if (lastDot >= 0) extension = filename.Substring(lastDot + 1).ToLower();
			return extension;
		}

        /// <summary>
        /// 
        /// </summary>
        public bool IsBlankChar(Char ch)
        {
            return (ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r');
        }

		#endregion

	}
	
}