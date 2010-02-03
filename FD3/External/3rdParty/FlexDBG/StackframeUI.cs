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

namespace FlexDbg
{
    class StackframeUI : DockPanelControl
    {
        private ListView lv;
        private ColumnHeader imageColumnHeader;
        private ColumnHeader frameColumnHeader;
        private PluginMain pluginMain;

        private int currentImageIndex;

        public StackframeUI(PluginMain pluginMain, ImageList imageList)
        {
            this.pluginMain = pluginMain;

            lv = new ListView();
            this.imageColumnHeader = new ColumnHeader();
            this.imageColumnHeader.Text = string.Empty;
            this.imageColumnHeader.Width = 20;

            this.frameColumnHeader = new ColumnHeader();
            this.frameColumnHeader.Text = string.Empty;

            lv.Columns.AddRange(new ColumnHeader[] {
            this.imageColumnHeader,
            this.frameColumnHeader});
            lv.FullRowSelect = true;
            lv.BorderStyle = BorderStyle.None;
            lv.Dock = System.Windows.Forms.DockStyle.Fill;

            lv.SmallImageList = imageList;
            currentImageIndex = imageList.Images.IndexOfKey("StartContinue");

            lv.View = System.Windows.Forms.View.Details;
            lv.MouseDoubleClick += new MouseEventHandler(lv_MouseDoubleClick);
            lv.KeyDown += new KeyEventHandler(lv_KeyDown);
            lv.SizeChanged += new EventHandler(lv_SizeChanged);

            this.Controls.Add(lv);
        }

        void lv_SizeChanged(object sender, EventArgs e)
        {
            this.frameColumnHeader.Width = lv.Width - this.imageColumnHeader.Width;
        }

        public void ClearItem()
        {
            lv.Items.Clear();
        }

        public void ActiveItem()
        {
            foreach (ListViewItem item in lv.Items)
            {
                if (item.ImageIndex == currentImageIndex)
                {
                    item.ImageIndex = -1;
                    break;
                }
            }
			lv.SelectedItems[0].ImageIndex = currentImageIndex;
		}

        public void AddFrames(Frame[] frames)
        {
            lv.Items.Clear();

            if (frames.GetLength(0) > 0)
            {
                foreach (Frame item in frames)
                {
                    lv.Items.Add(new ListViewItem(new string[] {"", item.CallSignature}, -1));
                }

				lv.Items[0].ImageIndex = currentImageIndex;
            }
        }

        void lv_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Return)
            {
				if (lv.SelectedIndices.Count > 0)
				{
					PluginMain.debugManager.CurrentFrame = lv.SelectedIndices[0];
					ActiveItem();
				}
			}
        }

        void lv_MouseDoubleClick(object sender, MouseEventArgs e)
        {
			if (lv.SelectedIndices.Count > 0)
			{
				PluginMain.debugManager.CurrentFrame = lv.SelectedIndices[0];
				ActiveItem();
			}
        }
    }
}
