using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

namespace FdbPlugin
{
    class StackframeUI : DockPanelControl
    {
        private ListView lv;
        private ColumnHeader imageColumnHeader;
        private ColumnHeader frameColumnHeader;
        private PluginMain pluginMain;

        private int currnetImageIndex;

        public event Action<string> CallFrameEvent = null;

        public StackframeUI(PluginMain pluginMain, ImageList imageList)
        {
            this.pluginMain = pluginMain;

            lv = new ListView();
            this.imageColumnHeader = new ColumnHeader();
            this.imageColumnHeader.Text = string.Empty;
            this.imageColumnHeader.Width = 16;

            this.frameColumnHeader = new ColumnHeader();
            this.frameColumnHeader.Text = string.Empty;

            lv.Columns.AddRange(new ColumnHeader[] {
            this.imageColumnHeader,
            this.frameColumnHeader});
            lv.FullRowSelect = true;
            lv.Dock = System.Windows.Forms.DockStyle.Fill;

            lv.SmallImageList = imageList;
            currnetImageIndex = imageList.Images.IndexOfKey("Continue");

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
                if (item.ImageIndex == currnetImageIndex)
                {
                    item.ImageIndex = -1;
                    lv.SelectedItems[0].ImageIndex = currnetImageIndex;
                    break;
                }
            }
        }

        private string GetSelectFrameInfo()
        {
            if (lv.SelectedItems.Count > 0)
            {
                return lv.SelectedItems[0].SubItems[1].Text;
            }
            return string.Empty;
        }

        public void AddItem(List<string> data)
        {
            lv.Items.Clear();
            if (data.Count > 0)
            {
                foreach (string text in data)
                {
                    ListViewItem newitem = new ListViewItem(new string[] { "", text }, -1);
                    lv.Items.Add(newitem);
                }
                lv.Items[0].ImageIndex = currnetImageIndex;
            }
        }

        void lv_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Return)
            {
                string frame = GetSelectFrameInfo();
                if (CallFrameEvent != null && frame != string.Empty)
                    CallFrameEvent(frame);
            }
        }

        void lv_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            string frame = GetSelectFrameInfo();
            if (CallFrameEvent != null && frame != string.Empty)
                CallFrameEvent(frame);
        }
    }

}
