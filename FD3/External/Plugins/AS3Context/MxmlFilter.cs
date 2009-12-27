using System;
using System.Collections.Generic;
using System.Text;
using ASCompletion.Model;
using System.IO;
using System.Text.RegularExpressions;
using ASCompletion.Context;
using System.Xml;

namespace AS3Context
{
    class MxmlFilterContext
    {
        public List<InlineRange> as3ranges = new List<InlineRange>();
        public MemberList mxmlMembers = new MemberList();
        public string baseTag = "";
        public Dictionary<string, string> namespaces = new Dictionary<string,string>();
        public List<MxmlCatalog> catalogs = new List<MxmlCatalog>();
        public FileModel model;
    }

    #region MXML Filter
    class MxmlFilter
    {
        static private readonly Regex tagName = new Regex("<(?<name>[a-z][a-z0-9_:]*)[\\s>]", RegexOptions.Compiled | RegexOptions.IgnoreCase);

        static private Dictionary<string, MxmlCatalog> catalogs = new Dictionary<string, MxmlCatalog>();
        static private Dictionary<string, MxmlCatalog> archive = new Dictionary<string,MxmlCatalog>();

        static public void UpdateCatalogs(List<PathModel> classpath)
        {
            // keep catalogs in memory
            foreach (string key in catalogs.Keys)
                if (!archive.ContainsKey(key)) archive[key] = catalogs[key];

            // lookup catalogs
            catalogs.Clear();
            foreach (PathModel aPath in classpath)
            {
                try
                {
                    string[] files = Directory.GetFiles(aPath.Path, "*.xml");
                    foreach (string file in files)
                        if (file.EndsWith("catalog.xml")) AddCatalog(file);
                }
                catch { }
            }
        }

        private static void AddCatalog(string file)
        {
            if (archive.ContainsKey(file))
            {
                catalogs[file] = archive[file];
                return;
            }
            try
            {
                MxmlCatalog cat = new MxmlCatalog();
                cat.Read(file);
                catalogs[file] = cat;
            }
            catch (XmlException ex) { }
        }

        /// <summary>
        /// Called if a FileModel needs filtering
        /// - define inline AS3 ranges
        /// </summary>
        /// <param name="src"></param>
        /// <returns></returns>
        static public string FilterSource(string name, string src, MxmlFilterContext ctx)
        {
            List<InlineRange> as3ranges = ctx.as3ranges;
            MemberList mxmlMembers = ctx.mxmlMembers;

            StringBuilder sb = new StringBuilder();
            sb.Append("package{");
            int len = src.Length - 8;
            int rangeStart = -1;
            int nodeStart = -1;
            int nodeEnd = -1;
            int line = 0;
            bool firstNode = true;
            bool skip = true;
            bool hadNL = false;
            bool inComment = false;
            for (int i = 0; i < len; i++)
            {
                char c = src[i];
                // keep newlines
                if (c == 10 || c == 13)
                {
                    if (c == 13) line++;
                    else if (i > 0 && src[i - 1] != 13) line++;
                    sb.Append(c);
                    hadNL = true;
                }
                // XML comment
                else if (inComment)
                {
                    if (i < len - 3 && c == '-' && src[i + 1] == '-' && src[i + 2] == '>')
                    {
                        inComment = false;
                        i += 3;
                    }
                    continue;
                }
                // in XML
                else if (skip)
                {
                    if (c == '<' && i < len-3)
                    {
                        if (src[i + 1] == '!')
                        {
                            if (src[i + 2] == '-' && src[i + 3] == '-')
                            {
                                inComment = true;
                                i += 3;
                                continue;
                            }
                            else if (src[i + 2] == '[' && src.Substring(i + 2, 7) == "[CDATA[")
                            {
                                i += 8;
                                skip = false;
                                hadNL = false;
                                rangeStart = i;
                                continue;
                            }
                        }
                        else
                        {
                            nodeStart = i + 1;
                            nodeEnd = -1;

                            if (firstNode && src[i + 1] != '?')
                            {
                                int space = src.IndexOf(' ', i);
                                string tag = GetXMLContextTag(src, space);
                                if (tag != null && space > 0)
                                {
                                    firstNode = false;
                                    ctx.baseTag = tag;
                                    ReadNamespaces(ctx, src, space);
                                    string type = MxmlComplete.ResolveType(ctx, tag);
                                    sb.Append("public class ").Append(name)
                                        .Append(" extends ").Append(type).Append('{');
                                }
                            }
                        }
                    }
                    else if (c == '=' && i > 4) // <node id="..."
                    {
                        if (src[i - 3] == ' ' && src[i - 2] == 'i' && src[i - 1] == 'd')
                        {
                            string tag = GetXMLContextTag(src, i);
                            if (tag != null)
                            {
                                string id = GetAttributeValue(src, ref i);
                                if (id != null)
                                {
                                    MemberModel member = new MemberModel(id, tag, FlagType.Variable | FlagType.Dynamic, Visibility.Public);
                                    member.LineTo = member.LineFrom = line;
                                    string type = MxmlComplete.ResolveType(ctx, tag);
                                    mxmlMembers.Add(member);
                                    sb.Append("public var ").Append(id)
                                        .Append(':').Append(type).Append(';');
                                }
                            }
                        }
                    }
                    else if (nodeEnd < 0)
                    {
                        if (nodeStart >= 0 && (c == ' ' || c == '>'))
                        {
                            nodeEnd = i;
                        }
                    }
                }
                // in script
                else
                {
                    if (c == ']' && src[i] == ']' && src[i + 1] == '>')
                    {
                        skip = true;
                        if (hadNL) as3ranges.Add(new InlineRange("as3", rangeStart, i));
                        rangeStart = -1;
                    }
                    else sb.Append(c);
                }
            }
            if (rangeStart >= 0 && hadNL)
                as3ranges.Add(new InlineRange("as3", rangeStart, src.Length));
            sb.Append("}}");
            return sb.ToString();
        }

        private static void ReadNamespaces(MxmlFilterContext ctx, string src, int i)
        {
            // built-in ns
            ctx.namespaces["display"] = "flash.display.*";
            ctx.namespaces["errors"] = "flash.errors.*";
            ctx.namespaces["events"] = "flash.events.*";
            ctx.namespaces["filters"] = "flash.filters.*";
            ctx.namespaces["geom"] = "flash.geom.*";
            ctx.namespaces["media"] = "flash.media.*";
            ctx.namespaces["net"] = "flash.net.*";
            ctx.namespaces["printing"] = "flash.printing.*";
            ctx.namespaces["system"] = "flash.system.*";
            ctx.namespaces["text"] = "flash.text.*";
            ctx.namespaces["ui"] = "flash.ui.*";
            ctx.namespaces["utils"] = "flash.utils.*";
            ctx.namespaces["xml"] = "flash.xml.*";

            // declared ns
            int len = src.Length;
            while (i < len)
            {
                string name = GetAttributeName(src, ref i);
                if (name == null) break;
                string value = GetAttributeValue(src, ref i);
                if (value == null) break;
                if (name.StartsWith("xmlns"))
                {
                    string[] qname = name.Split(':');
                    if (qname.Length == 1) ctx.namespaces["*"] = value;
                    else ctx.namespaces[qname[1]] = value;
                }
            }
            // find catalogs
            foreach (string ns in ctx.namespaces.Keys)
            {
                string uri = ctx.namespaces[ns];
                string temp = (uri == "http://www.adobe.com/2006/mxml") ? "library://ns.adobe.com/flex/halo" : uri;
                foreach (MxmlCatalog cat in catalogs.Values)
                    if (cat.URI == temp)
                    {
                        cat.NS = ns;
                        ctx.catalogs.Add(cat);
                    }
            }
        }

        /// <summary>
        /// Get the attribute name
        /// </summary>
        private static string GetAttributeName(string src, ref int i)
        {
            string name = "";
            char c;
            int oldPos = 0;
            int len = src.Length;
            bool skip = true;
            while (i < len)
            {
                c = src[i++];
                if (c == '>') return null;
                if (skip && c > 32) skip = false;
                if (c == '=')
                {
                    if (!skip) return name;
                    else break;
                }
                else if (!skip && c > 32) name += c;
            }
            i = oldPos;
            return null;
        }

        /// <summary>
        /// Get the attribute value
        /// </summary>
        private static string GetAttributeValue(string src, ref int i)
        {
            string value = "";
            char c;
            int oldPos = i;
            int len = src.Length;
            bool skip = true;
            while (i < len)
            {
                c = src[i++];
                if (c == 10 || c == 13) break;
                if (c == '"')
                {
                    if (!skip) return value;
                    else skip = false;
                }
                else if (!skip) value += c;
            }
            i = oldPos;
            return null;
        }

        /// <summary>
        /// Gets the xml context tag
        /// </summary> 
        private static string GetXMLContextTag(string src, int position)
        {
            if (position < 0) return null;
            StringBuilder sb = new StringBuilder();
            char c = src[position - 1];
            position -= 2;
            sb.Append(c);
            while (position >= 0)
            {
                c = src[position];
                sb.Insert(0, c);
                if (c == '>') return null;
                if (c == '<') break;
                position--;
            }
            string tag = sb.ToString();
            Match mTag = tagName.Match(tag + " ");
            if (mTag.Success) return mTag.Groups["name"].Value;
            else return null;
        }

        /// <summary>
        /// Called if a FileModel needs filtering
        /// - modify parsed model
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        static public void FilterSource(FileModel model, MxmlFilterContext ctx)
        {
            ctx.model = model;
            model.InlinedIn = "xml";
            model.InlinedRanges = ctx.as3ranges;
            string[] qname;
            string ns;
            string cname;

            if (model.MetaDatas == null) model.MetaDatas = new List<ASMetaData>();
            foreach (string key in ctx.namespaces.Keys)
            {
                ASMetaData meta = new ASMetaData("Namespace");
                meta.Params = new Dictionary<string, string>();
                meta.Params.Add(key, ctx.namespaces[key]);
                model.MetaDatas.Add(meta);
            }

            ClassModel aClass = model.GetPublicClass();
            if (aClass == ClassModel.VoidClass) 
                return;
            aClass.Comments = "<" + ctx.baseTag + "/>";

            Dictionary<string, string> resolved = new Dictionary<string,string>();
            foreach (MemberModel mxmember in ctx.mxmlMembers)
            {
                string tag = mxmember.Type;
                string type = null;
                ns = "";
                cname = null;
                if (resolved.ContainsKey(tag)) type = resolved[tag];
                else
                {
                    type = MxmlComplete.ResolveType(ctx, tag);
                    resolved[tag] = type;
                }
                MemberModel member = aClass.Members.Search(mxmember.Name, FlagType.Variable, Visibility.Public);
                if (member != null)
                {
                    member.Comments = "<" + tag + "/>";
                    member.Type = type;
                }
            }
        }
    }
    #endregion

    #region Catalogs
    class MxmlCatalog : Dictionary<string, string>
    {
        public string URI;
        public string NS;

        public void Read(string fileName)
        {
            XmlReader reader = new XmlTextReader(fileName);
            reader.MoveToContent();
            while (reader.Read())
            {
                string tag = reader.Name;
                if (tag == "components") reader.MoveToContent();
                else if (tag == "component")
                {
                    string className = null;
                    string name = null;
                    string uri = null;
                    if (reader.MoveToFirstAttribute())
                        do
                        {
                            switch (reader.Name)
                            {
                                case "className": className = reader.Value; break;
                                case "name": name = reader.Value; break;
                                case "uri": uri = reader.Value; break;
                            }
                            if (!string.IsNullOrEmpty(className) && !string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(uri))
                            {
                                this[name] = className.Replace(':', '.');
                                if (URI == null) URI = uri;
                            }
                        }
                        while (reader.MoveToNextAttribute());
                }
            }

            if (URI == "http://www.adobe.com/2006/mxml") 
                URI = "library://ns.adobe.com/flex/halo";
        }
    }
    #endregion
}
