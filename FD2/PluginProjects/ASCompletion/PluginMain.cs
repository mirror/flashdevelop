using System;
using System.Windows.Forms;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using WeifenLuo.WinFormsUI;
using PluginCore;
using PluginCore.Controls;

namespace ASCompletion
{
	public class PluginMain: IPlugin
	{
		private string pluginName = "ASCompletion";
		private string pluginGuid = "078c7c1a-c667-4f54-9e47-d45c0e835c4e";
		private string pluginAuth = "Philippe Elsass";
		private string pluginHelp = "www.flashdevelop.org/community/";
		private string pluginDesc = "Adds an advanced ActionScript 2.0 support to FlashDevelop.";
		private EventType eventMask = /*EventType.FileOpen |*/ EventType.FileSave | EventType.FileSwitch | EventType.FileClose 
		                              | EventType.LanguageChange | EventType.UIRefresh | EventType.Shortcut | EventType.Command 
			                          | EventType.SettingUpdate | EventType.ProcessEnd | EventType.ProcessArgs;
		private ArrayList sciReferences;
		private DockContent pluginPanel;
		private IPluginHost pluginHost;
		private PluginUI pluginUI;
		private IMainForm mainForm;
		private ArrayList menuItems;
		private ArrayList buildMenuItems;
		//private bool justOpenFile;

		readonly private string SETTING_SHORTCUT_CHECK = "ASCompletion.Shortcut.CheckActionScript";
		readonly private string SETTING_SHORTCUT_BUILD = "ASCompletion.Shortcut.QuickMTASCBuild";
		readonly private string SETTING_SHORTCUT_GOTO = "ASCompletion.Shortcut.GotoDeclaration";
		readonly private string SETTING_SHORTCUT_BACK = "ASCompletion.Shortcut.BackFromDeclaration";
		readonly private string SETTING_SHORTCUT_CLEARCACHE = "ASCompletion.Shortcut.ClearClassCache";
		readonly private string SETTING_MACROMEDIA_FLASHIDE = "ASCompletion.Macromedia.FlashIDE";
		readonly private string[] MACROMEDIA_FLASHIDE_PATH = {
			@"C:\Program Files\Macromedia\Flash 8\Flash.exe",
			@"C:\Program Files\Macromedia\Flash MX 2004\Flash.exe"
		};
		
		#region RequiredPluginVariables

		public string Name
		{
			get { return this.pluginName; }
		}

		public string Guid
		{
			get { return this.pluginGuid; }
		}

		public string Author
		{
			get { return this.pluginAuth; }
		}

		public string Description
		{
			get { return this.pluginDesc; }
		}

		public string Help
		{
			get { return this.pluginHelp; }
		}

		public EventType EventMask
		{
			get { return this.eventMask; }
		}

		[Browsable(false)]
		public IPluginHost Host
		{
			get { return this.pluginHost; }
			set	{ this.pluginHost = value; }
		}

		[Browsable(false)]
		public DockContent Panel
		{
			get { return this.pluginPanel; }
		}

		#endregion

		#region PluginProperties

		[Browsable(false)]
		public IMainForm MainForm
		{
			get { return this.mainForm; }
		}

		[Browsable(false)]
		public PluginUI PluginUI
		{
			get { return this.pluginUI; }
		}

		#endregion

		#region RequiredPluginMethods

		/**
		* Initializes the plugin
		*/
		public void Initialize()
		{
			this.mainForm = this.pluginHost.MainForm;
			this.pluginUI = new PluginUI();
			System.Drawing.Image image = this.mainForm.GetSystemImage(46);
			/**
			*  Create panel
			*/
			this.pluginUI.Tag = "ActionScript";
			this.pluginUI.Text = "ActionScript";
			this.pluginPanel = mainForm.CreateDockingPanel(this.pluginUI, this.pluginGuid, image, DockState.DockRight);
			/**
			* Default shortcuts
			*/
			if (!MainForm.MainSettings.HasKey(SETTING_SHORTCUT_CHECK))
				MainForm.MainSettings.AddValue(SETTING_SHORTCUT_CHECK, "F7");
			if (!MainForm.MainSettings.HasKey(SETTING_SHORTCUT_BUILD))
				MainForm.MainSettings.AddValue(SETTING_SHORTCUT_BUILD, "CtrlF8");
			if (!MainForm.MainSettings.HasKey(SETTING_SHORTCUT_GOTO))
				MainForm.MainSettings.AddValue(SETTING_SHORTCUT_GOTO, "F4");
			if (!MainForm.MainSettings.HasKey(SETTING_SHORTCUT_BACK))
				MainForm.MainSettings.AddValue(SETTING_SHORTCUT_BACK, "ShiftF4");
			if (!MainForm.MainSettings.HasKey(SETTING_SHORTCUT_CLEARCACHE))
				MainForm.MainSettings.AddValue(SETTING_SHORTCUT_CLEARCACHE, "CtrlF7");

			/**
			*  Create menu items
			*/
			menuItems = new ArrayList();
			buildMenuItems = new ArrayList();
			CommandBarItem item;
			CommandBarMenu menu = mainForm.GetCBMenu("ViewMenu");
			menu.Items.AddButton(image, "&ActionScript Panel", new EventHandler(this.OpenPanel));
			Keys k;

			// tools items
			menu = this.mainForm.GetCBMenu("FlashToolsMenu");
			if (menu != null)
			{
				menu.Items.AddSeparator();

				// clear class cache
				k = MainForm.MainSettings.GetShortcut(SETTING_SHORTCUT_CLEARCACHE);
				if (k != Keys.None) this.mainForm.IgnoredKeys.Add(k);
				else ErrorHandler.ShowInfo("Settings Error: Invalid Shortcut ("+MainForm.MainSettings.GetValue(SETTING_SHORTCUT_CLEARCACHE)+")");
				menu.Items.AddButton("&Clear Class Cache", new EventHandler(this.ClearClassCache), k);

				// convert to intrinsic
				item = menu.Items.AddButton("Convert To &Intrinsic", new EventHandler(this.MakeIntrinsic));
				menuItems.Add(item);

				// check actionscript
				image = this.pluginUI.treeIcons.Images[11];
				k = MainForm.MainSettings.GetShortcut(SETTING_SHORTCUT_CHECK);
				if (k != Keys.None) this.mainForm.IgnoredKeys.Add(k);
				else ErrorHandler.ShowInfo("Settings Error: Invalid Shortcut ("+MainForm.MainSettings.GetValue(SETTING_SHORTCUT_CHECK)+")");
				item = menu.Items.AddButton(image, "Check &ActionScript", new EventHandler(this.CheckActionScript), k);
				menuItems.Add(item);

				// quick MTASC build
				image = this.pluginUI.treeIcons.Images[10];
				k = MainForm.MainSettings.GetShortcut(SETTING_SHORTCUT_BUILD);
				if (k != Keys.None) this.mainForm.IgnoredKeys.Add(k);
				else ErrorHandler.ShowInfo("Settings Error: Invalid Shortcut ("+MainForm.MainSettings.GetValue(SETTING_SHORTCUT_BUILD)+")");
				item = menu.Items.AddButton(image, "Quick &MTASC Build", new EventHandler(this.QuickMTASCBuild), k);
				menuItems.Add(item);
				buildMenuItems.Add(item);
			}
			else ErrorHandler.ShowInfo("MainMenu Error: no 'FlashToolsMenu' group found");

			// toolbar items
			CommandBar toolbar = MainForm.GetCBToolbar();
			if (toolbar != null)
			{
				toolbar.Items.AddSeparator();
				// check
				image = this.pluginUI.treeIcons.Images[11];
				item = toolbar.Items.AddButton(image, "Check ActionScript", new EventHandler(this.CheckActionScript));
				menuItems.Add(item);

				// build
				image = this.pluginUI.treeIcons.Images[10];
				item = toolbar.Items.AddButton(image, "Quick MTASC Build", new EventHandler(this.QuickMTASCBuild));
				menuItems.Add(item);
				buildMenuItems.Add(item);
			}

			// search items
			menu = this.mainForm.GetCBMenu("SearchMenu");
			if (menu != null)
			{
				menu.Items.AddSeparator();

				// goto back from declaration
				image = this.mainForm.GetSystemImage(18);
				k = MainForm.MainSettings.GetShortcut(SETTING_SHORTCUT_BACK);
				if (k != Keys.None) this.mainForm.IgnoredKeys.Add(k);
				else ErrorHandler.ShowInfo("Settings Error: Invalid Shortcut ("+MainForm.MainSettings.GetValue(SETTING_SHORTCUT_BACK)+")");
				item = menu.Items.AddButton(image, "&Back From Declaration", new EventHandler(this.BackDeclaration), k);
				menuItems.Add(item);

				// goto declaration
				image = this.mainForm.GetSystemImage(17);
				k = MainForm.MainSettings.GetShortcut(SETTING_SHORTCUT_GOTO);
				if (k != Keys.None) this.mainForm.IgnoredKeys.Add(k);
				else ErrorHandler.ShowInfo("Settings Error: Invalid Shortcut ("+MainForm.MainSettings.GetValue(SETTING_SHORTCUT_GOTO)+")");
				item = menu.Items.AddButton(image, "Goto &Declaration", new EventHandler(this.GotoDeclaration), k);
				menuItems.Add(item);
			}
			else ErrorHandler.ShowInfo("MainMenu Error: no 'SearchMenu' group found");

			/**
			*  Initialize completion context
			*/
			sciReferences = new ArrayList();
			ASContext.Init(this);
			AS3.Flex2Shell.Init(this.mainForm);
			UITools.OnCharAdded += new UITools.CharAddedHandler( OnChar );
			InfoTip.OnMouseHover += new InfoTip.MouseHoverHandler( OnMouseHover );
			UITools.OnTextChanged += new UITools.TextChangedHandler( ASContext.OnTextChanged );
			InfoTip.OnUpdateCallTip += new InfoTip.UpdateCallTipHandler( OnUpdateCallTip );
			this.mainForm.IgnoredKeys.Add(Keys.Control|Keys.Enter);
			this.mainForm.IgnoredKeys.Add(Keys.F1);

			/**
			*  Path to the Flash IDE
			*/
			if (!MainForm.MainSettings.HasKey(SETTING_MACROMEDIA_FLASHIDE))
			{
				string found = "";
				foreach(string flashexe in MACROMEDIA_FLASHIDE_PATH)
				{
					if (System.IO.File.Exists(flashexe)) {
						found = flashexe;
						break;
					}
				}
				MainForm.MainSettings.AddValue(SETTING_MACROMEDIA_FLASHIDE, found);
			}
		}

		/**
		* Disposes the plugin
		*/
		public void Dispose()
		{
			// free system ressources
			AS3.Flex2Shell.Instance.Stop();
		}

		/**
		* Handles the incoming events
		*/
		public void HandleEvent(object sender, NotifyEvent e)
		{
			if (e.Type != EventType.UIRefresh)
				DebugConsole.Trace("*** "+e.Type.ToString());

			// editor context
			ScintillaNet.ScintillaControl sci = ASContext.MainForm.CurSciControl;
			if (sci == null) {
				DebugConsole.Trace("null SCI");
				return;
			}

			/**
			 *  Other events always handled
			 */
			bool isValid;
			switch (e.Type)
			{
				// key combinations
				case EventType.Shortcut:
					DebugConsole.Trace("Key "+((KeyEvent)e).Value);
					e.Handled = ASComplete.OnShortcut( ((KeyEvent)e).Value, sci);
					return;

				//
				// File management
				//
				case EventType.FileSave:
					// update view if needed
					ASContext.CurrentClass.IsVoid();
					// toolbar
					isValid = ASContext.IsClassValid();
					this.SetItemsEnabled(isValid);
					if (isValid)
					{
						if (ASContext.CheckOnSave) AutoCheckActionScript();
						ASContext.RemoveClassASO();
					}
					return;

				case EventType.LanguageChange:
				case EventType.FileSwitch:
					DebugConsole.Trace("Switch to "+ASContext.MainForm.CurFile);
					if (e.Type == EventType.LanguageChange)
					{
						// remove file from the treeview (it will be re-checked and re-added later)
						ASContext.Panel.RemoveFromView(ASContext.MainForm.CurFile);
					}

					// check class
					if ((sci.ConfigurationLanguage == "as2" || sci.ConfigurationLanguage == "as3") 
					    && !ASContext.MainForm.CurDocIsUntitled())
						ASContext.CurrentFile = ASContext.MainForm.CurFile;
					else 
						ASContext.CurrentFile = "";

					// toolbar
					isValid = ASContext.IsClassValid();
					this.SetItemsEnabled(isValid);
					
					// check on open
					/*if (justOpenFile)
					{
						justOpenFile = true;
						if (isValid && ASContext.CheckOnSave) 
							AutoCheckActionScript();
					}*/
					return;
				
				/*case EventType.FileOpen:
					justOpenFile = true;
					return;*/

				case EventType.FileClose:
					DebugConsole.Trace("Close "+ASContext.MainForm.CurFile);
					this.pluginUI.RemoveFromView(ASContext.MainForm.CurFile);
					return;

				case EventType.SettingUpdate:
					ASContext.UpdateSettings();
					AS3.Flex2Shell.UpdateSettings();
					break;

				// some commands work all the time
				case EventType.Command:
					string command = ((TextEvent)e).Text;

					// add a custom classpath
					if (command.StartsWith("ASCompletion;ClassPath;"))
					{
						int p = command.IndexOf(';', 15);
						ASContext.ExternalClassPath = command.Substring(p+1);
						e.Handled = true;
					}

					// clear the classes cache
					else if (command.StartsWith("ASCompletion;ClearClassCache"))
					{
						ClearClassCache(null, null);
						e.Handled = true;
					}
					
					else if (command == "ASCompletion.SendContext")
					{
						DataEvent de = new DataEvent(EventType.CustomData,"ASCompletion.Context",new ASContext());
						MainForm.DispatchEvent(de);
						e.Handled = true;
					}
					
					// call the Flash IDE
					else if (command.StartsWith("CallFlashIDE"))
					{
						string flashexe = MainForm.MainSettings.GetValue(SETTING_MACROMEDIA_FLASHIDE);
						if ((flashexe.Length == 0) || !System.IO.File.Exists(flashexe))
						{
							ErrorHandler.ShowInfo("The path to Flash.exe is not configured properly.");
						}
						// save modified files
						this.mainForm.CallCommand("SaveAllModified", null);
						// run the Flash IDE
						if (command.IndexOf(';') > 0)
						{
							string args = MainForm.ProcessArgString( command.Substring(command.IndexOf(';')+1) );
							if (args.IndexOf('"') < 0) args = '"'+args+'"';
							System.Diagnostics.Process.Start(flashexe, args);
						}
						else
						{
							System.Diagnostics.Process.Start(flashexe);
						}
						e.Handled = true;
					}
					
					// run the Flex 2 compilet
					else if (command.StartsWith("RunMxmlc;"))
					{
						AS3.Flex2Shell.Instance.RunMxmlc(command.Substring(9));
					}
					break;
			}

			/**
			 * Actionscript context specific
			 */
			if ((sci.Lexer == 3) && ASContext.IsClassValid())
			switch (e.Type)
			{
				case EventType.ProcessArgs:
					TextEvent te = (TextEvent)e;
					string cmd = te.Text;
					if (cmd.IndexOf("@") > 0)
					{
						// resolve current element
						Hashtable details = ASComplete.ResolveElement(sci, null);
						// resolve current class details
						if (details == null)
						{
							ASClass oClass = ASContext.CurrentClass;
							details = new Hashtable();
							details.Add("@CLASSDECL", ASClass.MemberDeclaration(oClass.ToASMember()));
							int p = oClass.ClassName.LastIndexOf('.');
							if (p > 0) {
								details.Add("@CLASSPACKAGE", oClass.ClassName.Substring(0,p));
								details.Add("@CLASSNAME", oClass.ClassName.Substring(p+1));
							}
							else {
								details.Add("@CLASSPACKAGE", "");
								details.Add("@CLASSNAME", oClass.ClassName);
							}
							details.Add("@CLASSFULLNAME", oClass.ClassName);				
							details.Add("@MEMBERKIND", "");
							details.Add("@MEMBERNAME", "");
							details.Add("@MEMBERDECL", "");
							details.Add("@MEMBERCLASSPACKAGE", "");
							details.Add("@MEMBERCLASSNAME", "");
							details.Add("@MEMBERCLASSFILE", "");
							details.Add("@MEMBERCLASSDECL", "");
						}
						// complete command
						foreach(string key in details.Keys)
							cmd = cmd.Replace(key, (string)details[key]);
						te.Text = cmd;
					}
					break;
					
				// menu commands
				case EventType.Command:
					string command = ((TextEvent)e).Text;
					DebugConsole.Trace(command);
					if (command.StartsWith("ASCompletion;"))
					{
						// run MTASC
						if (command.StartsWith("ASCompletion;MtascRun"))
						{
							int p = command.IndexOf(';', 15);
							if (p > 15) ASContext.RunMTASC(command.Substring(p+1));
							else ASContext.RunMTASC("");
							e.Handled = true;
						}

						// build the SWF using MTASC
						else if (command.StartsWith("ASCompletion;MtascBuild"))
						{
							ASContext.BuildMTASC(false);
							e.Handled = true;
						}

						// resolve element under cusor and open declaration
						else if (command.StartsWith("ASCompletion;GotoDeclaration"))
						{
							ASComplete.DeclarationLookup(sci);
							e.Handled = true;
						}

						// resolve element under cursor and send a CustomData event
						else if (command.StartsWith("ASCompletion;ResolveElement;"))
						{
							int p = command.IndexOf(';', 15);
							ASComplete.ResolveElement(sci, command.Substring(p+1));
							e.Handled = true;
						}
						else if (command.StartsWith("ASCompletion;MakeIntrinsic"))
						{
							int p = command.IndexOf(';', 15);
							if (p > 15) ASContext.MakeIntrinsic(command.Substring(p+1));
							else ASContext.MakeIntrinsic(null);
							e.Handled = true;
						}
					}
					return;

				case EventType.ProcessEnd:
					string result = ((TextEvent)e).Text;
					ASContext.OnProcessEnd(result);
					break;
			}
		}

		/**
		* Opens the plugin panel again if closed
		*/
		public void OpenPanel(object sender, System.EventArgs e)
		{
			this.pluginPanel.Show();
		}

		#endregion

		#region MethodsAndEvents

		/// <summary>
		/// Menu item command: Check ActionScript
		/// </summary>
		public void CheckActionScript(object sender, System.EventArgs e)
		{
			if (ASContext.IsClassValid())
			{
				if (ASContext.CurrentClass.IsAS3) 
					AS3.Flex2Shell.Instance.CheckAS3(mainForm.CurFile);
				else
					ASContext.RunMTASC(null, null);
			}
		}

		/// <summary>
		/// Menu item command: Quick MTASC Build
		/// </summary>
		public void QuickMTASCBuild(object sender, System.EventArgs e)
		{
			if (ASContext.CurrentClass.IsAS3 || System.IO.Path.GetExtension(mainForm.CurFile) == ".mxml")
				AS3.Flex2Shell.Instance.QuickBuild(mainForm.CurFile);
			else
				ASContext.BuildMTASC(false);
		}

		/// <summary>
		/// Menu item command: Convert To Intrinsic
		/// </summary>
		public void MakeIntrinsic(object sender, System.EventArgs e)
		{
			if (ASContext.IsClassValid())
			{
				if (ASContext.CurrentClass.IsAS3)
					ErrorHandler.ShowInfo("AS3 classes are not supported.");
				else if (this.mainForm.CurSciControl != null)
					ASContext.MakeIntrinsic(null);
			}
		}

		/// <summary>
		/// Menu item command: Clear the class cache
		/// </summary>
		public void ClearClassCache(object sender, System.EventArgs e)
		{
			ASContext.BuildClassPath();
		}

		/// <summary>
		/// Menu item command: Goto Declaration
		/// </summary>
		public void GotoDeclaration(object sender, System.EventArgs e)
		{
			ASComplete.DeclarationLookup(this.mainForm.CurSciControl);
		}

		/// <summary>
		/// Menu item command: Back From Declaration
		/// </summary>
		public void BackDeclaration(object sender, System.EventArgs e)
		{
			pluginUI.RestoreLastLookupPosition();
		}

		/// <summary>
		/// Sets the IsEnabled value of all the CommandBarItems
		/// </summary>
		/// <param name="enabled">Is the item enabled?</param>
		private void SetItemsEnabled(bool enabled)
		{
			foreach(CommandBarItem item in menuItems)
				item.IsEnabled = enabled;
			
			if (!enabled && System.IO.Path.GetExtension(ASContext.MainForm.CurFile) == ".mxml")
			{
				foreach(CommandBarItem item in buildMenuItems)
					item.IsEnabled = true;
			}
		}

		/// <summary>
		/// Execute the first menu item with name 'ASCheckActionscript'
		/// </summary>
		private void AutoCheckActionScript()
		{
			CheckActionScript(null, null);
		}

		/// <summary>
		/// Display completion list or calltip info
		/// </summary>
		private void OnChar(ScintillaNet.ScintillaControl Sci, int Value)
		{
			DebugConsole.Trace(Value);
			if (Sci.Lexer == 3)
				ASComplete.OnChar(Sci, Value, true);
		}
		
		private void OnMouseHover(ScintillaNet.ScintillaControl sci, int position)
		{
			if (!ASContext.IsClassValid())
				return;
			
			// get word at mouse position
			int style = sci.BaseStyleAt(position);
			DebugConsole.Trace("Style="+style);
			if (!ASComplete.IsTextStyle(style))
				return;
			position = sci.WordEndPosition(position, true);
			ASResult result = ASComplete.GetExpressionType(sci, position);
			
			// set tooltip
			if (!result.IsNull())
			{
				string text = ASComplete.GetToolTipText(result);
				DebugConsole.Trace("SHOW "+text);
				if (text == null) return;
				// show tooltip
				InfoTip.ShowAtMouseLocation(text);
			}			
		}
		
		private void OnUpdateCallTip(ScintillaNet.ScintillaControl sci, int position)
		{
			if (ASComplete.HasCalltip()) 
			{
				ASComplete.HandleFunctionCompletion(sci);
			}
		}
		#endregion

	}

}
