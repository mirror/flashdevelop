using System;
using System.Text;
using System.Collections.Generic;
using PluginCore.Utilities;
using PluginCore.Helpers;
using PluginCore;

namespace CodeRefactor.FRService
{
    public class FRConfiguration
    {
        /// <summary>
        /// Properties of the class 
        /// </summary> 
        protected String path;
        protected String mask;
        protected String source;
        protected Boolean recursive;
        protected List<String> files;
        protected OperationType type;
        protected FRSearch search;
        protected string replacement;

        /// <summary>
        /// Warning: if this property is not null, the text will be replaced when running a background search
        /// </summary>
        public string Replacement
        {
            get { return replacement; }
            set { replacement = value; }
        }

        /// <summary>
        /// 
        /// </summary> 
        protected enum OperationType
        {
            FindInSource,
            FindInFile,
            FindInPath,
            FindInRange
        }

        /// <summary>
        /// Constructor of the class 
        /// </summary> 
        public FRConfiguration(List<String> files, FRSearch search)
        {
            this.type = OperationType.FindInRange;
            this.search = search;
            this.files = files;
        }
        public FRConfiguration(String fileName, String source, FRSearch search)
        {
            this.type = OperationType.FindInSource;
            this.path = fileName;
            this.search = search;
            this.source = source;
        }
        public FRConfiguration(String fileName, FRSearch search)
        {
            this.type = OperationType.FindInFile;
            this.path = fileName;
            this.search = search;
        }
        public FRConfiguration(String path, String fileMask, Boolean recursive, FRSearch search)
        {
            this.path = path;
            this.type = OperationType.FindInPath;
            this.recursive = recursive;
            this.mask = fileMask;
            this.search = search;
        }

        /// <summary>
        /// 
        /// </summary> 
        public FRSearch GetSearch()
        {
            return this.search;
        }


        /*******************************************************/
        /*****   Changes to original FRService start here  *****/
        /*******************************************************/

        /// <summary>
        /// Get the source
        /// @param    file    Source file
        /// </summary> 
        public string GetSource(String file)
        {
            switch (type)
            {
                case OperationType.FindInSource:
                    return this.source;

                default:
                    return ReadCurrentFileSource(file);
            }
        }


        protected IDictionary<String, PluginCore.ITabbedDocument> m_OpenDocuments = null;

        /// <summary>
        /// 
        /// </summary>
        protected string ReadCurrentFileSource(String file)
        {
            if (m_OpenDocuments == null)
            {
                CacheOpenDocuments();
            }
            if (m_OpenDocuments.ContainsKey(file))
            {
                return m_OpenDocuments[file].SciControl.Text;
            }
            return FileHelper.ReadFile(file);
        }

        /// <summary>
        /// 
        /// </summary>
        protected void CacheOpenDocuments()
        {
            this.m_OpenDocuments = new Dictionary<String, PluginCore.ITabbedDocument>();
            foreach (PluginCore.ITabbedDocument document in PluginBase.MainForm.Documents)
            {
                if (document.IsEditable)
                {
                    this.m_OpenDocuments[document.FileName] = document;
                }
            }
        }

        /*******************************************************/
        /*****    Changes to original FRService end here   *****/
        /*******************************************************/

        /// <summary>
        /// Update the file source (ie. write the file)
        /// </summary>
        public void SetSource(string file, string src)
        {
            switch (type)
            {
                case OperationType.FindInSource:
                    this.source = src;
                    break;

                default:
                    int codepage = FileHelper.GetFileCodepage(file);
                    FileHelper.WriteFile(file, src, Encoding.GetEncoding(codepage));
                    break;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        public List<String> GetFiles()
        {
            switch (type)
            {
                case OperationType.FindInRange:
                    return this.files;

                case OperationType.FindInSource:
                    if (this.files == null)
                    {
                        this.files = new List<String>();
                        this.files.Add(path);
                    }
                    return files;

                case OperationType.FindInFile:
                    if (this.files == null)
                    {
                        this.files = new List<String>();
                        this.files.Add(path);
                    }
                    return this.files;

                case OperationType.FindInPath:
                    if (this.files == null)
                    {
                        PathWalker walker = new PathWalker(this.path, this.mask, this.recursive);
                        this.files = walker.GetFiles();
                    }
                    return this.files;
            }
            return null;
        }

    }

}
