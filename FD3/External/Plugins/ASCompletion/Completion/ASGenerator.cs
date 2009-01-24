using System;
using System.Collections.Generic;
using System.Text;
using ASCompletion.Model;
using PluginCore.Helpers;
using ASCompletion.Context;
using PluginCore.Controls;
using PluginCore;
using System.Text.RegularExpressions;
using PluginCore.Localization;
using System.IO;
using PluginCore.Managers;

namespace ASCompletion.Completion
{
    public class ASGenerator
    {
        #region context detection (ie. entry points)
        const string patternEvent = "Listener\\s*\\(\\s*(?<event>[a-z_0-9.\\\"']+)\\s*,\\s*{0}";
        const string patternDelegate = @"\.\s*create\s*\(\s*[a-z_0-9.]+,\s*{0}";
        const string patternVarDecl = @"\s*{0}\s*:\s*{1}";
        const string patternMethod = @"{0}\s*\(";
        const string BlankLine = "$(Boundary)\n\n";
        const string NewLine = "$(Boundary)\n";

        static private string contextToken;
        static private string contextParam;
        static private MemberModel contextMember;
        static private bool firstVar;

        static public bool HandleGeneratorCompletion(ScintillaNet.ScintillaControl Sci, bool autoHide, string word)
        {
            ContextFeatures features = ASContext.Context.Features;
            if (features.overrideKey != null && word == features.overrideKey)
                return HandleOverrideCompletion(Sci, autoHide);
            return false;
        }

        static public void ContextualGenerator(ScintillaNet.ScintillaControl Sci)
        {
            if (ASContext.Context is ASContext)
                (ASContext.Context as ASContext).UpdateCurrentFile(false); // update model

            lookupPosition = -1;
            int position = Sci.CurrentPos;
            if (Sci.BaseStyleAt(position) == 19) // on keyword
                return;
            int line = Sci.LineFromPosition(position);
            contextToken = Sci.GetWordFromPosition(position);
            FoundDeclaration found = GetDeclarationAtLine(Sci, line);
            string text = Sci.GetLine(line);

            ASResult resolve = ASComplete.GetExpressionType(Sci, Sci.WordEndPosition(position, true));
            // ignore automatic vars (MovieClip members)
            if (resolve.Member != null && (resolve.Member.Flags & FlagType.AutomaticVar) > 0)
            {
                resolve.Member = null;
                resolve.Type = null;
            }

            if (found.member != null)
            {
                // private var -> property
                if ((found.member.Flags & FlagType.Variable) > 0 && (found.member.Flags & FlagType.LocalVar) == 0)
                {
                    // maybe we just want to import the member's non-imported type
                    Match m = Regex.Match(text, String.Format(patternVarDecl, found.member.Name, contextToken));
                    if (m.Success)
                    {
                        ClassModel type = ASContext.Context.ResolveType(contextToken, ASContext.Context.CurrentModel);
                        if (type.IsVoid() && CheckAutoImport(found))
                            return;
                    }
                    // create property
                    ShowGetSetList(found);
                    return;
                }
                // inside a function
                else if ((found.member.Flags & (FlagType.Function | FlagType.Getter | FlagType.Setter)) > 0
                    && resolve.Member == null && resolve.Type == null)
                {
                    if (contextToken != null)
                    {
                        // generate event handlers
                        Match m = Regex.Match(text, String.Format(patternEvent, contextToken), RegexOptions.IgnoreCase);
                        if (m.Success)
                        {
                            contextParam = CheckEventType(m.Groups["event"].Value);
                            ShowEventList(found);
                            return;
                        }
                        m = Regex.Match(text, String.Format(patternDelegate, contextToken), RegexOptions.IgnoreCase);
                        if (m.Success)
                        {
                            ShowDelegateList(found);
                            return;
                        }
                    }
                }
            }
            if (found.inClass != ClassModel.VoidClass && contextToken != null)
            {
                if (resolve.Member == null && resolve.Type != null
                    && (resolve.Type.Flags & FlagType.Interface) > 0) // implement interface
                {
                    contextParam = resolve.Type.Type;
                    ShowImplementInterface(found);
                    return;
                }

                if (resolve.Member != null && !ASContext.Context.CurrentClass.IsVoid()
                    && (resolve.Member.Flags & FlagType.LocalVar) > 0) // promote to class var
                {
                    contextMember = resolve.Member;
                    ShowPromoteLocal(found);
                }

                if (resolve.Member == null && resolve.Type == null) // declare unknown element
                {
                    if (!CheckAutoImport(found))
                    {
                        Match m = Regex.Match(text, String.Format(patternMethod, contextToken));
                        if (m.Success) ShowNewMethodList(found);
                        else ShowNewVarList(found);
                    }
                    return;
                }
            }
            // TODO  Empty line, show generators list?
        }

        private static FoundDeclaration GetDeclarationAtLine(ScintillaNet.ScintillaControl Sci, int line)
        {
            FoundDeclaration result = new FoundDeclaration();
            FileModel model = ASContext.Context.CurrentModel;

            foreach (MemberModel member in model.Members)
            {
                if (member.LineFrom <= line && member.LineTo >= line)
                {
                    result.member = member;
                    return result;
                }
            }

            foreach (ClassModel aClass in model.Classes)
            {
                if (aClass.LineFrom <= line && aClass.LineTo >= line)
                {
                    result.inClass = aClass;
                    foreach (MemberModel member in aClass.Members)
                    {
                        if (member.LineFrom <= line && member.LineTo >= line)
                        {
                            result.member = member;
                            return result;
                        }
                    }
                    return result;
                }
            }
            return result;
        }

        private static bool CheckAutoImport(FoundDeclaration found)
        {
            MemberList allClasses = ASContext.Context.GetAllProjectClasses();
            if (allClasses != null)
            {
                List<string> names = new List<string>();
                List<MemberModel> matches = new List<MemberModel>();
                string dotToken = "." + contextToken;
                foreach (MemberModel member in allClasses)
                    if (member.Name.EndsWith(dotToken) && !names.Contains(member.Name))
                    {
                        matches.Add(member);
                        names.Add(member.Name);
                    }
                if (matches.Count > 0)
                {
                    ShowImportClass(matches);
                    return true;
                }
            }
            return false;
        }

        /// <summary>
        /// For the Event handlers generator:
        /// check that the event name's const is declared in an Event type
        /// </summary>
        private static string CheckEventType(string name)
        {
            if (name.IndexOf('"') >= 0) return "Event";
            if (name.IndexOf('.') > 0) name = name.Substring(0, name.IndexOf('.'));
            ClassModel model = ASContext.Context.ResolveType(name, ASContext.Context.CurrentModel);
            if (model.IsVoid() || model.Name == "Event") return "Event";
            model.ResolveExtends();
            while (!model.IsVoid() && model.Name != "Event")
                model = model.Extends;
            if (model.Name == "Event") return name;
            else return "Event";
        }
        #endregion

        #region generators lists

        private static void ShowImportClass(List<MemberModel> matches)
        {
            if (matches.Count == 1)
            {
                ASGenerator.GenerateJob(GeneratorJobType.AddImport, matches[0], null);
                return;
            }

            List<ICompletionListItem> known = new List<ICompletionListItem>();
            foreach (MemberModel member in matches)
            {
                if ((member.Flags & FlagType.Class) > 0)
                    known.Add(new GeneratorItem("import " + member.Type, GeneratorJobType.AddImport, member, null));
                else if (member.IsPackageLevel)
                    known.Add(new GeneratorItem("import " + member.Name, GeneratorJobType.AddImport, member, null));
            }
            CompletionList.Show(known, false);
        }

        private static void ShowPromoteLocal(FoundDeclaration found)
        {
            List<ICompletionListItem> known = new List<ICompletionListItem>();
            string label = TextHelper.GetString("ASCompletion.Label.PromoteLocal");
            known.Add(new GeneratorItem(label, GeneratorJobType.PromoteLocal, found.member, found.inClass));
            CompletionList.Show(known, false);
        }

        private static void ShowImplementInterface(FoundDeclaration found)
        {
            List<ICompletionListItem> known = new List<ICompletionListItem>();
            string label = TextHelper.GetString("ASCompletion.Label.ImplementInterface");
            known.Add(new GeneratorItem(label, GeneratorJobType.ImplementInterface, null, found.inClass));
            CompletionList.Show(known, false);
        }

        private static void ShowNewVarList(FoundDeclaration found)
        {
            ContextFeatures features = ASContext.Context.Features;
            List<ICompletionListItem> known = new List<ICompletionListItem>();
            string labelVar = TextHelper.GetString("ASCompletion.Label.GenerateVar");
            string labelFun = TextHelper.GetString("ASCompletion.Label.GenerateFunction");
            known.Add(new GeneratorItem(labelVar, GeneratorJobType.Variable, found.member, found.inClass));
            known.Add(new GeneratorItem(labelFun, GeneratorJobType.Function, found.member, found.inClass));
            CompletionList.Show(known, false);
        }

        private static void ShowNewMethodList(FoundDeclaration found)
        {
            ContextFeatures features = ASContext.Context.Features;
            List<ICompletionListItem> known = new List<ICompletionListItem>();
            string label = TextHelper.GetString("ASCompletion.Label.GenerateFunction");
            known.Add(new GeneratorItem(label, GeneratorJobType.Function, found.member, found.inClass));
            CompletionList.Show(known, false);
        }

        private static void ShowDelegateList(FoundDeclaration found)
        {
            List<ICompletionListItem> known = new List<ICompletionListItem>();
            string label = String.Format(TextHelper.GetString("ASCompletion.Label.GenerateHandler"), "Delegate");
            known.Add(new GeneratorItem(label, GeneratorJobType.Delegate, found.member, found.inClass));
            CompletionList.Show(known, false);
        }

        private static void ShowEventList(FoundDeclaration found)
        {
            List<ICompletionListItem> known = new List<ICompletionListItem>();
            string tmp = TextHelper.GetString("ASCompletion.Label.GenerateHandler");
            string labelEvent = String.Format(tmp, "Event");
            string labelContext = String.Format(tmp, contextParam);
            string[] choices = (contextParam != "Event") ?
                new string[] { labelContext, labelEvent } :
                new string[] { labelEvent };
            for (int i = 0; i < choices.Length; i++)
            {
                known.Add(new GeneratorItem(choices[i], (GeneratorJobType)(i + 3), found.member, found.inClass));
            }
            CompletionList.Show(known, false);
        }

        private static void ShowGetSetList(FoundDeclaration found)
        {
            List<ICompletionListItem> known = new List<ICompletionListItem>();
            string labelGetSet = TextHelper.GetString("ASCompletion.Label.GenerateGetSet");
            string labelGet = TextHelper.GetString("ASCompletion.Label.GenerateGet");
            string labelSet = TextHelper.GetString("ASCompletion.Label.GenerateSet");
            string[] choices = new string[] { labelGetSet, labelGet, labelSet };
            for (int i = 0; i < choices.Length; i++)
            {
                known.Add(new GeneratorItem(choices[i], (GeneratorJobType)i, found.member, found.inClass));
            }
            CompletionList.Show(known, false);
        }
        #endregion

        #region code generation

        static private Regex reInsert = new Regex("\\s*([a-z])", RegexOptions.Compiled);

        static public void GenerateJob(GeneratorJobType job, MemberModel member, ClassModel inClass)
        {
            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;
            lookupPosition = Sci.CurrentPos;

            int position;
            MemberModel latest;
            bool detach = true;
            switch (job)
            {
                case GeneratorJobType.Getter:
                case GeneratorJobType.Setter:
                case GeneratorJobType.GetterSetter:
                    string name = GetPropertyNameFor(member);
                    latest = FindLatest(FlagType.Getter | FlagType.Setter, inClass);
                    if (latest == null)
                        return;
                    Sci.BeginUndoAction();
                    try
                    {
                        if ((member.Access & Visibility.Public) > 0) // hide member
                        {
                            MakePrivate(Sci, member);
                        }
                        if (name == null) // rename var with starting underscore
                        {
                            name = member.Name;
                            string newName = GetNewPropertyNameFor(member);
                            if (RenameMember(Sci, member, newName)) member.Name = newName;
                        }
                        position = Sci.PositionFromLine(latest.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);

                        if (job != GeneratorJobType.Getter)
                        {
                            Sci.SetSel(position, position);
                            GenerateSetter(name, member, position);
                        }
                        if (job != GeneratorJobType.Setter)
                        {
                            Sci.SetSel(position, position);
                            GenerateGetter(name, member, position);
                        }
                    }
                    finally
                    {
                        Sci.EndUndoAction();
                    }
                    break;

                case GeneratorJobType.BasicEvent:
                case GeneratorJobType.ComplexEvent:    
                    position = Sci.PositionFromLine(member.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);
                    Sci.SetSel(position, position);
                    string type = (job == GeneratorJobType.BasicEvent) ? "Event" : contextParam;
                    GenerateEventHandler(contextToken, type, member, position);
                    break;

                case GeneratorJobType.Delegate:
                    position = Sci.PositionFromLine(member.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);
                    Sci.SetSel(position, position);
                    GenerateDelegateMethod(contextToken, member, position);
                    break;

                case GeneratorJobType.Variable:
                    if (member == null)
                    {
                        detach = false;
                        lookupPosition = -1;
                        position = Sci.WordStartPosition(Sci.CurrentPos, true);
                        Sci.SetSel(position, Sci.WordEndPosition(position, true));
                    }
                    else
                    {
                        latest = FindLatest(FlagType.Variable | FlagType.Constant, inClass);
                        if (latest == null)
                            return;
                        position = FindNewVarPosition(Sci, inClass, latest);
                        if (position <= 0) return;
                        Sci.SetSel(position, position);
                    }
                    GenerateVariable(NewMember(contextToken, member, job, FlagType.Variable), position, detach);
                    break;

                case GeneratorJobType.Function:
                    if (member == null)
                    {
                        detach = false;
                        lookupPosition = -1;
                        position = Sci.WordStartPosition(Sci.CurrentPos, true);
                        Sci.SetSel(position, Sci.WordEndPosition(position, true));
                    }
                    else
                    {
                        position = Sci.PositionFromLine(member.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);
                        Sci.SetSel(position, position);
                    }
                    GenerateFunction(NewMember(contextToken, member, job, FlagType.Function), position, detach);
                    break;

                case GeneratorJobType.ImplementInterface:
                    ClassModel aType = ASContext.Context.ResolveType(contextParam, ASContext.Context.CurrentModel);
                    if (aType.IsVoid())
                        return;
                    latest = FindLatest(FlagType.Function, inClass);
                    if (latest == null)
                        return;
                    position = Sci.PositionFromLine(latest.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);
                    Sci.SetSel(position, position);
                    GenerateImplementation(aType, position);
                    break;

                case GeneratorJobType.PromoteLocal:
                    if (!RemoveLocalDeclaration(Sci, contextMember)) // try removing local declaration
                        return;

                    latest = FindLatest(FlagType.Variable | FlagType.Constant, inClass);
                    if (latest == null)
                        return;
                    
                    position = FindNewVarPosition(Sci, inClass, latest);
                    if (position <= 0) return;
                    Sci.SetSel(position, position);

                    contextMember.Flags -= FlagType.LocalVar;
                    if ((member.Flags & FlagType.Static) > 0)
                        contextMember.Flags |= FlagType.Static;
                    contextMember.Access = GetDefaultVisibility();
                    GenerateVariable(contextMember, position, detach);
                    
                    Sci.SetSel(lookupPosition, lookupPosition);
                    break;

                case GeneratorJobType.AddImport:
                    position = Sci.CurrentPos;
                    if ((member.Flags & FlagType.Class) == 0)
                    {
                        if (member.InFile == null) break;
                        member.Type = member.Name;
                    }
                    int offset = InsertImport(member, true);
                    position += offset;
                    Sci.SetSel(position, position);
                    break;
            }
        }

        private static int FindNewVarPosition(ScintillaNet.ScintillaControl Sci, ClassModel inClass, MemberModel latest)
        {
            firstVar = false;
            // found a var?
            if ((latest.Flags & FlagType.Variable) > 0)
                return Sci.PositionFromLine(latest.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);

            // add as first member
            int line = 0;
            int maxLine = Sci.LineCount;
            if (inClass != null) 
            {
                line = inClass.LineFrom;
                maxLine = inClass.LineTo;
            }
            else if (ASContext.Context.InPrivateSection) line = ASContext.Context.CurrentModel.PrivateSectionIndex;
            else maxLine = ASContext.Context.CurrentModel.PrivateSectionIndex;
            while (line < maxLine)
            {
                string text = Sci.GetLine(line++);
                if (text.IndexOf('{') >= 0)
                {
                    firstVar = true;
                    return Sci.PositionFromLine(line) - ((Sci.EOLMode == 0) ? 2 : 1);
                }
            }
            return -1;
        }

        private static bool RemoveLocalDeclaration(ScintillaNet.ScintillaControl Sci, MemberModel contextMember)
        {
            string type = "";
            if (contextMember.Type != null)
            {
                type = FormatType(contextMember.Type);
                if (type.IndexOf('*') > 0)
                    type = type.Replace("/*", @"/\*\s*").Replace("*/", @"\s*\*/");
                type = @":\s*" + type;
            }
            Regex reDecl = new Regex(String.Format(@"\s(var\s+{0}\s*{1})\s*", contextMember.Name, type));
            for (int i = contextMember.LineFrom; i <= contextMember.LineTo + 10; i++)
            {
                string text = Sci.GetLine(i);
                Match m = reDecl.Match(text);
                if (m.Success)
                {
                    int index = Sci.MBSafeTextLength(text.Substring(0, m.Groups[1].Index));
                    int position = Sci.PositionFromLine(i) + index;
                    int len = Sci.MBSafeTextLength(m.Groups[1].Value);
                    Sci.SetSel(position, position + len);
                    Sci.ReplaceSel(contextMember.Name);
                    UpdateLookupPosition(position, contextMember.Name.Length - len);
                    return true;
                }
            }
            return false;
        }

        private static void GenerateImplementation(ClassModel aType, int position)
        {
            List<string> typesUsed = new List<string>();

            StringBuilder sb = new StringBuilder(String.Format(GetTemplate("ImplementHeader"), aType.Type));
            string entry = "$(EntryPoint)";
            ASResult result = new ASResult();
            ClassModel cClass = ASContext.Context.CurrentClass;
            ContextFeatures features = ASContext.Context.Features;
            bool canGenerate = false;
            string template = GetTemplate("ImplementPart");

            aType.ResolveExtends(); // resolve inheritance chain
            while (!aType.IsVoid() && aType.QualifiedName != "Object")
            {
                foreach (MemberModel method in aType.Members)
                {
                    if ((method.Flags & (FlagType.Function | FlagType.Getter | FlagType.Setter)) == 0)
                        continue;

                    // check if method exists
                    ASComplete.FindMember(method.Name, cClass, result, method.Flags, 0);
                    if (!result.IsNull()) continue;

                    string decl = String.Format(template, GetDeclaration(method), entry);
                    entry = "";

                    sb.Append(decl);
                    canGenerate = true;

                    if (!typesUsed.Contains(method.Type)) typesUsed.Add(method.Type);
                    if (method.Parameters != null && method.Parameters.Count > 0)
                        foreach (MemberModel param in method.Parameters)
                            if (!typesUsed.Contains(param.Type)) typesUsed.Add(param.Type);
                }
                // interface inheritance
                aType = aType.Extends;
            }
            if (!canGenerate) 
                return;

            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;
            Sci.BeginUndoAction();
            try
            {
                position = Sci.CurrentPos;
                if (ASContext.Context.Settings.GenerateImports && typesUsed.Count > 0)
                {
                    int offset = AddImportsByName(typesUsed, aType.InFile, Sci.LineFromPosition(position));
                    position += offset;
                    Sci.SetSel(position, position);
                }
                InsertCode(position, sb.ToString());
            }
            finally { Sci.EndUndoAction(); }
        }

        private static MemberModel NewMember(string contextToken, MemberModel calledFrom, GeneratorJobType job, FlagType kind)
        {
            string type = (kind == FlagType.Function) ? ASContext.Context.Features.voidKey : null;
            if (calledFrom != null && (calledFrom.Flags & FlagType.Static) > 0)
                kind |= FlagType.Static;
            return new MemberModel(contextToken, type, kind, GetDefaultVisibility());
        }

        /// <summary>
        /// Get Visibility.Private or Visibility.Protected, depending on user setting forcing the use of protected.
        /// </summary>
        public static Visibility GetDefaultVisibility()
        {
            if (ASContext.Context.Features.protectedKey != null && ASContext.CommonSettings.GenerateProtectedDeclarations)
                return Visibility.Protected;
            else return Visibility.Private;
        }

        private static void GenerateFunction(MemberModel member, int position, bool detach)
        {
            string decl = String.Format(GetTemplate("Function"),
                GetDeclaration(member).Replace("()", "($(EntryPoint))"));
            if (detach) decl = BlankLine + decl;
            InsertCode(position, decl);
        }

        private static void GenerateVariable(MemberModel member, int position, bool detach)
        {
            string decl = String.Format(GetTemplate("Variable"), GetDeclaration(member));
            if (firstVar) { decl = '\t' + decl; firstVar = false; }
            if (detach) decl = NewLine + decl;
            InsertCode(position, decl);
        }

        public static bool MakePrivate(ScintillaNet.ScintillaControl Sci, MemberModel member)
        {
            ContextFeatures features = ASContext.Context.Features;
            string visibility = GetPrivateKeyword();
            if (features.publicKey == null || visibility == null) return false;
            Regex rePublic = new Regex(String.Format(@"\s*({0})\s+", features.publicKey));

            string line;
            Match m;
            int index, position;
            for (int i = member.LineFrom; i <= member.LineTo; i++)
            {
                line = Sci.GetLine(i);
                m = rePublic.Match(line);
                if (m.Success)
                {
                    index = Sci.MBSafeTextLength(line.Substring(0, m.Groups[1].Index));
                    position = Sci.PositionFromLine(i) + index;
                    Sci.SetSel(position, position + features.publicKey.Length);
                    Sci.ReplaceSel(visibility);
                    UpdateLookupPosition(position, features.publicKey.Length - visibility.Length);
                    return true;
                }
            }
            return false;
        }

        public static bool RenameMember(ScintillaNet.ScintillaControl Sci, MemberModel member, string newName)
        {
            ContextFeatures features = ASContext.Context.Features;
            string kind = features.varKey;
            if ((member.Flags & FlagType.Getter) > 0) kind = features.getKey;
            else if ((member.Flags & FlagType.Setter) > 0) kind = features.setKey;
            else if ((member.Flags & FlagType.Function) > 0) kind = features.functionKey;
            Regex reMember = new Regex(String.Format(@"{0}\s+({1})[\s:]", kind, member.Name));

            string line;
            Match m;
            int index, position;
            for (int i = member.LineFrom; i <= member.LineTo; i++)
            {
                line = Sci.GetLine(i);
                m = reMember.Match(line);
                if (m.Success)
                {
                    index = Sci.MBSafeTextLength(line.Substring(0, m.Groups[1].Index));
                    position = Sci.PositionFromLine(i) + index;
                    Sci.SetSel(position, position + member.Name.Length);
                    Sci.ReplaceSel(newName);
                    UpdateLookupPosition(position, 1);
                    return true;
                }
            }
            return false;
        }

        /// <summary>
        /// Return an obvious property name matching a private var, or null
        /// </summary>
        private static string GetPropertyNameFor(MemberModel member)
        {
            string name = member.Name;
            if (name.Length < 1)
                return null;
            int pre = name.IndexOf('_');
            if (pre < 0) pre = name.IndexOf('$');
            int post = name.Length - pre - 1;
            if (pre < 0) return null;
            if (pre > post) return name.Substring(0, pre); 
            else return name.Substring(pre + 1);
        }

        /// <summary>
        /// Return a smart new property name
        /// </summary>
        private static string GetNewPropertyNameFor(MemberModel member)
        {
            if (member.Name.Length < 1)
                return "prop";
            if (Regex.IsMatch(member.Name, "^[A-Z].*[a-z]")) 
                return Char.ToLower(member.Name[0]) + member.Name.Substring(1);
            else 
                return "_" + member.Name;
        }

        public static void GenerateDelegateMethod(string name, MemberModel afterMethod, int position)
        {
            string acc = GetPrivateAccessor(afterMethod);
            string decl = BlankLine + String.Format(GetTemplate("Delegate"),
                acc, name, ASContext.Context.Features.voidKey);
            InsertCode(position, decl);
        }

        public static void GenerateEventHandler(string name, string type, MemberModel afterMethod, int position)
        {
            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;
            Sci.BeginUndoAction();
            try
            {
                if (type == "Event")
                {
                    List<string> typesUsed = new List<string>();
                    typesUsed.Add("flash.events.Event");
                    position += AddImportsByName(typesUsed, null, Sci.LineFromPosition(position));
                    Sci.SetSel(position, position);
                }
                string acc = GetPrivateAccessor(afterMethod);
                string decl = BlankLine + String.Format(GetTemplate("EventHandler"),
                    acc, name, type, ASContext.Context.Features.voidKey);
                InsertCode(position, decl);
            }
            finally
            {
                Sci.EndUndoAction();
            }
        }

        public static void GenerateGetter(string name, MemberModel member, int position)
        {
            string acc = GetPublicAccessor(member);
            string decl = BlankLine + String.Format(GetTemplate("Getter"),
                acc, name, FormatType(member.Type), member.Name);
            InsertCode(position, decl);
        }

        public static void GenerateSetter(string name, MemberModel member, int position)
        {
            string acc = GetPublicAccessor(member);
            string decl = BlankLine + String.Format(GetTemplate("Setter"),
                acc, name, FormatType(member.Type), member.Name, ASContext.Context.Features.voidKey ?? "void");
            InsertCode(position, decl);
        }

        private static string GetPrivateAccessor(MemberModel member)
        {
            string acc = GetPrivateKeyword();
            if ((member.Flags & FlagType.Static) > 0) acc = (ASContext.Context.Features.staticKey ?? "static") + " " + acc;
            return acc;
        }

        private static string GetPrivateKeyword()
        {
            string acc;
            if (GetDefaultVisibility() == Visibility.Protected)
                acc = ASContext.Context.Features.protectedKey ?? "protected";
            else acc = ASContext.Context.Features.privateKey ?? "private";
            return acc;
        }

        static private string GetPublicAccessor(MemberModel member)
        {
            string acc = ASContext.Context.Features.publicKey ?? "public";
            if ((member.Flags & FlagType.Static) > 0) acc = (ASContext.Context.Features.staticKey ?? "static") + " " + acc;
            return acc;
        }

        static private MemberModel FindLatest(FlagType match, ClassModel inClass)
        {
            MemberList list;
            if (inClass == ClassModel.VoidClass)
                list = ASContext.Context.CurrentModel.Members;
            else list = inClass.Members;

            MemberModel fallback = null;
            MemberModel latest = null;
            foreach (MemberModel member in list)
            {
                fallback = member;
                if ((member.Flags & match) > 0) latest = member;
            }
            return latest ?? fallback;
        }

        static private string GetDeclaration(MemberModel member)
        {
            // modifiers
            FlagType ft = member.Flags;
            Visibility acc = member.Access;
            string modifiers = "";
            if ((ft & FlagType.Extern) > 0)
                modifiers += "extern ";
            if ((ft & FlagType.Static) > 0)
                modifiers += "static ";
            if ((acc & Visibility.Private) > 0)
                modifiers += "private ";
            else if ((acc & Visibility.Public) > 0)
                modifiers += "public ";
            else if ((acc & Visibility.Protected) > 0)
                modifiers += "protected ";
            else if ((acc & Visibility.Internal) > 0)
                modifiers += "internal ";
            // signature
            if ((ft & FlagType.Getter) > 0)
                return String.Format("{0}function get {1}", modifiers, member.ToDeclarationString());
            else if ((ft & FlagType.Setter) > 0)
                return String.Format("{0}function set {1}", modifiers, member.ToDeclarationString());
            else if ((ft & FlagType.Function) > 0)
                return String.Format("{0}function {1}", modifiers, member.ToDeclarationString());
            else if ((ft & FlagType.Constant) > 0)
                return String.Format("{0}const {1}", modifiers, member.ToDeclarationString());
            else
                return String.Format("{0}var {1}", modifiers, member.ToDeclarationString());
        }
        #endregion
        
        #region override generator
        /// <summary>
        /// List methods to override
        /// </summary>
        /// <param name="Sci">Scintilla control</param>
        /// <param name="autoHide">Don't keep the list open if the word does not match</param>
        /// <returns>Completion was handled</returns>
        static private bool HandleOverrideCompletion(ScintillaNet.ScintillaControl Sci, bool autoHide)
        {
            //int line = Sci.LineFromPosition(Sci.CurrentPos);

            // explore members
            IASContext ctx = ASContext.Context;
            ClassModel curClass = ctx.CurrentClass;
            if (curClass.IsVoid())
                return false;
            ContextFeatures features = ASContext.Context.Features;

            List<MemberModel> members = new List<MemberModel>();
            curClass.ResolveExtends(); // Resolve inheritance chain

            // explore function or getters or setters
            FlagType mask = FlagType.Function | FlagType.Getter | FlagType.Setter;
            ClassModel tmpClass = curClass.Extends;
            Visibility acc = ctx.TypesAffinity(curClass, tmpClass);
            while (tmpClass != null && !tmpClass.IsVoid())
            {
                if (tmpClass.QualifiedName.StartsWith("flash.utils.Proxy"))
                {
                    foreach (MemberModel member in tmpClass.Members)
                    {
                        member.Namespace = "flash_proxy";
                        members.Add(member);
                    }
                    break;
                }
                else
                {
                    foreach (MemberModel member in tmpClass.Members)
                        if ((member.Flags & FlagType.Dynamic) > 0
                            && (member.Flags & mask) > 0
                            && (member.Access & acc) > 0) members.Add(member);

                    tmpClass = tmpClass.Extends;
                    // members visibility
                    acc = ctx.TypesAffinity(curClass, tmpClass);
                }
            }
            members.Sort();

            // build list
            List<ICompletionListItem> known = new List<ICompletionListItem>();

            MemberModel last = null;
            foreach (MemberModel member in members)
            {
                if (last == null || last.Name != member.Name)
                    known.Add(new MemberItem(member));
                last = member;
            }
            if (known.Count > 0) CompletionList.Show(known, autoHide);
            return true;
        }

        static public void GenerateOverride(ScintillaNet.ScintillaControl Sci, ClassModel ofClass, MemberModel member, int position)
        {
            ContextFeatures features = ASContext.Context.Features;
            List<string> typesUsed = new List<string>();
            bool isProxy = (member.Namespace == "flash_proxy");
            if (isProxy) typesUsed.Add("flash.utils.flash_proxy");
            bool isAS2Event = ASContext.Context.Settings.LanguageId == "AS2" && member.Name.StartsWith("on");
            bool isObjectMethod = ofClass.QualifiedName == "Object";
            
            FlagType flags = member.Flags;
            string acc = "";
            string decl = "";
            /*if (features.hasNamespaces && member.Namespace != null && member.Namespace.Length > 0) 
                acc = member.Namespace; else*/
            if ((member.Access & Visibility.Public) > 0) acc = features.publicKey;
            else if ((member.Access & Visibility.Internal) > 0) acc = features.internalKey;
            else if ((member.Access & Visibility.Protected) > 0) acc = features.protectedKey;
            else if ((member.Access & Visibility.Private) > 0) acc = features.privateKey;
            string currentText = Sci.GetLine(Sci.LineFromPosition(position));
            if (currentText.IndexOf(acc) >= 0) acc = "";
            if ((flags & FlagType.Static) > 0 && currentText.IndexOf(features.staticKey) < 0) 
                acc = features.staticKey + " " + acc;

            if ((flags & (FlagType.Getter | FlagType.Setter)) > 0)
            {
                string type = member.Type;
                string name = member.Name;
                if (member.Parameters != null && member.Parameters.Count > 0) 
                    type = member.Parameters[0].Type;
                type = FormatType(type);
                if (type == null)
                {
                    string message = String.Format(TextHelper.GetString("Info.TypeDeclMissing"), member.Name);
                    ErrorManager.ShowInfo(message);
                    return;
                }

                if (ofClass.Members.Search(name, FlagType.Getter, 0) != null)
                {
                    decl += String.Format(GetTemplate("Getter"),
                        acc, name, type, "super." + name);
                }
                if (ofClass.Members.Search(name, FlagType.Getter, 0) != null)
                {
                    string tpl = GetTemplate("Setter");
                    if (decl.Length > 0)
                    {
                        decl += "\n\noverride ";
                        tpl = tpl.Replace("$(EntryPoint)", "");
                    }
                    decl += String.Format(tpl,
                        acc, name, type, "super." + name, ASContext.Context.Features.voidKey ?? "void");
                }
            }
            else
            {
                string type = FormatType(member.Type);
                if (type == null)
                {
                    string message = String.Format(TextHelper.GetString("Info.TypeDeclMissing"), member.Name);
                    ErrorManager.ShowInfo(message);
                    return;
                }
                if (acc.Length > 0) acc += " ";
                decl = acc + features.functionKey + " ";
                bool noRet = type.Equals("void", StringComparison.OrdinalIgnoreCase);
                type = (noRet) ? ASContext.Context.Features.voidKey : type;
                if (!noRet) typesUsed.Add(type);
                string action = (isProxy || isAS2Event) ? "" : GetSuperCall(member, typesUsed);
                decl += member.Name
                    + String.Format(GetTemplate("MethodOverride"), member.ParametersString(), type, action);
            }
            
            Sci.BeginUndoAction();
            try
            {
                if (ASContext.Context.Settings.GenerateImports && typesUsed.Count > 0)
                {
                    int offset = AddImportsByName(typesUsed, ofClass.InFile, Sci.LineFromPosition(position));
                    position += offset;
                }
                int len = member.Name.Length;
                if (!features.hasOverride || isObjectMethod)
                {
                    position -= features.overrideKey.Length + 1;
                    len += features.overrideKey.Length + 1;
                }
                Sci.SetSel(position, position + len);
                InsertCode(position, decl);
            }
            finally { Sci.EndUndoAction(); }
        }

        private static string FormatType(string type)
        {
            return MemberModel.FormatType(type);
        }

        private static string CleanType(string type)
        {
            int p = type.IndexOf('$');
            if (p > 0) return type.Substring(0, p);
            else return type;
        }

        private static string GetSuperCall(MemberModel member, List<string> typesUsed)
        {
            string args = "";
            if (member.Parameters != null)
                foreach (MemberModel param in member.Parameters)
                {
                    args += ", " + param.Name;
                    if (!typesUsed.Contains(param.Type)) typesUsed.Add(param.Type);
                }

            bool noRet = member.Type == null || member.Type.Length == 0 || member.Type.Equals("void", StringComparison.OrdinalIgnoreCase);
            if (!noRet && !typesUsed.Contains(member.Type))
                typesUsed.Add(member.Type);

            string action = "";
            if ((member.Flags & FlagType.Function) > 0)
            {
                action =
                    (noRet ? "" : "return ")
                    + "super." + member.Name
                    + ((args.Length > 2) ? "(" + args.Substring(2) + ")" : "()") + ";";
            }
            else if ((member.Flags & FlagType.Setter) > 0 && args.Length > 0)
            {
                action = "super." + member.Name + " = " + member.Parameters[0].Name + ";";
            }
            else if ((member.Flags & FlagType.Getter) > 0)
            {
                action = "return super." + member.Name + ";";
            }
            return action;
        }

        #endregion

        #region imports generator

        /// <summary>
        /// Generates all the missing imports in the given types list
        /// </summary>
        /// <param name="typesUsed">Types to import if needed</param>
        /// <param name="fromFile">Resolve types to import from this other file</param>
        /// <param name="atLine">Current line in editor</param>
        /// <returns>Inserted characters count</returns>
        private static int AddImportsByName(List<string> typesUsed, FileModel fromFile, int atLine)
        {
            int length = 0;
            IASContext context = ASContext.Context;
            FileModel inFile = context.CurrentModel;
            foreach (string type in typesUsed)
            {
                if (type == null || type.Length == 0 || type == context.Features.voidKey || type == "*")
                    continue;
                MemberModel import = null;
                ClassModel aClass = context.ResolveType(type, fromFile);
                if (aClass.InFile.Package.Length == 0)
                    continue;
                if (!aClass.IsVoid())
                {
                    import = new MemberModel(aClass.Name, CleanType(aClass.Type), aClass.Flags, aClass.Access);
                }
                else
                {
                    MemberList allKnown = context.GetAllProjectClasses();
                    foreach (MemberModel member in allKnown)
                        if (member.Name == type)
                        {
                            import = member.Clone() as MemberModel;
                            if ((import.Flags & FlagType.Class) == 0) import.Type = import.Name;
                            import.Type = CleanType(import.Type);
                            break;
                        }
                }
                if (import != null && !context.IsImported(import, atLine))
                    length += InsertImport(import, false);
            }
            return length;
        }

        /// <summary>
        /// Add an 'import' statement in the current file
        /// </summary>
        /// <param name="member">Generates 'import {member.Type};'</param>
        /// <param name="fixScrolling">Keep the editor view as if we didn't add any code in the file</param>
        /// <returns>Inserted characters count</returns>
        public static int InsertImport(MemberModel member, bool fixScrolling)
        {
            ScintillaNet.ScintillaControl sci = ASContext.CurSciControl;
            FileModel cFile = ASContext.Context.CurrentModel;
            int position = sci.CurrentPos;
            int curLine = sci.LineFromPosition(position);

            string fullPath = CleanType(member.Type); // ((member.Flags & FlagType.Class) > 0) ? member.Type : member.Name;
            string statement = "import " + fullPath + ";\n";

            // locate insertion point
            int line = (ASContext.Context.InPrivateSection) ? cFile.PrivateSectionIndex : 0;
            if (cFile.InlinedRanges != null)
            {
                foreach (InlineRange range in cFile.InlinedRanges)
                {
                    if (position > range.Start && position < range.End)
                    {
                        line = sci.LineFromPosition(range.Start) + 1;
                        break;
                    }
                }
            }
            int firstLine = line;
            bool found = false;
            int packageLine = -1;
            string txt;
            int indent = 0;
            Match mImport;
            while (line < curLine)
            {
                txt = sci.GetLine(line++).TrimStart();
                // insert imports after a package declaration
                if (txt.StartsWith("package"))
                {
                    packageLine = line;
                    firstLine = line;
                }
                else if (txt.StartsWith("import"))
                {
                    packageLine = -1;
                    found = true;
                    indent = sci.GetLineIndentation(line - 1);
                    // insert in alphabetical order
                    mImport = ASFileParser.re_import.Match(txt);
                    if (mImport.Success &&
                        String.Compare(mImport.Groups["package"].Value, fullPath) > 0)
                    {
                        line--;
                        break;
                    }
                }
                else if (found)
                {
                    line--;
                    break;
                }

                if (packageLine >= 0 && !cFile.haXe && txt.IndexOf('{') >= 0)
                {
                    packageLine = -1;
                    indent = sci.GetLineIndentation(line - 1) + PluginBase.MainForm.Settings.IndentSize;
                    firstLine = line;
                }
            }
            
            // insert
            if (line == curLine) line = firstLine;
            position = sci.PositionFromLine(line);
            firstLine = sci.FirstVisibleLine;
            sci.SetSel(position, position);
            sci.ReplaceSel(statement);
            sci.SetLineIndentation(line, indent);
            sci.LineScroll(0, firstLine - sci.FirstVisibleLine + 1);

            ASContext.Context.RefreshContextCache(fullPath);
            return sci.GetLine(line).Length + 1;
        }
        #endregion

        #region common safe code insertion
        static private int lookupPosition;

        private static void InsertCode(int position, string src)
        {
            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;
            Sci.BeginUndoAction();
            try
            {
                int len = SnippetHelper.InsertSnippetText(Sci, position, src);
                UpdateLookupPosition(position, len);
                AddLookupPosition();
            }
            finally { Sci.EndUndoAction(); }
        }

        private static void UpdateLookupPosition(int position, int delta)
        {
            if (position < lookupPosition + delta) lookupPosition += delta;
            else if (position < lookupPosition) lookupPosition = position; // replaced text at cursor position
        }

        private static void AddLookupPosition()
        {
            if (lookupPosition >= 0)
            {
                ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;
                if (Sci == null) return;
                int lookupLine = Sci.LineFromPosition(lookupPosition);
                int lookupCol = lookupPosition - Sci.PositionFromLine(lookupLine);
                ASContext.Panel.SetLastLookupPosition(ASContext.Context.CurrentFile, lookupLine, lookupCol);
            }
        }
        #endregion

        #region templates management

        static private Dictionary<string, string> templates;

        /// <summary>
        /// Templates are stored in the plugin's Data folder
        /// </summary>
        private static string GetTemplate(string name)
        {
            CheckTemplates();
            if (templates.ContainsKey(name)) return templates[name];
            else return "";
        }
        
        private static void CheckTemplates()
        {
            if (templates != null)
                return;
            templates = new Dictionary<string, string>();
            try
            {
                string res = Path.Combine(Path.Combine(PathHelper.DataDir, "ASCompletion"), "Generator.txt");
                if (!File.Exists(res) && !WriteDefaultTemplates(res))
                    return;

                string[] lines = File.ReadAllLines(res);
                foreach (string line in lines)
                {
                    string[] parts = line.Split('\t');
                    if (parts.Length == 2 && parts[0].Length > 0 && parts[1].Length > 0)
                    {
                        templates[parts[0]] = parts[1].Replace("\\n", "\n").Replace("\\t", "\t");
                    }
                }
            }
            catch { }
        }

        private static bool WriteDefaultTemplates(String file)
        {
            try
            {
                System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
                Stream src = assembly.GetManifestResourceStream("ASCompletion.Resources.Generator.txt");
                if (src == null) return false;

                String content;
                using (StreamReader sr = new StreamReader(src))
                {
                    content = sr.ReadToEnd();
                    sr.Close();
                }
                Directory.CreateDirectory(Path.GetDirectoryName(file));
                using (StreamWriter sw = File.CreateText(file))
                {
                    sw.Write(content);
                    sw.Close();
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
        #endregion
    }

    #region related structures
    /// <summary>
    /// Available generators
    /// </summary>
    public enum GeneratorJobType
    {
        GetterSetter = 0,
        Getter = 1,
        Setter = 2,
        ComplexEvent = 3,
        BasicEvent = 4,
        Delegate = 5,
        Variable = 6,
        Function = 7,
        ImplementInterface = 8,
        PromoteLocal = 9,
        AddImport = 10
    }

    /// <summary>
    /// Generation completion list item
    /// </summary>
    class GeneratorItem : ICompletionListItem
    {
        private string label;
        private GeneratorJobType job;
        private MemberModel member;
        private ClassModel inClass;

        public GeneratorItem(string label, GeneratorJobType job, MemberModel member, ClassModel inClass)
        {
            this.label = label;
            this.job = job;
            this.member = member;
            this.inClass = inClass;
        }

        public string Label
        {
            get { return label; }
        }
        public string Description
        {
            get { return "Generator template"; }
        }

        public System.Drawing.Bitmap Icon
        {
            get { return (System.Drawing.Bitmap)ASContext.Panel.GetIcon(PluginUI.ICON_DECLARATION); }
        }

        public string Value
        {
            get
            {
                ASGenerator.GenerateJob(job, member, inClass);
                return null;
            }
        }
    }

    class FoundDeclaration
    {
        public MemberModel member;
        public ClassModel inClass;

        public FoundDeclaration()
        {
            member = null;
            inClass = ClassModel.VoidClass;
        }
    }
    #endregion
}
