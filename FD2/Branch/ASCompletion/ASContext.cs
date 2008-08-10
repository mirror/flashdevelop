/*
 * Autocompletion context manager
 */

using System;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using System.Collections;
using System.Collections.Specialized;
using System.IO;
using PluginCore;
using PluginCore.Controls;

namespace ASCompletion
{
	public class ASContext: IASContext
	{
		#region Settings constants
		static readonly protected string SETTING_DOCUMENTATION_COMPLETION = "ASCompletion.Documentation.EnableCompletion";
		static readonly protected string SETTING_DOCUMENTATION_TAGS = "ASCompletion.Documentation.EnableTags";
		static readonly private string SETTING_DOCUMENTATION_TIPS = "ASCompletion.Documentation.EnhancedTips";
		static readonly private string SETTING_DOCUMENTATION_DESCRIPTION = "ASCompletion.Documentation.TipDescription";
		
		static readonly protected string[] SETTING_DOCUMENTATION_COMMAND = {
			"ASCompletion.AS2.Documentation.HelpCommand"
		};
		static readonly protected string[] DEFAULT_HELP_COMMAND = {
			"http://www.google.com/search?q=allintitle:@CLASSPACKAGE+@CLASSNAME+@MEMBERNAME+site:macromedia.com"
		};
		
		static readonly protected string[] SETTING_ENABLE_HELPERS = {
			"ASCompletion.AS2.EnableSmartHelpers"
		};
		static readonly protected string[] SETTING_ENABLE_AUTOIMPORT = {
			"ASCompletion.AS2.Generate.AutoImports"
		};
		static readonly protected string[] SETTING_ALWAYS_SHOW_INTRINSIC_MEMBERS = {
			"ASCompletion.AS2.IntrinsicMembers.AlwaysShow"
		};
		static readonly protected string[] SETTING_HIDE_INTRINSIC_MEMBERS = {
			"ASCompletion.AS2.IntrinsicMembers.Hide"
		};
		
		static readonly protected string[] DEFAULT_LIBRARY_PATH = {
			"\\Library\\"
		};
		static readonly protected string[] SETTING_CLASSPATH = {
			"ASCompletion.AS2.ClassPath"
		};
		static readonly protected string[] SETTING_DEFAULT_METHOD_RETURN_TYPE = {
			"ASCompletion.AS2.DefaultMethodReturnType"
		};
		static readonly protected string[] SETTING_CMD_CHECKONSAVE = {
			"ASCompletion.AS2.MTASC.CheckOnSave"
		};
		static readonly protected string[] SETTING_CMD_CHECKPARAMS = {
			"ASCompletion.AS2.MTASC.CheckParameters"
		};
		static readonly protected string[] SETTING_CMD_PATH = {
			"ASCompletion.AS2.MTASC.Path"
		};
		static readonly protected string[] SETTING_CMD_RUNAFTERBUILD = {
			"ASCompletion.AS2.MTASC.RunAfterBuild"
		};
		
		static readonly protected string[] STATUS_CMD_RUNNING = {
			"MTASC Running..."
		};
		static readonly protected string[] STATUS_CMD_DONE = {
			"MTASC Done"
		};
		static readonly protected string[] DEFAULT_CMD_PATH = {
			"\\Tools\\mtasc\\"
		};
		static readonly protected string[] DEFAULT_CMD_PARAMS = {
			"-mx"
		};
		#endregion
		
		// context
		static private int locked = 1;
		static protected ASContext context;
		protected ArrayList classPath;
		protected FileModel cFile;
		static protected PluginMain plugin;
		protected ClassModel cClass;
		protected FileModel topLevel;
		protected string lastClassWarning;
		// path normalization
		static protected bool doPathNormalization;
		static protected string dirSeparator;
		static protected char dirSeparatorChar;
		static protected string dirAltSeparator;
		static protected char dirAltSeparatorChar;
		// settings
		protected int contextIndex;
		protected string userClassPath;
		protected string externalClassPath = "";
		static private string externalClassPathWanted;
		protected string temporaryPath;
		public string TopLevelClassPath;
		public bool CheckOnSave;
		public string defaultMethodReturnType;
		public bool HelpersEnabled;
		public bool AutoImportsEnabled;
		public bool AlwaysShowIntrinsicMembers;
		public bool HideIntrinsicMembers;
		static public bool DocumentationCompletionEnabled;
		static public string DocumentationTags;
		static public bool DocumentationInTips;
		static public bool DescriptionInTips;
		public string HelpCommandPattern;
		// Checking / Quick Build
		protected bool runAfterBuild;
		protected string builtSWF;
		protected string builtSWFSize;
		protected bool trustFileWanted;
		// Watchers
		protected Hashtable Watchers;
		protected int WatchersLock;
		
		#region regular_expressions_definitions
		readonly protected Regex re_CMD_BuildCommand = 
			new Regex("^[\\s*/]*@mtasc[\\s]+(?<params>.*)$", RegexOptions.Compiled | RegexOptions.Multiline);
		readonly protected Regex re_SplitParams = 
			new Regex("[\\s](?<switch>\\-[A-z]+)", RegexOptions.Compiled | RegexOptions.Singleline);
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
		
		static public bool Locked
		{
			get {
				return locked > 0;
			}
		}
		
		static public ASContext Context
		{
			get {
				return context;
			}
		}
		
		public virtual ClassModel CurrentClass 
		{
			get {
				// to be implemented
				return ClassModel.VoidClass;
			}
		}
		
		public virtual FileModel CurrentFile 
		{
			get {
				return cFile;
			}
		}
		
		/// <summary>
		/// Currently edited class. On set, synchronise CurrentClass. 
		/// </summary>
		public FileModel SetCurrentFile(string fileName)
		{
			DebugConsole.Trace("Set '"+fileName+"'");
			// non-AS file
			if (fileName == null || fileName == "")
			{
				string nFile = MainForm.CurFile;
				if (doPathNormalization)
					nFile = nFile.Replace(dirAltSeparator, dirSeparator);
				cFile = new FileModel(nFile);
				cClass = ClassModel.VoidClass;
			}
			// AS file
			else
			{
				string nFile = fileName;
				if (doPathNormalization)
					nFile = nFile.Replace(dirAltSeparator, dirSeparator);
				cFile = PathModel.FindFile(nFile);
				cClass = cFile.GetPublicClass();
				DebugConsole.Trace("Parsed: "+cClass.ClassName);
				// update "this" and "super" special vars
				UpdateTopLevelElements();
			}
			if (Panel != null)
				Panel.UpdateView(cFile);
			return cFile;
		}
		
		/// <summary>
		/// Check if the current file is a valid file for the completion
		/// without parsing the file again.
		/// </summary>
		public bool IsFileValid()
		{
			return (cFile.Version >= 1);
		}
		
		/// <summary>
		/// MTASC's Actionscript built-in elements
		/// </summary>
		public FileModel TopLevel
		{
			get {
				return topLevel;
			}
		}
		
		#endregion
		
		#region context_management
		
		public ASContext()
		{
			cClass = ClassModel.VoidClass;
			cFile = cClass.InFile;
		}
		
		/// <summary>
		/// Init completion engine context
		/// </summary>
		/// <param name="mainForm">Reference to MainForm</param>
		static public void Init(PluginMain pluginMain)
		{
			dirSeparatorChar = System.IO.Path.DirectorySeparatorChar;
			dirSeparator = dirSeparatorChar.ToString();
			dirAltSeparatorChar = System.IO.Path.AltDirectorySeparatorChar;
			dirAltSeparator = dirAltSeparatorChar.ToString();
			doPathNormalization = dirSeparator != dirAltSeparator;
			//
			ASContext.plugin = pluginMain;
			try
			{
				context = new Contexts.Actionscript2();
				ASFileParser.Context = context;
				context.Init();
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError("Failed to initialize context.\n"+ex.Message, ex);
			}
			
			// documentation
			if (!MainForm.MainSettings.HasKey(SETTING_DOCUMENTATION_COMPLETION))
				MainForm.MainSettings.AddValue(SETTING_DOCUMENTATION_COMPLETION, "true");
			if (!MainForm.MainSettings.HasKey(SETTING_DOCUMENTATION_TAGS))
				MainForm.MainSettings.AddValue(SETTING_DOCUMENTATION_TAGS, ASDocumentation.DEFAULT_DOC_TAGS);
			if (!MainForm.MainSettings.HasKey(SETTING_DOCUMENTATION_TIPS))
				MainForm.MainSettings.AddValue(SETTING_DOCUMENTATION_TIPS, "true");
			if (!MainForm.MainSettings.HasKey(SETTING_DOCUMENTATION_DESCRIPTION))
				MainForm.MainSettings.AddValue(SETTING_DOCUMENTATION_DESCRIPTION, "true");
			
			// debugging enabled?
			DebugConsole.CheckSettings();
			
			// status
			UnLock();
		}
		
		/// <summary>
		/// The context is not busy anymore exploring the filesystem
		/// </summary>
		static protected void ExplorationDone()
		{
			string pathes = "";
			foreach(PathModel aPath in context.classPath)
				pathes += aPath.Path+" ("+aPath.Files.Count+")\n";
			DebugConsole.Trace("CLASSPATH:\n"+pathes);
			UnLock();
		}
		
		static public void SetLock()
		{
			locked++;
		}
		static public void UnLock()
		{
			if (locked == 0) return;
			locked--;
			if (locked == 0 && externalClassPathWanted != null)
			{
				SetExternalClassPath(externalClassPathWanted);
				externalClassPathWanted = null;
			}
		}
		
		
		protected virtual void Init()
		{
			// helpers enabled
			if (!MainForm.MainSettings.HasKey(SETTING_ENABLE_HELPERS[contextIndex]))
				MainForm.MainSettings.AddValue(SETTING_ENABLE_HELPERS[contextIndex], "true");			
			if (!MainForm.MainSettings.HasKey(SETTING_ENABLE_AUTOIMPORT[contextIndex]))
				MainForm.MainSettings.AddValue(SETTING_ENABLE_AUTOIMPORT[contextIndex], "true");
			
			// completion options
			if (!MainForm.MainSettings.HasKey(SETTING_ALWAYS_SHOW_INTRINSIC_MEMBERS[contextIndex]))
				MainForm.MainSettings.AddValue(SETTING_ALWAYS_SHOW_INTRINSIC_MEMBERS[contextIndex], "false");
			if (!MainForm.MainSettings.HasKey(SETTING_HIDE_INTRINSIC_MEMBERS[contextIndex]))
				MainForm.MainSettings.AddValue(SETTING_HIDE_INTRINSIC_MEMBERS[contextIndex], "false");
			
			// command line build
			if (!MainForm.MainSettings.HasKey(SETTING_CMD_PATH[contextIndex]))
				MainForm.MainSettings.AddValue(SETTING_CMD_PATH[contextIndex], 
					System.IO.Path.GetDirectoryName(Application.ExecutablePath)+DEFAULT_CMD_PATH[contextIndex]);
			if (!MainForm.MainSettings.HasKey(SETTING_CMD_CHECKONSAVE[contextIndex]))
				MainForm.MainSettings.AddValue(SETTING_CMD_CHECKONSAVE[contextIndex], "false");
			if (!MainForm.MainSettings.HasKey(SETTING_CMD_RUNAFTERBUILD[contextIndex]))
				MainForm.MainSettings.AddValue(SETTING_CMD_RUNAFTERBUILD[contextIndex], "true");
			if (!MainForm.MainSettings.HasKey(SETTING_CMD_CHECKPARAMS[contextIndex]))
				MainForm.MainSettings.AddValue(SETTING_CMD_CHECKPARAMS[contextIndex], DEFAULT_CMD_PARAMS[contextIndex]);
			
			// documentation
			if (!MainForm.MainSettings.HasKey(SETTING_DOCUMENTATION_COMMAND[contextIndex]))
				MainForm.MainSettings.AddValue(SETTING_DOCUMENTATION_COMMAND[contextIndex], DEFAULT_HELP_COMMAND[contextIndex]);
			
			UpdateSettings();
		}
		
		/// <summary>
		/// Application settings have been updated.
		/// </summary>
		static public void UpdateSettings()
		{
			DebugConsole.Trace("REFRESH SETTINGS");
			
			DocumentationCompletionEnabled = MainForm.MainSettings.GetBool(SETTING_DOCUMENTATION_COMPLETION);
			DocumentationTags = MainForm.MainSettings.GetValue(SETTING_DOCUMENTATION_TAGS);
			DocumentationInTips = MainForm.MainSettings.GetBool(SETTING_DOCUMENTATION_TIPS);
			DescriptionInTips = MainForm.MainSettings.GetBool(SETTING_DOCUMENTATION_DESCRIPTION);
			
			context.UpdateSettings(0);
			
			// UI settings
			DebugConsole.SettingsChanged();
			Panel.UpdateSettings();
		}
		
		public virtual void UpdateSettings(int index)
		{
			DebugConsole.Trace("REFRESH SETTINGS");
			// new settings
			DebugConsole.SettingsChanged();
			
			DocumentationCompletionEnabled = MainForm.MainSettings.GetBool(SETTING_DOCUMENTATION_COMPLETION);
			DocumentationTags = MainForm.MainSettings.GetValue(SETTING_DOCUMENTATION_TAGS);
			
			HelpersEnabled = MainForm.MainSettings.GetBool(SETTING_ENABLE_HELPERS[contextIndex]);
			AutoImportsEnabled = MainForm.MainSettings.GetBool(SETTING_ENABLE_AUTOIMPORT[contextIndex]);
			AlwaysShowIntrinsicMembers = MainForm.MainSettings.GetBool(SETTING_ALWAYS_SHOW_INTRINSIC_MEMBERS[contextIndex]);
			HideIntrinsicMembers = MainForm.MainSettings.GetBool(SETTING_HIDE_INTRINSIC_MEMBERS[contextIndex]);
			HelpCommandPattern = MainForm.MainSettings.GetValue(SETTING_DOCUMENTATION_COMMAND[contextIndex]);
			
			defaultMethodReturnType = MainForm.MainSettings.GetValue(SETTING_DEFAULT_METHOD_RETURN_TYPE[contextIndex]);
			
			CheckOnSave = MainForm.MainSettings.GetBool(SETTING_CMD_CHECKONSAVE[contextIndex]);
			runAfterBuild = MainForm.MainSettings.GetBool(SETTING_CMD_RUNAFTERBUILD[contextIndex]);
			
			// UI settings
			Panel.UpdateSettings();
		}
		
		/// <summary>
		/// Classpathes & classes cache initialisation
		/// </summary>
		public virtual void BuildClassPath()
		{
			// to be implemented
		}
		
		/// <summary>
		/// Update File System Watchers to automatically set classes out of date
		/// </summary>
		/*protected void UpdateWatchers()
		{
			if (WatchersLock > 0) return;
			Hashtable prevWatchers = Watchers;
			Watchers = new Hashtable();
			FileSystemWatcher fsw = null;
			
			try
			{
			// create or recycle watchers
			foreach(string path in classPath)
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
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError(ex.Message, ex);
			}
			
			try
			{
			// remove off-path watchers
			if (prevWatchers != null)
			{
				foreach(FileSystemWatcher oldFsw in prevWatchers.Values)
				{
					oldFsw.EnableRaisingEvents = false;
					oldFsw.Dispose();
				}
				prevWatchers.Clear();
			}
			}
			catch (Exception ex2)
			{
				ErrorHandler.ShowError(ex2.Message, ex2);
			}
		}*/
		#endregion
		
		#region class_caching
		static public void OnTextChanged(ScintillaNet.ScintillaControl sender, int position, int length, int linesAdded)
		{
			if (context != null) 
				context.cFile.OutOfDate = true;
			DebugConsole.Trace("ins "+position+", "+length+", "+linesAdded);
		}

		/// <summary>
		/// Set current class out-of-date to force re-parse of the code when needed
		/// </summary>
		public void SetOutOfDate()
		{
			cFile.OutOfDate = true;
		}
		/// <summary>
		/// Set current class ready to cancle re-parsing of the code
		/// </summary>
		public void UnsetOutOfDate()
		{
			cFile.OutOfDate = false;
		}
		
		/// <summary>
		/// Delete current class's cached file of the compiler
		/// </summary>
		public virtual void RemoveClassCompilerCache()
		{
			// to be implemented
		}
		
		/// <summary>
		/// (Re)Parse and cache a class file
		/// </summary>
		/// <param name="aClass">Class object</param>
		/// <returns>The class object</returns>
		public virtual ClassModel UpdateClass(ClassModel aClass)
		{
			// to be implemented
			return aClass;
		}
		
		/// <summary>
		/// An AS file has changed, maybe it's in the class cache
		/// TODO  TrackFileChanged
		/// </summary>
		public void TrackFileChanged(string filename)
		{
			if (filename == null)
				return;
			/*foreach(ClassModel aClass in classes.Values)
			if (String.Compare(aClass.FileName, filename, true) == 0)
			{
				DebugConsole.Trace(aClass.ClassName+" is out of date");
				aClass.OutOfDate = true;
				break;
			}*/
		}
		#endregion
		
		#region tools_methods
		static public string NormalizePath(string path)
		{
			if (path == null)
				return "";
			path = path.Trim();
			if (path.Length == 0)
				return path;
			if (doPathNormalization)
				path = path.Replace(dirAltSeparator, dirSeparator);
			if (!path.EndsWith(dirSeparator))
				path += dirSeparator;
			return MainForm.GetLongPathName(path);
		}
		static public string GetLastStringToken(string str, string sep)
		{
			if (str == null) return "";
			if (sep == null) return str;
			int p = str.LastIndexOf(sep);
			return (p >= 0) ? str.Substring(p+1) : str;
		}
		#endregion
		
		#region pathes handling functions
		/// <summary>
		/// Add additional classpathes
		/// </summary>
		static public void SetExternalClassPath(string classPath)
		{
			Context.externalClassPath = classPath;
			Context.BuildClassPath();
		}
		
		/// <summary>
		/// External request to set the additional classpath while a context was busy
		/// </summary>
		static public void SetExternalClassPathWanted(string classPath)
		{
			externalClassPathWanted = classPath;
		}
		
		/// <summary>
		/// Add a path to the classpath
		/// </summary>
		/// <param name="path">Path to add</param>
		public PathModel AddPath(string path)
		{
			try
			{
				path = NormalizePath(path);
				if (path.Length == 0) 
					return null;
				if (!System.IO.Directory.Exists(path))
					path = System.IO.Path.GetDirectoryName(Application.ExecutablePath)+dirSeparator+path;
				if (!System.IO.Directory.Exists(path))
				{
					ErrorHandler.ShowInfo("Invalid path in classpath:\n'"+path+"' "+path.Length);
					return null;
				}
				// avoid duplicated pathes
				string upath = path.ToUpper();
				foreach(PathModel apath in classPath)
				{
					if (apath.Path.ToUpper() == upath)
						return apath;
				}
				// add new path
				DebugConsole.Trace("Add to classpath: "+path);
				PathModel aPath = PathModel.GetModel(path);
				classPath.Add(aPath);
				
				// File System Watchers
				//UpdateWatchers();
				return aPath;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError(ex.Message+"\n"+path, ex);
			}
			return null;
		}
		public PathModel AddPath(PathModel path)
		{
			// avoid duplicated pathes
			string upath = path.Path.ToUpper();
			foreach(PathModel apath in classPath)
			{
				if (apath.Path.ToUpper() == upath)
						return apath;
			}
			// add new path
			classPath.Add(path);
			return path;
		}
		
		/// <summary>
		/// Add the current class' base path to classpath
		/// </summary>
		/// <param name="path">Path to add</param>
		public void SetTemporaryPath(string path)
		{
			if (temporaryPath == path)
				return;
			if (temporaryPath != null)
			{
				if ((classPath[0] as PathModel).Path == temporaryPath) classPath.RemoveAt(0);
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
				//UpdateWatchers();
			}
		}
		#endregion
		
		#region class_resolving_functions
		/// <summary>
		/// Resolve wildcards in imports
		/// </summary>
		/// <param name="package">Package to explore</param>
		/// <param name="inClass">Current class</param>
		/// <param name="known">Packages already added</param>
		public virtual void ResolveImports(string package, ClassModel inClass, ArrayList known)
		{
			// to be implemented
		}
		
		/// <summary>
		/// Retrieves a class model from its name
		/// </summary>
		/// <param name="cname">Class (short or full) name</param>
		/// <param name="inClass">Current file</param>
		/// <returns>A parsed class or an empty ClassModel if the class is not found</returns>
		public virtual ClassModel ResolveClass(string cname, FileModel inFile)
		{
			// to be implemented
			return null;
		}
		
		/// <summary>
		/// Look for a file in cache or parse a new file
		/// </summary>
		/// <param name="filename">Wanted class file</param>
		/// <returns>Parsed model</returns>
		public virtual FileModel GetFileModel(string fileName)
		{
			// to be implemented
			return ASFileParser.ParseFile(fileName);
		}
		
		/// <summary>
		/// Prepare completion's intrinsic known vars/methods/classes
		/// </summary>
		protected virtual void InitTopLevelElements()
		{
			// to be implemented
		}
		
		/// <summary>
		/// Update completion intrinsic know vars
		/// </summary>
		protected virtual void UpdateTopLevelElements()
		{
			// to be implemented
		}
		
		/// <summary>
		/// Find folder and classes in classpath
		/// </summary>
		/// <param name="folder">Path to eval</param>
		/// <param name="completeContent">Return package content</param>
		/// <returns>Package folders and classes</returns>
		public virtual MemberList FindPackage(string folder, bool completeContent)
		{
			// to be implemented
			return null;
		}
		
		/// <summary>
		/// Search all base packages (com, net, org,...) in classpath
		/// </summary>
		/// <returns>Base packages list as members</returns>
		public virtual MemberList GetBasePackages()
		{
			// to be implemented
			return null;
		}
		#endregion
		
		#region plugin_commands
		protected void SetStatusText(string text) 
		{
			MainForm.StatusBar.Panels[0].Text = "  " + text;
		}
		protected string GetStatusText()
		{
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
		public bool BrowseTo(string package)
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
		/// Run command-line compiler in the current class's base folder with current classpath
		/// </summary>
		/// <param name="append">Additional comiler switches</param>
		public virtual void RunCMD(string append)
		{
			// to be implemented
		}
		
		/// <summary>
		/// Calls RunMTASC with additional parameters taken from the classes @mtasc doc tag
		/// </summary>
		public virtual bool BuildCMD(bool failSilently)
		{
			// check if @mtasc is defined
			Match mCmd = null;
			if (IsFileValid() && CurrentClass.Comments != null) 
				mCmd = re_CMD_BuildCommand.Match(CurrentClass.Comments);
			
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
				command = " "+MainForm.ProcessArgString(command)+" ";
				if (command == null || command.Length == 0) 
				{
					if (!failSilently)
						throw new Exception("Preprocessor returned an empty command.");
					return false;
				}
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
						if ((op == "-swf") && (builtSWF == null) && (mPlayIndex < 0))
						{
							int start = mPar[i].Index+mPar[i].Length;
							int end = mPar[i+1].Index;
							if (end > start)
								builtSWF = command.Substring(start,end-start).Trim();
						}
						else if ((op == "-out") && (mPlayIndex < 0))
						{
							int start = mPar[i].Index+mPar[i].Length;
							int end = mPar[i+1].Index;
							if (end > start)
								builtSWF = command.Substring(start,end-start).Trim();
						}
						else if (op == "-header")
						{
							int start = mPar[i].Index+mPar[i].Length;
							int end = mPar[i+1].Index;
							if (end > start) {
								string[] dims = command.Substring(start,end-start).Trim().Split(':');
								if (dims.Length > 2) builtSWFSize = ";"+dims[0]+";"+dims[1];
							}
						}
						else if (op == "-play")
						{
							int start = mPar[i].Index+mPar[i].Length;
							int end = mPar[i+1].Index;
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
			RunCMD(command);
			return true;
		}
		
		public void RunCMD(object sender, EventArgs e)
		{
			RunCMD(MainForm.MainSettings.GetValue(SETTING_CMD_CHECKPARAMS[contextIndex]));
		}
		
		public virtual void HotBuild()
		{
			// to be implemented
		}
		
		/// <summary>
		/// If we have built a SWF, update it and eventually play it
		/// </summary>
		/// <param name="result">Execution result</param>
		public void OnProcessEnd(string result)
		{
			if (GetStatusText() == STATUS_CMD_RUNNING[contextIndex])
			{
				SetStatusText(STATUS_CMD_DONE[contextIndex]);
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
		public void MakeIntrinsic(string files)
		{
			string src = null;
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
			FileModel aFile;
			if (src == null) aFile = cFile;
			else {
				aFile = ASFileParser.ParseFile(src);
			}
			if (aFile.Classes.Count == 0) return;
			//
			string code = aFile.GenerateIntrinsic();
			
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
		
		#region IASContext-specific interface members
		
		public void SetTemporaryBasePath(string fileName, string basePath)
		{
			if (fileName.ToUpper() == CurrentFile.FileName.ToUpper())
				SetTemporaryPath(basePath);
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
