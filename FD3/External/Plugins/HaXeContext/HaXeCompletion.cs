using System;
using System.Text;
using System.Collections;

using System.Diagnostics;
using System.Xml;
using System.Text.RegularExpressions;

using PluginCore;
using PluginCore.Managers;
using ProjectManager.Projects.Haxe;
using System.IO;
using PluginCore.Helpers;

namespace HaXeContext
{
    class HaXeCompletion
    {
        Process p;
        int position;
        ScintillaNet.ScintillaControl sci;
        ArrayList tips;
         
        public HaXeCompletion(ScintillaNet.ScintillaControl sci, int position)
        {
            this.sci = sci;
            this.position = position;
            tips = new ArrayList();
        }

        private void initProcess()
        {
            // check haxe project & context
            if (PluginBase.CurrentProject == null || !(PluginBase.CurrentProject is HaxeProject)
                || !(Context.Context is HaXeContext.Context))
                return;

            PluginBase.MainForm.CallCommand( "SaveAllModified", null );
            
            HaxeProject hp = (PluginBase.CurrentProject as HaxeProject);
            HaxeOptions co = hp.CompilerOptions;

            // Classes "Always Compile"
            string classesToCompile = "";
            foreach (string ctc in hp.CompileTargets)
            {
                Array path = ctc.Split(new string[] { "\\" }, StringSplitOptions.RemoveEmptyEntries);
                string cl = path.GetValue(path.Length - 1).ToString();
                classesToCompile += " " + cl;
            }

            // output file 
            string output = "\"" + hp.OutputPath + "\"";

            // Check compiler command call consistency
            if (classesToCompile == "")
            {
                tips.Add("error");
                tips.Add("No class to compile");
                return;
            }
            else if (output == "\"\"")
            {
                tips.Add("error");
                tips.Add("Undefined output file");
                return;
            }

            // Project and Global classpath
            string cp = "";
            foreach (string i in ProjectManager.PluginMain.Settings.GlobalClasspaths)
                cp += " -cp \"" + i + "\"";
            foreach (string i in hp.AbsoluteClasspaths)
                cp += " -cp \"" + i + "\"";

            // haXelibs
            string libs = "";
            foreach (string i in co.Libraries)
                libs += " -lib " + i;

            // Additionnal compiler commands
            string addi = "";
            foreach (string i in co.Additional)
                addi += " " + i;

            // Current file
            string file = "\"" + PluginBase.MainForm.CurrentDocument.FileName + "\"";

            // Locate carret position
            Int32 pos = position + 1; // sci.CurrentPos;
            // locate a . or (
            while (pos > 1 && sci.CharAt(pos - 1) != '.' && sci.CharAt(pos - 1) != '(')
                pos--;
            if (sci.Encoding == System.Text.Encoding.UTF8)
                pos += 3; // BOM

            // Define the haXe target
            string target = "";
            int version = hp.MovieOptions.Version;
            if (version < 11)
            {
                target = "-swf-version " + version;
                target += " -swf " + output;
            }
            else if (version == 11)
                target = "-js " + output;
            else if (version == 12)
                target = "-neko " + output;

            // Build haXe command
            string hxml = target + " " + classesToCompile + cp + libs + addi;

            // Build haXe built-in completion command
            string args = hxml + " --display " + file + "@" + pos.ToString();

            // compiler path
            string haxePath = Environment.GetEnvironmentVariable("HAXEPATH");
            string customHaxePath = (Context.Context.Settings as HaXeSettings).HaXePath;
            if (customHaxePath != null && customHaxePath.Length > 0)
                haxePath = PathHelper.ResolvePath(customHaxePath);
            
            string process = Path.Combine(haxePath, "haxe.exe");
            if (!File.Exists(process))
            {
                ErrorManager.ShowInfo("haxe.exe can not be located.\n\n"
                    + "Please run 'haxesetup' in haxe installation and restart FlashDevelop,\nor "
                    + "configure the path to haxe installation in HaxeContext settings.");
                p = null;
                return;
            }

            // Run haXe compiler
            p = new Process();           
            p.StartInfo.FileName = process;
            p.StartInfo.Arguments = args;
            p.StartInfo.UseShellExecute = false;
            p.StartInfo.RedirectStandardError = true;
            p.StartInfo.CreateNoWindow = true;
            p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
            p.StartInfo.WorkingDirectory = hp.Directory;
            p.EnableRaisingEvents = true;
        }

        private String htmlUnescape(String s)
        {
            return s.Replace("&lt;", "<").Replace("&gt;", ">");
        }

        public ArrayList getList()
        {
            // Prepare haXe command
            initProcess();
            
            // If project is uncompletly set, return the errors
            if (p == null)
                return tips;
            else
                p.Start();
            
            // Parsing the haXe compiler output
            string[] lines = p.StandardError.ReadToEnd().Split('\n');
            string type = "";
            string error = "";

            for (int i = 0; i < lines.Length; i++)
            {
                String l = lines[i].Trim();
                
                if (l.Length == 0)
                    continue;
                // Get list of properties
                if (l == "<list>")
                {
                    ArrayList content = new ArrayList();
                    string xml = "";
                    while (++i < lines.Length)
                        xml += lines[i];
                    foreach (Match m in Regex.Matches(xml, "<i n=\"([^\"]+)\"><t>([^<]*)</t><d>([^<]*)</d></i>"))
                    {
                        ArrayList seq = new ArrayList();
                        seq.Add(m.Groups[1].Value);
                        seq.Add(htmlUnescape(m.Groups[2].Value));
                        seq.Add(htmlUnescape(m.Groups[3].Value));
                        content.Add(seq);
                    }

                    tips.Add("list");
                    tips.Add(content);

                    break;
                }
                // Get the type
                else if (l == "<type>")
                {
                    type = htmlUnescape(lines[++i].Trim('\r'));

                    tips.Add("type");
                    tips.Add(type);

                    break;
                }
                // Or get the errors
                else
                {
                    if (error == "")
                        error += l;
                    else
                        error += "\n" + l;
                }
            }
            p.Close();
            p = null;
            
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
