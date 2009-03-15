using System;
using System.Collections.Generic;
using System.Text;
using WeifenLuo.WinFormsUI.Docking;
using PluginCore.Localization;
using PluginCore;
using System.Drawing;
using FdbPlugin.Controls;
using System.Windows.Forms;

namespace FdbPlugin
{
    internal class PanelsHelper
    {
        static public String pluginGuid = "3721fb83-114f-46dc-b022-27c63cc9e878";
        static public DockContent pluginPanel;
        static public PluginUI pluginUI;

        static public String breakPointGuid = "59518ab2-83f8-44cd-953f-66731aaff3c7";
        static public DockContent breakPointPanel;
        static public BreakPointUI breakPointUI;

        static public String stackframeGuid = "e5dac885-3d0f-47bb-ae77-86bd8da44983";
        static public DockContent stackframePanel;
        static public StackframeUI stackframeUI;

        static public QuickWatchForm quickWatchForm;

        public PanelsHelper(PluginMain pluginMain, Image pluginImage)
        {
            pluginUI = new PluginUI(pluginMain);
            pluginUI.Text = TextHelper.GetString("FdbPlugin.Title.LocalVariables");
            pluginPanel = PluginBase.MainForm.CreateDockablePanel(pluginUI, pluginGuid, pluginImage, DockState.Hidden);

            pluginUI.TreeControl.Tree.Expanding += new EventHandler<Aga.Controls.Tree.TreeViewAdvEventArgs>(LocalVariablesTreeExpanding);

            breakPointUI = new BreakPointUI(pluginMain, PluginMain.breakPointManager);
            breakPointUI.Text = "BreakPointList";
            breakPointPanel = PluginBase.MainForm.CreateDockablePanel(breakPointUI, breakPointGuid, pluginImage, DockState.Hidden);

            stackframeUI = new StackframeUI(pluginMain, MenusHelper.imageList);
            stackframeUI.Text = "Stackframe";
            stackframeUI.CallFrameEvent += new Action<string>(stackframeUI_CallFrameEvent);
            stackframePanel = PluginBase.MainForm.CreateDockablePanel(stackframeUI, stackframeGuid, pluginImage, DockState.Hidden);

            quickWatchForm = new QuickWatchForm();
            quickWatchForm.StartPosition = FormStartPosition.CenterParent;
            //quickWatchForm.EvaluateEvent += new EvaluateEventHandler(quickWatchForm_EvaluateEvent);
            //quickWatchForm.DataTreeExpandingEvent += new EvaluateEventHandler(quickWatchForm_DataTreeExpandingEvent)

            quickWatchForm.EvaluateEvent += new EvaluateEventHandler(delegate(object sender, EvaluateArgs e)
            {
                //fdbWrapper.Print(quickWatchForm, e.Exp, "evaluate");
                PluginMain.debugManager.PushPrint(quickWatchForm, e.Exp, "evaluate");
            });
            quickWatchForm.DataTreeExpandingEvent += new EvaluateEventHandler(delegate(object sender, EvaluateArgs e)
            {
                //fdbWrapper.Print(quickWatchForm, e.Exp, "expand");
                PluginMain.debugManager.PushPrint(quickWatchForm, e.Exp, "expand");
            });
        }

        void stackframeUI_CallFrameEvent(string obj)
        {
            //PluginMain.breakPointManager.FdbWrapper.FrameInfo(obj);
        }

        void LocalVariablesTreeExpanding(Object sender, Aga.Controls.Tree.TreeViewAdvEventArgs e)
        {
            if (e.Node.Index >= 0)
            {
                DataNode node = e.Node.Tag as DataNode;
                if (node.Nodes.Count == 0 && RegexManager.RegexObject.IsMatch(node.Value))
                {
                    pluginUI.TreeControl.Enabled = false;
                    String path = pluginUI.TreeControl.GetFullPath(node) + ".";
                    //fdbWrapper.Print(pluginUI, path, "expand");
                    PluginMain.debugManager.PushPrint(pluginUI, path, "expand");
                }
            }
        }

        //void quickWatchForm_DataTreeExpandingEvent(object sender, EvaluateArgs e)
        //{
        //    fdbWrapper.Print(quickWatchForm, e.Exp, "expand");
        //}

        //void quickWatchForm_EvaluateEvent(object sender, EvaluateArgs e)
        //{
        //    fdbWrapper.Print(quickWatchForm, e.Exp, "exp");
        //}

    }
}
