using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using ASCompletion.Context;
using ASCompletion.Model;
using ASCompletion.Settings;
using PluginCore;
using PluginCore.Controls;
using PluginCore.Helpers;
using PluginCore.Localization;
using PluginCore.Managers;
using WeifenLuo.WinFormsUI.Docking;

namespace ASCompletion.Completion
{
    public class ASGenerator
    {
        #region context detection (ie. entry points)
        const string patternEvent = "Listener\\s*\\((\\s*([a-z_0-9.\\\"']+)\\s*,)?\\s*(?<event>[a-z_0-9.\\\"']+)\\s*,\\s*{0}";
        const string patternDelegate = @"\.\s*create\s*\(\s*[a-z_0-9.]+,\s*{0}";
        const string patternVarDecl = @"\s*{0}\s*:\s*{1}";
        const string patternMethod = @"{0}\s*\(";
        const string patternMethodDecl = @"function\s+{0}\s*\(";
        const string patternClass = @"new\s*{0}";
        const string BlankLine = "$(Boundary)\n\n";
        const string NewLine = "$(Boundary)\n";
        static private Regex reModifier = new Regex("[a-z \t]*(public |private |protected )", RegexOptions.Compiled);
        static private Regex reOverride = new Regex("[a-z \t]*(override )", RegexOptions.Compiled);

        static private string contextToken;
        static private string contextParam;
        static private Match contextMatch;
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
            contextMatch = null;

            FoundDeclaration found = GetDeclarationAtLine(Sci, line);
            string text = Sci.GetLine(line);
            bool suggestItemDeclaration = false;

            if (!String.IsNullOrEmpty(contextToken) && Char.IsDigit(contextToken[0]))
            {
                ShowConvertToConst(found);
                return;
            }

            ASResult resolve = ASComplete.GetExpressionType(Sci, Sci.WordEndPosition(position, true));
            // ignore automatic vars (MovieClip members)
            if (resolve.Member != null &&
                (((resolve.Member.Flags & FlagType.AutomaticVar) > 0)
                 || (resolve.inClass != null && resolve.inClass.QualifiedName == "Object")))
            {
                resolve.Member = null;
                resolve.Type = null;
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
                    ShowPromoteLocalAndAddParameter(found);
                    return;
                }

                if (resolve.Member == null && resolve.Type == null) // import declaration
                {
                    if (CheckAutoImport(found))
                    {
                        return;
                    }
                    else
                    {
                        int stylemask = (1 << Sci.StyleBits) - 1;
                        if (ASComplete.IsTextStyle(Sci.StyleAt(position - 1) & stylemask))
                        {
                            suggestItemDeclaration = true;
                        }
                    }
                }
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
                        contextMatch = m;
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
                        // "generate event handlers" suggestion
                        Match m = Regex.Match(text, String.Format(patternEvent, contextToken), RegexOptions.IgnoreCase);
                        if (m.Success)
                        {
                            contextMatch = m;
                            contextParam = CheckEventType(m.Groups["event"].Value);
                            ShowEventList(found);
                            return;
                        }
                        m = Regex.Match(text, String.Format(patternDelegate, contextToken), RegexOptions.IgnoreCase);
                        if (m.Success)
                        {
                            contextMatch = m;
                            ShowDelegateList(found);
                            return;
                        }
                    }
                }

                // "Generate fields from parameters" suggestion
                if (found.member != null
                    && (found.member.Flags & FlagType.Function) > 0
                    && (found.member.Flags & FlagType.Static) == 0
                    && found.member.Parameters != null && (found.member.Parameters.Count > 0)
                    && resolve.Member != null && (resolve.Member.Flags & FlagType.ParameterVar) > 0)
                {
                    contextMember = resolve.Member;
                    ShowFieldFromParameter(found);
                    return;
                }

                // "add to interface" suggestion
                if (resolve.Member != null &&
                    resolve.Member.Name == found.member.Name &&
                    (found.member.Flags & FlagType.Function) > 0 &&
                    found.inClass != null &&
                    found.inClass.Implements != null &&
                    found.inClass.Implements.Count > 0)
                {
                    string funcName = found.member.Name;
                    int classPosStart = Sci.PositionFromLine(found.inClass.LineFrom);

                    bool skip = false;
                    foreach (string interf in found.inClass.Implements)
                    {
                        if (skip)
                        {
                            break;
                        }
                        ClassModel cm = ASContext.Context.ResolveType(interf, ASContext.Context.CurrentModel);
                        contextParam = cm.Type;
                        MemberList members = cm.Members;
                        foreach (MemberModel m in members)
                        {
                            if (m.Name.Equals(funcName))
                            {
                                skip = true;
                                break;
                            }
                        }
                    }
                    if (!skip && contextParam != null)
                    {
                        ShowAddInterfaceDefList(found);
                        return;
                    }
                }


                // "assign var to statement" siggestion
                int curLine = Sci.LineFromPosition(Sci.CurrentPos);
                string ln = Sci.GetLine(curLine);
                if (ln.Trim().Length > 0 && ln.TrimEnd().Length <= Sci.CurrentPos - Sci.PositionFromLine(curLine))
                {
                    Regex re = new Regex("=");
                    Match m = re.Match(ln);
                    if (!m.Success)
                    {
                        ShowAssignStatementToVarList(found);
                    }
                }
            }

            // suggest generate constructor / toString
            if (found.member == null && found.inClass != ClassModel.VoidClass && contextToken == null)
            {
                ClassModel cm = ASContext.Context.CurrentClass;
                MemberList members = cm.Members;

                bool hasConstructor = false;
                bool hasToString = false;
                foreach (MemberModel m in members)
                {
                    if ((m.Flags & FlagType.Constructor) > 0)
                    {
                        hasConstructor = true;
                    }
                    if ((m.Flags & FlagType.Function) > 0 && m.Name.Equals("toString"))
                    {
                        hasToString = true;
                    }
                }

                if (!hasConstructor || !hasToString)
                {
                    ShowConstructorAndToStringList(found, hasConstructor, hasToString);
                    return;
                }
            }

            if (resolve.Member != null
                && resolve.Type != null
                && resolve.Type.QualifiedName == "String"
                && found.inClass != null)
            {
                int lineStartPos = Sci.PositionFromLine(Sci.LineFromPosition(Sci.CurrentPos));
                string lineStart = text.Substring(0, Sci.CurrentPos - lineStartPos);
                Match m = Regex.Match(lineStart, String.Format(@"new\s+(?<event>\w+)\s*\(\s*\w+", lineStart));
                if (m.Success)
                {
                    Group g = m.Groups["event"];
                    ASResult eventResolve = ASComplete.GetExpressionType(Sci, lineStartPos + g.Index + g.Length);
                    if (eventResolve != null && eventResolve.Type != null)
                    {
                        ClassModel aType = eventResolve.Type;
                        aType.ResolveExtends();
                        while (!aType.IsVoid() && aType.QualifiedName != "Object")
                        {
                            if (aType.QualifiedName == "flash.events.Event")
                            {
                                contextParam = eventResolve.Type.QualifiedName;
                                ShowEventMetatagList(found);
                                return;
                            }
                            aType = aType.Extends;
                        }
                    }
                }
            }


            
            // suggest declaration
            if (contextToken != null)
            {
                if (suggestItemDeclaration)
                {
                    Match m = Regex.Match(text, String.Format(patternClass, contextToken));
                    if (m.Success)
                    {
                        contextMatch = m;
                        ShowNewClassList(found);
                    }
                    else
                    {
                        m = Regex.Match(text, String.Format(patternMethod, contextToken));
                        if (m.Success)
                        {
                            contextMatch = m;
                            ShowNewMethodList(found);
                        }
                        else ShowNewVarList(found);
                    }
                }
                else
                {
                    if (resolve != null 
                        && resolve.inClass != null 
                        && resolve.inClass.InFile != null
                        && resolve.Member != null
                        && (resolve.Member.Flags & FlagType.Function) > 0
                        && File.Exists(resolve.inClass.InFile.FileName)
                        && !resolve.inClass.InFile.FileName.StartsWith(PathHelper.AppDir))
                    {
                        Match m = Regex.Match(text, String.Format(patternMethodDecl, contextToken));
                        Match m2 = Regex.Match(text, String.Format(patternMethod, contextToken));
                        if (!m.Success && m2.Success)
                        {
                            contextMatch = m;
                            ShowChangeMethodDeclList(found);
                        }
                    }
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
                ASGenerator.GenerateJob(GeneratorJobType.AddImport, matches[0], null, null);
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

        private static void ShowPromoteLocalAndAddParameter(FoundDeclaration found)
        {
            List<ICompletionListItem> known = new List<ICompletionListItem>();
            string label = TextHelper.GetString("ASCompletion.Label.PromoteLocal");
            string labelParam = TextHelper.GetString("ASCompletion.Label.AddAsParameter");
            known.Add(new GeneratorItem(label, GeneratorJobType.PromoteLocal, found.member, found.inClass));
            known.Add(new GeneratorItem(labelParam, GeneratorJobType.AddAsParameter, found.member, found.inClass));
            CompletionList.Show(known, false);
        }

        private static void ShowConvertToConst(FoundDeclaration found)
        {
            List<ICompletionListItem> known = new List<ICompletionListItem>();
            string label = TextHelper.GetString("ASCompletion.Label.ConvertToConst");
            known.Add(new GeneratorItem(label, GeneratorJobType.ConvertToConst, found.member, found.inClass));
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

            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;

            string autoSelect = "";

            ASResult result = ASComplete.GetExpressionType(Sci, Sci.WordEndPosition(Sci.CurrentPos, true));
            if (!(result != null && result.relClass != null))
            {
                result = null;
            }
            else if (found.inClass.QualifiedName.Equals(result.relClass.QualifiedName))
            {
                result = null;
            }

            bool isConst = false;
            string textAtCursor = Sci.GetWordFromPosition(Sci.CurrentPos);
            if (textAtCursor != null && textAtCursor.ToUpper().Equals(textAtCursor))
            {
                isConst = true;
            }

            ClassModel inClass = result != null ? result.relClass : found.inClass;
            bool isInterface = ClassIsInterface(inClass);

            if (!isInterface)
            {
                if (isConst)
                {
                    string labelConst = TextHelper.GetString("ASCompletion.Label.GenerateConstant");
                    known.Add(new GeneratorItem(labelConst, GeneratorJobType.Constant, found.member, found.inClass));

                    autoSelect = labelConst;
                }

                if (result == null)
                {
                    string labelVar = TextHelper.GetString("ASCompletion.Label.GeneratePrivateVar");
                    known.Add(new GeneratorItem(labelVar, GeneratorJobType.Variable, found.member, found.inClass));
                }

                string labelVarPublic = TextHelper.GetString("ASCompletion.Label.GeneratePublicVar");
                known.Add(new GeneratorItem(labelVarPublic, GeneratorJobType.VariablePublic, found.member, found.inClass));

                if (result == null)
                {
                    string labelFun = TextHelper.GetString("ASCompletion.Label.GeneratePrivateFunction");
                    known.Add(new GeneratorItem(labelFun, GeneratorJobType.Function, found.member, found.inClass));
                }
            }

            string labelFunPublic = TextHelper.GetString("ASCompletion.Label.GenerateFunctionPublic");
            if (isInterface)
            {
                labelFunPublic = TextHelper.GetString("ASCompletion.Label.GenerateFunctionInterface");
                autoSelect = labelFunPublic;
            }
            known.Add(new GeneratorItem(labelFunPublic, GeneratorJobType.FunctionPublic, found.member, found.inClass));

            if (PluginBase.CurrentProject != null && PluginBase.CurrentProject.Language.StartsWith("as"))
            {
                string labelClass = TextHelper.GetString("ASCompletion.Label.GenerateClass");
                known.Add(new GeneratorItem(labelClass, GeneratorJobType.Class, found.member, found.inClass));
            }
            CompletionList.Show(known, false);
        }

        private static void ShowChangeMethodDeclList(FoundDeclaration found)
        {
            List<ICompletionListItem> known = new List<ICompletionListItem>();
            string label = TextHelper.GetString("ASCompletion.Label.ChangeMethodDecl");
            known.Add(new GeneratorItem(label, GeneratorJobType.ChangeMethodDecl, found.member, found.inClass));
            CompletionList.Show(known, false);
        }

        private static void ShowNewMethodList(FoundDeclaration found)
        {
            ContextFeatures features = ASContext.Context.Features;
            List<ICompletionListItem> known = new List<ICompletionListItem>();

            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;

            string autoSelect = "";

            ASResult result = ASComplete.GetExpressionType(Sci, Sci.WordEndPosition(Sci.CurrentPos, true));
            if (!(result != null && result.relClass != null))
            {
                result = null;
            }
            else if (found.inClass.QualifiedName.Equals(result.relClass.QualifiedName))
            {
                result = null;
            }

            ClassModel inClass = result != null ? result.relClass : found.inClass;
            bool isInterface = ClassIsInterface(inClass);

            if (!isInterface)
            {
                if (result == null)
                {
                    string label = TextHelper.GetString("ASCompletion.Label.GeneratePrivateFunction");
                    known.Add(new GeneratorItem(label, GeneratorJobType.Function, found.member, found.inClass));
                }
            }

            string labelFunPublic = TextHelper.GetString("ASCompletion.Label.GenerateFunctionPublic");
            if (isInterface)
            {
                labelFunPublic = TextHelper.GetString("ASCompletion.Label.GenerateFunctionInterface");
                autoSelect = labelFunPublic;
            }
            known.Add(new GeneratorItem(labelFunPublic, GeneratorJobType.FunctionPublic, found.member, found.inClass));

            CompletionList.Show(known, false);
        }

        private static void ShowAssignStatementToVarList(FoundDeclaration found)
        {
            List<ICompletionListItem> known = new List<ICompletionListItem>();

            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;

            if (PluginBase.CurrentProject != null && PluginBase.CurrentProject.Language.StartsWith("as"))
            {
                string labelClass = TextHelper.GetString("ASCompletion.Label.AssignStatementToVar");
                known.Add(new GeneratorItem(labelClass, GeneratorJobType.AssignStatementToVar, found.member, found.inClass));

                CompletionList.Show(known, false);
            }
        }

        private static void ShowNewClassList(FoundDeclaration found)
        {
            ContextFeatures features = ASContext.Context.Features;
            List<ICompletionListItem> known = new List<ICompletionListItem>();

            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;

            if (PluginBase.CurrentProject != null && PluginBase.CurrentProject.Language.StartsWith("as"))
            {
                string labelClass = TextHelper.GetString("ASCompletion.Label.GenerateClass");
                known.Add(new GeneratorItem(labelClass, GeneratorJobType.Class, found.member, found.inClass));

                CompletionList.Show(known, false);
            }
        }

        private static void ShowConstructorAndToStringList(FoundDeclaration found, bool hasConstructor, bool hasToString)
        {
            ContextFeatures features = ASContext.Context.Features;
            List<ICompletionListItem> known = new List<ICompletionListItem>();

            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;

            if (PluginBase.CurrentProject != null && PluginBase.CurrentProject.Language.StartsWith("as"))
            {
                if (!hasConstructor)
                {
                    string labelClass = TextHelper.GetString("ASCompletion.Label.GenerateConstructor");
                    known.Add(new GeneratorItem(labelClass, GeneratorJobType.Constructor, found.member, found.inClass));
                }

                if (!hasToString)
                {
                    string labelClass = TextHelper.GetString("ASCompletion.Label.GenerateToString");
                    known.Add(new GeneratorItem(labelClass, GeneratorJobType.ToString, found.member, found.inClass));
                }

                CompletionList.Show(known, false);
            }
        }

        private static void ShowEventMetatagList(FoundDeclaration found)
        {
            ContextFeatures features = ASContext.Context.Features;
            List<ICompletionListItem> known = new List<ICompletionListItem>();

            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;

            string label = TextHelper.GetString("ASCompletion.Label.GenerateEventMetatag");
            known.Add(new GeneratorItem(label, GeneratorJobType.EventMetatag, found.member, found.inClass));

            CompletionList.Show(known, false);
        }

        private static void ShowFieldFromParameter(FoundDeclaration found)
        {
            ContextFeatures features = ASContext.Context.Features;
            List<ICompletionListItem> known = new List<ICompletionListItem>();

            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;

            if (PluginBase.CurrentProject != null && PluginBase.CurrentProject.Language.StartsWith("as"))
            {
                string labelClass = TextHelper.GetString("ASCompletion.Label.GenerateFieldFromPatameter");
                known.Add(new GeneratorItem(labelClass, GeneratorJobType.FieldFromPatameter, found.member, found.inClass));

                CompletionList.Show(known, false);
            }
        }

        private static void ShowAddInterfaceDefList(FoundDeclaration found)
        {
            ContextFeatures features = ASContext.Context.Features;
            List<ICompletionListItem> known = new List<ICompletionListItem>();

            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;

            if (PluginBase.CurrentProject != null && PluginBase.CurrentProject.Language.StartsWith("as"))
            {
                string labelClass = TextHelper.GetString("ASCompletion.Label.AddInterfaceDef");
                known.Add(new GeneratorItem(labelClass, GeneratorJobType.AddInterfaceDef, found.member, found.inClass));

                CompletionList.Show(known, false);
            }
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
            string labelDataEvent = String.Format(tmp, "DataEvent");
            string labelContext = String.Format(tmp, contextParam);
            string[] choices = (contextParam != "Event") ?
                new string[] { labelContext, labelEvent } :
                new string[] { labelEvent, labelDataEvent };
            for (int i = 0; i < choices.Length; i++)
            {
                known.Add(new GeneratorItem(choices[i],
                    choices[i] == labelContext ? GeneratorJobType.ComplexEvent : GeneratorJobType.BasicEvent,
                    found.member, found.inClass));
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

        static public void SetJobContext(String contextToken, String contextParam, MemberModel contextMember, Match contextMatch)
        {
            ASGenerator.contextToken = contextToken;
            ASGenerator.contextParam = contextParam;
            ASGenerator.contextMember = contextMember;
            ASGenerator.contextMatch = contextMatch;
        }

        static public void GenerateJob(GeneratorJobType job, MemberModel member, ClassModel inClass, string itemLabel)
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

                    PropertiesGenerationLocations location = ASContext.CommonSettings.PropertiesGenerationLocation;
                    if (location == PropertiesGenerationLocations.AfterLastPropertyDeclaration)
                    {
                        latest = FindLatest(FlagType.Getter | FlagType.Setter, inClass);
                    }
                    else latest = member;
                    if (latest == null) return;

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

                        int atLine = latest.LineTo + 1;
                        if (location == PropertiesGenerationLocations.BeforeVariableDeclaration)
                            atLine = latest.LineTo;
                        position = Sci.PositionFromLine(atLine) - ((Sci.EOLMode == 0) ? 2 : 1);

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
                    string type = contextParam;
                    if (job == GeneratorJobType.BasicEvent)
                        if (itemLabel.IndexOf("DataEvent") >= 0) type = "DataEvent"; else type = "Event";
                    GenerateEventHandler(contextToken, type, member, position);
                    break;

                case GeneratorJobType.Delegate:
                    position = Sci.PositionFromLine(member.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);
                    Sci.SetSel(position, position);
                    GenerateDelegateMethod(contextToken, member, position);
                    break;

                case GeneratorJobType.Constant:
                case GeneratorJobType.Variable:
                case GeneratorJobType.VariablePublic:
                    Sci.BeginUndoAction();
                    try
                    {
                        GenerateVariableJob(job, Sci, member, detach, inClass);
                    }
                    finally
                    {
                        Sci.EndUndoAction();
                    }
                    break;

                case GeneratorJobType.Function:
                case GeneratorJobType.FunctionPublic:
                    Sci.BeginUndoAction();
                    try
                    {
                        GenerateFunctionJob(job, Sci, member, detach, inClass);
                    }
                    finally
                    {
                        Sci.EndUndoAction();
                    }
                    break;

                case GeneratorJobType.ImplementInterface:
                    ClassModel aType = ASContext.Context.ResolveType(contextParam, ASContext.Context.CurrentModel);
                    if (aType.IsVoid()) return;

                    latest = FindLatest(FlagType.Function, inClass);
                    if (latest == null) return;

                    position = Sci.PositionFromLine(latest.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);
                    Sci.SetSel(position, position);
                    GenerateImplementation(aType, position);
                    break;

                case GeneratorJobType.PromoteLocal:
                    if (!RemoveLocalDeclaration(Sci, contextMember)) return;

                    latest = FindLatest(FlagType.Variable | FlagType.Constant, inClass);
                    if (latest == null) return;

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

                case GeneratorJobType.AddAsParameter:
                    Sci.BeginUndoAction();
                    try
                    {
                        AddAsParameter(inClass, Sci, member, detach);
                    }
                    finally
                    {
                        Sci.EndUndoAction();
                    }
                    
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

                case GeneratorJobType.Class:
                    String clasName = Sci.GetWordFromPosition(Sci.CurrentPos);
                    GenerateClass(Sci, clasName, inClass);
                    break;

                case GeneratorJobType.Constructor:
                    member = new MemberModel(inClass.Name, inClass.QualifiedName, FlagType.Constructor | FlagType.Function, Visibility.Public);
                    GenerateFunction(
                        member,
                        Sci.CurrentPos, false, "", inClass);
                    break;

                case GeneratorJobType.ToString:
                    Sci.BeginUndoAction();
                    try
                    {
                        GenerateToString(inClass, Sci, member);
                    }
                    finally
                    {
                        Sci.EndUndoAction();
                    }
                    break;

                case GeneratorJobType.FieldFromPatameter:
                    Sci.BeginUndoAction();
                    try
                    {
                        GenerateFieldFromParameter(Sci, member, inClass);
                    }
                    finally
                    {
                        Sci.EndUndoAction();
                    }
                    break;

                case GeneratorJobType.AddInterfaceDef:
                    Sci.BeginUndoAction();
                    try
                    {
                        AddInterfaceDefJob(inClass, Sci, member);
                    }
                    finally
                    {
                        Sci.EndUndoAction();
                    }
                    break;

                case GeneratorJobType.ConvertToConst:
                    Sci.BeginUndoAction();
                    try
                    {
                        ConvertToConst(inClass, Sci, member, detach);
                    }
                    finally
                    {
                        Sci.EndUndoAction();
                    }
                    break;

                case GeneratorJobType.ChangeMethodDecl:
                    Sci.BeginUndoAction();
                    try
                    {
                        ChangeMethodDecl(Sci, member, inClass);
                    }
                    finally
                    {
                        Sci.EndUndoAction();
                    }
                    break;

                case GeneratorJobType.EventMetatag:
                    Sci.BeginUndoAction();
                    try
                    {
                        EventMetatag(inClass, Sci, member);
                    }
                    finally
                    {
                        Sci.EndUndoAction();
                    }
                    break;

                case GeneratorJobType.AssignStatementToVar:
                    Sci.BeginUndoAction();
                    try
                    {
                        AssignStatementToVar(inClass, Sci, member);
                    }
                    finally
                    {
                        Sci.EndUndoAction();
                    }
                    break;
            }
        }

        private static void AssignStatementToVar(ClassModel inClass, ScintillaNet.ScintillaControl Sci, MemberModel member)
        {
            int lineNum = Sci.LineFromPosition(Sci.CurrentPos);
            string line = Sci.GetLine(lineNum);
            StatementReturnType returnType = GetStatementReturnType(Sci, inClass, line, Sci.PositionFromLine(lineNum));

            if (returnType == null)
            {
                return;
            }
            
            IASContext cntx = inClass.InFile.Context;
            bool isAs3 = cntx.Settings.LanguageId == "AS3";
            string voidWord = isAs3 ? "void" : "Void";
            string type = null;
            string varname = null;
            string cleanType = null;
            ASResult resolve = returnType.resolve;
            int pos = returnType.position;
            string word = returnType.word;

            if (resolve != null && !resolve.IsNull())
            {
                if (resolve.Member != null && resolve.Member.Type != null)
                {
                    type = resolve.Member.Type;
                }
                else if (resolve.Type != null && resolve.Type.Name != null)
                {
                    type = returnType.resolve.Type.QualifiedName;
                }

                if (resolve.Member != null && resolve.Member.Name != null)
                {
                    varname = GuessVarName(resolve.Member.Name, type);
                }
            }

            if (word != null && Char.IsDigit(word[0]))
            {
                word = null;
            }
            
            if (type == voidWord)
            {
                type = null;
            }
            if (varname == null)
            {
                varname = GuessVarName(word, type);
            }
            if (varname != null && varname == word)
            {
                if (varname.Length == 1)
                {
                    varname = varname + "1";
                }
                else
                {
                    varname = varname[0] + "";
                }
            }

            if (type != null)
            {
                cleanType = FormatType(GetShortType(type));
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("var ");
            if (varname != null)
            {
                sb.Append(varname);
                sb.Append(":");
            }
            if (cleanType != null)
            {
                sb.Append(cleanType);
            }
            else
            {
                sb.Append("$(EntryPoint)");
            }
            sb.Append(" = $(Boundary)");

            int indent = Sci.GetLineIndentation(lineNum);
            pos = Sci.PositionFromLine(lineNum) + indent / Sci.Indent;

            Sci.CurrentPos = pos;
            Sci.SetSel(pos, pos);
            InsertCode(pos, sb.ToString());

            if (type != null)
            {
                ClassModel inClassForImport = null;
                if (resolve.inClass != null)
                {
                    inClassForImport = resolve.inClass;
                }
                else if (resolve.relClass != null)
                {
                    inClassForImport = resolve.relClass;
                }
                else 
                {
                    inClassForImport = inClass;
                }
                List<string> l = new List<string>();
                l.Add(getQualifiedType(type, inClassForImport));
                pos += AddImportsByName(l, Sci.LineFromPosition(pos));
            }
        }

        private static void EventMetatag(ClassModel inClass, ScintillaNet.ScintillaControl Sci, MemberModel member)
        {
            ASResult resolve = ASComplete.GetExpressionType(Sci, Sci.WordEndPosition(Sci.CurrentPos, true));
            string line = Sci.GetLine(inClass.LineFrom);
            int position = Sci.PositionFromLine(inClass.LineFrom) + (line.Length - line.TrimStart().Length);

            string value = resolve.Member.Value;
            if (value != null)
            {
                if (value.StartsWith("\""))
                {
                    value = value.Trim(new char[] { '"' });
                }
                else if (value.StartsWith("'"))
                {
                    value = value.Trim(new char[] { '\'' });
                }
            }
            else
            {
                value = resolve.Member.Type;
            }

            if (value == "" || value == null)
            {
                return;
            }

            Regex re1 = new Regex("'(?:[^'\\\\]|(?:\\\\\\\\)|(?:\\\\\\\\)*\\\\.{1})*'");
            Regex re2 = new Regex("\"(?:[^\"\\\\]|(?:\\\\\\\\)|(?:\\\\\\\\)*\\\\.{1})*\"");
            Match m1 = re1.Match(value);
            Match m2 = re2.Match(value);

            if (m1.Success || m2.Success)
            {
                Match m = null;
                if (m1.Success && m2.Success)
                {
                    if (m1.Index > m2.Index)
                    {
                        m = m2;
                    }
                    else
                    {
                        m = m1;
                    }
                }
                else if (m1.Success)
                {
                    m = m1;
                }
                else
                {
                    m = m2;
                }
                value = value.Substring(m.Index + 1, m.Length - 2);
            }

            string template = GetTemplate("EventMetatag", "[Event(name=\"{0}\", type=\"{1}\")]");
            template = String.Format(template + "\n$(Boundary)", value, contextParam);

            AddLookupPosition();

            Sci.CurrentPos = position;
            Sci.SetSel(position, position);
            InsertCode(position, template);
        }

        private static void ConvertToConst(ClassModel inClass, ScintillaNet.ScintillaControl Sci, MemberModel member, bool detach)
        {
            String suggestion = "NEW_CONST";
            String label = TextHelper.GetString("ASCompletion.Label.ConstName");
            String title = TextHelper.GetString("ASCompletion.Title.ConvertToConst");

            Hashtable info = new Hashtable();
            info["suggestion"] = suggestion;
            info["label"] = label;
            info["title"] = title;
            DataEvent de = new DataEvent(EventType.Command, "LineEntryDialog", info);
            EventManager.DispatchEvent(null, de);
            if (!de.Handled)
            {
                return;
            }
            
            suggestion = (string)info["suggestion"];

            int position = Sci.CurrentPos;
            MemberModel latest = null;

            int wordPosEnd = Sci.WordEndPosition(position, true);
            int wordPosStart = Sci.WordStartPosition(position, true);
            char cr = (char)Sci.CharAt(wordPosEnd);
            if (cr == '.')
            {
                wordPosEnd = Sci.WordEndPosition(wordPosEnd + 1, true);
            }
            else
            {
                cr = (char)Sci.CharAt(wordPosStart - 1);
                if (cr == '.')
                {
                    wordPosStart = Sci.WordStartPosition(wordPosStart - 1, true);
                }
            }
            Sci.SetSel(wordPosStart, wordPosEnd);
            string word = Sci.SelText;
            Sci.ReplaceSel(suggestion);
            
            if (member == null)
            {
                detach = false;
                lookupPosition = -1;
                position = Sci.WordStartPosition(Sci.CurrentPos, true);
                Sci.SetSel(position, Sci.WordEndPosition(position, true));
            }
            else
            {
                latest = FindLatest(FlagType.Constant, GetDefaultVisibility(), inClass)
                    ?? FindLatest(FlagType.Variable, GetDefaultVisibility(), inClass);
                if (latest != null)
                {
                    position = FindNewVarPosition(Sci, inClass, latest);
                }
                else
                {
                    position = GetBodyStart(inClass.LineFrom, inClass.LineTo, Sci);
                    detach = false;
                }
                if (position <= 0) return;
                Sci.SetSel(position, position);
            }

            contextToken = suggestion + ":Number = " + word + "";

            GenerateVariable(
                NewMember(contextToken, member, FlagType.Variable | FlagType.Constant | FlagType.Static),
                        position, detach);
        }

        private static void ChangeMethodDecl(ScintillaNet.ScintillaControl Sci, MemberModel member, ClassModel inClass)
        {
            int wordPos = Sci.WordEndPosition(Sci.CurrentPos, true);
            List<FunctionParameter> functionParameters = ParseFunctionParameters(Sci, wordPos);

            ASResult funcResult = ASComplete.GetExpressionType(Sci, Sci.WordEndPosition(Sci.CurrentPos, true));
            if (funcResult.Member == null)
            {
                return;
            }
            if (funcResult != null && funcResult.inClass != null && !funcResult.inClass.Equals(inClass))
            {
                AddLookupPosition();
                lookupPosition = -1;

                DockContent dc = ASContext.MainForm.OpenEditableDocument(funcResult.inClass.InFile.FileName, true);
                Sci = ASContext.CurSciControl;

                FileModel fileModel = new FileModel();
                ASFileParser parser = new ASFileParser();
                parser.ParseSrc(fileModel, Sci.Text);

                foreach (ClassModel cm in fileModel.Classes)
                {
                    if (cm.QualifiedName.Equals(funcResult.inClass.QualifiedName))
                    {
                        funcResult.inClass = cm;
                        break;
                    }
                }
                inClass = funcResult.inClass;
            }

            MemberList members = inClass.Members;
            foreach (MemberModel m in members)
            {
                if (m.Name == funcResult.Member.Name)
                {
                    funcResult.Member = m;
                }
            }

            bool paramsDiffer = false;
            if (funcResult.Member.Parameters != null)
            {
                // check that parameters have one and the same type
                if (funcResult.Member.Parameters.Count == functionParameters.Count)
                {
                    if (functionParameters.Count > 0)
                    {
                        List<MemberModel> parameters = funcResult.Member.Parameters;
                        for (int i = 0; i < parameters.Count; i++)
                        {
                            MemberModel p = parameters[i];
                            if (p.Type != functionParameters[i].paramType)
                            {
                                paramsDiffer = true;
                                break;
                            }
                        }
                    }
                }
                else
                {
                    paramsDiffer = true;
                }
            }
                // check that parameters count differs
            else if (functionParameters.Count != 0)
            {
                paramsDiffer = true;
            }

            if (paramsDiffer)
            {
                int app = 0;
                List<MemberModel> newParameters = new List<MemberModel>();
                List<MemberModel> existingParameters = funcResult.Member.Parameters;
                for (int i = 0; i < functionParameters.Count; i++)
                {
                    FunctionParameter p = functionParameters[i];
                    if (existingParameters != null
                        && existingParameters.Count > (i - app)
                        && existingParameters[i - app].Type == p.paramType)
                    {
                        newParameters.Add(existingParameters[i - app]);
                    }
                    else
                    {
                        if (existingParameters != null && existingParameters.Count < functionParameters.Count)
                        {
                            app++;
                        }
                        newParameters.Add(new MemberModel(p.param, p.paramType, FlagType.ParameterVar, 0));
                    }
                }
                funcResult.Member.Parameters = newParameters;

                int posStart = Sci.PositionFromLine(funcResult.Member.LineFrom);
                int posEnd = Sci.LineEndPosition(funcResult.Member.LineTo);
                Sci.SetSel(posStart, posEnd);
                string selectedText = Sci.SelText;
                Regex rStart = new Regex(String.Format(@"\s+{0}\s*\(([^\)]*)\)(\s*:\s*([^({{|\n|\r|\s|;)]+))?", funcResult.Member.Name));
                Match mStart = rStart.Match(selectedText);
                if (!mStart.Success)
                {
                    return;
                }

                int start = mStart.Index + posStart;
                int end = start + mStart.Length;

                Sci.SetSel(start, end);

                string decl = funcResult.Member.ToDeclarationString();
                Sci.ReplaceSel(" " + decl);

                // add imports to function argument types
                if (functionParameters.Count > 0)
                {
                    List<string> l = new List<string>();
                    foreach (FunctionParameter fp in functionParameters)
                    {
                        try
                        {
                            l.Add(fp.paramQualType);
                        }
                        catch (Exception)
                        {
                        }
                    }
                    start += AddImportsByName(l, Sci.LineFromPosition(end));
                }

                Sci.SetSel(start, start);
            }
        }

        private static void AddAsParameter(ClassModel inClass, ScintillaNet.ScintillaControl Sci, MemberModel member, bool detach)
        {
            if (!RemoveLocalDeclaration(Sci, contextMember)) return;

            StringBuilder sb = new StringBuilder();

            int position = Sci.PositionFromLine(member.LineFrom);
            Sci.SetSel(position, Sci.LineEndPosition(member.LineTo));

            string body = Sci.SelText;
            int bracePos = body.IndexOf(')') + position;
            
            if (member.Parameters != null && member.Parameters.Count > 0)
            {
                sb.Append(", ");
            }

            sb.Append(contextMember.Name);

            if (contextMember.Type != null)
            {
                sb.Append(":")
                    .Append(contextMember.Type);
            }

            Sci.SetSel(bracePos, bracePos);
            Sci.CurrentPos = bracePos;
            InsertCode(bracePos, sb.ToString());

            Sci.SetSel(lookupPosition, lookupPosition);
        }

        private static void AddInterfaceDefJob(ClassModel inClass, ScintillaNet.ScintillaControl Sci, MemberModel member)
        {
            ClassModel aType = ASContext.Context.ResolveType(contextParam, ASContext.Context.CurrentModel);
            if (aType.IsVoid()) return;

            FileModel fileModel = ASFileParser.ParseFile(aType.InFile.FileName, ASContext.Context);
            foreach (ClassModel cm in fileModel.Classes)
            {
                if (cm.QualifiedName.Equals(aType.QualifiedName))
                {
                    aType = cm;
                    break;
                }
            }

            StringBuilder snippet = new StringBuilder();


            DockContent dc = ASContext.MainForm.OpenEditableDocument(aType.InFile.FileName, true);
            Sci = ASContext.CurSciControl;

            MemberModel latest = FindLatest(FlagType.Function, aType);
            int position;
            if (latest == null)
            {
                position = GetBodyStart(aType.LineFrom, aType.LineTo, Sci);
            }
            else
            {
                position = Sci.PositionFromLine(latest.LineTo + 1) - ((Sci.EOLMode == 0) ? 1 : 0);
                snippet.Append(NewLine);
            }
            Sci.SetSel(position, position);
            Sci.CurrentPos = position;

            List<MemberModel> parms = member.Parameters;
            snippet.Append("function ")
                .Append(member.ToDeclarationString())
                .Append(";");

            List<string> importsList = new List<string>();
            string t;
            if (parms != null && parms.Count > 0)
            {
                for (int i = 0; i < parms.Count; i++)
                {
                    if (parms[i].Type != null)
                    {
                        t = getQualifiedType(parms[i].Type, inClass); 
                        importsList.Add(t);
                    }
                }
            }

            if (member.Type != null)
            {
                t = getQualifiedType(member.Type, inClass);
                importsList.Add(t);
            }

            if (importsList.Count > 0)
            {
                int o = AddImportsByName(importsList, Sci.LineFromPosition(position));
                position += o;
                Sci.SetSel(position, position);
            }

            InsertCode(position, snippet.ToString());

            Sci.CurrentPos = position;
        }

        private static void GenerateFieldFromParameter(ScintillaNet.ScintillaControl Sci, MemberModel member, ClassModel inClass)
        {
            int funcBodyStart = GetBodyStart(member.LineFrom, member.LineTo, Sci);

            Sci.SetSel(funcBodyStart, Sci.LineEndPosition(member.LineTo));
            string body = Sci.SelText;
            string trimmed = body.TrimStart();

            Regex re = new Regex("^super\\s*[\\(|\\.]");
            Match m = re.Match(trimmed);
            if (m.Success)
            {
                if (m.Index == 0)
                {
                    int p = funcBodyStart + (body.Length - trimmed.Length);
                    int l = Sci.LineFromPosition(p);
                    p = Sci.PositionFromLine(l + 1);
                    funcBodyStart = GetBodyStart(member.LineFrom, member.LineTo, Sci, p);
                }
            }

            Sci.SetSel(funcBodyStart, funcBodyStart);
            Sci.CurrentPos = funcBodyStart;

            bool isVararg = false;
            string paramName = contextMember.Name;
            if (paramName.StartsWith("..."))
            {
                paramName = paramName.TrimStart(new char[] { ' ', '.' });
                isVararg = true;
            }
            string varName = paramName;

            if (ASContext.CommonSettings.PrefixFields.Length > 0 && !paramName.StartsWith(ASContext.CommonSettings.PrefixFields))
            {
                varName = ASContext.CommonSettings.PrefixFields + varName;
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("this.")
                .Append(varName)
                .Append(" = ")
                .Append(paramName)
                .Append(";")
                .Append(NewLine)
                .Append("$(Boundary)");

            SnippetHelper.InsertSnippetText(Sci, funcBodyStart, sb.ToString());


            MemberList classMembers = inClass.Members;
            foreach (MemberModel classMember in classMembers)
            {
                if (classMember.Name.Equals(varName))
                {
                    return;
                }
            }

            MemberModel latest = FindLatest(FlagType.Variable | FlagType.Constant, GetDefaultVisibility(), inClass);
            if (latest == null) return;

            int position = FindNewVarPosition(Sci, inClass, latest);
            if (position <= 0) return;
            Sci.SetSel(position, position);
            Sci.CurrentPos = position;

            MemberModel mem = NewMember(varName, member, FlagType.Variable, GetDefaultVisibility());
            if (isVararg)
            {
                mem.Type = "Array";
            }
            else
            {
                mem.Type = contextMember.Type;
            }

            GenerateVariable(mem, position, true);
            ASContext.Panel.RestoreLastLookupPosition();
        }

        public static int GetBodyStart(int lineFrom, int lineTo, ScintillaNet.ScintillaControl Sci)
        {
            return GetBodyStart(lineFrom, lineTo, Sci, -1);
        }

        public static int GetBodyStart(int lineFrom, int lineTo, ScintillaNet.ScintillaControl Sci, int pos)
        {
            int posStart = Sci.PositionFromLine(lineFrom);
            int posEnd = Sci.LineEndPosition(lineTo);

            Sci.SetSel(posStart, posEnd);

            List<char> characterClass = new List<char>(new char[] { ' ', '\r', '\n', '\t' });
            string currentMethodBody = Sci.SelText;
            int nCount = 0;
            int funcBodyStart = pos;
            int extraLine = 0;
            if (pos == -1)
            {
                funcBodyStart = posStart + currentMethodBody.IndexOf('{');
                extraLine = 1;
            }
            while (funcBodyStart <= posEnd)
            {
                char c = (char)Sci.CharAt(++funcBodyStart);
                if (c == '}')
                {
                    int ln = Sci.LineFromPosition(funcBodyStart);
                    int indent = Sci.GetLineIndentation(ln);
                    if (lineFrom == lineTo || lineFrom == ln)
                    {
                        Sci.InsertText(funcBodyStart, Sci.NewLineMarker);
                        Sci.SetLineIndentation(ln + 1, indent);
                        ln++;
                    }
                    Sci.SetLineIndentation(ln, indent + Sci.Indent);
                    Sci.InsertText(funcBodyStart, Sci.NewLineMarker);
                    Sci.SetLineIndentation(ln + 1, indent);
                    Sci.SetLineIndentation(ln, indent + Sci.Indent);
                    funcBodyStart = Sci.LineEndPosition(ln);
                    break;
                }
                else if (!characterClass.Contains(c))
                {
                    break;
                }
                else if (Sci.EOLMode == 1 && c == '\r' && (++nCount) > extraLine)
                {
                    break;
                }
                else if (c == '\n' && (++nCount) > extraLine)
                {
                    if (Sci.EOLMode != 2)
                    {
                        funcBodyStart--;
                    }
                    break;
                }
            }
            return funcBodyStart;
        }

        private static void GenerateToString(ClassModel inClass, ScintillaNet.ScintillaControl Sci, MemberModel member)
        {
            bool isOverride = false;
            inClass.ResolveExtends();
            if (inClass.Extends != null)
            {
                ClassModel aType = inClass.Extends;
                while (!aType.IsVoid() && aType.QualifiedName != "Object")
                {
                    foreach (MemberModel method in aType.Members)
                    {
                        if (method.Name == "toString")
                        {
                            isOverride = true;
                            break;
                        }
                    }
                    if (isOverride)
                    {
                        break;
                    }
                    // interface inheritance
                    aType = aType.Extends;
                }
            }
            MemberList members = inClass.Members;
            StringBuilder membersString = new StringBuilder();
            StringBuilder oneMembersString;
            int len = 0;
            int indent = Sci.GetLineIndentation(Sci.LineFromPosition(Sci.CurrentPos));
            foreach (MemberModel m in members)
            {
                if (((m.Flags & FlagType.Variable) > 0 || (m.Flags & FlagType.Getter) > 0)
                    && (m.Access & Visibility.Public) > 0
                    && (m.Flags & FlagType.Constant) == 0)
                {
                    oneMembersString = new StringBuilder();
                    oneMembersString.Append(" ").Append(m.Name).Append("=\" + ").Append(m.Name).Append(" + ");
                    membersString.Append(oneMembersString);
                    len += oneMembersString.Length;
                    if (len > 80)
                    {
                        len = 0;
                        membersString.Append("\n\t\t\t\t");
                    }
                    membersString.Append("\"");
                }
            }
            member = new MemberModel("toString", "String", FlagType.Function, Visibility.Public);
            string repl = GetDeclaration(member, true).Replace("()", "($(EntryPoint))");
            if (isOverride)
            {
                repl = "override " + repl;
            }
            string tmpl = GetTemplate("ToString", "{0} $(CSLB){{\n\treturn {1};\n}}");
            string toStringData = "\"[" + inClass.Name + membersString.ToString() + "]\"";
            string decl = String.Format(tmpl, repl, toStringData);
            InsertCode(Sci.CurrentPos, decl);
        }

        private static void GenerateVariableJob(GeneratorJobType job, ScintillaNet.ScintillaControl Sci, MemberModel member,
            bool detach, ClassModel inClass)
        {
            int position = 0;
            MemberModel latest = null;
            bool isOtherClass = false;

            Visibility varVisi = job.Equals(GeneratorJobType.Variable) ? GetDefaultVisibility() : Visibility.Public;
            FlagType ft = job.Equals(GeneratorJobType.Constant) ? FlagType.Constant : FlagType.Variable;

            // evaluate, if the variable (or constant) should be generated in other class
            ASResult varResult = ASComplete.GetExpressionType(Sci, Sci.WordEndPosition(Sci.CurrentPos, true));

            int contextOwnerPos = GetContextOwnerEndPos(Sci, Sci.WordStartPosition(Sci.CurrentPos, true));
            MemberModel isStatic = new MemberModel();
            if (contextOwnerPos != -1)
            {
                ASResult contextOwnerResult = ASComplete.GetExpressionType(Sci, contextOwnerPos);
                if (contextOwnerResult != null)
                {
                    if (contextOwnerResult.Member == null && contextOwnerResult.Type != null)
                    {
                        isStatic.Flags |= FlagType.Static;
                    }
                }
            }
            else if (member != null && (member.Flags & FlagType.Static) > 0)
            {
                isStatic.Flags |= FlagType.Static;
            }

            ASResult returnType = null;
            int lineNum = Sci.LineFromPosition(Sci.CurrentPos);
            string line = Sci.GetLine(lineNum);
            Match m = Regex.Match(line, @"=\s*[^;\s\n\r}}]+");
            if (m.Success)
            {
                int posLineStart = Sci.PositionFromLine(lineNum);
                if (posLineStart + m.Index >= Sci.CurrentPos)
                {
                    line = line.Substring(m.Index);
                    StatementReturnType rType = GetStatementReturnType(Sci, inClass, line, posLineStart + m.Index);
                    if (rType != null)
                    {
                        returnType = rType.resolve;
                    }
                }
            }

            if (varResult != null && varResult.relClass != null && !varResult.relClass.Equals(inClass))
            {
                AddLookupPosition();
                lookupPosition = -1;

                ASContext.MainForm.OpenEditableDocument(varResult.relClass.InFile.FileName, false);
                Sci = ASContext.CurSciControl;
                isOtherClass = true;

                FileModel fileModel = new FileModel();
                ASFileParser parser = new ASFileParser();
                parser.ParseSrc(fileModel, Sci.Text);

                foreach (ClassModel cm in fileModel.Classes)
                {
                    if (cm.QualifiedName.Equals(varResult.relClass.QualifiedName))
                    {
                        varResult.relClass = cm;
                        break;
                    }
                }
                inClass = varResult.relClass;

                ASContext.Context.UpdateContext(inClass.LineFrom);
            }
            
            // if we generate variable in current class..
            if (!isOtherClass && member == null)
            {
                detach = false;
                lookupPosition = -1;
                position = Sci.WordStartPosition(Sci.CurrentPos, true);
                Sci.SetSel(position, Sci.WordEndPosition(position, true));
            }
            else // if we generate variable in another class
            {
                if (job.Equals(GeneratorJobType.Constant))
                {
                    latest = FindLatest(FlagType.Constant, varVisi, inClass)
                        ?? FindLatest(FlagType.Variable, varVisi, inClass);
                }
                else
                {
                    latest = FindLatest(FlagType.Variable | FlagType.Constant, varVisi, inClass);
                }
                if (latest != null)
                {
                    position = FindNewVarPosition(Sci, inClass, latest);
                }
                else
                {
                    position = GetBodyStart(inClass.LineFrom, inClass.LineTo, Sci);
                    detach = false;
                }
                if (position <= 0) return;
                Sci.SetSel(position, position);
            }

            // if this is a constant, we assign a value to constant
            int selectConstantStart = -1;
            if (job.Equals(GeneratorJobType.Constant))
            {
                string constDef = ":String = \"" + Camelize(contextToken) + "\"";
                contextToken += constDef;
                selectConstantStart = constDef.Length - 1;
                isStatic.Flags |= FlagType.Static;
            }
            else if (returnType != null)
            {
                ClassModel inClassForImport = null;
                if (returnType.inClass != null)
                {
                    inClassForImport = returnType.inClass;
                }
                else if (returnType.relClass != null)
                {
                    inClassForImport = returnType.relClass;
                }
                else
                {
                    inClassForImport = inClass;
                }
                List<String> imports = new List<string>();
                if (returnType.Member != null)
                {
                    if (!"void".Equals(returnType.Member.Type, StringComparison.InvariantCultureIgnoreCase))
                    {
                        contextToken += ":" + FormatType(GetShortType(returnType.Member.Type));
                        imports.Add(getQualifiedType(returnType.Member.Type, inClassForImport));
                    }
                }
                else if (returnType != null && returnType.Type != null)
                {
                    contextToken += ":" + FormatType(GetShortType(returnType.Type.QualifiedName));
                    imports.Add(getQualifiedType(returnType.Type.QualifiedName, inClassForImport));
                }
                if (imports.Count > 0)
                {
                    position += AddImportsByName(imports, Sci.LineFromPosition(position));
                    Sci.SetSel(position, position);
                }
            }

            GenerateVariable(
                NewMember(contextToken, isStatic, ft, varVisi),
                        position, detach);

            if (selectConstantStart != -1)
            {
                Sci.CurrentPos = Sci.CurrentPos - selectConstantStart;
                Sci.SetSel(Sci.CurrentPos, Sci.CurrentPos + selectConstantStart);
            }
        }

        private static int GetContextOwnerEndPos(ScintillaNet.ScintillaControl Sci, int worsStartPos)
        {
            int pos = worsStartPos - 1;
            bool dotFound = false;
            while (pos > 0)
            {
                char c = (char) Sci.CharAt(pos);
                if (c == '.' && !dotFound)
                {
                    dotFound = true;
                }
                else if (c == '\t' || c == '\n' || c == '\r' || c == ' ')
                {

                }
                else
                {
                    if (dotFound)
                    {
                        return pos + 1;
                    }
                    else
                    {
                        return -1;
                    }
                }
                pos--;
            }
            return pos;
        }

        static public string Camelize(string name)
        {
            string[] parts = name.ToLower().Split('_');
            string result = "";
            foreach (string part in parts)
            {
                if (result.Length > 0)
                    result += Char.ToUpper(part[0]) + part.Substring(1);
                else result = part;
            }
            return result;
        }

        private static List<FunctionParameter> ParseFunctionParameters(ScintillaNet.ScintillaControl Sci, int p)
        {
            List<FunctionParameter> prms = new List<FunctionParameter>();
            StringBuilder sb = new StringBuilder();
            List<ASResult> types = new List<ASResult>();
            bool isFuncStarted = false;
            bool isDoubleQuote = false;
            bool isSingleQuote = false;
            bool wasEscapeChar = false;
            bool doBreak = false;
            bool writeParam = false;
            int subClosuresCount = 0;
            ASResult result = null;
            IASContext ctx = ASContext.Context;
            char[] charsToTrim = new char[] { ' ', '\t', '\r', '\n' };
            int counter = Sci.TextLength; // max number of chars in parameters line (to avoid infinitive loop)
            string characterClass = ScintillaNet.ScintillaControl.Configuration.GetLanguage(Sci.ConfigurationLanguage).characterclass.Characters;
            int lastMemberPos = p;

            // add [] and <>
            while (p < counter && !doBreak)
            {
                char c = (char)Sci.CharAt(p++);
                if (c == '(' && !isFuncStarted)
                {
                    if (sb.ToString().Trim(charsToTrim).Length == 0)
                    {
                        isFuncStarted = true;
                    }
                    else
                    {
                        break;
                    }
                }
                else if (c == ';' && !isFuncStarted)
                {
                    break;
                }
                else if (c == ')' && isFuncStarted && !wasEscapeChar && !isDoubleQuote && !isSingleQuote && subClosuresCount == 0)
                {
                    isFuncStarted = false;
                    writeParam = true;
                    doBreak = true;
                }
                else if ((c == '(' || c == '[' || c == '<' || c == '{') && !wasEscapeChar && !isDoubleQuote && !isSingleQuote)
                {
                    if (subClosuresCount == 0)
                    {
                        if (c == '[')
                        {
                            result = new ASResult();
                            result.Type = ctx.ResolveType("Array", null);
                            types.Insert(0, result);
                        }
                        else if (c == '{')
                        {
                            if (sb.ToString().TrimStart().Length > 0)
                            {
                                result = new ASResult();
                                result.Type = ctx.ResolveType("Function", null);
                                types.Insert(0, result);
                            }
                            else
                            {
                                result = new ASResult();
                                result.Type = ctx.ResolveType("Object", null);
                                types.Insert(0, result);
                            }
                        }
                        else if (c == '(')
                        {
                            result = ASComplete.GetExpressionType(Sci, lastMemberPos + 1);
                            if (!result.IsNull())
                            {
                                types.Insert(0, result);
                            }
                        }
                        else if (c == '<')
                        {
                            if (sb.ToString().TrimStart().Length == 0)
                            {
                                result = new ASResult();
                                result.Type = ctx.ResolveType("XML", null);
                                types.Insert(0, result);
                            }
                        }
                    }
                    subClosuresCount++;
                    sb.Append(c);
                    wasEscapeChar = false;
                }
                else if ((c == ')' || c == ']' || c == '>' || c == '}') && !wasEscapeChar && !isDoubleQuote && !isSingleQuote)
                {
                    subClosuresCount--;
                    sb.Append(c);
                    wasEscapeChar = false;
                }
                else if (c == '\\')
                {
                    wasEscapeChar = !wasEscapeChar;
                    sb.Append(c);
                }
                else if (c == '"' && !wasEscapeChar && !isSingleQuote)
                {
                    isDoubleQuote = !isDoubleQuote;
                    if (subClosuresCount == 0)
                    {
                        if (isDoubleQuote)
                        {
                            result = new ASResult();
                            result.Type = ctx.ResolveType("String", null);
                            types.Add(result);
                        }
                    }
                    sb.Append(c);
                    wasEscapeChar = false;
                }
                else if (c == '\'' && !wasEscapeChar && !isDoubleQuote)
                {
                    isSingleQuote = !isSingleQuote;
                    if (subClosuresCount == 0)
                    {
                        if (isSingleQuote)
                        {
                            result = new ASResult();
                            result.Type = ctx.ResolveType("String", null);
                            types.Add(result);
                        }
                    }
                    sb.Append(c);
                    wasEscapeChar = false;
                }
                else if (c == ',' && subClosuresCount == 0)
                {
                    if (!isSingleQuote && !isDoubleQuote && subClosuresCount == 0)
                    {
                        writeParam = true;
                    }
                    else
                    {
                        sb.Append(c);
                    }
                    wasEscapeChar = false;
                }
                else if (isFuncStarted)
                {
                    sb.Append(c);
                    if (!isSingleQuote && !isDoubleQuote && subClosuresCount == 0 && characterClass.IndexOf(c) > -1)
                    {
                        lastMemberPos = p - 1;
                    }
                    wasEscapeChar = false;
                }
                else if (characterClass.IndexOf(c) > -1)
                {
                    doBreak = true;
                }

                if (writeParam)
                {
                    writeParam = false;
                    string trimmed = sb.ToString().Trim(charsToTrim);
                    if (trimmed.Length > 0)
                    {
                        result = ASComplete.GetExpressionType(Sci, lastMemberPos + 1);
                        if (result != null && !result.IsNull())
                        {
                            if (characterClass.IndexOf(trimmed[trimmed.Length - 1]) > -1)
                            {
                                types.Insert(0, result);
                            }
                            else
                            {
                                types.Add(result);
                            }
                        }
                        else
                        {
                            double d = double.MaxValue;
                            try
                            {
                                d = double.Parse(trimmed, System.Globalization.CultureInfo.InvariantCulture);
                            }
                            catch (Exception)
                            {
                            }
                            if (d != double.MaxValue && d.ToString().Length == trimmed.Length)
                            {
                                result = new ASResult();
                                result.Type = ctx.ResolveType("Number", null);
                                types.Insert(0, result);
                            }
                            else if (trimmed.Equals("true") || trimmed.Equals("false"))
                            {
                                result = new ASResult();
                                result.Type = ctx.ResolveType("Boolean", null);
                                types.Insert(0, result);
                            }
                        }

                        if (types.Count == 0)
                        {
                            result = new ASResult();
                            result.Type = ctx.ResolveType("Object", null);
                            types.Add(result);
                        }

                        result = types[0];
                        string paramName = null;
                        string paramType = null;
                        string paramQualType = null;

                        paramName = "arg" + (prms.Count + 1);
                        if (result.Member == null)
                        {
                            paramType = result.Type.Name;
                            paramQualType = result.Type.QualifiedName;
                        }
                        else
                        {
                            if (result.Member.Name != null)
                            {
                                paramName = result.Member.Name;
                            }
                            if (result.Member.Type == null || "void".Equals(result.Member.Type, StringComparison.InvariantCultureIgnoreCase))
                            {
                                paramType = result.Type.Name;
                                paramQualType = result.Type.QualifiedName;
                            }
                            else
                            {
                                paramType = FormatType(GetShortType(result.Member.Type));
                                if (result.inClass == null)
                                {
                                    paramQualType = result.Type.QualifiedName;
                                }
                                else
                                {
                                    paramQualType = getQualifiedType(result.Member.Type, result.inClass);
                                }
                            }
                        }

                        prms.Add(new FunctionParameter(paramName, paramType, paramQualType, result));
                    }
                    types = new List<ASResult>();
                    sb = new StringBuilder();
                }
            }
            for (int i = 0; i < prms.Count; i++)
            {
                ASResult rslt = prms[i].result;
                string name = prms[i].param;
                string type = prms[i].paramType;
                prms[i].param = GuessVarName(name, FormatType(GetShortType(type)));
            }
            return prms;
        }

        private static void GenerateFunctionJob(GeneratorJobType job, ScintillaNet.ScintillaControl Sci, MemberModel member,
            bool detach, ClassModel inClass)
        {
            int position = 0;
            MemberModel latest = null;
            bool isOtherClass = false;

            Visibility funcVisi = job.Equals(GeneratorJobType.FunctionPublic) ? Visibility.Public : GetDefaultVisibility();
            int wordPos = Sci.WordEndPosition(Sci.CurrentPos, true);
            List<FunctionParameter> functionParameters = ParseFunctionParameters(Sci, wordPos);

            // evaluate, if the function should be generated in other class
            ASResult funcResult = ASComplete.GetExpressionType(Sci, Sci.WordEndPosition(Sci.CurrentPos, true));

            int contextOwnerPos = GetContextOwnerEndPos(Sci, Sci.WordStartPosition(Sci.CurrentPos, true));
            MemberModel isStatic = new MemberModel();
            if (contextOwnerPos != -1)
            {
                ASResult contextOwnerResult = ASComplete.GetExpressionType(Sci, contextOwnerPos);
                if (contextOwnerResult != null)
                {
                    if (contextOwnerResult.Member == null && contextOwnerResult.Type != null)
                    {
                        isStatic.Flags |= FlagType.Static;
                    }
                }
            }
            else if (member != null && (member.Flags & FlagType.Static) > 0)
            {
                isStatic.Flags |= FlagType.Static;
            }


            if (funcResult != null && funcResult.relClass != null && !funcResult.relClass.Equals(inClass))
            {
                AddLookupPosition();
                lookupPosition = -1;

                DockContent dc = ASContext.MainForm.OpenEditableDocument(funcResult.relClass.InFile.FileName, true);
                Sci = ASContext.CurSciControl;
                isOtherClass = true;

                FileModel fileModel = new FileModel();
                ASFileParser parser = new ASFileParser();
                parser.ParseSrc(fileModel, Sci.Text);

                foreach (ClassModel cm in fileModel.Classes)
                {
                    if (cm.QualifiedName.Equals(funcResult.relClass.QualifiedName))
                    {
                        funcResult.relClass = cm;
                        break;
                    }
                }
                latest = FindLatest(FlagType.Function, funcVisi, funcResult.relClass);
                inClass = funcResult.relClass;

                ASContext.Context.UpdateContext(inClass.LineFrom);
            }


            // if we generate function in current class..
            if (!isOtherClass)
            {
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
            }
            else // if we generate function in another class..
            {
                if (latest != null)
                {
                    position = Sci.PositionFromLine(latest.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);
                }
                else
                {
                    position = GetBodyStart(inClass.LineFrom, inClass.LineTo, Sci);
                    detach = false;
                }
                Sci.SetSel(position, position);
            }


            // add imports to function argument types
            if (functionParameters.Count > 0)
            {
                List<string> l = new List<string>();
                foreach (FunctionParameter fp in functionParameters)
                {
                    try
                    {
                        l.Add(fp.paramQualType);
                    }
                    catch (Exception)
                    {
                    }
                }
                int o = AddImportsByName(l, Sci.LineFromPosition(position));
                position += o;
                if (latest == null)
                {
                    Sci.SetSel(position, Sci.WordEndPosition(position, true));
                }
                else
                {
                    Sci.SetSel(position, position);
                }
            }


            
            MemberModel m = new MemberModel();
            m.Parameters = new List<MemberModel>();
            for (int i = 0; i < functionParameters.Count; i++)
            {
                string name = functionParameters[i].param;
                string type = functionParameters[i].paramType;
                m.Parameters.Add(new MemberModel(name, type, FlagType.ParameterVar, 0));
            }
            string par = m.ParametersString(true);

            GenerateFunction(
                NewMember(contextToken, isStatic, FlagType.Function,
                        funcVisi),
                position, detach, par, inClass);
        }

        private static void GenerateClass(ScintillaNet.ScintillaControl Sci, String className, ClassModel inClass)
        {
            AddLookupPosition(); // remember last cursor position for Shift+F4

            List<FunctionParameter> parameters = ParseFunctionParameters(Sci, Sci.WordEndPosition(Sci.CurrentPos, true));
            List<MemberModel> constructorArgs = new List<MemberModel>();
            List<String> constructorArgTypes = new List<String>();
            MemberModel paramMember = new MemberModel();
            for (int i = 0; i < parameters.Count; i++)
            {
                FunctionParameter p = parameters[i];
                constructorArgs.Add(new MemberModel(p.param, p.paramType, FlagType.ParameterVar, 0));
                constructorArgTypes.Add(CleanType(getQualifiedType(p.paramQualType, inClass)));
            }
            
            paramMember.Parameters = constructorArgs;

            IProject project = PluginBase.CurrentProject;
            if (String.IsNullOrEmpty(className)) className = "Class";
            string projFilesDir = Path.Combine(PathHelper.TemplateDir, "ProjectFiles");
            string projTemplateDir = Path.Combine(projFilesDir, project.GetType().Name);
            string paramsString = paramMember.ParametersString(true);
            Hashtable info = new Hashtable();
            info["className"] = className;
            info["templatePath"] = Path.Combine(projTemplateDir, "Class.as.fdt");
            info["inDirectory"] = Path.GetDirectoryName(inClass.InFile.FileName);
            info["constructorArgs"] = paramsString.Length > 0 ? paramsString : null;
            info["constructorArgTypes"] = constructorArgTypes;
            DataEvent de = new DataEvent(EventType.Command, "ProjectManager.CreateNewFile", info);
            EventManager.DispatchEvent(null, de);
            if (de.Handled) return;
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

        private static StatementReturnType GetStatementReturnType(ScintillaNet.ScintillaControl Sci, ClassModel inClass, string line, int startPos)
        {
            Regex target = new Regex(@"[;\s\n\r]*", RegexOptions.RightToLeft);
            Match m = target.Match(line);
            if (!m.Success)
            {
                return null;
            }
            line = line.Substring(0, m.Index);

            if (line.Length == 0)
            {
                return null;
            }

            line = ReplaceAllStringContents(line);

            ASResult resolve = null;
            int pos = -1; 
            string word = null;
            int stylemask = (1 << Sci.StyleBits) - 1;
            ClassModel type = null;

            if (line[line.Length - 1] == ')')
            {
                pos = -1;
                int lastIndex = 0;
                int bracesBalance = 0;
                while (true)
                {
                    int pos1 = line.IndexOf("(", lastIndex);
                    int pos2 = line.IndexOf(")", lastIndex);
                    if (pos1 != -1 && pos2 != -1)
                    {
                        lastIndex = Math.Min(pos1, pos2);
                    }
                    else if (pos1 != -1 || pos2 != -1)
                    {
                        lastIndex = Math.Max(pos1, pos2);
                    }
                    else
                    {
                        break;
                    }
                    if (lastIndex == pos1)
                    {
                        bracesBalance++;
                        if (bracesBalance == 1)
                        {
                            pos = lastIndex;
                        }
                    }
                    else if (lastIndex == pos2)
                    {
                        bracesBalance--;
                    }
                    lastIndex++;
                }
            }
            else
            {
                pos = line.Length;
            }
            if (pos != -1)
            {
                line = line.Substring(0, pos);
                pos += startPos;
                pos -= line.Length - line.TrimEnd().Length + 1;
                pos = Sci.WordEndPosition(pos, true);
                resolve = ASComplete.GetExpressionType(Sci, pos);
                word = Sci.GetWordFromPosition(pos);
            }
            char c = (char)Sci.CharAt(pos);
            if (word != null && Char.IsDigit(word[0]))
            {
                type = inClass.InFile.Context.ResolveType("Number", inClass.InFile);
            }
            else if (word != null && (word == "true" || word == "false"))
            {
                type = inClass.InFile.Context.ResolveType("Boolean", inClass.InFile);
            }
            else if (!(ASComplete.IsTextStyle(Sci.StyleAt(pos - 1) & stylemask)))
            {
                type = inClass.InFile.Context.ResolveType("String", inClass.InFile);
            }
            else if (c == '}')
            {
                type = inClass.InFile.Context.ResolveType("Object", inClass.InFile);
            }
            else if (c == '>')
            {
                type = inClass.InFile.Context.ResolveType("XML", inClass.InFile);
            }
            else if (c == ']')
            {
                type = inClass.InFile.Context.ResolveType("Array", inClass.InFile);
            }

            if (resolve == null)
            {
                resolve = new ASResult();
            }
            if (resolve.Type == null)
            {
                resolve.Type = type;
            }

            return new StatementReturnType(resolve, pos, word);
        }

        private static string ReplaceAllStringContents(string line)
        {
            string retLine = line;
            Regex re1 = new Regex("'(?:[^'\\\\]|(?:\\\\\\\\)|(?:\\\\\\\\)*\\\\.{1})*'");
            Regex re2 = new Regex("\"(?:[^\"\\\\]|(?:\\\\\\\\)|(?:\\\\\\\\)*\\\\.{1})*\"");
            Match m1 = re1.Match(line);
            Match m2 = re2.Match(line);
            while (m1.Success || m2.Success)
            {
                Match m = null;
                if (m1.Success && m2.Success)
                {
                    if (m1.Index > m2.Index)
                    {
                        m = m2;
                    }
                    else
                    {
                        m = m1;
                    }
                }
                else if (m1.Success)
                {
                    m = m1;
                }
                else
                {
                    m = m2;
                }
                string sub = "";
                string val = m.Value;
                for (int j = 0; j < val.Length - 2; j++)
                {
                    sub += "A";
                }
                line = line.Substring(0, m.Index) + sub + "AA" + line.Substring(m.Index + m.Value.Length);
                retLine = retLine.Substring(0, m.Index + 1) + sub + retLine.Substring(m.Index + m.Value.Length - 1);

                m1 = re1.Match(line);
                m2 = re2.Match(line);
            }
            return retLine;
        }

        private static string GuessVarName(string name, string type)
        {
            if (name == null)
            {
                name = type;
            }

            if (name == null)
            {
                return name;
            }
            // if constant then convert to camelCase
            if (name.ToUpper() == name)
            {
                name = Camelize(name);
            }

            // if getter, then remove 'get' prefix
            name = name.TrimStart(new char[] { '_' });
            if (name.Length > 3 && name.StartsWith("get") && (name[3].ToString() == char.ToUpper(name[3]).ToString()))
            {
                name = char.ToLower(name[3]).ToString() + name.Substring(4);
            }

            if (name.Length > 1)
            {
                name = Char.ToLower(name[0]) + name.Substring(1);
            }
            else
            {
                name = Char.ToLower(name[0]) + "";
            }

            if (name == "this" || type == name)
            {
                if (type != null && type.Length > 0)
                {
                    name = Char.ToLower(type[0]) + type.Substring(1);
                }
                else
                {
                    name = "p_this";
                }
            }
            return name;
        }

        private static void GenerateImplementation(ClassModel aType, int position)
        {
            List<string> typesUsed = new List<string>();

            StringBuilder sb = new StringBuilder(String.Format(GetTemplate("ImplementHeader"), aType.Type));
            string entry = "$(EntryPoint)";
            ASResult result = new ASResult();
            IASContext context = ASContext.Context;
            ClassModel cClass = context.CurrentClass;
            ContextFeatures features = context.Features;
            bool canGenerate = false;
            string template = GetTemplate("ImplementPart");

            aType.ResolveExtends(); // resolve inheritance chain
            while (!aType.IsVoid() && aType.QualifiedName != "Object")
            {
                foreach (MemberModel method in aType.Members)
                {
                    if ((method.Flags & (FlagType.Function | FlagType.Getter | FlagType.Setter)) == 0
                        || method.Name == aType.Name)
                        continue;

                    // check if method exists
                    ASComplete.FindMember(method.Name, cClass, result, method.Flags, 0);
                    if (!result.IsNull()) continue;

                    string decl = String.Format(template, GetDeclaration(method), entry);
                    entry = "";

                    sb.Append(decl);
                    canGenerate = true;

                    addTypeOnce(typesUsed, getQualifiedType(method.Type, aType));

                    if (method.Parameters != null && method.Parameters.Count > 0)
                        foreach (MemberModel param in method.Parameters)
                            addTypeOnce(typesUsed, getQualifiedType(param.Type, aType));
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
                    int offset = AddImportsByName(typesUsed, Sci.LineFromPosition(position));
                    position += offset;
                    Sci.SetSel(position, position);
                }
                InsertCode(position, sb.ToString());
            }
            finally { Sci.EndUndoAction(); }
        }

        private static void addTypeOnce(List<string> typesUsed, string qualifiedName)
        {
            if (!typesUsed.Contains(qualifiedName)) typesUsed.Add(qualifiedName);
        }

        private static string getQualifiedType(string type, ClassModel aType)
        {
            if (type == null || type == "") return "*";
            if (type.IndexOf('<') > 0) // Vector.<Point>
            {
                Match mGeneric = Regex.Match(type, "<([^>]+)>");
                if (mGeneric.Success)
                {
                    return getQualifiedType(mGeneric.Groups[1].Value, aType);
                }
            }

            if (type.IndexOf('.') > 0) return type;

            ClassModel aClass = ASContext.Context.ResolveType(type, aType.InFile);
            if (!aClass.IsVoid())
            {
                if (aClass.InFile.Package.Length != 0)
                    return aClass.QualifiedName;
            }
            return "*";
        }

        private static MemberModel NewMember(string contextToken, MemberModel calledFrom, FlagType kind, Visibility visi)
        {
            string type = (kind == FlagType.Function) ? ASContext.Context.Features.voidKey : null;
            if (calledFrom != null && (calledFrom.Flags & FlagType.Static) > 0)
                kind |= FlagType.Static;
            return new MemberModel(contextToken, type, kind, visi);
        }

        private static MemberModel NewMember(string contextToken, MemberModel calledFrom, FlagType kind)
        {
            return NewMember(contextToken, calledFrom, kind, GetDefaultVisibility());
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

        private static void GenerateFunction(MemberModel member, int position, bool detach, String parameters, ClassModel inClass)
        {
            bool isInterface = ClassIsInterface(inClass);
            bool isConstructor = (member.Flags & FlagType.Constructor) > 0;
            string template = "";
            if (isInterface)
            {
                template = GetTemplate("IFunction", "{0};");
            }
            else if (isConstructor)
            {
                template = GetTemplate("Constructor", "{0} $(CSLB){{\n\tsuper();\n}}");
            }
            else
            {
                template = GetTemplate("Function");
            }
            string repl = GetDeclaration(member, !isInterface).Replace("()", "(" + parameters + "$(EntryPoint))");
            string decl = String.Format(template,
                    repl);

            if (detach) decl = BlankLine + decl;
            InsertCode(position, decl);
        }

        private static bool ClassIsInterface(ClassModel cm)
        {
            return (cm.Flags & FlagType.Interface) > 0;
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
            Match parts = Regex.Match(name, "([^_$]*)[_$]+(.*)");
            if (parts.Success)
            {
                string pre = parts.Groups[1].Value;
                string post = parts.Groups[2].Value;
                return (pre.Length > post.Length) ? pre : post;
            }
            return null;
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

        private static void GenerateDelegateMethod(string name, MemberModel afterMethod, int position)
        {
            string acc = GetPrivateAccessor(afterMethod);
            string decl = BlankLine + String.Format(GetTemplate("Delegate"),
                acc, name, ASContext.Context.Features.voidKey);
            InsertCode(position, decl);
        }

        private static void GenerateEventHandler(string name, string type, MemberModel afterMethod, int position)
        {
            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;
            Sci.BeginUndoAction();
            try
            {
                if (type == "Event")
                {
                    List<string> typesUsed = new List<string>();
                    typesUsed.Add("flash.events.Event");
                    position += AddImportsByName(typesUsed, Sci.LineFromPosition(position));
                    Sci.SetSel(position, position);
                }
                else if (type == "DataEvent")
                {
                    List<string> typesUsed = new List<string>();
                    typesUsed.Add("flash.events.DataEvent");
                    position += AddImportsByName(typesUsed, Sci.LineFromPosition(position));
                    Sci.SetSel(position, position);
                }
                string acc = GetPrivateAccessor(afterMethod);
                string decl = BlankLine + String.Format(GetTemplate("EventHandler"),
                    acc, name, type, ASContext.Context.Features.voidKey);

                string eventName = contextMatch.Groups["event"].Value;
                string autoRemove = AddRemoveEvent(eventName);
                if (autoRemove != null)
                {
                    if (autoRemove.Length > 0) autoRemove += ".";
                    string remove = String.Format("{0}removeEventListener({1}, {2});\n\t$(EntryPoint)", autoRemove, eventName, name);
                    decl = decl.Replace("$(EntryPoint)", remove);
                }
                InsertCode(position, decl);
            }
            finally
            {
                Sci.EndUndoAction();
            }
        }

        static private string AddRemoveEvent(string eventName)
        {
            foreach (string autoRemove in ASContext.CommonSettings.EventListenersAutoRemove)
            {
                string test = autoRemove.Trim();
                if (test.Length == 0 || test.StartsWith("//")) continue;
                int colonPos = test.IndexOf(':');
                if (colonPos >= 0) test = test.Substring(colonPos + 1);
                if (test == eventName)
                {
                    if (colonPos < 0) return "";
                    else return autoRemove.Trim().Substring(0, colonPos);
                }
            }
            return null;
        }

        static private void GenerateGetter(string name, MemberModel member, int position)
        {
            string acc = GetPublicAccessor(member);
            string decl = BlankLine + String.Format(GetTemplate("Getter"),
                acc, name, FormatType(member.Type), member.Name);
            InsertCode(position, decl);
        }

        static private void GenerateSetter(string name, MemberModel member, int position)
        {
            string acc = GetPublicAccessor(member);
            string decl = BlankLine + String.Format(GetTemplate("Setter"),
                acc, name, FormatType(member.Type), member.Name, ASContext.Context.Features.voidKey ?? "void");
            InsertCode(position, decl);
        }

        static private string GetPrivateAccessor(MemberModel member)
        {
            string acc = GetPrivateKeyword();
            if ((member.Flags & FlagType.Static) > 0) acc = (ASContext.Context.Features.staticKey ?? "static") + " " + acc;
            return acc;
        }

        static public string GetPrivateKeyword()
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

        static private MemberModel FindMember(string name, ClassModel inClass)
        {
            MemberList list;
            if (inClass == ClassModel.VoidClass)
                list = ASContext.Context.CurrentModel.Members;
            else list = inClass.Members;

            MemberModel found = null;
            foreach (MemberModel member in list)
            {
                if (member.Name == name)
                {
                    found = member;
                    break;
                }
            }
            return found;
        }

        static private MemberModel FindLatest(FlagType match, ClassModel inClass)
        {
            return FindLatest(match, 0, inClass);
        }

        static private MemberModel FindLatest(FlagType match, Visibility visi, ClassModel inClass)
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
                if ((member.Flags & match) > 0 && (visi == 0 || (member.Access & visi) > 0))
                {
                    latest = member;
                }
            }
            return latest ?? fallback;
        }

        static private string GetDeclaration(MemberModel member)
        {
            return GetDeclaration(member, true);
        }

        static private string GetDeclaration(MemberModel member, bool addModifiers)
        {
            // modifiers
            FlagType ft = member.Flags;
            Visibility acc = member.Access;
            string modifiers = "";
            if ((ft & FlagType.Extern) > 0)
                modifiers += "extern ";
            if ((ft & FlagType.Static) > 0)
                modifiers += "static ";
            if ((acc & Visibility.Private) > 0 && addModifiers)
                modifiers += "private ";
            else if ((acc & Visibility.Public) > 0 && addModifiers)
                modifiers += "public ";
            else if ((acc & Visibility.Protected) > 0 && addModifiers)
                modifiers += "protected ";
            else if ((acc & Visibility.Internal) > 0 && addModifiers)
                modifiers += "internal ";
            // signature
            if ((ft & FlagType.Getter) > 0)
                return String.Format("{0}function get {1}", modifiers, member.ToDeclarationString());
            else if ((ft & FlagType.Setter) > 0)
                return String.Format("{0}function set {1}", modifiers, member.ToDeclarationString());
            else if ((ft & FlagType.Function) > 0)
                return String.Format("{0}function {1}", modifiers, member.ToDeclarationString());
            else if (((ft & FlagType.Constant) > 0) && ASContext.Context.Settings.LanguageId != "AS2")
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

            int line = Sci.LineFromPosition(position);
            string currentText = Sci.GetLine(line);
            int startPos = currentText.Length;
            GetStartPos(currentText, ref startPos, features.privateKey);
            GetStartPos(currentText, ref startPos, features.protectedKey);
            GetStartPos(currentText, ref startPos, features.internalKey);
            GetStartPos(currentText, ref startPos, features.publicKey);
            GetStartPos(currentText, ref startPos, features.staticKey);
            GetStartPos(currentText, ref startPos, features.overrideKey);
            startPos += Sci.PositionFromLine(line);

            FlagType flags = member.Flags;
            string acc = "";
            string decl = "";
            if (features.hasNamespaces && member.Namespace != null
                && member.Namespace.Length > 0 && member.Namespace != "internal")
                acc = member.Namespace;
            else if ((member.Access & Visibility.Public) > 0) acc = features.publicKey;
            else if ((member.Access & Visibility.Internal) > 0) acc = features.internalKey;
            else if ((member.Access & Visibility.Protected) > 0) acc = features.protectedKey;
            else if ((member.Access & Visibility.Private) > 0) acc = features.privateKey;

            bool isStatic = (flags & FlagType.Static) > 0;
            if (isStatic) acc = features.staticKey + " " + acc;

            if (!isAS2Event && !isObjectMethod)
                acc = features.overrideKey + " " + acc;

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
                if (ofClass.Members.Search(name, FlagType.Setter, 0) != null)
                {
                    string tpl = GetTemplate("Setter");
                    if (decl.Length > 0)
                    {
                        decl += "\n\n";
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
                if (!noRet) typesUsed.Add(getQualifiedType(type, ofClass));
                string action = (isProxy || isAS2Event) ? "" : GetSuperCall(member, typesUsed, ofClass);
                decl += member.Name
                    + String.Format(GetTemplate("MethodOverride"), member.ParametersString(true), type, action);
            }

            Sci.BeginUndoAction();
            try
            {
                if (ASContext.Context.Settings.GenerateImports && typesUsed.Count > 0)
                {
                    int offset = AddImportsByName(typesUsed, line);
                    position += offset;
                    startPos += offset;
                }

                Sci.SetSel(startPos, position + member.Name.Length);
                InsertCode(startPos, decl);
            }
            finally { Sci.EndUndoAction(); }
        }

        public static void GenerateDelegateMethods(ScintillaNet.ScintillaControl Sci, MemberModel member,
            Dictionary<MemberModel, ClassModel> selectedMembers, ClassModel classModel, ClassModel inClass)
        {
            Sci.BeginUndoAction();
            try
            {
                StringBuilder sb = new StringBuilder(
                    String.Format(GetTemplate("DelegateMethodsHeader", "$(Boundary)\n\n/* DELEGATE {0} */"), classModel.Type));

                MemberModel latest;
                int position = -1;
                List<MemberModel> methodParams;
                ClassModel type;
                List<string> importsList = new List<string>();

                bool isStaticMember = false;
                if ((member.Flags & FlagType.Static) > 0)
                {
                    isStaticMember = true;
                }

                inClass.ResolveExtends();
                
                Dictionary<MemberModel, ClassModel>.KeyCollection selectedMemberKeys = selectedMembers.Keys;
                foreach (MemberModel m in selectedMemberKeys)
                {
                    sb.Append("$(Boundary)\n\n");

                    bool overrideFound = false;
                    ClassModel aType = inClass;
                    while (aType != null && !aType.IsVoid())
                    {
                        MemberList inClassMembers = aType.Members;
                        foreach (MemberModel inClassMember in inClassMembers)
                        {
                            if ((inClassMember.Flags & FlagType.Function) > 0
                               && m.Name.Equals(inClassMember.Name))
                            {
                                sb.Append("override ");
                                overrideFound = true;
                                break;
                            }
                        }
                        if (overrideFound)
                        {
                            break;
                        }
                        aType = aType.Extends;
                    }
                        
                    
                    if (isStaticMember)
                    {
                        sb.Append("static ");
                    }

                    sb.Append(GetDeclaration(m))
                        .Append(" $(CSLB){\n\t");

                    if (m.Type != null && m.Type.ToLower() != "void")
                    {
                        sb.Append("return ");
                    }


                    methodParams = m.Parameters;

                    // check for varargs
                    bool isVararg = false;
                    if (methodParams != null && methodParams.Count > 0)
                    {
                        MemberModel mm = methodParams[methodParams.Count - 1];
                        if (mm.Name.StartsWith("..."))
                        {
                            isVararg = true;
                        }
                    }
                    if (!isVararg)
                    {
                        sb.Append(member.Name)
                            .Append(".")
                            .Append(m.Name)
                            .Append("(");

                        if (methodParams != null)
                        {
                            for (int i = 0; i < methodParams.Count; i++)
                            {
                                MemberModel param = methodParams[i];
                                sb.Append(param.Name);
                                if (i + 1 < methodParams.Count)
                                {
                                    sb.Append(", ");
                                }
                            }
                        }

                        sb.Append(");");
                    }
                    else 
                    {
                        sb.Append(member.Name)
                            .Append(".")
                            .Append(m.Name)
                            .Append(".apply(null, [");

                        for (int i = 0; i < methodParams.Count; i++)
                        {
                            MemberModel param = methodParams[i];
                            if (i + 1 < methodParams.Count)
                            {
                                sb.Append(param.Name);
                                if (i + 2 < methodParams.Count)
                                {
                                    sb.Append(", ");
                                }
                            }
                            else
                            {
                                sb.Append("].concat(")
                                    .Append(param.Name.Substring(3))
                                    .Append(")");
                            }
                        }

                        sb.Append(");");
                    }

                    sb.Append("\n}");

                    if (methodParams != null)
                    {
                        for (int i = 0; i < methodParams.Count; i++)
                        {
                            MemberModel param = methodParams[i];
                            if (param.Type != null)
                            {
                                type = ASContext.Context.ResolveType(param.Type, selectedMembers[m].InFile);
                                importsList.Add(type.QualifiedName);
                            }
                        }
                    }

                    if (position < 0)
                    {
                        latest = FindLatest(FlagType.Function, inClass);
                        if (latest == null)
                        {
                            position = Sci.WordStartPosition(Sci.CurrentPos, true);
                            Sci.SetSel(position, Sci.WordEndPosition(position, true));
                        }
                        else
                        {
                            position = Sci.PositionFromLine(latest.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);
                            Sci.SetSel(position, position);
                        }
                    }
                    else
                    {
                        position = Sci.CurrentPos;
                    }

                    if (m.Type != null)
                    {
                        type = ASContext.Context.ResolveType(m.Type, selectedMembers[m].InFile);
                        importsList.Add(type.QualifiedName);
                    }
                }

                if (importsList.Count > 0 && position > -1)
                {
                    int o = AddImportsByName(importsList, Sci.LineFromPosition(position));
                    position += o;
                    Sci.SetSel(position, position);
                }

                InsertCode(position, sb.ToString());
            }
            finally { Sci.EndUndoAction(); }
        }

        private static void GetStartPos(string currentText, ref int startPos, string keyword)
        {
            if (keyword == null) return;
            int p = currentText.IndexOf(keyword);
            if (p > 0 && p < startPos) startPos = p;
        }

        private static string GetShortType(string type)
        {
            if (type == null || type.Length == 0)
            {
                return type;
            }
            Regex r = new Regex(@"[^\.]+(\.<.+>)?(@.+|$)");
            Match m = r.Match(type);
            if (m.Success)
            {
                type = m.Value;
            }
            return type;
        }

        private static string FormatType(string type)
        {
            return MemberModel.FormatType(type);
        }

        private static string CleanType(string type)
        {
            if (type == null || type.Length == 0)
            {
                return type;
            }
            int p = type.IndexOf('$');
            if (p > 0) type = type.Substring(0, p);
            p = type.IndexOf('<');
            if (p > 1 && type[p - 1] == '.') p--;
            if (p > 0) type = type.Substring(0, p);
            p = type.IndexOf("@");
            if (p > 0)
            {
                type = type.Substring(0, p);
            }
            return type;
        }

        private static string GetSuperCall(MemberModel member, List<string> typesUsed, ClassModel aType)
        {
            string args = "";
            if (member.Parameters != null)
                foreach (MemberModel param in member.Parameters)
                {
                    if (param.Name.StartsWith(".")) break;
                    args += ", " + param.Name;
                    addTypeOnce(typesUsed, getQualifiedType(param.Type, aType));
                }

            bool noRet = member.Type == null || member.Type.Length == 0 || member.Type.Equals("void", StringComparison.OrdinalIgnoreCase);
            if (!noRet) addTypeOnce(typesUsed, getQualifiedType(member.Type, aType));

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
        private static int AddImportsByName(List<string> typesUsed, int atLine)
        {
            int length = 0;
            IASContext context = ASContext.Context;
            FileModel inFile = context.CurrentModel;
            List<string> addedTypes = new List<string>();
            string cleanType = null;
            foreach (string type in typesUsed)
            {
                cleanType = CleanType(type);
                if (cleanType == null || cleanType.Length == 0 || cleanType.IndexOf('.') <= 0 || addedTypes.Contains(cleanType))
                    continue;
                addedTypes.Add(cleanType);
                MemberModel import = new MemberModel(cleanType.Substring(cleanType.LastIndexOf('.') + 1), cleanType, FlagType.Import, Visibility.Public);
                if (!context.IsImported(import, atLine))
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
            string nl = ASComplete.GetNewLineMarker(sci.EOLMode);
            string statement = "import " + fullPath + ";" + nl;

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
            if (sci.EOLMode == 2) return sci.GetLine(line).Length + nl.Length;
            else return sci.GetLine(line).Length + nl.Length - 1;
        }
        #endregion

        #region common safe code insertion
        static private int lookupPosition;

        public static void InsertCode(int position, string src)
        {
            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;
            Sci.BeginUndoAction();
            try
            {
                if (ASContext.CommonSettings.StartWithModifiers)
                    src = FixModifiersLocation(src);

                int len = SnippetHelper.InsertSnippetText(Sci, position, src);
                UpdateLookupPosition(position, len);
                AddLookupPosition();
            }
            finally { Sci.EndUndoAction(); }
        }

        private static string FixModifiersLocation(string src)
        {
            string[] lines = src.Split('\n');
            for (int i = 0; i < lines.Length; i++)
            {
                string line = lines[i];
                string trimmedLine = line.TrimStart();
                Match m = reModifier.Match(trimmedLine);
                if (m.Success)
                {
                    lines[i] = line.Substring(0, line.Length - trimmedLine.Length) 
                        + m.Groups[1].Value + trimmedLine.Remove(m.Groups[1].Index, m.Groups[1].Length);
                }
            }
            src = String.Join("\n", lines);

            lines = src.Split('\n');
            for (int i = 0; i < lines.Length; i++)
            {
                string line = lines[i];
                string trimmedLine = line.TrimStart();
                Match m = reOverride.Match(trimmedLine);
                if (m.Success)
                {
                    lines[i] = line.Substring(0, line.Length - trimmedLine.Length)
                        + m.Groups[1].Value + trimmedLine.Remove(m.Groups[1].Index, m.Groups[1].Length);
                }
            }

            src = String.Join("\n", lines);
            return src;
        }

        private static void UpdateLookupPosition(int position, int delta)
        {
            if (lookupPosition < 0) return;
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
        private static string GetTemplate(string name, string defaultTemplate)
        {
            CheckTemplates();
            if (templates.ContainsKey(name)) return templates[name];
            else return defaultTemplate;
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
        AddImport = 10,
        Class = 11,
        FunctionPublic = 12,
        VariablePublic = 13,
        Constant = 14,
        Constructor = 15,
        ToString = 16,
        FieldFromPatameter = 17,
        AddInterfaceDef = 18,
        ConvertToConst = 19,
        AddAsParameter = 20,
        ChangeMethodDecl = 21,
        EventMetatag = 22,
        AssignStatementToVar = 23,
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
            get { return TextHelper.GetString("Info.GeneratorTemplate"); }
        }

        public System.Drawing.Bitmap Icon
        {
            get { return (System.Drawing.Bitmap)ASContext.Panel.GetIcon(PluginUI.ICON_DECLARATION); }
        }

        public string Value
        {
            get
            {
                ASGenerator.GenerateJob(job, member, inClass, label);
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

    class FunctionParameter
    {
        public string paramType;
        public string paramQualType;
        public string param;
        public ASResult result;

        public FunctionParameter(string parameter, string paramType, string paramQualType, ASResult result)
        {
            this.param = parameter;
            this.paramType = paramType;
            this.paramQualType = paramQualType;
            this.result = result;
        }
    }

    class StatementReturnType
    {
        public ASResult resolve;
        public Int32 position;
        public String word;

        public StatementReturnType(ASResult resolve, Int32 position, String word)
        {
            this.resolve = resolve;
            this.position = position;
            this.word = word;
        }
    }
    #endregion
}
