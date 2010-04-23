using System;
using System.Collections.Generic;
using System.Text;
using Aga.Controls.Tree;
using System.Text.RegularExpressions;

namespace AS3Context.Controls
{
    class ProfilerObjectsView
    {
        ObjectRefsGrid objectsGrid;
        Regex reStep = new Regex("([^\\[]+)\\[(.*):([0-9]+)\\]");

        public ProfilerObjectsView(ObjectRefsGrid grid)
        {
            objectsGrid = grid;
        }

        public void Clear()
        {
        }

        public void Display(string qname, string[] info)
        {
            ObjectRefsModel model = new ObjectRefsModel();

            foreach (string line in info)
            {
                ObjectRefsNode node = new ObjectRefsNode(qname, "","");

                string[] steps = line.Split(',');
                foreach (string step in steps)
                {
                    Match m = reStep.Match(step);
                    if (m.Success)
                    {
                        node.Nodes.Add(new ObjectRefsNode(m.Groups[1].Value, m.Groups[2].Value, m.Groups[3].Value));
                    }
                    else
                    {
                        node.Nodes.Add(new ObjectRefsNode(step, "", ""));
                    }
                }

                model.Root.Nodes.Add(node);
            }

            objectsGrid.Model = model;
        }
    }
}
