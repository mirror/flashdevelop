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
        /// Saves the current session
        /// </summary>
        public static void SaveSession(Session session)
        {
            try
            {
                String sessionFile = FileNameHelper.SessionData;
                ObjectSerializer.Serialize(sessionFile, session);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Loads the saved session 
        /// </summary> 
        public static void LoadSession()
        {
            try
            {
                String sessionFile = FileNameHelper.SessionData;
                if (File.Exists(sessionFile))
                {
                    Session session = new Session();
                    session = (Session)ObjectSerializer.Deserialize(sessionFile, session);
                    RestoreSession(session);
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Properties of the class 
        /// </summary>
        public static void RestoreSession(Session session)
        {
            try
            {
                Globals.MainForm.RestoringContents = true;
                Globals.MainForm.CloseAllDocuments(false);
                if (!Globals.MainForm.CloseAllCanceled)
                {
                    TextEvent te = new TextEvent(EventType.RestoreSession, session.ToString());
                    EventManager.DispatchEvent(Globals.MainForm, te);
                    if (!te.Handled)
                    {
                        for (Int32 i = 0; i < session.Files.Count; i++)
                        {
                            String file = session.Files[i];
                            if (File.Exists(file)) Globals.MainForm.OpenEditableDocument(file);
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

        /// <summary>
        /// Gets a string presentation of the session
        /// </summary>
        public override String ToString()
        {
            String result = this.Index.ToString() + "|";
            for (Int32 i = 0; i < this.Files.Count; i++)
            {
                result += this.Files[i] + ";";
            }
            return result.Substring(0, result.Length-1);
        }

    }

}
