using System;
using System.Text;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using PluginCore.Localization;

namespace MacroManager
{
    [Serializable]
    public class Settings
    {
        private Keys editShortcut = Keys.Control|Keys.F10;
        private List<Macro> userMacros = new List<Macro>();
        private String[] initialMacro = new String[0];

        /// <summary> 
        /// Get and sets the editShortcut
        /// </summary>
        [DisplayName("Edit Shortcut")]
        [DefaultValue(Keys.Control|Keys.F10)]
        [LocalizedDescription("MacroManager.Description.EditShortcut")]
        public Keys EditShortcut
        {
            get { return this.editShortcut; }
            set { this.editShortcut = value; }
        }

        /// <summary> 
        /// Get and sets the initialMacro
        /// </summary>
        [DisplayName("Initial Macro")]
        [LocalizedDescription("MacroManager.Description.InitialMacro")]
        public String[] InitialMacro
        {
            get { return this.initialMacro; }
            set { this.initialMacro = value; }
        }

        /// <summary> 
        /// Get and sets the userMacros
        /// </summary>
        [DisplayName("User Macros")]
        [LocalizedDescription("MacroManager.Description.UserMacros")]
        public List<Macro> UserMacros
        {
            get { return this.userMacros; }
            set { this.userMacros = value; }
        }

    }

}
