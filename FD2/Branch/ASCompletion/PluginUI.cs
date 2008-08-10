/*
 * ASCompletion panel
 * 
 * Contributed by IAP: 
 * - Quick search field allowing to highlight members in the tree (see: region Find declaration)
 */

using System;
using System.Windows.Forms;
using System.Collections;
using System.Text;
using System.Text.RegularExpressions;
using PluginCore;

namespace ASCompletion
{
	
	/// <summary>
	/// AS2 class treeview
	/// </summary>
	public class PluginUI : System.Windows.Forms.UserControl
	{
		private System.ComponentModel.IContainer components;
		private System.Windows.Forms.Label labelStatus;
		private System.Windows.Forms.ProgressBar progressBarStatus;
		public System.Windows.Forms.ImageList treeIcons;
		private System.Windows.Forms.Panel panelFind;
		public System.Windows.Forms.CheckBox checkBoxDebug;
		private System.Windows.Forms.TextBox findProcTxt;
		private System.Windows.Forms.Panel panelStatus;
		public System.Windows.Forms.Panel panelDebug;
		private FixedTreeView classTree; 
		private System.Timers.Timer tempoClick;
		
		private string prevChecksum;
		private string lastLookupFile;
		private int lastLookupPosition;
		
		#region settings
		static readonly private string SETTING_TREEVIEW_EXTEND = "ASCompletion.TreeView.ShowExtend";
		static readonly private string SETTING_TREEVIEW_IMPORTS = "ASCompletion.TreeView.ShowImports";
		static readonly private string SETTING_TREEVIEW_GROUPS = "ASCompletion.TreeView.Groups";
		static readonly private string SETTING_TREEVIEW_ALLFILES = "ASCompletion.TreeView.ShowAllFiles";
		static readonly private string SETTING_TREEVIEW_SEARCH = "ASCompletion.TreeView.ShowSearchField";
		private bool initDone;
		private bool showExtend;
		private bool showImports;
		private int memberGroups;
		private bool showAllFiles;

		/// <summary>
		/// Read TreeView settings
		/// TODO  TreeView: allow to update settings at runtime by properly updating the TreeView items
		/// </summary>
		public void UpdateSettings()
		{
			try
			{
				if (!ASContext.MainForm.MainSettings.HasKey(SETTING_TREEVIEW_SEARCH))
					ASContext.MainForm.MainSettings.AddValue(SETTING_TREEVIEW_SEARCH, "true");
				panelFind.Visible = ASContext.MainForm.MainSettings.GetBool(SETTING_TREEVIEW_SEARCH);
			}
			catch(Exception sex)
			{
				ErrorHandler.ShowError("ASCompletion TreeView: Settings initialization error.\n"+sex.Message, sex);
				showExtend = true;
				showImports = true;
				memberGroups = 3;
			}
			if (initDone) return;
			initDone = true;
			try
			{
				if (!ASContext.MainForm.MainSettings.HasKey(SETTING_TREEVIEW_EXTEND))
					ASContext.MainForm.MainSettings.AddValue(SETTING_TREEVIEW_EXTEND, "true");
				if (!ASContext.MainForm.MainSettings.HasKey(SETTING_TREEVIEW_IMPORTS))
					ASContext.MainForm.MainSettings.AddValue(SETTING_TREEVIEW_IMPORTS, "true");
				if (!ASContext.MainForm.MainSettings.HasKey(SETTING_TREEVIEW_GROUPS))
					ASContext.MainForm.MainSettings.AddValue(SETTING_TREEVIEW_GROUPS, "2");
				showExtend = ASContext.MainForm.MainSettings.GetBool(SETTING_TREEVIEW_EXTEND);
				showImports = ASContext.MainForm.MainSettings.GetBool(SETTING_TREEVIEW_IMPORTS);
				memberGroups = Math.Max(0, Math.Min(3, ASContext.MainForm.MainSettings.GetInt(SETTING_TREEVIEW_GROUPS)) );
				showAllFiles = ASContext.MainForm.MainSettings.GetBool(SETTING_TREEVIEW_ALLFILES);
			}
			catch(Exception sex)
			{
				ErrorHandler.ShowError("ASCompletion TreeView: Settings initialization error.\n"+sex.Message, sex);
				showExtend = true;
				showImports = true;
				memberGroups = 3;
			}
						
		}
		#endregion
		
		#region initialization
		public PluginUI()
		{
			InitializeComponent();
			//
			// custom treeview
			//
			classTree = new FixedTreeView();
			classTree.ShowRootLines = false;
			classTree.Dock = DockStyle.Fill;
			classTree.ImageList = treeIcons;
			classTree.HotTracking = true;
			classTree.TabIndex = 0;
			classTree.NodeClicked += new FixedTreeView.NodeClickedHandler( ClassTreeSelect );
			classTree.KeyDown += new System.Windows.Forms.KeyEventHandler(this.FindProcTxtKeyDown);
			Controls.Add(classTree);
			classTree.BringToFront();
			//
			// search field information
			//
			FindProcTxtLeave(null,null);
			//
			// load resource icons
			//
			try 
			{
				treeIcons.Images.Clear();
				System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Class.png")));			//0
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("FolderClosed.png")));	//1
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("FolderOpen.png")));		//2
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Method.png")));			//3
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Property.png")));		//4
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Variable.png")));		//5
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Package.png")));			//6
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Intrinsic.png")));		//7
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Template.png")));		//8
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("FilePlain.png")));		//9
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("QuickBuild.png")));		//10
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("CheckAS.png")));			//11
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("MethodPrivate.png")));	//12
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("PropertyPrivate.png")));	//13
				treeIcons.Images.Add(new System.Drawing.Bitmap(assembly.GetManifestResourceStream("VariablePrivate.png")));	//14
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while loading resources in ASCompletion.DLL", ex);
			}
		}
		#endregion
		
		#region Windows Forms Designer generated code
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			this.components = new System.ComponentModel.Container();
			this.panelDebug = new System.Windows.Forms.Panel();
			this.panelStatus = new System.Windows.Forms.Panel();
			this.findProcTxt = new System.Windows.Forms.TextBox();
			this.checkBoxDebug = new System.Windows.Forms.CheckBox();
			this.panelFind = new System.Windows.Forms.Panel();
			this.treeIcons = new System.Windows.Forms.ImageList(this.components);
			this.progressBarStatus = new System.Windows.Forms.ProgressBar();
			this.labelStatus = new System.Windows.Forms.Label();
			this.panelDebug.SuspendLayout();
			this.panelStatus.SuspendLayout();
			this.panelFind.SuspendLayout();
			this.SuspendLayout();
			// 
			// panelDebug
			// 
			this.panelDebug.Controls.Add(this.checkBoxDebug);
			this.panelDebug.Dock = System.Windows.Forms.DockStyle.Bottom;
			this.panelDebug.Location = new System.Drawing.Point(0, 389);
			this.panelDebug.Name = "panelDebug";
			this.panelDebug.Size = new System.Drawing.Size(192, 24);
			this.panelDebug.TabIndex = 4;
			this.panelDebug.Visible = false;
			// 
			// panelStatus
			// 
			this.panelStatus.Controls.Add(this.labelStatus);
			this.panelStatus.Controls.Add(this.progressBarStatus);
			this.panelStatus.Dock = System.Windows.Forms.DockStyle.Bottom;
			this.panelStatus.Location = new System.Drawing.Point(0, 357);
			this.panelStatus.Name = "panelStatus";
			this.panelStatus.Size = new System.Drawing.Size(192, 32);
			this.panelStatus.TabIndex = 5;
			this.panelStatus.Visible = false;
			// 
			// findProcTxt
			// 
			this.findProcTxt.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
						| System.Windows.Forms.AnchorStyles.Right)));
			this.findProcTxt.Cursor = System.Windows.Forms.Cursors.IBeam;
			this.findProcTxt.Location = new System.Drawing.Point(0, 5);
			this.findProcTxt.Name = "findProcTxt";
			this.findProcTxt.Size = new System.Drawing.Size(192, 20);
			this.findProcTxt.TabIndex = 2;
			this.findProcTxt.Text = "";
			this.findProcTxt.KeyDown += new System.Windows.Forms.KeyEventHandler(this.FindProcTxtKeyDown);
			this.findProcTxt.TextChanged += new System.EventHandler(this.FindProcTxtChanged);
			this.findProcTxt.Leave += new System.EventHandler(this.FindProcTxtLeave);
			this.findProcTxt.Enter += new System.EventHandler(this.FindProcTxtEnter);
			// 
			// checkBoxDebug
			// 
			this.checkBoxDebug.Location = new System.Drawing.Point(8, 0);
			this.checkBoxDebug.Name = "checkBoxDebug";
			this.checkBoxDebug.Size = new System.Drawing.Size(160, 24);
			this.checkBoxDebug.TabIndex = 4;
			this.checkBoxDebug.Text = "Show debug information";
			// 
			// panelFind
			// 
			this.panelFind.Controls.Add(this.findProcTxt);
			this.panelFind.Dock = System.Windows.Forms.DockStyle.Top;
			this.panelFind.Location = new System.Drawing.Point(0, 0);
			this.panelFind.Name = "panelFind";
			this.panelFind.Size = new System.Drawing.Size(192, 32);
			this.panelFind.TabIndex = 1;
			this.panelFind.Visible = false;
			// 
			// treeIcons
			// 
			this.treeIcons.ImageSize = new System.Drawing.Size(16, 16);
			this.treeIcons.TransparentColor = System.Drawing.Color.Transparent;
			// 
			// progressBarStatus
			// 
			this.progressBarStatus.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
						| System.Windows.Forms.AnchorStyles.Right)));
			this.progressBarStatus.Location = new System.Drawing.Point(112, 8);
			this.progressBarStatus.Name = "progressBarStatus";
			this.progressBarStatus.Size = new System.Drawing.Size(72, 16);
			this.progressBarStatus.TabIndex = 0;
			// 
			// labelStatus
			// 
			this.labelStatus.Location = new System.Drawing.Point(8, 8);
			this.labelStatus.Name = "labelStatus";
			this.labelStatus.Size = new System.Drawing.Size(104, 16);
			this.labelStatus.TabIndex = 1;
			this.labelStatus.Text = "...";
			// 
			// PluginUI
			// 
			this.Controls.Add(this.panelStatus);
			this.Controls.Add(this.panelFind);
			this.Controls.Add(this.panelDebug);
			this.Name = "PluginUI";
			this.Size = new System.Drawing.Size(192, 413);
			this.panelDebug.ResumeLayout(false);
			this.panelStatus.ResumeLayout(false);
			this.panelFind.ResumeLayout(false);
			this.ResumeLayout(false);
		}
		#endregion

		#region Status
		
		public void SetStatus(string state, int value, int max)
		{
			if (state == null)
			{
				panelStatus.Visible = false;
				return;
			}
			labelStatus.Text = state;
			progressBarStatus.Maximum = max;
			progressBarStatus.Value = value;
			panelStatus.Visible = true;
		}
		
		#endregion
		
		#region class_tree_display

		public void UpdateView(FileModel aFile)
		{
			DebugConsole.Trace("UI: update "+aFile.FileName);
			try
			{
				// files "checksum"
				StringBuilder sb = new StringBuilder().Append(aFile.Version).Append(aFile.Package);
				foreach(MemberModel import in aFile.Imports)
					sb.Append(import.Type);
				foreach(MemberModel member in aFile.Members)
					sb.Append(member.Flags.ToString()).Append(member.ToString());
				foreach(ClassModel aClass in aFile.Classes)
				{
					sb.Append(aClass.Flags.ToString()).Append(aClass.ClassName);
					foreach(MemberModel member in aClass.Members)
						sb.Append(member.Flags.ToString()).Append(member.ToString());
				}
				if (aFile.haXe)
				foreach(ClassModel aClass in aFile.Enums)
				{
					sb.Append(aClass.Flags.ToString()).Append(aClass.ClassName);
					foreach(MemberModel member in aClass.Members)
						sb.Append(member.Flags.ToString()).Append(member.ToString());
				}
				string checksum = sb.ToString();
				if (checksum != prevChecksum)
				{
					prevChecksum = checksum;
					RefreshView(aFile);
				}
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError(ex.Message, ex);
			}
		}
		
		private void RefreshView(FileModel aFile)
		{
			DebugConsole.Trace("Refresh...");
			classTree.BeginStatefulUpdate();
			try
			{
				classTree.Nodes.Clear();
				TreeNode root = new TreeNode(aFile.FileName,9,9);
				classTree.Nodes.Add(root);
				//if (aFile.Version < 1) 
				//	return;
				
				TreeNodeCollection folders = root.Nodes;
				TreeNodeCollection nodes;
				TreeNode node;
				int img;
				
				// imports
				if (showImports)
				{
					node = new TreeNode("Imports", 1,1);
					folders.Add(node);
					nodes = node.Nodes;
					foreach(MemberModel import in aFile.Imports)
					{
						if (import.Type.EndsWith(".*"))
							nodes.Add(new TreeNode(import.Type, 6,6));
						else 
						{
							img = ((import.Flags & FlagType.Intrinsic) > 0) ? 7 : 0;
							nodes.Add(new TreeNode(import.Type, img,img));
						}
					}
				}
				
				// class members
				if (aFile.Members.Count > 0)
				{
					AddMembers(folders, aFile.Members);
				}
				
				// classes
				if (aFile.Classes.Count > 0)
				{
					//node = new TreeNode("Classes", 1,1);
					//folders.Add(node);
					nodes = folders; //node.Nodes;
					
					foreach(ClassModel aClass in aFile.Classes)
					{
						img = ((aClass.Flags & FlagType.Intrinsic) > 0) ? 7 : 0;
						node = new TreeNode(aClass.ClassName, img,img);
						nodes.Add(node);
						AddMembers(node.Nodes, aClass.Members);
						node.Expand();
					}
				}
				
				root.Expand();
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError(ex.Message, ex);
			}
			finally
			{
				classTree.EndStatefulUpdate();
			}
		}
		
		/// <summary>
		/// Add tree nodes following the user defined members presentation
		/// </summary>
		/// <param name="tree"></param>
		/// <param name="members"></param>
		private void AddMembers(TreeNodeCollection tree, MemberList members)
		{
			TreeNode node;
			//node = new TreeNode("Members", 1,1);
			//tree.Add(node);
			TreeNodeCollection nodes = tree; //node.Nodes;
			int img;					
			foreach(MemberModel member in members)
			if ((member.Flags & FlagType.Variable) > 0) 
			{
				img = ((member.Flags & FlagType.Private) > 0) ? 14 : 5;
				node = new TreeNode(member.ToString(),img,img);
				node.Tag = member.Name;
				nodes.Add(node);
			}
			else if ((member.Flags & FlagType.Function) > 0)
			{
				img = ((member.Flags & FlagType.Private) > 0) ? 12 : 3;
				node = new TreeNode(member.ToString(), img,img);
				node.Tag = member.Name;
				nodes.Add(node);
			}
			else if ((member.Flags & (FlagType.Getter|FlagType.Setter)) > 0)
			{
				img = ((member.Flags & FlagType.Private) > 0) ? 13 : 4;
				node = new TreeNode(member.ToString(), img,img);
				node.Tag = member.Name;
				nodes.Add(node);
			}
		}
		#endregion
		
		#region tree_items_selection
		/// <summary>
		/// Selection des items de l'arbre
		/// </summary>
		private void ClassTreeSelect(object sender, TreeNode node)
		{
			if (tempoClick == null)
			{
				tempoClick = new System.Timers.Timer();
				tempoClick.Interval = 50;
				tempoClick.SynchronizingObject = this;
				tempoClick.AutoReset = false;
				//tempoClick.Elapsed += new System.Timers.ElapsedEventHandler( delayedClassTreeSelect );
			}
			tempoClick.Enabled = true;
		}
		
		private void delayedClassTreeSelect(Object sender, System.Timers.ElapsedEventArgs e)
		{
			TreeNode node = classTree.SelectedNode;
			if (node == null)
				return;
			try
			{
				// class node
				if (node.Parent == null) 
				{
					if (node.Tag != null)
						ASContext.MainForm.OpenSelectedFile( (string)node.Tag );
				}
				
				// group node
				else if (node.Nodes.Count > 0)
				{
					node.Toggle();
				}
				
				// leaf node
				else if ((node.Parent != null) && (node.Parent.Tag == null))
				{
					TreeNode classNode = node.Parent.Parent;
					ScintillaNet.ScintillaControl sci = ASContext.MainForm.CurSciControl;
					// for Back command:
					if (sci != null)
						SetLastLookupPosition(ASContext.Context.CurrentFile.FileName, sci.CurrentPos);
					//
					int index = node.Parent.Index;
					// extends
					if (showExtend && index == 0)
					{
						if (node.Tag != null)
							ASContext.MainForm.OpenSelectedFile( (string)node.Tag );
					}
					// import
					else if (showImports && ((showExtend && index == 1) || (!showExtend && index == 0)))
					{
						if (System.IO.File.Exists((string)classNode.Tag))
						{
							FileModel aFile = PathModel.FindFile((string)classNode.Tag);
							ASContext.MainForm.OpenSelectedFile(aFile.FileName);
						}
					}
					// members
					else if (node.Tag != null)
					{
						ASContext.MainForm.OpenSelectedFile( (string)classNode.Tag );
						sci = ASContext.MainForm.CurSciControl;
						if (sci == null)
							return;
						// look for declaration
						string pname = Regex.Escape((string)node.Tag);
						Match m = null;
						switch (node.ImageIndex)
						{
							case 12: // method
							case 3: 
								m = Regex.Match(sci.Text, "function[\\s]+(?<pname>"+pname+")[\\s]*\\(");
								break;
							case 13: // property
							case 4: 
								m = Regex.Match(sci.Text, "function[\\s]+(?<pname>(g|s)et[\\s]+"+pname+")[\\s]*\\(");
								break;
							case 14: // variables
							case 5: 
								m = Regex.Match(sci.Text, "var[\\s]+(?<pname>"+pname+")[^\\w]");
								break;
						}
						// show
						if (m != null && m.Success)
						{
							GotoPosAndFocus(sci, m.Groups["pname"].Index);
							sci.SetSel(sci.CurrentPos, sci.CurrentPos + m.Groups["pname"].Length);
						}
					}
				}
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError(ex.Message, ex);
			}
		}
		
		public void GotoPosAndFocus(ScintillaNet.ScintillaControl sci, int position)
		{
			sci.MBSafeGotoPos(position);
			int line = sci.LineFromPosition(sci.CurrentPos);
			// TODO  The folding makes the line centering fail - solution: expand all folds / make it smarter.
			//sci.EnsureVisible(line);
			sci.ExpandAllFolds();
			int top = sci.FirstVisibleLine;
			int middle = top + sci.LinesOnScreen/2;
			sci.LineScroll(0, line-middle);
			//
			((Control)sci).Focus();
		}
		
		public void SetLastLookupPosition(string file, int position)
		{
			lastLookupFile = file;
			lastLookupPosition = position;
		}
		public bool RestoreLastLookupPosition()
		{
			if (lastLookupFile == null)
				return false;
			
			ASContext.MainForm.OpenSelectedFile(lastLookupFile);
			ScintillaNet.ScintillaControl sci = ASContext.MainForm.CurSciControl;
			if (sci != null)
			{
				sci.SetSel(lastLookupPosition,lastLookupPosition);
				int line = sci.LineFromPosition(sci.CurrentPos);
				sci.EnsureVisible(line);
				int top = sci.FirstVisibleLine;
				int middle = top + sci.LinesOnScreen/2;
				sci.LineScroll(0, line-middle);
				return true;
			}
			
			lastLookupFile = null;
			return false;
		}
		
		#endregion
		
		#region FileSystemWatcher synchronization
		static private string lastChangeFile;
		static private long lastChangeTimeStamp;
		
		/// <summary>
		/// Some .AS file has changed
		/// </summary>
		public void OnFileChanged(object sender, System.IO.FileSystemEventArgs e)
		{
			// this event comes in on a separate thread
			if (this.InvokeRequired) 
			{
				this.BeginInvoke(new System.IO.FileSystemEventHandler(this.OnFileChanged), new object[]{sender, e});
			}
			else
			{
				// repeated event fix
				long ts = System.DateTime.Now.Ticks;
				string file = e.FullPath;
				if ((ts-lastChangeTimeStamp < 100) && (file == lastChangeFile))
					return;
				lastChangeFile = file;
				lastChangeTimeStamp = ts;
				
				// check AS class
				ASContext.Context.TrackFileChanged(file);
			}
		}
		#endregion
	
		#region Find declaration
		
		// if hilight is true, shows the node and paint it with color 
		private void ShowAndHilightNode(TreeNode node, bool hilight)
		{
			if (hilight) 
			{
				node.EnsureVisible();
				node.BackColor = System.Drawing.Color.Aqua;
			}
			else
			{
				node.BackColor = System.Drawing.Color.White;
			}
		}
		
		private void HilightDeclarationInGroup(TreeNodeCollection nodes, string text)
		{
			foreach(TreeNode sub in nodes) 
			{
				ShowAndHilightNode(sub,IsMach(sub.Tag as string,text));
			}
		}
		
		private bool IsMach(string inputText, string searchText) 
		{
			if (inputText == null || searchText == "")
			{
				return false;
			}
			return (inputText.ToUpper().IndexOf(searchText) >= 0);
		}
		
		private void HighlightAllMachingDeclaration(string text)
		{
			try
			{
				classTree.BeginUpdate();
				classTree.CollapseAll();
				TreeNodeCollection nodes = classTree.Nodes;
				TreeNode node;
				TreeNode expandedNode = null;
				// checking wich node is expanded
				foreach(TreeNode sub in nodes) 
				{
					if (sub.IsExpanded)
						expandedNode = sub;
				}
				foreach(TreeNode sub in nodes) 
				{
					node = sub;
	
					// hilights the name of the class (if mach)
					ShowAndHilightNode(node,IsMach(node.Text, text));
					// where to start the hilighting
					int startWith = 0;
					if (showExtend) startWith++; // has Extend node
					if (showImports) startWith++; // has Imports node
					for (int index = startWith; index < node.Nodes.Count; index++)
					{
						TreeNodeCollection groupNodes = node.Nodes[index].Nodes;
						HilightDeclarationInGroup(groupNodes, text);
					}
				}
				Win32.Scrolling.scrollToLeft(classTree);
				if (expandedNode != null)
					expandedNode.Expand();
			}
			catch(Exception ex)
			{
				// log error and disable search field
				ErrorHandler.AddToLog(ex);
				findProcTxt.Visible = false;
			}
			finally
			{
				classTree.EndUpdate();
			}
		}
		
		void FindProcTxtChanged(object sender, System.EventArgs e)
		{
			string text = findProcTxt.Text;
			if (text == searchInvitation) text = "";
			HighlightAllMachingDeclaration(text.ToUpper());
		}
		
		// Display informative text in the search field
		private string searchInvitation = "Search...";
		
		void FindProcTxtEnter(object sender, System.EventArgs e)
		{
			if (findProcTxt.Text == searchInvitation)
			{
				findProcTxt.Text = "";
				findProcTxt.ForeColor = System.Drawing.SystemColors.WindowText;
			}
		}
		
		void FindProcTxtLeave(object sender, System.EventArgs e)
		{
			if (findProcTxt.Text == "")
			{
				findProcTxt.Text = searchInvitation;
				findProcTxt.ForeColor = System.Drawing.SystemColors.GrayText;
			}
		}
		
		/// <summary>
		/// Go to the matched declaration on Enter - clear field on Escape
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		void FindProcTxtKeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
		{
			if (e.KeyCode == Keys.Enter)
			{
				e.Handled = true;
				if (findProcTxt.Text != searchInvitation)
				{
					TreeNode node = FindMatch(classTree.Nodes);
					if (node != null)
					{
						classTree.SelectedNode = node;
						delayedClassTreeSelect(null, null);
					}
				}
			}
			else if (e.KeyCode == Keys.Escape)
			{
				findProcTxt.Text = "";
				FindProcTxtLeave(null, null);
				classTree.Focus();
			}
		}
		
		/// <summary>
		/// Find an highlighted item and "click" it
		/// </summary>
		/// <param name="nodes"></param>
		/// <returns></returns>
		private TreeNode FindMatch(TreeNodeCollection nodes)
		{
			foreach(TreeNode node in nodes)
			{
				if (node.BackColor == System.Drawing.Color.Aqua)
					return node;
				if (node.Nodes.Count > 0)
				{
					TreeNode subnode = FindMatch(node.Nodes);
					if (subnode != null) return subnode;
				}
			}
			return null;
		}
		#endregion	
		
	}
}
