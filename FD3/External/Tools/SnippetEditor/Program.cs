using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace SnippetEditor
{
    static class Program
    {
        /// <summary>
        /// Entry point of the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new MainForm());
        }

    }

}