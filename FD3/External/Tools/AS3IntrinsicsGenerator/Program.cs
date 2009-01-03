using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.IO;
using AS3Context;
using ASCompletion.Model;

namespace AS3IntrinsicsGenerator
{
    class Program
    {
        static private Context context;
        static private ClassModel currentClass;
        static private Dictionary<string, BlockModel> types;
        static private Dictionary<string, string> generated;
        
        static void Main(string[] args)
        {

            // SWC parsing
            Console.WriteLine("Parsing SWCs...");
            AS3Settings settings = new AS3Settings();
            context = new Context(settings);
            context.Classpath = new List<PathModel>();
            context.Classpath.Add(ParseSWC("libs\\air\\servicemonitor.swc"));
            context.Classpath.Add(ParseSWC("libs\\air\\airglobal.swc"));
            context.Classpath.Add(ParseSWC("libs\\player\\10\\playerglobal.swc"));
            context.Classpath.Add(ParseSWC("libs\\player\\9\\playerglobal.swc"));

            // AS3 doc parsing
            string AS3XML = "ActionsPanel_3.xml";
            if (!File.Exists(AS3XML))
            {
                Console.WriteLine("Error: missing {0}, copy this file from Flash CS4 installation", AS3XML);
                return;
            }
            ExtractXML(AS3XML);

            // Intrinsics generation
            Console.WriteLine("Generating intrinsics...");
            generated = new Dictionary<string, string>();
            GenerateIntrinsics("FP9", context.Classpath[3]);
            GenerateIntrinsics("FP10", context.Classpath[2]);
            GenerateIntrinsics("AIR", context.Classpath[1]);

            Console.WriteLine("Done.");
        }

        private static void ExtractXML(string AS3XML)
        {
            types = new Dictionary<string, BlockModel>();
            Console.WriteLine("Extracting XML...");
            XmlDocument doc = new XmlDocument();
            doc.Load(AS3XML);
            XmlNodeList nodes = doc.LastChild.FirstChild.ChildNodes;
            foreach (XmlNode node in nodes)
            {
                string id = GetAttribute(node, "id");
                if (id.Length == 0) continue;
                if (id.IndexOf(' ') > 0)
                {
                    if (id == "Top Level") ParsePackage(node, "");
                    else if (id == "Language Elements") ParseTopLevel(node);
                    else Console.WriteLine("Unsupported: " + id);
                }
                else ParsePackage(node, id);
            }
        }

        private static PathModel ParseSWC(string swcFile)
        {
            PathModel path = new PathModel(System.IO.Path.GetFullPath(swcFile), context);
            if (!File.Exists(swcFile))
            {
                Console.WriteLine("Error: missing {0}, copy Flex SDK's lib directory", swcFile);
                return path;
            }
            SwfOp.ContentParser parser = new SwfOp.ContentParser(path.Path);
            parser.Run();
            AbcConverter.Convert(parser.Abcs, path, context);
            return path;
        }

        #region Intrinsics generation

        private static void GenerateIntrinsics(string dir, PathModel pathModel)
        {
            foreach (FileModel aFile in pathModel.Files.Values)
            {
                if (aFile.Package == "private") continue;

                ClassModel aClass = aFile.GetPublicClass();
                if (aClass.IsVoid()) continue;
                aFile.Members.Sort();
                aClass.Members.Sort();

                string type = aClass.QualifiedName;
                string fileName = Path.Combine(Path.Combine("out", dir), 
                    type.Replace('.', Path.DirectorySeparatorChar)) + ".as";
                // adding comments extracted from XML
                if (types.Keys.Contains<string>(type))
                {
                    BlockModel docModel = types[type];
                    aClass.Comments = docModel.Blocks[0].Comment;
                    AddDocumentation(aFile.Members, docModel);
                    AddDocumentation(aClass.Members, docModel.Blocks[0]);
                    AddEvents(aFile, docModel.Blocks[0]);
                }

                // removing non-public members
                if ((aClass.Flags & FlagType.Interface) == 0)
                    aClass.Members.Items
                        .RemoveAll(member => member.Access != Visibility.Public);
                // removing AIR members
                if (dir != "AIR")
                    aClass.Members.Items
                        .RemoveAll(member => member.Comments != null && member.Comments.StartsWith("[AIR]"));

                // MANUAL FIX event consts' values
                if (aFile.Package == "flash.events")
                    aClass.Members.Items
                        .FindAll(member => (member.Flags & FlagType.Constant) > 0 && member.Type == "String")
                        .ForEach(member => member.Value = '"' + BaseModel.Camelize(member.Name) + '"');

                // MANUAL FIX MovieClip.addFrameScript
                if (aClass.QualifiedName == "flash.display.MovieClip")
                {
                    MemberModel member = aClass.Members.Search("addFrameScript", 0, 0);
                    if (member != null)
                    {
                        member.Comments = "[Undocumented] Takes a collection of frame (zero-based) - method pairs that associates a method with a frame on the timeline.";
                        member.Parameters = new List<MemberModel>();
                        member.Parameters.Add(new MemberModel("frame", "int", FlagType.ParameterVar, Visibility.Public));
                        member.Parameters.Add(new MemberModel("method", "Function", FlagType.ParameterVar, Visibility.Public));
                    }
                }

                // MANUAL FIX Sprite.toString (needed for override)
                if (aClass.QualifiedName == "flash.display.Sprite")
                {
                    if (aClass.Members.Search("toString", 0, 0) == null)
                        aClass.Members.Add(new MemberModel("toString", "String", FlagType.Function, Visibility.Public));
                }

                // MANUAL FIX Object
                if (aClass.QualifiedName == "Object")
                {
                    if (aClass.Members.Search("toString", 0, 0) == null)
                        aClass.Members.Add(new MemberModel("toString", "String", FlagType.Function, Visibility.Public));
                    if (aClass.Members.Search("valueOf", 0, 0) == null)
                        aClass.Members.Add(new MemberModel("valueOf", "Object", FlagType.Function, Visibility.Public));
                    if (aClass.Members.Search("setPropertyIsEnumerable", 0, 0) == null)
                    {
                        MemberModel member = new MemberModel("setPropertyIsEnumerable", "void", FlagType.Function, Visibility.Public);
                        member.Parameters = new List<MemberModel>();
                        member.Parameters.Add(new MemberModel("name", "String", FlagType.ParameterVar, Visibility.Public));
                        member.Parameters.Add(new MemberModel("isEnum", "Boolean", FlagType.ParameterVar, Visibility.Public));
                        member.Parameters[1].Value = "true";
                        aClass.Members.Add(member);
                    }
                }

                // MANUAL FIX Proxy
                // TODO  Need to check ABC parser for specific namespaces
                if (aClass.QualifiedName == "flash.utils.Proxy")
                {
                    aClass.Members.Items.ForEach(member => member.Namespace = "flash_proxy");
                }

                string src = aFile.GenerateIntrinsic(false);
                if (generated.ContainsKey(type) && generated[type] == src) continue;
                else generated[type] = src;
                Directory.CreateDirectory(Path.GetDirectoryName(fileName));
                File.WriteAllText(fileName, src);
            }
        }

        private static void AddEvents(FileModel aFile, BlockModel docModel)
        {
            aFile.MetaDatas = new List<ASMetaData>();
            foreach (EventModel ev in docModel.Events)
            {
                ASMetaData meta = new ASMetaData("Event");
                if (ev.Comment != null)
                    meta.Comments = "\n\t * " + ev.Comment + "\n\t * @eventType " + ev.EventType;
                meta.ParseParams(String.Format("name=\"{0}\", type=\"{1}\"", ev.Name, ev.EventType));
                aFile.MetaDatas.Add(meta);
            }
        }

        private static void AddDocumentation(MemberList members, BlockModel docModel)
        {
            AddDocComments(members, docModel.Properties.ToArray());
            AddDocComments(members, docModel.Methods.ToArray());
        }

        private static void AddDocComments(MemberList members, BaseModel[] docMembers)
        {
            foreach (BaseModel docMember in docMembers)
            {
                MemberModel member = members.Search(docMember.Name, 0, 0);
                if (member == null) continue;
                member.Comments = docMember.Comment;
                //if (docMember.IsFP10) member.Comments = "[FP10] " + member.Comments;
                if (docMember.IsAIR) member.Comments = "[AIR] " + member.Comments;
            }
        }

        private static void RegisterBlock(BlockModel block)
        {
            string fileName = block.Name.Replace('.', Path.DirectorySeparatorChar);
            if (block.Blocks.Count > 0)
            {
                BlockModel classBlock = block.Blocks[0];
                fileName = Path.Combine(fileName, classBlock.Name + ".as");
                types.Add((block.Name.Length > 0 ? block.Name + "." : "") + classBlock.Name, block);

                // MANUAL FIX Vector.join
                if (classBlock.Name == "Vector")
                {
                    classBlock.Methods.ForEach(method => 
                    {
                        if (method.Name == "join")
                            method.Params = method.Params.Replace("= ,", "= \",\"");
                    });
                }
                // will be written based on SWC
                else return;
            }
            else
            {
                if (IsEmptyBlock(block)) return;
                if (fileName.Length == 0) fileName = "toplevel.as";
                else
                {
                    fileName = Path.Combine(fileName, "package.as");

                    // MANUAL FIX flah.net package
                    if (block.Name == "flash.net")
                    {
                        block.Imports = new List<string>();
                        block.Imports.Add("flash.net.URLRequest");
                        block.Methods.ForEach(method =>
                        {
                            method.Params = method.Params.Replace("flash.net.URLRequest", "URLRequest");
                        });
                    }
                }
            }

            string dest;
            if (IsAirTarget(block))
            {
                dest = Path.Combine("out\\AIR", fileName);
                WriteFile(dest, block);
                if (block.Name == "flash.desktop" || block.Name == "flash.filesystem" 
                    || block.Name == "flash.html") return;
                RemoveAIRMembers(block);
            }
            if (IsFP10Target(block))
            {
                dest = Path.Combine("out\\FP10", fileName);
                WriteFile(dest, block);
                if (block.Name == "flash.text.engine") return;
                RemoveFP10Members(block);
            }

            if (!IsEmptyBlock(block))
            {
                dest = Path.Combine("out\\FP9", fileName);
                WriteFile(dest, block);
            }
        }

        private static bool IsEmptyBlock(BlockModel block)
        {
            if (block.Methods.Count > 0) return false;
            if (block.Properties.Count > 0)
            {
                if (block.Blocks.Count == 0 && block.Methods.Count == 0 
                    && (block.IsAIR || block.IsFP10))
                {
                    Console.WriteLine("Considered empty: " + block.Name);
                    return true;
                }
            }
            foreach (var sub in block.Blocks)
                if (!IsEmptyBlock(sub)) return false;
            return true;
        }

        private static void RemoveFP10Members(BlockModel block)
        {
            block.Methods.RemoveAll(model => model.IsFP10);
            block.Properties.RemoveAll(model => model.IsFP10);
            block.Blocks.ForEach(sub => RemoveFP10Members(sub));
        }

        private static void RemoveAIRMembers(BlockModel block)
        {
            block.Methods.RemoveAll(model => model.IsAIR);
            block.Properties.RemoveAll(model => model.IsAIR);
            block.Blocks.ForEach(sub => RemoveAIRMembers(sub));
        }

        private static void WriteFile(string fileName, BlockModel block)
        {
            StringBuilder sb = new StringBuilder();
            block.Format(sb, "");
            Directory.CreateDirectory(Path.GetDirectoryName(fileName));
            File.WriteAllText(fileName, sb.ToString());
        }

        private static bool IsFP10Target(BlockModel block)
        {
            return block.Methods.Exists(model => model.IsFP10)
                || block.Properties.Exists(model => model.IsFP10)
                || block.Blocks.Exists(sub => IsFP10Target(sub));
        }

        private static bool IsAirTarget(BlockModel block)
        {
            return block.Methods.Exists(model => model.IsAIR)
                || block.Properties.Exists(model => model.IsAIR)
                || block.Blocks.Exists(sub => IsAirTarget(sub));
        }

        #endregion

        #region Extracting information from XML

        private static string GetAttribute(XmlNode node, string name)
        {
            try { return node.Attributes[name].Value; }
            catch { return ""; }
        }

        private static void ParseTopLevel(XmlNode node)
        {
            BlockModel block = new BlockModel();
            block.Name = "";
            block.Decl = "package";
            foreach (XmlNode part in node.ChildNodes)
                ParseTopLevelPart(part, block);

            RegisterBlock(block);
        }

        private static void ParseTopLevelPart(XmlNode part, BlockModel block)
        {
            string id = GetAttribute(part, "id");
            if (id == "Global Functions")
            {
                ParseMethods(part, block);
                List<MethodModel> methods = new List<MethodModel>();
                foreach (MethodModel method in block.Methods)
                {
                    // ignore convertion methods
                    if (method.Name != method.ReturnType && method.Name != "Vector")
                    {
                        method.IsStatic = false;
                        methods.Add(method);
                    }
                }
                block.Methods = methods;
            }
            else if (id == "Global Constants")
            {
                ParseProperties(part, block);
                foreach (PropertyModel prop in block.Properties)
                {
                    prop.IsStatic = false;
                    prop.Kind = "var";
                }
            }
        }

        private static void ParsePackage(XmlNode node, string package)
        {
            if (package.StartsWith("fl.")) 
                return;
            foreach (XmlNode part in node.ChildNodes)
            {
                BlockModel block = new BlockModel();
                block.Name = package;
                block.Decl = "package " + package;

                ParsePart(part, block);
                foreach (BaseModel member in block.Methods) member.IsStatic = false;
                foreach (BaseModel member in block.Properties) member.IsStatic = false;

                // MANUAL FIX FOR SPECIAL CASES
                if (package == "flash.utils" && block.Blocks.Count == 0)
                {
                    PropertyModel ns = new PropertyModel();
                    ns.Kind = "namespace";
                    ns.Name = "flash_proxy";
                    ns.Comment = "Proxy methods namespace";
                    block.Properties.Insert(0, ns);
                }

                RegisterBlock(block);
            }
        }

        private static void ParsePart(XmlNode part, BlockModel block)
        {
            string id = GetAttribute(part, "id");
            if (id == "Methods") ParseMethods(part, block);
            else if (id == "Properties") ParseProperties(part, block);
            else if (id == "Events") ParseEvents(part, block);
            else ParseClass(part, block);
        }

        private static void ParseMethods(XmlNode part, BlockModel block)
        {
            foreach (XmlNode node in part.ChildNodes)
            {
                MethodModel model = new MethodModel();
                model.Name = GetAttribute(node, "name");
                model.IsAIR = GetAttribute(node, "playername").Trim() == "AIR" || GetAttribute(node, "version").Trim() == "1.0";
                model.IsFP10 = GetAttribute(node, "version").Trim() == "1.5";
                string text = GetAttribute(node, "text");
                model.IsStatic = text[0] != '.' && model.Name != block.Name;
                int p = text.IndexOf("):");
                if (p > 0)
                {
                    model.ReturnType = text.Substring(p + 2);
                    if (!model.IsFP10 && model.ReturnType.IndexOf("Vector") >= 0) model.IsFP10 = true;
                }
                else if (model.Name != block.Name) model.ReturnType = "void";
                text = text.Substring(text.IndexOf('%') + 1);
                text = text.Substring(0, text.LastIndexOf('%'));
                model.Params = text;
                if (!model.IsFP10 && model.Params.IndexOf("Vector") > 0)
                    model.IsFP10 = true;
                model.Comment = GetAttribute(node, "tiptext");
                model.FixParams();
                block.Methods.Add(model);
            }
        }

        private static void ParseProperties(XmlNode part, BlockModel block)
        {
            foreach (XmlNode node in part.ChildNodes)
            {
                PropertyModel model = new PropertyModel();
                model.Name = GetAttribute(node, "name");
                model.IsAIR = GetAttribute(node, "playername").Trim() == "AIR";
                model.IsFP10 = GetAttribute(node, "version").Trim() == "1.5";
                if (GetAttribute(node, "constant") == "true") model.Kind = "const";
                string text = GetAttribute(node, "text");
                model.IsStatic = text[0] != '.';

                if (currentClass != null && !currentClass.IsVoid())
                {
                    MemberModel member = currentClass.Members.Search(model.Name, 0, 0);
                    if (member == null)
                    {
                        if (model.Name == "SAMPLE_DATA") model.ValueType = "String";
                        else if (model.Name == "prototype") model.ValueType = "Object";
                        else if (model.Name == "constructor") model.ValueType = "Function";
                        else if (model.Name == "enabled") model.ValueType = "Boolean";
                        else if (model.Name == "Infinity") model.ValueType = "Number";
                        else if (model.Name == "-Infinity") continue;
                        else if (model.Name == "NaN") model.ValueType = "Number";
                        else if (model.Name == "undefined") model.ValueType = "*";
                        else
                            Console.WriteLine("Member not found in SWC: {0}", block.Name + "." + model.Name);
                    }
                    else if ((member.Flags & FlagType.Setter) > 0)
                    {
                        // MANUAL FIX FOR MISSING MEMBERS
                        if (member.Parameters == null)
                        {
                            Console.WriteLine("Setter parameter missing in SWC: {0}", block.Name + "." + model.Name);
                        }
                        else model.ValueType = member.Parameters[0].Type;
                    }
                    else
                        model.ValueType = member.Type;
                }

                model.Comment = GetAttribute(node, "tiptext");
                model.GuessValue();
                block.Properties.Add(model);
            }
        }

        private static void ParseEvents(XmlNode part, BlockModel block)
        {
            foreach (XmlNode node in part.ChildNodes)
            {
                EventModel model = new EventModel();
                model.Name = GetAttribute(node, "name");
                model.IsAIR = GetAttribute(node, "playername").Trim() == "AIR";
                model.IsFP10 = GetAttribute(node, "version").Trim() == "1.5";
                string temp = GetAttribute(node, "text");
                int p = temp.IndexOf("%type:String=");
                if (p > 0)
                {
                    temp = temp.Substring(p + 13);
                    model.EventType = "flash.events." + temp.Substring(0, temp.IndexOf('{'));
                }
                else model.EventType = "???";
                model.Comment = GetAttribute(node, "tiptext");
                block.Events.Add(model);
            }
        }

        private static void ParseClass(XmlNode node, BlockModel parentBlock)
        {
            BlockModel block = new BlockModel();
            block.Name = GetAttribute(node, "name");
            string ext = GetAttribute(node, "asAncestors");
            if (ext.Length > 0 && ext != "Object") ext = " extends " + ext.Split(',')[0].Replace(':', '.');
            else ext = "";
            block.Decl = "public class " + block.Name + ext;
            block.Comment = GetAttribute(node, "tiptext");

            string package = parentBlock.Name;
            if (package.Length > 0) package += ".";
            currentClass = context.ResolveType(package + block.Name, null);
            if (currentClass.IsVoid())
            {
                // MANUAL FIX FOR MISSING CLASSES
                if (block.Name == "arguments")
                {
                    currentClass = new ClassModel();
                    currentClass.Members.Add(new MemberModel("callee", "Object", FlagType.Variable, Visibility.Public));
                    currentClass.Members.Add(new MemberModel("length", "int", FlagType.Variable, Visibility.Public));
                }
                else if (block.Name == "Vector")
                {
                    currentClass = new ClassModel();
                    currentClass.Members.Add(new MemberModel("fixed", "Boolean", FlagType.Variable, Visibility.Public));
                    currentClass.Members.Add(new MemberModel("length", "int", FlagType.Variable, Visibility.Public));
                }
                else Console.WriteLine("Class not found in SWC: {0}", package + block.Name);
            }

            foreach (XmlNode part in node.ChildNodes)
                ParsePart(part, block);

            // MANUAL FIX FOR SPECIFIC CASES
            if (block.Name == "Vector")
            {
                block.Decl = "public class Vector.<T>";
            }
            else if (block.Name.StartsWith("Clipboard"))
            {
                foreach (BaseModel member in block.Methods)
                {
                    member.IsAIR = (member.Comment.IndexOf("AIR only") > 0);
                    member.IsFP10 = true;
                }
                foreach (BaseModel member in block.Properties)
                {
                    member.IsAIR = (member.Comment.IndexOf("AIR only") > 0);
                    member.IsFP10 = true;
                }
            }
            parentBlock.Blocks.Add(block);
        }

        #endregion
    }
}
