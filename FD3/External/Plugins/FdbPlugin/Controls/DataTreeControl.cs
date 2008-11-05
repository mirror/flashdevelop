using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using Aga.Controls.Tree;
using System.Text.RegularExpressions;
using System.Collections.ObjectModel;
using PluginCore;
using FdbPlugin.Properties;

namespace FdbPlugin.Controls
{
    public partial class DataTreeControl : UserControl
    {
        private DataTreeModel _model;
        private static ViewerForm viewerForm = null;
        private ContextMenuStrip _contextMenuStrip;
        private ToolStripMenuItem copyMenuItem, viewerMenuItem;

        public Collection<Node> Nodes
        {
            get { return _model.Root.Nodes; }
        }

        public TreeViewAdv Tree
        {
            get { return _tree; }
        }

        public ViewerForm Viewer
        {
            get { return viewerForm; }
        }

        public DataTreeControl()
        {
            InitializeComponent();

            _model = new DataTreeModel();
            _tree.Model = _model;
            this.Controls.Add(_tree);

            _contextMenuStrip = new ContextMenuStrip();
            _tree.ContextMenuStrip = _contextMenuStrip;
            copyMenuItem = new ToolStripMenuItem("Copy", null, new EventHandler(this.CopyItemClick));
            viewerMenuItem = new ToolStripMenuItem("Viewer", null, new EventHandler(this.ViewerItemClick));
            _contextMenuStrip.Items.AddRange(new ToolStripMenuItem[] { copyMenuItem, viewerMenuItem});

            viewerForm = new ViewerForm();
            viewerForm.StartPosition = FormStartPosition.Manual;
        }

        public DataNode AddRootNode(DataNode node)
        {
            _model.Root.Nodes.Add(node);
            return node;
        }

        public DataNode AddNode(string fullpath, DataNode node)
        {
            DataNode n = GetNode(fullpath);
            if (n != null)
            {
                n.Nodes.Add(node);
                return node;
            }
            return null;
        }

        public DataNode GetNode(string fullpath)
        {
            DataNode node = _model.FindNode(fullpath) as DataNode;
            return node;
        }

        public List<DataNode> AllLeaf
        {
            get { return _model.GetLeafList(); }
        }

        public List<DataNode> AllHasChildNodes
        {
            get { return _model.GetHasChildNodes(); }
        }

        public string GetFullPath(DataNode node)
        {
            return _model.GetFullPath(node);
        }


        private void CopyItemClick(Object sender, System.EventArgs e)
        {
            if (Tree.SelectedNode != null)
            {
                DataNode node = Tree.SelectedNode.Tag as DataNode;
                Clipboard.SetText(string.Format("{0} = {1}",node.Text, node.Value));
            }  
        }
        private void ViewerItemClick(Object sender, System.EventArgs e)
        {
            if (Tree.SelectedNode != null)
            {
                if (viewerForm == null)
                {
                    viewerForm = new ViewerForm();
                    viewerForm.StartPosition = FormStartPosition.Manual;
                }
                DataNode node = Tree.SelectedNode.Tag as DataNode;
                viewerForm.Exp = node.Text;
                viewerForm.Value = node.Value;
                Form mainform = (PluginBase.MainForm as Form);
                viewerForm.Left = mainform.Left + mainform.Width / 2 - viewerForm.Width / 2;
                viewerForm.Top = mainform.Top + mainform.Height / 2  - viewerForm.Height / 2;
                viewerForm.ShowDialog();
            }
        }
    }
}
