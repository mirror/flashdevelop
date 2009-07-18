using System;
using System.Collections.Generic;
using System.Text;
using ASCompletion.Model;
using SwfOp.Data;
using System.IO;

namespace AS3Context
{
    public class AbcConverter
    {
        private static Dictionary<string, FileModel> genericTypes;
        private static Dictionary<string, string> imports;
        private static bool inSWF;

        /// <summary>
        /// Create virtual FileModel objects from Abc bytecode
        /// </summary>
        /// <param name="abcs"></param>
        /// <param name="path"></param>
        /// <param name="context"></param>
        public static void Convert(List<Abc> abcs, PathModel path, Context context)
        {
            path.Files.Clear();
            inSWF = Path.GetExtension(path.Path).ToLower() == ".swf";

            FileModel privateClasses = new FileModel(Path.Combine(path.Path, "__Private.as"));
            privateClasses.Version = 3;
            privateClasses.Package = "private";
            genericTypes = new Dictionary<string, FileModel>();
            imports = new Dictionary<string, string>();

            foreach (Abc abc in abcs)
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
                    model.Package = instance.name.uri;
                    string filename = Path.Combine(model.Package.Replace('.', Path.DirectorySeparatorChar), trait.name + ".as");
                    model.FileName = Path.Combine(path.Path, filename);
                    model.Version = 3;

                    ClassModel type = new ClassModel();
                    model.Classes = new List<ClassModel>();
                    model.Classes.Add(type);
                    type.InFile = model;

                    type.Type = instance.name.ToTypeString();
                    type.Name = instance.name.localName;
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

                    type.Flags = (instance.flags == TraitMember.Function) ? FlagType.Interface : FlagType.Class;

                    type.Members = GetMembers(trait.members, FlagType.Static, instance.name);
                    type.Members.Add(GetMembers(instance.members, FlagType.Dynamic, instance.name));

                    if (type.Flags == FlagType.Interface)
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
                    if (model.Classes.Count > 0)
                    {
                        path.AddFile(model);

                        foreach (string import in imports.Keys)
                        {
                            model.Imports.Add(new MemberModel(imports[import], import, FlagType.Import, 0));
                        }
                    }
                }

                // packages
                if (abc.scripts == null) continue;
                foreach (Traits trait in abc.scripts)
                {
                    FileModel model = null;
                    foreach (MemberInfo info in trait.members)
                    {
                        if (info.kind == TraitMember.Class) 
                            continue;

                        MemberModel member = GetMember(info, 0);
                        if (member == null) continue;

                        if (model == null)
                        {
                            imports.Clear();
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
                                model.FileName = filename;
                                model.Version = 3;
                                path.AddFile(model);
                            }
                        }
                        else if (info.name.uri != model.Package)
                            continue;

                        member.InFile = model;
                        member.IsPackageLevel = true;
                        model.Members.Add(member);
                    }

                    if (model != null)
                    {
                        foreach (string import in imports.Keys)
                        {
                            model.Imports.Add(new MemberModel(imports[import], import, FlagType.Import, 0));
                        }
                    }
                }
            }

            if (privateClasses.Classes.Count > 0) path.AddFile(privateClasses);
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
                    if (uri == "private") 
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
                    else
                    {
                        // builtin, flash10 namespaces
                        member.Access = Visibility.Public;
                        member.Namespace = "public";
                    }
                }
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
            else member.Value = value.ToString();
        }
    }
}
