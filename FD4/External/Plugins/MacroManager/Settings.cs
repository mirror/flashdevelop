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
        private List<Macro> userMacros = new List<Macro>();

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
