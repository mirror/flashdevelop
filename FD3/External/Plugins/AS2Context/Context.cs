using System;
using System.Collections;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.IO;
using System.Diagnostics;
using System.Windows.Forms;
using PluginCore;
using PluginCore.Managers;
using PluginCore.Controls;
using ASCompletion.Context;
using ASCompletion.Completion;
using ASCompletion.Model;
using ASCompletion.Settings;
using PluginCore.Localization;
using PluginCore.Helpers;

namespace AS2Context
{
	/// <summary>
	/// Actionscript2 context
	/// </summary>
	public class Context: ASContext
	{
        #region regular_expressions_definitions
        static readonly protected Regex re_CMD_BuildCommand =
            new Regex("@mtasc[\\s]+(?<params>.*)", RegexOptions.Compiled | RegexOptions.Multiline);
        static readonly protected Regex re_SplitParams =
            new Regex("[\\s](?<switch>\\-[A-z]+)", RegexOptions.Compiled | RegexOptions.Singleline);
        static protected readonly Regex re_level =
            new Regex("^_level[0-9]+$", RegexOptions.Compiled | RegexOptions.Singleline);
        static protected readonly Regex re_token =
            new Regex("^[a-z$][a-z0-9$_]*$", RegexOptions.IgnoreCase | RegexOptions.Compiled);
        static protected readonly Regex re_package =
            new Regex("^[a-z$][a-z0-9$_.]*$", RegexOptions.IgnoreCase | RegexOptions.Compiled);
        #endregion

        #region initialization

        protected int flashVersion;
        protected bool hasLevels = true;
        protected string docType;

        private AS2Settings as2settings;

        public override IContextSettings Settings
        {
            get { return settings; }
            set { settings = value; }
        }

        /// <summary>
        /// Do not call directly
        /// </summary>
        protected Context()
        {
        }

		public Context(AS2Settings initSettings)
        {
            as2settings = initSettings;

            /* AS-LIKE OPTIONS */

            hasLevels = true;
            docType = "MovieClip";

            /* DESCRIBE LANGUAGE FEATURES */

            // language constructs
            features.hasImports = true;
            features.hasImportsWildcard = true;
            features.hasClasses = true;
            features.hasExtends = true;
            features.hasImplements = true;
            features.hasInterfaces = true;
            features.hasEnums = false;
            features.hasGenerics = false;
            features.hasEcmaTyping = true;
            features.hasVars = true;
            features.hasConsts = false;
            features.hasMethods = true;
            features.hasStatics = true;
            features.hasTryCatch = true;
            features.checkFileName = true;

            // allowed declarations access modifiers
            features.classModifiers = Visibility.Public | Visibility.Private;
            features.varModifiers = Visibility.Public | Visibility.Private;
            features.methodModifiers = Visibility.Public | Visibility.Private;

            // default declarations access modifiers
            features.classModifierDefault = Visibility.Public;
            features.varModifierDefault = Visibility.Public;
            features.methodModifierDefault = Visibility.Public;

            // keywords
            features.dot = ".";
            features.voidKey = "Void";
            features.objectKey = "Object";
            features.importKey = "import";
            features.typesPreKeys = new string[] { "import", "new", "instanceof", "extends", "implements" };
            features.codeKeywords = new string[] { 
                "var", "function", "new", "delete", "instanceof", "return", "break", "continue",
                "if", "else", "for", "in", "while", "do", "switch", "case", "default", "with",
                "null", "undefined", "true", "false", "try", "catch", "finally", "throw"
            };
            features.varKey = "var";
            features.functionKey = "function";
            features.getKey = "get";
            features.setKey = "set";
            features.staticKey = "static";
            features.overrideKey = "override";
            features.publicKey = "public";
            features.privateKey = "private";
            features.intrinsicKey = "intrinsic";

            features.functionArguments = new MemberModel("arguments", "FunctionArguments", FlagType.Variable | FlagType.LocalVar, 0);

            /* INITIALIZATION */

            settings = initSettings;
            //BuildClassPath(); // defered to first use
		}
		#endregion
		
		#region classpath management
		/// <summary>
		/// Classpathes & classes cache initialisation
		/// </summary>
		public override void BuildClassPath()
        {
            ReleaseClasspath();
            started = true;
            if (as2settings == null) throw new Exception("BuildClassPath() must be overridden");

			// external version definition
            // expected from project manager: "8;path;path..."
            flashVersion = as2settings.DefaultFlashVersion;
            string exPath = externalClassPath ?? "";
			if (exPath.Length > 0)
			{
				try {
					int p = exPath.IndexOf(';');
					flashVersion = Convert.ToInt16(exPath.Substring(0, p));
					exPath = exPath.Substring(p+1).Trim();
				}
				catch {}
			}
			
            //
			// Class pathes
            //
			classPath = new List<PathModel>();
            // MTASC
            string mtascPath = PathHelper.ResolvePath(as2settings.MtascPath) ?? "";
            if (Path.GetExtension(mtascPath) != "") mtascPath = Path.GetDirectoryName(mtascPath);
            string path;
            if ((as2settings.UseMtascIntrinsic || as2settings.MMClassPath.Length == 0)
                && mtascPath.Length > 0 && System.IO.Directory.Exists(mtascPath))
			{
				try 
				{
                    if (flashVersion == 9)
                    {
                        path = Path.Combine(mtascPath, "std9");
                        if (System.IO.Directory.Exists(path)) AddPath(path);
                        else flashVersion = 8;
                    }
                    if (flashVersion == 8)
                    {
                        path = Path.Combine(mtascPath, "std8");
                        if (System.IO.Directory.Exists(path)) AddPath(path);
                    }
                    path = Path.Combine(mtascPath, "std");
                    if (System.IO.Directory.Exists(path)) AddPath(path);
				}
				catch {}
			}
			// Macromedia/Adobe
            if (as2settings.MMClassPath != null && System.IO.Directory.Exists(as2settings.MMClassPath))
            {
                if (classPath.Count == 0)
                {
                    // Flash CS3: the FP9 classpath overrides some classes of FP8
                    int tempVersion = flashVersion;
                    if (tempVersion > 8)
                    {
                        path = Path.Combine(as2settings.MMClassPath, "FP" + tempVersion);
                        if (System.IO.Directory.Exists(path))
                            AddPath(path);
                        // now add FP8
                        tempVersion = 8;
                    }
                    path = Path.Combine(as2settings.MMClassPath, "FP" + Math.Max(7, tempVersion));
                    if (System.IO.Directory.Exists(path)) AddPath(path);
                }
            }
			// add external pathes
			List<PathModel> initCP = classPath;
			classPath = new List<PathModel>();
			string[] cpathes;
			if (exPath.Length > 0)
			{
				cpathes = exPath.Split(';');
				foreach(string cpath in cpathes) AddPath(cpath.Trim());
			}
            // add library
            AddPath(Path.Combine(PathHelper.LibraryDir, "AS2/classes"));
			// add user pathes from settings
            if (settings.UserClasspath != null && settings.UserClasspath.Length > 0)
			{
				foreach(string cpath in settings.UserClasspath) AddPath(cpath.Trim());
			}
			// add initial pathes
			foreach(PathModel mpath in initCP) AddPath(mpath);

            // parse top-level elements
            InitTopLevelElements();
            if (cFile != null) UpdateTopLevelElements();
			
            // add current temporaty path
            if (temporaryPath != null)
            {
                string tempPath = temporaryPath;
                temporaryPath = null;
                SetTemporaryPath(tempPath);
            }
            FinalizeClasspath();
		}
		
		/// <summary>
		/// Delete current class's ASO file
		/// </summary>
		public override void RemoveClassCompilerCache()
		{
            if (as2settings == null) return;

            ClassModel pClass = cFile.GetPublicClass();
            if (as2settings.MMClassPath == null || pClass.IsVoid())
				return;
            string package = (cFile.Package.Length > 0) ? cFile.Package + "." : "";
            string packagePath = dirSeparator + package.Replace('.', dirSeparatorChar);
            string file = Path.Combine(as2settings.MMClassPath, "aso") + packagePath + package + pClass.Name + ".aso";
			try
			{
				if (File.Exists(file)) File.Delete(file);
			}
			catch {}
		}
        #endregion

        #region class resolution
		
		public override ClassModel CurrentClass 
		{
			get 
            {
                if (cFile == FileModel.Ignore)
                {
                    return ClassModel.VoidClass;
                }
				if (cClass == null)
				{
					cClass = ClassModel.VoidClass;
					cFile.OutOfDate = true;
				}
				// update class
				if (cFile.OutOfDate)
				{
					if (cFile.FileName.Length > 0)
					{
						string prevClassName = cClass.Name;
						UpdateCurrentFile(true);
					}
					// update "this" and "super" special vars
					UpdateTopLevelElements();
				}
				return cClass;
			}
		}

        /// <summary>
        /// Evaluates the visibility of one given type from another.
        /// Caller is responsible of calling ResolveExtends() on 'inClass'
        /// </summary>
        /// <param name="inClass">Completion context</param>
        /// <param name="withClass">Completion target</param>
        /// <returns>Completion visibility</returns>
        public override Visibility TypesAffinity(ClassModel inClass, ClassModel withClass)
        {
            if (inClass == null || withClass == null) return Visibility.Public;
            // inheritance affinity
            ClassModel tmp = inClass;
            while (!tmp.IsVoid())
            {
                if (tmp.Type == withClass.Type)
                    return Visibility.Public | Visibility.Private;
                tmp = tmp.Extends;
            }
            // public only
            return Visibility.Public;
        }

        /// <summary>
        /// Default types inheritance
        /// </summary>
        /// <param name="package">File package</param>
        /// <param name="classname">Class name</param>
        /// <returns>Inherited type</returns>
        public override string DefaultInheritance(string package, string classname)
        {
            if (package.Length == 0 && classname == features.objectKey) return features.voidKey;
            else return features.objectKey;
        }

        /// <summary>
        /// Top-level elements lookup
        /// </summary>
        /// <param name="token">Element to search</param>
        /// <param name="result">Response structure</param>
        public override void ResolveTopLevelElement(string token, ASResult result)
        {
            if (topLevel != null && topLevel.Members.Count > 0)
            {
                // current class
                ClassModel inClass = ASContext.Context.CurrentClass;
                if (token == "this")
                {
                    result.Member = topLevel.Members.Search("this", 0, 0);
                    result.Type = inClass;
                    result.inFile = ASContext.Context.CurrentModel;
                    return;
                }
                else if (token == "super" && !inClass.IsVoid())
                {
                    inClass.ResolveExtends();
                    ClassModel extends = inClass.Extends;
                    if (!extends.IsVoid())
                    {
                        result.Member = topLevel.Members.Search("super", 0, 0);
                        result.Type = extends;
                        result.inFile = extends.InFile;
                        return;
                    }
                }

                // other top-level elements
                ASComplete.FindMember(token, topLevel, result, 0, 0);
                if (!result.IsNull()) return;

                // special _levelN
                if (hasLevels && token.StartsWith("_") && re_level.IsMatch(token))
                {
                    result.Member = new MemberModel();
                    result.Member.Name = token;
                    result.Member.Flags = FlagType.Variable;
                    result.Member.Type = "MovieClip";
                    result.Type = ResolveType("MovieClip", null);
                    result.inFile = topLevel;
                }
            }
        }

        /// <summary>
        /// Return imported classes list (not null)
        /// </summary>
        /// <param name="package">Package to explore</param>
        /// <param name="inFile">Current file</param>
        public override MemberList ResolveImports(FileModel inFile)
		{
            bool filterImports = (inFile == cFile);
            int lineMin = (filterImports && inPrivateSection) ? inFile.PrivateSectionIndex : 0;
            int lineMax = (filterImports && inPrivateSection) ? int.MaxValue : inFile.PrivateSectionIndex;
            MemberList imports = new MemberList();
            foreach (MemberModel item in inFile.Imports)
            {
                if (filterImports && (item.LineFrom < lineMin || item.LineFrom > lineMax)) continue;

                if (item.Name != "*")
                {
                    if (settings.LazyClasspathExploration) imports.Add(item);
                    else
                    {
                        ClassModel type = ResolveType(item.Type, null);
                        if (!type.IsVoid()) imports.Add(type);
                        else 
                        {
                            // package-level declarations
                            int p = item.Type.LastIndexOf('.');
                            if (p < 0) continue;
                            string package = item.Type.Substring(0, p);
                            string token = item.Type.Substring(p+1);
                            FileModel pack = ResolvePackage(package, false);
                            if (pack == null) continue;
                            MemberModel member = pack.Members.Search(token, 0, 0);
                            if (member != null) imports.Add(member);
                        }
                    }
                }
                else
                {
                    // classes matching wildcard
                    FileModel matches = ResolvePackage(item.Type.Substring(0, item.Type.Length - 2), false);

                    if (matches != null)
                    {
                        foreach (MemberModel import in matches.Imports)
                            imports.Add(import);
                        foreach (MemberModel member in matches.Members)
                            imports.Add(member);
                    }
                }
            }
            return imports;
        }

        /// <summary>
        /// Check if a type is already in the file's imports
        /// Throws an Exception if the type name is ambiguous 
        /// (ie. same name as an existing import located in another package)
        /// </summary>
        /// <param name="member">Element to search in imports</param>
        /// <param name="atLine">Position in the file</param>
        public override bool IsImported(MemberModel member, int atLine)
        {
            FileModel cFile = ASContext.Context.CurrentModel;
            string fullName = member.Type;
            string name = member.Name;
            int lineMin = (ASContext.Context.InPrivateSection) ? cFile.PrivateSectionIndex : 0;
            int lineMax = atLine;
            foreach (MemberModel import in cFile.Imports)
            {
                if (import.LineFrom >= lineMin && import.LineFrom <= lineMax && import.Name == name)
                {
                    if (import.Type != fullName) throw new Exception("Ambiguous Type");
                    return true;
                }
                else if (import.Name == "*" && import.Type.Replace("*", name) == fullName)
                    return true;
            }
            return false;
        }

		/// <summary>
		/// Retrieves a class model from its name
		/// </summary>
		/// <param name="cname">Class (short or full) name</param>
		/// <param name="inClass">Current file</param>
		/// <returns>A parsed class or an empty ClassModel if the class is not found</returns>
        public override ClassModel ResolveType(string cname, FileModel inFile)
		{
            // unknown type
            if (cname == null || cname.Length == 0 || cname == features.voidKey || classPath == null) 
                return ClassModel.VoidClass;

            // typed array
            if (cname.IndexOf('$') > 0)
                return ResolveTypeIndex(cname, inFile);

            string package = "";
            int p = cname.LastIndexOf('.');
            if (p > 0 && p < cname.Length - 1 && cname[p + 1] != '<')
            {
                package = cname.Substring(0, p);
                cname = cname.Substring(p + 1);
            }

            // quick check in current file
            if (inFile != null && inFile.Classes.Count > 0)
            {
                foreach (ClassModel aClass in inFile.Classes)
                {
                    if (aClass.Name == cname && (package == "" || package == inFile.Package))
                    {
                        return aClass;
                    }
                }
            }

            // package reference for resolution
            string inPackage = (features.hasPackages && inFile != null) ? inFile.Package : "";

            // search in imported classes
            if (package == "" && inFile != null)
            {
                foreach (MemberModel import in inFile.Imports)
                {
                    if (import.Name == "*" && import.Type.Length > 2)
                    {
                        // try wildcards
                        string testPackage = import.Type.Substring(0, import.Type.Length - 2);
                        if (settings.LazyClasspathExploration)
                        {
                            ClassModel testClass = GetModel(testPackage, cname, inPackage);
                            if (!testClass.IsVoid()) return testClass;
                        }
                        else
                        {
                            FileModel pack = ResolvePackage(testPackage, false);
                            if (pack == null) continue;
                            MemberModel found = pack.Imports.Search(cname, 0, 0);
                            if (found != null) return ResolveType(found.Type, null);
                            //found = pack.Members.Search(cname, 0, 0);
                            //if (found != null)
                        }
                    }
                    else if (import.Name == cname)
                    {
                        if (import.Type.Length > import.Name.Length)
                            package = import.Type.Substring(0, import.Type.Length - cname.Length - 1);
                        break;
                    }
                }
            }

            // search in classpath
            return GetModel(package, cname, inPackage);
        }

        private ClassModel ResolveTypeIndex(string cname, FileModel inFile)
        {
            int p = cname.IndexOf('$');
            if (p < 0) return ClassModel.VoidClass;
            string indexType = cname.Substring(p + 1);
            string baseType = cname.Substring(0, p);

            ClassModel originalClass = ResolveType(baseType, inFile);
            if (originalClass.IsVoid()) return originalClass;

            ClassModel indexClass = ResolveType(indexType, inFile);
            if (indexClass.IsVoid()) return originalClass;
            indexType = indexClass.QualifiedName;

            FileModel aFile = originalClass.InFile;
            // is the type already cloned?
            foreach (ClassModel otherClass in aFile.Classes)
                if (otherClass.IndexType == indexType) return otherClass;

            // clone the type
            ClassModel aClass = originalClass.Clone() as ClassModel;

            aClass.Name = baseType + "$" + indexType;
            aClass.IndexType = indexType;

            // special AS3 Proxy support
            if (originalClass.QualifiedName == "flash.utils.Proxy")
            {
                // have the proxy extend the index type
                aClass.ExtendsType = indexType;
            }
            // replace 'Object' and '*' by the index type
            else
            foreach (MemberModel member in aClass.Members)
            {
                if (member.Type == features.objectKey || member.Type == "*") member.Type = indexType;
                if (member.Parameters != null)
                {
                    foreach (MemberModel param in member.Parameters)
                    {
                        if (param.Name == "value" 
                            && (param.Type == features.objectKey || param.Type == "*"))
                            param.Type = indexType;
                    }
                }
            }

            aFile.Classes.Add(aClass);
            return aClass;
        }

        /// <summary>
        /// Search a fully qualified class in classpath
        /// </summary>
        /// <param name="package">Class package</param>
        /// <param name="cname">Class name</param>
        /// <param name="inPackage">Package reference for resolution</param>
        /// <returns></returns>
        public override ClassModel GetModel(string package, string cname, string inPackage)
        {
			if (!settings.LazyClasspathExploration)
            {
                bool testSamePackage = package.Length == 0 && features.hasPackages;
                foreach (PathModel aPath in classPath) if (aPath.IsValid && !aPath.Updating)
                {
                    foreach (FileModel aFile in aPath.Files.Values)
                    {
                        // qualified path
                        if (aFile.Package == package && aFile.Classes.Count > 0)
                        {
                            foreach (ClassModel aClass in aFile.Classes)
                            {
                                if (aClass.Name == cname) return aClass;
                            }
                        }
                        // in the same package
                        else if (testSamePackage && aFile.Package == inPackage)
                        {
                            foreach (ClassModel aClass in aFile.Classes)
                            {
                                if (aClass.Name == cname) return aClass;
                            }
                        }
                    }
                }
                if (classPath.Count > 0 && classPath[0].IsTemporaryPath)
                {
                    // guess file name
                    string fullClass = ((package.Length > 0) ? package + "." : "") + cname;
                    string fileName = fullClass.Replace(".", dirSeparator) + ".as";

                    ClassModel model = LocateClassFile(classPath[0], fileName);
                    if (model != null) return model;
                    else return ClassModel.VoidClass;
                }
            }
            else
            {
                // guess file name
                string fullClass = ((package.Length > 0) ? package + "." : "") + cname;
                string fileName = fullClass.Replace(".", dirSeparator) + ".as";

                foreach (PathModel aPath in classPath) if (aPath.IsValid && !aPath.Updating)
                {
                    ClassModel model = LocateClassFile(aPath, fileName);
                    if (model != null) return model;
                }
            }
            return ClassModel.VoidClass;
		}

        private ClassModel LocateClassFile(PathModel aPath, string fileName)
        {
            if (!aPath.IsValid) return null;
            try
            {
                string path = Path.Combine(aPath.Path, fileName);
                // cached file
                if (aPath.HasFile(path))
                {
                    FileModel nFile = aPath.Files[path.ToUpper()];
                    if (nFile.Context != this)
                    {
                        // not associated with this context -> refresh
                        nFile.OutOfDate = true;
                        nFile.Context = this;
                    }
                    return nFile.GetPublicClass();
                }
                // non-cached existing file
                else if (File.Exists(path))
                {
                    FileModel nFile = GetFileModel(path);
                    if (nFile != null)
                    {
                        aPath.AddFile(nFile);
                        return nFile.GetPublicClass();
                    }
                }
            }
            catch (Exception ex)
            {
                aPath.IsValid = false;
                ErrorManager.ShowError(ex);
            }
            return null;
        }

        /// <summary>
        /// Update model if needed and warn user if it has problems
        /// <param name="onFileOpen">Flag indicating it is the first model check</param>
        /// </summary>
        public override void CheckModel(bool onFileOpen)
        {
            if (!File.Exists(cFile.FileName))
            {
                // refresh model
                base.CheckModel(onFileOpen);
                return;
            }
            string prevPackage = (onFileOpen) ? null : cFile.Package;
            string prevCname = (onFileOpen) ? null : cFile.GetPublicClass().Name;
            // refresh model
            base.CheckModel(onFileOpen);

            if (features.checkFileName && cFile.Version > 1)
            {
                string package = cFile.Package;
                ClassModel pClass = cFile.GetPublicClass();
                if (package.Length > 0)
                {
                    string pathname = package.Replace('.', Path.DirectorySeparatorChar);
                    string fullpath = Path.GetDirectoryName(cFile.FileName);
                    if (!fullpath.ToUpper().EndsWith(pathname.ToUpper()))
                    {
                        string msg = String.Format("The package '{0}' does not match the file path:", package)
                            + "\n" + cFile.FileName;
                        MessageBar.ShowWarning(msg);
                        return;
                    }
                }
                if (!pClass.IsVoid())
                {
                    string cname = pClass.Name;
                    if (prevPackage != package || prevCname != cname)
                    {
                        if (package.Length > 0) cname = package + "." + cname;
                        string filename = cname.Replace('.', Path.DirectorySeparatorChar) + Path.GetExtension(cFile.FileName);
                        if (!cFile.FileName.ToUpper().EndsWith(filename.ToUpper()))
                        {
                            string msg = String.Format("The type '{0}' does not match the file name:", cname)
                                + "\n" + cFile.FileName;
                            MessageBar.ShowWarning(msg);
                        }
                    }
                }
            }
        }


		/// <summary>
		/// Update Flash intrinsic known vars
		/// </summary>
		protected override void UpdateTopLevelElements()
		{
		    MemberModel special;
		    special = topLevel.Members.Search("this",0,0);
		    if (special != null)
		    {
                if (!cClass.IsVoid()) special.Type = cClass.Name;
                else special.Type = (cFile.Version > 1) ? features.voidKey : docType;
		    }
		    special = topLevel.Members.Search("super",0,0);
		    if (special != null) 
		    {
                cClass.ResolveExtends();
                ClassModel extends = cClass.Extends;
			    if (!extends.IsVoid()) special.Type = extends.Name;
                else special.Type = (cFile.Version > 1) ? features.voidKey : features.objectKey;
		    }
		}
		
		/// <summary>
		/// Prepare AS2 intrinsic known vars/methods/classes
		/// </summary>
		protected override void InitTopLevelElements()
		{
            string filename = "toplevel.as";
            topLevel = new FileModel(filename);

            // search top-level declaration
            foreach(PathModel aPath in classPath)
            if (File.Exists(Path.Combine(aPath.Path, filename)))
            {
                filename = Path.Combine(aPath.Path, filename);
                topLevel = GetCachedFileModel(filename);
                break;
            }

            if (File.Exists(filename))
            {
                // MTASC toplevel-style declaration:
                ClassModel tlClass = topLevel.GetPublicClass();
                if (!tlClass.IsVoid())
                {
                    topLevel.Members = tlClass.Members;
                    tlClass.Members = null;
                    topLevel.Classes = new List<ClassModel>();
                }
            }
			// not found
			else
			{
                //ErrorHandler.ShowInfo("Top-level elements class not found. Please check your Program Settings.");
			}

			topLevel.Members.Add(new MemberModel("_root", docType, FlagType.Variable, Visibility.Public));
            topLevel.Members.Add(new MemberModel("_global", features.objectKey, FlagType.Variable, Visibility.Public));
			topLevel.Members.Add(new MemberModel("this", "", FlagType.Variable, Visibility.Public));
            topLevel.Members.Add(new MemberModel("super", "", FlagType.Variable, Visibility.Public));
            topLevel.Members.Add(new MemberModel(features.voidKey, "", FlagType.Class | FlagType.Intrinsic, Visibility.Public));
			topLevel.Members.Sort();
            foreach (MemberModel member in topLevel.Members)
                member.Flags |= FlagType.Intrinsic;
		}

        /// <summary>
        /// Retrieves a package content
        /// </summary>
        /// <param name="name">Package path</param>
        /// <param name="lazyMode">Force file system exploration</param>
        /// <returns>Package folders and types</returns>
        public override FileModel ResolvePackage(string name, bool lazyMode)
		{
            if (name == null) name = "";
            else if (!re_package.IsMatch(name)) return null;

            FileModel pModel = new FileModel();
            pModel.Package = name;
            pModel.OutOfDate = false;

            string packagePath = name.Replace('.', dirSeparatorChar);
            foreach (PathModel aPath in classPath) if (aPath.IsValid && !aPath.Updating)
            {
                // explore file system
                if (lazyMode || settings.LazyClasspathExploration || aPath.IsTemporaryPath)
                {
                    string path = Path.Combine(aPath.Path, packagePath);
                    if (aPath.IsValid && System.IO.Directory.Exists(path))
                    {
                        try
                        {
                            PopulatePackageEntries(name, path, pModel.Imports);
                            PopulateClassesEntries(name, path, pModel.Imports);
                        }
                        catch (Exception ex)
                        {
                            ErrorManager.ShowError(ex);
                        }
                    }
                }
                // explore parsed models
                else
                {
                    string prevPackage = null;
                    string packagePrefix = name + ".";
                    foreach (FileModel model in aPath.Files.Values)
                    {
                        if (model.Package == name)
                        {
                            foreach (ClassModel type in model.Classes)
                                if (type.IndexType == null) pModel.Imports.Add(type.ToMemberModel());
                            foreach (MemberModel member in model.Members)
                                pModel.Members.Add(member.Clone() as MemberModel);
                        }
                        else 
                        {
                            string package = model.Package;
                            if (package != prevPackage 
                                && (name.Length == 0 
                                    || (package.Length > name.Length && package.StartsWith(packagePrefix))))
                            {
                                prevPackage = package;
                                if (name.Length > 0) package = package.Substring(name.Length+1);
                                int p = package.IndexOf('.');
                                if (p > 0) package = package.Substring(0, p);
                                if (pModel.Imports.Search(package, 0, 0) == null)
                                {
                                    pModel.Imports.Add(new MemberModel(package, prevPackage, FlagType.Package, Visibility.Public));
                                }
                            }
                        }
                    }
                }
            }
			// result
            if (pModel.Imports.Count > 0)
			{
                pModel.Imports.Sort();
				return pModel;
			}
			else return null;
		}

        private void PopulateClassesEntries(string package, string path, MemberList memberList)
        {
            string[] fileEntries = null;
            try
            {
                fileEntries = System.IO.Directory.GetFiles(path, "*" + settings.DefaultExtension);
            }
            catch { }
            if (fileEntries == null) return;
            string mname;
            string type;
            FlagType flag = FlagType.Class | ((package == null) ? FlagType.Intrinsic : 0);
            foreach (string entry in fileEntries)
            {
                mname = GetLastStringToken(entry, dirSeparator);
                mname = mname.Substring(0, mname.LastIndexOf("."));
                if (mname.Length > 0 && memberList.Search(mname, 0, 0) == null && re_token.IsMatch(mname))
                {
                    type = mname;
                    if (package.Length > 0) type = package + "." + mname;
                    memberList.Add(new MemberModel(mname, type, flag, Visibility.Public));
                }
            }
        }

        private void PopulatePackageEntries(string package, string path, MemberList memberList)
        {
            string[] dirEntries = null;
            try
            {
                dirEntries = System.IO.Directory.GetDirectories(path);
            }
            catch { }
            if (dirEntries == null) return;

            string mname;
            string type;
            foreach (string entry in dirEntries)
            {
                mname = GetLastStringToken(entry, dirSeparator);
                if (mname.Length > 0 && memberList.Search(mname, 0, 0) == null && re_token.IsMatch(mname))
                {
                    type = mname;
                    if (package.Length > 0) type = package + "." + mname;
                    memberList.Add(new MemberModel(mname, type, FlagType.Package, Visibility.Public));
                }
            }
        }

        /// <summary>
        /// Return the elements (package, types, etc) visible from the current file
        /// </summary>
        /// <param name="typesOnly">Return only packages & types</param>
        /// <returns></returns>
        public override MemberList GetVisibleExternalElements(bool typesOnly)
		{
            MemberList visibleElements = new MemberList();
            if (!IsFileValid) return visibleElements;

            // top-level elements
            if (!typesOnly && topLevel != null)
            {
                if (topLevel.OutOfDate) InitTopLevelElements();
                visibleElements.Add(topLevel.Members);
            }

            if (completionCache.IsDirty)
            {
                MemberList elements = new MemberList();
                // root types & packages
                FileModel baseElements = ResolvePackage(null, false);
                if (baseElements != null)
                {
                    elements.Add(baseElements.Imports);
                }
                elements.Add(new MemberModel(features.voidKey, features.voidKey, FlagType.Class | FlagType.Intrinsic, 0));

                // other classes in same package
                if (features.hasPackages && cFile.Package.Length > 0)
                {
                    bool qualify = Settings.CompletionShowQualifiedTypes;
                    FileModel packageElements = ResolvePackage(cFile.Package, false);
                    if (packageElements != null)
                    {
                        foreach (MemberModel member in packageElements.Imports)
                        {
                            if (member.Flags != FlagType.Package)
                            {
                                if (qualify) member.Name = member.Type;
                                elements.Add(member);
                            }
                        }
                        foreach (MemberModel member in packageElements.Members)
                        {
                            if (qualify) member.Name = member.InFile.Package + "." + member.Name;
                            elements.Add(member);
                        }
                    }
                }
                // other classes in same file
                else
                {
                    bool qualify = Settings.CompletionShowQualifiedTypes && cFile.Package.Length > 0;
                    MemberModel member;
                    foreach (ClassModel aClass in cFile.Classes)
                    {
                        member = aClass.ToMemberModel();
                        if (qualify) member.Name = cFile.Package + "." + member.Name;
                        elements.Add(member);
                    }
                }
                // imports
                elements.Add(ResolveImports(CurrentModel));

                // in cache
                elements.Sort();
                completionCache = new CompletionCache(this, elements);

                // known classes colorization
                if (!CommonSettings.DisableKnownTypesColoring && !settings.LazyClasspathExploration
                    && CurSciControl != null)
                {
                    CurSciControl.KeyWords(1, completionCache.Keywords); // additional-keywords index = 1
                    CurSciControl.Colourise(0, -1); // re-colorize the editor
                }
            }
            visibleElements.Merge(completionCache.Elements);
            return visibleElements;
        }

        /// <summary>
        /// Return the full project classes list
        /// </summary>
        /// <returns></returns>
        public override MemberList GetAllProjectClasses()
        {
            // from cache
            if (!completionCache.IsDirty && completionCache.AllTypes != null)
                return completionCache.AllTypes;

            MemberList fullList = new MemberList();
            ClassModel aClass;
            MemberModel item;
            // public classes
            foreach (PathModel aPath in classPath) if (aPath.IsValid && !aPath.Updating)
            {
                foreach (FileModel aFile in aPath.Files.Values)
                {
                    aClass = aFile.GetPublicClass();
                    if (!aClass.IsVoid() && aClass.IndexType == null && aClass.Access == Visibility.Public)
                    {
                        item = aClass.ToMemberModel();
                        item.Name = item.Type;
                        fullList.Add(item);
                    }
                }
            }
            // void
            fullList.Add(new MemberModel(features.voidKey, features.voidKey, FlagType.Class | FlagType.Intrinsic, 0));

            // in cache
            fullList.Sort();
            completionCache.AllTypes = fullList;
            return fullList;
        }
		#endregion
		
		#region command line compiler
        /// <summary>
        /// Retrieve the context's default compiler path
        /// </summary>
        public override string GetCompilerPath()
        {
            if (as2settings != null) return as2settings.MtascPath;
            else return null;
        }

        /// <summary>
        /// Check current file's syntax
        /// </summary>
        public override void CheckSyntax()
        {
            if (as2settings == null)
            {
                ErrorManager.ShowInfo(TextHelper.GetString("Info.FeatureMissing"));
                return;
            }
            // just run the compiler against the current file
            RunCMD(as2settings.MtascCheckParameters);
        }

		/// <summary>
		/// Run MTASC compiler in the current class's base folder with current classpath
		/// </summary>
		/// <param name="append">Additional comiler switches</param>
		public override void RunCMD(string append)
		{
            if (as2settings == null)
            {
                ErrorManager.ShowInfo(TextHelper.GetString("Info.FeatureMissing"));
                return;
            }

            if (!IsFileValid || !File.Exists(CurrentFile))
				return;
            if (CurrentModel.Version != 2)
            {
                MessageBar.ShowWarning(TextHelper.GetString("Info.InvalidClass"));
                return;
            }

            string basePath = null;
            if (PluginBase.CurrentProject != null)
                basePath = Path.GetDirectoryName(PluginBase.CurrentProject.ProjectPath);
            string mtascPath = PathHelper.ResolvePath(as2settings.MtascPath, basePath);
            if (!Directory.Exists(mtascPath) && !File.Exists(mtascPath))
			{
                ErrorManager.ShowInfo(TextHelper.GetString("Info.InvalidMtascPath"));
				return;
			}
			
			SetStatusText(settings.CheckSyntaxRunning);
			
			try 
			{
				// save modified files if needed
				if (outputFile != null) MainForm.CallCommand("SaveAllModified", null);
				else MainForm.CallCommand("SaveAllModified", ".as");
				
				// prepare command
                string command = mtascPath;
                if (Path.GetExtension(command) == "") command = Path.Combine(command, "mtasc.exe");
                else mtascPath = Path.GetDirectoryName(mtascPath);

                command += ";\"" + CurrentFile + "\"";
				if (append == null || append.IndexOf("-swf-version") < 0)
                    command += " -version "+flashVersion;
				// classpathes
				foreach(PathModel aPath in classPath)
                if (aPath.Path != temporaryPath
                    && !aPath.Path.StartsWith(mtascPath, StringComparison.OrdinalIgnoreCase))
                    command += " -cp \"" + aPath.Path.TrimEnd('\\') + "\"";
				
				// run
                string filePath = NormalizePath(cFile.BasePath);
                if (PluginBase.CurrentProject != null)
                    filePath = Path.GetDirectoryName(PluginBase.CurrentProject.ProjectPath); 
                string workDir = MainForm.WorkingDirectory;
                MainForm.WorkingDirectory = filePath;
				MainForm.CallCommand("RunProcessCaptured", command+" "+append);
                MainForm.WorkingDirectory = workDir;
			}
			catch (Exception ex)
			{
                ErrorManager.ShowError(ex);
			}
		}
		
		/// <summary>
		/// Calls RunCMD with additional parameters taken from the classes @mtasc doc tag
		/// </summary>
		public override bool BuildCMD(bool failSilently)
		{
            if (as2settings == null)
            {
                ErrorManager.ShowInfo(TextHelper.GetString("Info.FeatureMissing"));
                return false;
            }

            if (!File.Exists(CurrentFile)) 
                return false;
			// check if @mtasc is defined
			Match mCmd = null;
            ClassModel cClass = cFile.GetPublicClass();
            if (IsFileValid && cClass.Comments != null)
                mCmd = re_CMD_BuildCommand.Match(cClass.Comments);
			
			if (CurrentModel.Version != 2 || mCmd == null || !mCmd.Success) 
			{
				if (!failSilently)
				{
					MessageBar.ShowWarning(TextHelper.GetString("Info.InvalidForQuickBuild"));
				}
				return false;
			}
			
			// build command
			string command = mCmd.Groups["params"].Value.Trim();
            try
            {
                command = Regex.Replace(command, "[\\r\\n]\\s*\\*", "", RegexOptions.Singleline);
                command = " " + MainForm.ProcessArgString(command) + " ";
                if (command == null || command.Length == 0)
                {
                    if (!failSilently)
                        throw new Exception(TextHelper.GetString("Info.InvalidQuickBuildCommand"));
                    return false;
                }
                outputFile = null;
                outputFileDetails = "";
                trustFileWanted = false;

                // get SWF url
                MatchCollection mPar = re_SplitParams.Matches(command + "-eof");
                int mPlayIndex = -1;
                bool noPlay = false;
                if (mPar.Count > 0)
                {
                    string op;
                    for (int i = 0; i < mPar.Count; i++)
                    {
                        op = mPar[i].Groups["switch"].Value;
                        int start = mPar[i].Index + mPar[i].Length;
                        int end = (mPar.Count > i + 1) ? mPar[i + 1].Index : start;
                        if ((op == "-swf") && (outputFile == null) && (mPlayIndex < 0))
                        {
                            if (end > start)
                                outputFile = command.Substring(start, end - start).Trim();
                        }
                        else if ((op == "-out") && (mPlayIndex < 0))
                        {
                            if (end > start)
                                outputFile = command.Substring(start, end - start).Trim();
                        }
                        else if (op == "-header")
                        {
                            if (end > start)
                            {
                                string[] dims = command.Substring(start, end - start).Trim().Split(':');
                                if (dims.Length > 2) outputFileDetails = ";" + dims[0] + ";" + dims[1];
                            }
                        }
                        else if (op == "-play")
                        {
                            if (end > start)
                            {
                                mPlayIndex = i;
                                outputFile = command.Substring(start, end - start).Trim();
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
                if (outputFile.Length == 0) outputFile = null;

                // cleaning custom switches
                if (mPlayIndex >= 0)
                {
                    command = command.Substring(0, mPar[mPlayIndex].Index) + command.Substring(mPar[mPlayIndex + 1].Index);
                }
                if (trustFileWanted)
                {
                    command = command.Replace("-trust", "");
                }
                if (noPlay || !settings.PlayAfterBuild)
                {
                    command = command.Replace("-noplay", "");
                    outputFile = null;
                    runAfterBuild = false;
                }
                else runAfterBuild = (outputFile != null);

                // fixing output path
                if (runAfterBuild)
                {
                    if (!Path.IsPathRooted(outputFile))
                    {
                        string filePath = NormalizePath(cFile.BasePath);
                        if (PluginBase.CurrentProject != null)
                            filePath = Path.GetDirectoryName(PluginBase.CurrentProject.ProjectPath);
                        outputFile = Path.Combine(filePath, outputFile);
                    }
                    string outputPath = Path.GetDirectoryName(outputFile);

                    if (!Directory.Exists(outputPath)) Directory.CreateDirectory(outputPath);
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return false;
            }
			
			// run
			RunCMD(command);
			return true;
		}
		#endregion
	}
}
