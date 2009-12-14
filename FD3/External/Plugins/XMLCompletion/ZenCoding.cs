using System;
using System.Collections.Generic;
using System.Text;
using PluginCore;
using ScintillaNet;
using System.Collections;
using System.IO;
using PluginCore.Helpers;
using PluginCore.Managers;
using System.Reflection;

namespace XMLCompletion
{
    public class ZenCoding
    {
        static public LanguageDef lang;
        static private bool inited;
        static private Hashtable expandos = new Hashtable();
        static private Hashtable attribs = new Hashtable();

        #region initialization
        static private void init()
        {
            if (inited) return;
            inited = true;

            LoadResource("zen-expandos.txt", expandos);
            LoadResource("zen-attribs.txt", attribs);
        }

        private static void LoadResource(string file, Hashtable table)
        {
            string path = Path.Combine(PathHelper.DataDir, "XMLCompletion");
            string filePath = Path.Combine(path, file);
            try
            {
                if (!File.Exists(filePath) && !WriteResource(file, filePath))
                    return;
                string[] lines = File.ReadAllLines(filePath);
                foreach (string line in lines)
                {
                    string temp = line.Trim();
                    if (temp.Length == 0) continue;
                    string[] parts = temp.Split(new char[] {'\t'}, 2);
                    if (parts.Length == 2)
                        table[parts[0].Trim()] = parts[1].Trim();
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        private static bool WriteResource(string file, string filePath)
        {
            try
            {
                Assembly assembly = Assembly.GetExecutingAssembly();
                Stream src = assembly.GetManifestResourceStream("XMLCompletion.Resources." + file);
                if (src == null) return false;

                String content;
                using (StreamReader sr = new StreamReader(src))
                {
                    content = sr.ReadToEnd();
                    sr.Close();
                }
                Directory.CreateDirectory(Path.GetDirectoryName(filePath));
                using (StreamWriter sw = File.CreateText(filePath))
                {
                    sw.Write(content);
                    sw.Close();
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
        #endregion

        static public bool expandSnippet(Hashtable data)
        {
            if (data["snippet"] == null)
            {
                ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
                if (sci == null) return false;
                int pos = sci.CurrentPos - 1;
                int lastValid = sci.CurrentPos;
                char c = (char)sci.CharAt(pos);
                while (pos > 0)
                {
                    if (c <= 32)
                    {
                        lastValid = pos + 1;
                        break;
                    }
                    if (c == '>')
                    {
                        if (lastValid - 1 <= pos) break;
                        lastValid = pos + 1;
                    }
                    else if (!Char.IsLetterOrDigit(c) && "+*$.#:-".IndexOf(c) < 0) break;
                    pos--;
                    c = (char)sci.CharAt(pos);
                }
                if (lastValid <= sci.CurrentPos)
                {
                    sci.SetSel(lastValid, sci.CurrentPos);
                    try
                    {
                        data["snippet"] = expandExpression(sci.SelText);
                    }
                    catch (ZenExpandException zex)
                    {
                        // error in expression, no snippet display
                        Console.WriteLine(zex.Message);
                        return true;
                    }
                    // insert modified snippet or show snippet list
                    return false; 
                }
            }
            return false;
        }

        static public string expandExpression(string expr)
        {
            init();

            if (expandos.ContainsKey(expr)) expr = (string)expandos[expr];
            if (expr.Length == 0) 
                return "";

            string src = expr[0] == '<' ? expr : expandZen(expr);
            int p = src.IndexOf('|');
            src = src.Replace("|", "");
            return src.Substring(0, p) + "$(EntryPoint)" + src.Substring(p);
        }

        private static string expandZen(string expr)
        {
            if (expr.Length == 0) 
                throw new ZenExpandException("Empty expression found");

            string src = "";
            string[] parts = expr.Split('>');
            Array.Reverse(parts);
            bool inline = true;
            foreach (string part in parts)
            {
                if (part.Length == 0)
                    throw new ZenExpandException("Empty sub-expression found (sub1>sub2)");

                string subSrc = src;
                src = "";
                string[] sparts = part.Split('+');
                foreach (string spart in sparts)
                {
                    if (spart.Length == 0)
                        throw new ZenExpandException("Empty sub-expression part found (part1+part2)");

                    int multiply = 1;
                    string tag = spart;
                    string mult = extractEnd('*', ref tag);
                    if (mult != null)
                    {
                        multiply = -1;
                        int.TryParse(mult, out multiply);
                        if (multiply < 0)
                            throw new ZenExpandException("Invalid multiplier value (" + mult + ")");
                    }
                    string css = "";
                    string cssClass;
                    do
                    {
                        cssClass = extractEnd('.', ref tag);
                        if (cssClass != null) css = cssClass + " " + css;
                    }
                    while (cssClass != null);
                    string id = extractEnd('#', ref tag);

                    string attr = "";
                    if (id != null) attr += " id=\"" + id + "\"";
                    if (css.Length > 0) attr += " class=\"" + css.Trim() + "\"";
                    bool closedTag = false;
                    if (expandos.ContainsKey(tag))
                    {
                        tag = (string)expandos[tag];
                        if (tag[0] == '<') closedTag = true;
                    }
                    if (attribs.ContainsKey(tag)) attr += " " + (string)attribs[tag];
                    extractEnd(':', ref tag);

                    string master;
                    string temp = spart == sparts[sparts.Length - 1] ? subSrc : "";
                    if (closedTag)
                    {
                        inline = true;
                        if (tag.Length > 2 && tag[1] != '!')
                        {
                            int sp = tag.IndexOf(' ');
                            master = tag.Substring(0, sp) + attr + tag.Substring(sp);
                        }
                        else master = tag;
                    }
                    else
                    {
                        string wrapIn = "";
                        string wrapOut = "";
                        if (temp.Length > 0 && !inline)
                        {
                            wrapIn = "\n" + "\t";
                            wrapOut = "\n";
                            temp = addIndent(temp);
                        }
                        if (temp.Length == 0) temp = "|";

                        inline = sparts.Length == 1 && isInline(tag);
                        master = "<" + tag + attr + ">" + wrapIn + temp + wrapOut + "</" + tag + ">";
                    }

                    for (int i = 1; i <= multiply; i++)
                    {
                        src += master.Replace("$", i.ToString());
                        if (!inline) src += "\n";
                    }
                }
            }
            return src;
        }

        private static string addIndent(string res)
        {
            string[] lines = res.Split('\n');
            res = "";
            foreach (string line in lines) res += "\t" + line + "\n";
            return res.Trim();
        }

        private static bool isInline(string tag)
        {
            return tag == "a" || tag == "span"
                || tag == "b" || tag == "strong" || tag == "i" || tag == "em"
                || tag == "s" || tag == "strike" || tag == "tt"
                || tag == "big" || tag == "small"
                || tag == "dd" || tag == "dt";
        }

        private static string extractEnd(char sep, ref string part)
        {
            int p = part.LastIndexOf(sep);
            if (p == 0)
                throw new ZenExpandException("Empty '" + sep + "' argument found (" + part + ")");
            if (p > 0)
            {
                string ret = part.Substring(p + 1);
                part = part.Substring(0, p);
                return ret;
            }
            return null;
        }
    }

    public class ZenExpandException : Exception
    {
        public ZenExpandException(string message) : base(message) { }
    }
}
