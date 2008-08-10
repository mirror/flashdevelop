using System;
using System.Drawing;
using System.Windows.Forms;
using System.Text;

// From: http://www.vesic.org/english/blog/winforms/full-screen-maximize/

namespace FlashDevelop.Controls
{
    /// <summary>
    /// Class used to preserve and restore state of the form
    /// </summary>
    public class FormState
    {
        private Boolean topMost;
        private FormWindowState winState;
        private FormBorderStyle borderStyle;
        private Rectangle windowBounds;

        /// <summary>
        /// Maximizes the form to fullscreen
        /// </summary>
        public void Maximize(Form form)
        {
            Save(form);
            form.TopMost = true;
            form.WindowState = FormWindowState.Maximized;
            form.FormBorderStyle = FormBorderStyle.None;
            Win32.SetWinFullScreen(form.Handle);
        }

        /// <summary>
        /// Saves the state before maximizing
        /// </summary>
        public void Save(Form form)
        {
            winState = form.WindowState;
            borderStyle = form.FormBorderStyle;
            windowBounds = form.Bounds;
            topMost = form.TopMost;
        }

        /// <summary>
        /// Restores the form to old state
        /// </summary>
        public void Restore(Form form)
        {
            form.WindowState = winState;
            form.FormBorderStyle = borderStyle;
            form.Bounds = windowBounds;
            form.TopMost = topMost;
        }

    }

}
