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

using Aga.Controls.Tree;

namespace FlexDbg.Controls
{
    public class DataTreeModel : TreeModel
    {
		static private char[] chTrims = { '.' };

        public string GetFullPath(Node node)
        {
            if (node == Root)
                return string.Empty;
            else
            {
                string path = string.Empty;
				while (node != Root && node != null)
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
                if (path == GetFullPath(node))
                {
                    return node;
                }
                else
                {
                    if (node.Nodes.Count > 0)
                    {
                        Node tmp = FindNode(node, path, level + 1);
                        if (tmp != null)
                            return tmp;
                    }
                }
            }
            return null;
        }
    }
}
