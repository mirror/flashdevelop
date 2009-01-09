using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;

namespace EnhancedArguments.Controls
{
	public partial class ArgEditor : UserControl
	{
        /// <summary>
        /// Creates Argument editor
        /// </summary>
        /// <param name="arg">Name of argument</param>
        /// <param name="values">Comma seperated list of </param>
        /// 

		public ArgEditor(String arg, String[] values)
		{
			InitializeComponent();
            this.arg.Text = arg;
            if (values.Length > 0)
            {
                argValue.Items.AddRange(values);
                Value = values[0];
            }
		}

		protected override void OnGotFocus(EventArgs e)
		{
			base.OnGotFocus(e);
			argValue.Focus();
		}

		public String Arg
		{
			get { return arg.Text; }
			set { arg.Text = value; }
		}

		public String Value
		{
			get { return argValue.Text; }
            set { argValue.Text = value; }
		}

	}
}
