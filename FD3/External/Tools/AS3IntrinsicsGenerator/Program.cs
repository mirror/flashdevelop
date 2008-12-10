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
        
        static void Main(string[] args)
        {
            string AS3XML = "ActionsPanel_3.xml";
            if (!File.Exists(AS3XML))
            {
                Console.WriteLine("Copy {0} in bin\\Debug", AS3XML);
                return;
            }

            // SWC parsing
            Console.WriteLine("Parsing SWCs...");
            AS3Settings settings = new AS3Settings();
            context = new Context(settings);
            context.Classpath = new List<PathModel>();
            context.Classpath.Add(ParseSWC("servicemonitor.swc"));
            context.Classpath.Add(ParseSWC("airglobal.swc"));
            context.Classpath.Add(ParseSWC("playerglobal.swc"));

            // AS3 doc parsing
            Console.WriteLine("Generating...");
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
            Console.WriteLine("Done.");
        }

        private static PathModel ParseSWC(string swcFile)
        {
            PathModel path = new PathModel(System.IO.Path.GetFullPath(swcFile), context);
            if (!File.Exists(swcFile))
            {
                Console.WriteLine("Copy {0} in bin\\Debug", swcFile);
                return path;
            }
            SwfOp.ContentParser parser = new SwfOp.ContentParser(path.Path);
            parser.Run();
            AbcConverter.Convert(parser.Abcs, path, context);
            return path;
        }

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
            if (block.Methods.Count > 0) WriteFile(block);
        }

        private static void WriteFile(BlockModel block)
        {
            string fileName = block.Name.Replace('.', Path.DirectorySeparatorChar);
            if (block.Blocks.Count > 0) fileName = Path.Combine(fileName, block.Blocks[0].Name + ".as");
            else if (fileName.Length == 0) fileName = "toplevel.as";
            else fileName = Path.Combine(fileName, "package.as");
            
            fileName = Path.Combine("out", fileName);
            //Console.WriteLine(fileName);
            StringBuilder sb = new StringBuilder();
            block.Format(sb, "");
            Directory.CreateDirectory(Path.GetDirectoryName(fileName));
            File.WriteAllText(fileName, sb.ToString());
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

                WriteFile(block);
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
                model.IsAIR = GetAttribute(node, "playername").Trim() == "AIR";
                model.IsFP10 = GetAttribute(node, "version").Trim() == "1.5";
                string text = GetAttribute(node, "text");
                model.IsStatic = text[0] != '.' && model.Name != block.Name;
                int p = text.IndexOf("):");
                if (p > 0) model.ReturnType = text.Substring(p + 2);
                else if (model.Name != block.Name) model.ReturnType = "void";
                text = text.Substring(text.IndexOf('%') + 1);
                text = text.Substring(0, text.LastIndexOf('%'));
                model.Params = text;
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
            if (block.Name == "Proxy")
            {
                foreach (MethodModel method in block.Methods)
                {
                    method.Namespace = "flash_proxy";
                }
            }
            else if (block.Name == "BitmapData")
            {
                foreach (MethodModel method in block.Methods)
                {
                    if (method.Name == "histogram")
                    {
                        method.ReturnType = "Vector.<Vector.<Number>>";
                        break;
                    }
                }
            }
            else if (block.Name == "DisplayObject")
            {
                foreach (PropertyModel prop in block.Properties)
                {
                    if (prop.Name.EndsWith("z", StringComparison.OrdinalIgnoreCase))
                        prop.IsFP10 = true;
                }
            }
            else if (block.Name == "Vector")
            {
                block.Decl = "public class Vector.<T>";
            }
            parentBlock.Blocks.Add(block);
        }
    }
}
