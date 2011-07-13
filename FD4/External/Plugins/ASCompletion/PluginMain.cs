using System;
using System.Windows.Forms;
using System.Drawing;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using WeifenLuo.WinFormsUI;
using WeifenLuo.WinFormsUI.Docking;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Controls;
using PluginCore;
using ASCompletion.Settings;
using ASCompletion.Model;
using ASCompletion.Context;
using ASCompletion.Completion;
using PluginCore.Localization;
using System.Text.RegularExpressions;
using PluginCore.Helpers;
using ASCompletion.Helpers;

namespace ASCompletion
{
	public class PluginMain: IPlugin
	{
		private string pluginName = "ASCompletion";
		private string pluginGuid = "078c7c1a-c667-4f54-9e47-d45c0e835c4e";
        private string pluginAuth = "FlashDevelop Team";
		private string pluginHelp = "www.flashdevelop.org/community/";
		private string pluginDesc = "Code completion engine for FlashDevelop.";

        private string dataPath;
        private string settingsFile;
        private GeneralSettings settingObject;
        private DockContent pluginPanel;
        private PluginUI pluginUI;
        private Image pluginIcon;
        private EventType eventMask =
            EventType.FileSave |
            EventType.FileSwitch |
            EventType.SyntaxChange |
            EventType.SyntaxDetect |
            EventType.UIRefresh |
            EventType.Keys |
            EventType.Command |
            EventType.ProcessEnd |
            EventType.ApplySettings |
            EventType.ProcessArgs;
        private List<ToolStripItem> menuItems;
        private ToolStripItem quickBuildItem;
        private int currentPos;
        private string currentDoc;
        private bool started;
        private FlashErrorsWatcher flashErrorsWatcher;
        private bool checking = false;
        private System.Timers.Timer timerPosition;

        #region Required Properties

        public Int32 Api
        {
            get { return 1; }
        }

        public string Name
		{
			get { return pluginName; }
		}

		public string Guid
		{
			get { return pluginGuid; }
		}

		public string Author
		{
			get { return pluginAuth; }
		}

		public string Description
		{
			get { return pluginDesc; }
		}

		public string Help
		{
			get { return pluginHelp; }
		}

        [Browsable(false)]
        public Object Settings
        {
            get { return settingObject; }
        }
		#endregion

		#region Plugin Properties

		[Browsable(false)]
		public PluginUI Panel
		{
			get { return pluginUI; }
		}

        [Browsable(false)]
        public string DataPath
        {
            get { return dataPath; }
        }

        #endregion

        #region Required Methods

        /**
		* Initializes the plugin
		*/
		public void Initialize()
		{
			try
			{
                InitSettings();
                CreatePanel();
                CreateMenuItems();
                AddEventHandlers();
                ASContext.GlobalInit(this);
                ModelsExplorer.CreatePanel();
			}
			catch(Exception ex)
			{
				ErrorManager.ShowError(/*"Failed to initialize the completion engine.\n"+ex.Message,*/ ex);
			}
		}

        /**
		* Disposes the plugin
		*/
		public void Dispose()
		{
            PathExplorer.StopBackgroundExploration();
            SaveSettings();
		}

		/**
		* Handles the incoming events
		*/
        public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
		{
            try
            {
                // ignore all events when leaving
                if (PluginBase.MainForm.ClosingEntirely) return;
                // current active document
                ITabbedDocument doc = PluginBase.MainForm.CurrentDocument;

                // application start
                if (!started && e.Type == EventType.UIStarted)
                {
                    started = true;
                    PathExplorer.OnUIStarted();
                    // associate context to initial document
                    e = new NotifyEvent(EventType.SyntaxChange);
                }

                // editor ready?
                if (doc == null) return;
                ScintillaNet.ScintillaControl sci = doc.IsEditable ? doc.SciControl : null;

                //
                //  Events always handled
                //
                bool isValid;
                switch (e.Type)
                {
                    // caret position in editor
                    case EventType.UIRefresh:
                        if (!doc.IsEditable) return;
                        timerPosition.Enabled = false;
                        timerPosition.Enabled = true;
                        return;

                    // key combinations
                    case EventType.Keys:
                        Keys key = (e as KeyEvent).Value;
                        if (ModelsExplorer.HasFocus)
                        {
                            e.Handled = ModelsExplorer.Instance.OnShortcut(key);
                            return;
                        }
                        if (!doc.IsEditable) return;
                        e.Handled = ASComplete.OnShortcut(key, sci);
                        return;

                    //
                    // File management
                    //
                    case EventType.FileSave:
                        if (!doc.IsEditable) return;
                        ASContext.Context.CheckModel(false);
                        // toolbar
                        isValid = ASContext.Context.IsFileValid;
                        if (isValid && !PluginBase.MainForm.SavingMultiple)
                        {
                            if (ASContext.Context.Settings.CheckSyntaxOnSave) CheckSyntax(null, null);
                            ASContext.Context.RemoveClassCompilerCache();
                        }
                        return;

                    case EventType.SyntaxDetect:
                        // detect Actionscript language version
                        if (!doc.IsEditable) return;
                        if (doc.FileName.ToLower().EndsWith(".as"))
                        {
                            settingObject.LastASVersion = DetectActionscriptVersion(doc);
                            (e as TextEvent).Value = settingObject.LastASVersion;
                            e.Handled = true;
                        }
                        break;

                    case EventType.ApplySettings:
                    case EventType.SyntaxChange:
                    case EventType.FileSwitch:
                        if (!doc.IsEditable)
                        {
                            ASContext.SetCurrentFile(null, true);
                            ContextChanged();
                            return;
                        }
                        currentDoc = doc.FileName;
                        currentPos = sci.CurrentPos;
                        // check file
                        bool ignoreFile = !doc.IsEditable;
                        ASContext.SetCurrentFile(doc, ignoreFile);
                        // UI
                        ContextChanged();
                        return;

                    // some commands work all the time
                    case EventType.Command:
                        DataEvent de = e as DataEvent;
                        string command = de.Action ?? "";

                        if (command.StartsWith("ASCompletion."))
                        {
                            string cmdData = (de.Data is string) ? (string)de.Data : null;

                            // add a custom classpath
                            if (command == "ASCompletion.ClassPath")
                            {
                                Hashtable info = de.Data as Hashtable;
                                if (info != null)
                                {
                                    ContextSetupInfos setup = new ContextSetupInfos();
                                    setup.Platform = (string)info["platform"];
                                    setup.Lang = (string)info["lang"];
                                    setup.Version = (string)info["version"];
                                    setup.Classpath = (string[])info["classpath"];
                                    setup.HiddenPaths = (string[])info["hidden"];
                                    ASContext.SetLanguageClassPath(setup);
                                }
                                e.Handled = true;
                            }

                            // send a UserClasspath
                            else if (command == "ASCompletion.GetUserClasspath")
                            {
                                Hashtable info = de.Data as Hashtable;
                                if (info != null && info.ContainsKey("language"))
                                {
                                    IASContext context = ASContext.GetLanguageContext(info["language"] as string);
                                    if (context != null && context.Settings != null 
                                        && context.Settings.UserClasspath != null)
                                        info["cp"] = new List<string>(context.Settings.UserClasspath);
                                }
                                e.Handled = true;
                            }
                            // update a UserClasspath
                            else if (command == "ASCompletion.SetUserClasspath")
                            {
                                Hashtable info = de.Data as Hashtable;
                                if (info != null && info.ContainsKey("language") && info.ContainsKey("cp"))
                                {
                                    IASContext context = ASContext.GetLanguageContext(info["language"] as string);
                                    List<string> cp = info["cp"] as List<string>;
                                    if (cp != null && context != null && context.Settings != null)
                                    {
                                        string[] pathes = new string[cp.Count];
                                        cp.CopyTo(pathes);
                                        context.Settings.UserClasspath = pathes;
                                    }
                                }
                                e.Handled = true;
                            }
                            // send the language's default compiler path
                            else if (command == "ASCompletion.GetCompilerPath")
                            {
                                Hashtable info = de.Data as Hashtable;
                                if (info != null && info.ContainsKey("language"))
                                {
                                    IASContext context = ASContext.GetLanguageContext(info["language"] as string);
                                    if (context != null)
                                        info["compiler"] = context.GetCompilerPath();
                                }
                                e.Handled = true;
                            }

                            // show a language's compiler settings
                            else if (command == "ASCompletion.ShowSettings")
                            {
                                e.Handled = true;
                                IASContext context = ASContext.GetLanguageContext(cmdData);
                                if (context == null) return;
                                string filter = "";
                                string name = "";
                                switch (cmdData.ToUpper())
                                {
                                    case "AS2": name = "AS2Context"; filter = "SDK"; break;
                                    case "AS3": name = "AS3Context"; filter = "SDK"; break;
                                    case "HAXE": name = "HaXeContext"; filter = "SDK"; break;
                                    default: name = cmdData.ToUpper() + "Context"; break;
                                }
                                PluginBase.MainForm.ShowSettingsDialog(name, filter);
                            }

                            // Open types explorer dialog
                            else if (command == "ASCompletion.TypesExplorer")
                            {
                                TypesExplorer(null, null);
                            }

                            // call the Flash IDE
                            else if (command == "ASCompletion.CallFlashIDE")
                            {
                                if (flashErrorsWatcher == null) flashErrorsWatcher = new FlashErrorsWatcher();
                                e.Handled = Commands.CallFlashIDE.Run(settingObject.PathToFlashIDE, cmdData);
                            }

                            // create Flash 8+ trust file
                            else if (command == "ASCompletion.CreateTrustFile")
                            {
                                if (cmdData != null)
                                {
                                    string[] args = cmdData.Split(';');
                                    if (args.Length == 2)
                                        e.Handled = Commands.CreateTrustFile.Run(args[0], args[1]);
                                }
                            }

                            // 
                            else if (command == "ASCompletion.GetClassPath")
                            {
                                if (cmdData != null)
                                {
                                    string[] args = cmdData.Split(';');
                                    if (args.Length == 1)
                                    {
                                        FileModel model = ASContext.Context.GetFileModel(args[0]);
                                        ClassModel aClass = model.GetPublicClass();
                                        if (!aClass.IsVoid())
                                        {
                                            Clipboard.SetText(aClass.QualifiedName);
                                            e.Handled = true;
                                        }
                                    }
                                }
                            }

                            // Return requested language SDK list
                            else if (command == "ASCompletion.InstalledSDKs")
                            {
                                Hashtable info = de.Data as Hashtable;
                                if (info != null && info.ContainsKey("language"))
                                {
                                    IASContext context = ASContext.GetLanguageContext(info["language"] as string);
                                    if (context != null)
                                        info["sdks"] = context.Settings.InstalledSDKs;
                                }
                                e.Handled = true;
                            }
                        }

                        // Create a fake document from a FileModel
                        else if (command == "ProjectManager.OpenVirtualFile")
                        {
                            string cmdData = de.Data as string;
                            if (Regex.IsMatch(cmdData, "\\.(swf|swc)::"))
                            {
                                string[] path = Regex.Split(cmdData, "::");
                                string fileName = path[0] + Path.DirectorySeparatorChar
                                    + path[1].Replace('.', Path.DirectorySeparatorChar).Replace("::", Path.DirectorySeparatorChar.ToString())
                                    + "$.as";
                                FileModel found = ModelsExplorer.Instance.OpenFile(fileName);
                                if (found != null) e.Handled = true;
                            }
                        }
                        break;
                }

                //
                // Actionscript context specific
                //
                if (ASContext.Context.IsFileValid)
                switch (e.Type)
                {
                    case EventType.ProcessArgs:
                        TextEvent te = (TextEvent)e;
                        string cmd = te.Value;
                        if (Regex.IsMatch(cmd, "\\$\\((Typ|Mbr|Itm)"))
                        {
                            // resolve current element
                            Hashtable details = ASComplete.ResolveElement(sci, null);
                            te.Value = ArgumentsProcessor.Process(cmd, details);
                        }
                        break;

                    // menu commands
                    case EventType.Command:
                        string command = (e as DataEvent).Action ?? "";
                        if (command.StartsWith("ASCompletion."))
                        {
                            string cmdData = (e as DataEvent).Data as string;
                            // run MTASC
                            if (command == "ASCompletion.CustomBuild")
                            {
                                if (cmdData != null) ASContext.Context.RunCMD(cmdData);
                                else ASContext.Context.RunCMD("");
                                e.Handled = true;
                            }

                            // build the SWF using MTASC
                            else if (command == "ASCompletion.QuickBuild")
                            {
                                ASContext.Context.BuildCMD(false);
                                e.Handled = true;
                            }

                            // resolve element under cusor and open declaration
                            else if (command == "ASCompletion.GotoDeclaration")
                            {
                                ASComplete.DeclarationLookup(sci);
                                e.Handled = true;
                            }

                            // resolve element under cursor and send a CustomData event
                            else if (command == "ASCompletion.ResolveElement")
                            {
                                ASComplete.ResolveElement(sci, cmdData);
                                e.Handled = true;
                            }
                            else if (command == "ASCompletion.MakeIntrinsic")
                            {
                                ASContext.Context.MakeIntrinsic(cmdData);
                                e.Handled = true;
                            }

                            // alternative to default shortcuts
                            else if (command == "ASCompletion.CtrlSpace")
                            {
                                ASComplete.OnShortcut(Keys.Control | Keys.Space, ASContext.CurSciControl);
                                e.Handled = true;
                            }
                            else if (command == "ASCompletion.CtrlShiftSpace")
                            {
                                ASComplete.OnShortcut(Keys.Control | Keys.Shift | Keys.Space, ASContext.CurSciControl);
                                e.Handled = true;
                            }
                            else if (command == "ASCompletion.CtrlAltSpace")
                            {
                                ASComplete.OnShortcut(Keys.Control | Keys.Alt | Keys.Space, ASContext.CurSciControl);
                                e.Handled = true;
                            }
                            else if (command == "ASCompletion.ContextualGenerator")
                            {
                                if (ASContext.HasContext && ASContext.Context.IsFileValid)
                                {
                                    ASGenerator.ContextualGenerator(ASContext.CurSciControl);
                                }
                            }
                        }
                        return;

                    case EventType.ProcessEnd:
                        string result = (e as TextEvent).Value;
                        ASContext.Context.OnProcessEnd(result);
                        break;
                }
            }
            catch(Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
		}

		#endregion

        #region Custom Properties

        /**
        * Gets the PluginPanel
        */
        [Browsable(false)]
        public DockContent PluginPanel
        {
            get { return pluginPanel; }
        }

        /**
        * Gets the PluginSettings
        */
        [Browsable(false)]
        public GeneralSettings PluginSettings
        {
            get { return settingObject; }
        }

        [Browsable(false)]
        public List<ToolStripItem> MenuItems
        {
            get { return menuItems; }
        }

        #endregion

		#region Initialization

        private void InitSettings()
        {
            pluginDesc = TextHelper.GetString("Info.Description");
            dataPath = Path.Combine(PathHelper.DataDir, "ASCompletion");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            settingsFile = Path.Combine(dataPath, "Settings.fdb");
            settingObject = new GeneralSettings();
            if (!File.Exists(settingsFile))
            {
                // default settings
                settingObject.JavadocTags = GeneralSettings.DEFAULT_TAGS;
                settingObject.PathToFlashIDE = Commands.CallFlashIDE.FindFlashIDE();
                SaveSettings();
            }
            else
            {
                Object obj = ObjectSerializer.Deserialize(settingsFile, settingObject);
                settingObject = (GeneralSettings)obj;
            }
        }

        private void SaveSettings()
        {
            ObjectSerializer.Serialize(settingsFile, this.settingObject);
        }

        private void CreatePanel()
        {
            pluginIcon = PluginBase.MainForm.FindImage("99");
            pluginUI = new PluginUI(this);
            pluginUI.Text = TextHelper.GetString("Title.PluginPanel");
            pluginPanel = PluginBase.MainForm.CreateDockablePanel(pluginUI, pluginGuid, pluginIcon, DockState.DockRight);
        }

        private void CreateMenuItems()
        {
            IMainForm mainForm = PluginBase.MainForm;
            menuItems = new List<ToolStripItem>();
            ToolStripMenuItem item;
            ToolStripMenuItem menu = (ToolStripMenuItem)mainForm.FindMenuItem("ViewMenu");
            if (menu != null)
            {
                item = new ToolStripMenuItem(TextHelper.GetString("Label.ViewMenuItem"), pluginIcon, new EventHandler(OpenPanel));
                PluginBase.MainForm.RegisterShortcutItem("ViewMenu.ShowOutline", item);
                menu.DropDownItems.Add(item);
            }

            System.Drawing.Image image;
            // tools items
            menu = (ToolStripMenuItem)mainForm.FindMenuItem("FlashToolsMenu");
            if (menu != null)
            {
                menu.DropDownItems.Add(new ToolStripSeparator());

                // check actionscript
                image = pluginUI.GetIcon(PluginUI.ICON_CHECK_SYNTAX);
                item = new ToolStripMenuItem(TextHelper.GetString("Label.CheckSyntax"), image, new EventHandler(CheckSyntax), Keys.F7);
                PluginBase.MainForm.RegisterShortcutItem("FlashToolsMenu.CheckSyntax", item);
                menu.DropDownItems.Add(item);
                menuItems.Add(item);

                // quick build
                image = pluginUI.GetIcon(PluginUI.ICON_QUICK_BUILD);
                item = new ToolStripMenuItem(TextHelper.GetString("Label.QuickBuild"), image, new EventHandler(QuickBuild), Keys.Control | Keys.F8);
                PluginBase.MainForm.RegisterShortcutItem("FlashToolsMenu.QuickBuild", item);
                menu.DropDownItems.Add(item);
                //menuItems.Add(item);
                quickBuildItem = item;

                menu.DropDownItems.Add(new ToolStripSeparator());

                // type explorer
                image = mainForm.FindImage("202");
                item = new ToolStripMenuItem(TextHelper.GetString("Label.TypesExplorer"), image, new EventHandler(TypesExplorer), Keys.Control | Keys.J);
                PluginBase.MainForm.RegisterShortcutItem("FlashToolsMenu.TypeExplorer", item);
                menu.DropDownItems.Add(item);

                // model cleanup
                image = mainForm.FindImage("153");
                item = new ToolStripMenuItem(TextHelper.GetString("Label.RebuildClasspathCache"), image, new EventHandler(RebuildClasspath));
                PluginBase.MainForm.RegisterShortcutItem("FlashToolsMenu.RebuildClasspathCache", item);
                menu.DropDownItems.Add(item);

                // convert to intrinsic
                item = new ToolStripMenuItem(TextHelper.GetString("Label.ConvertToIntrinsic"), null, new EventHandler(MakeIntrinsic));
                PluginBase.MainForm.RegisterShortcutItem("FlashToolsMenu.ConvertToIntrinsic", item);
                menu.DropDownItems.Add(item);
                menuItems.Add(item);
            }

            // toolbar items
            ToolStrip toolStrip = mainForm.ToolStrip;
            ToolStripButton button;
            if (toolStrip != null)
            {
                toolStrip.Items.Add(new ToolStripSeparator());
                // check
                image = pluginUI.GetIcon(PluginUI.ICON_CHECK_SYNTAX);
                button = new ToolStripButton(image);
                button.Name = "CheckSyntax";
                button.ToolTipText = TextHelper.GetString("Label.CheckSyntax").Replace("&", "");
                button.Click += new EventHandler(CheckSyntax);
                toolStrip.Items.Add(button);
                menuItems.Add(button);
            }

            // search items
            menu = (ToolStripMenuItem)mainForm.FindMenuItem("SearchMenu");
            if (menu != null)
            {
                menu.DropDownItems.Add(new ToolStripSeparator());

                // goto declaration
                image = mainForm.FindImage("99|9|3|-3");
                item = new ToolStripMenuItem(TextHelper.GetString("Label.GotoDeclaration"), image, new EventHandler(GotoDeclaration), Keys.F4);
                PluginBase.MainForm.RegisterShortcutItem("SearchMenu.GotoDeclaration", item);
                menu.DropDownItems.Add(item);
                menuItems.Add(item);

                // goto back from declaration
                image = mainForm.FindImage("99|1|-3|-3");
                item = new ToolStripMenuItem(TextHelper.GetString("Label.BackFromDeclaration"), image, new EventHandler(BackDeclaration), Keys.Shift | Keys.F4);
                PluginBase.MainForm.RegisterShortcutItem("SearchMenu.BackFromDeclaration", item);
                menu.DropDownItems.Add(item);
                pluginUI.LookupMenuItem = item;
                item.Enabled = false;

                // editor items
                ContextMenuStrip emenu = mainForm.EditorMenu;
                if (emenu != null)
                {
                    image = mainForm.FindImage("99|9|3|-3");
                    item = new ToolStripMenuItem(TextHelper.GetString("Label.GotoDeclaration"), image, new EventHandler(GotoDeclaration));
                    emenu.Items.Insert(4, item);
                    emenu.Items.Insert(5, new ToolStripSeparator());
                    menuItems.Add(item);
                }
            }
        }

        private void AddEventHandlers()
        {
            // scintilla controls listeners
            UITools.Manager.OnCharAdded += new UITools.CharAddedHandler(OnChar);
            UITools.Manager.OnMouseHover += new UITools.MouseHoverHandler(OnMouseHover);
            UITools.Manager.OnTextChanged += new UITools.TextChangedHandler(OnTextChanged);
            UITools.CallTip.OnUpdateCallTip += new MethodCallTip.UpdateCallTipHandler(OnUpdateCallTip);
            CompletionList.OnInsert += new InsertedTextHandler(ASComplete.HandleCompletionInsert);

            // shortcuts
            PluginBase.MainForm.IgnoredKeys.Add(Keys.Control | Keys.Enter);
            PluginBase.MainForm.IgnoredKeys.Add(Keys.F1);
            PluginBase.MainForm.IgnoredKeys.Add(Keys.Space | Keys.Control | Keys.Alt); // complete project types

            // application events
            EventManager.AddEventHandler(this, eventMask);
            EventManager.AddEventHandler(this, EventType.UIStarted, HandlingPriority.Low);

            // cursor position changes tracking
            timerPosition = new System.Timers.Timer();
            timerPosition.SynchronizingObject = PluginBase.MainForm as Form;
            timerPosition.Interval = 50;
            timerPosition.Elapsed += new System.Timers.ElapsedEventHandler(timerPosition_Elapsed);
        }

        #endregion

        #region Plugin actions

        /// <summary>
        /// AS2/AS3 detection
        /// </summary>
        /// <param name="doc">Document to check</param>
        /// <returns>Detected language</returns>
        private string DetectActionscriptVersion(ITabbedDocument doc)
        {
            ASFileParser parser = new ASFileParser();
            FileModel model = new FileModel(doc.FileName);
            parser.ParseSrc(model, doc.SciControl.Text);
            if (model.Version == 1 && PluginBase.CurrentProject != null) return PluginBase.CurrentProject.Language;
            else if (model.Version > 2) return "as3";
            else if (model.Version > 1) return "as2";
            else if (settingObject.LastASVersion != null) return settingObject.LastASVersion;
            else return "as2";
        }

        /// <summary>
        /// Clear and rebuild classpath models cache
        /// </summary>
        private void RebuildClasspath(object sender, System.EventArgs e)
        {
            ASContext.RebuildClasspath();
        }

        /// <summary>
        /// Open de types explorer dialog
        /// </summary>
        private void TypesExplorer(object sender, System.EventArgs e)
        {
            ModelsExplorer.Instance.UpdateTree();
            ModelsExplorer.Open();
        }

        /// <summary>
		/// Opens the plugin panel again if closed
        /// </summary>
		public void OpenPanel(object sender, System.EventArgs e)
		{
			pluginPanel.Show();
		}

		/// <summary>
		/// Menu item command: Check ActionScript
		/// </summary>
		public void CheckSyntax(object sender, System.EventArgs e)
		{
            if (!checking && !PluginBase.MainForm.SavingMultiple)
            {
                checking = true;
                ASContext.Context.CheckSyntax();
                checking = false;
            }
		}

		/// <summary>
		/// Menu item command: Quick Build
		/// </summary>
		public void QuickBuild(object sender, System.EventArgs e)
		{
			ASContext.Context.BuildCMD(false);
		}

		/// <summary>
		/// Menu item command: Convert To Intrinsic
		/// </summary>
		public void MakeIntrinsic(object sender, System.EventArgs e)
		{
			if (PluginBase.MainForm.CurrentDocument.IsEditable)
				ASContext.Context.MakeIntrinsic(null);
		}

		/// <summary>
		/// Menu item command: Goto Declaration
		/// </summary>
		public void GotoDeclaration(object sender, System.EventArgs e)
		{
			ASComplete.DeclarationLookup(ASContext.CurSciControl);
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
		private void SetItemsEnabled(bool enabled, bool canBuild)
		{
            foreach (ToolStripItem item in menuItems) item.Enabled = enabled;
            quickBuildItem.Enabled = canBuild;
        }

        #endregion

        #region Event handlers

        /// <summary>
		/// Display completion list or calltip info
		/// </summary>
		private void OnChar(ScintillaNet.ScintillaControl Sci, int Value)
		{
			if (Sci.Lexer == 3 || Sci.Lexer == 4)
				ASComplete.OnChar(Sci, Value, true);
		}

		private void OnMouseHover(ScintillaNet.ScintillaControl sci, int position)
		{
			if (!ASContext.Context.IsFileValid)
				return;

			// get word at mouse position
			int style = sci.BaseStyleAt(position);
			if (!ASComplete.IsTextStyle(style))
				return;
			position = sci.WordEndPosition(position, true);
			ASResult result = ASComplete.GetExpressionType(sci, position);

			// set tooltip
			if (!result.IsNull())
			{
				string text = ASComplete.GetToolTipText(result);
				if (text == null) return;
				// show tooltip
				UITools.Tip.ShowAtMouseLocation(text);
			}
		}

        private void OnTextChanged(ScintillaNet.ScintillaControl sender, int position, int length, int linesAdded)
        {
            ASComplete.OnTextChanged(sender, position, length, linesAdded);
            ASContext.OnTextChanged(sender, position, length, linesAdded);
        }

		private void OnUpdateCallTip(ScintillaNet.ScintillaControl sci, int position)
		{
			if (ASComplete.HasCalltip())
				ASComplete.HandleFunctionCompletion(sci, false, true);
        }

        void timerPosition_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            ScintillaNet.ScintillaControl sci = ASContext.CurSciControl;
            if (sci == null) return;
            int position = sci.CurrentPos;
            if (position != currentPos)
            {
                currentPos = position;
                ContextChanged();
            }
        }

        private void ContextChanged()
        {
            ITabbedDocument doc = PluginBase.MainForm.CurrentDocument;
            bool isValid = false;

            if (doc.IsEditable)
            {
                ScintillaNet.ScintillaControl sci = ASContext.CurSciControl;
                if (currentDoc == doc.FileName && sci != null)
                {
                    int line = sci.LineFromPosition(currentPos);
                    ASContext.SetCurrentLine(line);
                }
                else ASComplete.CurrentResolvedContext = null; // force update

                isValid = ASContext.Context.IsFileValid;
                if (isValid) ASComplete.ResolveContext(sci);
            }
            else ASComplete.ResolveContext(null);
            
            bool enableItems = isValid && !doc.IsUntitled;
            pluginUI.OutlineTree.Enabled = ASContext.Context.CurrentModel != null;
            SetItemsEnabled(enableItems, ASContext.Context.CanBuild);
        }
        #endregion
    }

}
