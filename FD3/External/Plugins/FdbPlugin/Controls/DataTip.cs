using System;
using System.Collections.Generic;
using System.Text;
using PluginCore;
using System.Windows.Forms;
using System.Drawing;
using System.Text.RegularExpressions;

namespace FdbPlugin.Controls
{
    class DataTip
    {
        //public event MethodInvoker HideEvent = null;
        public event MethodInvoker UpDateDataFinishEvent = null;

        private Panel toolTip;
        private DataTipControl dataTipControl;
        private Cursor orgCursor;
        private bool mouseDownFlg = false;
        private Point mouseDownPoint = new Point();
        private Regex reNameValue = new Regex(@"(?<name>.*).*?(\s=\s)(?<value>.*)", RegexOptions.Compiled);
        char[] chTrims = { '.' };
        private List<Control> controls = new List<Control>();

        public DataTreeControl DataTree
        {
            get { return dataTipControl.DataTree; }
        }

        public List<Control> Controls
        {
            get { return controls; }
        }

        public ContextMenuStrip contextMenuStrip
        {
            get { return dataTipControl.DataTree.Tree.ContextMenuStrip; }
        }

        public int Height
        {
            get { return toolTip.Height; }
            set { toolTip.Height = value; }
        }

        public int Width
        {
            get { return toolTip.Width; }
            set { toolTip.Width = value; }
        }

        public bool Visible
        {
            get { return toolTip.Visible; }
        }

        public Point Location
        {
            get { return toolTip.Location; }
        }

        public Point PointToScreen(Point p)
        {
            return toolTip.PointToScreen(p);
        }

        private void DataTipAutoSize(int RawCont, Point DataTipLocation)
        {
            int h = (RawCont + 3) * dataTipControl.DataTree.Tree.RowHeight + dataTipControl.ResizepictureBox.Height;
            int r = (PluginBase.MainForm as Form).Height - DataTipLocation.Y - PluginBase.MainForm.StatusStrip.Height;
            if (h > r)
            {
                h = r - 8;
            }
            else
            {
                h += 8;
            }
            this.Height = h;

            r = (PluginBase.MainForm as Form).Width - DataTipLocation.X;
            if (this.Width > r)
            {
                this.Width = r-8;
            }
            else
            {
                this.Width += 8;
            }
        }

        public DataTip(IMainForm mainForm)
        {
            toolTip = new System.Windows.Forms.Panel();
            toolTip.Location = new System.Drawing.Point(0, 0);
            toolTip.BorderStyle = BorderStyle.FixedSingle;
            toolTip.Visible = false;
            (mainForm as Form).Controls.Add(toolTip);

            dataTipControl = new DataTipControl();
            dataTipControl.Dock = DockStyle.Fill;
            dataTipControl.BorderStyle = BorderStyle.None;
            dataTipControl.Visible = true;
            dataTipControl.ResizepictureBox.MouseEnter += new EventHandler(ResizepictureBox_MouseEnter);
            dataTipControl.ResizepictureBox.MouseLeave += new EventHandler(ResizepictureBox_MouseLeave);
            dataTipControl.ResizepictureBox.MouseDown += new MouseEventHandler(ResizepictureBox_MouseDown);
            dataTipControl.ResizepictureBox.MouseUp += new MouseEventHandler(ResizepictureBox_MouseUp);
            dataTipControl.ResizepictureBox.MouseMove += new MouseEventHandler(ResizepictureBox_MouseMove);
            dataTipControl.Tree.ShowLines = false;
            dataTipControl.Tree.Collapsed += new EventHandler<Aga.Controls.Tree.TreeViewAdvEventArgs>(Tree_Collapsed);
            toolTip.Controls.Add(dataTipControl);

            controls.AddRange(new Control[] { dataTipControl.DataTree, toolTip, dataTipControl.ResizepictureBox});
        }

        void Tree_Collapsed(object sender, Aga.Controls.Tree.TreeViewAdvEventArgs e)
        {
            curRawCount -= e.Node.Children.Count;
            DataTipAutoSize(curRawCount, toolTip.Location);
        }

        void ResizepictureBox_MouseMove(object sender, MouseEventArgs e)
        {
            if (Reflg)
            {
                Cursor.Current = Cursors.SizeNWSE;
            }
        }

        void ResizepictureBox_MouseUp(object sender, MouseEventArgs e)
        {
            if (mouseDownFlg)
            {
                toolTip.Height += (e.Y - mouseDownPoint.Y);
                toolTip.Width += (e.X - mouseDownPoint.X);
                Cursor.Current = orgCursor;
                dataTipControl.ResizepictureBox.Capture = false;
            }
            mouseDownFlg = false;
            Reflg = false;
        }

        void ResizepictureBox_MouseDown(object sender, MouseEventArgs e)
        {
            mouseDownFlg = true;
            Cursor.Current = Cursors.SizeNWSE;
            mouseDownPoint = e.Location;
            dataTipControl.ResizepictureBox.Capture = true;
        }
        bool Reflg = false;
        void ResizepictureBox_MouseLeave(object sender, EventArgs e)
        {
            Cursor.Current = orgCursor;
            Reflg = false;
        }

        void ResizepictureBox_MouseEnter(object sender, EventArgs e)
        {
            Reflg = true;
            orgCursor = Cursor.Current;
            Cursor.Current = Cursors.SizeNWSE;
        }

        int nameMaxW = 0;
        int valueMaxW = 0;
        int curRawCount = 0;
        public void AddNodes(string name, List<string> datalist)
        {
            DataNode node = dataTipControl.DataTree.GetNode(name.Trim(chTrims));
            if (node.Nodes.Count > 0)
            {
                return;
            }

            int nameMaxWtmp = 0;
            int valueMaxWtmp = 0;
            foreach (string data in datalist)
            {
                Match m = reNameValue.Match(data);

                int w = calcWidth(m.Groups["name"].Value);
                if (w > nameMaxWtmp) nameMaxWtmp = w;

                w = calcWidth(m.Groups["value"].Value);
                if (w > valueMaxWtmp) valueMaxWtmp = w;

                node.Nodes.Add(new DataNode(m.Groups["name"].Value, m.Groups["value"].Value));
            }

            int dispCount = 0;
            int pos = 0;
            int startpos =0;
            while(true)
            {
                pos = name.IndexOf(".", startpos);
                if (pos >= 0)
                {
                    dispCount++;
                    startpos = pos+1;
                }
                else
                    break;

                if (startpos > name.Length)
                    break;
            }

            int dispW = nameMaxWtmp + (dataTipControl.DataTree.Tree.Indent + 16) * (dispCount);
            if (dispW > nameMaxW)
                nameMaxW = dispW;
            //value
            dispW = valueMaxWtmp + dataTipControl.DataTree.Tree.Indent;
            if (dispW > valueMaxW)
                valueMaxW = dispW;

            dataTipControl.DataTree.Tree.Columns[0].Width = nameMaxW+8;// nameMaxW + dataTreeControl.Tree.Indent + 16;
            dataTipControl.DataTree.Tree.Columns[1].Width = valueMaxW;// valueMaxW + dataTreeControl.Tree.Indent;
            this.Width = dataTipControl.DataTree.Tree.Columns[0].Width + dataTipControl.DataTree.Tree.Columns[1].Width;

            curRawCount += datalist.Count;
            DataTipAutoSize(curRawCount, toolTip.Location);

            if (UpDateDataFinishEvent != null)
                UpDateDataFinishEvent();
        }

        public void Show(Point point, string valuename, List<string> datalist)
        {
            dataTipControl.DataTree.Nodes.Clear();
            foreach (string data in datalist)
            {
                Match m;
                if ((m = reNameValue.Match(data)).Success)
                {
                    int w = calcWidth(m.Groups["name"].Value);
                    if (w > nameMaxW) nameMaxW = w;

                    w = calcWidth(m.Groups["value"].Value);
                    if (w > valueMaxW) valueMaxW = w;

                    dataTipControl.DataTree.AddRootNode(new DataNode(m.Groups["name"].Value, m.Groups["value"].Value));
                }
            }
            if (dataTipControl.DataTree.Nodes.Count == 0)
            {
                curRawCount = 0;
                nameMaxW = calcWidth(valuename);
                valueMaxW = calcWidth("Expression could not be evaluated");
                dataTipControl.DataTree.AddRootNode(new DataNode(valuename, "Expression could not be evaluated"));
            }
            else
            {
                curRawCount = dataTipControl.DataTree.Nodes[0].Nodes.Count;
            }
            dataTipControl.DataTree.Tree.Columns[0].Width = nameMaxW + dataTipControl.DataTree.Tree.Indent + 8;
            dataTipControl.DataTree.Tree.Columns[1].Width = valueMaxW + dataTipControl.DataTree.Tree.Indent;
            this.Height = (curRawCount+3) * dataTipControl.DataTree.Tree.RowHeight + dataTipControl.ResizepictureBox.Height+8;
            this.Width = dataTipControl.DataTree.Tree.Columns[0].Width + dataTipControl.DataTree.Tree.Columns[1].Width+8;
            
            toolTip.Left = point.X;
            toolTip.Top = point.Y;
            toolTip.Visible = true;
            toolTip.BringToFront();
            toolTip.Focus();

            if (UpDateDataFinishEvent != null)
                UpDateDataFinishEvent();
        }

        public void Hide()
        {
            mouseDownFlg = false;
            toolTip.Visible = false;
            nameMaxW = 0;
            valueMaxW = 0;
        }

        private int calcWidth(string str)
        {
            int w = 0;
            using (Graphics g = ((Form)PluginBase.MainForm).CreateGraphics())
            {
                SizeF textSize = g.MeasureString(str, dataTipControl.DataTree.Tree.Font);
                w = (int)textSize.Width + 4;
            }
            return w;
        }

    }

    public delegate void MouseDownEventHandler(MouseButtons button, Point e);
    public class MouseMessageFilter : IMessageFilter
    {
        private const int WM_LBUTTONDOWN = 0x0201;
        public event MouseDownEventHandler MouseDownEvent = null;
        private List<Control> controllist;

        public void AddControls(List<Control> controls)
        {
            controllist = new List<Control>(controls);
        }

        #region IMessageFilter

        public bool PreFilterMessage(ref Message m)
        {
            if (m.Msg == WM_LBUTTONDOWN)
            {
                bool iscontain = false;
                foreach (Control c in controllist)
                {
                    iscontain = c.Contains(Control.FromHandle(m.HWnd));
                    if (iscontain) break;
                }
                if (!iscontain)
                {
                    MouseDownEvent(MouseButtons.Left, new Point(m.LParam.ToInt32()));
                }
            }
            return false;
        }

        #endregion
    }
}
