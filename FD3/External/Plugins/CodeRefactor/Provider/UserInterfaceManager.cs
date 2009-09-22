using System;
using System.Collections.Generic;
using System.Text;

using PluginCore;

using CodeRefactor.Commands;
using CodeRefactor.Controls;

namespace CodeRefactor.Provider
{
    internal static class UserInterfaceManager
    {
        private static CodeRefactor.Controls.ProgressDialog m_FindingReferencesDialogueMain;

        private static FlashDevelop.MainForm Main
        {
            get
            {
                return (PluginBase.MainForm as FlashDevelop.MainForm);
            }
        }

        internal static ProgressDialog FindingReferencesDialogueMain
        {
            get
            {
                if (m_FindingReferencesDialogueMain == null)
                {
                    m_FindingReferencesDialogueMain = new ProgressDialog();
                    Main.AddOwnedForm(m_FindingReferencesDialogueMain);
                }
                return m_FindingReferencesDialogueMain;
            }
        }
    }
}
