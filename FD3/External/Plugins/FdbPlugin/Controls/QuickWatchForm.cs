using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Text.RegularExpressions;

namespace FdbPlugin.Controls
{
    public partial class QuickWatchForm : Form, ISetData
    {
        public event EvaluateEventHandler EvaluateEvent = null;
        public event EvaluateEventHandler DataTreeExpandingEvent = null;
        private DataTreeControl dataTree;

        public string Exp
        {
            set { ExpTextBox.Text = value; }
        }

        public QuickWatchForm()
        {
            InitializeComponent();

            dataTree = new DataTreeControl();
            dataTree.Dock = DockStyle.Fill;
            dataTree.Tree.Expanding +=new EventHandler<Aga.Controls.Tree.TreeViewAdvEventArgs>(Tree_Expanding);
            TreePanel.Controls.Add(dataTree);

            EvaluateButton.Click += delegate
            {
                if (EvaluateEvent != null && ExpTextBox.Text != string.Empty)
                {
                    EvaluateEvent(this, new EvaluateArgs(ExpTextBox.Text));
                }
            };

            CloseButton.Click += delegate
            {
                this.Close();
            };

            this.Shown += new EventHandler(QuickWatchForm_Shown);
        }

        void QuickWatchForm_Shown(object sender, EventArgs e)
        {
            dataTree.Nodes.Clear();
            if (EvaluateEvent != null && ExpTextBox.Text != string.Empty)
            {
                EvaluateEvent(this, new EvaluateArgs(ExpTextBox.Text));
            }
        }

        void  Tree_Expanding(object sender, Aga.Controls.Tree.TreeViewAdvEventArgs e)
        {
            if (DataTreeExpandingEvent != null)
            {
                DataNode node = e.Node.Tag as DataNode;
                DataTreeExpandingEvent(sender, new EvaluateArgs(dataTree.GetFullPath(node) + "."));
            }
        }

        public void EvaluateExp(string exp)
        {
            dataTree.Nodes.Clear();

            ExpTextBox.Text = exp;
            if (EvaluateEvent != null && ExpTextBox.Text != string.Empty)
            {
                EvaluateEvent(this, new EvaluateArgs(ExpTextBox.Text));
            }
        }

        #region ISetData メンバ

        public void SetData(string name, List<string> datalist, object option)
        {
            if ((string)option == "evaluate")
            {
                dataTree.Nodes.Clear();
                foreach (string data in datalist)
                {
                    Match m;
                    if ((m = RegexManager.RegexNameValue.Match(data)).Success)
                    {
                        dataTree.AddRootNode(new DataNode(m.Groups["name"].Value, m.Groups["value"].Value));
                    }
                }
            }
            else if ((string)option == "expand")
            {
                DataNode node = dataTree.GetNode(name.Trim(new char[]{ '.' }));
                if (node.Nodes.Count > 0)
                {
                    return;
                }
                foreach (string data in datalist)
                {
                    Match m;
                    if ((m = RegexManager.RegexNameValue.Match(data)).Success)
                    {
                        node.Nodes.Add(new DataNode(m.Groups["name"].Value, m.Groups["value"].Value));
                    }
                }
            }
        }

        public Control TargetControl
        {
            get { return this.dataTree.Tree; }
        }

        #endregion
    }

    public delegate void EvaluateEventHandler(object sender, EvaluateArgs e);
    public class EvaluateArgs : EventArgs
    {
        public string Exp;
        public EvaluateArgs(string exp)
        {
            this.Exp = exp;
        }
    }
}
