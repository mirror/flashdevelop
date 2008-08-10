using System;
using System.Windows.Forms;
using System.Collections;
using System.Drawing;
using System.Resources;
using WeifenLuo.WinFormsUI;
using PluginCore.Controls;
using ScintillaNet;

namespace PluginCore
{
	public interface IPlugin
	{
		#region IPlugin Methods
		
		void Dispose();
		void HandleEvent(object sender, NotifyEvent e);
		void Initialize();
		
		#endregion
		
		#region IPlugin Properties
		
		string Name { get; }
		string Guid { get; }
		string Author { get; }
		string Help { get; }
		string Description { get; }
		IPluginHost Host { get; set; }
		DockContent Panel  { get; }
		EventType EventMask { get; }
		
		#endregion
	}
	
	public interface IPluginHost
	{
		#region IPluginHost Properties
		
		IMainForm MainForm { get; }
		
		#endregion
	}

	public interface ISettings
	{
		#region ISettings Methods
		
		int GetInt(string settingKey);
		string GetKey(string settingValue);
		string GetValue(string settingKey);
		bool GetBool(string settingKey);
		bool HasKey(string settingKey);
		bool HasValue(string settingValue);
		Keys GetShortcut(string settingKey);
		void RemoveByKey(string settingKey);
		void RemoveByValue(string settingValue);
		void AddValue(string settingKey, string settingValue);
		void InsertValue(int index, string settingKey, string settingValue);
		void ChangeValue(string settingKey, string settingValue);
		void RemoveValueAt(int index);
		void Load(string filename);
		void SortByKey();
		void Save();
		
		#endregion
		
		#region ISettings Properties
		
		ArrayList Settings { get; }
		bool UseCDATA { get; set; }
		
		#endregion
	}
	
	public interface ISettingEntry
	{
		#region ISettingEntry Properties
		
		string Key { get; set; }
		string Value { get; set; }
		
		#endregion
	}
	
	public interface ITraceEntry
	{
		#region ITraceEntry Properties
			
		string Message { get; }
		DateTime Timestamp { get; }
		int State { get; }
		
		#endregion
	}
	
	public interface ITabbedDocument
	{
		#region ITabbedDocument Properties

		string Text { get; set; }
		string FilePath { get; }
		Control.ControlCollection Controls { get; }
		ScintillaControl SciControl { get; }
		
		#endregion
		
		#region ITabbedDocument Methods

		void Activate();
		void Close();
		
		#endregion
	}
	
	public interface IMainForm
	{
		#region IMainForm Methods

		bool CurDocIsModified();
		bool CurDocIsUntitled();
		bool CallCommand(string name, string tag);
		bool InsertTextByWord(string word);
		string GetLongPathName(string file);
		string GetNewLineMarker(int eolMode);
		string ProcessArgString(string args);
		void DispatchEvent(NotifyEvent ne);
		void ChangeLanguage(string lang);
		void OpenSelectedFile(string file);
		void SaveSelectedFile(string file, string text);
		void AddTraceLogEntry(string msg, int state);
		ScintillaControl GetSciControl(DockContent document);
		DockContent CreateNewDocument(string file, string text, int codepage);
		DockContent CreateDockingPanel(Control form, string guid, Image image, DockState defaultDockState);
		DockContent[] GetDocuments();
		CommandBar GetCBMainMenu();
		CommandBar GetCBToolbar();
		CommandBarMenu GetCBMenu(string name);
		CommandBarButton GetCBButton(string name);
		CommandBarCheckBox GetCBCheckBox(string name);
		CommandBarComboBox GetCBComboBox(string name);
		ArrayList GetItemsByName(string name);
		IPlugin FindPlugin(string guid);
		Image GetSystemImage(int index);
		int GetSystemImageCount();
		
		#endregion
		
		#region IMainFrom Properties

		string CurFile { get; }
		string LocalDataPath { get; }
		ArrayList EventLog { get; }
		ArrayList IgnoredKeys { get; }
		DockPanel DockPanel { get; }
		StatusBar StatusBar { get; }
		ISettings MainSettings { get; }
		ISettings MainSnippets { get; }
		DockContent CurDocument { get; }
		ScintillaControl CurSciControl { get; }
		CommandBarManager CommandBarManager { get; }
		ResourceManager Resources { get; }
		bool HasModifiedDocuments { get; }
		bool IsClosing { get; }
		
		#endregion
	}
	
}
