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
            features.typesPreKeys = new string[] { "import", "new", "extends", "implements" };
            features.codeKeywords = new string[] { 
                "var", "function", "new", "delete", "cast", "return", "break", "continue",
                "if", "else", "for", "while", "do", "switch", "case", "default", "with",
                "null", "undefined", "true", "false", "try", "catch", "finally", "throw"
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

            // NOTE: version > 9 for non-Flash platforms
            string lang = null;
            features.Directives = new List<string>();
            if (flashVersion == 10) 
            {
                lang = "js";
                features.Directives.Add(lang);
            }
            else if (flashVersion == 11) 
            {
                lang = "neko";
                features.Directives.Add(lang);
            }
            else
            {
                features.Directives.Add("flash");
                features.Directives.Add("flash" + flashVersion);
                lang = (flashVersion == 9) ? "flash9" : "flash";
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
                        stdExplorer.HideDirectories(new string[] { "flash", "flash9", "js", "neko" });
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
                    if (aFile.Classes.Count > 0 && !aFile.Classes[0].IsVoid())
                        foreach (ClassModel aClass in aFile.Classes)
                        {
                            if (aClass.IndexType == null
                                && (aClass.Access == Visibility.Public
                                    || (aClass.Access == Visibility.Internal && aClass.InFile.Package == package)))
                            {
                                item = aClass.ToMemberModel();
                                item.Name = item.Type;
                                fullList.Add(item);
                            }
                        }
                }
            }
            // void
            //fullList.Add(new MemberModel(features.voidKey, features.voidKey, FlagType.Class | FlagType.Intrinsic, 0));

            // in cache
            fullList.Sort();
            completionCache.AllTypes = fullList;
            return fullList;
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

            aClass.Name = baseType + "#" + indexType;
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
            if (settings.LazyClasspathExploration && flashVersion == 9 && name == "flash") 
                name = "flash9";
            return base.ResolvePackage(name, lazyMode);
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

            if (flashVersion == 10) output = "-js ";
            else if (flashVersion == 11) output = "-neko ";

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

                if (flashVersion < 10 && (append == null || append.IndexOf("-swf-version") < 0)) 
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
