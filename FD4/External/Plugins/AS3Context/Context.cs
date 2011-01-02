using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using PluginCore.Managers;
using ASCompletion.Context;
using ASCompletion.Model;
using PluginCore;
using System.Collections;
using System.Text.RegularExpressions;
using PluginCore.Controls;
using PluginCore.Localization;
using AS3Context.Compiler;
using PluginCore.Helpers;
using System.Timers;
using ASCompletion.Completion;

namespace AS3Context
{
    public class Context : AS2Context.Context
    {
        static readonly protected Regex re_genericType =
            new Regex("(?<gen>[^<]+)\\.<(?<type>.+)>$", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        
        // C:\path\to\Main.as$raw$:31: col: 1:  Error #1084: Syntax error: expecting rightbrace before end of program.
        static readonly protected Regex re_syntaxError =
            new Regex("(?<filename>.*)\\$raw\\$:(?<line>[0-9]+): col: (?<col>[0-9]+):(?<desc>.*)", RegexOptions.Compiled);
        
        #region initialization
        private AS3Settings as3settings;
        private bool hasAIRSupport;
        private MxmlFilterContext mxmlFilterContext; // extract inlined AS3 ranges & MXML tags
        private System.Timers.Timer timerCheck;
        private string fileWithSquiggles;

        public Context(AS3Settings initSettings)
        {
            as3settings = initSettings;

            /* AS-LIKE OPTIONS */

            hasLevels = false;
            docType = "flash.display.MovieClip";

            /* DESCRIBE LANGUAGE FEATURES */

            // language constructs
            features.hasPackages = true;
            features.hasNamespaces = true;
            features.hasImports = true;
            features.hasImportsWildcard = false;
            features.hasClasses = true;
            features.hasExtends = true;
            features.hasImplements = true;
            features.hasInterfaces = true;
            features.hasEnums = false;
            features.hasGenerics = true;
            features.hasEcmaTyping = true;
            features.hasVars = true;
            features.hasConsts = true;
            features.hasMethods = true;
            features.hasStatics = true;
            features.hasOverride = true;
            features.hasTryCatch = true;
            features.hasE4X = true;
            features.checkFileName = true;

            // allowed declarations access modifiers
            Visibility all = Visibility.Public | Visibility.Internal | Visibility.Protected | Visibility.Private;
            features.classModifiers = all;
            features.varModifiers = all;
            features.constModifiers = all;
            features.methodModifiers = all;

            // default declarations access modifiers
            features.classModifierDefault = Visibility.Internal;
            features.varModifierDefault = Visibility.Internal;
            features.methodModifierDefault = Visibility.Internal;

            // keywords
            features.dot = ".";
            features.voidKey = "void";
            features.objectKey = "Object";
            features.importKey = "import";
            features.typesPreKeys = new string[] { "import", "new", "typeof", "is", "as", "extends", "implements" };
            features.codeKeywords = new string[] { 
                "var", "function", "new", "delete", "typeof", "is", "as", "return", "break", "continue",
                "if", "else", "for", "each", "in", "while", "do", "switch", "case", "default", "with",
                "null", "true", "false", "try", "catch", "finally", "throw", "use", "namespace"
            };
            features.varKey = "var";
            features.constKey = "const";
            features.functionKey = "function";
            features.getKey = "get";
            features.setKey = "set";
            features.staticKey = "static";
            features.finalKey = "final";
            features.overrideKey = "override";
            features.publicKey = "public";
            features.internalKey = "internal";
            features.protectedKey = "protected";
            features.privateKey = "private";
            features.intrinsicKey = "extern";
            features.namespaceKey = "namespace";

            /* INITIALIZATION */

            settings = initSettings;
            //BuildClassPath(); // defered to first use

            // live syntax checking
            timerCheck = new Timer(500);
            timerCheck.AutoReset = false;
            timerCheck.Elapsed += new ElapsedEventHandler(timerCheck_Elapsed);
            FlexShells.SyntaxError += new SyntaxErrorHandler(Flex2Shell_SyntaxError);
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
            if (as3settings == null) throw new Exception("BuildClassPath() must be overridden");

            // external version definition
            platform = "Flash Player";
            majorVersion = 10;
            minorVersion = 0;
            ParseVersion(as3settings.DefaultFlashVersion, ref majorVersion, ref minorVersion);
            string exPath = ExtractPlatformVersion();
            hasAIRSupport = platform == "AIR";

            //
            // Class pathes
            //
            classPath = new List<PathModel>();
            MxmlFilter.ClearCatalogs();
            MxmlFilter.AddProjectManifests();

            // SDK
            string compiler = MainForm.ProcessArgString("$(CompilerPath)");
            if (compiler == "$(CompilerPath)") compiler = as3settings.GetDefaultSDK().Path ?? "Tools\\flexsdk";
            char S = Path.DirectorySeparatorChar;
            string frameworks = compiler + S + "frameworks";
            string sdkLibs = frameworks + S + "libs";
            string sdkLocales = frameworks + S + "locale" + S + PluginBase.MainForm.Settings.LocaleVersion;
            string fallbackLocales = PathHelper.ResolvePath(PathHelper.LibraryDir + S + "AS3" + S + "intrinsic" + S + "locale" + S + "en_US");
            List<string> addLibs = new List<string>();
            List<string> addLocales = new List<string>();

            if (!Directory.Exists(sdkLibs) && !sdkLibs.StartsWith("$")) // fallback
            {
                sdkLibs = PathHelper.ResolvePath(PathHelper.LibraryDir + S + "AS3" + S + "intrinsic" + S + "libs");
            }

            if (!String.IsNullOrEmpty(sdkLibs) && Directory.Exists(sdkLibs))
            {
                string libPlayer = sdkLibs + S + "player";
                if (hasAIRSupport)
                {
                    addLibs.Add("air" + S + "airglobal.swc");
                    addLibs.Add("air" + S + "aircore.swc");
                    addLibs.Add("air" + S + "applicationupdater.swc");
                }
                else
                {
                    string playerglobal = null;
                    for (int i = minorVersion; i >= 0; i--)
                    {
                        string version = majorVersion + "." + i;
                        if (Directory.Exists(libPlayer + S + version))
                        {
                            playerglobal = "player" + S + version + S + "playerglobal.swc";
                            break;
                        }
                    }
                    if (playerglobal == null && Directory.Exists(libPlayer + S + majorVersion))
                        playerglobal = "player" + S + majorVersion + S + "playerglobal.swc";
                    if (playerglobal != null) addLibs.Add(playerglobal);
                }
                addLocales.Add("playerglobal_rb.swc");

                string test = exPath.Replace('\\', '/');
                string as3Fmk = PathHelper.ResolvePath("Library" + S + "AS3" + S + "frameworks");

                if (test.IndexOf("Library/AS3/frameworks/Flex") >= 0)
                {
                    addLibs.Add("framework.swc");
                    addLibs.Add("rpc.swc");
                    addLibs.Add("datavisualization.swc");
                    addLibs.Add("flash-integration.swc");
                    addLocales.Add("framework_rb.swc");
                    addLocales.Add("rpc_rb.swc");
                    addLocales.Add("datavisualization_rb.swc");
                    addLocales.Add("flash-integration_rb.swc");
                    if (hasAIRSupport)
                    {
                        addLibs.Add("air" + S + "airframework.swc");
                        addLocales.Add("airframework_rb.swc");
                    }

                    if (test.IndexOf("Library/AS3/frameworks/Flex4") >= 0)
                    {
                        addLibs.Add("spark.swc");
                        addLibs.Add("sparkskins.swc");
                        addLibs.Add("textLayout.swc");
                        addLibs.Add("osmf.swc");
                        addLocales.Add("spark_rb.swc");
                        addLocales.Add("textLayout_rb.swc");
                        addLocales.Add("osmf_rb.swc");
                        if (hasAIRSupport)
                        {
                            addLibs.Add("air" + S + "airspark.swc");
                            addLocales.Add("airspark_rb.swc");
                        }

                        MxmlFilter.AddManifest("http://ns.adobe.com/mxml/2009", as3Fmk + S + "Flex4" + S + "manifest.xml");
                    }
                    else 
                    {
                        MxmlFilter.AddManifest(MxmlFilter.OLD_MX, as3Fmk + S + "Flex3" + S + "manifest.xml");
                    }
                }
            }

            foreach (string file in addLocales)
            {
                string swcItem = sdkLocales + S + file;
                if (!File.Exists(swcItem)) swcItem = fallbackLocales + S + file;
                AddPath(swcItem);
            }
            foreach (string file in addLibs)
                AddPath(sdkLibs + S + file);

            // intrinsics (deprecated, excepted for FP10 Vector.<T>)
            string fp9cp = as3settings.AS3ClassPath + S + "FP9";
            AddPath(PathHelper.ResolvePath(fp9cp));
            if (majorVersion > 9)
            {
                string fp10cp = as3settings.AS3ClassPath + S + "FP" + majorVersion;
                AddPath(PathHelper.ResolvePath(fp10cp));
                string fp101cp = as3settings.AS3ClassPath + S + "FP" + majorVersion + "." + minorVersion;
                AddPath(PathHelper.ResolvePath(fp101cp));
            }

            // add external pathes
            List<PathModel> initCP = classPath;
            classPath = new List<PathModel>();
            string[] cpathes;
            if (exPath.Length > 0)
            {
                cpathes = exPath.Split(';');
                foreach (string cpath in cpathes)
                    AddPath(cpath.Trim());
            }

            // add library
            AddPath(PathHelper.LibraryDir + S + "AS3" + S + "classes");
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
        /// Build a list of file mask to explore the classpath
        /// </summary>
        public override string[] GetExplorerMask()
        {
            string[] mask = as3settings.AS3FileTypes;
            if (mask == null || mask.Length == 0 || (mask.Length == 1 && mask[1] == "")) 
                as3settings.AS3FileTypes = mask = new string[] { "*.as", "*.mxml" };
            return mask;
        }

        /// <summary>
        /// Parse a packaged library file
        /// </summary>
        /// <param name="path">Models owner</param>
        public override void ExploreVirtualPath(PathModel path)
        {
            if (path.WasExplored)
            {
                if (MxmlFilter.HasCatalog(path.Path)) MxmlFilter.AddCatalog(path.Path);

                if (path.Files.Count != 0) // already parsed
                    return;
            }

            try
            {
                if (File.Exists(path.Path) && !path.WasExplored)
                {
                    //TraceManager.AddAsync("parse " + path.Path);
                    lock (path)
                    {
                        path.WasExplored = true;
                        SwfOp.ContentParser parser = new SwfOp.ContentParser(path.Path);
                        parser.Run();
                        AbcConverter.Convert(parser, path, this);
                    }
                }
            }
            catch (Exception ex)
            {
                string message = TextHelper.GetString("Info.ExceptionWhileParsing");
                TraceManager.AddAsync(message + " " + path.Path);
                TraceManager.AddAsync(ex.Message);
                TraceManager.AddAsync(ex.StackTrace);
            }
        }

        /// <summary>
        /// Delete current class's cached file
        /// </summary>
        public override void RemoveClassCompilerCache()
        {
            // not implemented - is there any?
        }

        /// <summary>
        /// Create a new file model using the default file parser
        /// </summary>
        /// <param name="filename">Full path</param>
        /// <returns>File model</returns>
        public override FileModel GetFileModel(string fileName)
        {
            if (fileName == null || fileName.Length == 0 || !File.Exists(fileName))
                return new FileModel(fileName);

            fileName = PathHelper.GetLongPathName(fileName);
            if (fileName.EndsWith(".mxml", StringComparison.OrdinalIgnoreCase))
            {
                FileModel nFile = new FileModel(fileName);
                nFile.Context = this;
                nFile.HasFiltering = true;
                ASFileParser.ParseFile(nFile);
                return nFile;
            }
            else return base.GetFileModel(fileName);
        }

        private void GuessPackage(string fileName, FileModel nFile)
        {
            foreach(PathModel aPath in classPath)
                if (fileName.StartsWith(aPath.Path, StringComparison.OrdinalIgnoreCase))
                {
                    string local = fileName.Substring(aPath.Path.Length);
                    char sep = Path.DirectorySeparatorChar;
                    local = local.Substring(0, local.LastIndexOf(sep)).Replace(sep, '.');
                    nFile.Package = local.Length > 0 ? local.Substring(1) : "";
                    nFile.HasPackage = true;
                }
        }

        /// <summary>
        /// Build the file DOM
        /// </summary>
        /// <param name="filename">File path</param>
        protected override void GetCurrentFileModel(string fileName)
        {
            base.GetCurrentFileModel(fileName);
        }

        /// <summary>
        /// Refresh the file model
        /// </summary>
        /// <param name="updateUI">Update outline view</param>
        public override void UpdateCurrentFile(bool updateUI)
        {
            if (cFile != null && cFile != FileModel.Ignore
                && cFile.FileName.EndsWith(".mxml", StringComparison.OrdinalIgnoreCase))
                cFile.HasFiltering = true;
            base.UpdateCurrentFile(updateUI);

            if (cFile.HasFiltering)
            {
                MxmlComplete.mxmlContext = mxmlFilterContext;
                MxmlComplete.context = this;
            }
        }

        /// <summary>
        /// Update the class/member context for the given line number.
        /// Be carefull to restore the context after calling it with a custom line number
        /// </summary>
        /// <param name="line"></param>
        public override void UpdateContext(int line)
        {
            base.UpdateContext(line);
        }

        /// <summary>
        /// Called if a FileModel needs filtering
        /// - define inline AS3 ranges
        /// </summary>
        /// <param name="src"></param>
        /// <returns></returns>
        public override string FilterSource(string fileName, string src)
        {
            mxmlFilterContext = new MxmlFilterContext();
            return MxmlFilter.FilterSource(Path.GetFileNameWithoutExtension(fileName), src, mxmlFilterContext);
        }

        /// <summary>
        /// Called if a FileModel needs filtering
        /// - modify parsed model
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public override void FilterSource(FileModel model)
        {
            GuessPackage(model.FileName, model);
            if (mxmlFilterContext != null) MxmlFilter.FilterSource(model, mxmlFilterContext);
        }
        #endregion

        #region syntax checking

        internal void OnFileOperation(NotifyEvent e)
        {
            timerCheck.Stop();
            foreach (ITabbedDocument doc in PluginBase.MainForm.Documents)
                if (doc.FileName == fileWithSquiggles) ClearSquiggles(doc.SciControl);
        }

        public override void TrackTextChange(ScintillaNet.ScintillaControl sender, int position, int length, int linesAdded)
        {
            base.TrackTextChange(sender, position, length, linesAdded);
            if (!as3settings.DisableLiveChecking && IsFileValid)
            {
                timerCheck.Stop();
                timerCheck.Start();
            }
        }

        private void timerCheck_Elapsed(object sender, ElapsedEventArgs e)
        {
            BackgroundSyntaxCheck();
        }

        /// <summary>
        /// Checking syntax of current file
        /// </summary>
        private void BackgroundSyntaxCheck()
        {
            if (Panel == null) return;
            if (Panel.InvokeRequired)
            {
                Panel.BeginInvoke((System.Windows.Forms.MethodInvoker)delegate { BackgroundSyntaxCheck(); });
                return;
            }
            if (!IsFileValid) return;

            ScintillaNet.ScintillaControl sci = CurSciControl;
            if (sci == null) return;
            ClearSquiggles(sci);

            string src = CurSciControl.Text;
            FlexShells.Instance.CheckAS3(CurrentFile, as3settings.GetDefaultSDK().Path, src);
        }

        private void ClearSquiggles(ScintillaNet.ScintillaControl sci)
        {
            if (sci == null) return;
            try
            {
                int es = sci.EndStyled;
                int mask = (1 << sci.StyleBits);
                sci.StartStyling(0, mask);
                sci.SetStyling(sci.TextLength, 0);
                sci.StartStyling(es, mask - 1);
            }
            finally
            {
                fileWithSquiggles = null;
            }
        }

        private void Flex2Shell_SyntaxError(string error)
        {
            if (!IsFileValid) return;
            Match m = re_syntaxError.Match(error);
            if (!m.Success) return;

            ScintillaNet.ScintillaControl sci = CurSciControl;
            if (sci == null || m.Groups["filename"].Value != CurrentFile) 
                return;
            try
            {
                int line = int.Parse(m.Groups["line"].Value) - 1;
                if (sci.LineCount < line) return;
                int start = MBSafeColumn(sci, line, int.Parse(m.Groups["col"].Value) - 1);
                if (line == sci.LineCount && start == 0 && line > 0) start = -1;
                AddSquiggles(sci, line, start, start + 1);
            }
            catch { }
        }

        /// <summary>
        /// Convert multibyte column to byte length
        /// </summary>
        private int MBSafeColumn(ScintillaNet.ScintillaControl sci, int line, int length)
        {
            String text = sci.GetLine(line) ?? "";
            length = Math.Min(length, text.Length);
            return sci.MBSafeTextLength(text.Substring(0, length));
        }

        private void AddSquiggles(ScintillaNet.ScintillaControl sci, int line, int start, int end)
        {
            if (sci == null) return;
            fileWithSquiggles = CurrentFile;
            int position = sci.PositionFromLine(line) + start;
            int es = sci.EndStyled;
            int mask = 1 << sci.StyleBits;
            sci.SetIndicStyle(0, (int)ScintillaNet.Enums.IndicatorStyle.Squiggle);
            sci.SetIndicFore(0, 0x000000ff);
            sci.StartStyling(position, mask);
            sci.SetStyling(end - start, mask);
            sci.StartStyling(es, mask - 1);
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
            if (inClass == null || withClass == null) return Visibility.Public;
            // same file
            if (inClass.InFile == withClass.InFile)
                return Visibility.Public | Visibility.Internal | Visibility.Protected | Visibility.Private;
            
            // same package
            Visibility acc = Visibility.Public;
            if (inClass.InFile.Package == withClass.InFile.Package) acc |= Visibility.Internal;

            // inheritance affinity
            ClassModel tmp = inClass;
            while (!tmp.IsVoid())
            {
                if (tmp.Type == withClass.Type)
                {
                    acc |= Visibility.Protected;
                    break;
                }
                tmp = tmp.Extends;
            }
            return acc;
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
            // public & internal classes
            string package = CurrentModel.Package;
            foreach (PathModel aPath in classPath) if (aPath.IsValid && !aPath.Updating)
            {
                foreach (FileModel aFile in aPath.Files.Values)
                {
                    if (!aFile.HasPackage)
                        continue;

                    aClass = aFile.GetPublicClass();
                    if (!aClass.IsVoid() && aClass.IndexType == null)
                    {
                        if (aClass.Access == Visibility.Public
                            || (aClass.Access == Visibility.Internal && aFile.Package == package))
                        {
                            item = aClass.ToMemberModel();
                            item.Name = item.Type;
                            fullList.Add(item);
                        }
                    }
                    if (aFile.Package.Length > 0 && aFile.Members.Count > 0)
                    {
                        foreach (MemberModel member in aFile.Members)
                        {
                            item = member.Clone() as MemberModel;
                            item.Name = aFile.Package + "." + item.Name;
                            fullList.Add(item);
                        }
                    }
                    else if (aFile.Members.Count > 0)
                    {
                        foreach (MemberModel member in aFile.Members)
                        {
                            item = member.Clone() as MemberModel;
                            fullList.Add(item);
                        }
                    }
                }
            }
            // void
            fullList.Add(new MemberModel(features.voidKey, features.voidKey, FlagType.Class | FlagType.Intrinsic, 0));
            // private classes
            fullList.Add(GetPrivateClasses());

            // in cache
            fullList.Sort();
            completionCache.AllTypes = fullList;
            return fullList;
        }

        public override bool OnCompletionInsert(ScintillaNet.ScintillaControl sci, int position, string text)
        {
            bool isVector = false;
            if (text == "Vector")
            {
                isVector = true;
            }
            if (isVector)
            {
                string insert = null;
                string line = sci.GetLine(sci.LineFromPosition(position));
                Match m = Regex.Match(line, @"\svar\s+(?<varname>.+)\s*:\s*Vector\.<(?<indextype>.+)(?=(>\s*=))");
                if (m.Success)
                {
                    insert = String.Format(".<{0}>()", m.Groups["indextype"].Value);
                    sci.InsertText(position + text.Length, insert);
                    sci.CurrentPos = position + text.Length + insert.Length;
                    sci.SetSel(sci.CurrentPos, sci.CurrentPos);
                }
                else
                {
                    m = Regex.Match(line, @"\s*=");
                    if (m.Success)
                    {
                        ASResult result = ASComplete.GetExpressionType(sci, sci.PositionFromLine(sci.LineFromPosition(position)) + m.Index);
                        if (result != null && !result.IsNull() && result.Member != null && result.Member.Type != null)
                        {
                            m = Regex.Match(result.Member.Type, @"(?<=<).+(?=>)");
                            if (m.Success)
                            {
                                insert = String.Format(".<{0}>()", m.Value);
                                sci.InsertText(position + text.Length, insert);
                                sci.CurrentPos = position + text.Length + insert.Length;
                                sci.SetSel(sci.CurrentPos, sci.CurrentPos);
                                return true;
                            }
                        }
                    }
                    insert = ".<>";
                    sci.InsertText(position + text.Length, insert);
                    sci.CurrentPos = position + text.Length + 2;
                    sci.SetSel(sci.CurrentPos, sci.CurrentPos);
                    ASComplete.HandleAllClassesCompletion(sci, "", false, true);
                }
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
                    return ResolveGenericType(genType.Groups["gen"].Value + ".<T>", genType.Groups["type"].Value, inFile);
                else return ClassModel.VoidClass;
            }
            return base.ResolveType(cname, inFile);
        }

        /// <summary>
        /// Retrieve/build typed copies of generic types
        /// </summary>
        private ClassModel ResolveGenericType(string baseType, string indexType, FileModel inFile)
        {
            ClassModel originalClass = base.ResolveType(baseType, inFile);
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

            aClass.Name = baseType + "@" + indexType;
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
                            else param.Type = param.Type.Replace("<T>", typed);
                        }
                    }
                }
            }

            aFile.Classes.Add(aClass);
            return aClass;
        }

        protected MemberList GetPrivateClasses()
        {
            MemberList list = new MemberList();
            // private classes
            foreach(ClassModel model in cFile.Classes)
                if (model.Access == Visibility.Private)
                {
                    MemberModel item = model.ToMemberModel();
                    item.Type = item.Name;
                    item.Access = Visibility.Private;
                    list.Add(item);
                }
            // 'Class' members
            if (cClass != null)
                foreach (MemberModel member in cClass.Members)
                    if (member.Type == "Class") list.Add(member);
            return list;
        }

        /// <summary>
        /// Prepare AS3 intrinsic known vars/methods/classes
        /// </summary>
        protected override void InitTopLevelElements()
        {
            string filename = "toplevel.as";
            topLevel = new FileModel(filename);

            // search top-level declaration
            /*foreach (PathModel aPath in classPath)
                if (File.Exists(Path.Combine(aPath.Path, filename)))
                {
                    filename = Path.Combine(aPath.Path, filename);
                    topLevel = GetCachedFileModel(filename);
                    break;
                }

            if (File.Exists(filename))
            {
                // ok
            }
            // not found
            else
            {
                //ErrorHandler.ShowInfo("Top-level elements class not found. Please check your Program Settings.");
            }*/

            if (topLevel.Members.Search("this", 0, 0) == null)
                topLevel.Members.Add(new MemberModel("this", "", FlagType.Variable | FlagType.Intrinsic, Visibility.Public));
            if (topLevel.Members.Search("super", 0, 0) == null)
                topLevel.Members.Add(new MemberModel("super", "", FlagType.Variable | FlagType.Intrinsic, Visibility.Public));
            if (topLevel.Members.Search(features.voidKey, 0, 0) == null)
                topLevel.Members.Add(new MemberModel(features.voidKey, "", FlagType.Intrinsic, Visibility.Public));
            topLevel.Members.Sort();
            /*foreach (MemberModel member in topLevel.Members)
                member.Flags |= FlagType.Intrinsic;*/
        }

        #endregion

        #region Command line compiler

        /// <summary>
        /// Retrieve the context's default compiler path
        /// </summary>
        public override string GetCompilerPath()
        {
            return as3settings.GetDefaultSDK().Path ?? "Tools\\flexsdk";
        }

        /// <summary>
        /// Check current file's syntax
        /// </summary>
        public override void CheckSyntax()
        {
            if (IsFileValid && cFile.InlinedIn == null)
            {
                PluginBase.MainForm.CallCommand("Save", null);
                FlexShells.Instance.CheckAS3(cFile.FileName, as3settings.GetDefaultSDK().Path);
            }
        }

        /// <summary>
        /// Run MXMLC compiler in the current class's base folder with current classpath
        /// </summary>
        /// <param name="append">Additional comiler switches</param>
        public override void RunCMD(string append)
        {
            if (!IsCompilationTarget())
            {
                MessageBar.ShowWarning(TextHelper.GetString("Info.InvalidClass"));
                return;
            }

            string command = (append ?? "") + " -- " + CurrentFile;
            FlexShells.Instance.RunMxmlc(command, as3settings.GetDefaultSDK().Path);
        }

        private bool IsCompilationTarget()
        {
            return (!MainForm.CurrentDocument.IsUntitled && CurrentModel.Version >= 3);
        }

        /// <summary>
        /// Calls RunCMD with additional parameters taken from the classes @mxmlc doc tag
        /// </summary>
        public override bool BuildCMD(bool failSilently)
        {
            if (!IsCompilationTarget())
            {
                MessageBar.ShowWarning(TextHelper.GetString("Info.InvalidClass"));
                return false;
            }
            
            MainForm.CallCommand("SaveAllModified", null);

            FlexShells.Instance.QuickBuild(CurrentModel, as3settings.GetDefaultSDK().Path, failSilently, as3settings.PlayAfterBuild);
            return true;
        }
        #endregion
    }
}
