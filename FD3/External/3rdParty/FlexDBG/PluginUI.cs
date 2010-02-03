/*
    Copyright (C) 2009  Robert Nelson

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/

using System;
using System.Windows.Forms;
using Flash.Tools.Debugger;
using FlexDbg.Controls;
using PluginCore;

namespace FlexDbg
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

        #region SetDataInterface 

		public void Clear()
		{
			treeControl.Nodes.Clear();
		}

        public void SetData(Variable[] variables)
        {
            treeControl.Tree.BeginUpdate();
            try
            {
                foreach (Variable item in variables)
                {
					treeControl.AddNode(new DataNode(item));
                }
            }
            finally
            {
                treeControl.Tree.EndUpdate();
            }

			treeControl.Enabled = true;
        }

		#endregion
    }
}
