using System;
using System.Collections.Generic;
using System.Text;
using XMLCompletion;
using ASCompletion.Model;
using ASCompletion.Completion;
using PluginCore;
using PluginCore.Controls;
using System.Text.RegularExpressions;
using System.IO;

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
            if (model.IsVoid()) return true;

            if (!ctag.Name.EndsWith(word))
            {
                ASResult found = ResolveAttribute(model, word);
                if (found.inFile != null && found.Member != null)
                {
                    PluginBase.MainForm.OpenEditableDocument(found.inFile.FileName, false);
                    ASComplete.LocateMember("(var|const|get|set)", found.Member.Name, found.Member.LineFrom);
                    return true;
                }
            }
            
            PluginBase.MainForm.OpenEditableDocument(model.InFile.FileName);
            return true;
        }
        #endregion

        #region tag completion
        static private XMLContextTag tagContext;
        static private string tokenContext;
        static private string checksum;
        static private Dictionary<string, List<string>> allTags;
        static private Regex reIncPath = new Regex("[\"']([^\"']+)", RegexOptions.Compiled);
        static private Dictionary<string, FileModel> includesCache = new Dictionary<string,FileModel>();

        static public bool HandleElement(object data)
        {
            if (!string.IsNullOrEmpty(tagContext.Name) && tagContext.Name.IndexOf(':') > 0)
                return HandleNamespace(data);

            if (!GetContext(data)) return false;

            List<ICompletionListItem> items = new List<ICompletionListItem>();
            foreach (string ns in mxmlContext.namespaces.Keys)
            {
                if (ns != "*") items.Add(new NamespaceItem(ns));

                string uri = mxmlContext.namespaces[ns];
                if (uri.StartsWith("flash.") || !allTags.ContainsKey(ns)) 
                    continue;
                foreach (string tag in allTags[ns])
                {
                    if (ns == "*") items.Add(new HtmlTagItem(tag, tag));
                    else items.Add(new HtmlTagItem(tag, ns + ":" + tag));
                }
            }

            if (items.Count == 0) return true;
            items.Sort(new ListItemComparer());
            if (!string.IsNullOrEmpty(tagContext.Name)) CompletionList.Show(items, false, tagContext.Name);
            else CompletionList.Show(items, true);
            return true;
        }

        static public bool HandleNamespace(object data)
        {
            if (!GetContext(data) || string.IsNullOrEmpty(tagContext.Name)) 
                return false;

            int p = tagContext.Name.IndexOf(':');
            if (p < 0) return false;
            string ns = tagContext.Name.Substring(0, p);
            string word = tagContext.Name.Substring(p + 1);
            if (!mxmlContext.namespaces.ContainsKey(ns)) 
                return true;

            List<ICompletionListItem> items = new List<ICompletionListItem>();
            foreach (string tag in allTags[ns])
            {
                items.Add(new HtmlTagItem(tag, tag));
            }

            if (items.Count == 0) return true;
            items.Sort(new ListItemComparer());
            if (!string.IsNullOrEmpty(word)) CompletionList.Show(items, false, word);
            else CompletionList.Show(items, true);
            return true;
        }

        static public bool HandleElementClose(object data)
        {
            if (!GetContext(data)) return false;

            return false;
        }

        static public bool HandleAttribute(object data)
        {
            if (!GetContext(data)) return false;

            string type = ResolveType(mxmlContext, tagContext.Name);
            ClassModel tmpClass = context.ResolveType(type, mxmlContext.model);
            if (tmpClass.IsVoid()) return true;
            tmpClass.ResolveExtends();

            MemberList mix = new MemberList();
            ClassModel curClass = mxmlContext.model.GetPublicClass();
            FlagType mask = FlagType.Variable | FlagType.Setter;
            Visibility acc = context.TypesAffinity(curClass, tmpClass);
            List<string> excludes = new List<string>();

            if (tmpClass.InFile.Package != "mx.builtin") 
                mix.Add(new MemberModel("id", "", 0, 0));

            while (tmpClass != null && !tmpClass.IsVoid())
            {
                foreach (MemberModel member in tmpClass.Members)
                    if ((member.Flags & FlagType.Dynamic) > 0 && (member.Flags & mask) > 0 
                        && (member.Access & acc) > 0)
                        mix.Add(member);

                ExploreMetadatas(tmpClass.InFile, mix, excludes);

                tmpClass = tmpClass.Extends;
                if (tmpClass != null && tmpClass.InFile.Package == "" && tmpClass.Name == "Object")
                    break;
                // members visibility
                acc = context.TypesAffinity(curClass, tmpClass);
            }
            mix.Sort();
            
            List<ICompletionListItem> items = new List<ICompletionListItem>();
            string previous = null;
            foreach (MemberModel member in mix.Items)
            {
                if (previous == member.Name) continue;
                previous = member.Name;
                if (excludes.Contains(previous)) continue;
                items.Add(new HtmlAttributeItem(previous));
            }

            if (items.Count == 0) return true;
            items.Sort(new ListItemComparer());
            if (!string.IsNullOrEmpty(tokenContext)) CompletionList.Show(items, false, tokenContext);
            else CompletionList.Show(items, true);
            return true;
        }

        private static void ExploreMetadatas(FileModel fileModel, MemberList mix, List<string> excludes)
        {
            if (fileModel == null || fileModel.MetaDatas == null) 
                return;
            foreach (ASMetaData meta in fileModel.MetaDatas)
            {
                string add = null;
                switch (meta.Kind)
                {
                    case ASMetaKind.Event: add = ":e"; break;
                    case ASMetaKind.Style: add = ":s"; break;
                    case ASMetaKind.Effect: add = ":x"; break;
                    case ASMetaKind.Exclude:
                        if (meta.Params != null) excludes.Add(meta.Params["name"]);
                        break;
                    case ASMetaKind.Include:
                        FileModel incModel = ParseInclude(fileModel, meta);
                        ExploreMetadatas(incModel, mix, excludes);
                        break;
                }
                if (add != null) mix.Add(new MemberModel(meta.Params["name"] + add, "", 0, 0));
            }
        }

        private static FileModel ParseInclude(FileModel fileModel, ASMetaData meta)
        {
            Match m = reIncPath.Match(meta.RawParams);
            if (m.Success)
            {
                string path = m.Groups[1].Value;
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
                        path = Path.Combine(Path.GetDirectoryName(fileModel.FileName), fileName);
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

        private static bool GetContext(object data)
        {
            if (mxmlContext == null) return false;

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
            allTags["*"] = new List<string>();

            foreach (string key in nss.Keys)
            {
                string uri = nss[key];
                if (uri.EndsWith(".*"))
                    packages.Add(uri.Substring(0, uri.LastIndexOf('.') + 1), key);
            }

            foreach (MemberModel model in allClasses)
            {
                if ((model.Flags & FlagType.Class) == 0)
                    continue;
                int p = model.Type.IndexOf('.');
                string bns = p > 0 ? model.Type.Substring(0, p) : "";
                if (bns == "")
                {
                    allTags["*"].Add(model.Type);
                    continue;
                }
                if (bns == "mx" || bns == "fx" || bns == "spark")
                    continue;
                p = model.Type.LastIndexOf('.');
                string pkg = model.Type.Substring(0, p + 1);
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

            if (uri == "http://www.adobe.com/2006/mxml")
                uri = "library://ns.adobe.com/flex/halo";
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
            FlagType mask = FlagType.Variable | FlagType.Setter;
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
                        result.Member = member;
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
}
