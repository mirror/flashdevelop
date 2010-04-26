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

using System;
using System.Windows.Forms;
using FlexDbg.Localization;

namespace FlexDbg.Controls
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
            InitializeLocalization();
        }

        private void InitializeLocalization()
        {
            this.label1.Text = TextHelper.GetString("Label.Exp");
            this.label2.Text = TextHelper.GetString("Label.Value");
            this.CopyAllbutton.Text = TextHelper.GetString("Label.CopyAll");
            this.WordWrapcheckBox.Text = TextHelper.GetString("Label.WordWrap");
            this.CopyValuebutton.Text = TextHelper.GetString("Label.CopyValue");
            this.CopyExpbutton.Text = TextHelper.GetString("Label.CopyExp");
            this.Closebutton.Text = TextHelper.GetString("Label.Close");
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
