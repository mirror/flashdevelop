/*
 * Autocompletion context manager
 */

using System;
using System.Windows.Forms;
using System.Collections;
using System.Collections.Specialized;
using System.IO;
using System.Text.RegularExpressions;
using PluginCore;
using PluginCore.Controls;

namespace ASCompletion
{
	public class ASContext: IASContext
	{
		static readonly private string SETTING_CLASSPATH = "ASCompletion.ClassPath";
		static readonly private string SETTING_DEFAULT_METHOD_RETURN_TYPE = "ASCompletion.DefaultMethodReturnType";
		static readonly private string SETTING_ENABLE_HELPERS = "ASCompletion.EnableSmartHelpers";
		static readonly private string SETTING_ENABLE_AUTOIMPORT = "ASCompletion.Generate.AutoImports";
		static readonly private string SETTING_ALWAYS_SHOW_INTRINSIC_MEMBERS = "ASCompletion.IntrinsicMembers.AlwaysShow";
		static readonly private string SETTING_HIDE_INTRINSIC_MEMBERS = "ASCompletion.IntrinsicMembers.Hide";
		static readonly private string SETTING_DOCUMENTATION_COMPLETION = "ASCompletion.Documentation.EnableCompletion";
		static readonly private string SETTING_DOCUMENTATION_TAGS = "ASCompletion.Documentation.EnableTags";
		static readonly private string SETTING_DOCUMENTATION_COMMAND = "ASCompletion.Documentation.HelpCommand";
		static readonly private string SETTING_DOCUMENTATION_TIPS = "ASCompletion.Documentation.EnhancedTips";
		static readonly private string SETTING_DOCUMENTATION_TIPLINES = "ASCompletion.Documentation.TipsDescriptionMaxLines";
		static readonly private string SETTING_DOCUMENTATION_DESCRIPTION = "ASCompletion.Documentation.TipDescription";
		static readonly private string DEFAULT_HELP_COMMAND = "http://www.google.com/search?q=allintitle:@CLASSPACKAGE+@CLASSNAME+@MEMBERNAME+site:macromedia.com";
		static readonly private string SETTING_MTASC_PATH = "ASCompletion.MTASC.Path";
		static readonly private string SETTING_MTASC_USECLASSES = "ASCompletion.MTASC.UseStdClasses";
		static readonly private string SETTING_MTASC_CHECKONSAVE = "ASCompletion.MTASC.CheckOnSave";
		static readonly private string SETTING_MTASC_RUNAFTERBUILD = "ASCompletion.MTASC.RunAfterBuild";
		static readonly private string SETTING_MTASC_CHECKPARAMS = "ASCompletion.MTASC.CheckParameters";
		static readonly private string DEFAULT_MTASC_PATH = "\\Tools\\mtasc\\";
		static readonly private string DEFAULT_LIBRARY_PATH = "\\Library\\";
		static readonly private string SETTING_FLASH_VERSION = "ASCompletion.Flash.Version";
		static readonly private string SETTING_MM_CLASSES = "ASCompletion.Macromedia.ClassPath";
		static readonly private string SETTING_MM_HOTBUILD = "ASCompletion.Macromedia.TestOnCtrlEnter";
		static readonly private string[] MACROMEDIA_VERSIONS = {"Macromedia\\Flash 8\\", "Macromedia\\Flash MX 2004\\"};
		static readonly private string STATUS_MTASC_RUNNING = "MTASC Running...";
		static readonly private string STATUS_MTASC_DONE = "MTASC Done";
		// context
		static private StringCollection classPath;
		static private ListDictionary classes;
		static private string cFile = "";
		static private PluginMain plugin;
		static private ASClass cClass;
		static private ASClass topLevel;
		static private string lastClassWarning;
		// path normalization
		static private bool doPathNormalization;
		static private string dirSeparator;
		static private char dirSeparatorChar;
		static private string dirAltSeparator;
		static private char dirAltSeparatorChar;
		// settings
		static private string MMClassPath;
		static public bool MMHotBuild;
		static private string userClassPath;
		static private string externalClassPath = "";
		static private string temporaryPath;
		static public string TopLevelClassPath;
		static private string mtascRootFolder;
		static private bool useMtascClasses;
		static public bool CheckOnSave;
		static public string defaultMethodReturnType;
		static public bool HelpersEnabled;
		static public bool AutoImportsEnabled;
		static public int HoverTipDelay;
		static public bool CompletionListFilter;
		static public int CompletionListDelay;
		static public bool AlwaysShowIntrinsicMembers;
		static public bool HideIntrinsicMembers;
		static public bool DocumentationCompletionEnabled;
		static public string DocumentationTags;
		static public string HelpCommandPattern;
		static public bool DocumentationInTips;
		static public bool DescriptionInTips;
		static public int TipsDescriptionMaxLines;
		// Checking / Quick Build
		static public int flashVersion;
		static private bool runAfterBuild;
		static private string builtSWF;
		static private string builtSWFSize;
		static private bool trustFileWanted;
		// Watchers
		static private Hashtable Watchers;
		static private int WatchersLock;
		
		#region regular_expressions_definitions
		static readonly private Regex re_MtascBuildCommand = 
			new Regex("^[\\s*/]*@mtasc[\\s]+(?<params>.*)$", RegexOptions.Compiled | RegexOptions.Multiline);
		static readonly public Regex re_SplitParams = 
			new Regex("[\\s](?<switch>\\-[a-z]+)", RegexOptions.Compiled | RegexOptions.Singleline | RegexOptions.IgnoreCase);
		#endregion
		
		#region public_properties
		static public IMainForm MainForm 
		{
			get {
				return plugin.MainForm;
			}
		}
		
		static public PluginUI Panel 
		{
			get {
				return plugin.PluginUI;
			}
		}
		
		static public ASClass CurrentClass 
		{
			get {
				if (cClass == null)
				{
					cClass = new ASClass();
					cClass.OutOfDate = true;
				}
				// update class
				if (cClass.OutOfDate)
				{
					DebugConsole.Trace("Current class is out of date "+cFile);
					if ((cFile != null) && (cFile.Length > 0))
					{
						cClass.FileName = cFile;
						string prevClassName = cClass.ClassName;
						UpdateCurrentClass();
						if (Panel != null)
						{
							if (cClass.IsVoid() || (cClass.ClassName != prevClassName))
								Panel.RemoveFromView(cFile);
							if (cClass.IsVoid()) Panel.AddInView(cFile);
							else Panel.UpdateView(cClass);
						}
						// coloring syntax
						if (DetectSyntax()) return cClass;
					}
					// update "this" and "super" special vars
					UpdateTopLevelElements();
				}
				return cClass;
			}
			set {
				cClass = value;
				// coloring syntax
				if (DetectSyntax()) return;
				// update "this" and "super" special vars
				UpdateTopLevelElements();
			}
		}
		static private bool DetectSyntax()
		{
			// language syntax
			ScintillaNet.ScintillaControl sci = MainForm.CurSciControl;
			if (sci != null)
			{
				if (cClass.IsAS3) {
					if (sci.ConfigurationLanguage == "as2") {
						MainForm.ChangeLanguage("as3");
						return true;
					}
				}
				else if (sci.ConfigurationLanguage == "as3") {
					MainForm.ChangeLanguage("as2");
					return true;
				}
			}			
			return false;
		}
		
		/// <summary>
		/// Currently edited class. On set, synchronise CurrentClass. 
		/// </summary>
		static public string CurrentFile 
		{
			get {
				return cFile;
			}
			set {
				DebugConsole.Trace("Set '"+value+"'");
				// non-AS file
				if (value == "")
				{
					cFile = "";
					cClass = new ASClass();
					cClass.FileName = MainForm.GetLongPathName(MainForm.CurFile);
				}
				// AS file
				else
				{
					string nFile = value;
					if (doPathNormalization)
						nFile = nFile.Replace(dirAltSeparator, dirSeparator);
					nFile = MainForm.GetLongPathName(nFile);
					if (cFile != nFile)
					{
						cFile = nFile;
						CurrentClass = FindClassFromFile(nFile);
					}
				}
				if (Panel != null)
					Panel.UpdateAndActive(CurrentClass);
			}
		}
		
		/// <summary>
		/// Check if the current file is a valid AS2 class
		/// without parsing the file again.
		/// </summary>
		static public bool IsClassValid()
		{
			return ((cClass != null) && !cClass.IsVoid());
		}
		
		/// <summary>
		/// MTASC's Actionscript built-in elements
		/// </summary>
		static public ASClass TopLevel
		{
			get {
				return topLevel;
			}
		}
		
		/// <summary>
		/// Add additional classpathes
		/// </summary>
		static public string ExternalClassPath {
			get {
				return externalClassPath;
			}
			set {
				externalClassPath = value;
				BuildClassPath();
			}
		}
		
		#endregion
		
		#region context_management
		/// <summary>
		/// Create default context
		/// </summary>
		/// <param name="mainForm">Reference to MainForm</param>
		static public void Init(PluginMain pluginMain)
		{
			ASContext.plugin = pluginMain;
			
			// default method return type
			if (!MainForm.MainSettings.HasKey(SETTING_DEFAULT_METHOD_RETURN_TYPE))
				MainForm.MainSettings.AddValue(SETTING_DEFAULT_METHOD_RETURN_TYPE, "Object");
			// helpers enabled
			if (!MainForm.MainSettings.HasKey(SETTING_ENABLE_HELPERS))
				MainForm.MainSettings.AddValue(SETTING_ENABLE_HELPERS, "true");			
			if (!MainForm.MainSettings.HasKey(SETTING_ENABLE_AUTOIMPORT))
				MainForm.MainSettings.AddValue(SETTING_ENABLE_AUTOIMPORT, "true");
			
			// mtasc
			if (!MainForm.MainSettings.HasKey(SETTING_MTASC_PATH))
				MainForm.MainSettings.AddValue(SETTING_MTASC_PATH, 
					System.IO.Path.GetDirectoryName(Application.ExecutablePath)+DEFAULT_MTASC_PATH);
			if (!MainForm.MainSettings.HasKey(SETTING_MTASC_USECLASSES))
				MainForm.MainSettings.AddValue(SETTING_MTASC_USECLASSES, "true");
			if (!MainForm.MainSettings.HasKey(SETTING_MTASC_CHECKONSAVE))
				MainForm.MainSettings.AddValue(SETTING_MTASC_CHECKONSAVE, "false");
			if (!MainForm.MainSettings.HasKey(SETTING_MTASC_RUNAFTERBUILD))
				MainForm.MainSettings.AddValue(SETTING_MTASC_RUNAFTERBUILD, "true");
			if (!MainForm.MainSettings.HasKey(SETTING_MTASC_CHECKPARAMS))
				MainForm.MainSettings.AddValue(SETTING_MTASC_CHECKPARAMS, "-mx");
			
			// completion options
			if (!MainForm.MainSettings.HasKey(SETTING_ALWAYS_SHOW_INTRINSIC_MEMBERS))
				MainForm.MainSettings.AddValue(SETTING_ALWAYS_SHOW_INTRINSIC_MEMBERS, "false");
			if (!MainForm.MainSettings.HasKey(SETTING_HIDE_INTRINSIC_MEMBERS))
				MainForm.MainSettings.AddValue(SETTING_HIDE_INTRINSIC_MEMBERS, "false");
			if (!MainForm.MainSettings.HasKey(SETTING_FLASH_VERSION))
				MainForm.MainSettings.AddValue(SETTING_FLASH_VERSION, "8");
			
			// documentation
			if (!MainForm.MainSettings.HasKey(SETTING_DOCUMENTATION_COMPLETION))
				MainForm.MainSettings.AddValue(SETTING_DOCUMENTATION_COMPLETION, "true");
			if (!MainForm.MainSettings.HasKey(SETTING_DOCUMENTATION_TAGS))
				MainForm.MainSettings.AddValue(SETTING_DOCUMENTATION_TAGS, ASDocumentation.DEFAULT_DOC_TAGS);
			if (!MainForm.MainSettings.HasKey(SETTING_DOCUMENTATION_COMMAND))
				MainForm.MainSettings.AddValue(SETTING_DOCUMENTATION_COMMAND, DEFAULT_HELP_COMMAND);
			if (!MainForm.MainSettings.HasKey(SETTING_DOCUMENTATION_TIPS))
				MainForm.MainSettings.AddValue(SETTING_DOCUMENTATION_TIPS, "true");
			if (!MainForm.MainSettings.HasKey(SETTING_DOCUMENTATION_TIPLINES))
				MainForm.MainSettings.AddValue(SETTING_DOCUMENTATION_TIPLINES, "4");
			if (!MainForm.MainSettings.HasKey(SETTING_DOCUMENTATION_DESCRIPTION))
				MainForm.MainSettings.AddValue(SETTING_DOCUMENTATION_DESCRIPTION, "true");
			
			// debugging enabled?
			DebugConsole.CheckSettings();
			
			// Macromedia classes folder lookup
			string cp = "";
			if (!MainForm.MainSettings.HasKey(SETTING_MM_CLASSES))
			{
				bool found = false;
				string deflang = System.Globalization.CultureInfo.CurrentUICulture.Name;
				deflang = deflang.Substring(0,2);
				string localAppData = "%USERPROFILE%\\Local Settings\\Application Data\\";
					//Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
				string expandAppData = Environment.ExpandEnvironmentVariables(localAppData);
				foreach(string path in MACROMEDIA_VERSIONS)
				{
					cp = expandAppData + path;
					// default language
					if (System.IO.Directory.Exists(cp+deflang+"\\Configuration\\Classes\\"))
					{
						cp += deflang+"\\Configuration\\Classes\\";
						found = true;
					}
					// look for other languages
					else if (System.IO.Directory.Exists(cp))
					{
						string[] dirs = System.IO.Directory.GetDirectories(cp);
						foreach(string dir in dirs)
						{
							if (System.IO.Directory.Exists(dir+"\\Configuration\\Classes\\"))
							{
								cp = dir+"\\Configuration\\Classes\\";
								found = true;
							}
							else if (System.IO.Directory.Exists(dir+"\\First Run\\Classes\\"))
							{
								cp = dir+"\\First Run\\Classes\\";
								found = true;
							}
						}
					}
					if (found) break;
				}
				if (!found) cp = "";
				else cp = cp.Replace(expandAppData, localAppData);
				MainForm.MainSettings.AddValue(SETTING_MM_CLASSES, cp);
			}
			if (!MainForm.MainSettings.HasKey(SETTING_MM_HOTBUILD))
				MainForm.MainSettings.AddValue(SETTING_MM_HOTBUILD, "true");
			
			// default classpath
			if (!MainForm.MainSettings.HasKey(SETTING_CLASSPATH))
			{
				// library folder
				string libraryPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath)+DEFAULT_LIBRARY_PATH;
				if (System.IO.Directory.Exists(libraryPath))
				{
					if (cp.Length > 0) cp += ";";
					cp += libraryPath;
				}
				MainForm.MainSettings.AddValue(SETTING_CLASSPATH, cp);
			}
			
			// init
			ASClassParser.Context = new ASContext();
			dirSeparatorChar = System.IO.Path.DirectorySeparatorChar;
			dirSeparator = dirSeparatorChar.ToString();
			dirAltSeparatorChar = System.IO.Path.AltDirectorySeparatorChar;
			dirAltSeparator = dirAltSeparatorChar.ToString();
			doPathNormalization = dirSeparator != dirAltSeparator;
			UpdateSettings();
		}
		
		/// <summary>
		/// Application settings have been updated.
		/// </summary>
		static public void UpdateSettings()
		{
			DebugConsole.Trace("REFRESH SETTINGS");
			// old settings
			int _flashVersion = flashVersion;
			string _MMClassPath = MMClassPath;
			bool _useMtascClasses = useMtascClasses;
			string _userClassPath = userClassPath;
			
			// new settings
			DebugConsole.SettingsChanged();
			defaultMethodReturnType = MainForm.MainSettings.GetValue(SETTING_DEFAULT_METHOD_RETURN_TYPE);
			HelpersEnabled = MainForm.MainSettings.GetBool(SETTING_ENABLE_HELPERS);
			AutoImportsEnabled = MainForm.MainSettings.GetBool(SETTING_ENABLE_AUTOIMPORT);
			AlwaysShowIntrinsicMembers = MainForm.MainSettings.GetBool(SETTING_ALWAYS_SHOW_INTRINSIC_MEMBERS);
			HideIntrinsicMembers = MainForm.MainSettings.GetBool(SETTING_HIDE_INTRINSIC_MEMBERS);
			DocumentationCompletionEnabled = MainForm.MainSettings.GetBool(SETTING_DOCUMENTATION_COMPLETION);
			DocumentationTags = MainForm.MainSettings.GetValue(SETTING_DOCUMENTATION_TAGS);
			HelpCommandPattern = MainForm.MainSettings.GetValue(SETTING_DOCUMENTATION_COMMAND);
			DocumentationInTips = MainForm.MainSettings.GetBool(SETTING_DOCUMENTATION_TIPS);
			TipsDescriptionMaxLines = MainForm.MainSettings.GetInt(SETTING_DOCUMENTATION_TIPLINES);
			DescriptionInTips = MainForm.MainSettings.GetBool(SETTING_DOCUMENTATION_DESCRIPTION);
			
			// flash version
			flashVersion = MainForm.MainSettings.GetInt(SETTING_FLASH_VERSION);
			if (flashVersion < 6)
			{
				flashVersion = 7;
				ErrorHandler.ShowInfo("Settings Error: Flash version is not valid.");
			}
			
			// Pathes
			userClassPath = MainForm.MainSettings.GetValue(SETTING_CLASSPATH);
			MMClassPath = NormalizePath( Environment.ExpandEnvironmentVariables(MainForm.MainSettings.GetValue(SETTING_MM_CLASSES)) );
			MMHotBuild = MainForm.MainSettings.GetBool(SETTING_MM_HOTBUILD);
			
			// MTASC
			useMtascClasses = MainForm.MainSettings.GetBool(SETTING_MTASC_USECLASSES);
			mtascRootFolder = NormalizePath( MainForm.MainSettings.GetValue(SETTING_MTASC_PATH) );
			CheckOnSave = MainForm.MainSettings.GetBool(SETTING_MTASC_CHECKONSAVE);
			runAfterBuild = MainForm.MainSettings.GetBool(SETTING_MTASC_RUNAFTERBUILD);
			
			// UI settings
			Panel.UpdateSettings();
			
			// do we need to update the completion engine?
			if ((_flashVersion == flashVersion) && (_useMtascClasses == useMtascClasses)
			     && (_MMClassPath == MMClassPath) && (_userClassPath == userClassPath))
				return;
			
			// update
			BuildClassPath();
		}
		
		/// <summary>
		/// Classpathes & classes cache initialisation
		/// </summary>
		static public void BuildClassPath()
		{
			DebugConsole.Trace("REFRESH PATHES");
			WatchersLock++;
			
			// external version definition
			string exPath = externalClassPath;
			if (exPath.Length > 0)
			{
				int p = exPath.IndexOf(';');
				if (p >= 0) 
				{
					try {
						flashVersion = Convert.ToInt16(exPath.Substring(0, p));
					}
					catch {
						flashVersion = 8;
					}
					exPath = exPath.Substring(p+1).Trim();
				}
				else exPath = exPath;
			}
			
			// class pathes
			classPath = new StringCollection();
			if (!System.IO.Directory.Exists(mtascRootFolder))
			{
				mtascRootFolder = "";
			}
			else if (useMtascClasses || (MMClassPath.Length == 0))
			{
				try 
				{
					if ((flashVersion >= 8) && System.IO.Directory.Exists(mtascRootFolder+"std8"))
						AddPath(mtascRootFolder+"std8");
					if (System.IO.Directory.Exists(mtascRootFolder+"std"))
					{
						AddPath(mtascRootFolder+"std");
						TopLevelClassPath = mtascRootFolder+"std";
					}
				}
				catch {}
			}
			// if we use MM classes
			if ((classPath.Count == 0) && (MMClassPath.Length != 0))
			{
				if (System.IO.Directory.Exists(MMClassPath+"FP"+flashVersion)) 
					AddPath(MMClassPath+"FP"+flashVersion);
				else
					AddPath(MMClassPath);
				TopLevelClassPath = MMClassPath;
			}
			
			// class cache
			classes = new ListDictionary();
			
			// toplevel elements
			try {
				ResolveTopLevelElements();
			}
			catch {}

			// add external pathes
			StringCollection initCP = classPath;
			classPath = new StringCollection();
			string[] cpathes;
			DebugConsole.Trace("**** EXTERNAL CP");
			if (exPath.Length > 0)
			{
				cpathes = Environment.ExpandEnvironmentVariables(exPath).Split(';');
				foreach(string cpath in cpathes) AddPath(cpath.Trim());
			}
			// add user pathes from settings
			DebugConsole.Trace("**** USER CP");
			if (userClassPath.Length > 0)
			{
				cpathes = Environment.ExpandEnvironmentVariables(userClassPath).Split(';');
				foreach(string cpath in cpathes) AddPath(cpath.Trim());
			}
			// add initial pathes
			foreach(string cpath in initCP) AddPath(cpath);
			// re-parse current file
			if (cFile.Length > 0) cClass.OutOfDate = true;
			
			// update File System Watchers
			WatchersLock--;
			UpdateWatchers();
		}
		
		/// <summary>
		/// Update File System Watchers to automatically set classes out of date
		/// </summary>
		static private void UpdateWatchers()
		{
			if (WatchersLock > 0) return;
			Hashtable prevWatchers = Watchers;
			Watchers = new Hashtable();
			FileSystemWatcher fsw = null;
			
			// create or recycle watchers
			foreach(string path in classPath)
			try
			{
				if (prevWatchers != null) 
				{
					fsw = (FileSystemWatcher)prevWatchers[path];
				}
				if (fsw != null) 
				{
					prevWatchers.Remove(path);
				}
				else if (Watchers[path] == null)
				{
					fsw = new FileSystemWatcher();
					fsw.SynchronizingObject = ASContext.Panel;
			        fsw.Path = path;
			        fsw.IncludeSubdirectories = true;
			        fsw.NotifyFilter = NotifyFilters.LastWrite;
			        fsw.Filter = "*.as";
			        fsw.Changed += new FileSystemEventHandler(ASContext.Panel.OnFileChanged);
			        fsw.EnableRaisingEvents = true;
				}
				DebugConsole.Trace("Watch "+path);
				Watchers[path] = fsw;
				fsw = null;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError(ex.Message, ex);
			}
			
			// remove off-path watchers
			if (prevWatchers != null)
			{
				foreach(FileSystemWatcher oldFsw in prevWatchers.Values)
				try
				{
					oldFsw.EnableRaisingEvents = false;
					oldFsw.Dispose();
				}
				catch (Exception ex2)
				{
					ErrorHandler.ShowError(ex2.Message, ex2);
				}
				prevWatchers.Clear();
			}
		}
		#endregion
		
		#region class_caching
		static public void OnTextChanged(ScintillaNet.ScintillaControl sender, int position, int length, int linesAdded)
		{
			if (cClass != null) cClass.OutOfDate = true;
			DebugConsole.Trace("ins "+position+", "+length+", "+linesAdded);
		}

		/// <summary>
		/// Set current class out-of-date to force re-parse of the code when needed
		/// </summary>
		static public void SetOutOfDate()
		{
			if (cClass != null) cClass.OutOfDate = true;
		}
		/// <summary>
		/// Set current class ready to cancle re-parsing of the code
		/// </summary>
		static public void UnsetOutOfDate()
		{
			if (cClass != null) cClass.OutOfDate = false;
		}
		
		/// <summary>
		/// Delete current class's ASO file
		/// </summary>
		static public void RemoveClassASO()
		{
			if (MMClassPath.Length == 0 || cClass == null || cClass.ClassName == null)
				return;
			int p = cClass.ClassName.LastIndexOf(".");
			string package = (p > 0) ? cClass.ClassName.Substring(0,p+1) : "";
			string file = MMClassPath+"aso\\"+package.Replace('.','\\')+cClass.ClassName+".aso";
			try
			{
				if (File.Exists(file)) File.Delete(file);
			}
			catch
			{}
		}
		
		/// <summary>
		/// (Re)Parse and cache a class file
		/// </summary>
		/// <param name="aClass">Class object</param>
		/// <returns>The class object</returns>
		static public ASClass UpdateClass(ASClass aClass)
		{
			if (!aClass.OutOfDate || (classes == null)) return aClass;
			// remove from cache
			if (!aClass.IsVoid())
				classes.Remove(aClass.ClassName);
			// (re)parse
			aClass.OutOfDate = false;
			ASClassParser.ParseClass(aClass);
			// add to cache
			AddClassToCache(aClass);
			return aClass;
		}
		
		/// <summary>
		/// (Re)Parse and cache the current class file
		/// </summary>
		/// <param name="aClass">Class object</param>
		/// <returns>The class object</returns>
		static public ASClass UpdateCurrentClass()
		{
			if (!cClass.OutOfDate || (classes == null)) return cClass;
			
			// try to get current text
			ScintillaNet.ScintillaControl sci = MainForm.CurSciControl;
			if (sci == null)
				return UpdateClass(cClass);
			
			// remove from cache
			if (!cClass.IsVoid())
				classes.Remove(cClass.ClassName);
			// (re)parse
			cClass.OutOfDate = false;
			cClass.FileName = MainForm.GetLongPathName(MainForm.CurFile);
			ASClassParser.ParseClass(cClass, sci.Text);
			// add to cache
			AddClassToCache(cClass);
			return cClass;
		}
		
		/// <summary>
		/// Add the class object to a cache
		/// </summary>
		/// <param name="aClass">Class object to cache</param>
		static private bool AddClassToCache(ASClass aClass)
		{
			if (!aClass.IsVoid())
			{
				ASClass check = (ASClass)classes[aClass.ClassName];
				if (check != null && lastClassWarning != aClass.ClassName)
				{
					// if this class was defined in another file, check if it is still open
					if (String.CompareOrdinal(check.FileName, aClass.FileName) != 0)
					{
						ScintillaNet.ScintillaControl sci = MainForm.CurSciControl;
						WeifenLuo.WinFormsUI.DockContent[] docs = MainForm.GetDocuments();
						int found = 0;
						bool isActive = false;
						string tabFile;
						// check if the classes are open
						foreach(WeifenLuo.WinFormsUI.DockContent doc in docs)
						{
							tabFile = (string)MainForm.GetSciControl(doc).Tag; //FileName;
							if (String.CompareOrdinal(check.FileName, tabFile) == 0
							    || String.CompareOrdinal(aClass.FileName, tabFile) == 0)
							{
								if (MainForm.GetSciControl(doc) == sci)
									isActive = true;
								found++;
							}
						}
						// if there are several files declaring the same class
						if (found > 1 && isActive)
						{
							lastClassWarning = aClass.ClassName;
							
							Match cdecl = Regex.Match(sci.Text, "[\\s]class[\\s]+(?<cname>"+aClass.ClassName+")[^\\w]");
							int line = 1;
							if (cdecl.Success) 
							{
								line = 1+sci.LineFromPosition( sci.MBSafeCharPosition(cdecl.Groups["cname"].Index) );
							}
							string msg = String.Format("The class '{2}' is already declared in {3}",
							                           aClass.FileName, line, aClass.ClassName, check.FileName);
							MessageBar.ShowWarning(msg);
						}
						else lastClassWarning = null;
					}
				}
				classes[aClass.ClassName] = aClass;
				return true;
			}
			return false;
		}

		/// <summary>
		/// An AS file has changed, maybe it's in the class cache
		/// </summary>
		static public void TrackFileChanged(string filename)
		{
			if (filename == null)
				return;
			foreach(ASClass aClass in classes.Values)
			if (String.Compare(aClass.FileName, filename, true) == 0)
			{
				DebugConsole.Trace(aClass.ClassName+" is out of date");
				aClass.OutOfDate = true;
				break;
			}
		}
		#endregion
		
		#region tools_methods
		static public string NormalizePath(string path)
		{
			path = path.Trim();
			if (path.Length == 0)
				return path;
			if (doPathNormalization)
				path = path.Replace(dirAltSeparator, dirSeparator);
			if (!path.EndsWith(dirSeparator))
				path += dirSeparator;
			path = path.Replace(dirSeparator+dirSeparator, dirSeparator);
			return MainForm.GetLongPathName(path);
		}
		static public string NormalizeSeparators(string path)
		{
			path = path.Trim();
			if (path.Length == 0)
				return path;
			if (doPathNormalization)
				path = path.Replace(dirAltSeparator, dirSeparator);
			return path;
		}
		static public string GetLastStringToken(string str, string sep)
		{
			if (str == null) return "";
			if (sep == null) return str;
			int p = str.LastIndexOf(sep);
			return (p >= 0) ? str.Substring(p+1) : str;
		}
		#endregion
		
		#region class_resolving_functions
		/// <summary>
		/// Add a path to the classpath
		/// </summary>
		/// <param name="path">Path to add</param>
		static public string AddPath(string path)
		{
			try
			{
				if ((path == null) || (path.Length == 0)) 
					return null;
				path = NormalizePath(path);
				if (!System.IO.Directory.Exists(path))
					path = System.IO.Path.GetDirectoryName(Application.ExecutablePath)+dirSeparator+path;
				if (!System.IO.Directory.Exists(path))
				{
					ErrorHandler.ShowInfo("Invalid path in classpath:\n"+path);
					return null;
				}
				// avoid duplicated pathes
				string upath = path.ToUpper();
				foreach(string apath in classPath)
				if (apath.ToUpper() == upath) 
					return apath;
				// add new path
				DebugConsole.Trace("Add to classpath: "+path);
				classPath.Add(path);
				
				// File System Watchers
				UpdateWatchers();
				return path;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError(ex.Message+"\n"+path, ex);
			}
			return null;
		}
		
		/// <summary>
		/// Add the current class' base path to classpath
		/// </summary>
		/// <param name="path">Path to add</param>
		static public void SetTemporaryPath(string path)
		{
			if (temporaryPath == path)
				return;
			if (temporaryPath != null)
			{
				if (classPath[0] == temporaryPath) classPath.RemoveAt(0);
				temporaryPath = null;
			}
			if (path != null)
			{
				// avoid duplicated pathes
				string upath = path.ToUpper();
				foreach(string apath in classPath)
				if (apath.ToUpper() == upath) 
				{
					temporaryPath = null;
					return;
				}
				// add path
				temporaryPath = path;
				classPath.Insert(0, temporaryPath);
				
				// File System Watchers
				UpdateWatchers();
			}
		}
		
		/// <summary>
		/// Resolve wildcards in imports
		/// </summary>
		/// <param name="package">Package to explore</param>
		/// <param name="inClass">Current class</param>
		/// <param name="known">Packages already added</param>
		static public void ResolveImports(string package, ASClass inClass, ArrayList known)
		{
			string subpath;
			string path;
			string[] files;
			
			// validation
			if ((package == null) || (inClass == null)) return;
			subpath = package.Replace(".", dirSeparator);
			
			// search in classpath
			ASMember newImport;
			foreach(string basepath in classPath)
			try
			{
				if (System.IO.Directory.Exists(basepath+subpath))
				{
					path = basepath+subpath;
					DebugConsole.Trace("Search "+path);
					files = System.IO.Directory.GetFiles(path, "*.as");
					if (files == null) 
						continue;
					// add classes found
					int plen = basepath.Length;
					foreach(string file in files)
					{
						package = file.Substring(plen,file.Length-3-plen).Replace(dirSeparator,".");
						if (known.Contains(package))
							continue;
						known.Add(package);
						//
						newImport = new ASMember();
						newImport.Name = GetLastStringToken(package, ".");
						newImport.Type = package;
						inClass.Imports.Add(newImport);
					}
				}
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError(ex.Message+"\n"+basepath+subpath, ex);
			}
		}
		
		/// <summary>
		/// Retrieves a parsed class from its name
		/// </summary>
		/// <param name="cname">Class (short or full) name</param>
		/// <param name="inClass">Current class</param>
		/// <returns>A parsed class or an empty ASClass if the class is not found</returns>
		static public ASClass FindClassFromName(string cname, ASClass inClass)
		{
			ASClass aClass;
			if ((cname == null) || (cname.Length == 0)) cname = defaultMethodReturnType;
			
			if (inClass != null)
				DebugConsole.Trace("Find class "+cname+" in "+inClass.ClassName);
			else
				DebugConsole.Trace("Find class "+cname);
			
			// unknown
			if (cname.ToLower() == "void" || classes == null)
				return new ASClass();
			
			if (inClass != null && !inClass.IsVoid())
			{
				// current class
				if (inClass.Extends != null 
				    && (inClass.ClassName.IndexOf('.') > 0) && (cname == GetLastStringToken(inClass.ClassName, ".")))
				{
					cname = inClass.ClassName;
				}
				// complete class name
				else if (cname.IndexOf(".") < 0) 
				{
					// search in imported classes
					foreach(ASMember path in inClass.Imports)
					if (path.Name == cname) {
						cname = path.Type;
						break;
					}
				}
			}
			
			// retrieve class from cache
			aClass = (ASClass)classes[cname];
			if (aClass != null) 
				return UpdateClass(aClass);

			// search in intrinsic classes
			/*if ((topLevel != null) && !topLevel.IsVoid() && (cname.IndexOf(".") < 0))
			foreach(ASMember import in topLevel.Imports)
			{
				if (import.Name == cname)
				{
					DebugConsole.Trace("Use intrinsic class "+cname);
					if (cname.ToLower() == "void")
						return new ASClass(); else 
						return FindClassFromFile(topLevel.BasePath+cname+".as");
				}
			}*/
			
			DebugConsole.Trace("In classpath "+cname);
			// search in classpath
			aClass = new ASClass();
			string file = cname.Replace(".", dirSeparator)+".as";
			foreach(string path in classPath)
			try
			{
				DebugConsole.Trace("Try "+path+file);
				if (System.IO.File.Exists(path+file))
				{
					// case sensitive check
					string[] check = System.IO.Directory.GetFiles(path, file);
					if (check.Length == 0) continue;
					if (check[0].LastIndexOf(file) != check[0].Length-file.Length) continue;
					// parse file
					aClass.FileName = check[0];
					ASClassParser.ParseClass(aClass);
					if (!aClass.IsVoid())
					{
						classes[aClass.ClassName] = aClass;
						break;
					}
				}
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError(ex.Message+"\n"+path+file, ex);
			}
			// no match
			return aClass;
		}
		
		/// <summary>
		/// Look for a class in cache or parse a new class
		/// </summary>
		/// <param name="filename">Wanted class file</param>
		/// <returns>Parsed class</returns>
		static public ASClass FindClassFromFile(string filename)
		{
			if ((filename == null) || (filename.Length == 0)) 
				return new ASClass();
			// search existing class
			string fname = filename.ToUpper();
			DebugConsole.Trace("FromFile "+filename);
			IDictionaryEnumerator de = classes.GetEnumerator();
			while (de.MoveNext())
			if ( ((ASClass)de.Value).FileName.ToUpper() == fname )
			{
				DebugConsole.Trace("Found "+((ASClass)de.Value).ClassName);
				return UpdateClass( (ASClass)de.Value );
			}
			
			// if unknown, parse and cache
			ASClass aClass = new ASClass();
			aClass.FileName = filename;
			aClass.OutOfDate = true;
			return UpdateClass(aClass);
		}
		
		/// <summary>
		/// Search a class in classpath and open the file in editor
		/// </summary>
		/// <param name="classname">Class name</param>
		/// <returns>Success</returns>
		static public bool OpenFileFromClass(string classname, ASClass fromClass)
		{
			ASClass aClass = FindClassFromName(classname, fromClass);
			if (!aClass.IsVoid()) 
			{
				MainForm.OpenSelectedFile(aClass.FileName);
				return true;
			}
			else
			{
				ErrorHandler.ShowInfo("Class not found: "+classname);
				return false;
			}
		}
		
		/// <summary>
		/// Prepare Flash intrinsic know vars/methods/classes
		/// </summary>
		static private void ResolveTopLevelElements()
		{
			//
			// search top-level class
			//
			if (useMtascClasses)
			{
				topLevel = FindClassFromName("TopLevel",null);
			}
			else
			{
				topLevel = new ASClass();
				topLevel.FileName = MMClassPath+"toplevel.as";
				topLevel.OutOfDate = true;
				string src;
				// read file content
				try
				{
					StreamReader sr = new StreamReader(topLevel.FileName);
					src = sr.ReadToEnd();
					sr.Close();
				}
				catch (System.IO.FileNotFoundException)
				{
					// ignore files that don't exist (i.e. "Untitled.as")
					return;
				}
				catch(Exception ex)
				{
					ErrorHandler.ShowError(ex.Message+"\n"+topLevel.FileName, ex);
					return;
				}
				// make it look like a valid class
				src = "class toplevel {"+src+"}";
				// parse
				ASClassParser.ParseClass(topLevel, src);
			}
			// not found
			if (topLevel.IsVoid())
			{
				ErrorHandler.ShowInfo("Top-level elements class not found. Please check your Program Settings.");
				return;
			}
			
			//
			// init top-level elements
			//
			topLevel.ClassName = "top-level";
			topLevel.Extends = new ASClass();
			// special vars
			ASMember special;
			if (topLevel.Vars.Search("_root",0) == null)
			{
				special = new ASMember();
				special.Name = "_root";
				special.Flags = FlagType.Variable;
				special.Type = "MovieClip";
				topLevel.Vars.Add(special);
			}
			if (topLevel.Vars.Search("_global",0) == null)
			{
				special = new ASMember();
				special.Name = "_global";
				special.Flags = FlagType.Variable;
				special.Type = "Object";
				topLevel.Vars.Add(special);
			}
			if (topLevel.Vars.Search("this",0) == null)
			{
				special = new ASMember();
				special.Name = "this";
				special.Flags = FlagType.Variable;
				special.Type = "Object";
				topLevel.Vars.Add(special);
			}
			if (topLevel.Vars.Search("super",0) == null)
			{
				special = new ASMember();
				special.Name = "super";
				special.Flags = FlagType.Variable;
				special.Type = "Object";
				topLevel.Vars.Add(special);
			}
			// pre-sort
			topLevel.Sort();
			
			// all intrinsic methods/vars
			foreach(ASMember member in topLevel.Methods)
				member.Flags |= FlagType.Intrinsic;
			foreach(ASMember member in topLevel.Vars)
				member.Flags |= FlagType.Intrinsic;
			
			// list instrinsic classes
			string package;
			ASMember newImport;
			foreach(string path in classPath)
			try
			{
				string[] files = System.IO.Directory.GetFiles(path, "*.as");
				if (files == null) 
					continue;
				// add classes found
				string iname;
				int plen = path.Length;
				foreach(string file in files)
				{
					package = file.Substring(plen,file.Length-3-plen).Replace(dirSeparator, ".");
					iname = GetLastStringToken(package, ".");
					newImport = new ASMember();
					newImport.Name = iname;
					newImport.Type = package;
					newImport.Flags = FlagType.Intrinsic;
					if (!iname.Equals("TopLevel") && !iname.Equals("StdPresent") 
					    && (iname.IndexOf(' ') < 0) && (topLevel.Imports.Search(iname, 0) == null))
						topLevel.Imports.Add(newImport);
				}
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError(ex.Message+"\n"+path, ex);
				continue;
			}
			// special case
			newImport = new ASMember();
			newImport.Name = newImport.Type = "Void";
			newImport.Flags = FlagType.Intrinsic;
			topLevel.Imports.Add(newImport);
			topLevel.Imports.Sort();
		}
		
		/// <summary>
		/// Update Flash intrinsic know vars
		/// </summary>
		static private void UpdateTopLevelElements()
		{
			if (cClass.IsVoid() || topLevel.IsVoid())
				return;
			ASMember special;
			special = topLevel.Vars.Search("this",0);
			if (special != null)
			{
				special.Type = cClass.ClassName;
			}
			special = topLevel.Vars.Search("super",0);
			if (special != null) 
			{
				if ((cClass.Extends != null) && !cClass.Extends.IsVoid())
					special.Type = cClass.Extends.ClassName;
				else
					special.Type = "Object";
			}
			// HACK AS3 'void' support
			special = topLevel.Imports.Search(cClass.IsAS3 ? "Void" : "void",0);
			if (special != null)
			{
				special.Type = special.Name = cClass.IsAS3 ? "void" : "Void";
			}
		}
		
		/// <summary>
		/// Find folder and classes in classpath
		/// </summary>
		/// <param name="folder">Path to eval</param>
		/// <returns>Package folders and classes</returns>
		static public ASMemberList FindPackage(string folder, bool completeContent)
		{
			if ((folder == null) || (folder.Length == 0))
				return null;
			ASMemberList package = new ASMemberList();
			ASMember pathMember;
			string[] dirEntries;
			string cname;
			foreach(string path in classPath)
			try
			{
				if (System.IO.Directory.Exists(path+folder))
				{
					// continue parsing?
					if (!completeContent) return package;
					
					// add sub packages
					try {
						dirEntries = System.IO.Directory.GetDirectories(path+folder);
					}
					catch {
						// fail silently
						dirEntries = null;
					}
					if (dirEntries != null)
					foreach(string entry in dirEntries)
					{
						cname = GetLastStringToken(entry, dirSeparator);
						if ((cname.Length > 0) && !cname.StartsWith("_") 
						    && (cname.IndexOf(' ') < 0) && (cname.IndexOf('.') < 0)
						    && (package.Search(cname, 0) == null))
						{
							pathMember = new ASMember();
							pathMember.Flags = FlagType.Package;
							pathMember.Type = folder.Replace(dirSeparatorChar, '.')+"."+cname;
							pathMember.Name = cname;
							package.Add(pathMember);
						}
					}
					
					// add sub classes
					try {
						dirEntries = System.IO.Directory.GetFiles(path+folder);
					}
					catch {
						// fail silently
						dirEntries = null;
					}
					if (dirEntries != null)
					foreach(string entry in dirEntries)
					if (entry.EndsWith(".as")) {
						cname = GetLastStringToken(entry, dirSeparator);
						cname = cname.Substring(0, cname.LastIndexOf("."));
						pathMember = package.Search(cname, 0);
						if ((pathMember == null) && (cname.Length > 0) 
						    && (cname.IndexOf(' ') < 0) && (cname.IndexOf('.') < 0))
						{
							pathMember = new ASMember();
							pathMember.Flags = 0;
							pathMember.Type = folder.Replace(dirSeparatorChar,'.')+"."+cname;
							pathMember.Name = cname;
							package.Add(pathMember);
						}
					}
				}
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError(ex.Message+"\n"+path+folder, ex);
			}
			// result
			if (package.Count > 0)
			{
				package.Sort();
				return package;
			}
			else return null;
		}
		
		/// <summary>
		/// Search all base packages (com, net, org,...) in classpath
		/// </summary>
		/// <returns>Base packages list as members</returns>
		static public ASMemberList GetBasePackages()
		{
			ASMemberList packages = new ASMemberList();
			ASMember package;
			string[] dirEntries;
			string[] fileEntries;
			string cname;
			string upPath;
			string mmCP = MMClassPath.ToUpper();
			string mtascCP = mtascRootFolder.ToUpper();
			bool notMacromedia;
			bool notMTASC;
			foreach(string path in classPath) 
			try
			{
				upPath = path.ToUpper();
				notMacromedia = (mmCP.Length == 0) || !upPath.StartsWith(mmCP);
				notMTASC = (mtascCP.Length == 0) || !upPath.StartsWith(mtascCP);
				// base classes
				if (notMacromedia && notMTASC)
				{
					try {
						fileEntries = System.IO.Directory.GetFiles(path, "*.as");
					}
					catch {
						// fail silently
						fileEntries = null;
					}
					if (fileEntries != null)
					foreach(string entry in fileEntries)
					{
						cname = GetLastStringToken(entry, dirSeparator);
						int p = cname.LastIndexOf('.');
						cname = cname.Substring(0,p);
						if (!cname.StartsWith("_") && (cname.IndexOf('.') < 0) && (cname.IndexOf(' ') < 0)
						    && (packages.Search(cname, 0) == null))
						{
							//DebugConsole.Trace("Base class "+cname);
							package = new ASMember();
							package.Flags = 0;
							package.Type = package.Name = cname;
							packages.Add(package);
						}
					}
				}
				// base packages
				if (notMacromedia)
				{
					try {
						dirEntries = System.IO.Directory.GetDirectories(path);
					}
					catch {
						// fail silently
						dirEntries = null;
					}
					if (dirEntries != null)
					foreach(string entry in dirEntries)
					{
						cname = GetLastStringToken(entry, dirSeparator);
						if (!cname.StartsWith("_") && (cname.IndexOf(' ') < 0) && (cname.IndexOf('.') < 0)
						    && (packages.Search(cname, 0) == null))
						{
							//DebugConsole.Trace("Base package "+cname);
							package = new ASMember();
							package.Flags = FlagType.Package;
							package.Type = package.Name = cname;
							packages.Add(package);
						}
					}
				}
				else if (packages.Search("mx", 0) == null)
				{
					package = new ASMember();
					package.Flags = FlagType.Package;
					package.Type = package.Name = "mx";
					packages.Add(package);
				}
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError(ex.Message+"\n"+path, ex);
			}
			packages.Sort();
			return packages;
		}
		#endregion
		
		#region plugin_commands
		static public void SetStatusText(string text) {
			MainForm.StatusBar.Panels[0].Text = "  " + text;
		}
		static public string GetStatusText() {
			if (MainForm.StatusBar.Panels[0].Text.Length > 2)
				return MainForm.StatusBar.Panels[0].Text.Substring(2);
			else 
				return "";
		}
		
		/// <summary>
		/// Browse to the first package folder in the classpath
		/// </summary>
		/// <param name="package">Package to show in the Files Panel</param>
		/// <returns>A folder was found and displayed</returns>
		static public bool BrowseTo(string package)
		{
			package = package.Replace('.',dirSeparatorChar);
			foreach(string path in classPath)
			{
				if (System.IO.Directory.Exists(path+package))
				{
					TextEvent te = new TextEvent(EventType.Command, "BrowseTo;"+path+package);
					MainForm.DispatchEvent(te);
					return te.Handled;
				}
			}
			return false;
		}
		
		/// <summary>
		/// Run MTASC compiler in the current class's base folder with current classpath
		/// </summary>
		/// <param name="append">Additional comiler switches</param>
		static public void RunMTASC(string append)
		{
			DebugConsole.Trace("> RunMTASC "+CurrentClass.IsVoid());
			
			if (!IsClassValid())
				return;
			if (mtascRootFolder.Length == 0)
			{
				ErrorHandler.ShowInfo("MTASC's path is not correctly set. Please check your Program Settings.");
				return;
			}
			
			SetStatusText(STATUS_MTASC_RUNNING);
			
			try 
			{
				// save modified files if needed
				bool check = CheckOnSave;
				CheckOnSave = false;
				if (builtSWF != null) MainForm.CallCommand("SaveAllModified", null);
				else MainForm.CallCommand("SaveAllModified", ".as");
				CheckOnSave = check;
				
				// change current directory
				string currentPath = System.IO.Directory.GetCurrentDirectory();
				System.IO.Directory.SetCurrentDirectory(CurrentClass.BasePath);
				// prepare command
				string command = mtascRootFolder+"mtasc.exe;\""+CurrentFile+"\"";
				command += " -version "+flashVersion;
				// classpathes
				foreach(string path in classPath)
				if (path.IndexOf(mtascRootFolder) < 0)
					command += " -cp \""+path.TrimEnd('\\')+"\"";
				command = command.Replace(CurrentClass.BasePath, "");
				
				// run
				MainForm.CallCommand("RunProcessCaptured", command+" "+append);
				// restaure current directory
				if (System.IO.Directory.GetCurrentDirectory() == CurrentClass.BasePath)
					System.IO.Directory.SetCurrentDirectory(currentPath);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError(ex.Message, ex);
			}
		}
		
		/// <summary>
		/// Calls RunMTASC with additional parameters taken from the classes @mtasc doc tag
		/// </summary>
		static public bool BuildMTASC(bool failSilently)
		{
			// check if @mtasc is defined
			Match mCmd = null;
			if (ASContext.IsClassValid() && ASContext.CurrentClass.Comments != null) 
				mCmd = re_MtascBuildCommand.Match(ASContext.CurrentClass.Comments);
			
			if (mCmd == null || !mCmd.Success) 
			{
				if (!failSilently)
				{
					MessageBar.ShowWarning("This class is invalid or does not include a @mtasc build command.");
				}
				return false;
			}
			
			// build command
			string command = mCmd.Groups["params"].Value.Trim();
			try
			{
				if (command == null || command.Length == 0) 
				{
					if (!failSilently)
						throw new Exception("Preprocessor returned an empty command.");
					return false;
				}
				command = " "+MainForm.ProcessArgString(command)+" ";
				builtSWF = null;
				builtSWFSize = "";
				trustFileWanted = false;
				
				// get SWF url
				MatchCollection mPar = re_SplitParams.Matches(command+"-eof");
				int mPlayIndex = -1;
				bool noPlay = false;
				if (mPar.Count > 0)
				{
					string op;
					for(int i=0; i<mPar.Count; i++)
					{
						op = mPar[i].Groups["switch"].Value;
						int start = mPar[i].Index+mPar[i].Length;
						int end = (mPar.Count > i+1) ? mPar[i+1].Index : command.Length;
						if ((op == "-swf") && (builtSWF == null) && (mPlayIndex < 0))
						{
							if (end > start)
								builtSWF = command.Substring(start,end-start).Trim();
						}
						else if ((op == "-out") && (mPlayIndex < 0))
						{
							if (end > start)
								builtSWF = command.Substring(start,end-start).Trim();
						}
						else if (op == "-header")
						{
							if (end > start) {
								string[] dims = command.Substring(start,end-start).Trim().Split(':');
								if (dims.Length > 2) builtSWFSize = ";"+dims[0]+";"+dims[1];
							}
						}
						else if (op == "-play")
						{
							if (end > start)
							{
								mPlayIndex = i;
								builtSWF = command.Substring(start,end-start).Trim();
							}
						}
						else if (op == "-trust")
						{
							trustFileWanted = true;
						}
						else if (op == "-noplay")
						{
							noPlay = true;
						}
					}
				}
				if (builtSWF.Length == 0) builtSWF = null;
				
				// cleaning custom switches
				if (mPlayIndex >= 0) {
					command = command.Substring(0, mPar[mPlayIndex].Index)+command.Substring(mPar[mPlayIndex+1].Index);
				}
				if (trustFileWanted) {
					command = command.Replace("-trust", "");
				}
				if (noPlay) {
					command = command.Replace("-noplay", "");
					builtSWF = null;
				}
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while preprocessing the build command.", ex);
				return false;
			}
			
			// run
			RunMTASC(command);
			return true;
		}
		
		static public void RunMTASC(object sender, EventArgs e)
		{
			RunMTASC(MainForm.MainSettings.GetValue(SETTING_MTASC_CHECKPARAMS));
		}
		
		/// <summary>
		/// If we have built a SWF, update it and eventually play it
		/// </summary>
		/// <param name="result">Execution result</param>
		static public void OnProcessEnd(string result)
		{
			if (GetStatusText() == STATUS_MTASC_RUNNING)
			{
				SetStatusText(STATUS_MTASC_DONE);
			}
			
			if (builtSWF == null) return;
			string swf = builtSWF;
			builtSWF = null;
			
			// on error, don't play
			if (!result.EndsWith("(0)"))
				return;
			
			// remove quotes
			if (swf.StartsWith("\"")) swf = swf.Substring(1, swf.Length-2);
			
			// allow network access to the SWF
			if (trustFileWanted)
			{
				System.IO.FileInfo info = new System.IO.FileInfo(swf);
				//
				string path = info.Directory.FullName;
				string trustFile = path.Replace(dirSeparatorChar,'_').Remove(1,1);
				while ((trustFile.Length > 100) && (trustFile.IndexOf('_') > 0)) trustFile = trustFile.Substring(trustFile.IndexOf('_'));
				string trustParams = "FlashDevelop_"+trustFile+".cfg;"+path;
				//
				DataEvent deTrust = new DataEvent(EventType.CustomData, "CreateTrustFile", trustParams);
				MainForm.DispatchEvent(deTrust);
			}

			// stop here if the user doesn't want to automatically play the SWF
			if (!runAfterBuild) return;
			
			// other plugin may handle the SWF playing
			DataEvent dePlay = new DataEvent(EventType.CustomData, "PlaySWF", swf+builtSWFSize);
			MainForm.DispatchEvent(dePlay);
			if (dePlay.Handled) return;
			
			try 
			{
				// change current directory
				string currentPath = System.IO.Directory.GetCurrentDirectory();
				System.IO.Directory.SetCurrentDirectory(CurrentClass.BasePath);
				// run
				System.Diagnostics.Process.Start(swf);
				// restaure current directory
				if (System.IO.Directory.GetCurrentDirectory() == CurrentClass.BasePath)
					System.IO.Directory.SetCurrentDirectory(currentPath);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError(ex.Message, ex);
			}
		}
		
		/// <summary>
		/// Generate an instrinsic class
		/// </summary>
		/// <param name="files">Semicolon-separated source & destination files</param>
		static public void MakeIntrinsic(string files)
		{
			string src = cFile;
			string dest = null;
			if ((files != null) && (files.Length > 0))
			{
				string[] list = files.Split(';');
				if (list.Length == 1) dest = list[0];
				else {
					src = list[0];
					dest = list[1];
				}
			}
			ASClass aClass;
			if (src == cFile) aClass = cClass;
			else {
				aClass = new ASClass();
				aClass.FileName = src;
				ASClassParser.ParseClass(aClass);
			}
			if (aClass.IsVoid()) return;
			//
			string code = aClass.GenerateIntrinsic();
			
			// no destination, replace text
			if (dest == null) 
			{
				MainForm.CallCommand("New", null);
				MainForm.CurSciControl.CurrentPos = 0;
				MainForm.CurSciControl.Text = code;
				return;
			}
			
			// write destination
			try
			{
				StreamWriter writer = System.IO.File.CreateText(dest);
				writer.Write(code);
				writer.Close();
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("IO error while writing the intrinsic class.", ex);
			}
		}
		#endregion
		
		#region IASContext interface members
		
		public void SetTemporaryBasePath(string fileName, string basePath)
		{
			if (fileName.ToUpper() == ASContext.CurrentFile.ToUpper())
				ASContext.SetTemporaryPath(basePath);
		}
		
		public ASMemberList GetSubClasses(string folder)
		{
			return ASContext.FindPackage(folder, true);
		}
			
		public void ResolveWildcards(string package, ASClass inClass, ArrayList known)
		{
			ASContext.ResolveImports(package, inClass, known);			                         
		}
		
		public ASClass GetClassByName(string cname, ASClass inClass)
		{
			// avoid class inheritance infinite loop
			if (inClass != null && ASContext.classes[inClass.ClassName] == null)
			{
				ASContext.classes[inClass.ClassName] = inClass;
			}
			return ASContext.FindClassFromName(cname, inClass);
		}
		
		public ASClass GetClassByFile(string filename)
		{
			return ASContext.FindClassFromFile(filename);
		}
		
		public ASClass GetCurrentClass()
		{
			return ASContext.CurrentClass;
		}

		/// <summary>
		/// (Re)Parse and cache a class file
		/// </summary>
		/// <param name="aClass">Class object</param>
		/// <returns>The class object</returns>
		public ASClass GetCachedClass(ASClass aClass)
		{
			return ASContext.UpdateClass(aClass);
		}
				
		/// <summary>
		/// Depending on the context UI, display some message
		/// </summary>
		public void DisplayError(string message)
		{
			MessageBar.ShowWarning(message);
		}
		#endregion
	}
}
