using System;
using System.Collections.Generic;
using System.Text;
using Aga.Controls.Tree;
using Aga.Controls.Tree.NodeControls;
using PluginCore;

namespace AS3Context.Controls
{
    public class ObjectRefsGrid:TreeViewAdv
    {
        NodeTextBox methodTB;
        NodeTextBox fileTB;
        NodeTextBox lineTB;

        public ObjectRefsGrid()
        {
            BorderStyle = System.Windows.Forms.BorderStyle.None;
            Dock = System.Windows.Forms.DockStyle.Fill;
            GridLineStyle = GridLineStyle.HorizontalAndVertical;
            Font = PluginBase.Settings.DefaultFont;

            UseColumns = true;

            Columns.Add(new TreeColumn("Method", 300));
            Columns.Add(new TreeColumn("File", 200));
            Columns.Add(new TreeColumn("Line", 50));

            methodTB = new NodeTextBox();
            methodTB.DataPropertyName = "Method";
            methodTB.ParentColumn = Columns[0];
            methodTB.Font = PluginBase.Settings.DefaultFont;
            fileTB = new NodeTextBox();
            fileTB.DataPropertyName = "File";
            fileTB.ParentColumn = Columns[1];
            fileTB.Font = PluginBase.Settings.DefaultFont;
            lineTB = new NodeTextBox();
            lineTB.DataPropertyName = "Line";
            lineTB.ParentColumn = Columns[2];
            lineTB.Font = PluginBase.Settings.DefaultFont;

            NodeControls.Add(methodTB);
            NodeControls.Add(fileTB);
            NodeControls.Add(lineTB);
        }
    }

    public class ObjectRefsNode : Node
    {
        string method;
        string path;
        string file;
        string line;

        public ObjectRefsNode(string method, string file, string line)
        {
            this.method = method;
            this.path = file;
            this.file = file.Substring(file.LastIndexOf(';') + 1);
            this.line = line;
        }

        public String Method
        {
            get { return method; }
        }
        public String Path
        {
            get { return path; }
        }
        public String File
        {
            get { return file; }
        }
        public String Line
        {
            get { return line; }
        }
    }

    public class ObjectRefsModel : TreeModel
    {

    }
}
