using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.IO;

namespace AS3IntrinsicsGenerator
{
    class Program
    {
        static void Main(string[] args)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load("ActionsPanel_3.xml");
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
            Console.WriteLine(fileName);
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
                foreach (MethodModel method in block.Methods) method.IsStatic = false;
            }
            else if (id == "Global Constants")
            {
                ParseProperties(part, block);
                foreach (PropertyModel prop in block.Properties)
                {
                    prop.IsStatic = false;
                    prop.IsConst = false;
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
                foreach (MemberModel member in block.Methods) member.IsStatic = false;
                foreach (MemberModel member in block.Properties) member.IsStatic = false;

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
                model.IsConst = GetAttribute(node, "constant") == "true";
                string text = GetAttribute(node, "text");
                model.IsStatic = text[0] != '.';
                if (model.IsConst)
                {
                    if (block.Name == "Keyboard")
                    {
                        if (model.Name.StartsWith("STRING_") || model.Name.StartsWith("KEYNAME_"))
                            model.ValueType = "String";
                        else model.ValueType = "uint";
                    }
                    else if (block.Name == "int" || block.Name == "uint" || block.Name == "Number") model.ValueType = block.Name;
                    else if (block.Name == "Math") model.ValueType = "Number";
                    else if (model.Name.StartsWith("MAX_")) model.ValueType = "int";
                    else if (model.Name.Length > 1 && Char.IsLower(model.Name[1])) model.ValueType = "*";
                    else model.ValueType = "String";
                }
                model.Comment = GetAttribute(node, "tiptext");
                model.GuessType(block);
                block.Properties.Add(model);
            }
        }

        private static void ParseEvents(XmlNode part, BlockModel block)
        {
            foreach (XmlNode node in part.ChildNodes)
            {
                EventModel model = new EventModel();
                model.Name = GetAttribute(node, "name");
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

            foreach (XmlNode part in node.ChildNodes)
                ParsePart(part, block);

            parentBlock.Blocks.Add(block);
        }
    }
}
