using System;
using System.Collections.Generic;
using System.Text;
using ASCompletion.Model;
using System.IO;
using System.Text.RegularExpressions;
using ASCompletion.Context;

namespace AS3Context
{
    class MxmlFilterContext
    {
        public List<InlineRange> as3ranges = new List<InlineRange>();
        public MemberList mxmlMembers = new MemberList();
        public string baseTag = "";
    }

    class MxmlFilter
    {
        private static readonly Regex tagName = new Regex("<(?<name>[a-z][a-z0-9_:]*)[\\s>]", RegexOptions.Compiled | RegexOptions.IgnoreCase);

        /// <summary>
        /// Called if a FileModel needs filtering
        /// - define inline AS3 ranges
        /// </summary>
        /// <param name="src"></param>
        /// <returns></returns>
        static public string FilterSource(string src, MxmlFilterContext ctx)
        {
            List<InlineRange> as3ranges = ctx.as3ranges;
            MemberList mxmlMembers = ctx.mxmlMembers;

            StringBuilder sb = new StringBuilder();
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
                            else if (nodeEnd > 0 && nodeStart >= 0 && src.Substring(i + 2, 7) == "[CDATA["
                                && src.Substring(nodeStart, nodeEnd - nodeStart) == "mx:Script")
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
                                string tag = GetXMLContextTag(src, src.IndexOf(' ', i));
                                if (tag != null)
                                {
                                    firstNode = false;
                                    ctx.baseTag = tag;
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
                                string id = GetAttributeValue(src, i);
                                if (id != null)
                                {
                                    MemberModel member = new MemberModel(id, tag, FlagType.Variable | FlagType.Dynamic, Visibility.Public);
                                    member.LineTo = member.LineFrom = line;
                                    mxmlMembers.Add(member);
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
            return sb.ToString();
        }

        /// <summary>
        /// Get the attribute value
        /// </summary>
        private static string GetAttributeValue(string src, int position)
        {
            string value = "";
            char c;
            int len = src.Length;
            bool skip = true;
            while (position < len)
            {
                c = src[position++];
                if (c == '"')
                {
                    if (!skip) return value;
                    else skip = false;
                }
                else if (!skip) value += c;
            }
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
            model.InlinedIn = "xml";
            model.InlinedRanges = ctx.as3ranges;
            string[] qname;
            string ns;
            string cname;

            Dictionary<string, string> resolved = new Dictionary<string,string>();
            foreach (MemberModel member in ctx.mxmlMembers)
            {
                string tag = member.Type;
                string type = null;
                ns = "";
                cname = null;
                if (resolved.ContainsKey(tag)) type = resolved[tag];
                else
                {
                    if (tag.IndexOf(':') >= 0)
                    {
                        qname = tag.Split(':');
                        ns = qname[0];
                        cname = qname[1];
                    }
                    type = ResolveType(model.Context, ns, cname);
                    resolved[tag] = type;
                }
                member.Type = type ?? "Object";
            }

            // consider the inline script as a class body named after the file
            ClassModel theClass = new ClassModel();
            if (ctx.baseTag.IndexOf(':') > 0)
            {
                qname = ctx.baseTag.Split(':');
                ns = qname[0];
                cname = qname[1];
                string baseType = ResolveType(model.Context, ns, cname);
                if (baseType != null && baseType != "") theClass.ExtendsType = baseType;
            }
            theClass.InFile = model;
            theClass.Name = Path.GetFileNameWithoutExtension(model.FileName);
            theClass.Members = model.Members;
            theClass.Members.MergeByLine(ctx.mxmlMembers);
            if (theClass.Members.Count > 0)
            {
                theClass.LineFrom = theClass.Members[0].LineFrom;
                theClass.LineTo = theClass.Members[theClass.Members.Count - 1].LineTo;
            }
            model.Classes.Add(theClass);
            model.Members = new MemberList();
            model.Version = 3;
        }

        private static string ResolveType(IASContext context, string ns, string name)
        {
            string package = null;
            bool anyMatch = false;
            bool mxMatch = false;
            if (name == null) return null;
            else if (ns == "mx")
            {
                mxMatch = true;
            }
            else if (ns == "display" || ns == "errors" || ns == "events" || ns == "filters" || ns == "geom"
                || ns == "media" || ns == "net" || ns == "printing" || ns == "system" || ns == "text" 
                || ns == "ui" || ns == "utils" || ns == "xml")
            {
                package = "flash." + ns + "." + name;
            }
            else anyMatch = true;
            string dname = "." + name;

            MemberList all = context.GetAllProjectClasses();
            foreach (MemberModel member in all)
            {
                string type = member.Type;
                if (type == null) continue;
                bool baseType = type.IndexOf('.') < 0;
                if (anyMatch && baseType)
                {
                    if (type == name) return type;
                }
                else if (anyMatch && type.EndsWith(dname)
                    && !type.StartsWith("mx.") && !type.StartsWith("flash."))
                {
                    return type;
                }
                else if (mxMatch && baseType && type == name)
                {
                    return type;
                }
                else if (mxMatch && type.StartsWith("mx.") && type.EndsWith(dname))
                {
                    return type;
                }
            }
            return "";
        }
    }
}
