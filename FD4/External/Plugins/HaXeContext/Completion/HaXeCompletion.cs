using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using ASCompletion.Context;
using PluginCore;
using ProjectManager.Projects.Haxe;
using ScintillaNet;

namespace HaXeContext
{
    internal class HaXeCompletion
    {
        private static readonly Regex reListEntry = new Regex("<i n=\"([^\"]+)\"><t>([^<]*)</t><d>([^<]*)</d></i>",
                                                              RegexOptions.Compiled | RegexOptions.Singleline);
        private static readonly Regex reArg = new Regex("^(-[a-z0-9-]+)\\s*([^\"'].*)$", 
                                                        RegexOptions.Compiled | RegexOptions.IgnoreCase);

        private readonly int position;
        private readonly IHaxeCompletionHandler handler;
        private readonly ScintillaControl sci;
        private readonly ArrayList tips;
        private int nbErrors;

        public HaXeCompletion(ScintillaControl sci, int position, IHaxeCompletionHandler handler)
        {
            this.sci = sci;
            this.position = position;
            this.handler = handler;
            tips = new ArrayList();
            nbErrors = 0;
        }

        public ArrayList getList()
        {
            return parseLines(handler.GetCompletion(buildHxmlArgs()));
        }


        private static String htmlUnescape(String s)
        {
            return s.Replace("&lt;", "<").Replace("&gt;", ">");
        }


        private string[] buildHxmlArgs()
        {
            // check haxe project & context
            if (PluginBase.CurrentProject == null || !(PluginBase.CurrentProject is HaxeProject)
                || !(ASContext.Context is Context))
                return null;

            PluginBase.MainForm.CallCommand("SaveAllModified", null);

            var hp = (PluginBase.CurrentProject as HaxeProject);

            // Current file
            var file = PluginBase.MainForm.CurrentDocument.FileName;

            // Locate carret position
            var pos = position; // sci.CurrentPos;
            // locate a . or (
            while (pos > 1 && sci.CharAt(pos - 1) != '.' && sci.CharAt(pos - 1) != '(')
                pos--;

            try
            {
                var bom = new Byte[4];
                var fs = new FileStream(file, FileMode.Open, FileAccess.Read, FileShare.Read);
                if (fs.CanSeek)
                {
                    fs.Read(bom, 0, 4);
                    fs.Close();
                    if (bom[0] == 0xef && bom[1] == 0xbb && bom[2] == 0xbf)
                    {
                        pos += 3; // Skip BOM
                    }
                }
            }
            catch
            {
            }

            // Build haXe command
            var paths = ProjectManager.PluginMain.Settings.GlobalClasspaths.ToArray();
            var hxmlArgs = new List<String>(hp.BuildHXML(paths, "__nothing__", true));
            // quote
            for (int i = 0; i < hxmlArgs.Count; i++)
            {
                string arg = hxmlArgs[i];
                if (!string.IsNullOrEmpty(arg))
                {
                    Match m = reArg.Match(arg);
                    if (m.Success)
                        hxmlArgs[i] = m.Groups[1].Value + " \"" + m.Groups[2].Value.Trim() + "\"";
                }
            }

            // Get the current class edited (ensure completion even if class not reference in the project)
            var start = file.LastIndexOf("\\") + 1;
            var end = file.LastIndexOf(".");
            var package = ASContext.Context.CurrentModel.Package;
            if (package != "")
            {
                var cl = ASContext.Context.CurrentModel.Package + "." + file.Substring(start, end - start);
                var libToAdd =
                    file.Split(
                        new[] {"\\" + String.Join("\\", cl.Split(new[] {"."}, StringSplitOptions.RemoveEmptyEntries))},
                        StringSplitOptions.RemoveEmptyEntries).GetValue(0).ToString();
                hxmlArgs.Add("-cp \"" + libToAdd + "\" " + cl);
            }
            else
                hxmlArgs.Add(file.Substring(start, end - start));

            hxmlArgs.Insert(0, "--display \"" + file + "\"@" + pos);
            hxmlArgs.Insert(1, "-D use_rtti_doc");
            if (hp.TraceEnabled) hxmlArgs.Insert(2, "-debug");

            return hxmlArgs.ToArray();
        }

        private ArrayList parseLines(string[] lines)
        {
            var type = "";
            var error = "";

            for (var i = 0; i < lines.Length; i++)
            {
                var l = lines[i].Trim();

                if (l.Length == 0)
                    continue;

                // Get list of properties
                switch (l)
                {
                    case "<list>":
                        {
                            var content = new ArrayList();
                            var xml = "";
                            while (++i < lines.Length)
                                xml += lines[i];
                            foreach (Match m in reListEntry.Matches(xml))
                            {
                                var seq = new ArrayList
                                              {
                                                  m.Groups[1].Value,
                                                  htmlUnescape(m.Groups[2].Value),
                                                  htmlUnescape(m.Groups[3].Value)
                                              };
                                content.Add(seq);
                            }

                            tips.Add("list");
                            tips.Add(content);

                            break;
                        }
                    case "<type>":
                        type = htmlUnescape(lines[++i].Trim('\r'));
                        tips.Add("type");
                        tips.Add(type);
                        break;
                    default:
                        if (l[0] == '<') continue;
                        if (l[0] == 1) continue; // ignore log
                        if (l[0] == 2) l = l.Substring(1);
                        if (nbErrors == 0)
                            error += l;
                        else if (nbErrors < 5)
                            error += "\n" + l;
                        else if (nbErrors == 5)
                            error += "\n...";
                        nbErrors++;
                        break;
                }
            }


            if (error != "")
            {
                tips.Clear();
                tips.Add("error");
                tips.Add(error);
            }
            return tips;
        }
    }
}
