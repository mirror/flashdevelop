using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace FdbPlugin.Controls
{
    public partial class ViewerForm : Form
    {
        public string Exp
        {
            get { return ExptextBox.Text; }
            set { ExptextBox.Text = value; }
        }

        public string Value
        {
            get { return ValuetextBox.Text; }
            set { ValuetextBox.Text = value; }
        }

        public ViewerForm()
        {
            InitializeComponent();
        }

        private void ViewerForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            e.Cancel = true;
            this.Visible = false;
        }


        private void Closebutton_Click(object sender, EventArgs e)
        {
            this.Visible = false;
        }

        private void WordWrapcheckBox_CheckedChanged(object sender, EventArgs e)
        {
            ValuetextBox.WordWrap = WordWrapcheckBox.Checked;
        }

        private void CopyExpbutton_Click(object sender, EventArgs e)
        {
            Clipboard.SetText(ExptextBox.Text);
        }

        private void CopyValuebutton_Click(object sender, EventArgs e)
        {
            Clipboard.SetText(ValuetextBox.Text);
        }

        private void CopyAllbutton_Click(object sender, EventArgs e)
        {
            Clipboard.SetText(string.Format("{0} = {1}", ExptextBox.Text, ValuetextBox.Text));
        }

    }
}
