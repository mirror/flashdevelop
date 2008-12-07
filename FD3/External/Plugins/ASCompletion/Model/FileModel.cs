using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.IO;
using ASCompletion.Context;
using System.Text.RegularExpressions;

namespace ASCompletion.Model
{
    public class InlineRange
    {
        public string Syntax;
        public int Start;
        public int End;

        public InlineRange()
        { }

        public InlineRange(string syntax, int start, int end)
        {
            Syntax = syntax;
            Start = start;
            End = end;
        }
    }

    public class ASMetaData: IComparable
    {
        static private Regex reNameTypeParams = new Regex("name\\s*=\\s*\"(?<name>[^\"]+)\"\\s*,\\s*type\\s*=\\s*\"(?<type>[^\"]+)\"", RegexOptions.Compiled);

        public int LineFrom;
        public int LineTo;
        public string Name;
        public Dictionary<string, string> Params;
        public string RawParams;

        public ASMetaData(string name)
        {
            Name = name;
        }

        internal void ParseParams(string raw)
        {
            RawParams = raw;
            Params = new Dictionary<string, string>();
            if (Name == "Event" || Name == "Style")
            {
                Match mParams = reNameTypeParams.Match(raw);
                if (mParams.Success)
                {
                    Params.Add("name", mParams.Groups["name"].Value);
                    Params.Add("type", mParams.Groups["type"].Value);
                }
            }
        }

        public int CompareTo(object obj)
        {
            if (!(obj is ASMetaData))
                throw new InvalidCastException("This object is not of type ASMetaData");
            if (Name == "Event" && Params != null && Params.Count > 0)
                return Params["type"].CompareTo((obj as ASMetaData).Params["type"]);
            return Name.CompareTo((obj as ASMetaData).Name);
        }
    }

    public class FileModel
    {
        static public FileModel Ignore = new FileModel();

        public System.Windows.Forms.TreeState OutlineState;

        public IASContext Context;

        public bool OutOfDate;
        public DateTime LastWriteTime;
        public bool CachedModel;

        public bool HasFiltering;
        public string InlinedIn;
        public List<InlineRange> InlinedRanges;

        public bool haXe;
        public int Version;
        public string Comments;
        public string FileName;
        public string Package;
        public bool TryAsPackage;
        public int PrivateSectionIndex;
        public Dictionary<string,Visibility> Namespaces;
        public MemberList Imports;
        public List<ClassModel> Classes;
        public MemberList Members;
        public MemberList Regions;
        public List<ASMetaData> MetaDatas;

        public string BasePath
        {
            get
            {
                if (!File.Exists(FileName)) return FileName;
                string path = Path.GetDirectoryName(FileName);
                if (path.EndsWith(Package.Replace('.', Path.DirectorySeparatorChar), StringComparison.OrdinalIgnoreCase))
                    return path.Substring(0, path.Length - Package.Length);
                return path;
            }
        }

        public FileModel()
        {
            init("");
        }

        public FileModel(string fileName)
        {
            init(fileName);
        }
        public FileModel(string fileName, DateTime cacheLastWriteTime)
        {
            init(fileName);
            LastWriteTime = cacheLastWriteTime;
        }
        private void init(string fileName)
        {
            Package = "";
            FileName = fileName;
            haXe = (fileName.Length > 3) ? fileName.EndsWith(".hx") : false;
            //
            Namespaces = new Dictionary<string, Visibility>();
            //
            Imports = new MemberList();
            Classes = new List<ClassModel>();
            Members = new MemberList();
            Regions = new MemberList();
        }

        public string GetBasePath()
        {
            if (FileName.Length == 0) return null;
            
            string path = Path.GetDirectoryName(FileName);
            if (Package.Length == 0 && FileName.Length > 0) return path;

            // get up the packages path
            string packPath = Path.DirectorySeparatorChar+Package.Replace('.', Path.DirectorySeparatorChar);
            if (path.ToUpper().EndsWith(packPath.ToUpper()))
            {
                return path.Substring(0, path.Length - packPath.Length);
            }
            else
            {
                return null;
            }
        }

        public void Check()
        {
            if (this == FileModel.Ignore) return;

            if (OutOfDate)
            {
                OutOfDate = false;
                if (File.Exists(FileName) && (CachedModel || LastWriteTime < System.IO.File.GetLastWriteTime(FileName)))
                    try
                    {
                        ASFileParser.ParseFile(this);
                    }
                    catch
                    {
                        OutOfDate = false;
                        Imports.Clear();
                        Classes.Clear();
                        Members.Clear();
                        PrivateSectionIndex = 0;
                        Package = "";
                    }

            }
        }

        public ClassModel GetPublicClass()
        {
            if (Classes != null && Classes.Count > 0)
            {
                if (Version > 3) // haXe
                {
                    foreach (ClassModel model in Classes)
                        if ((model.Flags & (FlagType.Class | FlagType.Interface)) > 0) return model;
                }
                else return Classes[0];
            }
            return ClassModel.VoidClass;
        }

        public ClassModel GetClassByName(string name)
        {
            foreach (ClassModel aClass in Classes)
                if (aClass.Name == name) return aClass;
            return ClassModel.VoidClass;
        }

        /// <summary>
        /// Return a sorted list of the file
        /// </summary>
        /// <returns></returns>
        internal MemberList GetSortedMembersList()
        {
            MemberList items = new MemberList();
            items.Add(Members);
            items.Sort();
            return items;
        }

        #region Text output

        public override string ToString()
        {
            return String.Format("package {0} ({1})", Package, FileName);
        }

        public string GenerateIntrinsic(bool caching)
        {
            if (this == FileModel.Ignore) return "";

            StringBuilder sb = new StringBuilder();
            string nl = (caching) ? "" : "\r\n";
            char semi = ';';
            string tab = (caching) ? "" : "\t";

            // header
            if (Version > 2)
            {
                sb.Append("package");
                if (Package.Length > 0) sb.Append(" ").Append(Package);
                if (haXe) sb.Append(semi).Append(nl).Append(nl);
                else sb.Append(nl).Append("{").Append(nl);
            }

            // imports
            if (Imports.Count > 0)
            {
                foreach (MemberModel import in Imports)
                    sb.Append("import ").Append(import.Type).Append(semi).Append(nl);
                sb.Append(nl);
            }

            // event/style metadatas
            if (MetaDatas != null)
            {
                bool emptyMeta = true;
                foreach (ASMetaData meta in MetaDatas) if (meta.Name == "Event" || meta.Name == "Style")
                {
                    emptyMeta = false;
                    sb.Append('[').Append(meta.Name).Append('(').Append(meta.RawParams).Append(")] ").Append(nl);
                }
                if (!emptyMeta) sb.Append(nl);
            }

            // members			
            string decl;
            foreach (MemberModel member in Members)
            {
                if ((member.Flags & FlagType.Variable) > 0)
                {
                    sb.Append(ClassModel.CommentDeclaration(member.Comments, tab));
                    sb.Append(tab).Append(ClassModel.MemberDeclaration(member)).Append(semi).Append(nl);
                }
                else if ((member.Flags & FlagType.Function) > 0)
                {
                    decl = ClassModel.MemberDeclaration(member);
                    sb.Append(ClassModel.CommentDeclaration(member.Comments, tab));
                    sb.Append(tab).Append(decl).Append(semi).Append(nl);
                }
            }

            foreach (ClassModel aClass in Classes)
            {
                sb.Append(aClass.GenerateIntrinsic(caching));
                sb.Append(nl);
            }

            if (Version == 3) sb.Append('}').Append(nl);
            return sb.ToString();
        }
        #endregion
    }
}
