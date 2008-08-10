using System;
using System.Text;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.Windows.Forms;
using FdbPlugin.Controls;
using Aga.Controls.Tree;
using PluginCore;

namespace FdbPlugin
{
    class PluginUI : DockPanelControl
    {
        private PluginMain pluginMain;
        private DataTreeControl treeControl;

        public PluginUI(PluginMain pluginMain)
        {
            this.pluginMain = pluginMain;
            this.treeControl = new DataTreeControl();
            this.treeControl.Tree.BorderStyle = BorderStyle.None;
            this.treeControl.Tree.Expanding += new EventHandler<TreeViewAdvEventArgs>(this.LocalVariablesTreeExpanding);
            this.treeControl.Resize += new EventHandler(this.TreeControlResize);
            this.treeControl.Tree.Font = PluginBase.Settings.DefaultFont;
            this.treeControl.Dock = DockStyle.Fill;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.treeControl);
        }

        /// <summary>
        /// 
        /// </summary>
        public DataTreeControl TreeControl 
        {
            get { return this.treeControl; }
        }

        /// <summary>
        /// 
        /// </summary>
        private void TreeControlResize(Object sender, EventArgs e)
        {
            Int32 w = this.treeControl.Width / 2;
            this.treeControl.Tree.Columns[0].Width = w;
            this.treeControl.Tree.Columns[1].Width = w - 8;
        }

        /// <summary>
        /// 
        /// </summary>
        private static Regex reObject = new Regex(@".*\[Object\s\d*, class='.*'\]", RegexOptions.Compiled);
        private void LocalVariablesTreeExpanding(Object sender, TreeViewAdvEventArgs e)
        {
            if (e.Node.Index >= 0)
            {
                DataNode node = e.Node.Tag as DataNode;
                if (reObject.IsMatch(node.Value))
                {
                    String path = this.treeControl.GetFullPath(node) + ".";
                    this.pluginMain.FdbWrapper.Print(path, PrintType.LOCALEXPAND);
                }
            }
        }

    }

}
