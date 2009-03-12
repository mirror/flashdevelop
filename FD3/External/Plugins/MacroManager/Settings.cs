using System;
using System.ComponentModel;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Text;

namespace MacroManager
{
    [Serializable]
    public class Settings
    {
        private List<Macro> userMacros = new List<Macro>();
        
        /// <summary> 
        /// Get and sets the userMacros
        /// </summary>
        [Description("List of available macros.")]
        public List<Macro> UserMacros
        {
            get { return this.userMacros; }
            set { this.userMacros = value; }
        }

    }

}
