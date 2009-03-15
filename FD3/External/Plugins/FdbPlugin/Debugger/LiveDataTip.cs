using System;
using System.Collections.Generic;
using System.Text;
using FdbPlugin.Controls;
using PluginCore;
using PluginCore.Controls;
using System.Windows.Forms;
using System.Drawing;
using ScintillaNet;

namespace FdbPlugin
{
    class LiveDataTip
    {
        static internal DataTip dataTip;

        static private string exclude = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM0123456789_$.";
        private Point dataTipPoint;
        private MouseMessageFilter mouseMessageFilter;

        public LiveDataTip()
        {
            if (dataTip == null) dataTip = new DataTip(PluginBase.MainForm);
            dataTip.DataTree.Tree.Expanding += new EventHandler<Aga.Controls.Tree.TreeViewAdvEventArgs>(DataTipTree_Expanding);

            mouseMessageFilter = new MouseMessageFilter();
            mouseMessageFilter.AddControls(dataTip.Controls);
            mouseMessageFilter.MouseDownEvent += new MouseDownEventHandler(mouseMessageFilter_MouseDownEvent);
            Application.AddMessageFilter(mouseMessageFilter);

            UITools.Manager.OnMouseHover += new UITools.MouseHoverHandler(Manager_OnMouseHover);
        }

        void fdbWrapper_PrintQuickWatchEvent(object sender, PrintArg e)
        {
            dataTip.DataTree.Invoke((MethodInvoker)delegate()
            {
                Point p = new Point(200, 200);
                dataTip.Show(p, e.valname, e.output);
            });
        }

        private void mouseMessageFilter_MouseDownEvent(MouseButtons button, Point e)
        {
            if (dataTip.Visible && !dataTip.contextMenuStrip.Visible && !dataTip.DataTree.Viewer.Visible)
            {
                dataTip.Hide();
            }
        }

        private void Manager_OnMouseHover(ScintillaControl sci, Int32 position)
        {
            FdbWrapper fdbWrapper = PluginMain.debugManager.FdbWrapper;

            if (!PluginBase.MainForm.EditorMenu.Visible
                && fdbWrapper != null && fdbWrapper.IsDebugStart
                && (fdbWrapper.State == FdbState.BREAK || fdbWrapper.State == FdbState.NEXT 
                    || fdbWrapper.State == FdbState.STEP || fdbWrapper.State == FdbState.EXCEPTION))
            {
                if (CurrentDebugPostion.fullpath != PluginBase.MainForm.CurrentDocument.FileName) return;
                if (UITools.Tip.Visible)
                    UITools.Tip.Hide();

                dataTipPoint = ((Form)PluginBase.MainForm).PointToClient(Control.MousePosition);
                if (dataTip.Visible && dataTip.Location.X <= dataTipPoint.X && (dataTip.Location.X + dataTip.Width) >= dataTipPoint.X && dataTip.Location.Y <= dataTipPoint.Y && (dataTip.Location.Y + dataTip.Height) >= dataTipPoint.Y)
                    return;

                position = sci.WordEndPosition(position, true);
                String leftword = GetWordRes(sci, position);
                if (leftword != String.Empty)
                {
                    dataTip.Location = dataTipPoint;
                    //fdbWrapper.Print(dataTip, leftword);
                    PluginMain.debugManager.PushPrint(dataTip, leftword, null);
                }
            }
        }

        private void DataTipTree_Expanding(Object sender, Aga.Controls.Tree.TreeViewAdvEventArgs e)
        {
            if (e.Node.Index >= 0)
            {
                DataNode node = e.Node.Tag as DataNode;
                if (RegexManager.RegexObject.IsMatch(node.Value))
                {
                    String path = dataTip.DataTree.GetFullPath(node) + ".";
                    //fdbWrapper.Print(dataTip, path, "expand");
                    PluginMain.debugManager.PushPrint(dataTip, path, "expand");
                }
            }
        }

        private String GetWordRes(ScintillaControl sci, Int32 position)
        {
            Char c; String word = "";
            position--;
            while (position >= 0)
            {
                c = (Char)sci.CharAt(position);
                if (exclude.IndexOf(c) < 0) break;
                else word = c + word;
                position--;
            }
            return word;
        }
    }
}
