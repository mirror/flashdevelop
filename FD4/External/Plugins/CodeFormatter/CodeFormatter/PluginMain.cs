using System;
using System.IO;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using WeifenLuo.WinFormsUI.Docking;
using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore;
using ASCompletion.Context;

using CodeFormatter.Handlers;
using CodeFormatter.Utilities;

namespace CodeFormatter
{
	public class PluginMain : IPlugin
	{
		private String pluginName = "CodeFormatter";
		private String pluginGuid = "1f387faz-421b-42ac-a985-72a03534f731";
		private String pluginHelp = "www.flashdevelop.org/community/";
		private String pluginDesc = "MXML and AS3 coder formatter for FlashDevelop 3. Port of FlexFormatter by Ernest Pasour";
		private String pluginAuth = "FlashDevelop Team";
		private String settingFilename;
		private Settings settingObject;
		private Image pluginImage;

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
			this.AddEventHandlers();
			this.CreateMenuItem();
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
			
		}
		
		#endregion

		#region Custom Methods
		
		/// <summary>
		/// Initializes important variables
		/// </summary>
		public void InitBasics()
		{
			String dataPath = Path.Combine(PathHelper.DataDir, "CodeFormatter");
			if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
			this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
			this.pluginImage = PluginBase.MainForm.FindImage("100");
		}

		/// <summary>
		/// Adds the required event handlers
		/// </summary>
		public void AddEventHandlers()
		{
			EventManager.AddEventHandler(this, EventType.FileSwitch | EventType.Command);
		}

		/// <summary>
		/// Creates a menu item for the plugin and adds a ignored key
		/// </summary>
		public void CreateMenuItem()
		{
			ToolStripMenuItem editMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("EditMenu");
			editMenu.DropDownItems.Add(new ToolStripSeparator());
			editMenu.DropDownItems.Add(new ToolStripMenuItem("Format Code", this.pluginImage, new EventHandler(this.Format), this.settingObject.Shortcut));
			PluginBase.MainForm.IgnoredKeys.Add(this.settingObject.Shortcut);
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
		
		private const int TYPE_AS3PURE = 0;
		private const int TYPE_MXML = 1;
		private const int TYPE_XML = 2;
		private const int TYPE_UNKNOWN = 3;
		
		/// <summary>
		/// Opens the plugin panel if closed
		/// </summary>
		public void Format(Object sender, System.EventArgs e)
		{
			ITabbedDocument doc = PluginBase.MainForm.CurrentDocument;
			
			if (doc.IsEditable )
			{
				doc.SciControl.BeginUndoAction();
				int oldPos = CurrentPos;
				String source = doc.SciControl.Text;
				DateTime startTime = DateTime.Now;
				switch(DocumentType) 
                {
					case TYPE_AS3PURE:
						ASPrettyPrinter asPrinter=new ASPrettyPrinter(true, source);
						FormatUtility.ConfigureASPrinter(asPrinter, settingObject, 4);
						String asResultData=asPrinter.Print(0);
						if (asResultData==null)
						{
							TraceItem item = new TraceItem("Syntax errors. Could not format code.", -3);
							TraceManager.Add(item);
							PluginBase.MainForm.CallCommand("PluginCommand", "ResultsPanel.ShowResults");
						}
						else doc.SciControl.Text = asResultData;
						break;

					case TYPE_MXML:
					case TYPE_XML:
						MXMLPrettyPrinter mxmlPrinter = new MXMLPrettyPrinter(source);
						FormatUtility.ConfigureMXMLPrinter(mxmlPrinter, settingObject, 4);
						String mxmlResultData=mxmlPrinter.Print(0);
						if (mxmlResultData==null)
						{
							TraceItem item = new TraceItem("Syntax errors. Could not format code.", -3);
							TraceManager.Add(item);
							PluginBase.MainForm.CallCommand("PluginCommand", "ResultsPanel.ShowResults");
						}
						else doc.SciControl.Text = mxmlResultData;
						break;
				}
				CurrentPos = oldPos;
				doc.SciControl.EndUndoAction();
			}
		}
		
		public int CurrentPos
		{
			get
			{
				DateTime startTime = DateTime.Now;
				ScintillaNet.ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
                String compressedText = CompressText(sci.Text.Substring(0, sci.CurrentPos));
				DateTime stopTime = DateTime.Now;
				TimeSpan duration = stopTime - startTime;
				return compressedText.Length;
			}
			set 
            {
				DateTime startTime = DateTime.Now;
				ScintillaNet.ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
                String documentText = sci.Text;
				bool found = false;
				int low = 0;
				int high = documentText.Length - 1;
				int midpoint = 0;
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

        public String CompressText(String originalText) 
        {
            String compressedText = originalText.Replace(" ", "");
			compressedText = compressedText.Replace("\t", "");
			compressedText = compressedText.Replace("\n", "");
			compressedText = compressedText.Replace("\r", "");
			return compressedText;
		}
		
		public bool IsBlankChar(Char ch) 
        {
			return (ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r');
		}
		
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
		
		public String GetFileExtension(String filename) 
        {
            String extension = "";
            Int32 lastDot = filename.LastIndexOf('.');
			if (lastDot >= 0) extension=filename.Substring(lastDot+1).ToLower();
			return extension;
		}

		#endregion

	}
	
}