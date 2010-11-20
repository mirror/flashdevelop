﻿using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Managers;

namespace SourceControl.Sources.Mercurial
{
    class Status : BaseCommand
    {
        public event StatusResult OnResult;

        public string RootPath;

        StatusNode root = new StatusNode(".", VCItemStatus.Unknown);
        StatusNode temp;
        string dirty;
        string updatingPath;

        public Status(string path)
        {
            RootPath = path;
        }

        public StatusNode Get(string path)
        {
            StatusNode found = root.FindPath(path);
            if (found == null)
                found = new StatusNode(Path.GetFileName(path), VCItemStatus.Unknown);
            return found;
        }

        public void Update()
        {
            if (runner != null) return;

            temp = new StatusNode(".", VCItemStatus.Unknown);
            updatingPath = RootPath;

            if (dirty != null)
            {
                /*if (File.Exists(dirty)) dirty = Path.GetDirectoryName(dirty);
                StatusNode dirtyNode = root.FindPath(dirty);
                if (dirtyNode != null)
                    updatingPath = dirty;*/
                dirty = null;
            }
            Run("status -A", updatingPath);
        }

        public bool SetPathDirty(string path)
        {
            if (path == null) return false;
            if (dirty == null || dirty == "") { dirty = path; return true; }

            char sep = Path.DirectorySeparatorChar;
            string[] p1 = dirty.Split(sep);
            string[] p2 = path.Split(sep);

            int len = Math.Min(p1.Length, p2.Length);
            path = "";
            for (int i = 0; i < len; i++)
            {
                if (p1[i] == p2[i]) path += sep + p1[i];
                else break;
            }
            dirty = path.Length > 0 ? path.Substring(1) : null;
            return true;
        }

        override protected void runner_ProcessEnded(object sender, int exitCode)
        {
            runner = null;
            if (exitCode != 0)
            {
                String label = TextHelper.GetString("SourceControl.Label.UnableToGetRepoStatus");
                TraceManager.AddAsync(label + " (" + exitCode + ")");
            }

            if (updatingPath == RootPath) root = temp;
            /*else
            {
                StatusNode updateNode = root.FindPath(Path.GetDirectoryName(updatingPath));
                if (updateNode != null)
                {
                    if (updateNode.Parent == null) root = temp;
                    else
                    {
                        string name = Path.GetFileName(updatingPath);
                        if (updateNode.Children.ContainsKey(name))
                            updateNode.Children.Remove(name);
                        updateNode.Children.Add(name, temp);
                    }
                }
            }*/
            if (OnResult != null) OnResult(this);
        }

        override protected void runner_Output(object sender, string line)
        {
            int fileIndex = 0;
            if (line.Length < fileIndex) return;
            char c0 = line[0];
            char c1 = line[1];

            VCItemStatus s = VCItemStatus.Added;
            if (c0 == '?') s = VCItemStatus.Unknown;
            else if (c0 == '!') s = VCItemStatus.Missing;
            else if (c0 == 'A') s = VCItemStatus.Added;
            else if (c0 == 'C') s = VCItemStatus.UpToDate; // clean == UpToDate
            else if (c0 == 'I') s = VCItemStatus.Ignored;
            else if (c0 == 'M' || c1 == 'M') s = VCItemStatus.Modified;
            else if (c0 == 'R' || c1 == 'R') s = VCItemStatus.Deleted;

            if (s == VCItemStatus.Unknown) return;
            int p = line.IndexOf(" ");
            if (p > 0) line = line.Substring(p + 1);
            else line = line.Substring(fileIndex);
            temp.MapPath(line, s);
        }
    }

    delegate void StatusResult(Status sender);

    class StatusNode
    {
        public bool HasChildren;
        public string Name;
        public VCItemStatus Status;
        public StatusNode Parent;
        public Dictionary<string, StatusNode> Children;

        public StatusNode(string name, VCItemStatus status)
        {
            Name = name;
            Status = status;
        }

        /// <summary>
        /// Recursively find a path in the tree
        /// </summary>
        /// <returns>Last node of the path</returns>
        public StatusNode FindPath(string path)
        {
            if (path == ".") return this;

            int p = path.IndexOf(Path.DirectorySeparatorChar);
            string childName = p < 0 ? path : path.Substring(0, p);
            if (HasChildren && Children.ContainsKey(childName))
            {
                StatusNode child = Children[childName];
                if (p > 0) return child.FindPath(path.Substring(p + 1));
                else return child;
            }
            return null;
        }

        /// <summary>
        /// Recursively create (if needed) nodes to match the path
        /// </summary>
        /// <returns>Last node of the path</returns>
        public StatusNode MapPath(string path, VCItemStatus status)
        {
            int p = path.IndexOf(Path.DirectorySeparatorChar);
            if (p < 0) return AddChild(path, status, true);
            else return AddChild(path.Substring(0, p), status, false)
                .MapPath(path.Substring(p + 1), status);
        }

        private StatusNode AddChild(string name, VCItemStatus status, bool isLeaf)
        {
            if (name == ".")
            {
                if (status != VCItemStatus.Unknown) Status = status;
                return this;
            }

            // inherit child status
            if (Status < status && status > VCItemStatus.UpToDate)
                Status = status == VCItemStatus.Conflicted ? status : VCItemStatus.Modified;

            // add/retrieve child
            if (!isLeaf)
            {
                if (status > VCItemStatus.UpToDate && status != VCItemStatus.Conflicted)
                    status = VCItemStatus.Modified;
                else status = VCItemStatus.UpToDate;
            }

            StatusNode node = new StatusNode(name, status);
            node.Parent = this;
            if (!HasChildren)
            {
                HasChildren = true;
                Children = new Dictionary<string, StatusNode>();
                Children.Add(name, node);
            }
            else if (Children.ContainsKey(name))
            {
                return Children[name];
            }
            else Children.Add(name, node);
            return node;
        }
    }
}
