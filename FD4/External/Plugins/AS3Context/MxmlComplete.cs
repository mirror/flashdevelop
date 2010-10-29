﻿using System;
using System.Collections.Generic;
using System.Text;
using XMLCompletion;
using ASCompletion.Model;
using ASCompletion.Completion;
using PluginCore;
using PluginCore.Controls;
using System.Text.RegularExpressions;
using System.IO;
using PluginCore.Helpers;

namespace AS3Context
{
    class MxmlComplete
    {
        static public bool IsDirty;
        static public Context context;
        static public MxmlFilterContext mxmlContext;

        #region shortcuts
        public static bool GotoDeclaration()
        {
            ScintillaNet.ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
            if (sci == null) return false;
            if (sci.ConfigurationLanguage != "xml") return false;

            int pos = sci.CurrentPos;
            int len = sci.TextLength;
            while (pos < len)
            {
                char c = (char)sci.CharAt(pos);
                if (c <= 32 || c == '/' || c == '>') break;
                pos ++;
            }
            XMLContextTag ctag = XMLComplete.GetXMLContextTag(sci, pos);
            if (ctag.Name == null) return true;
            string word = sci.GetWordFromPosition(sci.CurrentPos);

            string type = ResolveType(mxmlContext, ctag.Name);
            ClassModel model = context.ResolveType(type, mxmlContext.model);

            if (model.IsVoid()) // try resolving tag as member of parent tag
            {
                parentTag = XMLComplete.GetParentTag(sci, ctag);
                if (parentTag.Name != null)
                {
                    ctag = parentTag;
                    type = ResolveType(mxmlContext, ctag.Name);
                    model = context.ResolveType(type, mxmlContext.model);
                    if (model.IsVoid()) return true;
                }
                else return true;
            }

            if (!ctag.Name.EndsWith(word))
            {
                ASResult found = ResolveAttribute(model, word);
                ASComplete.OpenDocumentToDeclaration(sci, found);
            }
            else
            {
                ASResult found = new ASResult();
                found.inFile = model.InFile;
                found.Type = model;
                ASComplete.OpenDocumentToDeclaration(sci, found);
            }
            return true;
        }
        #endregion

        #region tag completion
        static private XMLContextTag tagContext;
        static private XMLContextTag parentTag;
        static private string tokenContext;
        static private string checksum;
        static private Dictionary<string, List<string>> allTags;
        //static private Regex reIncPath = new Regex("[\"']([^\"']+)", RegexOptions.Compiled);
        static private Regex reIncPath = new Regex("(\"|')([^\r\n]+)(\\1)", RegexOptions.Compiled);
        static private Dictionary<string, FileModel> includesCache = new Dictionary<string,FileModel>();

        /// <summary>
        /// Called 
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        static public bool HandleElement(object data)
        {
            if (!GetContext(data)) return false;

            if (!string.IsNullOrEmpty(tagContext.Name) && tagContext.Name.IndexOf(':') > 0)
                return HandleNamespace(data);

            List<ICompletionListItem> mix = new List<ICompletionListItem>();
            List<string> excludes = new List<string>();

            bool isContainer = AddParentAttributes(mix, excludes); // current tag attributes

            if (isContainer) // container children tag
            foreach (string ns in mxmlContext.namespaces.Keys)
            {
                string uri = mxmlContext.namespaces[ns];
                if (ns != "*") mix.Add(new NamespaceItem(ns, uri));

                if (!allTags.ContainsKey(ns)) 
                    continue;
                foreach (string tag in allTags[ns])
                {
                    if (ns == "*") mix.Add(new HtmlTagItem(tag, tag));
                    else mix.Add(new HtmlTagItem(tag, ns + ":" + tag, uri));
                }
            }

            // cleanup and show list
            mix.Sort(new MXMLListItemComparer());
            List<ICompletionListItem> items = new List<ICompletionListItem>();
            string previous = null;
            foreach (ICompletionListItem item in mix)
            {
                if (previous == item.Label) continue;
                previous = item.Label;
                if (excludes.Contains(previous)) continue;
                items.Add(item);
            }

            if (mix.Count == 0) return true;
            if (!string.IsNullOrEmpty(tagContext.Name)) CompletionList.Show(items, false, tagContext.Name);
            else CompletionList.Show(items, true);
            CompletionList.MinWordLength = 0;
            return true;
        }

        private static bool AddParentAttributes(List<ICompletionListItem> mix, List<string> excludes)
        {
            bool isContainer = true;
            if (parentTag.Name != null) // add parent tag members
            {
                if (tagContext.Closing) // closing tag, only show parent tag
                {
                    isContainer = false;
                    mix.Add(new HtmlTagItem(parentTag.Name.Substring(parentTag.Name.IndexOf(':') + 1), parentTag.Name + '>'));
                }
                else
                {
                    string parentType = ResolveType(mxmlContext, parentTag.Name);
                    ClassModel parentClass = context.ResolveType(parentType, mxmlContext.model);
                    if (!parentClass.IsVoid())
                    {
                        parentClass.ResolveExtends();
                        isContainer = GetTagAttributes(parentClass, mix, excludes, parentTag.NameSpace);
                    }
                }
            }
            return isContainer;
        }

        static public bool HandleNamespace(object data)
        {
            if (!GetContext(data) || string.IsNullOrEmpty(tagContext.Name)) 
                return false;

            int p = tagContext.Name.IndexOf(':');
            if (p < 0) return false;
            string ns = tagContext.Name.Substring(0, p);
            if (!mxmlContext.namespaces.ContainsKey(ns)) 
                return true;

            string uri = mxmlContext.namespaces[ns];
            List<ICompletionListItem> mix = new List<ICompletionListItem>();
            List<string> excludes = new List<string>();

            bool isContainer = AddParentAttributes(mix, excludes); // current tag attributes

            if (isContainer && allTags.ContainsKey(ns)) // container children tags
                foreach (string tag in allTags[ns])
                    mix.Add(new HtmlTagItem(tag, ns + ":" + tag, uri));

            // cleanup and show list
            mix.Sort(new MXMLListItemComparer());
            List<ICompletionListItem> items = new List<ICompletionListItem>();
            string previous = null;
            foreach (ICompletionListItem item in mix)
            {
                if (previous == item.Label) continue;
                previous = item.Label;
                if (excludes.Contains(previous)) continue;
                items.Add(item);
            }

            if (mix.Count == 0) return true;
            CompletionList.Show(items, true, tagContext.Name ?? "");
            CompletionList.MinWordLength = 0;
            return true;
        }

        static public bool HandleElementClose(object data)
        {
            if (!GetContext(data)) return false;

            if (tagContext.Closing) return false;

            string type = ResolveType(mxmlContext, tagContext.Name);
            ScintillaNet.ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;

            if (type.StartsWith("mx.builtin.") || type.StartsWith("fx.builtin.")) // special tags
            {
                if (type.EndsWith(".Script"))
                {
                    string snip = "$(Boundary)\n\t<![CDATA[\n\t$(EntryPoint)\n\t]]>\n</" + tagContext.Name + ">";
                    SnippetHelper.InsertSnippetText(sci, sci.CurrentPos, snip);
                    return true;
                }
                if (type.EndsWith(".Style"))
                {
                    string snip = "$(Boundary)";
                    foreach (string ns in mxmlContext.namespaces.Keys)
                    {
                        string uri = mxmlContext.namespaces[ns];
                        if (ns != "fx")
                            snip += String.Format("\n\t@namespace {0} \"{1}\";", ns, uri);
                    }
                    snip += "\n\t$(EntryPoint)\n</" + tagContext.Name + ">";
                    SnippetHelper.InsertSnippetText(sci, sci.CurrentPos, snip);
                    return true;
                }
            }
            return false;
        }

        static public bool HandleAttribute(object data)
        {
            if (!GetContext(data)) return false;

            string type = ResolveType(mxmlContext, tagContext.Name);
            ClassModel tagClass = context.ResolveType(type, mxmlContext.model);
            if (tagClass.IsVoid()) return true;
            tagClass.ResolveExtends();

            List<ICompletionListItem> mix = new List<ICompletionListItem>();
            List<string> excludes = new List<string>();
            GetTagAttributes(tagClass, mix, excludes, null);

            // cleanup and show list
            mix.Sort(new MXMLListItemComparer());
            List<ICompletionListItem> items = new List<ICompletionListItem>();
            string previous = null;
            foreach (ICompletionListItem item in mix)
            {
                if (previous == item.Label) continue;
                previous = item.Label;
                if (excludes.Contains(previous)) continue;
                items.Add(item);
            }

            if (items.Count == 0) return true;
            if (!string.IsNullOrEmpty(tokenContext)) CompletionList.Show(items, false, tokenContext);
            else CompletionList.Show(items, true);
            CompletionList.MinWordLength = 0;
            return true;
        }

        private static bool GetTagAttributes(ClassModel tagClass, List<ICompletionListItem> mix, List<string> excludes, string ns)
        {
            ClassModel curClass = mxmlContext.model.GetPublicClass();
            ClassModel tmpClass = tagClass;
            FlagType mask = FlagType.Variable | FlagType.Setter;
            Visibility acc = context.TypesAffinity(curClass, tmpClass);
            bool isContainer = false;

            if (tmpClass.InFile.Package != "mx.builtin" && tmpClass.InFile.Package != "fx.builtin")
                mix.Add(new HtmlAttributeItem("id", "String", null, ns));
            else isContainer = true;

            while (tmpClass != null && !tmpClass.IsVoid())
            {
                string className = tmpClass.Name;
                // look for containers
                if (!isContainer && tmpClass.Implements != null 
                    && (tmpClass.Implements.Contains("IContainer") 
                    || tmpClass.Implements.Contains("IVisualElementContainer")
                    || tmpClass.Implements.Contains("IFocusManagerContainer")))
                    isContainer = true;

                foreach (MemberModel member in tmpClass.Members)
                    if ((member.Flags & FlagType.Dynamic) > 0 && (member.Flags & mask) > 0
                        && (member.Access & acc) > 0)
                    {
                        string mtype = member.Type;

                        if ((member.Flags & FlagType.Setter) > 0)
                        {
                            if (member.Parameters != null && member.Parameters.Count > 0)
                                mtype = member.Parameters[0].Type;
                            else mtype = null;
                        }
                        mix.Add(new HtmlAttributeItem(member.Name, mtype, className, ns));
                    }

                ExploreMetadatas(tmpClass.InFile, mix, excludes, ns);

                tmpClass = tmpClass.Extends;
                if (tmpClass != null && tmpClass.InFile.Package == "" && tmpClass.Name == "Object")
                    break;
                // members visibility
                acc = context.TypesAffinity(curClass, tmpClass);
            }

            return isContainer;
        }

        private static void ExploreMetadatas(FileModel fileModel, List<ICompletionListItem> mix, List<string> excludes, string ns)
        {
            if (fileModel == null || fileModel.MetaDatas == null) 
                return;
            ClassModel model = fileModel.GetPublicClass();
            string className = model.IsVoid() ? Path.GetFileNameWithoutExtension(fileModel.FileName) : model.Name;
            foreach (ASMetaData meta in fileModel.MetaDatas)
            {
                string add = null;
                string type = null;
                switch (meta.Kind)
                {
                    case ASMetaKind.Event: add = ":e"; break;
                    case ASMetaKind.Style: 
                        add = ":s"; 
                        if (meta.Params != null) type = meta.Params["type"]; 
                        break;
                    case ASMetaKind.Effect: 
                        add = ":x";
                        if (meta.Params != null) type = meta.Params["event"]; 
                        break;
                    case ASMetaKind.Exclude:
                        if (meta.Params != null) excludes.Add(meta.Params["name"]);
                        break;
                    case ASMetaKind.Include:
                        FileModel incModel = ParseInclude(fileModel, meta);
                        ExploreMetadatas(incModel, mix, excludes, ns);
                        break;
                }
                if (add != null)
                    mix.Add(new HtmlAttributeItem(meta.Params["name"] + add, type, className, ns));
            }
        }

        private static FileModel ParseInclude(FileModel fileModel, ASMetaData meta)
        {
            Match m = reIncPath.Match(meta.RawParams);
            if (m.Success)
            {
                string path = m.Groups[2].Value;
                if (path.Length == 0) return null;

                // retrieve from cache
                if (includesCache.ContainsKey(path))
                    return includesCache[path];

                // relative path?
                string fileName = path;
                if (!Path.IsPathRooted(fileName))
                {
                    if (fileName[0] == '/' || fileName[0] == '\\')
                        fileName = Path.Combine(fileModel.BasePath, fileName);
                    else
                        fileName = Path.Combine(Path.GetDirectoryName(fileModel.FileName), fileName);
                }

                // parse & cache
                if (!File.Exists(fileName)) return null;
                string src = File.ReadAllText(fileName);
                if (src.IndexOf("package") < 0) src = "package {" + src + "}";
                ASFileParser parser = new ASFileParser();
                FileModel model = new FileModel(path);
                parser.ParseSrc(model, src);

                includesCache[path] = model;
                return model;
            }
            return null;
        }
        #endregion

        #region context detection
        private static bool GetContext(object data)
        {
            if (mxmlContext == null || mxmlContext.model == null) 
                return false;

            ScintillaNet.ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
            if (sci == null) return false;

            // XmlComplete context
            try
            {
                if (data is XMLContextTag)
                    tagContext = (XMLContextTag)data;
                else
                {
                    object[] o = (object[])data;
                    tagContext = (XMLContextTag)o[0];
                    tokenContext = (string)o[1];
                }
            }
            catch
            {
                return false;
            }

            // more context
            parentTag = XMLComplete.GetParentTag(sci, tagContext);

            // rebuild tags cache?
            string sum = "" + context.GetAllProjectClasses().Count;
            foreach (string uri in mxmlContext.namespaces.Values)
                sum += uri;
            if (IsDirty || sum != checksum)
            {
                checksum = sum;
                GetAllTags();
            }
            return true;
        }
        #endregion

        #region tag resolution
        private static void GetAllTags()
        {
            Dictionary<string, string> nss = mxmlContext.namespaces;
            MemberList allClasses = context.GetAllProjectClasses();
            Dictionary<string, string> packages = new Dictionary<string, string>();
            allTags = new Dictionary<string, List<string>>();

            foreach (string key in nss.Keys)
            {
                string uri = nss[key];
                if (uri.EndsWith(".*"))
                    packages[uri.Substring(0, uri.LastIndexOf('.') + 1)] = key;
                else if (uri == "*")
                    packages["*"] = key;
            }

            foreach (MemberModel model in allClasses)
            {
                if ((model.Flags & FlagType.Class) == 0 || (model.Flags & FlagType.Interface) != 0)
                    continue;
                int p = model.Type.IndexOf('.');
                string bns = p > 0 ? model.Type.Substring(0, p) : "";
                if (bns == "mx" || bns == "fx" || bns == "spark")
                    continue;

                p = model.Type.LastIndexOf('.');
                string pkg = model.Type.Substring(0, p + 1);
                if (pkg == "") pkg = "*";
                if (packages.ContainsKey(pkg))
                {
                    string ns = packages[pkg];
                    if (!allTags.ContainsKey(ns)) allTags.Add(ns, new List<string>());
                    allTags[ns].Add(model.Name.Substring(p + 1));
                }
            }

            foreach (MxmlCatalog cat in mxmlContext.catalogs)
            {
                List<string> cls = allTags.ContainsKey(cat.NS) ? allTags[cat.NS] : new List<string>();
                cls.AddRange(cat.Keys);
                allTags[cat.NS] = cls;
            }
        }

        public static string ResolveType(MxmlFilterContext ctx, string tag)
        {
            if (tag == null) return "void";
            int p = tag.IndexOf(':');
            if (p < 0) return ResolveType(ctx, "*", tag);
            else return ResolveType(ctx, tag.Substring(0, p), tag.Substring(p + 1));
        }

        public static string ResolveType(MxmlFilterContext ctx, string ns, string name)
        {
            if (!ctx.namespaces.ContainsKey(ns))
                return name;

            string uri = ctx.namespaces[ns];
            if (uri == "*")
                return name;
            if (uri.EndsWith(".*"))
                return uri.Substring(0, uri.Length - 1) + name;

            if (uri == MxmlFilter.BETA_MX || uri == MxmlFilter.OLD_MX) 
                uri = MxmlFilter.NEW_MX;

            foreach (MxmlCatalog cat in ctx.catalogs)
            {
                if (cat.URI == uri && cat.ContainsKey(name))
                    return cat[name];
            }
            return name;
        }

        private static ASResult ResolveAttribute(ClassModel model, string word)
        {
            ASResult result = new ASResult();
            ClassModel curClass = mxmlContext.model.GetPublicClass();
            ClassModel tmpClass = model;
            Visibility acc = context.TypesAffinity(curClass, tmpClass);
            List<string> excludes = new List<string>();
            tmpClass.ResolveExtends();

            while (tmpClass != null && !tmpClass.IsVoid())
            {
                foreach (MemberModel member in tmpClass.Members)
                    if ((member.Flags & FlagType.Dynamic) > 0 && (member.Access & acc) > 0
                        && member.Name == word)
                    {
                        result.inFile = tmpClass.InFile;
                        if (member.LineFrom == 0) // cached model, reparse
                        {
                            result.inFile.OutOfDate = true;
                            result.inFile.Check();
                            if (result.inFile.Classes.Count > 0)
                            {
                                result.inClass = result.inFile.Classes[0];
                                result.Member = result.inClass.Members.Search(member.Name, member.Flags, 0);
                            }
                        }
                        else result.Member = member;
                        return result;
                    }

                // TODO inspect metadata & includes

                tmpClass = tmpClass.Extends;
                if (tmpClass != null && tmpClass.InFile.Package == "" && tmpClass.Name == "Object")
                    break;
                // members visibility
                acc = context.TypesAffinity(curClass, tmpClass);
            }
            return result;
        }
        #endregion
    }

    class MXMLListItemComparer : IComparer<ICompletionListItem>
    {

        public int Compare(ICompletionListItem a, ICompletionListItem b)
        {
            string a1;
            string b1;
            if (a.Label.Equals(b.Label, StringComparison.OrdinalIgnoreCase))
            {
                int c = String.Compare("a", "b");
                if (a is HtmlAttributeItem && b is HtmlTagItem) return 1;
                else if (b is HtmlAttributeItem && a is HtmlTagItem) return -1;
            }
            if (a is IHtmlCompletionListItem)
            {
                a1 = ((IHtmlCompletionListItem)a).Name;
                if (a.Value.StartsWith("mx:")) a1 += "z"; // push down mx: tags
            }
            else a1 = a.Label;
            if (b is IHtmlCompletionListItem)
            {
                b1 = ((IHtmlCompletionListItem)b).Name;
                if (b.Value.StartsWith("mx:")) b1 += "z"; // push down mx: tags
            }
            else b1 = b.Label;
            return string.Compare(a1, b1);
        }

    }
}
