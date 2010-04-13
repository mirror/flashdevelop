using System;
using System.IO;
using System.Windows.Forms;
using System.ComponentModel;
using ASCompletion.Model;
using ASCompletion.Context;
using ASCompletion.Completion;
using CodeRefactor.Commands;
using CodeRefactor.Provider;
using CodeRefactor.Controls;
using PluginCore.Managers;
using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Helpers;
using PluginCore;

namespace CodeRefactor
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "CodeRefactor";
        private String pluginGuid = "5c0d3740-a6f2-11de-8a39-0800200c9a66";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "Adds refactoring capabilities to FlashDevelop.";
        private String pluginAuth = "FlashDevelop Team";
        private ToolStripMenuItem editorReferencesItem;
        private ToolStripMenuItem viewReferencesItem;
        private RefactorMenu refactorContextMenu;
        private RefactorMenu refactorMainMenu;
        private Settings settingObject;
        private String settingFilename;

        #region Required Properties

        /// <summary>
        /// Name of the plugin
        /// </summary> 
        public String Name
		{
			get { return this.pluginName; }
		}

        /// <summary>
        /// GUID of the plugin
        /// </summary>
        public String Guid
		{
			get { return this.pluginGuid; }
		}

        /// <summary>
        /// Author of the plugin
        /// </summary> 
        public String Author
		{
			get { return this.pluginAuth; }
		}

        /// <summary>
        /// Description of the plugin
        /// </summary> 
        public String Description
		{
			get { return this.pluginDesc; }
		}

        /// <summary>
        /// Web address for help
        /// </summary> 
        public String Help
		{
			get { return this.pluginHelp; }
		}

        /// <summary>
        /// Object that contains the settings
        /// </summary>
        [Browsable(false)]
        public Object Settings
        {
            get { return this.settingObject; }
        }
		
		#endregion

		#region Required Methods
		
		/// <summary>
		/// Initializes the plugin
		/// </summary>
		public void Initialize()
		{
            this.InitBasics();
            this.LoadSettings();
            this.CreateMenuItems();
        }

		/// <summary>
		/// Disposes the plugin
		/// </summary>
		public void Dispose()
		{
            this.SaveSettings();
		}
		
		/// <summary>
		/// Handles the incoming events
		/// </summary>
		public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
		{
            switch (e.Type)
            {
                case EventType.SettingChanged:
                    TextEvent evnt = (TextEvent)e;
                    if (evnt.Value.StartsWith("CodeRefactor"))
                    {
                        this.refactorContextMenu.ApplyShortcutKeys();
                        this.refactorMainMenu.ApplyShortcutKeys();
                        this.ApplyIgnoredKeys();
                    }
                    break;
            }
		}

        #endregion
   
        #region Event Handling
        
        /// <summary>
        /// Initializes important variables
        /// </summary>
        public void InitBasics()
        {
            String dataPath = Path.Combine(PathHelper.DataDir, "CodeRefactor");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            EventManager.AddEventHandler(this, EventType.SettingChanged | EventType.UIRefresh | EventType.FileSwitch);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            this.pluginDesc = TextHelper.GetString("Info.Description");
        }

        /// <summary>
        /// Creates the required menu items
        /// </summary>
        private void CreateMenuItems()
        {
            MenuStrip mainMenu = PluginBase.MainForm.MenuStrip;
            ContextMenuStrip editorMenu = PluginBase.MainForm.EditorMenu;
            this.refactorMainMenu = new RefactorMenu(this.settingObject);
            this.refactorMainMenu.RenameMenuItem.Click += new EventHandler(this.RenameClicked);
            this.refactorMainMenu.OrganizeMenuItem.Click += new EventHandler(this.OrganizeImportsClicked);
            this.refactorMainMenu.TruncateMenuItem.Click += new EventHandler(this.TruncateImportsClicked);
            this.refactorContextMenu = new RefactorMenu(this.settingObject);
            this.refactorContextMenu.RenameMenuItem.Click += new EventHandler(this.RenameClicked);
            this.refactorContextMenu.OrganizeMenuItem.Click += new EventHandler(this.OrganizeImportsClicked);
            this.refactorContextMenu.TruncateMenuItem.Click += new EventHandler(this.TruncateImportsClicked);
            editorMenu.Opening += new CancelEventHandler(this.EditorMenuOpening);
            mainMenu.MenuActivate += new EventHandler(this.MainMenuActivate);
            editorMenu.Items.Insert(3, this.refactorContextMenu);
            mainMenu.Items.Insert(4, this.refactorMainMenu);
            ToolStripMenuItem searchMenu = PluginBase.MainForm.FindMenuItem("SearchMenu") as ToolStripMenuItem;
            this.viewReferencesItem = new ToolStripMenuItem(TextHelper.GetString("Label.FindAllReferences"), null, new EventHandler(this.FindAllReferencesClicked));
            this.editorReferencesItem = new ToolStripMenuItem(TextHelper.GetString("Label.FindAllReferences"), null, new EventHandler(this.FindAllReferencesClicked));
            this.editorReferencesItem.ShortcutKeys = this.settingObject.OrganizeShortcut;
            this.viewReferencesItem.ShortcutKeys = this.settingObject.OrganizeShortcut;
            searchMenu.DropDownItems.Add(new ToolStripSeparator());
            searchMenu.DropDownItems.Add(this.viewReferencesItem);
            editorMenu.Items.Insert(6, this.editorReferencesItem);
            this.ApplyIgnoredKeys();
        }

        /// <summary>
        /// Updates the menu items
        /// </summary>
        private void MainMenuActivate(Object sender, EventArgs e)
        {
            this.UpdateMenuItems();
        }

        /// <summary>
        /// Updates the menu items
        /// </summary>
        private void EditorMenuOpening(Object sender, CancelEventArgs e)
        {
            this.UpdateMenuItems();
        }

        /// <summary>
        /// Gets if the current documents language is haxe
        /// </summary>
        private Boolean LanguageIsHaxe()
        {
            ITabbedDocument document = PluginBase.MainForm.CurrentDocument;
            if (document != null && document.IsEditable)
            {
                return document.FileName.ToLower().EndsWith(".hx");
            }
            else return false;
        }

        /// <summary>
        /// Gets if the language is valid for refactoring
        /// </summary>
        private Boolean GetLanguageIsValid()
        {
            ITabbedDocument document = PluginBase.MainForm.CurrentDocument;
            if (document != null && document.IsEditable)
            {
                String extension = document.FileName.ToLower();
                return (extension.EndsWith(".as") || extension.EndsWith(".hx"));
            }
            else return false;
        }

        /// <summary>
        /// Gets the result for menu updating from current position.
        /// </summary>
        private ASResult GetResultFromCurrentPosition()
        {
            ITabbedDocument document = PluginBase.MainForm.CurrentDocument;
            if (document == null || document.SciControl == null || !ASContext.Context.IsFileValid) return null;
            Int32 position = document.SciControl.WordEndPosition(document.SciControl.CurrentPos, true);
            ASResult result = ASComplete.GetExpressionType(document.SciControl, position);
            return result == null && result.IsNull() ? null : result;
        }

        /// <summary>
        /// Updates the state of the menu items
        /// </summary>
        private void UpdateMenuItems()
        {
            try
            {
                Boolean isValid = this.GetLanguageIsValid();
                ASResult result = isValid ? GetResultFromCurrentPosition() : null;
                if (result != null && result.Member != null)
                {
                    Boolean isClass = RefactoringHelper.CheckFlag(result.Member.Flags, FlagType.Class);
                    Boolean isVariable = RefactoringHelper.CheckFlag(result.Member.Flags, FlagType.Variable);
                    Boolean isConstructor = RefactoringHelper.CheckFlag(result.Member.Flags, FlagType.Constructor);
                    this.refactorContextMenu.RenameMenuItem.Enabled = !(isClass || isConstructor);
                    this.refactorMainMenu.RenameMenuItem.Enabled = !(isClass || isConstructor);
                    this.editorReferencesItem.Enabled = true;
                    this.viewReferencesItem.Enabled = true;
                }
                else
                {
                    this.refactorMainMenu.RenameMenuItem.Enabled = false;
                    this.refactorContextMenu.RenameMenuItem.Enabled = false;
                    this.editorReferencesItem.Enabled = false;
                    this.viewReferencesItem.Enabled = false;
                }
                IASContext context = ASContext.Context;
                if (context != null && context.CurrentModel != null)
                {
                    Boolean truncate = (this.GetLanguageIsValid() && context.CurrentModel.Imports.Count > 0);
                    Boolean organize = (this.GetLanguageIsValid() && context.CurrentModel.Imports.Count > 1);
                    this.refactorContextMenu.OrganizeMenuItem.Enabled = organize;
                    this.refactorContextMenu.TruncateMenuItem.Enabled = truncate && !this.LanguageIsHaxe();
                    this.refactorMainMenu.OrganizeMenuItem.Enabled = organize;
                    this.refactorMainMenu.TruncateMenuItem.Enabled = truncate && !this.LanguageIsHaxe();
                }
            }
            catch { }
        }

        /// <summary>
        /// Invoked when the user selects the "Rename" command
        /// </summary>
        private void RenameClicked(Object sender, EventArgs e)
        {
            try
            {
                Rename command = new Rename(true);
                command.Execute();
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Invoked when the user selects the "Find All References" command
        /// </summary>
        private void FindAllReferencesClicked(Object sender, EventArgs e)
        {
            try
            {
                FindAllReferences command = new FindAllReferences(true);
                command.Execute();
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Invoked when the user selects the "Organize Imports" command
        /// </summary>
        private void OrganizeImportsClicked(Object sender, EventArgs e)
        {
            try
            {
                OrganizeImports command = new OrganizeImports();
                command.SeparatePackages = this.settingObject.SeparatePackages;
                command.Execute();
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Invoked when the user selects the "Truncate Imports" command
        /// </summary>
        private void TruncateImportsClicked(Object sender, EventArgs e)
        {
            try
            {
                OrganizeImports command = new OrganizeImports();
                command.SeparatePackages = this.settingObject.SeparatePackages;
                command.TruncateImports = true;
                command.Execute();
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Applies the ignored keys to the mainform
        /// </summary>
        private void ApplyIgnoredKeys()
        {
            IMainForm mainForm = PluginBase.MainForm;
            if (this.settingObject.RenameShortcut != Keys.None)
            {
                mainForm.IgnoredKeys.Add(this.settingObject.RenameShortcut);
            }
            if (this.settingObject.FindRefsShortcut != Keys.None)
            {
                mainForm.IgnoredKeys.Add(this.settingObject.FindRefsShortcut);
            }
            if (this.settingObject.OrganizeShortcut != Keys.None)
            {
                mainForm.IgnoredKeys.Add(this.settingObject.OrganizeShortcut);
            }
            if (this.settingObject.TruncateShortcut != Keys.None)
            {
                mainForm.IgnoredKeys.Add(this.settingObject.TruncateShortcut);
            }
        }

        /// <summary>
        /// Loads the plugin settings
        /// </summary>
        public void LoadSettings()
        {
            this.settingObject = new Settings();
            if (!File.Exists(this.settingFilename)) this.SaveSettings();
            else
            {
                Object obj = ObjectSerializer.Deserialize(this.settingFilename, this.settingObject);
                this.settingObject = (Settings)obj;
            }
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            ObjectSerializer.Serialize(this.settingFilename, this.settingObject);
        }

		#endregion

    }
	
}
