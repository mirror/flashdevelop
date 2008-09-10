using System;
using System.IO;
using System.Text;
using System.Windows.Forms;
using System.Collections.Generic;
using PluginCore.Localization;
using FlashDevelop.Helpers;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore;

namespace FlashDevelop.Managers
{
    class SessionManager
    {
        /// <summary>
        /// Saves the current session to a file
        /// </summary>
        public static void SaveSession(String file)
        {
            try
            {
                Session session = GetCurrentSession();
                ObjectSerializer.Serialize(file, session);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Loads and restores the saved session 
        /// </summary>
        public static void RestoreSession(String file, Boolean notify)
        {
            try
            {
                Session session = new Session();
                session = (Session)ObjectSerializer.Deserialize(file, session);
                RestoreSession(file, session, notify);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }
        public static void RestoreSession(String file, Session session, Boolean notify)
        {
            try
            {
                Globals.MainForm.RestoringContents = true;
                Globals.MainForm.CloseAllDocuments(false);
                if (!Globals.MainForm.CloseAllCanceled)
                {
                    TextEvent te = new TextEvent(EventType.RestoreSession, file);
                    if (notify) EventManager.DispatchEvent(Globals.MainForm, te);
                    if (!te.Handled)
                    {
                        for (Int32 i = 0; i < session.Files.Count; i++)
                        {
                            String fileToOpen = session.Files[i];
                            if (File.Exists(fileToOpen)) Globals.MainForm.OpenEditableDocument(fileToOpen);
                        }
                        if (Globals.MainForm.Documents.Length == 0)
                        {
                            NotifyEvent ne = new NotifyEvent(EventType.FileEmpty);
                            EventManager.DispatchEvent(Globals.MainForm, ne);
                            if (!ne.Handled) Globals.MainForm.New(null, null);
                        }
                        DocumentManager.ActivateDocument(session.Index);
                    }
                }
                Globals.MainForm.RestoringContents = false;
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Gets a session from the current documents
        /// </summary> 
        public static Session GetCurrentSession()
        {
            Session session = new Session();
            ITabbedDocument[] documents = Globals.MainForm.Documents;
            for (Int32 i = 0; i < documents.Length; i++)
            {
                ITabbedDocument document = documents[i];
                if (document.IsEditable && !document.IsUntitled)
                {
                    if (document == Globals.CurrentDocument)
                    {
                        session.Index = i;
                    }
                    session.Files.Add(document.FileName);
                }
            }
            return session;
        }

    }

    [Serializable]
    public class Session
    {
        public Int32 Index = 0;
        public List<String> Files = new List<String>();

        public Session() { }
        public Session(Int32 index, List<String> files)
        {
            this.Index = index;
            this.Files = files;
        }

    }

}
