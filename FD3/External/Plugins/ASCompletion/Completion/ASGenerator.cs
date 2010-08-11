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
        const string patternClass = @"new\s*{0}";
        const string BlankLine = "$(Boundary)\n\n";
        const string NewLine = "$(Boundary)\n";
        static private Regex reModifier = new Regex("[a-z \t]*(public |private |protected )", RegexOptions.Compiled);

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
                    ShowPromoteLocal(found);
                    return;
                }

                if (resolve.Member == null && resolve.Type == null) // import declaration
                {
                    if (CheckAutoImport(found)) return;
                    else suggestItemDeclaration = true;
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
                        // generate event handlers
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
                    ShowFieldsFromParameters(found);
                    return;
                }

                if ((found.member.Flags & FlagType.Function) > 0 &&
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

                        int ind = Sci.Text.IndexOf(interf, classPosStart);
                        if (ind > 0)
                        {
                            ASResult expr = ASComplete.GetExpressionType(Sci, Sci.WordEndPosition(ind, true));
                            contextParam = expr.Type.Type;
                            MemberList members = expr.Type.Members;
                            foreach (MemberModel m in members)
                            {
                                if (m.Name.Equals(funcName))
                                {
                                    skip = true;
                                    break;
                                }
                            }
                        }
                    }
                    if (!skip && contextParam != null)
                    {
                        ShowAddInterfaceDefList(found);
                        return;
                    }
                }
            }

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
                    known.Add(new GeneratorItem(labelConst, GeneratorJobType.Constant, found.member, inClass));

                    autoSelect = labelConst;
                }

                if (result == null)
                {
                    string labelVar = TextHelper.GetString("ASCompletion.Label.GeneratePrivateVar");
                    known.Add(new GeneratorItem(labelVar, GeneratorJobType.Variable, found.member, inClass));
                }

                string labelVarPublic = TextHelper.GetString("ASCompletion.Label.GeneratePublicVar");
                known.Add(new GeneratorItem(labelVarPublic, GeneratorJobType.VariablePublic, found.member, inClass));

                if (result == null)
                {
                    string labelFun = TextHelper.GetString("ASCompletion.Label.GeneratePrivateFunction");
                    known.Add(new GeneratorItem(labelFun, GeneratorJobType.Function, found.member, inClass));
                }
            }

            string labelFunPublic = TextHelper.GetString("ASCompletion.Label.GenerateFunctionPublic");
            if (isInterface)
            {
                labelFunPublic = TextHelper.GetString("ASCompletion.Label.GenerateFunctionInterface");
                autoSelect = labelFunPublic;
            }
            known.Add(new GeneratorItem(labelFunPublic, GeneratorJobType.FunctionPublic, found.member, inClass));

            if (PluginBase.CurrentProject != null && PluginBase.CurrentProject.Language.StartsWith("as"))
            {
                string labelClass = TextHelper.GetString("ASCompletion.Label.GenerateClass");
                known.Add(new GeneratorItem(labelClass, GeneratorJobType.Class, found.member, found.inClass));
            }
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
                    known.Add(new GeneratorItem(label, GeneratorJobType.Function, found.member, inClass));
                }
            }

            string labelFunPublic = TextHelper.GetString("ASCompletion.Label.GenerateFunctionPublic");
            if (isInterface)
            {
                labelFunPublic = TextHelper.GetString("ASCompletion.Label.GenerateFunctionInterface");
                autoSelect = labelFunPublic;
            }
            known.Add(new GeneratorItem(labelFunPublic, GeneratorJobType.FunctionPublic, found.member, inClass));

            CompletionList.Show(known, false);
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

        private static void ShowFieldsFromParameters(FoundDeclaration found)
        {
            ContextFeatures features = ASContext.Context.Features;
            List<ICompletionListItem> known = new List<ICompletionListItem>();

            ScintillaNet.ScintillaControl Sci = ASContext.CurSciControl;

            if (PluginBase.CurrentProject != null && PluginBase.CurrentProject.Language.StartsWith("as"))
            {
                string labelClass = TextHelper.GetString("ASCompletion.Label.GenerateFieldsFromPatameters");
                known.Add(new GeneratorItem(labelClass, GeneratorJobType.FieldsFromPatameters, found.member, found.inClass));

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
                    GenerateClass(clasName, inClass);
                    break;

                case GeneratorJobType.Constructor:
                    member = new MemberModel(inClass.Name, inClass.QualifiedName, FlagType.Constructor | FlagType.Function, Visibility.Public);
                    GenerateFunction(
                        member,
                        Sci.CurrentPos, false, new List<FunctionParameter>(), inClass);
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

                case GeneratorJobType.FieldsFromPatameters:
                    Sci.BeginUndoAction();
                    try
                    {
                        GenerateFieldsParameters(Sci, member, inClass);
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
            }
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
                position = Sci.PositionFromLine(latest.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);
            }
            Sci.SetSel(position, position);
            Sci.CurrentPos = position;

            List<MemberModel> parms = member.Parameters;
            StringBuilder snippet = new StringBuilder();
            snippet.Append(NewLine)
                .Append("function ")
                .Append(member.ToDeclarationString());

            List<string> importsList = new List<string>();
            ClassModel t;
            if (parms != null && parms.Count > 0)
            {
                for (int i = 0; i < parms.Count; i++)
                {
                    if (parms[i].Type != null)
                    {
                        t = ASContext.Context.ResolveType(parms[i].Type, inClass.InFile);
                        importsList.Add(t.QualifiedName);
                    }
                }
            }

            if (member.Type != null)
            {
                t = ASContext.Context.ResolveType(member.Type, inClass.InFile);
                importsList.Add(t.QualifiedName);
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

        private static void GenerateFieldsParameters(ScintillaNet.ScintillaControl Sci, MemberModel member, ClassModel inClass)
        {
            int funcBodyStart = GetBodyStart(member.LineFrom, member.LineTo, Sci);

            Sci.SetSel(funcBodyStart, funcBodyStart);
            Sci.CurrentPos = funcBodyStart;

            StringBuilder sb = new StringBuilder();
            List<MemberModel> parameters = new List<MemberModel>();
            foreach (MemberModel param in member.Parameters)
            {
                if (param.Name.StartsWith("..."))
                {
                    continue;
                }
                parameters.Add(param);
                sb.Append("this.");
                if (ASContext.CommonSettings.PrefixFields.Length > 0 && !param.Name.StartsWith(ASContext.CommonSettings.PrefixFields))
                {
                    sb.Append(ASContext.CommonSettings.PrefixFields);
                }
                sb.Append(param.Name).Append(" = ").Append(param.Name).Append(";").Append(NewLine).Append("$(Boundary)");
            }

            SnippetHelper.InsertSnippetText(Sci, funcBodyStart, sb.ToString());
            bool varGenerated = false;
            MemberList classMembers = inClass.Members;
            foreach (MemberModel param in parameters)
            {
                string nm = param.Name;
                if (ASContext.CommonSettings.PrefixFields.Length > 0 && !param.Name.StartsWith(ASContext.CommonSettings.PrefixFields))
                {
                    nm = ASContext.CommonSettings.PrefixFields + nm;
                }

                bool nextParam = false;
                foreach (MemberModel classMember in classMembers)
                {
                    if (classMember.Name.Equals(nm))
                    {
                        nextParam = true;
                        break;
                    }
                }

                if (nextParam)
                {
                    continue;
                }

                MemberModel latest = FindLatest(FlagType.Variable | FlagType.Constant, GetDefaultVisibility(), inClass);
                if (latest == null) return;

                int position = FindNewVarPosition(Sci, inClass, latest);
                if (position <= 0) return;
                Sci.SetSel(position, position);
                Sci.CurrentPos = position;

                MemberModel mem = NewMember(nm, member, GeneratorJobType.Variable, FlagType.Variable, GetDefaultVisibility());
                mem.Type = param.Type;

                GenerateVariable(mem, position, true);
                varGenerated = true;

            }

            if (varGenerated)
            {
                ASContext.Panel.RestoreLastLookupPosition();
            }
        }

        public static int GetBodyStart(int lineFrom, int lineTo, ScintillaNet.ScintillaControl Sci)
        {
            int posStart = Sci.PositionFromLine(lineFrom);
            int posEnd = Sci.LineEndPosition(lineTo);

            Sci.SetSel(posStart, posEnd);
            string currentMethodBody = Sci.SelText;
            int funcBodyStart = currentMethodBody.IndexOf('{') + posStart;
            int nCount = 0;
            List<char> characterClass = new List<char>(new char[] { ' ', '\r', '\n', '\t' });
            while (funcBodyStart <= posEnd)
            {
                char c = (char)Sci.CharAt(++funcBodyStart);
                if (!characterClass.Contains(c))
                {
                    break;
                }
                else if (c == '}')
                {
                    break;
                }
                else if (Sci.EOLMode == 1 && c == '\r' && (++nCount) > 1)
                {
                    break;
                }
                else if (c == '\n' && (++nCount) > 1)
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
            MemberList members = inClass.Members;
            StringBuilder membersString = new StringBuilder();
            StringBuilder oneMembersString;
            int len = 0;
            int indent = Sci.GetLineIndentation(Sci.LineFromPosition(Sci.CurrentPos));
            foreach (MemberModel m in members)
            {
                if ((m.Flags & FlagType.Variable) > 0 && (m.Access & Visibility.Public) > 0)
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
            if (varResult != null && varResult.relClass != null)
            {
                FileModel fileModel = ASFileParser.ParseFile(varResult.relClass.InFile.FileName, ASContext.Context);
                foreach (ClassModel cm in fileModel.Classes)
                {
                    if (cm.QualifiedName.Equals(varResult.relClass.QualifiedName))
                    {
                        varResult.relClass = cm;
                        break;
                    }
                }

                ASContext.MainForm.OpenEditableDocument(varResult.relClass.InFile.FileName, false);
                Sci = ASContext.CurSciControl;
                inClass = varResult.relClass;
                isOtherClass = true;
            }

            // if we generate variable in current class..
            if (!isOtherClass && member == null)
            {
                detach = false;
                lookupPosition = -1;
                position = Sci.WordStartPosition(Sci.CurrentPos, true);
                Sci.SetSel(position, Sci.WordEndPosition(position, true));
            }
            else // if we generate variable in current class
            {
                latest = FindLatest(FlagType.Variable | FlagType.Constant, varVisi, inClass);
                if (latest == null) return;

                position = FindNewVarPosition(Sci, inClass, latest);
                if (position <= 0) return;
                Sci.SetSel(position, position);
            }


            if (member != null)
            {
                // check if it's more sense to generate a static variable (like Config.someStaticVar)
                if (varResult.inFile == null && varResult.relClass != null && !ClassIsInterface(inClass))
                {
                    member.Flags |= FlagType.Static;
                }
            }

            // if this is a constant, we assign a value to constant
            if (job.Equals(GeneratorJobType.Constant))
            {
                contextToken += ":String = \"" + Camelize(contextToken) + "\"";
            }

            GenerateVariable(
                NewMember(contextToken, member, job, ft, varVisi),
                        position, detach);
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
                            result = new ASResult();
                            result.Type = ctx.ResolveType("Function", null);
                            types.Insert(0, result);
                        }
                        else if (c == '(')
                        {
                            result = ASComplete.GetExpressionType(Sci, lastMemberPos + 1);
                            if (!result.IsNull())
                            {
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
                        if (!result.IsNull())
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
                        if (result.Member == null)
                        {
                            paramName = "arg" + (prms.Count + 1);
                            paramType = result.Type.Name;
                            paramQualType = result.Type.QualifiedName;
                        }
                        else
                        {
                            paramName = result.Member.Name;
                            if (result.Member.Type.Equals("void", StringComparison.InvariantCultureIgnoreCase))
                            {
                                paramType = result.Type.Name;
                                paramQualType = result.Type.QualifiedName;
                            }
                            else
                            {
                                paramType = result.Member.Type;
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
            return prms;
        }

        private static void GenerateFunctionJob(GeneratorJobType job, ScintillaNet.ScintillaControl Sci, MemberModel member,
            bool detach, ClassModel inClass)
        {
            int position = 0;
            MemberModel latest = null;

            Visibility funcVisi = job.Equals(GeneratorJobType.FunctionPublic) ? Visibility.Public : GetDefaultVisibility();
            int wordPos = Sci.WordEndPosition(Sci.CurrentPos, true);
            List<FunctionParameter> functionParameters = ParseFunctionParameters(Sci, wordPos);

            // evaluate, if the function should be generated in other class
            ASResult funcResult = ASComplete.GetExpressionType(Sci, Sci.WordEndPosition(Sci.CurrentPos, true));
            if (funcResult != null && funcResult.relClass != null)
            {
                FileModel fileModel = ASFileParser.ParseFile(funcResult.relClass.InFile.FileName, ASContext.Context);
                foreach (ClassModel cm in fileModel.Classes)
                {
                    if (cm.QualifiedName.Equals(funcResult.relClass.QualifiedName))
                    {
                        funcResult.relClass = cm;
                        break;
                    }
                }
                DockContent dc = ASContext.MainForm.OpenEditableDocument(funcResult.relClass.InFile.FileName, true);
                if (!Sci.Equals(ASContext.CurSciControl))
                {
                    Sci = ASContext.CurSciControl;
                    latest = FindLatest(FlagType.Function, funcVisi, funcResult.relClass);
                }
            }

            // if we generate function in current class..
            if (latest == null)
            {
                latest = member;
            }

            // if we generate function in current class..
            if (latest == null)
            {
                detach = false;
                lookupPosition = -1;
                position = Sci.WordStartPosition(Sci.CurrentPos, true);
                Sci.SetSel(position, Sci.WordEndPosition(position, true));
            }
            else // if we generate function in another class..
            {
                position = Sci.PositionFromLine(latest.LineTo + 1) - ((Sci.EOLMode == 0) ? 2 : 1);
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

            // check if it's more sense to generate a static function (like Config.someStaticFunc)
            if (member != null && funcResult.inFile == null && funcResult.relClass != null && !ClassIsInterface(inClass))
            {
                member.Flags |= FlagType.Static;
            }

            GenerateFunction(
                NewMember(contextToken, member, job, FlagType.Function,
                        funcVisi),
                position, detach, functionParameters, inClass);
        }

        private static void GenerateClass(String className, ClassModel inClass)
        {
            AddLookupPosition(); // remember last cursor position for Shift+F4

            IProject project = PluginBase.CurrentProject;
            if (String.IsNullOrEmpty(className)) className = "Class";
            string projFilesDir = Path.Combine(PathHelper.TemplateDir, "ProjectFiles");
            string projTemplateDir = Path.Combine(projFilesDir, project.GetType().Name);
            Hashtable info = new Hashtable();
            info["className"] = className;
            info["templatePath"] = Path.Combine(projTemplateDir, "Class.as.fdt");
            info["inDirectory"] = Path.GetDirectoryName(inClass.InFile.FileName);
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

        private static MemberModel NewMember(string contextToken, MemberModel calledFrom, GeneratorJobType job, FlagType kind, Visibility visi)
        {
            string type = (kind == FlagType.Function) ? ASContext.Context.Features.voidKey : null;
            if (calledFrom != null && (calledFrom.Flags & FlagType.Static) > 0)
                kind |= FlagType.Static;
            return new MemberModel(contextToken, type, kind, visi);
        }

        private static MemberModel NewMember(string contextToken, MemberModel calledFrom, GeneratorJobType job, FlagType kind)
        {
            return NewMember(contextToken, calledFrom, job, kind, GetDefaultVisibility());
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

        private static void GenerateFunction(MemberModel member, int position, bool detach, List<FunctionParameter> parameters, ClassModel inClass)
        {
            string par = "";
            char[] charsToTrim = new char[] { '_' };

            for (int i = 0; i < parameters.Count; i++)
            {
                if (i > 0)
                {
                    par += ", ";
                }

                ASResult result = parameters[i].result;
                string name = parameters[i].param;
                string type = parameters[i].paramType;

                // if constant then convert to camelCase
                if (result.Member != null && (result.Member.Flags & FlagType.Constant) > 0)
                {
                    name = name.ToLower();
                    string[] a = name.Split('_');
                    name = "";
                    for (int j = 0; j < a.Length; j++)
                    {
                        string val = a[j];
                        if (j > 0)
                        {
                            val = char.ToUpper(val[0]) + val.Substring(1);
                        }
                        name += val;
                    }
                }

                // if getter, then remove 'get' prefix
                name = name.TrimStart(charsToTrim);
                if (name.Length > 3 && name.StartsWith("get") && (name[3].ToString() == char.ToUpper(name[3]).ToString()))
                {
                    name = char.ToLower(name[3]).ToString() + name.Substring(4);
                }
                par += name + ":" + type;
            }

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
            string repl = GetDeclaration(member, !isInterface).Replace("()", "(" + par + "$(EntryPoint))");
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

        static private string GetPrivateKeyword()
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
                if (ofClass.Members.Search(name, FlagType.Getter, 0) != null)
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

                Dictionary<MemberModel, ClassModel>.KeyCollection selectedMemberKeys = selectedMembers.Keys;
                foreach (MemberModel m in selectedMemberKeys)
                {
                    sb.Append("$(Boundary)\n\n");

                    if ((m.Flags & FlagType.Override) > 0)
                    {
                        sb.Append("override ");
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

                    sb.Append(member.Name)
                        .Append(".")
                        .Append(m.Name)
                        .Append("(");

                    methodParams = m.Parameters;
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

                            if (param.Type != null)
                            {
                                type = ASContext.Context.ResolveType(param.Type, selectedMembers[m].InFile);
                                importsList.Add(type.QualifiedName);
                            }
                        }
                    }
                    
                    sb.Append(");")
                        .Append("\n}");

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

        private static string FormatType(string type)
        {
            return MemberModel.FormatType(type);
        }

        private static string CleanType(string type)
        {
            int p = type.IndexOf('$');
            if (p > 0) type = type.Substring(0, p);
            p = type.IndexOf('<');
            if (p > 1 && type[p - 1] == '.') p--;
            if (p > 0) type = type.Substring(0, p);
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
            foreach (string type in typesUsed)
            {
                if (type == null || type.Length == 0 || type.IndexOf('.') <= 0 || addedTypes.Contains(type))
                    continue;
                addedTypes.Add(type);
                MemberModel import = new MemberModel(type.Substring(type.LastIndexOf('.') + 1), type, FlagType.Import, Visibility.Public);
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

        private static void InsertCode(int position, string src)
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
                Match m = reModifier.Match(line);
                if (m.Success)
                {
                    lines[i] = m.Groups[1].Value + line.Remove(m.Groups[1].Index, m.Groups[1].Length);
                }
            }
            return String.Join("\n", lines);
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
        FieldsFromPatameters = 17,
        AddInterfaceDef = 18,
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
    #endregion
}
