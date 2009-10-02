using System;
using System.Windows.Forms;
using System.ComponentModel;
using CodeRefactor.Commands;
using PluginCore.Localization;
using ASCompletion.Completion;
using CodeRefactor.Provider;
using ASCompletion.Context;
using PluginCore.Managers;
using ASCompletion.Model;
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
        private ToolStripMenuItem refactorContextMenu;
        private ToolStripMenuItem editRefactorContextMenu;
        private ToolStripItem editEncapsulateMenuItem;
        private ToolStripItem editReferencesMenuItem;
        private ToolStripItem editOrganizeMenuItem;
        private ToolStripItem editRenameMenuItem;
        private ToolStripItem encapsulateMenuItem;
        private ToolStripItem referencesMenuItem;
        private ToolStripItem organizeMenuItem;
        private ToolStripItem renameMenuItem;

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
            get { return null; }
        }
		
		#endregion

		#region Required Methods
		
		/// <summary>
		/// Initializes the plugin
		/// </summary>
		public void Initialize()
		{
            this.CreateMenuItems();
            this.pluginDesc = TextHelper.GetString("Info.Description");
        }
		
		/// <summary>
		/// Disposes the plugin
		/// </summary>
		public void Dispose()
		{
            // Nothing to do
		}
		
		/// <summary>
		/// Handles the incoming events
		/// </summary>
		public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
		{            
            // No events handled
		}

        #endregion
   
        #region Event Handling

        /// <summary>
        /// Creates the required menu items
        /// </summary>
        private void CreateMenuItems()
        {
            ContextMenuStrip editorMenu = PluginBase.MainForm.EditorMenu;
            this.refactorContextMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Refactor"));
            this.refactorContextMenu.DropDownOpening += new EventHandler(this.RefactorContextMenuDropDownOpening);
            this.renameMenuItem = this.refactorContextMenu.DropDownItems.Add(TextHelper.GetString("Label.Rename"), null, new EventHandler(this.RenameClicked));
            this.organizeMenuItem = this.refactorContextMenu.DropDownItems.Add(TextHelper.GetString("Label.OrganizeImports"), null, new EventHandler(this.OrganizeImportsClicked));
            this.referencesMenuItem = this.refactorContextMenu.DropDownItems.Add(TextHelper.GetString("Label.FindAllReferences"), null, new EventHandler(this.FindAllReferencesClicked));
            this.encapsulateMenuItem = this.refactorContextMenu.DropDownItems.Add(TextHelper.GetString("Label.EncapsulateField"), null, new EventHandler(this.EncapsulateFieldClicked));
            editorMenu.Items.Insert(3, this.refactorContextMenu);
            ToolStripMenuItem editMenu = (ToolStripMenuItem)PluginBase.MainForm.FindMenuItem("EditMenu");
            if (editMenu != null)
            {
                editMenu.DropDownItems.Add(new ToolStripSeparator());
                this.editRefactorContextMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Refactor"));
                this.editRefactorContextMenu.DropDownOpening += new EventHandler(this.RefactorContextMenuDropDownOpening);
                this.editRenameMenuItem = this.editRefactorContextMenu.DropDownItems.Add(TextHelper.GetString("Label.Rename"), null, new EventHandler(this.RenameClicked));
                this.editOrganizeMenuItem = this.editRefactorContextMenu.DropDownItems.Add(TextHelper.GetString("Label.OrganizeImports"), null, new EventHandler(this.OrganizeImportsClicked));
                this.editReferencesMenuItem = this.editRefactorContextMenu.DropDownItems.Add(TextHelper.GetString("Label.FindAllReferences"), null, new EventHandler(this.FindAllReferencesClicked));
                this.editEncapsulateMenuItem = this.editRefactorContextMenu.DropDownItems.Add(TextHelper.GetString("Label.EncapsulateField"), null, new EventHandler(this.EncapsulateFieldClicked));
                editMenu.DropDownItems.Add(this.editRefactorContextMenu);
            }

        }

        /// <summary>
        /// Updates the state of the menu items when menu is opening
        /// </summary>
        private void RefactorContextMenuDropDownOpening(Object sender, EventArgs e)
        {
            ASResult result = GetResultFromCurrentPosition();
            if (result != null && result.Member != null)
            {
                Boolean isClass = RefactoringHelper.CheckFlag(result.Member.Flags, FlagType.Class);
                Boolean isVariable = RefactoringHelper.CheckFlag(result.Member.Flags, FlagType.Variable);
                Boolean isConstructor = RefactoringHelper.CheckFlag(result.Member.Flags, FlagType.Constructor);
                this.editRenameMenuItem.Enabled = !(isClass || isConstructor);
                this.renameMenuItem.Enabled = !(isClass || isConstructor);
                this.editEncapsulateMenuItem.Enabled = isVariable;
                this.encapsulateMenuItem.Enabled = isVariable;
                this.editReferencesMenuItem.Enabled = true;
                this.referencesMenuItem.Enabled = true;
            }
            else
            {
                this.renameMenuItem.Enabled = false;
                this.editRenameMenuItem.Enabled = false;
                this.encapsulateMenuItem.Enabled = false;
                this.editEncapsulateMenuItem.Enabled = false;
                this.referencesMenuItem.Enabled = false;
                this.editReferencesMenuItem.Enabled = false;
            }
            IASContext context = ASContext.Context;
            if (context != null && context.CurrentModel != null)
            {
                this.organizeMenuItem.Enabled = context.CurrentModel.Imports.Count > 0;
                this.editOrganizeMenuItem.Enabled = context.CurrentModel.Imports.Count > 0;
            }
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
            if (result == null && result.IsNull()) return null;
            else return result;
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
        /// Invoked when the user selects the "Encapsulate Field" command
        /// </summary>
        private void EncapsulateFieldClicked(Object sender, EventArgs e)
        {
            try
            {
                EncapsulateField command = new EncapsulateField();
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
                command.Execute();
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

		#endregion

    }
	
}
