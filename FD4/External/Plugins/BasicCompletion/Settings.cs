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
        private Boolean enableAutoCompletion = false;
        private List<String> enabledLanguages = new List<String> { "css", "jscript", "csharp", "python", "text" };
        
        /// <summary> 
        /// Get and sets the EnabledLanguages
        /// </summary>
        [DisplayName("Enabled Languages")]
        [LocalizedDescription("BasicCompletion.Description.EnabledLanguages")]
        [Editor("System.Windows.Forms.Design.StringCollectionEditor, System.Design, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "System.Drawing.Design.UITypeEditor,System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        public List<String> EnabledLanguages
        {
            get { return this.enabledLanguages; }
            set { this.enabledLanguages = value; }
        }

        /// <summary> 
        /// Get and sets the EnableAutoCompletion
        /// </summary>
        [DisplayName("Enable Auto Completion"), DefaultValue(false)]
        [LocalizedDescription("BasicCompletion.Description.EnableAutoCompletion")]
        public Boolean EnableAutoCompletion
        {
            get { return this.enableAutoCompletion; }
            set { this.enableAutoCompletion = value; }
        }

    }

}

