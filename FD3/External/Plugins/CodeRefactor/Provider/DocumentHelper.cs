using System;
using System.Collections.Generic;

using ASCompletion.Context;
using PluginCore;

using ScintillaNet;

namespace CodeRefactor.Provider
{

    /// <summary>
    /// A managing class for the retrieval and closting of temporary documents.
    /// Given the current architecture of FlashDevelop, this assists 
    /// Refactoring commands in keeping track of and closing any documents 
    /// that needed to be opened simply to check its class structure.
    /// </summary>
    public class DocumentHelper
    {

        private IDictionary<String, Boolean> m_FilesOpenedAndUsed = new Dictionary<String, Boolean>();
        private IDictionary<String, ITabbedDocument> m_FilesOpenedDocumentReferences = new Dictionary<String, ITabbedDocument>();
        private IDictionary<String, ITabbedDocument> m_InitiallyOpenedFiles;// = new Dictionary<String, ITabbedDocument>();

        private Boolean m_PreventClosing = false;

        /// <summary>
        /// Tracks files that have been opened.
        /// Key is the File Name.  Value is whether or not it's been used.
        /// If Value is false, it indicates the file is temporary and should be 
        /// closed.  If true, it indicates that even though the file was 
        /// opened, there is reportable/changed content in the file and it 
        /// should remain open.
        /// </summary>
        public IDictionary<String, Boolean> FilesOpenedAndUsed
        {
            get
            {
                return m_FilesOpenedAndUsed;
            }
            protected set
            {
                m_FilesOpenedAndUsed = value;
            }
        }

        /// <summary>
        /// Keeps track of opened files.  Provides reference to the files' 
        /// associated DockContent so that they may be closed.
        /// </summary>
        public IDictionary<String, ITabbedDocument> FilesOpenedDocumentReferences
        {
            get
            {
                return m_FilesOpenedDocumentReferences;
            }
            protected set
            {
                m_FilesOpenedDocumentReferences = value;
            }
        }

        public Boolean PreventClosing
        {
            get
            {
                return m_PreventClosing;
            }
            set
            {
                m_PreventClosing = value;
            }
        }

        /// <summary>
        /// Constructor. Creates a new helper.  Stores the current state of 
        /// open files at this time.  Therefore, if there are temporary files 
        /// already open, this instance will not consider those files to be 
        /// temporary.  Consider this when managing multiple DocumentHelpers.
        /// </summary>
        public DocumentHelper()
        {
            m_InitiallyOpenedFiles = GetOpenDocuments();
        }

        /// <summary>
        /// Retrieves a list of the currently open documents.
        /// </summary>
        protected IDictionary<String, ITabbedDocument> GetOpenDocuments()
        {
            IDictionary<String, ITabbedDocument> openedFiles = new Dictionary<String, ITabbedDocument>();
            
            foreach (ITabbedDocument openDocument in PluginBase.MainForm.Documents)
            {
                if (openDocument.IsEditable)
                {
                    openedFiles[openDocument.FileName] = openDocument;
                }
            }

            return openedFiles;
        }

        /// <summary>
        /// Flags the given file as used (not temporary).
        /// This will prevent it from being purged later on.
        /// </summary>
        public void MarkDocumentToKeep(String fileName)
        {
            if (m_FilesOpenedAndUsed.ContainsKey(fileName))
            {
                m_FilesOpenedAndUsed[fileName] = true;
            }
            else
            {
                LoadDocument(fileName);

                //repeat the code, but prevents accidental infinite recursion
                if (m_FilesOpenedAndUsed.ContainsKey(fileName))
                {
                    m_FilesOpenedAndUsed[fileName] = true;
                }
            }
        }

        /// <summary>
        /// Loads the given document into FlashDevelop.  
        /// If the document was not already previously opened, this will flag 
        /// it as a temporary file.
        /// </summary>
        public ScintillaControl LoadDocument(String fileName)
        {
            ITabbedDocument newDocument = (ITabbedDocument)PluginBase.MainForm.OpenEditableDocument(fileName);

            RegisterLoadedDocument(newDocument);

            return ASContext.CurSciControl;
        }

        public void RegisterLoadedDocument(ITabbedDocument document)
        {
            //if it's null, it means it was already opened, or the caller sent us garbage
            if (document != null && !m_FilesOpenedAndUsed.ContainsKey(document.FileName))
            {
                //newly opened document.  Let's store it so we can close it later if it's not part of our result set.
                //false to indicate that it so far hasn't found any matching entries.
                m_FilesOpenedAndUsed.Add(document.FileName, false);
                m_FilesOpenedDocumentReferences.Add(document.FileName, document);
            }
        }

        /// <summary>
        /// Closes the given document and purges the stored indices for it.
        /// If the document is part of the initially opened files list, it 
        /// will not be closed or purged.
        /// </summary>
        public Boolean CloseDocument(String fileName)
        {
            if (m_FilesOpenedDocumentReferences.ContainsKey(fileName) && !m_InitiallyOpenedFiles.ContainsKey(fileName))
            {
                m_FilesOpenedDocumentReferences[fileName].Close();

                m_FilesOpenedAndUsed.Remove(fileName);
                m_FilesOpenedDocumentReferences.Remove(fileName);
                return true;
            }
            return false;
        }

        /// <summary>
        /// Closes all temporary documents.
        /// </summary>
        public void CloseTemporarilyOpenedDocuments()
        {
            if (!this.PreventClosing)
            {
                // retrieve a list of documents to close
                List<String> documentsToClose = new List<string>();
                foreach (KeyValuePair<String, Boolean> openedAndUsedFile in m_FilesOpenedAndUsed)
                {
                    // if the value is true, it means the document was flagged as permanent/changed, so we shouldn't close it
                    if (!openedAndUsedFile.Value)
                    {
                        documentsToClose.Add(openedAndUsedFile.Key);
                    }
                }

                // close each document
                foreach (String fileName in documentsToClose)
                {
                    CloseDocument(fileName);
                }
            }
        }


    }
}
