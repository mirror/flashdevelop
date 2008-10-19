using System;
using System.IO;
using System.Text;
using System.Windows.Forms;
using System.Collections.Generic;
using System.Runtime.InteropServices;
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
            Session session = GetCurrentSession();
            SaveSession(file, session);
        }
        public static void SaveSession(String file, Session session)
        {
            try
            {
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
        public static void RestoreSession(String file, SessionType type)
        {
            try
            {
                Session session = new Session();
                session = (Session)ObjectSerializer.Deserialize(file, session);
                if (session.Files == null) session.Files = new List<string>();
                session.Type = type; // set the type here...
                RestoreSession(file, session);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }
        public static void RestoreSession(String file, Session session)
        {
            try
            {
                Globals.MainForm.RestoringContents = true;
                Globals.MainForm.CloseAllDocuments(false);
                if (!Globals.MainForm.CloseAllCanceled)
                {
                    DataEvent te = new DataEvent(EventType.RestoreSession, file, session);
                    EventManager.DispatchEvent(Globals.MainForm, te);
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
    public class Session : ISession
    {
        private Int32 index = 0;
        private List<String> files = new List<String>();
        private SessionType type = SessionType.Startup;

        public Session() {}
        public Session(Int32 index, List<String> files)
        {
            this.index = index;
            this.files = files;
        }
        public Session(Int32 index, List<String> files, SessionType type)
        {
            this.index = index;
            this.files = files;
            this.type = type;
        }

        public SessionType Type
        {
            get { return this.type; }
            set { this.type = value; }
        }
        public Int32 Index 
        {
            get { return this.index; }
            set { this.index = value; }
        }
        public List<String> Files
        {
            get { return this.files; }
            set { this.files = value; }
        }

    }

}
