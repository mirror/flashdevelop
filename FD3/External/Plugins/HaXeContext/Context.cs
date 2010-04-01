using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using PluginCore.Managers;
using ASCompletion.Context;
using ASCompletion.Model;
using PluginCore.Localization;
using PluginCore.Controls;
using PluginCore.Helpers;
using PluginCore;
using ASCompletion.Completion;
using System.Collections;
using System.Windows.Forms;

namespace HaXeContext
{
    public class Context : AS2Context.Context
    {
        #region initialization
        new static readonly protected Regex re_CMD_BuildCommand =
            new Regex("@haxe[\\s]+(?<params>.*)", RegexOptions.Compiled | RegexOptions.Multiline);

        static readonly protected Regex re_genericType =
                    new Regex("(?<gen>[^<]+)<(?<type>.+)>$", RegexOptions.Compiled | RegexOptions.IgnoreCase);

        private HaXeSettings hxsettings;

        public Context(HaXeSettings initSettings)
        {
            hxsettings = initSettings;

            /* AS-LIKE OPTIONS */

            hasLevels = false;
            docType = "Void"; // "flash.display.MovieClip";

            /* DESCRIBE LANGUAGE FEATURES */

            // language constructs
            features.hasPackages = true;
            features.hasImports = true;
            features.hasImportsWildcard = false;
            features.hasClasses = true;
            features.hasExtends = true;
            features.hasImplements = true;
            features.hasInterfaces = true;
            features.hasEnums = true;
            features.hasTypeDefs = true;
            features.hasGenerics = true;
            features.hasEcmaTyping = true;
            features.hasVars = true;
            features.hasConsts = false;
            features.hasMethods = true;
            features.hasStatics = true;
            features.hasTryCatch = true;
            features.checkFileName = false;

            // haxe directives
            features.hasDirectives = true;
            features.Directives = new List<string>();
            features.Directives.Add("true");

            // allowed declarations access modifiers
            Visibility all = Visibility.Public | Visibility.Private;
            features.classModifiers = all;
            features.varModifiers = all;
            features.methodModifiers = all;

            // default declarations access modifiers
            features.classModifierDefault = Visibility.Public;
            features.enumModifierDefault = Visibility.Public;
            features.typedefModifierDefault = Visibility.Public;
            features.varModifierDefault = Visibility.Private;
            features.methodModifierDefault = Visibility.Private;

            // keywords
            features.dot = ".";
            features.voidKey = "Void";
            features.objectKey = "Dynamic";
            features.importKey = "import";
            features.importKeyAlt = "using";
            features.typesPreKeys = new string[] { "import", "new", "extends", "implements", "using" };
            features.codeKeywords = new string[] { 
                "var", "function", "new", "cast", "return", "break", "continue", "callback",
                "if", "else", "for", "while", "do", "switch", "case", "default", "with",
                "null", "undefined", "true", "false", "try", "catch", "throw", "inline", "dynamic"
            };
            features.varKey = "var";
            features.functionKey = "function";
            features.staticKey = "static";
            features.publicKey = "public";
            features.privateKey = "private";
            features.intrinsicKey = "extern";
            features.inlineKey = "inline";

            /* INITIALIZATION */

            settings = initSettings;
            //BuildClassPath(); // defered to first use
        }
        #endregion

        #region classpath management

        public bool IsFlashTarget
        {
            get { return flashVersion < 11; }
        }
        public bool IsJavaScriptTarget
        {
            get { return flashVersion == 11; }
        }
        public bool IsNekoTarget
        {
            get { return flashVersion == 12; }
        }
        public bool IsPhpTarget
        {
            get { return flashVersion == 13; }
        }
        public bool IsCppTarget
        {
            get { return flashVersion == 14; }
        }

        /// <summary>
        /// Classpathes & classes cache initialisation
        /// </summary>
        public override void BuildClassPath()
        {
            ReleaseClasspath();
            started = true;
            if (hxsettings == null) throw new Exception("BuildClassPath() must be overridden");

            // external version definition
            // expected from project manager: "9;path;path..."
            flashVersion = hxsettings.DefaultFlashVersion;
            string exPath = externalClassPath ?? "";
            if (exPath.Length > 0)
            {
                try
                {
                    int p = exPath.IndexOf(';');
                    flashVersion = Convert.ToInt16(exPath.Substring(0, p));
                    exPath = exPath.Substring(p + 1).Trim();
                }
                catch { }
            }

            // NOTE: version > 10 for non-Flash platforms
            string lang = null;
            features.Directives = new List<string>();
            if (IsJavaScriptTarget) 
            {
                lang = "js";
                features.Directives.Add(lang);
            }
            else if (IsNekoTarget) 
            {
                lang = "neko";
                features.Directives.Add(lang);
            }
            else if (IsPhpTarget)
            {
                lang = "php";
                features.Directives.Add(lang);
            }
            else if (IsCppTarget)
            {
                lang = "cpp";
                features.Directives.Add(lang);
            }
            else
            {
                features.Directives.Add("flash");
                features.Directives.Add("flash" + flashVersion);
                lang = (flashVersion >= 9) ? "flash9" : "flash";
            }
            features.Directives.Add("true");

            //
            // Class pathes
            //
            classPath = new List<PathModel>();
            // haXe std
            if (hxsettings.HaXePath != null)
            {
                string haxeCP = Path.Combine(hxsettings.HaXePath, "std");
                if (Directory.Exists(haxeCP))
                {
                    PathModel std = PathModel.GetModel(haxeCP, this);
                    if (!std.WasExplored && !Settings.LazyClasspathExploration)
                    {
                        PathExplorer stdExplorer = new PathExplorer(this, std);
                        stdExplorer.HideDirectories(new string[] { "flash", "flash9", "js", "neko", "php", "cpp" });
                        stdExplorer.OnExplorationDone += new PathExplorer.ExplorationDoneHandler(RefreshContextCache);
                        stdExplorer.Run();
                    }
                    AddPath(std);

                    PathModel specific = PathModel.GetModel(Path.Combine(haxeCP, lang), this);
                    if (!specific.WasExplored && !Settings.LazyClasspathExploration)
                    {
                        PathExplorer speExplorer = new PathExplorer(this, specific);
                        speExplorer.OnExplorationDone += new PathExplorer.ExplorationDoneHandler(RefreshContextCache);
                        speExplorer.Run();
                    }
                    AddPath(specific);
                }
            }

            // add external pathes
            List<PathModel> initCP = classPath;
            classPath = new List<PathModel>();
            string[] cpathes;
            if (exPath.Length > 0)
            {
                cpathes = exPath.Split(';');
                foreach (string cpath in cpathes) AddPath(cpath.Trim());
            }
            // add library
            AddPath(Path.Combine(PathHelper.LibraryDir, "HAXE/classes"));
            // add user pathes from settings
            if (settings.UserClasspath != null && settings.UserClasspath.Length > 0)
            {
                foreach (string cpath in settings.UserClasspath) AddPath(cpath.Trim());
            }
            // add initial pathes
            foreach (PathModel mpath in initCP) AddPath(mpath);

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
        /// Delete current class's cached file
        /// </summary>
        public override void RemoveClassCompilerCache()
        {
            // not implemented - is there any?
        }
        #endregion

        #region class resolution
        /// <summary>
        /// Evaluates the visibility of one given type from another.
        /// Caller is responsible of calling ResolveExtends() on 'inClass'
        /// </summary>
        /// <param name="inClass">Completion context</param>
        /// <param name="withClass">Completion target</param>
        /// <returns>Completion visibility</returns>
        public override Visibility TypesAffinity(ClassModel inClass, ClassModel withClass)
        {
            // same file
            if (withClass != null && inClass.InFile == withClass.InFile)
                return Visibility.Public | Visibility.Private;
            // inheritance affinity
            ClassModel tmp = inClass;
            while (!tmp.IsVoid())
            {
                if (tmp == withClass)
                    return Visibility.Public | Visibility.Private;
                tmp = tmp.Extends;
            }
            // same package
            if (withClass != null && inClass.InFile.Package == withClass.InFile.Package)
                return Visibility.Public;
            // public only
            else
                return Visibility.Public;
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
            MemberModel item;
            // public & internal classes
            string package = CurrentModel.Package;
            foreach (PathModel aPath in classPath) if (aPath.IsValid && !aPath.Updating)
            {
                foreach (FileModel aFile in aPath.Files.Values)
                {
                    string module = Path.GetFileNameWithoutExtension(aFile.FileName);
                    string qmodule = aFile.Package.Length > 0 ? aFile.Package + "." + module : module;
                    bool needModule = true;

                    if (aFile.Classes.Count > 0 && !aFile.Classes[0].IsVoid())
                        foreach (ClassModel aClass in aFile.Classes)
                        {
                            string tpackage = aClass.InFile.Package;
                            if (aClass.IndexType == null
                                && (aClass.Access == Visibility.Public
                                    || (aClass.Access == Visibility.Internal && tpackage == package)))
                            {
                                if (aClass.Name == module)
                                {
                                    needModule = false;
                                    item = aClass.ToMemberModel();
                                    if (tpackage != package) item.Name = item.Type;
                                    fullList.Add(item);
                                }
                                else if (tpackage == "") fullList.Add(aClass.ToMemberModel());
                                else if (tpackage == package) fullList.Add(aClass.ToMemberModel());
                            }
                        }
                    // HX files correspond to a "module" which should appear in code completion
                    // (you don't import classes defined in modules but the module itself)
                    if (needModule)
                    {
                        item = new MemberModel(qmodule, qmodule, FlagType.Class, Visibility.Public);
                        fullList.Add(item);
                    }
                }
            }
            // display imported classes and classes declared in imported modules
            MemberList imports = ResolveImports(cFile);
            FlagType mask = FlagType.Class | FlagType.Enum;
            foreach (MemberModel import in imports)
            {
                if ((import.Flags & mask) > 0)
                {
                    fullList.Add(import);
                }
            }

            // in cache
            fullList.Sort();
            completionCache.AllTypes = fullList;
            return fullList;
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
                        // HX files are "modules": when imported all the classes contained are available
                        ClassModel type = ResolveType(item.Type, null);
                        if (!type.IsVoid())
                        {
                            foreach (ClassModel aClass in type.InFile.Classes)
                            {
                                if (aClass.IndexType == null)
                                    imports.Add(aClass);
                            }
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
            int p = member.Name.IndexOf('#');
            if (p > 0)
            {
                member = member.Clone() as MemberModel;
                member.Name = member.Name.Substring(0, p);
            }

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
            // handle generic types
            if (cname != null && cname.IndexOf('<') > 0)
            {
                Match genType = re_genericType.Match(cname);
                if (genType.Success)
                    return ResolveGenericType(genType.Groups["gen"].Value + "<T>", genType.Groups["type"].Value, inFile);
                else return ClassModel.VoidClass;
            }
            return base.ResolveType(cname, inFile);
        }

        /// <summary>
        /// Retrieve/build typed copies of generic types
        /// </summary>
        private ClassModel ResolveGenericType(string baseType, string indexType, FileModel inFile)
        {
            ClassModel aClass = base.ResolveType(baseType, inFile);
            if (aClass.IsVoid()) return aClass;

            FileModel aFile = aClass.InFile;
            // is the type already cloned?
            foreach (ClassModel otherClass in aFile.Classes)
                if (otherClass.IndexType == indexType) return otherClass;

            // clone the type
            aClass = aClass.Clone() as ClassModel;

            aClass.Name = baseType.Substring(baseType.LastIndexOf('.') + 1) + "#" + indexType;
            aClass.IndexType = indexType;

            string typed = "<" + indexType + ">";
            foreach (MemberModel member in aClass.Members)
            {
                if (member.Name == baseType) member.Name = baseType.Replace("<T>", typed);
                if (member.Type != null && member.Type.IndexOf('T') >= 0)
                {
                    if (member.Type == "T") member.Type = indexType;
                    else member.Type = member.Type.Replace("<T>", typed);
                }
                if (member.Parameters != null)
                {
                    foreach (MemberModel param in member.Parameters)
                    {
                        if (param.Type != null && param.Type.IndexOf('T') >= 0)
                        {
                            if (param.Type == "T") param.Type = indexType;
                            else
                            {
                                param.Type = param.Type.Replace("<T>", typed);
                                if (param.Type.IndexOf('-') > 0)
                                {
                                    param.Type = Regex.Replace(param.Type, "T\\s?->", indexType + " ->");
                                    param.Type = Regex.Replace(param.Type, "->\\s?T", "-> " + indexType);
                                }
                            }
                        }
                    }
                }
            }

            aFile.Classes.Add(aClass);
            return aClass;
        }

        /// <summary>
        /// Prepare haXe intrinsic known vars/methods/classes
        /// </summary>
        protected override void InitTopLevelElements()
        {
            string filename = "toplevel.hx";
            topLevel = new FileModel(filename);

            // search top-level declaration
            foreach (PathModel aPath in classPath)
                if (File.Exists(Path.Combine(aPath.Path, filename)))
                {
                    filename = Path.Combine(aPath.Path, filename);
                    topLevel = GetCachedFileModel(filename);
                    break;
                }

            if (File.Exists(filename))
            {
                // copy declarations as file-level
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

            topLevel.Members.Add(new MemberModel("this", "", FlagType.Variable, Visibility.Public));
            topLevel.Members.Add(new MemberModel("super", "", FlagType.Variable, Visibility.Public));
            topLevel.Members.Add(new MemberModel("Void", "", FlagType.Intrinsic, Visibility.Public));
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
            if (settings.LazyClasspathExploration && flashVersion >= 9 && name == "flash") 
                name = "flash9";
            return base.ResolvePackage(name, lazyMode);
        }
        #endregion

        #region Custom code completion
        /// <summary>
        /// Let contexts handle code completion
        /// </summary>
        /// <param name="sci">Scintilla control</param>
        /// <param name="expression">Completion context</param>
        /// <param name="autoHide">Auto-started completion (is false when pressing Ctrl+Space)</param>
        /// <returns>Null (not handled) or member list</returns>
        public override MemberList ResolveDotContext(ScintillaNet.ScintillaControl sci, ASExpr expression, bool autoHide)
        {
            if (hxsettings.DisableCompilerCompletion)
                return null;

            if (autoHide && !hxsettings.DisableCompletionOnDemand)
                return null;

            // auto-started completion, can be ignored for performance (show default completion tooltip)
            if (autoHide && !expression.Value.EndsWith("."))
                if ( hxsettings.DisableMixedCompletion )
                    return new MemberList();
                else
                    return null;

            MemberList list = new MemberList();
           
            HaXeCompletion hc = new HaXeCompletion(sci, expression.Position);
            ArrayList al = hc.getList();
            if (al == null || al.Count == 0) 
                return null; // haxe.exe not found
            
            string outputType = al[0].ToString();

            if( outputType == "error" )
            {
                string err = al[1].ToString();
                sci.CallTipShow(sci.CurrentPos, err);
                sci.CharAdded += new ScintillaNet.CharAddedHandler(removeTip);
                
                // show default completion tooltip
                if (!hxsettings.DisableMixedCompletion)
                    return null;
            }
            else if (outputType == "list")
            {
                foreach (ArrayList i in al[ 1 ] as ArrayList)
                {
                    string var = i[0].ToString();
                    string type = i[1].ToString();
                    string desc = i[2].ToString();

                    FlagType flag = FlagType.Variable;

                    MemberModel member = new MemberModel();
                    member.Name = var;
                    member.Access = Visibility.Public;
                    
                    // Package or Class
                    if (type == "")
                    {
                        string bl = var.Substring( 0, 1 );
                        if (bl == bl.ToLower())
                            flag = FlagType.Package;
                        else
                            flag = FlagType.Class;
                    }
                    // Function or Variable
                    else
                    {
                        Array types = type.Split(new string[] { "->" }, StringSplitOptions.RemoveEmptyEntries);

                        // Function
                        if (types.Length > 1)
                        {
                            flag = FlagType.Function;

                            // Function's arguments
                            member.Parameters = new List<MemberModel>();
                            int j = 0;
                            while (j < types.Length - 1)
                            {
                                MemberModel param = new MemberModel(types.GetValue(j).ToString(), "", FlagType.ParameterVar, Visibility.Public);
                                member.Parameters.Add(param);
                                j++;
                            }

                            // Function's return type
                            member.Type = types.GetValue(types.Length - 1).ToString();
                        }
                        // Variable
                        else
                        {
                            flag = FlagType.Variable;
                            // Variable's type
                            member.Type = type;
                        }    
                       
                    }
                                        
                    member.Flags = flag;
                    
                   list.Add(member);
                }
            }
            return list;
        }
        
        /// <summary>
        /// Let contexts handle code completion
        /// </summary>
        /// <param name="sci">Scintilla control</param>
        /// <param name="expression">Completion context</param>
        /// <returns>Null (not handled) or function signature</returns>
        public override MemberModel ResolveFunctionContext(ScintillaNet.ScintillaControl sci, ASExpr expression, bool autoHide)
        {
            if (hxsettings.DisableCompilerCompletion)
                return null;

            if (autoHide && !hxsettings.DisableCompletionOnDemand)
                return null;

            string[] parts = expression.Value.Split('.');
            string name = parts[parts.Length - 1];
            
            MemberModel member = new MemberModel();

            // Do not show error
            string val = expression.Value;
            if (val == "for" || 
                val == "while" ||
                val == "if" ||
                val == "switch" ||
                val == "function" ||
                val == "catch" ||
                val == "trace")
                return null;

            HaXeCompletion hc = new HaXeCompletion(sci, expression.Position);
            ArrayList al = hc.getList();
            if (al == null || al.Count == 0)
                return null; // haxe.exe not found

            string outputType = al[0].ToString();

            if (outputType == "type" )
            {
                member.Name = name;
                member.Flags = FlagType.Function;
                member.Access = Visibility.Public;

                var type = al[1].ToString();

                Array types = type.Split(new string[] { "->" }, StringSplitOptions.RemoveEmptyEntries);

                // Function's arguments
                member.Parameters = new List<MemberModel>();
                int j = 0;
                while (j < types.Length - 1)
                {
                    MemberModel param = new MemberModel(types.GetValue(j).ToString(), "", FlagType.ParameterVar, Visibility.Public);
                    member.Parameters.Add(param);
                    j++;
                }
                // Function's return type
                member.Type = types.GetValue(types.Length - 1).ToString();
            }
            else if ( outputType == "error" )
            {
                string err = al[1].ToString();
                sci.CallTipShow(sci.CurrentPos, err);
                sci.CharAdded += new ScintillaNet.CharAddedHandler(removeTip);
            }
                        
            return member;
        }

        void removeTip(ScintillaNet.ScintillaControl sender, int ch)
        {
            sender.CallTipCancel();
            sender.CharAdded -= removeTip;
        }
        #endregion

        #region command line compiler

        static public string TemporaryOutputFile;

        /// <summary>
        /// Retrieve the context's default compiler path
        /// </summary>
        public override string GetCompilerPath()
        {
            return hxsettings.HaXePath;
        }

        /// <summary>
        /// Check current file's syntax
        /// </summary>
        public override void CheckSyntax()
        {
            // compile current class into a dummy temporary file
            if (TemporaryOutputFile == null) TemporaryOutputFile = Path.GetTempFileName();
            string output = "-swf ";

            if (IsJavaScriptTarget) output = "-js ";
            else if (IsNekoTarget) output = "-neko ";
            else if (IsPhpTarget) output = "-php ";
            else if (IsCppTarget) output = "-cpp ";

            RunCMD(output + "\"" + TemporaryOutputFile + "\" " + hxsettings.HaXeCheckParameters);
        }

        /// <summary>
        /// Run haXe compiler in the current class's base folder with current classpath
        /// </summary>
        /// <param name="append">Additional comiler switches</param>
        public override void RunCMD(string append)
        {
            if (!IsFileValid || !File.Exists(CurrentFile))
                return;

            string basePath = null;
            if (PluginBase.CurrentProject != null)
                basePath = Path.GetDirectoryName(PluginBase.CurrentProject.ProjectPath);
            string haxePath = PathHelper.ResolvePath(hxsettings.HaXePath, basePath);
            if (!Directory.Exists(haxePath) && !File.Exists(haxePath))
            {
                ErrorManager.ShowInfo(TextHelper.GetString("Info.InvalidHaXePath"));
                return;
            }

            SetStatusText(settings.CheckSyntaxRunning);

            try
            {
                // save modified files if needed
                if (outputFile != null) MainForm.CallCommand("SaveAllModified", null);
                else MainForm.CallCommand("SaveAllModified", ".hx");

                // change current directory
                string currentPath = System.IO.Directory.GetCurrentDirectory();
                string filePath = (temporaryPath == null) ? Path.GetDirectoryName(cFile.FileName) : temporaryPath;
                filePath = NormalizePath(filePath);
                System.IO.Directory.SetCurrentDirectory(filePath);
                
                // prepare command
                string command = haxePath;
                if (Path.GetExtension(command) == "") command = Path.Combine(command, "haxe.exe");

                command += ";";
                if (cFile.Package.Length > 0) command += cFile.Package+".";
                string cname = cFile.GetPublicClass().Name;
                if (cname.IndexOf('<') > 0) cname = cname.Substring(0, cname.IndexOf('<'));
                command += cname;

                if (IsFlashTarget && (append == null || append.IndexOf("-swf-version") < 0)) 
                    command += " -swf-version " + flashVersion;
                // classpathes
                foreach (PathModel aPath in classPath)
                    if (aPath.Path != temporaryPath
                        && !aPath.Path.StartsWith(hxsettings.HaXePath, StringComparison.OrdinalIgnoreCase))
                        command += " -cp \"" + aPath.Path.TrimEnd('\\') + "\"";
                command = command.Replace(filePath, "");

                // run
                MainForm.CallCommand("RunProcessCaptured", command + " " + append);
                // restaure current directory
                if (System.IO.Directory.GetCurrentDirectory() == filePath)
                    System.IO.Directory.SetCurrentDirectory(currentPath);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Calls RunCMD with additional parameters taken from the classes @haxe doc tag
        /// </summary>
        public override bool BuildCMD(bool failSilently)
        {
            if (!File.Exists(CurrentFile))
                return false;
            // check if @haxe is defined
            Match mCmd = null;
            ClassModel cClass = cFile.GetPublicClass();
            if (IsFileValid)
            {
                if (cFile.Comments != null)
                    mCmd = re_CMD_BuildCommand.Match(cFile.Comments);
                if ((mCmd == null || !mCmd.Success) && cClass.Comments != null)
                    mCmd = re_CMD_BuildCommand.Match(cClass.Comments);
            }

            if (mCmd == null || !mCmd.Success)
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

                // get some output information url
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
                        else if (op == "-swf-header")
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
                if (outputFile != null && outputFile.Length == 0) outputFile = null;

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
