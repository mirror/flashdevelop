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
		public System.Windows.Forms.Panel panelDebug;
		private System.Windows.Forms.TextBox findProcTxt;
		public System.Windows.Forms.ImageList treeIcons;
		public System.Windows.Forms.CheckBox checkBoxDebug;
		private System.Windows.Forms.Panel panelFind;
		private FixedTreeView classTree; 
		private Hashtable checkEntries;
		private string lastLookupFile;
		private int lastLookupPosition;
		private System.Timers.Timer tempoClick;
		
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
			// entries "checksum"
			//
			checkEntries = new Hashtable();
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
			this.panelFind = new System.Windows.Forms.Panel();
			this.checkBoxDebug = new System.Windows.Forms.CheckBox();
			this.treeIcons = new System.Windows.Forms.ImageList(this.components);
			this.findProcTxt = new System.Windows.Forms.TextBox();
			this.panelDebug = new System.Windows.Forms.Panel();
			this.panelFind.SuspendLayout();
			this.panelDebug.SuspendLayout();
			this.SuspendLayout();
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
			// checkBoxDebug
			// 
			this.checkBoxDebug.Location = new System.Drawing.Point(8, 0);
			this.checkBoxDebug.Name = "checkBoxDebug";
			this.checkBoxDebug.Size = new System.Drawing.Size(160, 24);
			this.checkBoxDebug.TabIndex = 4;
			this.checkBoxDebug.Text = "Show debug information";
			// 
			// treeIcons
			// 
			this.treeIcons.ImageSize = new System.Drawing.Size(16, 16);
			this.treeIcons.TransparentColor = System.Drawing.Color.Transparent;
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
			// PluginUI
			// 
			this.Controls.Add(this.panelFind);
			this.Controls.Add(this.panelDebug);
			this.Name = "PluginUI";
			this.Size = new System.Drawing.Size(192, 413);
			this.panelFind.ResumeLayout(false);
			this.panelDebug.ResumeLayout(false);
			this.ResumeLayout(false);
		}
		#endregion

		#region class_tree_display
		public void RemoveFromView(string fileName)
		{
			// the item is present?
			string check = (string)checkEntries[fileName];
			if (check == null) return;
			
			// remove item
			try
			{
				classTree.BeginUpdate();
				DebugConsole.Trace("REMOVE "+fileName);
				foreach(TreeNode node in classTree.Nodes)
				if ((string)node.Tag == fileName)
				{
					classTree.Nodes.Remove(node);
				}
				//
				checkEntries.Remove(fileName);
			}
			finally
			{
				classTree.EndUpdate();
			}
		}
		
		public void AddInView(string fileName)
		{
			if (!showAllFiles)
				return;
			
			bool updateToken = false;
			try
			{
				DebugConsole.Trace("ADD "+fileName);
				bool found = false;
				string name = System.IO.Path.GetFileName(fileName);
				TreeNode insertBefore = null;
				foreach(TreeNode node in classTree.Nodes)
				{
					if ((string)node.Tag == fileName)
					{
						classTree.SelectedNode = node;
						found = true;
					}
					else if (!found && insertBefore == null && (node.Text.CompareTo(name) > 0) && 
					         ((node.ImageIndex != 9) || (((string)node.Tag).CompareTo(fileName) > 0)))
					{
						insertBefore = node;
					}
					else node.Collapse();
				}
				if (found) return;
				updateToken = true;
				classTree.BeginUpdate();
				TreeNode sub = new TreeNode(name,9,9);
				sub.Tag = fileName;
				if (insertBefore != null)
					classTree.Nodes.Insert(insertBefore.Index, sub); else 
					classTree.Nodes.Add(sub);
				classTree.SelectedNode = sub;
				//
				checkEntries[fileName] = fileName;
			}
			finally
			{
				if (updateToken)
					classTree.EndUpdate();
			}
		}
		
		public void UpdateAndActive(ASClass aClass)
		{
			try
			{
				classTree.BeginUpdate();
				if (aClass.IsVoid())
					AddInView(ASContext.MainForm.CurFile); else
					UpdateView(aClass);
				SetActiveClass(aClass);
			}
			finally
			{
				classTree.EndUpdate();
				Win32.Scrolling.scrollToLeft(classTree);
			}
		}
		
		public void SetActiveClass(ASClass aClass)
		{
			try
			{
				classTree.BeginUpdate();
				string filename;
				if (aClass.IsVoid())
					filename = ASContext.MainForm.CurFile; else 
					filename = aClass.FileName;
				DebugConsole.Trace("UI: set active "+filename);
				//
				bool found = false;
				foreach(TreeNode node in classTree.Nodes)
				if ((string)node.Tag == filename) 
				{
					if (!found) 
					{
						found = true;
						classTree.SelectedNode = node;
						int index = 0;
						if (showExtend) index++;
						if (showImports) index++;
						for (int i=0; i<memberGroups; i++) node.Nodes[index++].Expand();
						node.Expand();
					}
					else classTree.Nodes.Remove(node);
				}
				else node.Collapse();
				//
				if (classTree.SelectedNode != null) 
					classTree.SelectedNode.EnsureVisible();
			}
			catch
			{
				classTree.SelectedNode = null;
			}
			finally
			{
				classTree.EndUpdate();
				Win32.Scrolling.scrollToLeft(classTree);
			}
		}
		
		public void UpdateView(ASClass aClass)
		{
			bool updateToken = false;
			try
			{
				DebugConsole.Trace("UI: update "+aClass.ClassName);
				if (aClass.IsVoid()) 
					return;
				
				// compute class data "checksum" to know if it changed
				string fileName = aClass.FileName;
				string prevDataCheck = (string)checkEntries[fileName];
				StringBuilder sb = new StringBuilder().Append(aClass.Extends.ClassName);
				foreach(ASMember import in aClass.Imports)
					sb.Append(import.Name);
				foreach(ASMember method in aClass.Methods)
					sb.Append(method.Flags.ToString()).Append(method.ToString());
				foreach(ASMember prop in aClass.Properties)
					sb.Append(prop.Flags.ToString()).Append(prop.ToString());
				foreach(ASMember var in aClass.Vars)
					sb.Append(var.Flags.ToString()).Append(var.ToString());
				string classDataCheck = sb.ToString();
				
				// for tree exploration
				TreeNodeCollection nodes = classTree.Nodes;
				TreeNode node = null;
				TreeNode insertBefore = null;
				
				// re-sort imports by package
				aClass.Sort();
				ASMemberList import2 = new ASMemberList();
				ASMember newImport;
				foreach(ASMember import in aClass.Imports)
				{
					newImport = new ASMember();
					newImport.Name = import.Type;
					import2.Add(newImport);
				}
				import2.Sort();

				// search item insertion/update position
				string cname = aClass.ClassName;
				bool entryExists = false;
				foreach(TreeNode sub in nodes) 
				{
					if (sub.Text == cname)
					{
						node = sub;
						entryExists = true;
						break;
					}
					else if (sub.Text.CompareTo(cname) > 0)
					{
						insertBefore = sub;
						break;
					}
				}
				
				// New class
				if (node == null) 
				{
					updateToken = true;
					classTree.BeginStatefulUpdate();
					// create class node
					node = new TreeNode(cname);
					node.Tag = aClass.FileName;
					if (insertBefore != null) nodes.Insert(insertBefore.Index, node);
					else nodes.Add(node);
					// class details nodes
					if (showExtend) node.Nodes.Add(new TreeNode("Extends",1,1));
					if (showImports) node.Nodes.Add(new TreeNode("Imports",1,1));
					// class members nodes
					if (memberGroups == 1) 
					{
						node.Nodes.Add(new TreeNode("Members",1,1));
					}
					else
					{
						if (memberGroups > 1) 
						{
							node.Nodes.Add(new TreeNode("Methods",1,1));
							node.Nodes.Add(new TreeNode("Properties",1,1));
						}
						if (memberGroups > 2) node.Nodes.Add(new TreeNode("Variables",1,1));
					}
				}
				
				// Check class infos
				else {
					if (classDataCheck == prevDataCheck) return;
					updateToken = true;
					classTree.BeginStatefulUpdate();
				}

				//
				// UPDATE CLASS INFO
				//
				checkEntries[fileName] = classDataCheck;
				int index = 0;
				TreeNode sub2;
				// entends
				if (showExtend)
				{
					nodes = node.Nodes[index++].Nodes;
					nodes.Clear();
					if (!aClass.Extends.IsVoid())
					{
						if ((aClass.Extends.Flags & FlagType.Intrinsic) > 0)
							sub2 = new TreeNode(aClass.Extends.ClassName, 7,7);
						else
							sub2 = new TreeNode(aClass.Extends.ClassName, 0,0);
						sub2.Tag = aClass.Extends.FileName;
						
						nodes.Add(sub2);
					}
				}
				// imports
				if (showImports)
				{
					nodes = node.Nodes[index++].Nodes;
					nodes.Clear();
					foreach(ASMember import in import2)
					{
						if ((import.Flags & FlagType.Intrinsic) > 0)
							nodes.Add(new TreeNode(import.Name, 7,7));
						else
							nodes.Add(new TreeNode(import.Name, 0,0));
					}
				}
				// methods
				int img;
				if (memberGroups > 0)
				{
					nodes = node.Nodes[index++].Nodes;
					nodes.Clear();
					foreach(ASMember method in aClass.Methods)
					{
						img = ((method.Flags & FlagType.Private) > 0) ? 12 : 3;
						sub2 = new TreeNode(method.ToString(), img,img);
						sub2.Tag = method.Name;
						nodes.Add(sub2);
					}
					// properties
					if (memberGroups > 1)
					{
						nodes = node.Nodes[index++].Nodes;
						nodes.Clear();
					}
					foreach(ASMember prop in aClass.Properties)
					{
						img = ((prop.Flags & FlagType.Private) > 0) ? 13 : 4;
						sub2 = new TreeNode(prop.ToString(), img,img);
						sub2.Tag = prop.Name;
						nodes.Add(sub2);
					}
					// variables
					if (memberGroups > 2)
					{
						nodes = node.Nodes[index++].Nodes;
						nodes.Clear();
					}
					foreach(ASMember var in aClass.Vars)
					{
						img = ((var.Flags & FlagType.Private) > 0) ? 14 : 5;
						sub2 = new TreeNode(var.ToString(),img,img);
						sub2.Tag = var.Name;
						nodes.Add(sub2);
					}
				}
				
				// expand
				index = 0;
				if (showExtend) index++;
				if (showImports) index++;
				for (int i=0; i<memberGroups; i++) node.Nodes[index++].Expand();
				node.Expand();
				
				if (!entryExists) node.EnsureVisible();
			}
			finally
			{
				if (updateToken) 
					classTree.EndStatefulUpdate();
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
				tempoClick.Elapsed += new System.Timers.ElapsedEventHandler( delayedClassTreeSelect );
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
						SetLastLookupPosition(ASContext.CurrentFile, sci.CurrentPos);
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
						ASClass aClass = ASContext.FindClassFromFile((string)classNode.Tag);
						if (aClass.IsVoid()) return;
						ASContext.OpenFileFromClass(node.Text, aClass);
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
				ASContext.TrackFileChanged(file);
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
			if (text.Length == 0) SetActiveClass(ASContext.CurrentClass);
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
