using System;
using System.IO;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore;

namespace MacroManager
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "MacroManager";
        private String pluginGuid = "071817e0-0ee6-11de-8c30-0800200c9a66";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "Adds simple macro capacilities to FlashDevelop.";
        private String pluginAuth = "FlashDevelop Team";
        private ToolStripMenuItem macroMenuItem;
        private ToolStripMenuItem editMenuItem;
        private String settingFilename;
        private Settings settingObject;

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
            this.CreateMainMenuItems();
            this.RefreshMacroMenuItems();
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
            if (e.Type == EventType.UIStarted)
            {
                try
                {
                    String[] entries = this.settingObject.InitialMacro;
                    foreach (String entry in entries)
                    {
                        String[] parts = entry.Split(new Char[1]{'|'});
                        PluginBase.MainForm.CallCommand(parts[0], parts[1]);
                    }
                }
                catch {}
            }
            if (e.Type == EventType.ApplySettings)
            {
                this.UpdateMenuShortcut();
            }
		}
		
		#endregion

        #region Custom Methods
        
        /// <summary>
        /// List that contains the macros
        /// </summary>
        public List<Macro> Macros
        {
            get { return this.settingObject.UserMacros; }
            set { this.settingObject.UserMacros = value; }
        }

        /// <summary>
        /// Initializes important variables
        /// </summary>
        private void InitBasics()
        {
            this.pluginDesc = TextHelper.GetString("Info.Description");
            String dataPath = Path.Combine(PathHelper.DataDir, "MacroManager");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            EventManager.AddEventHandler(this, EventType.ApplySettings);
            EventManager.AddEventHandler(this, EventType.UIStarted);
        }

        /// <summary>
        /// Creates the nesessary main menu item
        /// </summary>
        private void CreateMainMenuItems()
        {
            MenuStrip mainMenu = PluginBase.MainForm.MenuStrip;
            this.macroMenuItem = new ToolStripMenuItem();
            this.macroMenuItem.Text = TextHelper.GetString("Label.Macros");
            this.editMenuItem = new ToolStripMenuItem();
            this.editMenuItem.Text = TextHelper.GetString("Label.EditMacros");
            this.editMenuItem.Click += new EventHandler(this.EditMenuItemClick);
            Int32 index = mainMenu.Items.Count - 2;
            mainMenu.Items.Insert(index, this.macroMenuItem);
        }

        /// <summary>
        /// Refreshes the macro related menu items
        /// </summary>
        public void RefreshMacroMenuItems()
        {
            this.macroMenuItem.DropDownItems.Clear();
            foreach (Macro macro in this.settingObject.UserMacros)
            {
                ToolStripMenuItem macroItem = new ToolStripMenuItem();
                macroItem.Click += new EventHandler(this.MacroMenuItemClick);
                macroItem.ShortcutKeys = macro.Shortcut;
                macroItem.Text = macro.Label; 
                macroItem.Tag = macro;
                this.macroMenuItem.DropDownItems.Add(macroItem);
                if (!PluginBase.MainForm.IgnoredKeys.Contains(macro.Shortcut))
                {
                    PluginBase.MainForm.IgnoredKeys.Add(macro.Shortcut);
                }
            }
            this.macroMenuItem.DropDownItems.Add(new ToolStripSeparator());
            this.macroMenuItem.DropDownItems.Add(this.editMenuItem);
            this.UpdateMenuShortcut();
        }

        /// <summary>
        /// Loads the plugin settings
        /// </summary>
        private void LoadSettings()
        {
            this.settingObject = new Settings();
            if (!File.Exists(this.settingFilename)) this.SaveSettings();
            else
            {
                Object obj = ObjectSerializer.Deserialize(this.settingFilename, this.settingObject);
                this.settingObject = (Settings)obj;
            }
            if (this.settingObject.InitialMacro == null)
            {
                this.settingObject.InitialMacro = new String[0];
            }
            if (this.settingObject.UserMacros.Count == 0)
            {
                Macro macro = new Macro("Hello World!", new String[1]{"Debug|HelloWorld!"}, Keys.None);
                this.settingObject.UserMacros.Add(macro);
            }
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        private void SaveSettings()
        {
            ObjectSerializer.Serialize(this.settingFilename, this.settingObject);
        }

        /// <summary>
        /// Updates the edit macros menu item shortcut
        /// </summary>
        private void UpdateMenuShortcut()
        {
            Keys shortcut = this.settingObject.EditShortcut;
            if (!PluginBase.MainForm.IgnoredKeys.Contains(shortcut))
            {
                PluginBase.MainForm.IgnoredKeys.Add(shortcut);
            }
            this.editMenuItem.ShortcutKeys = shortcut;
        }

        /// <summary>
        /// Executes the clicked macro
        /// </summary>
        private void MacroMenuItemClick(Object sender, EventArgs e)
        {
            try
            {
                ToolStripMenuItem macroItem = sender as ToolStripMenuItem;
                foreach (String entry in ((Macro)macroItem.Tag).Entries)
                {
                    String[] parts = entry.Split(new Char[1]{'|'});
                    PluginBase.MainForm.CallCommand(parts[0], parts[1]);
                }
            }
            catch (Exception)
            {
                String message = TextHelper.GetString("Info.CouldNotRunMacro");
                ErrorManager.ShowWarning(message, null);
            }
        }

        /// <summary>
        /// Opens the macro manager dialog
        /// </summary>
        private void EditMenuItemClick(Object sender, EventArgs e)
        {
            ManagerDialog.Show(this);
        }

		#endregion
    }
        
    #region Custom Types

    [Serializable]
    public class Macro
    {
        private String label = String.Empty;
        private String[] entries = new String[0];
        private Keys shortcut = Keys.None;

        public Macro() {}
        public Macro(String label, String[] entries, Keys shortcut) 
        {
            this.Label = label;
            this.entries = entries;
            this.shortcut = shortcut;
        }

        /// <summary>
        /// Gets and sets the label
        /// </summary> 
        public String Label
        {
            get { return this.label; }
            set { this.label = value; }
        }

        /// <summary>
        /// Gets and sets the entries
        /// </summary> 
        public String[] Entries
        {
            get { return this.entries; }
            set { this.entries = value; }
        }

        /// <summary>
        /// Gets and sets the shortcut
        /// </summary> 
        public Keys Shortcut
        {
            get { return this.shortcut; }
            set { this.shortcut = value; }
        }

    }

    #endregion
	
}
