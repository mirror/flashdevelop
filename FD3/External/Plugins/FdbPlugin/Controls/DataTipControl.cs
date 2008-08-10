using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using Aga.Controls.Tree;

namespace FdbPlugin.Controls
{
    public partial class DataTipControl : UserControl
    {
        public TreeViewAdv Tree
        {
            get { return this.dataTreeControl.Tree; }
        }

        public DataTreeControl DataTree
        {
            get { return this.dataTreeControl; }
        }

        public DataTipControl()
        {
            InitializeComponent();
        }
    }
}
