using System;
using System.IO;
using System.Text;
using System.Drawing;
using System.Diagnostics;
using System.Windows.Forms;
using System.Drawing.Printing;
using System.Text.RegularExpressions;
using System.Collections;
using System.Reflection;
using System.Resources;
using FlashDevelop.Windows;
using FlashDevelop.Utilities;
using vbAccelerator.Components.Win32;
using WeifenLuo.WinFormsUI;
using ScintillaNet.Configuration;
using PluginCore.Controls;
using ScintillaNet;
using PluginCore;

namespace FlashDevelop
{
	/**
	* Actual UI Form of the FlashDevelop IDE
	*/
	public class MainForm : System.Windows.Forms.Form, IMainForm
	{
		private System.Windows.Forms.StatusBar statusBar;
		private System.Windows.Forms.SaveFileDialog saveFileDialog;
		private System.Windows.Forms.PrintPreviewDialog printPreviewDialog;
		private System.Windows.Forms.StatusBarPanel statusBarPanel;
		private System.Windows.Forms.OpenFileDialog openFileDialog;
		private System.Windows.Forms.PrintDialog printDialog;
		private System.Windows.Forms.ColorDialog colorDialog;
		private WeifenLuo.WinFormsUI.DockPanel dockPanel;
		private DeserializeDockContent deserializeDockContent;
		private System.Resources.ResourceManager resources;
		private System.Windows.Forms.CommandBarContextMenu editorMenu;
		private System.Windows.Forms.CommandBarManager commandBarManager;
		private System.Windows.Forms.CommandBarContextMenu tabMenu;
		private System.Windows.Forms.ItemFinder itemFinder;
		private System.Windows.Forms.XmlBuilder xmlBuilder;
		private ScintillaNet.Configuration.ConfigurationUtility SciConfigUtil;
		private ScintillaNet.Configuration.Scintilla SciConfig;
		private System.Drawing.Printing.PrintDocument printDocument;
		private FlashDevelop.Windows.ReplaceDialog replaceDialog;
		private FlashDevelop.Windows.FindDialog findDialog;
		private FlashDevelop.Windows.FindInFilesDialog findInFilesDialog;
		private FlashDevelop.Windows.GoToDialog gotoDialog;
		private FlashDevelop.Utilities.SettingInitializer initializer;
		private FlashDevelop.Utilities.SettingParser documents;
		private FlashDevelop.Utilities.SettingParser snippets;
		private FlashDevelop.Utilities.SettingParser settings;
		private FlashDevelop.Utilities.Arguments arguments;
		private ProcessRunner processRunner;
		private bool closingForOpenFile;
		private bool closeAllCanceled;
		private ArrayList pluginPanels;
		private CopyData dataExchange;
		private int documentCount = 1;
		private int documentIndex = 0;
		private string[] startArgs;
		private string xpmBookmark;
		private bool closingEntirely;
		private ArrayList tabHistory;
		private bool reloadingDoc;
		private bool notifyOpen;
		private bool closingAll;
		private int sciEventMask;
		private Timer tabTimer;
		private Images images;
		private int lastChar;
		private int pageNum;
		
		#region ConstructorAndMain
		
		/**
		* Constructor of MainForm
		*/
		public MainForm(string[] args)
		{
			this.InitializeArgs(args);
			this.InitializeSettings();
			this.InitializeProcessRunner();
			this.InitializeIPConnection(args);
			this.InitializeComponent();
			this.InitializeGraphics();
			this.InitializeSmartDialogs();
			this.InitializeCommandBarMenus();
			this.InitializeLayoutSystems();
			this.InitializeMainForm();
		}
		
		/**
		* IPC communication messages handler
		*/
		private void DataExchangeReception(object sender, DataReceivedEventArgs e)
		{
			try
			{
				switch (e.ChannelName)
				{
					case "FileOpen":
						this.OpenDocumentsFromStartArgs((string[])e.Data, true);
						break;
					case "ExitApplication":
						if (this.Handle == (IntPtr)e.Data) Application.Exit();
						break;
				}
			}
			catch {}
		}
		
		/**
		* Checks if theming should be available
		*/
		private static bool ThemingAvailable()
		{
			Version version = Environment.OSVersion.Version;
			if (version.Major == 5 && version.Minor > 0) return true;
			else if (version.Major > 5) return true;
			else return false;
		}
		
		/**
		* Static entry point of MainForm
		*/
		[STAThread]
		static void Main(string[] args)
		{
			try 
			{
				if (ThemingAvailable())
				{
					Application.EnableVisualStyles();
  					Application.DoEvents(); // Bug fix
				}
				Application.Run(new MainForm(args));
			}
			catch (Exception ex) 
			{
				if (ex.Message != "ExitApplication")
				{
					ErrorHandler.ShowError("Unhandled exception occurred. \nSee the error log for detailed info.", ex);
				}
  			}
		}
		
		#endregion
		
		#region ConstructComponents
		
		/**
		* Fixes the short filenames to long ones
		*/
		public void InitializeArgs(string[] args)
		{
			for (int i = 0; i<args.Length; i++)
			{
				try 
				{
					args[i] = SharedUtils.GetLongPathName(args[i]);
				} 
				catch {}
			}
			this.startArgs = args;
		}
		
		/**
		* Initializes misc. variables and classes
		*/
		public void InitializeSettings()
		{
			Global.Plugins.Initialize(this);
			FilePaths.Initialize(Path.GetDirectoryName(Application.ExecutablePath));
			this.SetStyle(ControlStyles.UserPaint|ControlStyles.DoubleBuffer, true);
			this.sciEventMask = (int)ScintillaNet.Enums.ModificationFlags.InsertText | (int)ScintillaNet.Enums.ModificationFlags.DeleteText | (int)ScintillaNet.Enums.ModificationFlags.RedoPerformed | (int)ScintillaNet.Enums.ModificationFlags.UndoPerformed;
			this.deserializeDockContent = new DeserializeDockContent(this.GetContentFromPersistString);
			this.resources = new System.Resources.ResourceManager(typeof(MainForm));
			this.arguments = new Arguments(this);
			this.pluginPanels = new ArrayList();
			this.closingEntirely = false;
			this.tabHistory = new ArrayList();
			this.tabTimer = new Timer();
			this.tabTimer.Interval = 100;
			this.tabTimer.Tick += new EventHandler(this.OnTabTimer);
			this.CheckSystemFiles();
			this.LoadAllSettings();
		}
		
		/**
		* Initializes the process runner
		*/
		public void InitializeProcessRunner()
		{
			this.processRunner = new ProcessRunner();
			this.processRunner.Output += new LineOutputHandler(ProcessOutput);
			this.processRunner.Error += new LineOutputHandler(ProcessError);
			this.processRunner.ProcessEnded += new ProcessEndedHandler(ProcessEnded);
		}
		
		/**
		* Initializes the IPC data exchange 
		*/
		public void InitializeIPConnection(string[] args)
		{
			dataExchange = new CopyData();
			dataExchange.AssignHandle(this.Handle);
			dataExchange.Channels.Add("FileOpen");
			dataExchange.Channels.Add("ExitApplication");
			dataExchange.DataReceived += new DataReceivedEventHandler(DataExchangeReception);
			if (!settings.HasKey("FlashDevelop.SingleInstance")) settings.AddValue("FlashDevelop.SingleInstance", "true");
			if (settings.GetBool("FlashDevelop.SingleInstance"))
			{
				EnumWindows ew = new EnumWindows();
				ew.GetWindows();
				foreach(EnumWindowsItem ewi in ew.Items)
				{
					if (ewi.Text.EndsWith("- FlashDevelop"))
					{
						ewi.Restore();
						dataExchange.Channels["FileOpen"].Send(args);
						throw new Exception("ExitApplication");
					}
				}
			}
		}
		
		/**
		* Restores the window position, size and state.
		*/
		public void InitializeMainForm()
		{
			try 
			{
				int width = this.settings.GetInt("FlashDevelop.WindowSize.Width");
				int height = this.settings.GetInt("FlashDevelop.WindowSize.Height");
				int posX = this.settings.GetInt("FlashDevelop.WindowPosition.X");
				int posY = this.settings.GetInt("FlashDevelop.WindowPosition.Y");
				string state = this.settings.GetValue("FlashDevelop.WindowState");
				this.WindowState = (FormWindowState)System.Windows.Forms.FormWindowState.Parse(WindowState.GetType(), state, true);
				this.Size = new System.Drawing.Size(width, height);
				if (posX < -4 || posY < -4) posX = posY = 0;
				this.Location = new Point(posX, posY);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Could not apply MainForm settings", ex);
			}
		}
		
		/**
		* Builds the main menu and toolbar from xml file
		*/
		public void InitializeCommandBarMenus()
		{
			try 
			{
				this.images = new Images(FilePaths.Images, 16);
				this.xmlBuilder = new XmlBuilder(this, this.images);
				this.itemFinder = new ItemFinder(this.xmlBuilder);
				this.commandBarManager = new CommandBarManager();
				this.editorMenu = this.xmlBuilder.GenerateContextMenu(FilePaths.ScintillaMenu);
				this.tabMenu = this.xmlBuilder.GenerateContextMenu(FilePaths.TabMenu);
				this.commandBarManager.CommandBars.Add(this.xmlBuilder.GenerateMainMenu(FilePaths.MainMenu));
				if (this.settings.GetBool("FlashDevelop.ViewToolBar"))
				{
					this.commandBarManager.CommandBars.Add(this.xmlBuilder.GenerateToolBar(FilePaths.ToolBar));
				}
				this.Controls.Add(this.commandBarManager);
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while building menus.", ex);
			}
		}
		
		/**
		* Initialize the smart dialogs
		*/
		public void InitializeSmartDialogs()
		{
			this.gotoDialog = new FlashDevelop.Windows.GoToDialog(this);
			this.findDialog = new FlashDevelop.Windows.FindDialog(this);
			this.findInFilesDialog = new FlashDevelop.Windows.FindInFilesDialog(this);
			this.replaceDialog = new FlashDevelop.Windows.ReplaceDialog(this);
		}
		
		/**
		* Initializes the plugins and the dock layout
		*/
		public void InitializeLayoutSystems()
		{
			try
			{
				UITools.Init(this);
				Global.Plugins.FindPlugins(FilePaths.PluginDir);
				if (File.Exists(FilePaths.LayoutInfo))
				{
					if (this.pluginPanels.Count == this.settings.GetInt("FlashDevelop.CreatedPanels"))
					{
						this.CloseLayoutContents();
						this.dockPanel.LoadFromXml(FilePaths.LayoutInfo, this.deserializeDockContent);
					}
				}
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while building layoutsystems.", ex);
			}
		}
		
		/**
		* Retrieves the content by persist string
		*/
		private DockContent GetContentFromPersistString(string persistString)
		{
			int count = this.pluginPanels.Count;
			for (int i = 0; i<count; i++)
			{
				DockContent pluginPanel = (DockContent)this.pluginPanels[i];
				if (pluginPanel.GetPersistString() == persistString)
				{
					return pluginPanel;
				}
			}
			return null;
		}
		
		/**
		* Closes the contents for xml restoring
		*/
		public void CloseLayoutContents()
		{
			int count = this.pluginPanels.Count;
			for (int i = 0; i<count; i++)
			{
				DockContent pluginPanel = (DockContent)this.pluginPanels[i];
				if (pluginPanel.DockState != DockState.Document)
				{
					pluginPanel.DockPanel = null;
				}
			}
		}
		
		/**
		* Creates a floating panel for the plugin
		*/
		public DockContent CreateDockingPanel(Control ctrl, string guid, Image image, DockState defaultDockState)
		{
			try 
			{
				DockableWindow dockableWindow = new DockableWindow(this, ctrl, guid);
				if (image != null) dockableWindow.Icon = SharedUtils.ImageToIcon(image);
				dockableWindow.DockState = defaultDockState;
				this.pluginPanels.Add(dockableWindow);
				return dockableWindow;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while creating a panel.", ex);
				return null;
			}
		}
		
		/**
		* Creates a new document
		*/
		public DockContent CreateNewDocument(string file, string text, int codepage)
		{
			try 
			{
				if (File.Exists(file)) notifyOpen = true;
				string title = Path.GetFileName(file);
				ScintillaControl editor = this.CreateNewSciControl(file, text, codepage);
				TabbedDocument tabbedDocument = new TabbedDocument(this, editor);
				tabbedDocument.Closing += new System.ComponentModel.CancelEventHandler(this.OnDocumentClosing);
				tabbedDocument.Closed += new System.EventHandler(this.OnDocumentClosed);
				tabbedDocument.TabPageContextMenu = this.tabMenu;
				return tabbedDocument;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while creating a new document.", ex);
				return null;
			}
		}
		
		/**
		* Sets the used images from resources
		*/
		private void InitializeGraphics()
		{
			Bitmap bitmap = new Bitmap(((System.Drawing.Image)(this.resources.GetObject("Images.SmallStar"))));
			this.xpmBookmark = ScintillaNet.XPM.ConvertToXPM(bitmap, "#00FF00");
			Icon icon = ((System.Drawing.Icon)(this.resources.GetObject("Icons.FlashDevelop")));
			this.printPreviewDialog.Icon = icon;
			this.Icon = icon;
		}
		
		/**
		* This method is required for Windows Forms designer support.
		* Do not change the method contents inside the source code editor. The Forms designer might
		* not be able to load this method if it was changed manually.
		*/
		public void InitializeComponent() 
		{
			this.dockPanel = new WeifenLuo.WinFormsUI.DockPanel();
			this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
			this.colorDialog = new System.Windows.Forms.ColorDialog();
			this.printDialog = new System.Windows.Forms.PrintDialog();
			this.statusBarPanel = new System.Windows.Forms.StatusBarPanel();
			this.printPreviewDialog = new System.Windows.Forms.PrintPreviewDialog();
			this.statusBar = new System.Windows.Forms.StatusBar();
			this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
			((System.ComponentModel.ISupportInitialize)(this.statusBarPanel)).BeginInit();
			this.SuspendLayout();
			// 
			// dockPanel
			// 
			this.dockPanel.Dock = System.Windows.Forms.DockStyle.Fill;
			this.dockPanel.Font = new System.Drawing.Font("Tahoma", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.World);
			this.dockPanel.Location = new System.Drawing.Point(0, 0);
			this.dockPanel.Name = "dockPanel";
			this.dockPanel.Size = new System.Drawing.Size(552, 367);
			this.dockPanel.TabIndex = 6;
			// 
			// openFileDialog
			//
			this.openFileDialog.Filter = "All Files|*.*";
			this.openFileDialog.RestoreDirectory = true;
			//
			// colorDialog
			//
			this.colorDialog.FullOpen = true;
			this.colorDialog.ShowHelp = false;
			// 
			// statusBarPanel
			// 
			this.statusBarPanel.AutoSize = System.Windows.Forms.StatusBarPanelAutoSize.Spring;
			this.statusBarPanel.Width = 536;
			// 
			// printPreviewDialog
			// 
			this.printPreviewDialog.AutoScrollMargin = new System.Drawing.Size(0, 0);
			this.printPreviewDialog.AutoScrollMinSize = new System.Drawing.Size(0, 0);
			this.printPreviewDialog.ClientSize = new System.Drawing.Size(400, 300);
			this.printPreviewDialog.Enabled = true;
			this.printPreviewDialog.Location = new System.Drawing.Point(21, 213);
			this.printPreviewDialog.MinimumSize = new System.Drawing.Size(375, 250);
			this.printPreviewDialog.Name = "printPreviewDialog";
			this.printPreviewDialog.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.printPreviewDialog.TransparencyKey = System.Drawing.Color.Empty;
			this.printPreviewDialog.Visible = false;
			// 
			// statusBar
			// 
			this.statusBar.Location = new System.Drawing.Point(0, 367);
			this.statusBar.Name = "statusBar";
			this.statusBar.Panels.AddRange(new System.Windows.Forms.StatusBarPanel[] {this.statusBarPanel});
			this.statusBar.ShowPanels = true;
			this.statusBar.Size = new System.Drawing.Size(552, 22);
			this.statusBar.TabIndex = 5;
			// 
			// saveFileDialog
			//
			this.saveFileDialog.Filter = "All Files|*.*";
			this.saveFileDialog.RestoreDirectory = true;
			// 
			// MainForm
			// 
			this.AllowDrop = true;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.ClientSize = new System.Drawing.Size(552, 389);
			this.Controls.Add(this.dockPanel);
			this.Controls.Add(this.statusBar);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.Name = "MainForm";
			this.Text = " FlashDevelop";
			this.Closing += new System.ComponentModel.CancelEventHandler(this.OnMainFormClosing);
			this.Activated += new System.EventHandler(this.OnMainFormActivate);
			this.Load += new System.EventHandler(this.OnMainFormLoad);
			((System.ComponentModel.ISupportInitialize)(this.statusBarPanel)).EndInit();
			this.ResumeLayout(false);
		}
		
		#endregion
		
		#region AccessToGUIForPlugins
		
		/**
		* Gets the plugin by guid
		*/
		public IPlugin FindPlugin(string guid)
		{
			Utilities.Types.AvailablePlugin ap = Global.Plugins.AvailablePlugins.Find(guid);
			if (ap != null)
			{
				return ap.Instance;
			}
			return null;
		}
		
		/**
		* Allow plugins to send events to other plugins
		*/
		public void DispatchEvent(NotifyEvent ne)
		{
			Global.Plugins.NotifyPlugins(null, ne);
		}
		
		/**
		* Adds a new message to the log
		*/
		public void AddTraceLogEntry(string msg, int state)
		{
			TraceLog.AddMessage(msg, state);
		}
		
		/**
		* Gets the mainmenu CommandBar
		*/
		public CommandBar GetCBMainMenu()
		{
			try 
			{
				CommandBar mainMenu = this.commandBarManager.CommandBars[0];
				return mainMenu;
			} 
			catch
			{
				return null;
			}
		}
		
		/**
		* Gets the toolbar CommandBar
		*/
		public CommandBar GetCBToolbar()
		{
			try 
			{
				CommandBar toolBar = this.commandBarManager.CommandBars[1];
				return toolBar;
			} 
			catch
			{
				return null;
			}
		}
		
		/**
		* Gets a CommandBarMenu by name
		*/
		public CommandBarMenu GetCBMenu(string name)
		{
			return this.itemFinder.GetCommandBarMenu(name);
		}
		
		/**
		* Gets a CommandBarButton by name
		*/
		public CommandBarButton GetCBButton(string name)
		{
			return this.itemFinder.GetCommandBarButton(name);
		}
		
		/**
		* Gets a CommandBarComboBox by name
		*/
		public CommandBarComboBox GetCBComboBox(string name)
		{
			return this.itemFinder.GetCommandBarComboBox(name);
		}
		
		/**
		* Gets a CommandBarCheckBox by name
		*/
		public CommandBarCheckBox GetCBCheckBox(string name)
		{
			return this.itemFinder.GetCommandBarCheckBox(name);
		}
		
		/**
		* Gets all CommandBarItems by name
		*/
		public ArrayList GetItemsByName(string name)
		{
			return this.itemFinder.GetItemsByName(name);
		}
		
		/**
		* Gets the spcified system image by index
		*/
		public Image GetSystemImage(int index)
		{
			return this.images.GetImage(index);
		}
		
		/**
		* Gets the system image count
		*/
		public int GetSystemImageCount()
		{
			return this.images.Count;
		}
		
		#endregion
		
		#region GeneralMethods
		
		/**
		* Checks that if the current document is untitled
		* Note: SaveAllModified() does this test directly
		*/
		public bool CurDocIsUntitled()
		{
			return this.CurFile.StartsWith("Untitled");
		}
		
		/**
		* Checks that if the current document is modified
		* Note: SaveAll() & SaveAllModified() do this test directly
		*/
		public bool CurDocIsModified()
		{
			return this.CurDocument.Text.EndsWith("*");
		}
		
		/**
		* Fixes the short path to long path
		*/
		public string GetLongPathName(string file)
		{
			try 
			{
				return SharedUtils.GetLongPathName(file);
			} 
			catch 
			{
				return file;
			}
		}
		
		/**
		* Gets the correct EOL marker
		*/
		public string GetNewLineMarker(int eolMode)
		{
			if (eolMode == 1) return "\r";
			else if (eolMode == 2) return "\n";
			else return "\r\n";
		}
		
		/**
		* Basic detection of text's EOL marker
		*/
		public int GuessNewLineMarker(string text, int defaultMarker)
		{
			int cr = text.IndexOf("\r");
			int lf = text.IndexOf("\n");
			if ((cr >= 0) && (lf >= 0))
			{
				if (cr < lf) return 0;
				else return 2;
			}
			else if ((cr < 0) && (lf < 0)) return this.settings.GetInt("FlashDevelop.EOLMode");
			else if (lf < 0) return 1;
			else return 2;
		}
		
		/**
		* Gets the editor documents
		*/
		public DockContent[] GetDocuments()
		{
			int found = 0;
			int count = this.dockPanel.Documents.Length;
			for (int i = 0; i<count; i++) 
			{
				if (this.dockPanel.Documents[i] is FlashDevelop.TabbedDocument) found++;
			}
			DockContent[] elements = new DockContent[found];
			found = 0;
			for (int i = 0; i<count; i++) 
			{
				if (this.dockPanel.Documents[i] is FlashDevelop.TabbedDocument) 
				{
					elements[found++] = this.dockPanel.Documents[i];
				}
			}
			return elements;
		}
		
		/**
		* Find the ScintillaControl of a document
		*/
		public ScintillaControl GetSciControl(DockContent document)
		{
			if (document == null) 
			{
				document = CurDocument;
				if (document == null) 
				{
					return null;
				}
			}
			foreach(Control ctrl in document.Controls)
			{
				if (ctrl is ScintillaControl) 
				{
					return ctrl as ScintillaControl;
				}
			}
			return null;
		}
		
		/**
		* Reloads the specified document
		*/
		public void ReloadDocument(DockContent doc, bool showQuestion)
		{
			if (showQuestion)
			{
				if (MessageBox.Show("Are you sure you want to reload the file?\nAll changes get lost.", " Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
				{
					return;
				}
			}
			this.reloadingDoc = true;
			TabbedDocument td = (TabbedDocument)doc;
			int codepage = FileSystem.GetFileCodepage(td.FilePath);
			Encoding encoding = Encoding.GetEncoding(codepage);
			string contents = FileSystem.Read(td.FilePath, encoding);
			td.SciControl.Encoding = encoding;
			td.SciControl.CodePage = codepage;
			td.SciControl.Text = contents;
			td.SciControl.EmptyUndoBuffer();
			this.OnFileReload();
		}
		
		/**
		* Makes the read only file writable
		*/
		public void MakeFileWritable(ScintillaControl sci)
		{
			try 
			{
				string file = sci.Tag.ToString();
				File.SetAttributes(file, FileAttributes.Normal);
				sci.IsReadOnly = false;
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while making file readable.", ex);
			}
		}
		
		/**
		* Changes the current document's language
		*/
		public void ChangeLanguage(string lang)
		{
			this.CurSciControl.StyleClearAll();
			this.CurSciControl.StyleResetDefault();
			this.CurSciControl.ClearDocumentStyle();
			this.CurSciControl.ConfigurationLanguage = lang;
			this.CheckActiveLanguageButton(lang);
			this.CurSciControl.StyleBits = 7;
			this.CurSciControl.Colourise(0, -1);
			this.CurSciControl.Refresh();
			this.OnChangeLanguage(lang);
		}
		
		/**
		* Updates editor settings to all available ScintillaControls
		*/
		public void ApplySciSettingsToAllDocuments()
		{
			DockContent[] elements = this.GetDocuments();
			int count = elements.Length;
			for (int i = 0; i<count; i++)
			{
				ScintillaControl sciControl = GetSciControl(elements[i]);
				this.ApplySciSettings(sciControl);
			}
			this.CheckEditorButtons();
		}
		
		/**
		* Inserts text from the snippets class
		*/
		public bool InsertTextByWord(string word)
		{
			ScintillaControl sci = this.CurSciControl;
			string snippet = this.snippets.GetValue(word);
			int line = sci.LineFromPosition(sci.CurrentPos);
			int indent = sci.GetLineIndentation(line);
			if (word == "cdata" && snippet == null) snippet = "<![CDATA[@ENTRYPOINT]]>";
			if (snippet != null)
			{
				sci.BeginUndoAction();
				if (sci.SelText.Length > 0) sci.ReplaceSel("");
				string text = this.ProcessArgString(snippet.ToString());
				bool hasEntryPoint = text.IndexOf("@ENTRYPOINT") >= 0;
				string newline = this.GetNewLineMarker(this.GuessNewLineMarker(text, sci.EOLMode));
				if (newline != "\n")
				{
					text = text.Replace(newline, "\n");
					newline = this.GetNewLineMarker(sci.EOLMode);
				}
				int newindent;
				int curPos = sci.CurrentPos;
				int startPos = sci.WordStartPosition(curPos-1, true);
				int endPos = sci.WordEndPosition(curPos-1, true);
				if (startPos != endPos)
				{
					sci.SetSel(startPos, endPos);
					// replace the text at cursor position if it matches the snippet text
					if (word.StartsWith(sci.SelText)) sci.ReplaceSel("");
					else sci.SetSel(curPos, curPos);
				}
				string[] splitted = text.Trim().Split('\n');
				for (int j = 0; j<splitted.Length; j++)
				{
					if (j != splitted.Length-1) sci.InsertText(sci.CurrentPos, splitted[j]+newline);
					else sci.InsertText(sci.CurrentPos, splitted[j]);
					sci.CurrentPos += splitted[j].Length+newline.Length;
					if (j > 0) 
					{
						line = sci.LineFromPosition(sci.CurrentPos-1);
						newindent = sci.GetLineIndentation(line) + indent;
						sci.SetLineIndentation(line, newindent);
					}
				}
				if (hasEntryPoint)
				{
					sci.SelectText("@ENTRYPOINT");
					sci.ReplaceSel("");
				}
				else sci.SetSel(curPos,curPos);
				sci.EndUndoAction();
				return true;
			}
			else return false;
		}
		
		/**
		* Processes the argument string variables
		*/
		public string ProcessArgString(string args)
		{
			return this.arguments.ProcessString(args);
		}
		
		/**
		* Opens the specified file and reads the file's encoding
		*/
		public void OpenSelectedFile(string file)
		{
			TextEvent te = new TextEvent(EventType.FileOpening, file);
			Global.Plugins.NotifyPlugins(this, te);
			DockContent[] elements = this.GetDocuments();
			if (te.Handled) 
			{
				if (elements.Length == 0)
				{
					this.New(null, null);
				}
				return;
			}
			try
			{
				int count = elements.Length;
				for (int i = 0; i<count; i++)
				{
					ScintillaControl ctrl = GetSciControl(elements[i]);
					if (ctrl.Tag.ToString().ToUpper() == file.ToUpper())
					{
						elements[i].Activate();
						return;
					}
				}
			}
			catch {}
			int codepage = FileSystem.GetFileCodepage(file);
			if (codepage == -1) return; // If the file is locked, stop.
			string text = FileSystem.Read(file, Encoding.GetEncoding(codepage));
			try
			{
				if (this.CurDocIsUntitled() && !this.CurDocIsModified() && elements.Length == 1)
				{
					this.closingForOpenFile = true;
					this.CurDocument.Close();
					this.closingForOpenFile = false;
					this.CreateNewDocument(file, text, codepage);
				}
				else
				{
					this.CreateNewDocument(file, text, codepage);
				}
				this.AddNewReopenMenuItem(file);
			}
			catch
			{
				this.CreateNewDocument(file, text, codepage);
				this.AddNewReopenMenuItem(file);
			}
			this.CheckActiveEncodingButton(codepage);
		}
		
		/**
		* Saves the specified file with the specified encoding
		*/
		public void SaveSelectedFile(string file, string text)
		{
			DockContent doc = this.CurDocument;
			ScintillaControl sci = this.CurSciControl;
			bool otherFile = ((string)sci.Tag != file);
			if (otherFile)
			{
				NotifyEvent ne = new NotifyEvent(EventType.FileClose);
				Global.Plugins.NotifyPlugins(this, ne);
			}
			//
			TextEvent te = new TextEvent(EventType.FileSaving, file);
			Global.Plugins.NotifyPlugins(this, te);
			//
			sci.Tag = file;
			doc.Text = Path.GetFileName(file);
			FileSystem.Write(file, text, sci.Encoding);
			if (otherFile)
			{
				sci.ConfigurationLanguage = this.SciConfig.GetLanguageFromFile(file);
				TextEvent te2 = new TextEvent(EventType.FileSave, file);
				Global.Plugins.NotifyPlugins(this, te2);
				//
				this.notifyOpen = true;
				this.OnActiveDocumentChanged(null, null);
			}
			else this.OnFileSave(file);
		}
		
		/**
		* Checks that all required system files exists
		*/
		private void CheckSystemFiles()
		{
			bool result = true;
			if (!File.Exists(FilePaths.Images)) result = false;
			if (!File.Exists(FilePaths.TabMenu)) result = false;
			if (!File.Exists(FilePaths.Scintilla)) result = false;
			if (!File.Exists(FilePaths.ScintillaMenu)) result = false;
			if (!File.Exists(FilePaths.MainMenu)) result = false;
			if (!File.Exists(FilePaths.Snippets)) result = false;
			if (!File.Exists(FilePaths.ToolBar)) result = false;
			if (!result)
			{
				ErrorHandler.ShowError("You are missing some important setting files. \nPlease reinstall FlashDevelop.", null);
				throw new Exception("ExitApplication");
			}
		}
		
		/**
		* Gets the line comment string
		*/
		private string GetLineComment(string lang)
		{
			Language obj = this.SciConfig.GetLanguage(lang);
			if (obj.linecomment != null)
			{
				return obj.linecomment;
			} 
			return "";
		}
		
		/**
		* Gets the comment start string
		*/
		private string GetCommentStart(string lang)
		{
			Language obj = this.SciConfig.GetLanguage(lang);
			if (obj.commentstart != null)
			{
				return obj.commentstart;
			} 
			return "";
		}
		
		/**
		* Gets the comment end string
		*/
		private string GetCommentEnd(string lang)
		{
			Language obj = this.SciConfig.GetLanguage(lang);
			if (obj.commentend != null)
			{
				return obj.commentend;
			} 
			return "";
		}
		
		/**
		* Selects a correct codepage for the editor
		*/
		private int SelectCodePage(int codepage)
		{
			if (codepage == 65001 || codepage == 1201 || codepage == 1200)
			{
				return 65001;
			} 
			else return codepage;
		}
		
		/**
		* Gets a index of the document
		*/
		private int GetIndexForDockContent(DockContent doc)
		{
			int count = this.dockPanel.Documents.Length;
			for (int i = 0; i<count; i++)
			{
				if (doc.Equals(this.dockPanel.Documents[i]))
				{
					return i;
				}
			}
			return -1;
		}
		
		/**
		* Creates a new name for new document 
		*/
		private string GetNewDocumentName()
		{
			string ext = "as";
			string setting = this.settings.GetValue("FlashDevelop.DefaultFileExtension");
			if (setting != null && Regex.IsMatch(setting, "[^a-zA-Z0-9]")) ext = setting;
			string name = "Untitled"+this.documentCount++;
			return name+"."+ext;
		}
		
		/**
		* Populates the reopen menu from the documents class
		*/
		private void PopulateReopenMenu()
		{
			CommandBarMenu reopenMenu = this.itemFinder.GetCommandBarMenu("ReopenMenu");
			reopenMenu.Items.Clear();
			for (int i = 0; i<this.documents.Settings.Count; i++)
			{
				SettingEntry se = (SettingEntry)this.documents.Settings[i];
				if (i < 15) reopenMenu.Items.AddButton(se.Value, new EventHandler(this.Reopen));
				else this.documents.RemoveByValue(se.Value);
			}
			if (this.documents.Settings.Count > 0)
			{
				reopenMenu.Items.AddSeparator();
				reopenMenu.Items.AddButton("Clear Recent Files List", new EventHandler(this.ClearReopenList));
			}
		}
		
		/**
		* Adds a new menu item to the reopen menu
		*/
		private void AddNewReopenMenuItem(string file)
		{
			CommandBarMenu reopenMenu = this.itemFinder.GetCommandBarMenu("ReopenMenu");
			CommandBarButton reopenButton = new CommandBarButton(file, new EventHandler(this.Reopen));
			if (this.documents.HasValue(file))
			{
				this.documents.RemoveByValue(file);
			}
			this.documents.InsertValue(0, "Document", file);
			this.PopulateReopenMenu();
		}
		
		/**
		* Checks the important boolean value buttons
		*/
		private void CheckEditorButtons()
		{
			try 
			{
				string data = this.settings.GetValue("FlashDevelop.BooleanButtons");
				string[] buttonNames = data.Split(',');
				for(int i = 0; i<buttonNames.Length; i++)
				{
					CommandBarButton button = this.itemFinder.GetCommandBarButton(buttonNames[i]);
					bool buttonValue = this.settings.GetBool(button.Tag.ToString());
					if (buttonValue)  button.Image = this.images.GetImage(45);
					else button.Image = null;
				}
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while checking boolean buttons.", ex);
			}
		}
		
		/**
		* Checks the active language button 
		*/
		private void CheckActiveLanguageButton(string language)
		{
			CommandBarMenu syntaxMenu = this.itemFinder.GetCommandBarMenu("SyntaxMenu");
			int count = syntaxMenu.Items.Count;
			for (int i = 0; i<count; i++)
			{
				if ((string)syntaxMenu.Items[i].Tag == language)
				{
					syntaxMenu.Items[i].Image = this.images.GetImage(45);
				}
				else syntaxMenu.Items[i].Image = null;
			}
		}
		
		/**
		* Checks the active encoding button 
		*/
		private void CheckActiveEncodingButton(int codepage)
		{
			CommandBarMenu encodingMenu = this.itemFinder.GetCommandBarMenu("EncodingMenu");
			int count = encodingMenu.Items.Count;
			for (int i = 0; i<count; i++)
			{
				if ((string)encodingMenu.Items[i].Tag == codepage.ToString())
				{
					encodingMenu.Items[i].Image = this.images.GetImage(45);
				}
				else encodingMenu.Items[i].Image = null;
			}
		}
		
		/**
		* Checks the active eol button 
		*/
		private void CheckActiveEOLButton(int eolMode)
		{	
			CommandBarMenu eolMenu = this.itemFinder.GetCommandBarMenu("EOLMenu");
			int count = eolMenu.Items.Count;
			for (int i = 0; i<count; i++)
			{	
				if ((string)eolMenu.Items[i].Tag == eolMode.ToString())
				{
					eolMenu.Items[i].Image = this.images.GetImage(45);
				}
				else eolMenu.Items[i].Image = null;
			}
		}
		
		/**
		* Does the cleanup tasks to the specified document
		*/
		private void CleanUpDocument(ScintillaControl sci)
		{
			try
			{
				if (this.settings.GetBool("FlashDevelop.EnsureConsistentLineEnds"))
				{
					sci.ConvertEOLs(sci.EOLMode);
				}
				if (this.settings.GetBool("FlashDevelop.EnsureLastLineEnd"))
				{
					sci.AddLastLineEnd();
				}
				if (this.settings.GetBool("FlashDevelop.StripTrailingSpaces"))
				{
					sci.StripTrailingSpaces();
				}
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while running cleanup tasks.", ex);
			}
		}
		
		/**
		* Updates editor settings to the specified ScintillaControl
		*/
		private void ApplySciSettings(ScintillaControl sciControl)
		{
			try
			{
				sciControl.CaretPeriod = this.settings.GetInt("FlashDevelop.CaretPeriod");
				sciControl.CaretWidth = this.settings.GetInt("FlashDevelop.CaretWidth");
				sciControl.EOLMode = this.GuessNewLineMarker(sciControl.Text, this.settings.GetInt("FlashDevelop.EOLMode"));
				sciControl.HighlightGuide = Convert.ToInt32(this.settings.GetBool("FlashDevelop.HighlightGuide"));
				sciControl.Indent = this.settings.GetInt("FlashDevelop.IndentSize");
				sciControl.SmartIndentType = (ScintillaNet.Enums.SmartIndent)Enum.Parse(typeof(ScintillaNet.Enums.SmartIndent), this.settings.GetValue("FlashDevelop.SmartIndentType").ToString());
				sciControl.IsBackSpaceUnIndents = this.settings.GetBool("FlashDevelop.BackSpaceUnIndents");
				sciControl.IsCaretLineVisible = this.settings.GetBool("FlashDevelop.CaretLineVisible");
				sciControl.IsIndentationGuides = this.settings.GetBool("FlashDevelop.ViewIndentationGuides");
				sciControl.IsTabIndents = this.settings.GetBool("FlashDevelop.TabIndents");
				sciControl.IsUseTabs = this.settings.GetBool("FlashDevelop.UseTabs");
				sciControl.IsViewEOL = this.settings.GetBool("FlashDevelop.ViewEOL");
				sciControl.ScrollWidth = this.settings.GetInt("FlashDevelop.ScrollWidth");
				sciControl.TabWidth = this.settings.GetInt("FlashDevelop.TabWidth");
				sciControl.ViewWS = Convert.ToInt32(this.settings.GetBool("FlashDevelop.ViewWhitespace"));
				sciControl.WrapMode = Convert.ToInt32(this.settings.GetBool("FlashDevelop.WrapText"));
				sciControl.SetProperty("fold", Convert.ToInt32(this.settings.GetBool("FlashDevelop.UseFolding")).ToString());
				sciControl.SetProperty("fold.comment", Convert.ToInt32(this.settings.GetBool("FlashDevelop.FoldComment")).ToString());
				sciControl.SetProperty("fold.compact", Convert.ToInt32(this.settings.GetBool("FlashDevelop.FoldCompact")).ToString());
				sciControl.SetProperty("fold.preprocessor", Convert.ToInt32(this.settings.GetBool("FlashDevelop.FoldPreprocessor")).ToString());
				sciControl.SetProperty("fold.html", Convert.ToInt32(this.settings.GetBool("FlashDevelop.FoldHtml")).ToString());
				sciControl.SetProperty("fold.at.else", Convert.ToInt32(this.settings.GetBool("FlashDevelop.FoldAtElse")).ToString());
				sciControl.SetFoldFlags(this.settings.GetInt("FlashDevelop.FoldFlags"));
				/** 
				* Set correct line number margin width
				*/
				bool viewLineNumbers = this.settings.GetBool("FlashDevelop.ViewLineNumbers");
				if (viewLineNumbers) sciControl.SetMarginWidthN(1, 31);
				else sciControl.SetMarginWidthN(1, 0);
				/** 
				* Set correct bookmark margin width
				*/
				bool viewBookmarks = this.settings.GetBool("FlashDevelop.ViewBookmarks");
				if (viewBookmarks) sciControl.SetMarginWidthN(0, 14);
				else sciControl.SetMarginWidthN(0, 0);
				/**
				* Set correct folding margin width
				*/
				bool useFolding = this.settings.GetBool("FlashDevelop.UseFolding");
				if (!useFolding && !viewBookmarks && !viewLineNumbers) sciControl.SetMarginWidthN(2, 0);
				else if (useFolding) sciControl.SetMarginWidthN(2, 15);
				else sciControl.SetMarginWidthN(2, 2);
				/**
				* Add ingnored keys defined in mainmenu xml
				*/
				int count = this.xmlBuilder.Shortcuts.Count;
				for (int i = 0; i<count; i++)
				{
					Shortcut shortcut = (Shortcut)this.xmlBuilder.Shortcuts[i];
					if (!sciControl.ContainsIgnoredKey(shortcut))
					{
						sciControl.AddIgnoredKey(shortcut);
					}
				}
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while applying scintilla settings", ex);
			}
		}
		
		/**
		* Loads all settings of the FlashDevelop
		*/
		private void LoadAllSettings()
		{
			try 
			{
				this.snippets = new SettingParser(FilePaths.Snippets);
				this.settings = new SettingParser(FilePaths.Settings);
				this.documents = new SettingParser(FilePaths.Documents);
				this.SciConfigUtil = new ScintillaNet.Configuration.ConfigurationUtility(GetType().Module.Assembly);
				this.SciConfig = (ScintillaNet.Configuration.Scintilla)this.SciConfigUtil.LoadConfiguration(typeof(ScintillaNet.Configuration.Scintilla), FilePaths.Scintilla);
				ScintillaControl.Configuration = this.SciConfig;
				this.initializer = new SettingInitializer(this.settings);
				this.snippets.SortByKey();
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while loading settings", ex);
			}
		}
		
		/**
		* Saves all settings of the FlashDevelop
		*/
		private void SaveAllSettings()
		{
			try 
			{
				this.settings.ChangeValue("FlashDevelop.WindowState", this.WindowState.ToString());
				this.settings.ChangeValue("FlashDevelop.WindowPosition.X", this.Location.X.ToString());
				this.settings.ChangeValue("FlashDevelop.WindowPosition.Y", this.Location.Y.ToString());
				this.settings.ChangeValue("FlashDevelop.CreatedPanels", this.pluginPanels.Count.ToString());
				this.settings.ChangeValue("FlashDevelop.LatestDialogPath", Directory.GetCurrentDirectory());
				if (this.WindowState.ToString() != "Maximized" && this.WindowState.ToString() != "Minimized")
				{
					this.settings.ChangeValue("FlashDevelop.WindowSize.Width", this.Size.Width.ToString());
					this.settings.ChangeValue("FlashDevelop.WindowSize.Height", this.Size.Height.ToString());
				}
				this.dockPanel.SaveAsXml(FilePaths.LayoutInfo);
				this.settings.SortByKey();
				this.documents.Save();
				this.snippets.Save();
				this.settings.Save();
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while saving settings", ex);
			}
		}
		
		/**
		* Open documents from the specified start arguments
		*/
		private void OpenDocumentsFromStartArgs(string[] args, bool ipc)
		{
			bool filesOpened = false;
			if (ipc) this.InitializeArgs(args);
			if (this.startArgs.Length > 0)
			{
				for (int i = 0; i<this.startArgs.Length; i++)
				{
					if (File.Exists(this.startArgs[i]))
					{
						this.OpenSelectedFile(this.startArgs[i]);
						filesOpened = true;
					}
				}
			}
			if (filesOpened || ipc) return;
			this.New(null, null);
		}
		
		/**
		* Closes all open documents
		*/
		private void CloseAllDocuments()
		{
			this.closingAll = true;
			this.closeAllCanceled = false;			
			int count = this.GetDocuments().Length;
			for (int i = 0; i<count; i++)
			{
				this.dockPanel.ActiveDocument.Close();
			}
			this.closingAll = false;
		}
		
		/**
		* Disables/enables the important edit buttons
		*/
		private void UpdateButtonsEnabled()
		{
			ScintillaControl sciControl = this.CurSciControl;
			this.SetButtonEnabled("UndoButton", sciControl.CanUndo);
			this.SetButtonEnabled("RedoButton", sciControl.CanRedo);
			this.SetButtonEnabled("CutButton", sciControl.SelText.Length>0);
			this.SetButtonEnabled("CopyButton", sciControl.SelText.Length>0);
			this.SetButtonEnabled("PasteButton", sciControl.CanPaste);
			this.SetButtonEnabled("DeleteButton", sciControl.SelText.Length>0);
			if (this.CurDocIsModified()) this.SetButtonEnabled("SaveButton", true);
			else this.SetButtonEnabled("SaveButton", false);
			if (this.HasModifiedDocuments) this.SetButtonEnabled("SaveAllButton", true);
			else this.SetButtonEnabled("SaveAllButton", false);
		}
		
		/**
		* Sets the button's enabled property
		*/
		private void SetButtonEnabled(string name, bool enabled)
		{
			int count = this.xmlBuilder.Buttons.Count;
			for (int i = 0; i<count; i++)
			{
				CommandBarButton buttonItem = (CommandBarButton)this.xmlBuilder.Buttons[i];
				if (buttonItem.Name == name) buttonItem.IsEnabled = enabled;
			}
		}

		#endregion
		
		#region GeneralProperties
		
		/**
		* Gets the default codepage
		*/
		private int DefaultCodePage 
		{
			get 
			{
				int codePage = this.settings.GetInt("FlashDevelop.DefaultCodePage");
				if (codePage == 0) return Encoding.Default.CodePage;
				else return codePage;
			}
		}
		
		/**
		* Gets path to the local data folder
		*/
		public string LocalDataPath
		{
			get 
			{
				return FilePaths.DataDir;
			}
		}
		
		/**
		* Gets the filename of the current document
		*/
		public string CurFile
		{
			get 
			{
				try 
				{
					return this.CurSciControl.Tag.ToString();
				} 
				catch 
				{
					return null;
				}
			}
		}
		
		/**
		* Gets the DockPanel of the MainForm
		*/
		public DockPanel DockPanel
		{
			get 
			{
				return this.dockPanel;
			}
		}
		
		/**
		* Gets the CommandBarManager of the MainForm
		*/
		public CommandBarManager CommandBarManager
		{
			get 
			{
				return this.commandBarManager;
			}
		}
		
		/**
		* Gets the main settings for the plugin
		*/
		public ISettings MainSettings
		{
			get 
			{
				return this.settings; 
			}
		}
		
		/**
		* Gets the snippets for the plugin
		*/
		public ISettings MainSnippets
		{
			get 
			{
				return this.snippets; 
			}
		}
		
		/**
		* Gets the settings
		*/
		public SettingParser Settings
		{
			get 
			{
				return this.settings; 
			}
		}
		
		/**
		* Gets the ingnored keys (shortcuts)
		*/
		public ArrayList IgnoredKeys
		{
			get 
			{
				return this.xmlBuilder.Shortcuts; 
			}
		}
		
		/**
		* Gets the event log
		*/
		public ArrayList EventLog
		{
			get 
			{
				return TraceLog.Log;
			}
		}
		
		/**
		* Gets the active document
		*/
		public DockContent CurDocument
		{
			get 
			{
				return this.dockPanel.ActiveDocument;
			}
		}
		
		/**
		* Gets the editor control
		*/
		public ScintillaControl CurSciControl
		{
			get 
			{
				DockContent activeDoc = this.dockPanel.ActiveDocument;
				if ((activeDoc == null) || (activeDoc.Controls.Count == 0)) return null;
				else 
				{
					foreach(Control ctrl in activeDoc.Controls)
					{
						if (ctrl is ScintillaControl) return ctrl as ScintillaControl;
					}
					return null;
				}
			}
		}
		
		/**
		* Gets the statusBar
		*/
		public StatusBar StatusBar
		{
			get 
			{
				return this.statusBar;
			}
		}
		
		/**
		* Gets the used resource manager
		*/
		public ResourceManager Resources
		{
			get 
			{
				return this.resources;
			}
		}
		
		/**
		* Checks that if the app is closing
		*/
		public bool IsClosing
		{
			get 
			{
				return this.closingEntirely;
			}
		}
		
		/**
		* Checks that if there are modified documents
		*/
		public bool HasModifiedDocuments
		{
			get 
			{
				DockContent[] elements = this.GetDocuments();
				int count = elements.Length;
				for (int i = 0; i<count; i++){
					if (elements[i].Text.EndsWith("*"))
					{
						return true;
					}
				}
				return false;
			}
		}
		
		#endregion

		#region CreateNewSciControl
		
		/**
		* Creates a new editor control for the document 
		*/
		public ScintillaControl CreateNewSciControl(string file, string text, int codepage)
		{
			ScintillaControl sciControl = new ScintillaControl();
			sciControl.AutoCSeparator = 32;
			sciControl.AutoCTypeSeparator = 63;
			sciControl.IsAutoCGetAutoHide = true;
			sciControl.IsAutoCGetCancelAtStart = false;
			sciControl.IsAutoCGetChooseSingle = false;
			sciControl.IsAutoCGetDropRestOfWord = false;
			sciControl.IsAutoCGetIgnoreCase = false;
			sciControl.ControlCharSymbol = 0;
			sciControl.CurrentPos = 0;
			sciControl.CursorType = -1;
			sciControl.Dock = System.Windows.Forms.DockStyle.Fill;
			sciControl.DocPointer = 187541976;
			sciControl.EndAtLastLine = 1;
			sciControl.EdgeColumn = 0;
			sciControl.EdgeMode = 0;
			sciControl.IsHScrollBar = true;
			sciControl.IsMouseDownCaptures = true;
			sciControl.IsBufferedDraw = true;
			sciControl.IsOvertype = false;
			sciControl.IsReadOnly = false;
			sciControl.IsUndoCollection = true;
			sciControl.IsVScrollBar = true;
			sciControl.IsUsePalette = true;
			sciControl.IsTwoPhaseDraw = true;
			sciControl.LayoutCache = 1;
			sciControl.Lexer = 3;
			sciControl.Location = new System.Drawing.Point(0, 0);
			sciControl.MarginLeft = 5;
			sciControl.MarginRight = 5;
			sciControl.ModEventMask = this.sciEventMask;
			sciControl.MouseDwellTime = ScintillaControl.MAXDWELLTIME;
			sciControl.Name = "sciControl";
			sciControl.PrintMagnification = 0;
			sciControl.PrintColourMode = (int)ScintillaNet.Enums.PrintOption.Normal;
			sciControl.PrintWrapMode = (int)ScintillaNet.Enums.Wrap.Word;
			sciControl.SearchFlags = 0;
			sciControl.SelectionEnd = 0;
			sciControl.SelectionMode = 0;
			sciControl.SelectionStart = 0;
			sciControl.Size = new System.Drawing.Size(100, 100);
			sciControl.SmartIndentType = ScintillaNet.Enums.SmartIndent.CPP;
			sciControl.Status = 0;
			sciControl.StyleBits = 7;
			sciControl.TabIndex = 0;
			sciControl.TargetEnd = 0;
			sciControl.TargetStart = 0;
			sciControl.WrapStartIndent = 4;
			sciControl.WrapVisualFlagsLocation = (int)ScintillaNet.Enums.WrapVisualLocation.EndByText;
			sciControl.WrapVisualFlags = (int)ScintillaNet.Enums.WrapVisualFlag.End;
			sciControl.XOffset = 0;
			sciControl.ZoomLevel = 0;
			sciControl.UsePopUp(false);
			sciControl.SetMarginTypeN(0, 0);
			sciControl.SetMarginWidthN(0, 14);
			sciControl.SetMarginTypeN(1, 1);
			sciControl.SetMarginMaskN(1, 0);
			sciControl.SetMarginTypeN(2, 0);
			sciControl.SetMarginMaskN(2, -33554432);
			sciControl.MarginSensitiveN(2, true);
			sciControl.MarkerDefinePixmap(0, this.xpmBookmark);
			sciControl.MarkerSetBack((int)ScintillaNet.Enums.MarkerOutline.Folder, 0x777777);
			sciControl.MarkerSetFore((int)ScintillaNet.Enums.MarkerOutline.Folder, 0xFFFFFF);
			sciControl.MarkerSetBack((int)ScintillaNet.Enums.MarkerOutline.FolderOpen, 0x777777);
			sciControl.MarkerSetFore((int)ScintillaNet.Enums.MarkerOutline.FolderOpen, 0xFFFFFF);
			sciControl.MarkerSetBack((int)ScintillaNet.Enums.MarkerOutline.FolderSub, 0x777777);
			sciControl.MarkerSetFore((int)ScintillaNet.Enums.MarkerOutline.FolderSub, 0xFFFFFF);
			sciControl.MarkerSetBack((int)ScintillaNet.Enums.MarkerOutline.FolderTail, 0x777777);
			sciControl.MarkerSetFore((int)ScintillaNet.Enums.MarkerOutline.FolderTail, 0xFFFFFF);
			sciControl.MarkerSetBack((int)ScintillaNet.Enums.MarkerOutline.FolderEnd, 0x777777);
			sciControl.MarkerSetFore((int)ScintillaNet.Enums.MarkerOutline.FolderEnd, 0xFFFFFF);
			sciControl.MarkerSetBack((int)ScintillaNet.Enums.MarkerOutline.FolderOpenMid, 0x777777);
			sciControl.MarkerSetFore((int)ScintillaNet.Enums.MarkerOutline.FolderOpenMid, 0xFFFFFF);
			sciControl.MarkerSetBack((int)ScintillaNet.Enums.MarkerOutline.FolderMidTail, 0x777777);
			sciControl.MarkerSetFore((int)ScintillaNet.Enums.MarkerOutline.FolderMidTail, 0xFFFFFF);
			sciControl.MarkerDefine((int)ScintillaNet.Enums.MarkerOutline.Folder, ScintillaNet.Enums.MarkerSymbol.BoxPlus);
			sciControl.MarkerDefine((int)ScintillaNet.Enums.MarkerOutline.FolderOpen, ScintillaNet.Enums.MarkerSymbol.BoxMinus);
			sciControl.MarkerDefine((int)ScintillaNet.Enums.MarkerOutline.FolderSub, ScintillaNet.Enums.MarkerSymbol.VLine);
			sciControl.MarkerDefine((int)ScintillaNet.Enums.MarkerOutline.FolderTail, ScintillaNet.Enums. MarkerSymbol.LCorner);
			sciControl.MarkerDefine((int)ScintillaNet.Enums.MarkerOutline.FolderEnd, ScintillaNet.Enums.MarkerSymbol.BoxPlusConnected);
			sciControl.MarkerDefine((int)ScintillaNet.Enums.MarkerOutline.FolderOpenMid, ScintillaNet.Enums.MarkerSymbol.BoxMinusConnected);
			sciControl.MarkerDefine((int)ScintillaNet.Enums.MarkerOutline.FolderMidTail, ScintillaNet.Enums.MarkerSymbol.TCorner);
			sciControl.MarkerSetBack((int)ScintillaNet.Enums.MarkerSymbol.Background, SharedUtils.ResolveColor(this.settings.GetValue("FlashDevelop.BookmarkColor")));
			sciControl.CodePage = this.SelectCodePage(codepage);
			sciControl.Encoding = Encoding.GetEncoding(codepage);
			sciControl.Text = SharedUtils.ConvertText(text, codepage, sciControl.CodePage);
			sciControl.Tag = file;
			sciControl.ContextMenu = this.editorMenu;
			sciControl.MarginClick += new MarginClickHandler(this.OnScintillaControlMarginClick);
			sciControl.Modified += new ModifiedHandler(this.OnScintillaControlModified);
			sciControl.UpdateUI += new UpdateUIHandler(this.OnScintillaControlUpdateControl);
			sciControl.URIDropped += new URIDroppedHandler(this.OnScintillaControlDropFiles);
			sciControl.ModifyAttemptRO += new ModifyAttemptROHandler(this.OnScintillaControlModifyRO);
			if (!file.StartsWith("Untitled")) sciControl.IsReadOnly = FileSystem.IsReadOnly(file);
			sciControl.SetFoldFlags(this.settings.GetInt("FlashDevelop.FoldFlags"));
			sciControl.ConfigurationLanguage = this.SciConfig.GetLanguageFromFile(file);
			this.CheckActiveLanguageButton(sciControl.ConfigurationLanguage);
			this.ApplySciSettings(sciControl);
			sciControl.EmptyUndoBuffer();
			UITools.ListenTo(sciControl);
			try 
			{
				bool collapseAll = this.settings.GetBool("FlashDevelop.CollapseAllOnFileOpen");
				if (collapseAll) sciControl.CollapseAllFolds();
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while handling collapse all on file open.", ex);
			}
			return sciControl;
		}
		
		#endregion

		#region EventHandlers
		
		/**
		* Restores the focus on activation
		*/
		public void OnMainFormActivate(object sender, System.EventArgs e)
		{
			if (this.CurSciControl != null) this.CurSciControl.Focus();
			if (this.CurDocument != null)
			{
				try 
				{
					TabbedDocument document = (TabbedDocument)this.CurDocument;
					document.CheckFileChange();
				} 
				catch {}
			}
		}
		
		/**
		* Setups misc stuff when MainForm is loaded
		*/
		public void OnMainFormLoad(object sender, System.EventArgs e)
		{
			/**
			* DockPanel events 
			*/
			this.dockPanel.ActiveContentChanged += new EventHandler(this.OnActiveContentChanged);
			this.dockPanel.ActiveDocumentChanged += new EventHandler(this.OnActiveDocumentChanged);
			/** 
			* Populate menus and check buttons 
			*/
			this.PopulateReopenMenu(); 
			this.CheckActiveEncodingButton(this.DefaultCodePage);
			this.CheckEditorButtons();
			/**
			* Set the initial directory for file dialogs
			*/
			string path = this.settings.GetValue("FlashDevelop.LatestDialogPath");
			this.openFileDialog.InitialDirectory = this.saveFileDialog.InitialDirectory = path;
			/**
			* Open document from start args
			*/ 
			this.OpenDocumentsFromStartArgs(this.startArgs, false);
		}
		
		/**
		* Checks that if there are modified documents when the MainForm is closing
		*/
		public void OnMainFormClosing(object sender, System.ComponentModel.CancelEventArgs e)
		{
			NotifyEvent ne = new NotifyEvent(EventType.UIClosing);
			Global.Plugins.NotifyPlugins(this, ne);
			//
			this.closingEntirely = true;
			if (ne.Handled) e.Cancel = true;
			if (!e.Cancel) this.CloseAllDocuments();
			if (this.closeAllCanceled) 
			{
				this.closeAllCanceled = false;
				this.closingEntirely = false;
				e.Cancel = true;
			}
			if (!e.Cancel)
			{
				Global.Plugins.ClosePlugins();
				this.SaveAllSettings();
			}
		}
		
		/**
		* Watch if a pane or a scintilla control is selected
		* Disable Scintilla key-listening if a pane is active
		*/
		private void OnActiveContentChanged(object sender, System.EventArgs e)
		{
			if ((dockPanel.ActivePane != null) && (dockPanel.ActivePane.Controls.Count > 2))
			{
				ScintillaControl sci = this.CurSciControl;
				if (sci != null) sci.IsActive = (dockPanel.ActivePane.Controls[2] is FlashDevelop.TabbedDocument);
				//
				NotifyEvent ne = new NotifyEvent(EventType.UIRefresh);
				Global.Plugins.NotifyPlugins(this, ne);
			}
		}
		
		/**
		* Opens the selected files on drop
		*/
		public void OnScintillaControlDropFiles(ScintillaControl sci, string data)
		{
			string[] files = Regex.Split(data.Substring(1, data.Length-2), "\" \"");
			foreach (string file in files)
			{
				this.OpenSelectedFile(file);
			}
		}
		
		private Regex re_pathDirectory = new Regex(@"\\[^.][^\\]*\\", RegexOptions.Compiled);
		
		/**
		* Refreshes the statusbar display and 
		* updates the important edit buttons
		*/
		public void OnScintillaControlUpdateControl(ScintillaControl sci)
		{
			if (sci != this.CurSciControl) return;
			int column = sci.Column(sci.CurrentPos)+1;
			int line = sci.LineFromPosition(sci.CurrentPos)+1;
			string file = sci.Tag.ToString();
			int eolMode = sci.EOLMode;
			string eol = (eolMode == 0) ? "CR+LF" : ((eolMode == 1) ? "CR" : "LF");
			string txt = "  Line: "+line+"  |  Column: "+column+"  |  EOL: ("+eol+")  |  "+file;
			// reduce the path to fit 128 chars max in the status bar
			while (txt.Length > 128 && re_pathDirectory.IsMatch(txt)) {
				txt = re_pathDirectory.Replace(txt, @"\...\", (int)1);
			}
			this.statusBarPanel.Text = txt;
			
			this.Text = this.CurDocument.Text+" - FlashDevelop";
			this.CheckActiveEncodingButton(sci.Encoding.CodePage);
			this.CheckActiveLanguageButton(sci.ConfigurationLanguage);
			this.CheckActiveEOLButton(sci.EOLMode);
			this.UpdateButtonsEnabled();
			//
			NotifyEvent ne = new NotifyEvent(EventType.UIRefresh);
			Global.Plugins.NotifyPlugins(this, ne);
		}
		
		/**
		* Notifies when the user is trying to modify a read only file
		*/
		public void OnScintillaControlModifyRO(ScintillaControl sci)
		{
			if (!sci.Enabled) return;
			string msg = "The file is marked as read only. Do you want to make the file writable? ";
			if (MessageBox.Show(msg, " Information", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
			{
				this.MakeFileWritable(sci);
			}
		}
		
		/**
		* Handles the modified event
		*/
		public void OnScintillaControlModified(ScintillaControl sender , int pos, int modType, string text, int length, int lAdded, int line, int fLevelNow, int fLevelPrev)
		{
			this.OnDocumentModify();
		}
		
		/**
		* Provides a basic folding service and notifies 
		* the plugins for the MarginClick event
		*/
		public void OnScintillaControlMarginClick(ScintillaControl sci, int modifiers, int position, int margin)
		{
			if (margin == 2) 
			{
				int line = sci.LineFromPosition(position);
				sci.ToggleFold(line);
			}
		}
		
		/**
		* Updates the important edit buttons, selectes the corrent language 
		* and encoding. Also notifies the plugins for the FileSwitch event.
		*/
		public void OnActiveDocumentChanged(object sender, System.EventArgs e)
		{
			if (this.CurSciControl == null) return;
			this.CurSciControl.IsActive = true;
			try
			{
				/**
				* Bring this newly active document to the top of the tab history
				* unless you're currently cycling through tabs with the keyboard
				*/
				if (!this.tabTimer.Enabled)
				{
					tabHistory.Remove(this.CurDocument);
					tabHistory.Insert(0,this.CurDocument);
				}
				/**
				* Update UI
				*/
				this.OnScintillaControlUpdateControl(this.CurSciControl);
				/**
				* Set working directory
				*/
				string path = Path.GetDirectoryName(this.CurFile);
				if (!this.CurDocIsUntitled() && Directory.Exists(path))
				{
					Directory.SetCurrentDirectory(path);
				}
				/**
				* Check if file is changed outside of FlashDevelop
				*/
				TabbedDocument document = (TabbedDocument)this.CurDocument;
				document.CheckFileChange();
				/**
				* Send notifications
				*/
				if (this.notifyOpen)
				{
					this.notifyOpen = false;
					TextEvent te = new TextEvent(EventType.FileOpen, this.CurFile);
					Global.Plugins.NotifyPlugins(this, te);
				}
				NotifyEvent ne = new NotifyEvent(EventType.FileSwitch);
				Global.Plugins.NotifyPlugins(this, ne);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError(ex.Message, ex);
			}
		}
		
		/**
		* Checks that if the are anymodified documents when closing. 
		* Also notifies the plugins for the FileOpen event
		*/
		public void OnDocumentClosing(object sender, System.ComponentModel.CancelEventArgs e)
		{
			if (this.closeAllCanceled && this.closingAll) e.Cancel = true;
			else if (this.CurDocIsModified())
			{
				DialogResult result = MessageBox.Show("Do you want to save the current changes?", " Save changes in: "+this.CurDocument.Text, MessageBoxButtons.YesNoCancel, MessageBoxIcon.Question);
				if (result == DialogResult.Yes)
	   			{
					if (this.CurDocIsUntitled())
					{
						this.saveFileDialog.FileName = this.CurFile;
						if (this.saveFileDialog.ShowDialog(this) == System.Windows.Forms.DialogResult.OK && this.saveFileDialog.FileName.Length != 0)
						{
							this.CleanUpDocument(this.CurSciControl);
							this.AddNewReopenMenuItem(this.saveFileDialog.FileName);
							this.SaveSelectedFile(this.saveFileDialog.FileName, this.CurSciControl.Text);
						} 
						else 
						{
							if (this.closingAll) this.closeAllCanceled = true;
							e.Cancel = true;
						}
					}
					else if (this.CurDocIsModified())
					{
						this.CleanUpDocument(this.CurSciControl);
						this.SaveSelectedFile(this.CurFile, this.CurSciControl.Text);
					}
				} 
				else if (result == DialogResult.Cancel)
				{
					if (this.closingAll) this.closeAllCanceled = true;
					e.Cancel = true;
				}
			}
			DockContent[] elements = this.GetDocuments();
			if (elements.Length == 1 && this.CurDocIsUntitled() && !this.CurDocIsModified() && !e.Cancel && !this.closingForOpenFile)
			{
				e.Cancel = true;
			}
			if (!e.Cancel)
			{
				DockContent doc = (DockContent)sender;
				this.documentIndex = this.GetIndexForDockContent(doc);
				//
				NotifyEvent ne = new NotifyEvent(EventType.FileClose);
				Global.Plugins.NotifyPlugins(this, ne);
				//
				tabHistory.Remove(doc); // This document is really closing, so remove it from the tab history
				if (!this.settings.GetBool("FlashDevelop.SequentialTabbing")) // Activate the next document in the history
				{
					this.NavigateTabHistory(0);
				}
			}
			if (elements.Length == 1 && !e.Cancel && !this.closingForOpenFile && !this.closingEntirely)
			{
				this.New(null, null);
			}
		}
		
		/**
		* Activates the previous item when closed.
		*/
		public void OnDocumentClosed(object sender, System.EventArgs e)
 		{
			try 
			{
				if (this.settings.GetBool("FlashDevelop.SequentialTabbing"))
				{
					int previousIndex = this.documentIndex-1;
					this.dockPanel.Documents[previousIndex].Activate();
				}
			} 
			catch {}
        }
		
		/**
		* Handles the PrintPage event
		*/
		public void OnPrintDocumentPrintPage(object sender, System.Drawing.Printing.PrintPageEventArgs e)
 		{
			this.pageNum++;
			string footer = "Page "+this.pageNum+" - "+this.CurFile;
			this.lastChar = this.CurSciControl.FormatRange(false, e, this.lastChar, this.CurSciControl.Length);
			e.Graphics.DrawLine(new Pen(Color.Black), 35, e.PageBounds.Height-60, e.PageBounds.Width-35, e.PageBounds.Height-60);
			e.Graphics.DrawString(footer, new Font("Arial", 7), Brushes.Black, 35, e.PageBounds.Height-55, StringFormat.GenericDefault);
			if (this.lastChar<this.CurSciControl.Length) e.HasMorePages = true;
			else 
			{
				e.HasMorePages = false;
				this.CurSciControl.FormatRangeDone();
				this.lastChar = 0;
				this.pageNum = 0;
			}
        }
		
		/**
		* Handles the application shortcuts
		*/
		protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
		{
			/**
			* Notify plugins. Don't notify ControlKey or ShiftKey as it polls a lot
			*/
			KeyEvent ke = new KeyEvent(EventType.Shortcut, keyData);
			Keys keyCode = keyData & Keys.KeyCode;
			if ((keyCode != Keys.ControlKey) && (keyCode != Keys.ShiftKey))
			{
				Global.Plugins.NotifyPlugins(this, ke);
			} 
			if (!ke.Handled)
			{
				ScintillaControl sci = CurSciControl;
				if ((sci != null) && (sci.IgnoreAllKeys || !sci.IsActive)) return base.ProcessCmdKey(ref msg, keyData);
				else {
					bool handled = this.commandBarManager.PreProcessMessage(ref msg);
					if (!handled) 
					{
						// Process special key combinations
						if ((keyData & Keys.Control) != 0)
						{
							// Allow "chaining" of Ctrl-Tab commands if you keep holding control down
							this.tabTimer.Enabled = true;
							
							if ((keyData == (Keys.Control | Keys.Next)) || (keyData == (Keys.Control | Keys.Tab)))
							{
								if (keyData == (Keys.Control | Keys.Next) ||
								    this.settings.GetBool("FlashDevelop.SequentialTabbing"))
									this.NextDocument(null, null);
								else
									this.NavigateTabHistory(1);
							}
							if ((keyData == (Keys.Control | Keys.Prior)) || (keyData == (Keys.Control | Keys.Shift | Keys.Tab)))
							{
								if (keyData == (Keys.Control | Keys.Prior) || this.settings.GetBool("FlashDevelop.SequentialTabbing")) 
								{
									this.PreviousDocument(null, null);
								}
								else this.NavigateTabHistory(-1);
							}
							handled = true;
						}
					}
					return handled;
				}
			}
			return true;
		}		
		
		/**
		* Notifies the plugins for the LanguageChange event
		*/
		public void OnChangeLanguage(string lang)
		{
			TextEvent te = new TextEvent(EventType.LanguageChange, lang);
			Global.Plugins.NotifyPlugins(this, te);
		}
		
		/**
		* Removes the "*" from the end of the document on file reload
		* and resets the find and replace results
		*/
		public void OnFileReload()
		{
			this.reloadingDoc = false;
			this.Text = this.CurDocument.Text + " - FlashDevelop";
			this.findDialog.ResetResults();
			this.replaceDialog.ResetResults();
			this.UpdateButtonsEnabled();
		}
		
		/**
		* Removes the "*" from the end of the document on file save 
		* and notifies the plugins for the FileSave event
		*/
		public void OnFileSave(string file)
		{
			this.UpdateButtonsEnabled();
			this.Text = this.CurDocument.Text+" - FlashDevelop";
			//
			TextEvent te = new TextEvent(EventType.FileSave, file);
			Global.Plugins.NotifyPlugins(this, te);
		}
		
		/**
		* Adds the "*" to the end of the document on modify
		*/
		public void OnDocumentModify()
		{
			if (!this.CurDocIsModified() && !this.CurSciControl.IsReadOnly && !reloadingDoc)
			{
				this.CurDocument.Text = this.CurDocument.Text+"*";
				this.Text = this.CurDocument.Text + " - FlashDevelop";
			}
			this.findDialog.ResetResults();
			this.replaceDialog.ResetResults();
			this.UpdateButtonsEnabled();
		}
		
		#endregion

		#region ClickHandlers
		
		/**
		* Create a new blank document
		*/
		public void New(object sender, System.EventArgs e)
		{
			string fileName = this.GetNewDocumentName();
			TextEvent te = new TextEvent(EventType.FileNew, fileName);
			Global.Plugins.NotifyPlugins(this, te);
			if (!te.Handled)
			{
				this.CreateNewDocument(fileName, "", this.DefaultCodePage);
			}
		}
		
		/**
		* Opens the open file dialog and opens the selected file
		*/
		public void Open(object sender, System.EventArgs e)
		{
			this.openFileDialog.Multiselect = true;
			if (!this.CurDocIsUntitled())
			{
				string path = Path.GetDirectoryName(this.CurFile);
				this.openFileDialog.InitialDirectory = path;
			}
			if (this.openFileDialog.ShowDialog(this) == System.Windows.Forms.DialogResult.OK && this.openFileDialog.FileName.Length != 0)
			{
				int count = this.openFileDialog.FileNames.Length;
				for (int i = 0; i<count; i++)
				{
					this.OpenSelectedFile(openFileDialog.FileNames[i]);
				}
			}
			this.openFileDialog.Multiselect = false;
		}
		
		/**
		* Reopens a file from the old documents list
		*/
		public void Reopen(object sender, System.EventArgs e)
		{
			CommandBarButton cmButton;
			cmButton = (CommandBarButton)sender;
			if (File.Exists(cmButton.Text))
			{
				this.AddNewReopenMenuItem(cmButton.Text);
				this.OpenSelectedFile(cmButton.Text);
			}
			else
			{
				ErrorHandler.ShowInfo("Could not find the file to reopen. The reopen menu will be repopulated.");
				this.documents.RemoveByValue(cmButton.Text);
				this.PopulateReopenMenu();
			}
		}
		
		/**
		* Clears all entries from the old documents list
		*/
		public void ClearReopenList(object sender, System.EventArgs e)
		{
			this.documents.Settings.Clear();
			this.PopulateReopenMenu();
		}
		
		/**
		* Saves the current file or opens a save file dialog
		*/
		public void Save(object sender, System.EventArgs e)
		{
			if (this.CurDocIsUntitled())
			{
				this.saveFileDialog.FileName = this.CurFile;
				if (this.saveFileDialog.ShowDialog(this) == System.Windows.Forms.DialogResult.OK && this.saveFileDialog.FileName.Length != 0)
				{
					this.CleanUpDocument(this.CurSciControl);
					this.AddNewReopenMenuItem(this.saveFileDialog.FileName);
					this.SaveSelectedFile(this.saveFileDialog.FileName, this.CurSciControl.Text);
				}
			}
			else if (this.CurDocIsModified())
			{
				this.CleanUpDocument(this.CurSciControl);
				this.SaveSelectedFile(this.CurFile, this.CurSciControl.Text);
			}
		}
		
		/**
		* Saves the current document with the specified file name
		*/
		public void SaveAs(object sender, System.EventArgs e)
		{
			this.saveFileDialog.FileName = this.CurFile;
			if (this.saveFileDialog.ShowDialog(this) == System.Windows.Forms.DialogResult.OK && this.saveFileDialog.FileName.Length != 0)
			{
				this.CleanUpDocument(this.CurSciControl);
				this.AddNewReopenMenuItem(this.saveFileDialog.FileName);
				this.SaveSelectedFile(this.saveFileDialog.FileName, this.CurSciControl.Text);
			}
		}
		
		/**
		* Saves all modified documents or opens a save file dialog
		*/
		public void SaveAll(object sender, System.EventArgs e)
		{
			DockContent[] elements = this.GetDocuments();
			int count = elements.Length;
			DockContent active = this.CurDocument;
			for (int i = 0; i<count; i++)
			{
				elements[i].Activate();
				DockContent doc = this.CurDocument;
				if (this.CurDocIsModified())
				{
					if (this.CurDocIsUntitled())
					{
						this.saveFileDialog.FileName = this.CurFile;
						if (this.saveFileDialog.ShowDialog(this) == System.Windows.Forms.DialogResult.OK && this.saveFileDialog.FileName.Length != 0)
						{
							this.CleanUpDocument(this.CurSciControl);
							this.AddNewReopenMenuItem(this.saveFileDialog.FileName);
							this.SaveSelectedFile(this.saveFileDialog.FileName, this.CurSciControl.Text);
						}
					}
					else
					{
						this.CleanUpDocument(this.CurSciControl);
						this.SaveSelectedFile(this.CurFile, this.CurSciControl.Text);
					}
				}
			}
			active.Activate();
		}
		
		/**
		* Saves only edited documents (not untitled ones) with extension filter
		*/
		public void SaveAllModified(object sender, System.EventArgs e)
		{
			string filter = "*";
			CommandBarButton cmButton;
			cmButton = (CommandBarButton)sender;
			if (cmButton.Tag != null) filter = (string)cmButton.Tag+filter;
			DockContent[] elements = this.GetDocuments();
			int count = elements.Length;
			DockContent active = this.CurDocument;
			for (int i = 0; i<count; i++)
			{
				if (elements[i].Text.StartsWith("Untitled") || !elements[i].Text.EndsWith(filter)) continue;
				elements[i].Activate();
				DockContent doc = this.CurDocument;
				if (this.CurDocIsModified())
				{
					if (!this.CurDocIsUntitled())
					{
						this.CleanUpDocument(this.CurSciControl);
						this.SaveSelectedFile(this.CurFile, this.CurSciControl.Text);
					}
				}
			}
			active.Activate();
		}
		
		/**
		* Duplicates the current document
		*/
		public void Duplicate(object sender, System.EventArgs e) 
		{
			string contents = this.CurSciControl.Text;
			string document = this.GetNewDocumentName();
			int codepage = this.CurSciControl.Encoding.CodePage;
			this.CreateNewDocument(document, contents, codepage);
		}
		
		/**
		* Reverts the document to the default state
		*/
		public void Revert(object sender, System.EventArgs e) 
		{
			if (MessageBox.Show("Are you sure you want to revert the file?", " Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
			{
				while (this.CurSciControl.CanUndo)
				{
					this.CurSciControl.Undo();
				}
				this.UpdateButtonsEnabled();
			}
		}
		
		/**
		* Reloads the current document
		*/
		public void Reload(object sender, System.EventArgs e)
		{
			if (!this.CurDocIsUntitled())
			{
				this.ReloadDocument(this.CurDocument, true);
			}
		}
		
		/**
		* Prints the current document
		*/
		public void Print(object sender, System.EventArgs e)
		{
			if (this.CurSciControl.TextLength == 0)
			{
				ErrorHandler.ShowInfo("There's nothing to print.");
				return;
			}
		  	try
		  	{
		     	this.pageNum = 0;
		  		this.lastChar = 0;
		  		this.printDocument = new PrintDocument();
		     	this.printDocument.DocumentName = this.CurDocument.Text;
		     	this.printDocument.PrintPage += new PrintPageEventHandler(this.OnPrintDocumentPrintPage);
		     	this.printDialog.PrinterSettings = new PrinterSettings();
		     	if (this.printDialog.ShowDialog(this) == DialogResult.OK)
		     	{
					this.printDocument.Print();
				}
		  	}
		  	catch (Exception ex)
		  	{
		  		ErrorHandler.ShowError("Error while printing: "+ex.Message, ex);
		  	}
		}
		
		/**
		* Views the current print document
		*/
		public void PrintPreview(object sender, System.EventArgs e)
		{
		  	if (this.CurSciControl.TextLength == 0)
			{
				ErrorHandler.ShowInfo("There's nothing to print.");
				return;
			}
			try
		  	{
				this.pageNum = 0;
				this.lastChar = 0;
				this.printDocument = new PrintDocument();
				this.printDocument.DocumentName = this.CurDocument.Text;
		     	this.printDocument.PrintPage += new PrintPageEventHandler(this.OnPrintDocumentPrintPage);
		     	this.printPreviewDialog.Document = this.printDocument;
				this.printPreviewDialog.ShowDialog(this);
		  	}
		  	catch (Exception ex)
		  	{
		  		ErrorHandler.ShowError("Error while printing: "+ex.Message, ex);
		  	}
		}
		
		/**
		* Closes the current document
		*/
		public void Close(object sender, System.EventArgs e)
		{
			this.CurDocument.Close();
		}
		
		/**
		* Closes all open documents
		*/
		public void CloseAll(object sender, System.EventArgs e)
		{
			this.CloseAllDocuments();
		}
		
		/**
		* Exits the application
		*/
		public void Exit(object sender, System.EventArgs e)
		{
			this.Close();
		}
		
		/**
		* Opens a goto dialog and moves the user to the specified place
		*/
		public void GoTo(object sender, System.EventArgs e)
		{
			this.gotoDialog.ShowDialog();
		}
		
		/**
		* Moves the user to the matching brace
		*/
		public void GoToMatchingBrace(object sender, System.EventArgs e)
		{
			int curPos = this.CurSciControl.CurrentPos;
			char brace = (char)this.CurSciControl.CharAt(curPos);
			if (brace != '{' && brace != '[' && brace != '(' && brace != '}' && brace != ']' && brace != ')')
			{
				curPos = this.CurSciControl.CurrentPos-1;
			}
			int bracePosEnd = this.CurSciControl.BraceMatch(curPos);
			if (bracePosEnd != -1) this.CurSciControl.GotoPos(bracePosEnd+1);
			
		}
		
		/**
		* Opens a find dialog
		*/
		public void Find(object sender, System.EventArgs e)
		{
			this.findDialog.Show();
		}
		
		/**
		* Opens a find in files dialog
		*/
		public void FindInFiles(object sender, System.EventArgs e)
		{
			this.findInFilesDialog.Show();
		}
		
		/**
		* Displays the next result.
		*/
		public void FindNext(object sender, System.EventArgs e)
		{
			this.findDialog.FindNext(false);
		}
		
		/**
		* Displays the next result.
		*/
		public void FindPrevious(object sender, System.EventArgs e)
		{
			this.findDialog.FindNext(true);
		}
		
		/**
		* Opens a find and replace dialog
		*/
		public void Replace(object sender, System.EventArgs e)
		{
			this.replaceDialog.Show();
		}
		
		/**
		* Opens the plugins list dialog
		*/
		public void ShowPluginList(object sender, System.EventArgs e)
		{
			InstalledPlugins installedPlugins = new InstalledPlugins(this);
			installedPlugins.ShowDialog();
		}
		
		/**
		* Opens the settings dialog
		*/
		public void ShowSettingsDlg(object sender, System.EventArgs e)
		{
			SettingsDlg settingsDlg = new SettingsDlg(this);
			settingsDlg.ShowDialog();
		}
		
		/**
		* Activates next document in tabs
		*/
		public void NextDocument(object sender, System.EventArgs e)
		{			
			DockContent current = this.CurDocument;
			DockContent[] elements = this.GetDocuments();
			int count = elements.Length;
			if (count <= 1) return;
			for (int i = 0; i<count; i++) 
			{
				if (elements[i] == current) 
				{
					if (i < count-1) elements[i+1].Activate();
					else elements[0].Activate();
				}
			}
		}
		
		/**
		* Activates previous document in tabs
		*/
		public void PreviousDocument(object sender, System.EventArgs e)
		{
			DockContent current = this.CurDocument;
			DockContent[] elements = this.GetDocuments();
			int count = elements.Length;
			if (count <= 1) return;
			for (int i = 0; i<count; i++) 
			{
				if (elements[i] == current) 
				{
					if (i > 0) elements[i-1].Activate();
					else elements[count-1].Activate();
				}
			}
		}
		
		/**
		* Visual Studio style keyboard tab navigation: similar to Alt-Tab
		*/
		private void NavigateTabHistory(int direction)
		{
			if (tabHistory.Count < 1) return;
			int currentIndex = 0;
			// navigate forward or backward through history
			if (direction != 0)
			{
				currentIndex = tabHistory.IndexOf(this.CurDocument);
				currentIndex = (currentIndex+direction) % tabHistory.Count;
				if (currentIndex == -1) currentIndex = tabHistory.Count-1;
			}
			DockContent newDoc = tabHistory[currentIndex] as DockContent;
			newDoc.Activate();
		}
		
		/**
		* Checks to see if the Control key has been released
		*/
		private void OnTabTimer(object sender, EventArgs e)
		{
			if ((Control.ModifierKeys & Keys.Control) == 0)
			{
				this.tabTimer.Enabled = false;
				// it's now safe to bring the current document to the front of the tab history
				tabHistory.Remove(this.CurDocument);
				tabHistory.Insert(0,this.CurDocument);
			}
		}
		
		/**
		* Adds or removes a bookmark
		*/
		public void ToggleBookmark(object sender, System.EventArgs e)
		{
			int line = this.CurSciControl.LineFromPosition(this.CurSciControl.CurrentPos);
			int marker = this.CurSciControl.MarkerGet(line);
			if (marker == 0) 
			{
				int mask = 1 | (1 << 1) | (1 << 2) | (1 << 3);
				this.CurSciControl.SetMarginMaskN(0, mask);
				this.CurSciControl.MarkerAdd(line, 0);
			}
			else this.CurSciControl.MarkerDelete(line, 0);
		}
		
		/**
		* Moves the cursor to the next bookmark
		*/
		public void NextBookmark(object sender, System.EventArgs e)
		{
			int next = 0;
			int line = this.CurSciControl.LineFromPosition(this.CurSciControl.CurrentPos);
			if (this.CurSciControl.MarkerGet(line) != 0) 
			{
				next = this.CurSciControl.MarkerNext(line+1, 1<<0);
				if (next != -1) this.CurSciControl.GotoLine(next);
				else 
				{
					next = this.CurSciControl.MarkerNext(0, 1<<0);
					if (next != -1) this.CurSciControl.GotoLine(next);
				}
			}
			else 
			{
				next = this.CurSciControl.MarkerNext(line, 1<<0);
				if (next != -1) this.CurSciControl.GotoLine(next);
				else 
				{
					next = this.CurSciControl.MarkerNext(0, 1<<0);
					if (next != -1) this.CurSciControl.GotoLine(next);
				}
			}
		}
		
		/**
		* Moves the cursor to the previous bookmark
		*/
		public void PrevBookmark(object sender, System.EventArgs e)
		{
			int prev = 0;
			int count = 0;
			int line = this.CurSciControl.LineFromPosition(this.CurSciControl.CurrentPos);
			if (this.CurSciControl.MarkerGet(line) != 0)
			{
				prev = this.CurSciControl.MarkerPrevious(line-1, 1<<0);
				if (prev != -1) this.CurSciControl.GotoLine(prev);
				else 
				{
					count = this.CurSciControl.LineCount;
					prev = this.CurSciControl.MarkerPrevious(count, 1<<0);
					if (prev != -1) this.CurSciControl.GotoLine(prev);
				}
			}
			else 
			{
				prev = this.CurSciControl.MarkerPrevious(line, 1<<0);
				if (prev != -1) this.CurSciControl.GotoLine(prev);
				else 
				{
					count = this.CurSciControl.LineCount;
					prev = this.CurSciControl.MarkerPrevious(count, 1<<0);
					if (prev != -1) this.CurSciControl.GotoLine(prev);
				}
			}
		}
		
		/**
		* Removes all bookmarks
		*/
		public void ClearBookmarks(object sender, System.EventArgs e)
		{
			this.CurSciControl.MarkerDeleteAll(0);
		}
		
		/**
		* Converts all end of line characters
		*/
		public void ConvertEOL(object sender, System.EventArgs e)
		{
			try
			{
				CommandBarButton cmButton;
				cmButton = (CommandBarButton)sender;
				int eolMode = Convert.ToInt32(cmButton.Tag);
				this.CurSciControl.ConvertEOLs(eolMode);
				this.CurSciControl.EOLMode = eolMode;
				this.CheckActiveEOLButton(eolMode);
				this.OnScintillaControlUpdateControl(this.CurSciControl);
				this.OnDocumentModify();
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while converting EOL characters.", ex);
			}
		}
		
		/**
		* Toggles the folding of the editor
		*/
		public void ToggleFold(object sender, System.EventArgs e)
		{
			int pos = this.CurSciControl.CurrentPos;
			int line = this.CurSciControl.LineFromPosition(pos);
			this.CurSciControl.ToggleFold(line);
		}
		
		/**
		* Toggles the text wrapping in ScintillaControl
		*/
		public void ToggleBoolSetting(object sender, System.EventArgs e)
		{
			try
			{
				CommandBarButton cmButton;
				cmButton = (CommandBarButton)sender;
				string settingKey = cmButton.Tag.ToString();
				if (this.settings.GetBool(settingKey))
				{
					this.settings.ChangeValue(settingKey, "false");
					this.ApplySciSettingsToAllDocuments();
				} 
				else 
				{
					this.settings.ChangeValue(settingKey, "true");
					this.ApplySciSettingsToAllDocuments();
				}
				this.CheckEditorButtons();
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while toggling boolean setting.", ex);
			}
		}
		
		/**
		* Changes the encoding of the current document
		*/
		public void ChangeEncoding(object sender, System.EventArgs e)
		{
			try
			{
				CommandBarButton cmButton;
				cmButton = (CommandBarButton)sender;
				int encMode = Convert.ToInt32(cmButton.Tag);
				this.CurSciControl.CodePage = this.SelectCodePage(encMode);
				this.CurSciControl.Encoding = Encoding.GetEncoding(encMode);
				this.CheckActiveEncodingButton(encMode);
				this.OnScintillaControlUpdateControl(this.CurSciControl);
				this.OnDocumentModify();
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while changing encoding.", ex);
			}
		}
		
		/**
		* Converts the encoding of the current document
		*/
		public void ConvertEncoding(object sender, System.EventArgs e)
		{
			try
			{
				CommandBarButton cmButton;
				cmButton = (CommandBarButton)sender;
				int encMode = Convert.ToInt32(cmButton.Tag);
				int curMode = this.CurSciControl.CodePage;
				string converted = SharedUtils.ConvertText(this.CurSciControl.Text, curMode, encMode);
				this.CurSciControl.Encoding = Encoding.GetEncoding(encMode);
				this.CurSciControl.CodePage = this.SelectCodePage(encMode);
				this.CurSciControl.Text = converted;
				this.CheckActiveEncodingButton(encMode);
				this.OnScintillaControlUpdateControl(this.CurSciControl);
				this.OnDocumentModify();
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while converting the text.", ex);
			}
		}
		
		/**
		* Inserts a color to the editor
		*/
		public void InsertColor(object sender, System.EventArgs e)
		{
			try
			{
	    		ScintillaControl sci = this.CurSciControl;
	    		if (this.colorDialog.ShowDialog(this) == DialogResult.OK)
	    		{
					DataEvent de = new DataEvent(EventType.CustomData, "FlashDevelop.InsertColor", this.colorDialog.Color);
					Global.Plugins.NotifyPlugins(this, de);
					//
					if (!de.Handled)
					{
						int position = this.CurSciControl.CurrentPos;
						string colorText = SharedUtils.ColorToHex(this.colorDialog.Color);
						if (sci.ConfigurationLanguage != "xml" && sci.ConfigurationLanguage != "html")
		    			{
		    				colorText = Regex.Replace(colorText, "#", "0x");
		    			}
		    			sci.ReplaceSel(colorText);
					}
	    		}
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while inserting color.", ex);
			}
		}
		
		/**
		* Inserts a new GUID to the editor
		*/
		public void InsertGUID(object sender, System.EventArgs e)
		{
			string guid = Guid.NewGuid().ToString();
			this.CurSciControl.ReplaceSel(guid);
		}
		
		/**
		* Inserts the file info to the current position
		*/
		public void InsertFileDetails(object sender, System.EventArgs e)
		{
			try
			{
				string filePath = this.CurFile;
				System.IO.FileInfo fileInfo = new System.IO.FileInfo(filePath);
				string path = fileInfo.FullName.ToString();
				string created = fileInfo.CreationTime.ToString();
				string modified = fileInfo.LastWriteTime.ToString();
				string size = fileInfo.Length.ToString();
				string newline = this.GetNewLineMarker(this.CurSciControl.EOLMode);
				string info = path+newline+"Created: "+created+newline+"Modified: "+modified+newline+"Size: "+size+" bytes";
				this.CurSciControl.ReplaceSel(info);
			}
			catch
			{
				ErrorHandler.ShowInfo("The are no file info available.");
			}
		}
		
		/**
		* Inserts a global timestamp to the current position
		*/
		public void InsertTimestamp(object sender, System.EventArgs e)
		{
			try
			{
				CommandBarButton cmButton;
				DateTime dateTime = DateTime.Now;
				cmButton = (CommandBarButton)sender;
				string date = cmButton.Tag.ToString();
				string currentDate = dateTime.ToString(date);
				this.CurSciControl.ReplaceSel(currentDate);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while inserting timestamp.", ex);
			}
		}
		
		/**
		* Opens the open file dialog and inserts the selected file to the current position
		*/
		public void InsertFromFile(object sender, System.EventArgs e)
		{
			if (this.openFileDialog.ShowDialog(this) == System.Windows.Forms.DialogResult.OK && openFileDialog.FileName.Length != 0)
			{
				Encoding to = this.CurSciControl.Encoding;
				int codepage = FileSystem.GetFileCodepage(this.openFileDialog.FileName);
				if (codepage == -1) return; // If the file is locked, stop.
				Encoding from = Encoding.GetEncoding(codepage);
				string contents = SharedUtils.ConvertText(FileSystem.Read(this.openFileDialog.FileName, from), from.CodePage, to.CodePage);
				this.CurSciControl.ReplaceSel(contents);
			}
		}
		
		/**
		* Inserts text from the specified file to the current position
		*/
		public void InsertFile(object sender, System.EventArgs e)
		{
			try
			{
				CommandBarButton cmButton;
				cmButton = (CommandBarButton)sender;
				string file = this.ProcessArgString(cmButton.Tag.ToString());
				Encoding to = this.CurSciControl.Encoding;
				int codepage = FileSystem.GetFileCodepage(file);
				if (codepage == -1) return; // If the file is locked, stop.
				Encoding from = Encoding.GetEncoding(codepage);
				string contents = SharedUtils.ConvertText(FileSystem.Read(file, from), from.CodePage, to.CodePage);
				this.CurSciControl.ReplaceSel(contents);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while inserting text.", ex);
			}
		}
		
		/**
		* Inserts a snippet to the current position
		*/
		public void InsertSnippet(object sender, System.EventArgs e)
		{
			try 
			{
				CommandBarButton cmButton;
				cmButton = (CommandBarButton)sender;
				string word = cmButton.Tag.ToString();
				// insert specific snippet
				if (word != "null") this.InsertTextByWord(word);
				// insert snippet from current word
				else 
				{
					ScintillaControl sci = this.CurSciControl;
					int position = sci.CurrentPos;
					string curWord = sci.GetWordFromPosition(position);
					// if the current word is a not valid snippet, display completion list
					if ((curWord == null) || !this.InsertTextByWord(curWord))
					{
						// get text at position
						curWord = "";
						position--;
						char c = (char)sci.CharAt(position);
						while (position > 0 && Regex.IsMatch(""+c, "[\\w]"))
						{
							curWord = c+curWord;
							position--;
							c = (char)sci.CharAt(position);
						}
						// init SnippetItem class
						if (SnippetItem.mainForm == null) 
						{
							SnippetItem.mainForm = this;
							SnippetItem.stdIcon = new Bitmap(this.GetSystemImage(113));
						}
						// build snippets list
						SnippetItem item;
						ArrayList list = new ArrayList();
						int count = this.snippets.Settings.Count;
						for (int i = 0; i<count; i++) 
						{
							SettingEntry se = (SettingEntry)this.snippets.Settings[i];
							item = new SnippetItem(se.Key, se.Value);
							list.Add(item);
						}
						// display list
						if (curWord.Length > 0) CompletionList.Show(list, false, curWord);
						else CompletionList.Show(list, false);
					}
				}
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while inserting template.", ex);
			}
		}
		
		/**
		* Line-comment the selected text
		*/
		public void CommentLine(object sender, System.EventArgs e)
		{
			ScintillaControl sci = this.CurSciControl;
			string lineComment = this.GetLineComment(sci.ConfigurationLanguage);
			if (lineComment.Length == 0) return;
			int position = sci.CurrentPos;
			int curLine = sci.LineFromPosition(position);
			int startPosInLine = position-sci.PositionFromLine(curLine);
			int finalPos = position;
			int startLine = sci.LineFromPosition(sci.SelectionStart);
			int line = startLine;
			int endLine = sci.LineFromPosition(sci.SelectionEnd);
			if (endLine > line && curLine == endLine && startPosInLine == 0) 
			{
				curLine--;
				endLine--;
				finalPos = sci.PositionFromLine(curLine);
			}
			string text;
			bool afterIndent = this.settings.GetBool("FlashDevelop.LineCommentsAfterIndent");
			sci.BeginUndoAction();
			while (line <= endLine)
			{
				if (sci.LineLength(line) == 0) text = "";
				else text = sci.GetLine(line).TrimStart();
				if (!text.StartsWith(lineComment))
				{
					position = (afterIndent) ? sci.LineIndentPosition(line) : sci.PositionFromLine(line);
					sci.InsertText(position, lineComment);
					if (line == curLine) 
					{
						finalPos = sci.PositionFromLine(line)+startPosInLine;
						if (finalPos >= position) finalPos += lineComment.Length;
					}
				}
				else if (line == startLine && startLine == endLine)
				{
					position = sci.LineIndentPosition(line);
					sci.SetSel(position, position+lineComment.Length);
					sci.ReplaceSel("");
					if (line == curLine) 
					{
						finalPos = sci.PositionFromLine(line)+Math.Min(startPosInLine, sci.LineLength(line));
						if (finalPos >= position+lineComment.Length) finalPos -= lineComment.Length;
					}
				}
				line++;
			}
			sci.SetSel(finalPos, finalPos);
			if (startLine == endLine && (endLine < sci.LineCount) && this.settings.GetBool("FlashDevelop.MoveCursorAfterComment"))
			{
				sci.LineDown();
			}
			sci.EndUndoAction();
		}
		
		/**
		* Line-uncomment the selected text
		*/
		public void UncommentLine(object sender, System.EventArgs e)
		{
			ScintillaControl sci = this.CurSciControl;
			string lineComment = this.GetLineComment(sci.ConfigurationLanguage);
			if (lineComment.Length == 0) return;
			int position = sci.CurrentPos;
			int curLine = sci.LineFromPosition(position);
			int startPosInLine = position-sci.PositionFromLine(curLine);
			int finalPos = position;
			int line = sci.LineFromPosition(sci.SelectionStart);
			int endLine = sci.LineFromPosition(sci.SelectionEnd);
			if (endLine > line && curLine == endLine && startPosInLine == 0) 
			{
				curLine--;
				endLine--;
				finalPos = sci.PositionFromLine(curLine);
			}
			string text;
			sci.BeginUndoAction();
			while (line <= endLine)
			{
				if (sci.LineLength(line) == 0) text = "";
				else text = sci.GetLine(line).TrimStart();
				if (text.StartsWith(lineComment))
				{
					position = sci.LineIndentPosition(line);
					sci.SetSel(position, position+lineComment.Length);
					sci.ReplaceSel("");
					if (line == curLine) 
					{
						finalPos = sci.PositionFromLine(line)+Math.Min(startPosInLine, sci.LineLength(line));
						if (finalPos >= position+lineComment.Length) finalPos -= lineComment.Length;
					}
				}
				line++;
			}
			sci.SetSel(finalPos, finalPos);
			sci.EndUndoAction();
		}
		
		/**
		* Box-comments the selected text
		*/
		public void CommentSelection(object sender, System.EventArgs e)
		{
			ScintillaControl sci = this.CurSciControl;
			int selEnd = sci.SelectionEnd;
			int selStart = sci.SelectionStart;
			int curPos = sci.CurrentPos;
			if (sci.SelText.Length > 0)
			{
				string commentStart = this.GetCommentStart(sci.ConfigurationLanguage);
				string commentEnd = this.GetCommentEnd(sci.ConfigurationLanguage);
				sci.BeginUndoAction();
				sci.InsertText(selStart, commentStart);
				sci.InsertText(selEnd+commentStart.Length, commentEnd);
				sci.EndUndoAction();
			}
		}
		
		/**
		* Changes the language of the current document
		*/
		public void ChangeSyntax(object sender, System.EventArgs e)
		{
			try
			{
				CommandBarButton cmButton;
				cmButton = (CommandBarButton)sender;
				cmButton.Image = this.images.GetImage(45);
				this.ChangeLanguage(cmButton.Tag.ToString());
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while changing the syntax.", ex);
			}
		}
		
		/**
		* Runs a simple process
		*/
		public void RunProcess(object sender, System.EventArgs e)
		{
			NotifyEvent ne = new NotifyEvent(EventType.ProcessStart);
			Global.Plugins.NotifyPlugins(this, ne);
			try
			{
				CommandBarButton cmButton;
				cmButton = (CommandBarButton)sender;
				string args = this.ProcessArgString(cmButton.Tag.ToString());
				int p = args.IndexOf(';');
				if (p > -1)
				{
					TraceLog.AddMessage("Running process: "+args.Substring(0,p)+" "+args.Substring(p+1), TraceLog.ProcessStart);
					Process.Start(args.Substring(0,p), args.Substring(p+1));
				} 
				else 
				{
					TraceLog.AddMessage("Running process: "+args, TraceLog.ProcessStart);
					// Run batch files without console window
					if (args.ToLower().EndsWith(".bat"))
					{
						Process bp = new Process();
						bp.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
						bp.StartInfo.FileName = @args;
						bp.Start();
					} 
					else 
					{
						Process.Start(args);
					}
				}
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while running the process.", ex);
			}
		}
				
		/**
		* Runs a process and tracks it's progress
		*/
		public void RunProcessCaptured(object sender, System.EventArgs e)
		{
			try
			{
				if (processRunner.IsRunning)
				{
					TraceLog.AddMessage("A process is currently running", TraceLog.Error);
					return;
				}
				NotifyEvent ne = new NotifyEvent(EventType.ProcessStart);
				Global.Plugins.NotifyPlugins(this, ne);
				CommandBarButton cmButton;
				cmButton = (CommandBarButton)sender;
				string args = this.ProcessArgString(cmButton.Tag.ToString());
				int p = args.IndexOf(';');
				if (p < 0)
				{
					TraceLog.AddMessage("Not enough arguments: "+args, TraceLog.Error);
					return;
				}
				TraceLog.AddMessage("Running process: "+args.Substring(0,p)+" "+args.Substring(p+1), TraceLog.ProcessStart);
				processRunner.Run(args.Substring(0,p), args.Substring(p+1));
				//
				CommandBarButton killButton = this.GetCBButton("KillProcess");
				if (killButton != null) killButton.IsEnabled = true;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while running the application:\n"+ex.Message, ex);
			}			
		}
		
		private void ProcessOutput(object sender, string line) 
		{
			if (this.InvokeRequired) this.BeginInvoke(new ProcessOutputHandler(this.ProcessOutput), new object[]{sender, line});
			else TraceLog.AddMessage(line, TraceLog.Info);
		}
		
		private void ProcessError(object sender, string line) 
		{
			if (this.InvokeRequired) this.BeginInvoke(new ProcessOutputHandler(this.ProcessError), new object[]{sender, line});
			else TraceLog.AddMessage(line, TraceLog.ProcessError);
		}
		
		private void ProcessEnded(object sender, int exitCode)
		{
			// This must be marshalled to the GUI thread since we're calling plugins
			if (this.InvokeRequired) this.BeginInvoke(new ProcessEndedHandler(this.ProcessEnded), new object[]{sender, exitCode});
			else
			{
				CommandBarButton killButton = this.GetCBButton("KillProcess");
				if (killButton != null) killButton.IsEnabled = false;
				// Restore working directory
				string path = Path.GetDirectoryName(this.CurFile);
				if (!this.CurDocIsUntitled() && Directory.Exists(path))
				{
					Directory.SetCurrentDirectory(path);
				}
				string result = string.Format("Done({0})", exitCode);
				TraceLog.AddMessage(result, TraceLog.ProcessEnd);
				//
				TextEvent te = new TextEvent(EventType.ProcessEnd, result);
				Global.Plugins.NotifyPlugins(this, te);
			}
		}
		
		/**
		* Stop the currently running process
		*/
		public void KillProcess(object sender, System.EventArgs e)
		{
			if (processRunner.IsRunning) processRunner.KillProcess();
		}
			
		/**
		* Opens the about dialog
		*/
		public void About(object sender, System.EventArgs e)
		{
			FlashDevelop.Windows.AboutDialog aboutDialog;
			aboutDialog = new FlashDevelop.Windows.AboutDialog(this);
			aboutDialog.ShowDialog();
		}
		
		/**
		* Call ScintillaControl command
		*/
		public void ScintillaCommand(object sender, System.EventArgs e)
		{
			try
			{
				CommandBarButton cmButton;
				cmButton = (CommandBarButton)sender;
				string command = cmButton.Tag.ToString();
				Type mfType = this.CurSciControl.GetType();
				MethodInfo method = mfType.GetMethod(command);
				method.Invoke(this.CurSciControl, null);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while sending a scintilla command.", ex);
			}
		}
		
		/**
		* Call custom plugin command
		*/
		public void PluginCommand(object sender, System.EventArgs e)
		{
			try
			{
				CommandBarButton cmButton;
				cmButton = (CommandBarButton)sender;
				NotifyEvent ne = new TextEvent(EventType.Command, cmButton.Tag.ToString());
				Global.Plugins.NotifyPlugins(this, ne);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while sending a plugin command.", ex);
			}
		}
		
		/**
		* Call MainForm normal method
		*/
		public bool CallCommand(string name, string tag)
		{
			try
			{
				Type mfType = this.GetType();
				System.Reflection.MethodInfo method = mfType.GetMethod(name);
				if (method == null) return false;
				CommandBarButton cmButton = new CommandBarButton();
				cmButton.Tag = tag;
				Object[] parameters = new Object[2];
				parameters[0] = cmButton;
				parameters[1] = null;
				method.Invoke(this, parameters);
				return true;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while calling a command.", ex);
				return false;
			}
		}

		#endregion
	
	}
	
}
