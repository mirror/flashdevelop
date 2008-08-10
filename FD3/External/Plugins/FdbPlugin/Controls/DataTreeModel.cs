using System;
using System.Collections.Generic;
using System.Text;
using Aga.Controls.Tree;
using System.Threading;
using System.Collections.ObjectModel;

namespace FdbPlugin.Controls
{
    public class DataTreeModel : TreeModel
    {
        char[] chTrims = { '.' };
        public string GetFullPath(Node node)
        {
            if (node == Root)
                return string.Empty;
            else
            {
                string path = string.Empty;
                while (node != Root && node !=null)
                {
                    path = string.Format("{0}.{1}", node.Text, path);
                    node = node.Parent;
                }
                return path.TrimEnd(chTrims);
            }
        }

        public Node FindNode(string path)
        {
            if (path == string.Empty)
                return Root;
            else
                return FindNode(Root, path, 0);
        }

        private Node FindNode(Node root, string path, int level)
        {
            foreach (Node node in root.Nodes)
            {
                string ppp = this.GetFullPath(node);
                if (path == this.GetFullPath(node))
                {
                    return node;
                }
                else
                {
                    if (node.Nodes.Count > 0)
                    {
                        Node tmp = FindNode(node, path, level + 1);
                        if(tmp !=null)
                            return tmp;
                    }
                }
            }
            return null;
        }


        public List<DataNode> GetLeafList()
        {
            List<DataNode> list = new List<DataNode>();
            LeafList(Root, ref list);
            return list;
        }
        private void LeafList(Node root, ref List<DataNode> list)
        {
            foreach (Node node in root.Nodes)
            {
                if (node.Nodes.Count == 0)
                {
                    list.Add(node as DataNode);
                }
                else
                {
                    LeafList(node, ref list);
                }
            }
        }

        public List<DataNode> GetHasChildNodes()
        {
            List<DataNode> list = new List<DataNode>();
            HasChildNodes(Root, ref list);
            return list;
        }

        private void HasChildNodes(Node root, ref List<DataNode> list)
        {
            foreach (Node node in root.Nodes)
            {
                if (node.Nodes.Count != 0)
                {
                    list.Add(node as DataNode);
                    HasChildNodes(node, ref list);
                }
            }
        }
    }
}
