using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace AS3IntrinsicsGenerator
{
    public class MemberModel
    {
        protected const string NL = "\r\n";
        protected const char SEMI = ';';

        public string Name;
        public string Comment;
        public bool IsStatic;
        public bool IsFP10;
        public bool IsAIR;

        public virtual void Format(StringBuilder sb, string tabs) { }

        public void FormatComments(StringBuilder sb, string tabs)
        {
            string cmt = Comment ?? "";
            if (IsAIR) cmt = "[AIR] " + cmt;
            else if (IsFP10) cmt = "[FP10] " + cmt;
            if (cmt.Length > 0)
                sb.Append(tabs).Append("/** ").Append(cmt).Append(" */").Append(NL);
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

    public class BlockModel : MemberModel
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
            foreach (MemberModel m in Events) m.Format(sb, ctabs);
            if (Events.Count > 0) sb.Append(NL);
            foreach (MemberModel m in Properties) m.Format(sb, ctabs);
            if (Properties.Count > 0) sb.Append(NL);
            foreach (MemberModel m in Methods) m.Format(sb, ctabs);
            if (Methods.Count > 0) sb.Append(NL);
            foreach (MemberModel m in Blocks) m.Format(sb, ctabs);

            sb.Append(tabs).Append('}').Append(NL);
        }
    }

    public class MethodModel : MemberModel
    {
        static private Regex reComa = new Regex(",([a-z])", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        static private Regex reRest = new Regex("([a-z0-9]+):restParam", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        static private Regex reVector = new Regex("Vector\\$([a-z.]+)", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        static private Regex reType = new Regex(":([a-z.]+):", RegexOptions.Compiled | RegexOptions.IgnoreCase);

        public string Params;
        public string ReturnType;

        public override void Format(StringBuilder sb, string tabs)
        {
            FormatComments(sb, tabs);
            sb.Append(tabs);
            if (IsStatic) sb.Append("public static ");
            else sb.Append("public ");
            sb.Append("function ").Append(Name)
                .Append('(').Append(Params).Append(')');
            if (ReturnType != null) sb.Append(':').Append(ReturnType);
            sb.Append(SEMI).Append(NL);
        }

        public void FixParams()
        {
            if (Params.Length > 0)
            {
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

    public class PropertyModel : MemberModel
    {
        public string ValueType;
        public bool IsConst;

        public override void Format(StringBuilder sb, string tabs)
        {
            FormatComments(sb, tabs);
            sb.Append(tabs);
            if (IsStatic) sb.Append("public static ");
            else sb.Append("public ");
            if (IsConst) sb.Append("const ");
            else sb.Append("var ");
            sb.Append(Name);
            if (ValueType != null && ValueType.Length > 0) sb.Append(':').Append(ValueType);
            sb.Append(SEMI).Append(NL);
        }

        public void GuessType(BlockModel block)
        {
            if (IsConst && ValueType == "String" && Char.IsUpper(Name[0]))
            {
                ValueType = "String = \"" + Camelize(Name) + "\"";
            }
            else if (ValueType == null)
            {
                if (block.Name == "XML" || Comment.IndexOf(" whether ") > 0) ValueType = "Boolean";
                else if (Comment.IndexOf(" array of ") > 0) ValueType = "Array";
                else if (Comment.IndexOf(" number of ") > 0) ValueType = "int";
                else if (Comment.IndexOf(" amount of ") > 0) ValueType = "Number";
                else if (Comment.IndexOf(" transparency value ") > 0) ValueType = "Number";
                else if (Comment.IndexOf(" color of ") > 0) ValueType = "uint";
                else if (Comment.IndexOf(" Vector of ") > 0) ValueType = "Vector.<*>";
                else if (Comment.IndexOf(" name of ") > 0) ValueType = "String";
                else ValueType = "*";
            }
        }
    }

    public class EventModel : MemberModel
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
                .Append("\")]").Append(NL);
        }
    }
}
