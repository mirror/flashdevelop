using System;
using System.Text;
using System.Windows.Forms;
using System.Collections.Generic;
using CodeRefactor.Commands;
using CodeRefactor.Controls;
using PluginCore;

namespace CodeRefactor.Provider
{
    internal static class UserInterfaceManager
    {
        private static ProgressDialog findingReferencesDialogMain;

        /// <summary>
        /// 
        /// </summary>
        private static Form Main
        {
            get
            {
                return PluginBase.MainForm as Form;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        internal static ProgressDialog FindingReferencesDialogueMain
        {
            get
            {
                if (findingReferencesDialogMain == null)
                {
                    findingReferencesDialogMain = new ProgressDialog();
                    Main.AddOwnedForm(findingReferencesDialogMain);
                }
                return findingReferencesDialogMain;
            }
        }

    }

}
