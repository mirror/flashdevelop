using System;
using System.ComponentModel;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Text;
using PluginCore.Localization;

namespace BasicCompletion
{
    [Serializable]
    public class Settings
    {
        private List<String> enabledLanguages = new List<String> { "css", "jscript", "csharp", "python" };
        
        /// <summary> 
        /// Get and sets the EnabledLanguages
        /// </summary>
        [DisplayName("Enabled Languages")]
        [LocalizedDescription("BasicCompletion.Description.EnabledLanguages")]
        public List<String> EnabledLanguages
        {
            get { return this.enabledLanguages; }
            set { this.enabledLanguages = value; }
        }

    }

}

