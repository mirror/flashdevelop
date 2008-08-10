/*
 * 
 * User: Philippe Elsass
 * Date: 20/04/2006
 * Time: 22:25
 */

using System;
using System.Windows.Forms;
using System.Collections;
using System.Collections.Specialized;
using System.Text.RegularExpressions;
using System.IO;
using PluginCore;
using PluginCore.Controls;

namespace ASCompletion.Contexts
{
	/// <summary>
	/// Description of Actionscript2.
	/// </summary>
	public class Actionscript2: ASContext
	{
		#region Settings constants
		readonly private string SETTING_FLASH_VERSION = "ASCompletion.AS2.Flash.Version";
		readonly private string SETTING_CMD_USECLASSES = "ASCompletion.AS2.MTASC.UseStdClasses";
		readonly private string SETTING_MM_CLASSES = "ASCompletion.AS2.Macromedia.ClassPath";
		readonly private string SETTING_MM_HOTBUILD = "ASCompletion.AS2.Macromedia.TestOnCtrlEnter";
		readonly private string[] MACROMEDIA_VERSIONS = {
			"\\Macromedia\\Flash 8\\", 
			"\\Macromedia\\Flash MX 2004\\"
		};
		#endregion
		
		// settings
		private string MMClassPath;
		public bool MMHotBuild;
		private string mtascRootFolder;
		private bool useMtascClasses;
		public int flashVersion;

		#region initialization
		protected override void Init()
		{
			// language
			if (!MainForm.MainSettings.HasKey(SETTING_DEFAULT_METHOD_RETURN_TYPE[contextIndex]))
				MainForm.MainSettings.AddValue(SETTING_DEFAULT_METHOD_RETURN_TYPE[contextIndex], "Object");
			if (!MainForm.MainSettings.HasKey(SETTING_FLASH_VERSION))
				MainForm.MainSettings.AddValue(SETTING_FLASH_VERSION, "8");
			
			// mtasc-specific
			if (!MainForm.MainSettings.HasKey(SETTING_CMD_USECLASSES))
				MainForm.MainSettings.AddValue(SETTING_CMD_USECLASSES, "true");
			
			// Macromedia classes folder lookup
			string cp = "";
			if (!MainForm.MainSettings.HasKey(SETTING_MM_CLASSES))
			{
				bool found = false;
				string deflang = System.Globalization.CultureInfo.CurrentUICulture.Name;
				deflang = deflang.Substring(0,2);
				string localAppData = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
				foreach(string path in MACROMEDIA_VERSIONS)
				{
					cp = localAppData + path;
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
				MainForm.MainSettings.AddValue(SETTING_MM_CLASSES, cp);
			}
			if (!MainForm.MainSettings.HasKey(SETTING_MM_HOTBUILD))
				MainForm.MainSettings.AddValue(SETTING_MM_HOTBUILD, "true");
			
			// default classpath
			if (!MainForm.MainSettings.HasKey(SETTING_CLASSPATH[contextIndex]))
			{
				// library folder
				string libraryPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath)+DEFAULT_LIBRARY_PATH;
				if (System.IO.Directory.Exists(libraryPath))
				{
					if (cp.Length > 0) cp += ";";
					cp += libraryPath;
				}
				MainForm.MainSettings.AddValue(SETTING_CLASSPATH[contextIndex], cp);
			}
			
			// contexts common initialization
			base.Init();
		}
		
		public override void UpdateSettings(int index)
		{
			// old settings
			int _flashVersion = flashVersion;
			string _MMClassPath = MMClassPath;
			bool _useMtascClasses = useMtascClasses;
			string _userClassPath = userClassPath;
			
			// flash version
			flashVersion = MainForm.MainSettings.GetInt(SETTING_FLASH_VERSION);
			if (flashVersion < 6)
			{
				ErrorHandler.ShowInfo("Settings Error: Flash version is not valid.");
				flashVersion = 7;
			}
			
			// Pathes
			userClassPath = MainForm.MainSettings.GetValue(SETTING_CLASSPATH[contextIndex]);
			MMClassPath = NormalizePath( MainForm.MainSettings.GetValue(SETTING_MM_CLASSES) );
			MMHotBuild = MainForm.MainSettings.GetBool(SETTING_MM_HOTBUILD);
			
			// MTASC
			useMtascClasses = MainForm.MainSettings.GetBool(SETTING_CMD_USECLASSES);
			mtascRootFolder = NormalizePath( MainForm.MainSettings.GetValue(SETTING_CMD_PATH[contextIndex]) );
			
			// do we need to update the completion engine?
			if ((_flashVersion == flashVersion) && (_useMtascClasses == useMtascClasses)
			     && (_MMClassPath == MMClassPath) && (_userClassPath == userClassPath))
				return;
			
			// update
			BuildClassPath();
		}
		#endregion
		
		#region class caching
		/// <summary>
		/// Classpathes & classes cache initialisation
		/// </summary>
		public override void BuildClassPath()
		{
			DebugConsole.Trace("REFRESH PATHES");
			WatchersLock++;
			
			// external version definition
			string exPath = externalClassPath;
			if (exPath.Length > 0)
			{
				try {
					int p = exPath.IndexOf(';');
					flashVersion = Convert.ToInt16(exPath.Substring(0, p));
					exPath = exPath.Substring(p+1).Trim();
				}
				catch {}
			}
			
			// class pathes
			classPath = new ArrayList();
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
			
			// toplevel elements (MTASC std)
			InitTopLevelElements();

			// add external pathes
			ArrayList initCP = classPath;
			classPath = new ArrayList();
			string[] cpathes;
			DebugConsole.Trace("**** EXTERNAL CP");
			if (exPath.Length > 0)
			{
				cpathes = exPath.Split(';');
				foreach(string cpath in cpathes) AddPath(cpath.Trim());
			}
			// add user pathes from settings
			DebugConsole.Trace("**** USER CP");
			if (userClassPath.Length > 0)
			{
				cpathes = userClassPath.Split(';');
				foreach(string cpath in cpathes) AddPath(cpath.Trim());
			}
			// add initial pathes
			foreach(PathModel mpath in initCP) AddPath(mpath);
			// re-parse current file
			cFile.OutOfDate = true;
			
			// create models
			PathExplorer explorer = new PathExplorer();
			explorer.OnExplorationDone += new PathExplorer.ExplorationDoneHandler(ExplorationDone);
			explorer.ExploreClasspath(classPath);
			
			// update File System Watchers
			WatchersLock--;
			//UpdateWatchers();
			
		}
		
				/// <summary>
		/// Delete current class's ASO file
		/// </summary>
		public override void RemoveClassCompilerCache()
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
		/// TODO  change to FileModel
		/// </summary>
		/// <param name="aClass">Class object</param>
		/// <returns>The class object</returns>
		public override ClassModel UpdateClass(ClassModel aClass)
		{
			/*if (aClass.InFile == null || !aClass.InFile.OutOfDate) 
				return aClass;
			
			// remove from cache
			if (!aClass.IsVoid())
				classes.Remove(aClass.ClassName);
			// (re)parse
			FileModel aFile = ASFileParser.ParseFile(aClass.InFile);
			aClass = aFile.GetPublicClass();
			// add to cache
			AddClassToCache(aClass);*/
			return aClass;
		}
		
		/// <summary>
		/// (Re)Parse and cache the current class file
		/// TODO  change to FileModel
		/// </summary>
		/// <param name="aClass">Class object</param>
		/// <returns>The class object</returns>
		private ClassModel UpdateCurrentClass()
		{
			/*if (cClass.InFile == null || !cClass.InFile.OutOfDate) 
				return cClass;
			
			// try to get current text
			ScintillaNet.ScintillaControl sci = MainForm.CurSciControl;
			if (sci == null)
				return UpdateClass(cClass);
			
			// remove from cache
			if (!cClass.IsVoid())
				classes.Remove(cClass.ClassName);
			// (re)parse
			FileModel aFile = ASFileParser.ParseFile(cClass.InFile);
			cClass = cFile.GetPublicClass();
			// add to cache
			AddClassToCache(cClass);*/
			return cClass;
		}
		
		/// <summary>
		/// Add the class object to a cache
		/// TODO  change to FileModel
		/// </summary>
		/// <param name="aClass">Class object to cache</param>
		private bool AddClassToCache(ClassModel aClass)
		{
			/*if (!aClass.IsVoid())
			{
				ClassModel check = (ClassModel)classes[aClass.ClassName];
				if (check != null && lastClassWarning != aClass.ClassName)
				{
					// if this class was defined in another file, check if it is still open
					if (String.CompareOrdinal(check.InFile.FileName, aClass.InFile.FileName) != 0)
					{
						ScintillaNet.ScintillaControl sci = MainForm.CurSciControl;
						WeifenLuo.WinFormsUI.DockContent[] docs = MainForm.GetDocuments();
						int found = 0;
						bool isActive = false;
						string tabFile;
						// check if the classes are open
						foreach(WeifenLuo.WinFormsUI.DockContent doc in docs)
						{
							tabFile = MainForm.GetSciControl(doc).Tag.ToString();
							if (String.CompareOrdinal(check.InFile.FileName, tabFile) == 0
							    || String.CompareOrdinal(aClass.InFile.FileName, tabFile) == 0)
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
							                           aClass.InFile.FileName, line, aClass.ClassName, check.InFile.FileName);
							MessageBar.ShowWarning(msg);
						}
						else lastClassWarning = null;
					}
				}
				classes[aClass.ClassName] = aClass;
				return true;
			}*/
			return false;
		}
		#endregion
		
		#region class resolution
		
		public override ClassModel CurrentClass 
		{
			get {
				if (cClass == null)
				{
					cClass = ClassModel.VoidClass;
					cFile.OutOfDate = true;
				}
				// update class
				if (cFile.OutOfDate)
				{
					DebugConsole.Trace("Current file is out of date "+cFile.FileName);
					if (cFile.FileName.Length > 0)
					{
						string prevClassName = cClass.ClassName;
						UpdateCurrentClass();
						if (Panel != null)
							Panel.UpdateView(cFile);
					}
					// update "this" and "super" special vars
					UpdateTopLevelElements();
				}
				return cClass;
			}
		}
		
		/// <summary>
		/// Resolve wildcards in imports
		/// TODO  change to FileModel
		/// </summary>
		/// <param name="package">Package to explore</param>
		/// <param name="inClass">Current class</param>
		/// <param name="known">Packages already added</param>
		public override void ResolveImports(string package, ClassModel inClass, ArrayList known)
		{
			string subpath;
			string path;
			string[] files;
			
			// validation
			if ((package == null) || (inClass == null)) return;
			subpath = package.Replace(".", dirSeparator);
			
			// search in classpath
			MemberModel newImport;
			string basepath = "";
			foreach(PathModel aPath in classPath)
			try
			{
				basepath = aPath.Path;
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
						newImport = new MemberModel();
						newImport.Name = GetLastStringToken(package, ".");
						newImport.Type = package;
						inClass.InFile.Imports.Add(newImport);
					}
				}
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError(ex.Message+"\n"+basepath+subpath, ex);
			}
		}
		
		/// <summary>
		/// Retrieves a class model from its name
		/// </summary>
		/// <param name="cname">Class (short or full) name</param>
		/// <param name="inClass">Current file</param>
		/// <returns>A parsed class or an empty ClassModel if the class is not found</returns>
		public override ClassModel ResolveClass(string cname, FileModel inFile)
		{
			ClassModel aClass;
			if ((cname == null) || (cname.Length == 0)) cname = defaultMethodReturnType;
			
			if (inFile != null)
				DebugConsole.Trace("Find class "+cname+" in "+inFile.FileName);
			else
				DebugConsole.Trace("Find class "+cname);
			
			// unknown
			if ((cname == "Void") || (classPath == null))
				return ClassModel.VoidClass;
			
			string package = "";
			if (inFile != null)
			{
				// TODO  recognize current class
				/*if (inClass.Extends != null 
				    && (inClass.ClassName.IndexOf('.') > 0) && (cname == GetLastStringToken(inClass.ClassName, ".")))
				{
					return inClass;
				}*/
				int p = cname.IndexOf(".");
				// qualify class name
				if (p < 0) 
				{
					// search in imported classes
					foreach(MemberModel import in inFile.Imports)
					if (import.Name == cname) {
						package = import.Type.Substring(0, import.Type.Length-cname.Length-1);
						break;
					}
				}
				else
				{
					package = cname.Substring(0, p);
					cname = cname.Substring(p+1);
				}
			}
			DebugConsole.Trace("Resolve "+package+"."+cname);
			
			// retrieve class from cache
			foreach(PathModel aPath in classPath)
			{
				aClass = aPath.Resolve(package, cname);
				if (aClass != null) return aClass;
			}

			DebugConsole.Trace("In classpath "+cname);
			// search in classpath
			aClass = ClassModel.VoidClass;
			string file = cname.Replace(".", dirSeparator)+".as";
			string path = "";
			FileModel aFile;
			foreach(PathModel aPath in classPath)
			try
			{
				path = aPath.Path;
				if (File.Exists(path+file))
				{
					aFile = aPath.GetFile(path+file);
					aClass = aFile.GetPublicClass();
					break;
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
		/// Look for a file in cache or parse a new file
		/// </summary>
		/// <param name="filename">Wanted class file</param>
		/// <returns>Parsed model</returns>
		public override FileModel GetFileModel(string fileName)
		{
			if ((fileName == null) || (fileName.Length == 0) || !File.Exists(fileName))
				return null;
			return PathModel.FindFile(fileName);
		}
		
		/// <summary>
		/// Update Flash intrinsic know vars
		/// </summary>
		protected override void UpdateTopLevelElements()
		{
			try
			{
			if (cFile == null || cClass == null || cClass.IsVoid())
				return;
			MemberModel special;
			special = topLevel.Members.Search("this",0);
			if (special != null)
			{
				special.Type = cClass.ClassName;
			}
			special = topLevel.Members.Search("super",0);
			if (special != null) 
			{
				if ((cClass.Extends != null) && !cClass.Extends.IsVoid())
					special.Type = cClass.Extends.ClassName;
				else
					special.Type = "Object";
			}
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError(ex.Message+"\n"+ex.StackTrace, ex);
			}
		}
		
		/// <summary>
		/// Prepare AS2 intrinsic known vars/methods/classes
		/// TODO  Parse MM top-level class / FileModel?
		/// </summary>
		protected override void InitTopLevelElements()
		{
			topLevel = new FileModel("");
			//
			// search top-level class
			//
			if (useMtascClasses)
			{
				ClassModel tlClass = ResolveClass("TopLevel",null);
				if (!tlClass.IsVoid()) 
				{
					topLevel.FileName = tlClass.InFile.FileName;
					foreach(MemberModel member in tlClass.Members) 
					{
						topLevel.Members.Add(member);
					}
				}
			}
			/*else
			{
				topLevel = new ClassModel();
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
				ASFileParser.ParseClass(topLevel, src);
			}*/
			// not found
			if (topLevel.FileName.Length == 0)
			{
				//ErrorHandler.ShowInfo("Top-level elements class not found. Please check your Program Settings.");
				//return;
			}
			
			//
			// init top-level elements
			//
			// special vars
			MemberModel special;
			if (topLevel.Members.Search("_root",0) == null)
			{
				special = new MemberModel();
				special.Name = "_root";
				special.Flags = FlagType.Variable;
				special.Type = "MovieClip";
				topLevel.Members.Add(special);
			}
			if (topLevel.Members.Search("_global",0) == null)
			{
				special = new MemberModel();
				special.Name = "_global";
				special.Flags = FlagType.Variable;
				special.Type = "Object";
				topLevel.Members.Add(special);
			}
			if (topLevel.Members.Search("this",0) == null)
			{
				special = new MemberModel();
				special.Name = "this";
				special.Flags = FlagType.Variable;
				special.Type = "Object";
				topLevel.Members.Add(special);
			}
			if (topLevel.Members.Search("super",0) == null)
			{
				special = new MemberModel();
				special.Name = "super";
				special.Flags = FlagType.Variable;
				special.Type = "Object";
				topLevel.Members.Add(special);
			}
			// pre-sort
			topLevel.Members.Sort();
			
			// all intrinsic methods/vars
			foreach(MemberModel member in topLevel.Members)
				member.Flags |= FlagType.Intrinsic;
			
			// TODO list instrinsic classes
			/*string package;
			MemberModel newImport;
			string path;
			foreach(PathModel aPath in classPath)
			{
				path = aPath.Path;
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
						newImport = new MemberModel();
						newImport.Name = iname;
						newImport.Type = package;
						newImport.Flags = FlagType.Intrinsic;
						if (!iname.Equals("TopLevel") && !iname.Equals("StdPresent") 
						    && (iname.IndexOf(' ') < 0) && (topLevel.Imports.Search(iname, 0) == null))
							topLevel.Imports.Add(newImport);
					}
					// special case
					newImport = new MemberModel();
					newImport.Name = "Void";
					newImport.Type = "Void";
					newImport.Flags = FlagType.Intrinsic;
					topLevel.Imports.Add(newImport);
					topLevel.Imports.Sort();
				}
				catch(Exception ex)
				{
					ErrorHandler.ShowError(ex.Message+"\n"+path, ex);
					continue;
				}
			}*/
		}
		
		/// <summary>
		/// Find folder and classes in classpath
		/// </summary>
		/// <param name="folder">Path to eval</param>
		/// <param name="completeContent">Return package content</param>
		/// <returns>Package folders and classes</returns>
		public override MemberList FindPackage(string folder, bool completeContent)
		{
			if ((folder == null) || (folder.Length == 0))
				return null;
			MemberList package = new MemberList();
			MemberModel pathMember;
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
					dirEntries = System.IO.Directory.GetDirectories(path+folder);
					if (dirEntries != null)
					foreach(string entry in dirEntries)
					{
						cname = GetLastStringToken(entry, dirSeparator);
						if ((cname.Length > 0) && !cname.StartsWith("_") 
						    && (cname.IndexOf(' ') < 0) && (cname.IndexOf('.') < 0)
						    && (package.Search(cname, 0) == null))
						{
							pathMember = new MemberModel();
							pathMember.Flags = FlagType.Package;
							pathMember.Type = folder.Replace(dirSeparatorChar, '.')+"."+cname;
							pathMember.Name = cname;
							package.Add(pathMember);
						}
					}
					
					// add sub classes
					dirEntries = System.IO.Directory.GetFiles(path+folder);
					if (dirEntries != null)
					foreach(string entry in dirEntries)
					if (entry.EndsWith(".as")) {
						cname = GetLastStringToken(entry, dirSeparator);
						cname = cname.Substring(0, cname.LastIndexOf("."));
						pathMember = package.Search(cname, 0);
						if ((pathMember == null) && (cname.Length > 0) 
						    && (cname.IndexOf(' ') < 0) && (cname.IndexOf('.') < 0))
						{
							pathMember = new MemberModel();
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
		public override MemberList GetBasePackages()
		{
			MemberList packages = new MemberList();
			MemberModel package;
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
					fileEntries = System.IO.Directory.GetFiles(path, "*.as");
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
							package = new MemberModel();
							package.Flags = 0;
							package.Type = package.Name = cname;
							packages.Add(package);
						}
					}
				}
				// base packages
				if (notMacromedia)
				{
					dirEntries = System.IO.Directory.GetDirectories(path);
					if (dirEntries != null)
					foreach(string entry in dirEntries)
					{
						cname = GetLastStringToken(entry, dirSeparator);
						if (!cname.StartsWith("_") && (cname.IndexOf(' ') < 0) && (cname.IndexOf('.') < 0)
						    && (packages.Search(cname, 0) == null))
						{
							//DebugConsole.Trace("Base package "+cname);
							package = new MemberModel();
							package.Flags = FlagType.Package;
							package.Type = package.Name = cname;
							packages.Add(package);
						}
					}
				}
				else if (packages.Search("mx", 0) == null)
				{
					package = new MemberModel();
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
		
		#region command line compiler
		/// <summary>
		/// Run MTASC compiler in the current class's base folder with current classpath
		/// </summary>
		/// <param name="append">Additional comiler switches</param>
		public override void RunCMD(string append)
		{
			DebugConsole.Trace("> RunMTASC "+CurrentClass.IsVoid());
			
			if (!IsFileValid())
				return;
			if (mtascRootFolder.Length == 0)
			{
				ErrorHandler.ShowInfo("MTASC's path is not correctly set. Please check your Program Settings.");
				return;
			}
			
			SetStatusText(STATUS_CMD_RUNNING[contextIndex]);
			
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
		/// Calls RunCMD with additional parameters taken from the classes @mtasc doc tag
		/// </summary>
		public override bool BuildCMD(bool failSilently)
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
		
		public override void HotBuild()
		{
			if (MMHotBuild)
			{
				// test movie
				CommandBarButton item = ASContext.MainForm.GetCBButton("TestInFlashButton");
				if ((item != null) && (item.Tag != null))
				{
					ASContext.MainForm.CallCommand("PluginCommand", (string)item.Tag);
				}
			}
		}
		#endregion
	}
}
