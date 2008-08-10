using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.Diagnostics;
using System.Windows.Forms;
using FlashDevelop.Utilities;

namespace ProjectExplorer.Controls.TreeView
{
	public class WorkingNode : TreeNode
	{
		public WorkingNode()
		{
			Text = "Exploring...";
			ImageIndex = SelectedImageIndex = Icons.Gear.Index;
			ForeColor = Color.Gray;
			NodeFont = new Font("Tahoma", 8.25F, FontStyle.Regular);
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

		public ExportNode(string filePath, string export) : base(filePath+";"+export)
		{
			ContainingSwfPath = filePath;
			Export = export;
			Text = export;
			ForeColorRequest = Color.Gray;
			ImageIndex = SelectedImageIndex = Icons.ImageResource.Index;
		}
	}

	public class ClassExportNode : ExportNode
	{
		public ClassExportNode(string filePath, string export) : base(filePath,export)
		{
			Text = Text.Substring(11);
			ImageIndex = SelectedImageIndex = Icons.Class.Index;
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

	public class SwfFileNode : FileNode
	{
		bool explored;
		ProcessRunner runner;
		ArrayList exports;

		public SwfFileNode(string filePath) : base(filePath)
		{
			isRefreshable = true;
			Nodes.Add(new WorkingNode());
		}

		public override void Refresh(bool recursive)
		{
			base.Refresh (recursive);

			if (explored)
				Explore();
		}

		public void RefreshWithFeedback(bool recursive)
		{
			if (explored)
			{
				Nodes.Clear();
				Nodes.Add(new WorkingNode());
				
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
			string toolsPath = Path.Combine(Application.StartupPath, "tools");
			string swfOpDir = Path.Combine(toolsPath, "swfop");
			string swfOpPath = Path.Combine(swfOpDir, "swfop.exe");

			exports = new ArrayList();

			runner = new ProcessRunner();
			runner.Output += new LineOutputHandler(runner_Output);
			runner.ProcessEnded += new ProcessEndedHandler(runner_ProcessEnded);
			runner.Run(swfOpPath,"\"" + BackingPath + "\"");

			explored = true;
		}

		private void runner_Output(object sender, string line)
		{
			exports.Add(line);
		}

		private void runner_ProcessEnded(object sender, int exitCode)
		{
			// marshal to GUI thread
			TreeView.Invoke(new MethodInvoker(AddExports));
		}

		private void AddExports()
		{
			// remove WorkingNode
			Nodes.Clear();

			ArrayList classes = new ArrayList();
			ArrayList symbols = new ArrayList();

			foreach (string export in exports)
				if (export.StartsWith("__Packages."))
					classes.Add(export);
				else
					symbols.Add(export);
			
			classes.Sort();
			symbols.Sort();

			if (classes.Count > 0)
			{
				ClassesNode node = new ClassesNode(BackingPath);
				foreach (string cls in classes)
					node.Nodes.Add(new ClassExportNode(BackingPath,cls));
				Nodes.Add(node);
			}

			foreach (string symbol in symbols)
				Nodes.Add(new ExportNode(BackingPath,symbol));
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
}
