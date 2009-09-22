using System;
using System.Windows.Forms;
using CodeRefactor.Commands;
using System.ComponentModel;
using PluginCore.Localization;
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
        private Settings settingObject;

        #region Refactor Plugin Context Menu Items

        private ToolStripMenuItem m_RefactorMenu;
        private ToolStripItem m_RefactorRenameItem;

        #endregion

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
            this.AddEventHandlers();
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
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            // Set events you want to listen (combine as flags)
            PluginBase.MainForm.EditorMenu.Opening += new CancelEventHandler(EditorMenu_Opening);
        }

        /// <summary>
        /// Creates our "Refactor" menu.
        /// TODO: Considered having this check if the currently selected item COULD be refactored, but I don't know if there's too high
        /// a performance impact to check, especially when the user does not even intend to refactor.  Is it possible to check once 
        /// they open the "Refactor" sub-menu?
        /// </summary>
        private void EditorMenu_Opening(object sender, CancelEventArgs e)
        {
            ContextMenuStrip contextMenu = (ContextMenuStrip)sender;
            if (m_RefactorMenu == null)
            {
                m_RefactorMenu = new ToolStripMenuItem(TextHelper.GetString("Label.Refactor"));
                m_RefactorRenameItem = m_RefactorMenu.DropDownItems.Add(TextHelper.GetString("Label.Rename"), null, new EventHandler(this.RenameClicked));
                m_RefactorRenameItem = m_RefactorMenu.DropDownItems.Add(TextHelper.GetString("Label.FindAllReferences"), null, new EventHandler(this.FindAllreferencesClicked));
                m_RefactorRenameItem = m_RefactorMenu.DropDownItems.Add(TextHelper.GetString("Label.EncapsulateField"), null, new EventHandler(this.EncapsulateFieldClicked));
                contextMenu.Items.Insert(3, m_RefactorMenu);
            }
        }

        /// <summary>
        /// Invoked when the user selects the "Rename" command
        /// </summary>
        private void RenameClicked(object sender, EventArgs e)
        {
            try
            {
                Rename command = new Rename(true);
                command.Execute();
            }
            catch (CodeRefactor.Exceptions.RefactorException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// Invoked when the user selects the "Find All References" command
        /// </summary>
        private void FindAllreferencesClicked(object sender, EventArgs e)
        {
            FindAllReferences command = new FindAllReferences(true);
            command.Execute();
        }

        /// <summary>
        /// Invoked when the user selects the "Encapsulate Field" command
        /// </summary>
        private void EncapsulateFieldClicked(object sender, EventArgs e)
        {
            try
            {
                EncapsulateField command = new EncapsulateField(true);
                command.Execute();
            }
            catch (CodeRefactor.Exceptions.RefactorException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

		#endregion

    }
	
}
