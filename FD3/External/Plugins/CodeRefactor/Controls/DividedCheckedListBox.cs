using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.Drawing;

namespace CodeRefactor.Controls
{
    class DividedCheckedListBox : CheckedListBox
    {
        private Color color = Color.FromArgb(255, 0, 0, 0);

        public DividedCheckedListBox()
        {
        }

        protected override void OnDrawItem(DrawItemEventArgs e)
        {
            string label = Items[e.Index].ToString();
            if (label.StartsWith("---"))
            {
                e.Graphics.FillRectangle(new SolidBrush(BackColor), e.Bounds);
                e.Graphics.DrawString(label.Substring(4), Font, Brushes.Gray, e.Bounds);
            }
            else base.OnDrawItem(e);
        }

    }
}
