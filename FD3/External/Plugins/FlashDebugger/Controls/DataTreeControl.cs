using System;
using System.Drawing;
using System.Windows.Forms;
using Aga.Controls.Tree;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using Aga.Controls.Tree.NodeControls;
using Flash.Tools.Debugger;
using PluginCore.Localization;
using PluginCore;

namespace FlashDebugger.Controls
{
    public partial class DataTreeControl : UserControl
    {
        private DataTreeModel _model;
        private static ViewerForm viewerForm = null;
        private ContextMenuStrip _contextMenuStrip;
        private ToolStripMenuItem copyMenuItem, viewerMenuItem;

        public Collection<Node> Nodes
        {
            get
			{
				return _model.Root.Nodes;
			}
        }

        public TreeViewAdv Tree
        {
            get
			{
				return _tree;
			}
        }

        public ViewerForm Viewer
        {
            get
			{
				return viewerForm;
			}
        }

        public DataTreeControl()
        {
            InitializeComponent();
            _model = new DataTreeModel();
            _tree.Model = _model;
            this.Controls.Add(_tree);
			_tree.Expanding += new EventHandler<TreeViewAdvEventArgs>(TreeExpanding);
			_tree.LoadOnDemand = true;
			_tree.AutoRowHeight = true;
			NameNodeTextBox.IsEditEnabledValueNeeded += new EventHandler<NodeControlValueEventArgs>(NameNodeTextBox_IsEditEnabledValueNeeded);
			ValueNodeTextBox.DrawText += new EventHandler<DrawEventArgs>(ValueNodeTextBox_DrawText);
			ValueNodeTextBox.IsEditEnabledValueNeeded += new EventHandler<NodeControlValueEventArgs>(ValueNodeTextBox_IsEditEnabledValueNeeded);
			ValueNodeTextBox.EditorShowing += new System.ComponentModel.CancelEventHandler(ValueNodeTextBox_EditorShowing);
			ValueNodeTextBox.EditorHided += new EventHandler(ValueNodeTextBox_EditorHided);
			_contextMenuStrip = new ContextMenuStrip();
			if (PluginBase.MainForm != null && PluginBase.Settings != null)
			{
				_contextMenuStrip.Font = PluginBase.Settings.DefaultFont;
			}
			_tree.ContextMenuStrip = _contextMenuStrip;
            this.NameTreeColumn.Header = TextHelper.GetString("Label.Name");
            this.ValueTreeColumn.Header = TextHelper.GetString("Label.Value");
            copyMenuItem = new ToolStripMenuItem(TextHelper.GetString("Label.Copy"), null, new EventHandler(this.CopyItemClick));
            viewerMenuItem = new ToolStripMenuItem(TextHelper.GetString("Label.Viewer"), null, new EventHandler(this.ViewerItemClick));
            _contextMenuStrip.Items.AddRange(new ToolStripMenuItem[] { copyMenuItem, viewerMenuItem});
            viewerForm = new ViewerForm();
            viewerForm.StartPosition = FormStartPosition.Manual;
        }

		void NameNodeTextBox_IsEditEnabledValueNeeded(object sender, NodeControlValueEventArgs e)
		{
			e.Value = false;
		}

		void ValueNodeTextBox_EditorHided(object sender, EventArgs e)
		{
			NodeTextBox box = sender as NodeTextBox;
			DataNode node = box.Parent.CurrentNode.Tag as DataNode;
			node.IsEditing = false;
		}

		void ValueNodeTextBox_EditorShowing(object sender, System.ComponentModel.CancelEventArgs e)
		{
			NodeTextBox box = sender as NodeTextBox;
			DataNode node = box.Parent.CurrentNode.Tag as DataNode;
			node.IsEditing = true;
		}

		void ValueNodeTextBox_IsEditEnabledValueNeeded(object sender, NodeControlValueEventArgs e)
		{
            DataNode node = e.Node.Tag as DataNode;
			int type = node.Variable.getValue().getType();
			if (type != VariableType.BOOLEAN && type != VariableType.NUMBER && type != VariableType.STRING)
			{
				e.Value = false;
			}
		}

		void ValueNodeTextBox_DrawText(object sender, DrawEventArgs e)
		{
			DataNode node = e.Node.Tag as DataNode;
			if (node.Variable != null && node.Variable.hasValueChanged())
			{
				e.TextColor = Color.Red;
			}
		}

        public DataNode AddNode(DataNode node)
        {
			_model.Root.Nodes.Add(node);
            return node;
        }

        public DataNode GetNode(string fullpath)
        {
            DataNode node = _model.FindNode(fullpath) as DataNode;
            return node;
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
                viewerForm.Top = mainform.Top + mainform.Height / 2 - viewerForm.Height / 2;
                viewerForm.ShowDialog();
            }
        }

		void TreeExpanding(Object sender, TreeViewAdvEventArgs e)
        {
            if (e.Node.Index >= 0)
            {
                DataNode node = e.Node.Tag as DataNode;
				if (node.Nodes.Count == 0)
                {
					FlashInterface flashInterface = PluginMain.debugManager.FlashInterface;
					SortedList<DataNode, DataNode> nodes = new SortedList<DataNode, DataNode>();
					SortedList<DataNode, DataNode> inherited = new SortedList<DataNode, DataNode>();
					foreach (Variable member in node.Variable.getValue().getMembers(flashInterface.Session))
					{
						if ((member.Scope == VariableAttribute.PRIVATE_SCOPE && member.Level > 0) ||
							member.Scope == VariableAttribute.INTERNAL_SCOPE ||
							member.isAttributeSet(VariableAttribute.IS_STATIC))
						{
							// Flex Builder doesn't display these so we won't either.
							continue;
						}
						DataNode memberNode = new DataNode(member);
						if (member.Level > 0)
						{
							inherited.Add(memberNode, memberNode);
						}
						else
						{
							nodes.Add(memberNode, memberNode);
						}
					}
					if (inherited.Count > 0)
					{
						DataNode inheritedNode = new DataNode("[inherited]");
						foreach (DataNode item in inherited.Keys)
						{
							inheritedNode.Nodes.Add(item);
						}
						node.Nodes.Add(inheritedNode);
					}
					foreach (DataNode item in nodes.Keys)
					{
						node.Nodes.Add(item);
					}
                }
            }
        }

    }

}
