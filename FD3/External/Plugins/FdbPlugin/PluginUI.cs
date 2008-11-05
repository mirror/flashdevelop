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
    class PluginUI : DockPanelControl, ISetData
    {
        private PluginMain pluginMain;
        private DataTreeControl treeControl;

        public PluginUI(PluginMain pluginMain)
        {
            this.pluginMain = pluginMain;
            this.treeControl = new DataTreeControl();
            this.treeControl.Tree.BorderStyle = BorderStyle.None;
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

        private static Char[] chTrims = { '.' };
        #region SetDataInterface ãƒ¡ãƒ³ãƒ

        public void SetData(string name, List<string> datalist, object option)
        {
            treeControl.Tree.BeginUpdate();

            if ((string)option == "expand")
            {
                DataNode node = treeControl.GetNode(name.Trim(chTrims));
                if (node.Nodes.Count > 0) return;
                foreach (String data in datalist)
                {
                    Match m = RegexManager.RegexNameValue.Match(data);
                    node.Nodes.Add(new DataNode(m.Groups["name"].Value, m.Groups["value"].Value));
                }
            }
            else
            {
                foreach (string buf in datalist)
                {
                    Match m = RegexManager.RegexNameValue.Match(buf);
                    string objname = m.Groups["name"].Value.Trim();
                    string objvalue = m.Groups["value"].Value.Trim();

                    DataNode node = treeControl.GetNode(objname.Trim(chTrims));
                    if (node != null)
                    {
                        node.Value = objvalue;
                    }
                }
            }

            treeControl.Tree.EndUpdate();
            treeControl.Enabled = true;
        }

        public Control TargetControl
        {
            get { return this.treeControl; }
        }

        #endregion
    }

}
