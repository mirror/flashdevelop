using System;
using System.Text;
using System.Collections;

using System.Diagnostics;
using System.Threading;
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
        ScintillaNet.ScintillaControl sci;

        public HaXeCompletion(ScintillaNet.ScintillaControl sci)
        {
            this.sci = sci;
        }

        private void startProcess()
        {
            // check haxe project & context
            if (PluginBase.CurrentProject == null || !(PluginBase.CurrentProject is HaxeProject)
                || !(Context.Context is HaXeContext.Context))
                return;

            PluginBase.MainForm.CallCommand( "SaveAllModified", null );
            
            HaxeProject hp = (PluginBase.CurrentProject as HaxeProject);
            HaxeOptions co = hp.CompilerOptions;

            string mainClass = co.MainClass;
            string cp = "";
            foreach (string i in hp.AbsoluteClasspaths)
                cp += " -cp " + i;
            string libs = "";
            foreach (string i in co.Libraries)
                libs += " -lib " + i;

            string addi = "";
            foreach (string i in co.Additional)
                addi += " " + i;

            string file = PluginBase.MainForm.CurrentDocument.FileName;
            Int32 pos = sci.CurrentPos;
            if (sci.Encoding == System.Text.Encoding.UTF8)
                pos += 3; // BOM

            // locate a . or (
            while (pos > 1 && sci.CharAt(pos - 1) != '.' && sci.CharAt(pos - 1) != '(') 
                pos--;

            string target = "";

            int version = hp.MovieOptions.Version;

            if (version < 11)
            {
                target = "-swf-version " + version;
                target += " -swf " + hp.OutputPath;
            }
            else if (version == 11)
                target = "-js " + hp.OutputPath;
            else if (version == 12)
                target = "-neko " + hp.OutputPath;

            string hxml = target + " " + mainClass + cp + libs + addi;

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
            
            p = new Process();
            p.StartInfo.FileName = process;
            p.StartInfo.Arguments = args;
            p.StartInfo.UseShellExecute = false;
            p.StartInfo.RedirectStandardError = true;
            p.StartInfo.CreateNoWindow = true;
            p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
            p.EnableRaisingEvents = true;
            p.Start();
        }

        private String htmlUnescape(String s)
        {
            return s.Replace("&lt;", "<").Replace("&gt;", ">");
        }

        public ArrayList getList()
        {
            startProcess();
            if (p == null) return null;

            string[] lines = p.StandardError.ReadToEnd().Split('\n');
            string type = "";

            ArrayList tips = new ArrayList();
            
            for (int i = 0; i < lines.Length; i++)
            {
                String l = lines[i].Trim('\r');
                
                if (l.Length == 0)
                    continue;

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
                        content.Add( seq );
                    }

                    tips.Add("list");
                    tips.Add(content);

                    break;
                }
                else if (l == "<type>")
                {
                    type = htmlUnescape(lines[++i].Trim('\r'));
                    
                    tips.Add("type");
                    tips.Add(type);

                    break;
                }
                else
                {
                    tips.Add("error");
                    tips.Add(l);
                    break;
                }
            }
            p.Close();
            p = null;
                       
            return tips;
        }

    }
}
