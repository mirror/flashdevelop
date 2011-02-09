using System;
using System.Collections.Generic;
using System.Text;
using ASCompletion.Model;
using SwfOp;
using SwfOp.Data;
using System.IO;
using System.Text.RegularExpressions;
using System.Xml;
using ASCompletion.Context;
using System.Globalization;

namespace AS3Context
{
    #region ABC model builder

    public class AbcConverter
    {
        static public Regex reSafeChars = new Regex("[*\\:" + Regex.Escape(new String(Path.GetInvalidPathChars())) + "]", RegexOptions.Compiled);
        static private Regex reDocFile = new Regex("[/\\\\]([-_.$a-z0-9]+)\\.xml", RegexOptions.IgnoreCase | RegexOptions.Compiled);
        
        static public Dictionary<string, Dictionary<string, DocItem>> Docs 
            = new Dictionary<string, Dictionary<string, DocItem>>();

        private static Dictionary<string, FileModel> genericTypes;
        private static Dictionary<string, string> imports;
        private static bool inSWF;
        private static Dictionary<string, DocItem> thisDocs;
        private static string docPath;

        /// <summary>
        /// Extract documentation from XML included in ASDocs-enriched SWCs
        /// </summary>
        /// <param name="rawDocs"></param>
        private static void ParseDocumentation(ContentParser parser)
        {
            if (parser.Catalog != null)
            {
                MxmlFilter.AddCatalog(parser.Filename, parser.Catalog);
            }

            if (parser.Docs.Count > 0)
            foreach (string docFile in parser.Docs.Keys)
            {
                if (docFile.EndsWith(".dita.xml"))
                    continue;
                try
                {
                    Match m = reDocFile.Match(docFile);
                    if (!m.Success) continue;
                    string package = m.Groups[1].Value;
                    Dictionary<string, DocItem> packageDocs = Docs.ContainsKey(package)
                        ? Docs[package]
                        : new Dictionary<string, DocItem>();

                    byte[] rawDoc = parser.Docs[docFile];
                    DocsReader dr = new DocsReader(rawDoc);
                    dr.Parse(packageDocs);

                    Docs[package] = packageDocs;
                }
                catch (Exception)
                {
                }
            }
        }

        /// <summary>
        /// Create virtual FileModel objects from Abc bytecode
        /// </summary>
        /// <param name="abcs"></param>
        /// <param name="path"></param>
        /// <param name="context"></param>
        public static void Convert(ContentParser parser, PathModel path, IASContext context)
        {
            path.Files.Clear();
            inSWF = Path.GetExtension(path.Path).ToLower() == ".swf";

            // extract documentation
            ParseDocumentation(parser);

            // extract models
            FileModel privateClasses = new FileModel(Path.Combine(path.Path, "__Private.as"));
            privateClasses.Version = 3;
            privateClasses.Package = "private";
            genericTypes = new Dictionary<string, FileModel>();
            imports = new Dictionary<string, string>();

            foreach (Abc abc in parser.Abcs)
            {
                // types
                foreach (Traits trait in abc.classes)
                {
                    Traits instance = trait.itraits;
                    if (instance == null)
                        continue;
                    imports.Clear();

                    FileModel model = new FileModel("");
                    model.Context = context;
                    model.Package = reSafeChars.Replace(instance.name.uri, "_");
                    model.HasPackage = true;
                    string filename = reSafeChars.Replace(trait.name.ToString(), "_").TrimEnd('$');
                    filename = Path.Combine(model.Package.Replace('.', Path.DirectorySeparatorChar), filename);
                    model.FileName = Path.Combine(path.Path, filename);
                    model.Version = 3;

                    ClassModel type = new ClassModel();
                    model.Classes = new List<ClassModel>();
                    model.Classes.Add(type);
                    type.InFile = model;

                    type.Type = instance.name.ToTypeString();
                    type.Name = instance.name.localName;

                    thisDocs = GetDocs(model.Package);
                    if (thisDocs != null)
                    {
                        docPath = (model.Package.Length > 0 ? model.Package + ":" : "globalClassifier:") + type.Name;
                        if (thisDocs.ContainsKey(docPath))
                        {
                            DocItem doc = thisDocs[docPath];
                            type.Comments = doc.LongDesc;
                            model.MetaDatas = doc.Meta;
                        }
                        if (model.Package.Length == 0) docPath = type.Name;
                    }

                    if (instance.baseName.uri == model.Package)
                        type.ExtendsType = ImportType(instance.baseName.localName);
                    else type.ExtendsType = ImportType(instance.baseName);

                    if (instance.interfaces != null && instance.interfaces.Length > 0)
                    {
                        type.Implements = new List<string>();
                        foreach (QName name in instance.interfaces)
                            type.Implements.Add(ImportType(name));
                    }

                    if (model.Package == "private")
                    {
                        model.Package = "";
                        type.Access = Visibility.Private;
                        type.Namespace = "private";
                    }
                    else if (model.Package == "__AS3__.vec")
                    {
                        model.Package = "";
                        type.Access = Visibility.Private;
                        type.Namespace = "private";
                        string genType = type.Name;
                        if (type.Name.IndexOf("$") > 0)
                        {
                            string[] itype = type.Name.Split('$');
                            genType = itype[0];
                            type.Name = itype[0] + "$" + itype[1];
                            type.IndexType = itype[1];
                        }
                        if (genericTypes.ContainsKey(genType))
                        {
                            model.Classes.Clear();
                            type.InFile = genericTypes[genType];
                            genericTypes[genType].Classes.Add(type);
                        }
                        else genericTypes[genType] = model;
                    }
                    else if (type.Name.StartsWith("_"))
                    {
                        type.Access = Visibility.Private;
                        type.Namespace = "private";
                    }
                    else
                    {
                        type.Access = Visibility.Public;
                        type.Namespace = "public";
                    }

                    type.Flags = FlagType.Class;
                    if (instance.flags == TraitMember.Function) type.Flags |= FlagType.Interface;

                    type.Members = GetMembers(trait.members, FlagType.Static, instance.name);
                    type.Members.Add(GetMembers(instance.members, FlagType.Dynamic, instance.name));

                    if ((type.Flags & FlagType.Interface) > 0)
                    {
                        // TODO properly support interface multiple inheritance
                        type.ExtendsType = null;
                        if (type.Implements != null && type.Implements.Count > 0)
                        {
                            type.ExtendsType = type.Implements[0];
                            type.Implements.RemoveAt(0);
                            if (type.Implements.Count == 0) type.Implements = null;
                        }

                        foreach (MemberModel member in type.Members)
                        {
                            member.Access = Visibility.Public;
                            member.Namespace = "";
                        }
                    }

                    // constructor
                    if (instance.init != null && type.Flags != FlagType.Interface)
                    {
                        List<MemberInfo> temp = new List<MemberInfo>(new MemberInfo[] { instance.init });
                        MemberList result = GetMembers(temp, 0, instance.name);
                        if (result.Count > 0)
                        {
                            MemberModel ctor = result[0];
                            ctor.Flags |= FlagType.Constructor;
                            ctor.Access = Visibility.Public;
                            ctor.Type = type.Type;
                            ctor.Namespace = "public";
                            type.Members.Merge(result);
                            type.Constructor = ctor.Name;
                        }
                        result = null;
                        temp = null;
                    }
                    else type.Constructor = type.Name;

                    if (type.Access == Visibility.Private)
                    {
                        model = privateClasses;
                        type.InFile = model;
                    }

                    if (model.Classes.Count > 0 || model.Members.Count > 0)
                    {
                        AddImports(model, imports);
                        path.AddFile(model);
                    }
                }

                // packages
                if (abc.scripts == null) 
                    continue;
                foreach (Traits trait in abc.scripts)
                {
                    FileModel model = null;
                    foreach (MemberInfo info in trait.members)
                    {
                        if (info.kind == TraitMember.Class) 
                            continue;

                        MemberModel member = GetMember(info, 0);
                        if (member == null) continue;

                        if (model == null || model.Package != info.name.uri)
                        {
                            AddImports(model, imports);
                            
                            string package = info.name.uri ?? "";
                            string filename = package.Length > 0 ? "package.as" : "toplevel.as";
                            filename = Path.Combine(package.Replace('.', Path.DirectorySeparatorChar), filename);
                            filename = Path.Combine(path.Path, filename);
                            if (path.HasFile(filename)) 
                                model = path.GetFile(filename);
                            else
                            {
                                model = new FileModel("");
                                model.Context = context;
                                model.Package = package;
                                model.HasPackage = true;
                                model.FileName = filename;
                                model.Version = 3;
                                path.AddFile(model);
                            }
                        }

                        thisDocs = GetDocs(model.Package);
                        if (thisDocs != null)
                        {
                            docPath = "globalOperation:" + (model.Package.Length > 0 ? model.Package + ":" : "") 
                                + member.Name;
                            if (member.Access == Visibility.Public && !String.IsNullOrEmpty(member.Namespace)
                                && member.Namespace != "public")
                                docPath += member.Namespace + ":";
                            if ((member.Flags & FlagType.Setter) > 0) docPath += ":set";
                            else if ((member.Flags & FlagType.Getter) > 0) docPath += ":get";

                            if (thisDocs.ContainsKey(docPath))
                            {
                                DocItem doc = thisDocs[docPath];
                                member.Comments = doc.LongDesc;
                            }
                        }

                        member.InFile = model;
                        member.IsPackageLevel = true;
                        model.Members.Add(member);
                    }

                    AddImports(model, imports);
                }
            }

            if (privateClasses.Classes.Count > 0) path.AddFile(privateClasses);

            // some SWCs need manual fixes
            CustomFixes(path);
        }

        private static void CustomFixes(PathModel path)
        {
            string file = Path.GetFileName(path.Path);
            if (file == "playerglobal.swc" || file == "airglobal.swc")
            {
                string mathPath = Path.Combine(path.Path, "Math").ToUpper();
                if (path.HasFile(mathPath))
                {
                    ClassModel mathModel = path.GetFile(mathPath).GetPublicClass();
                    foreach(MemberModel member in mathModel.Members)
                    {
                        if (member.Parameters != null && member.Parameters.Count > 0 && member.Parameters[0].Name == "x")
                        {
                            string n = member.Name;
                            if (member.Parameters.Count > 1)
                            {
                                if (n == "atan2") member.Parameters.Reverse();
                                else if (n == "min" || n == "max") { member.Parameters[0].Name = "val1"; member.Parameters[1].Name = "val2"; }
                                else if (n == "pow") { member.Parameters[0].Name = "base"; member.Parameters[1].Name = "pow"; }
                            }
                            else if (n == "sin" || n == "cos" || n == "tan") member.Parameters[0].Name = "angleRadians";
                            else member.Parameters[0].Name = "val";
                        }
                    }
                }
            }
        }

        private static void AddImports(FileModel model, Dictionary<string, string> imports)
        {
            if (model != null)
            {
                foreach (string import in imports.Keys)
                {
                    model.Imports.Add(new MemberModel(imports[import], import, FlagType.Import, 0));
                }
                imports.Clear();
            }
        }

        private static Dictionary<string, DocItem> GetDocs(string package)
        {
            string docPackage = package == "" ? "__Global__" : package;
            if (Docs.ContainsKey(docPackage)) return Docs[docPackage];
            else return null;
        }

        private static MemberList GetMembers(List<MemberInfo> abcMembers, FlagType baseFlags, QName instName)
        {
            MemberList list = new MemberList();
            string package = instName.uri;
            string protect = instName.ToString();

            foreach (MemberInfo info in abcMembers)
            {
                MemberModel member = GetMember(info, baseFlags);
                if (member == null) continue;
                
                string uri = info.name.uri ?? "";
                if (uri.Length > 0)
                {
                    if (uri == "private" || package == "private")
                        continue;
                    else if (uri == protect)
                    {
                        member.Access = Visibility.Protected;
                        member.Namespace = "protected";
                    }
                    else if (uri == package)
                    {
                        member.Access = Visibility.Internal;
                        member.Namespace = "internal";
                    }
                    else if (uri == "http://adobe.com/AS3/2006/builtin")
                    {
                        member.Access = Visibility.Public;
                        member.Namespace = "AS3";
                    }
                    else if (uri == "http://www.adobe.com/2006/flex/mx/internal")
                        continue;
                    else if (uri == "http://www.adobe.com/2006/actionscript/flash/proxy")
                    {
                        member.Access = Visibility.Public;
                        member.Namespace = "flash_proxy";
                    }
                    else if (uri == "http://www.adobe.com/2006/actionscript/flash/objectproxy")
                    {
                        member.Access = Visibility.Public;
                        member.Namespace = "object_proxy";
                    }
                    else // unknown namespace
                    {
                        member.Access = Visibility.Public;
                        member.Namespace = "internal";
                    }
                }
                
                if (thisDocs != null) GetMemberDoc(member);

                list.Add(member);
            }
            return list;
        }

        private static MemberModel GetMember(MemberInfo info, FlagType baseFlags)
        {
            MemberModel member = new MemberModel();
            member.Name = info.name.localName;
            member.Flags = baseFlags;
            member.Access = Visibility.Public;
            member.Namespace = "public";

            if (info is SlotInfo)
            {
                SlotInfo slot = info as SlotInfo;
                member.Flags |= FlagType.Variable;
                if (slot.kind == TraitMember.Const) member.Flags |= FlagType.Constant;
                if (slot.value is Namespace)
                {
                    member.Flags |= FlagType.Namespace;
                    member.Value = '"' + (slot.value as Namespace).uri + '"';
                }
                member.Type = ImportType(slot.type);
            }

            else if (info is MethodInfo)
            {
                switch (info.kind)
                {
                    case TraitMember.Setter: member.Flags |= FlagType.Setter; break;
                    case TraitMember.Getter: member.Flags |= FlagType.Getter; break;
                    default: member.Flags |= FlagType.Function; break;
                }
                MethodInfo method = info as MethodInfo;
                QName type = method.returnType;
                member.Type = ImportType(type);

                member.Parameters = new List<MemberModel>();
                int n = method.paramTypes.Length;
                int defaultValues = (method.optionalValues != null) ? n - method.optionalValues.Length : n;
                for (int i = 0; i < n; i++)
                {
                    MemberModel param = new MemberModel();
                    param.Name = (!inSWF && method.paramNames != null) ? method.paramNames[i] : "param" + i;
                    type = method.paramTypes[i];
                    param.Type = ImportType(type);

                    if (param.Name[0] == '.' && param.Type == "Array") // ...rest
                    {
                        param.Type = "";
                    }
                    else if (i >= defaultValues)
                    {
                        SetDefaultValue(param, method.optionalValues[i - defaultValues]);
                    }
                    member.Parameters.Add(param);
                }
            }
            else return null;
            return member;
        }

        private static void GetMemberDoc(MemberModel member)
        {
            string dPath = docPath + ":";
            if (member.Access == Visibility.Public && !String.IsNullOrEmpty(member.Namespace)
                && member.Namespace != "public")
                dPath += member.Namespace + ":";
            dPath += member.Name;
            if ((member.Flags & FlagType.Getter) > 0) dPath += ":get";
            else if ((member.Flags & FlagType.Setter) > 0) dPath += ":set";
            if (thisDocs.ContainsKey(dPath))
            {
                DocItem doc = thisDocs[dPath];
                member.Comments = doc.LongDesc;
                if (doc.Value != null) member.Value = doc.Value;
            }
        }

        private static string ImportType(QName type)
        {
            if (type == null) return "*";
            else return ImportType(type.ToTypeString());
        }

        private static string ImportType(string qname)
        {
            if (qname == null) return "*";
            int p = qname.LastIndexOf('.');
            int q = qname.LastIndexOf('<');
            if (q > 0)
            {
                p = qname.IndexOf('>', q);
                if (p <= q) return qname;
                else
                    return qname.Substring(0, q + 1) + ImportType(qname.Substring(q + 1, p - q - 1)) + qname.Substring(p);
            }
            if (p < 0) return qname;
            if (imports.ContainsKey(qname)) return imports[qname];
            string cname = qname.Substring(p + 1);
            imports[qname] = cname;
            return cname;
        }

        private static void SetDefaultValue(MemberModel member, object value)
        {
            if (value == null) member.Value = "null";
            else if (value is string && value.ToString() != "undefined") member.Value = '"' + value.ToString() + '"';
            else if (value is bool) member.Value = value.ToString().ToLower();
            else if (value is double) member.Value = ((double)value).ToString(CultureInfo.InvariantCulture.NumberFormat);
            else member.Value = value.ToString();
        }
    }

    #endregion

    #region Documentation parser

    class DocsReader : XmlTextReader
    {
        private Dictionary<string, DocItem> docs;

        public DocsReader(byte[] raw)
            : base(new MemoryStream(raw))
        {
            WhitespaceHandling = WhitespaceHandling.None;
        }

        public void Parse(Dictionary<string, DocItem> packageDocs)
        {
            docs = packageDocs;

            DocItem doc = new DocItem();
            MoveToContent();
            while (Read())
                ProcessDeclarationNodes(doc);

            docs = null;
        }

        private void ReadDeclaration()
        {
            if (IsEmptyElement)
                return;

            DocItem doc = new DocItem();
            string id = GetAttribute("id");

            string eon = Name;
            ReadStartElement();
            while (Name != eon)
            {
                ProcessDeclarationNodes(doc);
                Read();
            }

            if (id != null)
            {
                if (doc.LongDesc == null) doc.LongDesc = "";
                if (doc.ShortDesc == null) doc.ShortDesc = doc.LongDesc;
                else doc.LongDesc = doc.LongDesc.Trim();

                if (doc.Params != null)
                    foreach (string name in doc.Params.Keys)
                        doc.LongDesc += "\n\t @param\t" + name + "\t" + doc.Params[name];
                if (doc.Returns != null)
                    doc.LongDesc += "\n\t @returns\t" + doc.Returns;

                if (doc.ShortDesc != "" || doc.LongDesc != "")
                    docs[id] = doc;
            }
        }

        private void ProcessDeclarationNodes(DocItem doc)
        {
            if (NodeType != XmlNodeType.Element) return;
            switch (Name)
            {
                case "shortdesc": doc.ShortDesc = ReadValue(); break;
                case "apiDesc": doc.LongDesc = ReadValue(); break;
                case "apiData": doc.Value = ReadValue(); break;
                case "apiValueClassifier": if (ReadValue() == "String") doc.Value = '"' + doc.Value + '"'; break;
                case "style": ReadStyleMeta(doc); break;
                case "Exclude": ReadExcludeMeta(doc); break;
                case "adobeApiEvent": ReadEventMeta(doc); break;
                case "apiName": break; // TODO validate event name
                case "apiClassifier": 
                case "apiConstructor": 
                case "apiValue": 
                case "apiOperation": ReadDeclaration(); break;
                case "apiParam": ReadParamDesc(doc); break;
                case "apiReturn": ReadReturnsDesc(doc); break;
                case "apiInheritDoc": break; // TODO link inherited doc?

                case "apiConstructorDetail":
                case "apiClassifierDetail":
                case "apiOperationDetail":
                case "apiValueDetail": 
                case "apiDetail": 
                case "related-links": SkipContents(); break;

                case "prolog": SkipContents(); break; // TODO parse metadata

                default: 
                    Console.WriteLine("Unhandled node: " + Name); 
                    SkipContents(); 
                    break;
            }
        }

        private void SkipContents()
        {
            if (IsEmptyElement) return;

            string eon = Name;
            ReadStartElement();
            while (Name != eon)
                Read();
        }

        private void ReadReturnsDesc(DocItem doc)
        {
            if (IsEmptyElement) return;

            string eon = Name;
            ReadStartElement();
            while (Name != eon)
            {
                if (Name == "apiDesc")
                    doc.Returns = ReadValue();
                Read();
            }
        }

        private void ReadParamDesc(DocItem doc)
        {
            if (IsEmptyElement) return;

            string name = null;
            string desc = null;

            string eon = Name;
            ReadStartElement();
            while (Name != eon)
            {
                if (NodeType == XmlNodeType.Element)
                switch (Name)
                {
                    case "apiItemName": name = ReadValue(); break;
                    case "apiDesc": desc = ReadValue(); break;
                }
                Read();
            }

            if (name != null && desc != null) 
            {
                if (doc.Params == null) doc.Params = new Dictionary<string,string>();
                doc.Params[name] = desc;
            }
        }

        private void ReadExcludeMeta(DocItem doc)
        {
            if (!HasAttributes) return;

            ASMetaData meta = new ASMetaData("Style");
            meta.Kind = ASMetaKind.Exclude;
            string sKind = GetAttribute("kind");
            string sName = GetAttribute("name");

            if (doc.Meta == null) doc.Meta = new List<ASMetaData>();
            meta.Params = new Dictionary<string, string>();
            meta.Params["kind"] = sKind;
            meta.Params["name"] = sName;
            meta.RawParams = String.Format("kind=\"{0}\", name=\"{1}\"", sKind, sName);
            doc.Meta.Add(meta);
        }

        private void ReadStyleMeta(DocItem doc)
        {
            if (IsEmptyElement || !HasAttributes) return;
            
            ASMetaData meta = new ASMetaData("Style");
            meta.Kind = ASMetaKind.Style;
            meta.Comments = "";

            string sName = GetAttribute("name");
            string sType = GetAttribute("type");
            //string sInherit = GetAttribute("inherit");
            //string sFormat = GetAttribute("format");
            string sEnum = GetAttribute("enumeration");
            string sDefault = null;

            string eon = Name;
            ReadStartElement();
            while (Name != eon)
            {
                if (NodeType == XmlNodeType.Element)
                    switch (Name)
                    {
                        case "description": meta.Comments = ReadValue() ?? ""; break;
                        case "default": sDefault = ReadValue(); break;
                    }
                Read();
            }

            if (doc.Meta == null) doc.Meta = new List<ASMetaData>();
            if (sDefault != null) meta.Comments = meta.Comments.Trim() + "\n\t @default\t" + sDefault;
            meta.Params = new Dictionary<string, string>();
            meta.Params["name"] = sName;
            meta.Params["type"] = sType;
            meta.RawParams = String.Format("name=\"{0}\", type=\"{1}\"", sName, sType);
            if (sEnum != null)
            {
                meta.Params["enumeration"] = sEnum;
                meta.RawParams += ", enumeration=\"" + sEnum + "\"";
            }
            doc.Meta.Add(meta);
        }

        private void ReadEventMeta(DocItem doc)
        {
            if (IsEmptyElement) return;

            ASMetaData meta = new ASMetaData("Event");
            meta.Kind = ASMetaKind.Event;
            meta.Comments = "";
            string eName = null;
            string eType = null;
            string eFullType = null;
            
            string eon = Name;
            ReadStartElement();
            while (Name != eon)
            {
                if (NodeType == XmlNodeType.Element)
                switch (Name)
                {
                    case "shortdesc": meta.Comments = ReadValue() ?? ""; break;
                    case "apiDesc": if (meta.Comments == "") meta.Comments = ReadValue() ?? ""; break;
                    case "apiName": eName = ReadValue(); break;
                    case "adobeApiEventClassifier": eType = ReadValue().Replace(':', '.'); break;
                    case "apiEventType": eFullType = ReadValue(); break;
                }
                Read();
            }

            if (doc.Meta == null) doc.Meta = new List<ASMetaData>();
            meta.Params = new Dictionary<string, string>();
            meta.Params["name"] = eName;
            meta.Params["type"] = eType;
            if (eFullType != null)
                meta.Comments = meta.Comments.Trim() + "\n\t @eventType\t" + eFullType.Replace(':', '.');
            meta.RawParams = String.Format("name=\"{0}\", type=\"{1}\"", eName, eType);
            doc.Meta.Add(meta);
        }

        private string ReadValue()
        {
            if (IsEmptyElement)
            {
                string see = GetAttribute("conref");
                if (see != null) return "@see " + see;
                return "";
            }

            string desc = "";

            string eon = Name;
            ReadStartElement();
            while (Name != eon)
            {
                switch (NodeType)
                {
                    case XmlNodeType.Element: ReadStartElement(); break;
                    case XmlNodeType.EndElement: ReadEndElement(); break;
                    case XmlNodeType.Text: desc += ReadString(); break;
                }
            }
            return desc;
        }
    }

    public class DocItem
    {
        public string ShortDesc;
        public string LongDesc;
        public List<ASMetaData> Meta;
        public Dictionary<string, string> Params;
        public string Returns;
        public string Value;
    }

    #endregion
}
