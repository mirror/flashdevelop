using System;
using System.IO;
using System.Collections.Generic;
using System.ComponentModel;
using System.Windows.Forms;
using ASCompletion.Completion;
using ASCompletion.Context;
using ASCompletion.Model;
using CodeRefactor.Commands;
using CodeRefactor.Controls;
using CodeRefactor.CustomControls;
using CodeRefactor.Provider;
using PluginCore.Helpers;
using PluginCore.Localization;
using PluginCore.Managers;
using PluginCore.Utilities;
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
        private SurroundMenu surroundContextMenu;
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
                case EventType.ApplySettings:
                    this.refactorContextMenu.ApplyShortcutKeys();
                    this.refactorMainMenu.ApplyShortcutKeys();
                    this.ApplyIgnoredKeys();
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
            EventManager.AddEventHandler(this, EventType.ApplySettings | EventType.UIRefresh | EventType.FileSwitch);
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
            this.refactorMainMenu.ExtractMethodMenuItem.Click += new EventHandler(this.ExtractMethodClicked);
            this.refactorMainMenu.DelegateMenuItem.Click += new EventHandler(this.DelegateMethodsClicked);
            this.refactorMainMenu.ExtractLocalVariableMenuItem.Click += new EventHandler(this.ExtractLocalVariableClicked);
            this.refactorContextMenu = new RefactorMenu(this.settingObject);
            this.refactorContextMenu.RenameMenuItem.Click += new EventHandler(this.RenameClicked);
            this.refactorContextMenu.OrganizeMenuItem.Click += new EventHandler(this.OrganizeImportsClicked);
            this.refactorContextMenu.TruncateMenuItem.Click += new EventHandler(this.TruncateImportsClicked);
            this.refactorContextMenu.DelegateMenuItem.Click += new EventHandler(this.DelegateMethodsClicked);
            this.refactorContextMenu.ExtractMethodMenuItem.Click += new EventHandler(this.ExtractMethodClicked);
            this.refactorContextMenu.ExtractLocalVariableMenuItem.Click += new EventHandler(this.ExtractLocalVariableClicked);
            this.surroundContextMenu = new SurroundMenu();
            editorMenu.Opening += new CancelEventHandler(this.EditorMenuOpening);
            mainMenu.MenuActivate += new EventHandler(this.MainMenuActivate);
            editorMenu.Items.Insert(3, this.refactorContextMenu);
            editorMenu.Items.Insert(4, this.surroundContextMenu);
            mainMenu.Items.Insert(5, this.refactorMainMenu);
            ToolStripMenuItem searchMenu = PluginBase.MainForm.FindMenuItem("SearchMenu") as ToolStripMenuItem;
            this.viewReferencesItem = new ToolStripMenuItem(TextHelper.GetString("Label.FindAllReferences"), null, new EventHandler(this.FindAllReferencesClicked));
            this.editorReferencesItem = new ToolStripMenuItem(TextHelper.GetString("Label.FindAllReferences"), null, new EventHandler(this.FindAllReferencesClicked));
            this.editorReferencesItem.ShortcutKeys = this.settingObject.FindRefsShortcut;
            this.viewReferencesItem.ShortcutKeys = this.settingObject.FindRefsShortcut;
            searchMenu.DropDownItems.Add(new ToolStripSeparator());
            searchMenu.DropDownItems.Add(this.viewReferencesItem);
            editorMenu.Items.Insert(7, this.editorReferencesItem);
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
                this.refactorContextMenu.DelegateMenuItem.Enabled = false;
                this.refactorMainMenu.DelegateMenuItem.Enabled = false;

                Boolean isValid = this.GetLanguageIsValid();
                ASResult result = isValid ? GetResultFromCurrentPosition() : null;
                if (result != null && result.Member != null)
                {
                    Boolean isVoid = result.Type.IsVoid();
                    Boolean isClass = RefactoringHelper.CheckFlag(result.Member.Flags, FlagType.Class);
                    Boolean isVariable = RefactoringHelper.CheckFlag(result.Member.Flags, FlagType.Variable);
                    Boolean isConstructor = RefactoringHelper.CheckFlag(result.Member.Flags, FlagType.Constructor);
                    this.refactorContextMenu.RenameMenuItem.Enabled = !(isClass || isConstructor || isVoid);
                    this.refactorMainMenu.RenameMenuItem.Enabled = !(isClass || isConstructor || isVoid);
                    this.editorReferencesItem.Enabled = true;
                    this.viewReferencesItem.Enabled = true;

                    if (result.Type != null && result.inClass != null && result.inFile != null)
                    {
                        FlagType flags = result.Member.Flags;
                        if ((flags & FlagType.Variable) > 0
                            && (flags & FlagType.LocalVar) == 0
                            && (flags & FlagType.ParameterVar) == 0)
                        {
                            this.refactorContextMenu.DelegateMenuItem.Enabled = true;
                            this.refactorMainMenu.DelegateMenuItem.Enabled = true;
                        }
                    }
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
                this.surroundContextMenu.Enabled = false;
                this.refactorContextMenu.ExtractMethodMenuItem.Enabled = false;
                this.refactorContextMenu.ExtractLocalVariableMenuItem.Enabled = false;
                this.refactorMainMenu.ExtractMethodMenuItem.Enabled = false;
                this.refactorMainMenu.ExtractLocalVariableMenuItem.Enabled = false;
                ITabbedDocument document = PluginBase.MainForm.CurrentDocument;
                if (document != null && document.SciControl != null && ASContext.Context.IsFileValid)
                {
                    if (document.SciControl.SelTextSize > 1)
                    {
                        string selText = document.SciControl.SelText;
                        this.surroundContextMenu.Enabled = true;
                        this.refactorContextMenu.ExtractMethodMenuItem.Enabled = true;
                        this.refactorMainMenu.ExtractMethodMenuItem.Enabled = true;
                        this.refactorContextMenu.ExtractLocalVariableMenuItem.Enabled = true;
                        this.refactorMainMenu.ExtractLocalVariableMenuItem.Enabled = true;
                        foreach (ToolStripMenuItem item in this.surroundContextMenu.DropDownItems)
                        {
                            item.Click -= this.SurroundWithClicked;
                        }
                        this.surroundContextMenu.GenerateSnippets(document.SciControl);
                        foreach (ToolStripMenuItem item in this.surroundContextMenu.DropDownItems)
                        {
                            item.Click += this.SurroundWithClicked;
                        }
                    }
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
        /// Invoked when the user selects the "Surround with Try/catch block" command
        /// </summary>
        private void SurroundWithClicked(Object sender, EventArgs e)
        {
            try
            {
                SurroundWithCommand command = new SurroundWithCommand((sender as ToolStripItem).Text);
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
        /// Invoked when the user selects the "Truncate Imports" command
        /// </summary>
        private void DelegateMethodsClicked(Object sender, EventArgs e)
        {
            try
            {
                ASResult result = GetResultFromCurrentPosition();
                Dictionary<MemberModel, ClassModel> members = new Dictionary<MemberModel, ClassModel>();
                List<string> memberNames = new List<string>();
                ClassModel cm = result.Type;
                cm.ResolveExtends();
                string decl;
                while (cm != null && !cm.IsVoid())
                {
                    foreach (MemberModel m in cm.Members)
                    {
                        if ((m.Flags & FlagType.Function) > 0
                            && (m.Access & Visibility.Public) > 0
                            && (m.Flags & FlagType.Constructor) == 0
                            && (m.Flags & FlagType.Static) == 0)
                        {
                            decl = m.ToDeclarationString();
                            if (!memberNames.Contains(decl))
                            {
                                memberNames.Add(decl);
                                members[m] = cm;
                            }
                        }
                    }
                    cm = cm.Extends;
                }
                DelegateMethodsDialog dd = new DelegateMethodsDialog();
                dd.FillData(members, result.Type);
                System.Windows.Forms.DialogResult choice = dd.ShowDialog();
                if (choice == System.Windows.Forms.DialogResult.OK && dd.checkedMembers.Count > 0)
                {
                    DelegateMethodsCommand command = new DelegateMethodsCommand(result, dd.checkedMembers);
                    command.Execute();
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Invoked when the user selects the "Extract Method" command
        /// </summary>
        private void ExtractMethodClicked(Object sender, EventArgs e)
        {
            try
            {
                String label = TextHelper.GetString("Label.NewName");
                String title = TextHelper.GetString("Title.ExtractMethodDialog");
                String suggestion = "newMethod";
                ProjectManager.Helpers.LineEntryDialog askName = new ProjectManager.Helpers.LineEntryDialog(title, label, suggestion);
                System.Windows.Forms.DialogResult choice = askName.ShowDialog();
                if (choice == System.Windows.Forms.DialogResult.OK && askName.Line.Trim().Length > 0 && askName.Line.Trim() != suggestion)
                {
                    suggestion = askName.Line.Trim();
                }
                if (choice == System.Windows.Forms.DialogResult.OK)
                {
                    ExtractMethodCommand command = new ExtractMethodCommand(suggestion);
                    command.Execute();
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Invoked when the user selects the "Extract Local Variable" command
        /// </summary>
        private void ExtractLocalVariableClicked(Object sender, EventArgs e)
        {
            try
            {
                String suggestion = "newVar";
                String label = TextHelper.GetString("Label.NewName");
                String title = TextHelper.GetString("Title.ExtractLocalVariableDialog");
                ProjectManager.Helpers.LineEntryDialog askName = new ProjectManager.Helpers.LineEntryDialog(title, label, suggestion);
                System.Windows.Forms.DialogResult choice = askName.ShowDialog();
                if (choice == System.Windows.Forms.DialogResult.OK && askName.Line.Trim().Length > 0 && askName.Line.Trim() != suggestion)
                {
                    suggestion = askName.Line.Trim();
                }
                if (choice == System.Windows.Forms.DialogResult.OK)
                {
                    ExtractLocalVariableCommand command = new ExtractLocalVariableCommand(suggestion);
                    command.Execute();
                }
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
            if (this.settingObject.ExtractLocalVariableShortcut != Keys.None)
            {
                mainForm.IgnoredKeys.Add(this.settingObject.ExtractLocalVariableShortcut);
            }
            if (this.settingObject.ExtractMethodShortcut != Keys.None)
            {
                mainForm.IgnoredKeys.Add(this.settingObject.ExtractMethodShortcut);
            }
            if (this.settingObject.GenerateDelegateMethodsShortcut != Keys.None)
            {
                mainForm.IgnoredKeys.Add(this.settingObject.GenerateDelegateMethodsShortcut);
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
