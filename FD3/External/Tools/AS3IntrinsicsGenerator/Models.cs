using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace AS3IntrinsicsGenerator
{
    public class BaseModel
    {
        protected const string NL = "\r\n";
        protected const char SEMI = ';';

        public string Name;
        public string Comment;
        public bool IsStatic;
        public bool IsFP10;
        public bool IsAIR;
        public string Namespace = "public";

        public virtual void Format(StringBuilder sb, string tabs) { }

        public void FormatComments(StringBuilder sb, string tabs)
        {
            string cmt = Comment ?? "";
            if (IsAIR) cmt = "[AIR] " + cmt;
            else if (IsFP10) cmt = "[FP10] " + cmt;
            if (cmt.Length == 0) return;
            if (cmt.IndexOf('\n') > 0)
                sb.Append(tabs).Append("/** ")
                    .Append(NL).Append(tabs).Append(" * ").Append(cmt)
                    .Append(NL).Append(tabs).Append(" */").Append(NL);
            else
                sb.Append(tabs).Append("/// ").Append(cmt).Append(NL);
        }

        static public string Camelize(string name)
        {
            string[] parts = name.ToLower().Split('_');
            string result = "";
            foreach (string part in parts)
            {
                if (result.Length > 0)
                    result += Char.ToUpper(part[0]) + part.Substring(1);
                else result = part;
            }
            return result;
        }
    }

    public class BlockModel : BaseModel
    {
        public string Decl;
        public List<EventModel> Events = new List<EventModel>();
        public List<PropertyModel> Properties = new List<PropertyModel>();
        public List<MethodModel> Methods = new List<MethodModel>();
        public List<BlockModel> Blocks = new List<BlockModel>();

        public override void Format(StringBuilder sb, string tabs)
        {
            FormatComments(sb, tabs);
            sb.Append(tabs).Append(Decl).Append(NL)
                .Append(tabs).Append('{').Append(NL);

            string ctabs = tabs + '\t';
            foreach (BaseModel m in Events) m.Format(sb, ctabs);
            foreach (BaseModel m in Properties) m.Format(sb, ctabs);
            foreach (BaseModel m in Methods) m.Format(sb, ctabs);
            foreach (BaseModel m in Blocks) m.Format(sb, ctabs);

            sb.Append(tabs).Append('}').Append(NL).Append(NL);
        }
    }

    public class MethodModel : BaseModel
    {
        static private Regex reComa = new Regex(",([a-z])", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        static private Regex reRest = new Regex("([a-z0-9]+):restParam", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        static private Regex reVector = new Regex("Vector\\$([a-z.]+)", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        static private Regex reType = new Regex(":([a-z.$]+):", RegexOptions.Compiled | RegexOptions.IgnoreCase);

        public string Params;
        public string ReturnType;

        public override void Format(StringBuilder sb, string tabs)
        {
            FormatComments(sb, tabs);
            sb.Append(tabs).Append(Namespace).Append(' ');
            if (IsStatic) sb.Append("static ");
            sb.Append("function ").Append(Name)
                .Append('(').Append(Params).Append(')');
            if (ReturnType != null) sb.Append(':').Append(ReturnType);
            sb.Append(SEMI).Append(NL).Append(NL);
        }

        public void FixParams()
        {
            if (Params.Length > 0)
            {
                Params = Params.Replace("[", "");
                Params = Params.Replace("]", "");
                Params = reComa.Replace(Params, ", $1");
                Params = reType.Replace(Params, ":$1.");
                Params = reVector.Replace(Params, "Vector.<$1>");
                Match m = reRest.Match(Params);
                if (m.Success)
                    Params = Params.Substring(0, m.Index) + "..." + m.Groups[1].Value + Params.Substring(m.Index + m.Length);
            }
            if (ReturnType != null)
            {
                ReturnType = ReturnType.Replace(':', '.');
                if (ReturnType.StartsWith("Vector"))
                    ReturnType = reVector.Replace(ReturnType, "Vector.<$1>");
            }
        }
    }

    public class PropertyModel : BaseModel
    {
        public string ValueType;
        public string Kind = "var";

        public override void Format(StringBuilder sb, string tabs)
        {
            FormatComments(sb, tabs);
            sb.Append(tabs).Append(Namespace).Append(' ');
            if (IsStatic) sb.Append("static ");
            sb.Append(Kind).Append(' ').Append(Name);
            if (ValueType != null && ValueType.Length > 0) sb.Append(':').Append(ValueType);
            sb.Append(SEMI).Append(NL).Append(NL);
        }

        public void GuessValue()
        {
            if (Kind == "const" && ValueType == "String" && Char.IsUpper(Name[0]))
            {
                ValueType = "String = \"" + Camelize(Name) + "\"";
            }
        }
    }

    public class EventModel : BaseModel
    {
        public string EventType;

        public override void Format(StringBuilder sb, string tabs)
        {
            string tmp = Comment;
            Comment = Comment + NL + tabs + " * @eventType " + EventType;
            FormatComments(sb, tabs);
            sb.Append(tabs).Append("[Event(")
                .Append("name=\"").Append(Name)
                .Append("\", type=\"").Append(EventType.Substring(0, EventType.LastIndexOf('.')))
                .Append("\")]").Append(NL).Append(NL);
        }
    }
}
