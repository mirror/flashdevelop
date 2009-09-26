using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.Diagnostics;
using System.Windows.Forms;
using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Helpers;
using System.ComponentModel;
using System.Collections.Generic;

namespace ProjectManager.Controls.TreeView
{
	public class WorkingNode : GenericNode
	{
		public WorkingNode(string swfPath) : base(Path.Combine(swfPath, "invalid"))
		{
            Text = TextHelper.GetString("Info.Exploring");
			ImageIndex = SelectedImageIndex = Icons.Gear.Index;
			ForeColor = Color.Gray;
            NodeFont = new Font(PluginCore.PluginBase.Settings.DefaultFont, FontStyle.Regular);
		}

        public void SetErrorText(string msg)
        {
            Text = msg;
            ForeColor = Color.Red;
        }
	}

	public class FakeNode : GenericNode
	{
		public FakeNode(string filePath) : base(filePath) {}
	}

	public class ExportNode : FakeNode
	{
		public string Export;
		public string ContainingSwfPath;

		public ExportNode(string filePath, string export) : base(filePath+"::"+export)
		{
			ContainingSwfPath = filePath;
            if (export.IndexOf(' ') < 0) Export = export;
            else Export = export.Substring(0, export.IndexOf(' '));
			Text = export;
			ForeColorRequest = Color.Gray;
			ImageIndex = SelectedImageIndex = Icons.ImageResource.Index;
		}
	}

	public class ClassExportNode : ExportNode
	{
		public ClassExportNode(string filePath, string export) : base(filePath, export)
		{
			ImageIndex = SelectedImageIndex = Icons.Class.Index;
		}
    }

    public class FontExportNode : ExportNode
    {
        public FontExportNode(string filePath, string export)
            : base(filePath, export)
        {
            ImageIndex = SelectedImageIndex = Icons.Font.Index;
        }
    }

	public class ClassesNode : FakeNode
	{
		public ClassesNode(string filePath):  base(filePath+";__classes__")
		{
			Text = "Classes";
			ForeColorRequest = Color.Gray;
			ImageIndex = SelectedImageIndex = Icons.HiddenFolder.Index;
		}
    }

    public class SymbolsNode : FakeNode
    {
        public SymbolsNode(string filePath)
            : base(filePath + ";__symbols__")
        {
            Text = "Symbols";
            ForeColorRequest = Color.Gray;
            ImageIndex = SelectedImageIndex = Icons.HiddenFolder.Index;
        }
    }

    public class FontsNode : FakeNode
    {
        public FontsNode(string filePath)
            : base(filePath + ";__fonts__")
        {
            Text = "Fonts";
            ForeColorRequest = Color.Gray;
            ImageIndex = SelectedImageIndex = Icons.HiddenFolder.Index;
        }
    }

	public class SwfFileNode : FileNode
	{
		bool explored;
		BackgroundWorker runner;
        SwfOp.ContentParser parser;

		public SwfFileNode(string filePath) : base(filePath)
		{
			isRefreshable = true;
			Nodes.Add(new WorkingNode(filePath));
		}

        public bool FileExists { get { return File.Exists(BackingPath); } }

		public override void Refresh(bool recursive)
		{
			base.Refresh (recursive);

            if (!FileExists)
            {
                Nodes.Clear(); // non-existent file can't be explored
                return;
            }
            else if (Nodes.Count == 0)
            {
                Nodes.Add(new WorkingNode(BackingPath));
            }

			if (explored)
				Explore();
		}

		public void RefreshWithFeedback(bool recursive)
		{
			if (explored)
			{
				Nodes.Clear();
				Nodes.Add(new WorkingNode(BackingPath));
				
				Refresh(recursive);
			}
		}

		public override void BeforeExpand()
		{
			if (!explored)
				Explore();
		}

		private void Explore()
		{
			explored = true;

            if (parser != null) 
                return;
            parser = new SwfOp.ContentParser(BackingPath);

            runner = new BackgroundWorker();
            runner.RunWorkerCompleted += new RunWorkerCompletedEventHandler(runner_ProcessEnded);
            runner.DoWork += new DoWorkEventHandler(runner_DoWork);
            runner.RunWorkerAsync(parser);
		}

        private void runner_DoWork(object sender, DoWorkEventArgs e)
        {
            (e.Argument as SwfOp.ContentParser).Run();
        }

		private void runner_ProcessEnded(object sender, RunWorkerCompletedEventArgs e)
		{
			// marshal to GUI thread
			TreeView.Invoke(new MethodInvoker(AddExports));
		}

		private void AddExports()
		{
            // remove WorkingNode
            TreeView.BeginUpdate();
            try
            {
                if (parser == null)
                    return;
                if (parser.Errors.Count > 0)
                {
                    WorkingNode wnode = Nodes[0] as WorkingNode;
                    if (wnode == null)
                    {
                        Nodes.Clear();
                        wnode = new WorkingNode(BackingPath);
                        Nodes.Add(wnode);
                    }
                    wnode.SetErrorText(parser.Errors[0]);
                    return;
                }

                Nodes.Clear();
                ExportComparer classesComp = new ExportComparer();
                if (parser.Classes.Count == 1) classesComp.Compare(parser.Classes[0], parser.Classes[0]);
                parser.Classes.Sort(classesComp);
                ExportComparer symbolsComp = new ExportComparer();
                if (parser.Symbols.Count == 1) symbolsComp.Compare(parser.Symbols[0], parser.Symbols[0]);
                parser.Symbols.Sort(symbolsComp);
                ExportComparer fontsComp = new ExportComparer();
                if (parser.Fonts.Count == 1) fontsComp.Compare(parser.Fonts[0], parser.Fonts[0]);
                parser.Fonts.Sort(fontsComp);

                if (parser.Classes.Count > 0)
                {
                    ClassesNode node = new ClassesNode(BackingPath);
                    string[] groups = new string[classesComp.groups.Keys.Count];
                    classesComp.groups.Keys.CopyTo(groups, 0);
                    Array.Sort(groups);
                    foreach (string groupName in groups)
                    {
                        if (node.Nodes.Count > 0)
                        {
                            SwfFrameNode frame = new SwfFrameNode(BackingPath, groupName);
                            frame.Text = groupName;
                            node.Nodes.Add(frame);
                        }
                        List<String> names = classesComp.groups[groupName];
                        names.Sort(); // TODO Add setting?
                        foreach (string cls in names)
                            node.Nodes.Add(new ClassExportNode(BackingPath, cls.Replace(':', '.')));
                    }
                    Nodes.Add(node);
                }

                if (parser.Symbols.Count > 0)
                {
                    SymbolsNode node2 = new SymbolsNode(BackingPath);
                    string[] groups = new string[symbolsComp.groups.Keys.Count];
                    symbolsComp.groups.Keys.CopyTo(groups, 0);
                    Array.Sort(groups);
                    foreach (string groupName in groups)
                    {
                        if (node2.Nodes.Count > 0)
                        {
                            SwfFrameNode frame = new SwfFrameNode(BackingPath, groupName);
                            frame.Text = groupName;
                            node2.Nodes.Add(frame);
                        }
                        List<String> names = symbolsComp.groups[groupName];
                        names.Sort(); // TODO Add setting?
                        foreach (string symbol in names)
                            node2.Nodes.Add(new ExportNode(BackingPath, symbol));
                    }
                    Nodes.Add(node2);
                }

                if (parser.Fonts.Count > 0)
                {
                    FontsNode node2 = new FontsNode(BackingPath);
                    string[] groups = new string[fontsComp.groups.Keys.Count];
                    fontsComp.groups.Keys.CopyTo(groups, 0);
                    Array.Sort(groups);
                    foreach (string groupName in groups)
                    {
                        if (node2.Nodes.Count > 0)
                        {
                            SwfFrameNode frame = new SwfFrameNode(BackingPath, groupName);
                            frame.Text = groupName;
                            node2.Nodes.Add(frame);
                        }
                        List<String> names = fontsComp.groups[groupName];
                        names.Sort(); // TODO Add setting?
                        foreach (string font in names)
                            node2.Nodes.Add(new FontExportNode(BackingPath, font));
                    }
                    Nodes.Add(node2);
                }
            }
            finally
            {
                // free parsed model
                parser = null;
                TreeView.EndUpdate();
            }
		}

        class ExportComparer : IComparer<string>
        {
            public Dictionary<string, List<string>> groups = new Dictionary<string, List<string>>();

            public int Compare(string a, string b)
            {
                int pa = a.IndexOf(" @Frame");
                int pb = b.IndexOf(" @Frame");
                string endA = " ";
                if (pa > 0) { endA = a.Substring(pa + 2); a = a.Substring(0, pa); }
                string endB = " ";
                if (pb > 0) { endB = b.Substring(pb + 2); b = b.Substring(0, pb); }
                if (!groups.ContainsKey(endA)) groups[endA] = new List<string>();
                if (!groups[endA].Contains(a)) groups[endA].Add(a);
                if (!groups.ContainsKey(endB)) groups[endB] = new List<string>();
                if (!groups[endB].Contains(b)) groups[endB].Add(b);
                if (endA != endB) return string.Compare(endA, endB);
                return string.Compare(a, b);
            }

        }
	}

	public class InputSwfNode : SwfFileNode
	{
		public InputSwfNode(string filePath) : base(filePath) {}

		public override void Refresh(bool recursive)
		{
			base.Refresh (recursive);
            ForeColorRequest = Color.Blue;
		}
	}

    public class SwfFrameNode : GenericNode
    {
        public SwfFrameNode(string filePath, string name)
            : base(filePath + ";" + name)
        {
            ImageIndex = SelectedImageIndex = Icons.DownArrow.Index;
        }
    }
}
