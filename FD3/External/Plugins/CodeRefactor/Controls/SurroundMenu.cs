using System;
using System.Collections.Generic;
using System.IO;
using System.Windows.Forms;
using PluginCore.Helpers;
using PluginCore.Localization;
using PluginCore.Utilities;

namespace CodeRefactor.CustomControls
{
    public class SurroundMenu : ToolStripMenuItem
    {
        private List<String> items;

        public SurroundMenu()
        {
            this.Text = TextHelper.GetString("Label.SurroundWith");
        }

        public void GenerateSnippets(ScintillaNet.ScintillaControl sci)
        {
            string surroundFolder = "surround";

            string content;
            PathWalker walker;
            List<String> files;
            String path;
            items = new List<String>();

            path = Path.Combine(PathHelper.SnippetDir, surroundFolder);
            if (Directory.Exists(path))
            {
                walker = new PathWalker(PathHelper.SnippetDir + surroundFolder, "*.fds", false);
                files = walker.GetFiles();
                foreach (String file in files)
                {
                    items.Add(file);
                }
            }
            
            path = Path.Combine(PathHelper.SnippetDir, sci.ConfigurationLanguage);
            path = Path.Combine(path, surroundFolder);
            if (Directory.Exists(path))
            {
                walker = new PathWalker(path, "*.fds", false);
                files = walker.GetFiles();
                foreach (String file in files)
                {
                    items.Add(file);
                }
            }
            if (items.Count > 0)
            {
                items.Sort();
            }

            this.DropDownItems.Clear();
            foreach (String itm in items)
            {
                content = File.ReadAllText(itm);
                if (content.IndexOf("{0}") > -1)
                {
                    this.DropDownItems.Insert(this.DropDownItems.Count,
                            new ToolStripMenuItem(Path.GetFileNameWithoutExtension(itm), null, new EventHandler(this.SurroundWithClicked)));
                }
            }
        }

        private void SurroundWithClicked(Object sender, EventArgs e)
        {
            
        }

    }
}
