using System;
using System.ComponentModel;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Text;
using PluginCore.Localization;

namespace CssCompletion
{
    [Serializable]
    public class Settings
    {
        private Boolean disableAutoCompletion = false;
        private Boolean disableCompileOnSave = false;
        private Boolean disableMinifyOnSave = false;
        private Boolean enableVerboseCompilation = false;

        [DisplayName("Disable Auto Completion"), DefaultValue(false)]
        [LocalizedDescription("CssCompletion.Description.DisableAutoCompletion")]
        public Boolean DisableAutoCompletion
        {
            get { return this.disableAutoCompletion; }
            set { this.disableAutoCompletion = value; }
        }

        [DisplayName("Disable Compile To CSS On Save"), DefaultValue(false)]
        [LocalizedDescription("CssCompletion.Description.DisableCompileOnSave")]
        public Boolean DisableCompileOnSave
        {
            get { return this.disableCompileOnSave; }
            set { this.disableCompileOnSave = value; }
        }

        [DisplayName("Disable Minify CSS On Save"), DefaultValue(false)]
        [LocalizedDescription("CssCompletion.Description.DisableMinifyOnSave")]
        public Boolean DisableMinifyOnSave
        {
            get { return this.disableMinifyOnSave; }
            set { this.disableMinifyOnSave = value; }
        }

        [DisplayName("Enable Verbose Compilation"), DefaultValue(false)]
        [LocalizedDescription("CssCompletion.Description.EnableVerboseCompilation")]
        public Boolean EnableVerboseCompilation
        {
            get { return this.enableVerboseCompilation; }
            set { this.enableVerboseCompilation = value; }
        }
    }

}

