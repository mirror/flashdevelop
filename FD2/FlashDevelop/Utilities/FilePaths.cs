using System;
using System.IO;

namespace FlashDevelop.Utilities
{
	public class FilePaths
	{
		public static string Images;
		public static string AppPath;
		public static string DataDir;
		public static string ToolBar;
		public static string MainMenu;
		public static string PluginDir;
		public static string ToolsDir;
		public static string SettingDir;
		public static string Scintilla;
		public static string ScintillaMenu;
		public static string Settings;
		public static string Documents;
		public static string LayoutInfo;
		public static string Snippets;
		public static string TabMenu;
		
		/**
		* Initializes the filepaths
		*/
		public static void Initialize(string path)
		{
			string sep = Path.DirectorySeparatorChar.ToString();
			DataDir = path+sep+"Data"+sep;
			PluginDir = path+sep+"Plugins"+sep;
			SettingDir = path+sep+"Settings"+sep;
			ToolsDir = path+sep+"Tools"+sep;
			Images = SettingDir+"Images.png";
			ToolBar = SettingDir+"ToolBar.xml";
			MainMenu = SettingDir+"MainMenu.xml";
			Documents = SettingDir+"ReopenDocs.xml";
			Snippets = SettingDir+"Snippets.xml";
			Scintilla = SettingDir+"ScintillaNet.xml";
			ScintillaMenu = SettingDir+"ScintillaMenu.xml";
			Settings = SettingDir+"Settings.xml";
			LayoutInfo = SettingDir+"LayoutInfo.xml";
			TabMenu = SettingDir+"TabMenu.xml";
			AppPath = path;
		}
		
	}
	
}
