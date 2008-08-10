/*
 * Misc classes used by the plugin
 */

using System;
using System.Collections;
using System.Collections.Specialized;
using System.Text;
using PluginCore;

namespace ASCompletion
{
	#region FlagType enum
	[Flags]
	public enum FlagType: uint
	{
		Package = 1<<1,
		Import = 1<<2,
		Namespace = 1<<3,
		Enum = 1<<4,
		Class = 1<<5,
		Interface = 1<<6,
		Extends = 1<<7,
		Implements = 1<<8,

		Native = 1<<9,
		Intrinsic = 1<<10,
		Extern = 1<<11,
		Dynamic = 1<<12,
		Static = 1<<13,
		Override = 1<<17,

		Constant = 1<<18,
		Variable = 1<<19,
		Function = 1<<20,
		Getter = 1<<21,
		Setter = 1<<22,
		HXProperty = 1<<23,
		Constructor = 1<<24,
		
		Template = 1<<25,
		DocTemplate = 1<<26,
		CodeTemplate = 1<<27,
		
		Public = 1<<28,
		Protected = 1<<29,
		Private = 1<<30
	}
	#endregion
	
	#region PathModel class
	/// <summary>
	/// Files cache
	/// TODO  PathModel watchers & cleanup
	/// </summary>
	public class PathModel
	{
		//static private readonly bool cacheEnabled = false;
		static private ListDictionary pathes = new ListDictionary();
		static private PathModel orphans = new PathModel("");
		
		/// <summary>
		/// Retrieve a PathModel from the cache or create a new one
		/// </summary>
		/// <param name="path"></param>
		/// <returns></returns>
		static public PathModel GetModel(string path)
		{
			PathModel aPath = pathes[path.ToUpper()] as PathModel;
			if (aPath == null)
			{
				pathes[path.ToUpper()] = aPath = new PathModel(path);
			}
			aPath.Touch();
			return aPath;
		}
		
		/// <summary>
		/// Get a FileModel for a file
		/// </summary>
		/// <param name="fileName"></param>
		/// <returns></returns>
		static public FileModel FindFile(string fileName)
		{
			// the file is in a known classpath
			foreach(PathModel aPath in pathes.Values)
			{
				if (fileName.StartsWith(aPath.Path))
				{
					DebugConsole.Trace("File in: "+aPath.Path);
					return aPath.GetFile(fileName);
				}
			}
			// else, orphan file
			DebugConsole.Trace("File in: (orphan)");
			return orphans.GetFile(fileName);
		}
		
		static public string BuildLogFileName(PathModel aPath)
		{
			string clean = System.Text.RegularExpressions.Regex.Replace(aPath.Path, "[\\:]+", "")+".as";
			return ASContext.MainForm.LocalDataPath+clean;
		}
		
		public ListDictionary Files;
		public DateTime LastAccess;
		public string Path;
		//private System.IO.FileSystemWatcher watcher;
		public bool IsValid;
		
		public PathModel(string path)
		{
			Path = path;
			Files = new ListDictionary();
			if (Path.Length == 0 || (System.IO.Directory.Exists(Path) && Path.Length > 3))
			{
				IsValid = true;
				
				/*if (cacheEnabled && Path.Length > 3) 
				{
					DateTime dt = System.DateTime.Now;
					
					// cache file
					string log = BuildLogFileName(this);
					
					// already cached
					if (System.IO.File.Exists(log))
					{
						ASFileParser.ParseCacheFile(this, log);
					}
					// parse & cache
					else
					{
						explored = new ArrayList();
						ExploreFolder(path, "*.as");
					}
					ErrorHandler.ShowInfo("Path: "+Path+"\nFiles: "+Files.Count+"\nElapsed: "+(DateTime.Now-dt)+"ms");
				}*/
			}
		}

		public FileModel GetFile(string fileName)
		{
			if (!IsValid) return new FileModel(fileName);
			//
			FileModel aFile = Files[fileName.ToUpper()] as FileModel;
			if (aFile == null)
			{
				try
				{
					DebugConsole.Trace("Parse: "+fileName+"\nIn: "+Path);
					aFile = ASFileParser.ParseFile(fileName);
					DebugConsole.Trace("Version "+aFile.Version+" - "+aFile.Classes.Count+" classes");
					foreach(ClassModel aClass in aFile.Classes)
						DebugConsole.Trace(aClass.ClassName);
					Files[fileName.ToUpper()] = aFile;
				}
				catch(Exception ex)
				{
					ErrorHandler.ShowError("Error while parsing the file:\n"+fileName, ex);
				}
			}
			aFile.Check();
			return aFile;
		}
		
		public void AddFile(FileModel aFile)
		{
			if (!IsValid) return;
			//
			Files[aFile.FileName.ToUpper()] = aFile;
		}
		
		/// <summary>
		/// Retrieve a class from the cache
		/// </summary>
		/// <param name="package"></param>
		/// <param name="name"></param>
		/// <returns></returns>
		public ClassModel Resolve(string package, string name)
		{
			if (!IsValid) return ClassModel.VoidClass;
			//
			IDictionaryEnumerator eFiles = Files.GetEnumerator();
			FileModel aFile;
			while (eFiles.MoveNext())
			{
				aFile = eFiles.Value as FileModel;
				if (aFile.Package == package)
				{
					foreach(ClassModel aClass in aFile.Classes)
					{
						if (aClass.ClassName == name)
							return aClass;
					}
				}
			}
			return ClassModel.VoidClass;
		}
		
		public void Touch()
		{
			LastAccess = DateTime.Now;
		}
		
		/// <summary>
		/// Create cache file and clear all data
		/// </summary>
		public void Store()
		{
			IDictionaryEnumerator eFiles = Files.GetEnumerator();
			FileModel aFile;
			while (eFiles.MoveNext())
			{
				aFile = eFiles.Value as FileModel;
				//if (aFile.Version > 1)
				//{
					//sb.Append("#file-cache ").Append(aFile.FileName).Append('\n');
					//sb.Append( aFile.GenerateIntrinsic() );
				//}
			}
		}
	}
	#endregion
	
	#region FileModel class
	public class FileModel
	{
		public bool OutOfDate;
		public DateTime LastWriteTime;
		
		public bool haXe;
		public int Version;
		public string FileName;
		public string Package;
		public ArrayList Namespaces;
		public MemberList Imports;
		public ArrayList Enums;
		public ArrayList Classes;
		public MemberList Members;
		private bool doCheckFile;
		
		public FileModel(string fileName)
		{
			init(fileName);
		}
		public FileModel(string fileName, DateTime cacheLastWriteTime)
		{
			init(fileName);
			LastWriteTime = cacheLastWriteTime;
			doCheckFile = true;
		}
		private void init(string fileName)
		{
			FileName = fileName;
			Package = "";
			haXe = fileName.EndsWith(".hx");
			//
			Namespaces = new ArrayList();
			Namespaces.Add("public");
			Namespaces.Add("private");
			//
			Imports = new MemberList();
			if (haXe) Enums = new ArrayList();
			Classes = new ArrayList();
			Members = new MemberList();
		}
		
		public void Check()
		{
			if (OutOfDate || (doCheckFile && LastWriteTime < System.IO.File.GetLastWriteTime(FileName)) )
			{
				OutOfDate = false;
				doCheckFile = false;
				ASFileParser.ParseFile(this);
			}
		}
		
		public override string ToString()
		{
			return String.Format("package {0} ({1})", Package, FileName);
		}
		
		public ClassModel GetPublicClass()
		{
			if (Classes.Count > 0) return Classes[0] as ClassModel;
			else return ClassModel.VoidClass;
		}
		
		/// <summary>
		/// TODO  GenerateHaXe is far from complete
		/// </summary>
		/// <returns></returns>
		public string GenerateHaXeExtern()
		{
			if (!haXe)
			{
				int _version = Version;
				bool _haXe = haXe;
				ClassModel.haXeConversion = true;
				string res = GenerateIntrinsic();
				ClassModel.haXeConversion = false;
				haXe = _haXe;
				Version = _version;
				return res;
			}
			else return GenerateIntrinsic();
		}
		
		public string GenerateIntrinsic()
		{
			StringBuilder sb = new StringBuilder();
			string nl = "\r\n";
			char semi = ';';
			char tab = '\t';
			
			// header
			if (Version > 2)
			{
				sb.Append("package");
				if (Package.Length > 0) sb.Append(" ").Append(Package);
				if (haXe) sb.Append(semi).Append(nl).Append(nl);
				else sb.Append(nl).Append("{").Append(nl).Append(nl);
			}
			
			// imports
			if (Imports.Count > 0)
			{
				foreach(MemberModel import in Imports)
					sb.Append("import ").Append(import.Type).Append(semi).Append(nl);
				sb.Append(nl);
			}
			
			// members			
			string decl;
			foreach(MemberModel member in Members)
			{
				if ((member.Flags & FlagType.Variable) > 0)
				{
					sb.Append(ClassModel.CommentDeclaration(member.Comments, true));
					sb.Append(tab).Append(ClassModel.MemberDeclaration(member)).Append(semi).Append(nl);
					sb.Append(nl);
				}
				else if ((member.Flags & FlagType.Function) > 0)
				{
					decl = ClassModel.MemberDeclaration(member);
					if ( (member.Flags & FlagType.Constructor) > 0 ) decl = decl.Replace(" : constructor", "");
					sb.Append(ClassModel.CommentDeclaration(member.Comments, true));
					sb.Append(tab).Append(decl).Append(semi).Append(nl).Append(nl);
					sb.Append(nl);
				}
			}
			
			foreach(ClassModel aClass in Classes)
			{
				sb.Append(aClass.GenerateIntrinsic());
				sb.Append(nl).Append(nl);
			}
			
			if (Version == 3) sb.Append('}');
			return sb.ToString();
		}
	}
	#endregion
	
	/// <summary>
	/// Object representation of an Actionscript class
	/// </summary>
	sealed public class ClassModel
	{
		static public ClassModel VoidClass;
		
		static ClassModel()
		{
			 VoidClass = new ClassModel();
			 VoidClass.ClassName = "Void";
			 VoidClass.InFile = new FileModel("");
		}
		
		#region actionscript class instance
		public FlagType Flags;
		public string Namespace;
		public FileModel InFile;
		public string ClassName;
		public string Constructor;
		public MemberList Members;
		//public MemberList Methods;
		//public MemberList Vars;
		//public MemberList Properties;
		//public MemberList Constants;
		public MemberList Package;
		public string BasePath;
		private ClassModel extends;
		public ArrayList Implements;
		public string Comments;
		public int LineFrom;
		public int LineTo;
		
		public ClassModel Extends
		{
			get {
				//if (extends == null) 
				return VoidClass;
				//else return ASFileParser.Context.GetCachedClass(extends);
			}
			set {
				extends = value;
			}
		}
		
		public ClassModel() 
		{
			ClassName = null;
			Members = new MemberList();
			//Methods = new MemberList();
			//Vars = new MemberList();
			//Properties = new MemberList();
		}
		
		public bool IsVoid()
		{
			return this == VoidClass;
		}
		
		public override string ToString()
		{
			return ClassDeclaration(this);
		}
		
		public MemberModel ToMemberModel()
		{
			MemberModel self = new MemberModel();
			int p = ClassName.LastIndexOf(".");
			self.Name = (p >= 0) ? ClassName.Substring(p+1) : ClassName;
			self.Type = ClassName;
			self.Flags = Flags;
			return self;
		}
		
		public string GenerateIntrinsic()
		{
			StringBuilder sb = new StringBuilder();
			string nl = "\r\n";
			char semi = ';';
			char tab = '\t';
			
			// IMPORTS
			// TODO  Imports are now in the FileModel
			//foreach(MemberModel import in Imports)
			//	sb.Append("import ").Append(import.Type).Append(semi).Append(nl);
			
			// CLASS
			sb.Append(CommentDeclaration(Comments, false));
			if ((this.Flags & (FlagType.Intrinsic | FlagType.Interface)) == 0) 
			{
				sb.Append((InFile.haXe) ? "extern " : "intrinsic ");
			}
			sb.Append(ClassDeclaration(this));
			
			if (extends != null && !extends.IsVoid() && (extends.ClassName != "Object"))
			{
				sb.Append(" extends ").Append(extends.ClassName);
			}
			if (Implements != null)
			{
				sb.Append(" implements ");
				bool addSep = false;
				foreach(ClassModel impClass in Implements)
				{
					if (addSep) sb.Append(", ");
					else addSep = true;
					sb.Append(impClass.ClassName);
				}
			}
			sb.Append(nl).Append('{').Append(nl).Append(nl);
			
			// MEMBERS
			int count = 0;
			foreach(MemberModel var in Members)
			if ((var.Flags & FlagType.Variable) > 0)
			{
				sb.Append(CommentDeclaration(var.Comments, true));
				sb.Append(tab).Append(MemberDeclaration(var)).Append(semi).Append(nl);
				count ++;
			}
			if (count > 0) sb.Append(nl);
			
			// MEMBERS
			string decl;
			MemberModel temp;
			foreach(MemberModel property in Members)
			if ((property.Flags & (FlagType.Getter|FlagType.Setter)) > 0)
			{
				sb.Append(CommentDeclaration(property.Comments, true));
				FlagType flags = (property.Flags & ~(FlagType.Setter | FlagType.Getter)) | FlagType.Function;
				
				if ( (property.Flags & FlagType.Getter) > 0 )
				{
					temp = (MemberModel)property.Clone();
					temp.Name = "get "+temp.Name;
					temp.Flags = flags;
					temp.Parameters = null;
					sb.Append(tab).Append(MemberDeclaration(temp)).Append(semi).Append(nl);
				}
				if ( (property.Flags & FlagType.Setter) > 0 )
				{
					temp = (MemberModel)property.Clone();
					temp.Name = "set "+temp.Name;
					temp.Flags = flags;
					temp.Type = "Void";
					sb.Append(tab).Append(MemberDeclaration(temp)).Append(semi).Append(nl);
				}
				sb.Append(nl);
			}
			
			// MEMBERS
			foreach(MemberModel method in Members)
			if ((method.Flags & FlagType.Function) > 0)
			{
				decl = MemberDeclaration(method);
				if ( (method.Flags & FlagType.Constructor) > 0 ) decl = decl.Replace(" : constructor", "");
				sb.Append(CommentDeclaration(method.Comments, true));
				sb.Append(tab).Append(decl).Append(semi).Append(nl).Append(nl);
			}
						
			// END CLASS
			sb.Append('}');
			return sb.ToString();
		}
		
		public void Sort()
		{
			//Methods.Sort();
			//Vars.Sort();
			//Properties.Sort();
		}
		
		public override bool Equals(object obj)
		{
			if (!(obj is ClassModel)) return false;
			return ClassName.Equals( ((ClassModel)obj).ClassName );
		}
		public override int GetHashCode()
		{
			return ClassName.GetHashCode();
		}
		#endregion
		
		#region actionscript declaration generation
		static internal bool haXeConversion;
		
		static public string ClassDeclaration(ClassModel ofClass)
		{
			// package
			if (ofClass.Flags == FlagType.Package)
			{
				return "package "+ofClass.ClassName.Replace('\\', '.');
			}
			else
			{
				// modifiers
				string modifiers = ofClass.Namespace+" ";
				if ((ofClass.Flags & FlagType.Intrinsic) > 0)
				{
					if (haXeConversion || (ofClass.Flags & FlagType.Extern) > 0) modifiers += "extern ";
					else modifiers += "intrinsic ";
				}
				if ((ofClass.Flags & FlagType.Dynamic) > 0)
					modifiers += "dynamic ";
				
				string classType = "class";
				if ((ofClass.Flags & FlagType.Interface) > 0) classType = "interface";
				else if ((ofClass.Flags & FlagType.Enum) > 0) classType = "enum";
				// signature
				return String.Format("{0}{1} {2}", modifiers, classType, ofClass.ClassName);
			}
		}
		
		static public string MemberDeclaration(MemberModel member)
		{
			// modifiers
			FlagType ft = member.Flags;
			string modifiers = member.Namespace+" ";
			if ((ft & FlagType.Intrinsic) > 0)
			{
				if (haXeConversion || (ft & FlagType.Extern) > 0) modifiers += "extern ";
				else modifiers += "intrinsic ";
			}
			if ((ft & FlagType.Class) > 0)
			{
				if ((ft & FlagType.Dynamic) > 0)
					modifiers += "dynamic ";
				string classType = "class";
				if ((member.Flags & FlagType.Interface) > 0) classType = "interface";
				else if ((member.Flags & FlagType.Enum) > 0) classType = "enum";
				return String.Format("{0}{1} {2}", modifiers, classType, member.Type);
			}
			else if ((ft & FlagType.Enum) == 0)
			{
				if ((ft & FlagType.Native) > 0)
					modifiers += "native ";
				if ((ft & FlagType.Static) > 0)
					modifiers += "static ";
			}
			// signature
			if ((ft & FlagType.Enum) > 0)
				return member.ToString();
			else if ((ft & FlagType.Function) > 0)
			{
				if ((ft & FlagType.HXProperty) > 0)
					return String.Format("{0}property {1}", modifiers, member.ToString());
				else
					return String.Format("{0}function {1}", modifiers, member.ToString());
			}
			else if ((ft & FlagType.Variable) > 0)
			{
				if (modifiers.Length == 0) modifiers = "local ";
				if (!haXeConversion && (ft & FlagType.Constant) > 0)
					return String.Format("{0}const {1}", modifiers, member.ToString());
				else return String.Format("{0}var {1}", modifiers, member.ToString());
			}
			else if ((ft & (FlagType.Getter | FlagType.Setter)) > 0)
				return String.Format("{0}property {1}", modifiers, member.ToString());
			else if ((ft & FlagType.Template) > 0)
				return String.Format("Template {0}", member.Type);
			else if (ft == FlagType.Package)
				return String.Format("Package {0}", member.Type);
			else 
			{
				if ((ft & FlagType.Intrinsic) > 0) modifiers = "intrinsic "+modifiers;
				return String.Format("{0}type {1}", modifiers, member.Type);
			}
		}
		
		static public string CommentDeclaration(string comment, bool indent)
		{
			if (comment == null) return "";
			if (indent) return "\t/**\n\t"+comment+"\n\t*/\n";
			else return "/**\n"+comment+"\n*/\n";
		}
		#endregion
	}
	
	#region class_members
	/// <summary>
	/// Object representation of an Actionscript MemberModel
	/// </summary>
	sealed public class MemberModel: ICloneable, IComparable
	{
		public FlagType Flags;
		public string Namespace;
		public string Name;
		public ArrayList Parameters;
		public string Type;
		public string Comments;
		public int LineFrom;
		public int LineTo;
		
		/// <summary>
		/// Clone member - WARNING: doesn't clone parameters!
		/// </summary>
		public Object Clone()
		{
			MemberModel copy = new MemberModel();
			copy.Name = Name;
			copy.Flags = Flags;
			copy.Namespace = Namespace;
			copy.Parameters = Parameters;
			copy.Type = Type;
			copy.Comments = Comments;
			return copy;
		}
		
		public override string ToString()
		{
			string res = Name;
			if ((Flags & FlagType.Function) > 0) 
			{
				res += " (";
				if (Parameters != null && Parameters.Count > 0)
				{
					bool addSep = false;
					foreach(MemberModel param in Parameters)
					{
						if (addSep) res += ", ";
						else addSep = true;
						res += param.Name;
						if (param.Type != null && param.Type.Length > 0)
							res += ":"+param.Type;
						if (param.Parameters != null && param.Parameters.Count > 0)
							res += " = "+param.Parameters[0].ToString();
					}
				}
				res += ")";
			}
			if ((Flags & FlagType.Constructor) > 0)
				return res+" : constructor";
			else if (Type != null && Type.Length > 0)
				return res+" : "+Type;
			else
				return res;
		}
		
		public override bool Equals(object obj)
		{
			if (!(obj is MemberModel)) 
				return false;
			return Name.Equals( ((MemberModel)obj).Name );
		}
		
		public override int GetHashCode() 
		{
			return (Name+Flags).GetHashCode();
		}
		
		private string upperName;
		internal string UpperName
		{
			get {
				if (upperName == null) upperName = Name.ToUpper();
				return upperName;
			}
		}
		public int CompareTo(object obj)
		{
			// using ascii comparison to be compatible with Scintilla completion list
			if (!(obj is MemberModel))
				throw new InvalidCastException("This object is not of type MemberModel");
			return string.CompareOrdinal(UpperName, ((MemberModel)obj).UpperName);
		}
	}
	
	/// <summary>
	/// Strong-typed MemberModel list with special merging/searching methods
	/// </summary>
	sealed public class MemberList: IEnumerable
	{
		private ArrayList items;
		private bool Sorted;
		
		public IEnumerator GetEnumerator()
		{
			return items.GetEnumerator();
		}
		
		/*public ArrayList Items 
		{
			get {
				return items;
			}
		}*/

		public int Count
		{
			get {
				return items.Count;
			}
		}
		
		public MemberList()
		{
			items = new ArrayList();
		}
		
		public MemberModel this[int index]
		{
			get {
				return (MemberModel)items[index];
			}
			set {
				Sorted = false;
				items[index] = value;
			}
		}
		
		public int Add(MemberModel value)
		{
			Sorted = false;
			return items.Add(value);
		}
		
		public void Insert(int index, MemberModel value)
		{
			Sorted = false;
			items.Insert(index, value);
		}
		
		public void Remove(MemberModel value)
		{
			Sorted = false;
			items.Remove(value);
		}
		
		public void Clear()
		{
			Sorted = true;
			items.Clear();
		}
		
		public MemberModel Search(string name, FlagType mask) {
			foreach (MemberModel m in items)
				if ((m.Name.Equals(name)) && ((m.Flags & mask) == mask)) return m;
			return null;
		}
		
		public MemberList MultipleSearch(string name, FlagType mask) {
			MemberList result = new MemberList();
			foreach (MemberModel m in items)
				if ((m.Name.Equals(name)) && ((m.Flags & mask) == mask)) result.Add(m);
			return result;
		}
		
		public void Sort()
		{
			if (!Sorted) 
			{
				items.Sort();
				Sorted = true;
			}
		}
		
		/// <summary>
		/// Merge one item into the list
		/// </summary>
		/// <param name="item">Item to merge</param>
		public void Merge(MemberModel item)
		{
			MemberList list = new MemberList();
			list.Add(item);
			Merge(list, 0);
		}
		
		/// <summary>
		/// Merge SORTED lists without duplicate values
		/// </summary>
		/// <param name="list">Items to merge</param>
		public void Merge(MemberList list)
		{
			Merge(list, 0);
		}
		
		/// <summary>
		/// Merge selected items from the SORTED lists without duplicate values
		/// </summary>
		/// <param name="list">Items to merge</param>
		public void Merge(MemberList list, FlagType mask)
		{
			int index = 0;
			bool added;
			foreach (MemberModel m in list)
			if ((m.Flags & mask) == mask) 
			{
				added = false;
				while (index < items.Count)
				{
					if (m.CompareTo(items[index]) <= 0)
					{
						if (!m.Equals(items[index]))
							items.Insert(index, m);
						added = true;
						break;
					}
					index++;
				}
				if (!added) items.Add(m);
			}
		}
	}
	#endregion
}
