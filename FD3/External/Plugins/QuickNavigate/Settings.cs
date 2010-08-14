using System;
using System.Drawing;
using System.ComponentModel;
using System.Windows.Forms;
using PluginCore.Localization;

namespace QuickNavigate
{
    [Serializable]
    public class Settings
    {
        private const Keys DEFAULT_RESOURCE_SHORTCUT = Keys.Control | Keys.R;
        private const Boolean DEFAULT_CTRL_CLICK_ENABLED = true;
        private const Boolean DEFAULT_SEARCH_EXTERNAL_CLASSPATH = true;
        
        private Keys openResourceShortcut = DEFAULT_RESOURCE_SHORTCUT;
        private Boolean ctrlClickEnabled = DEFAULT_CTRL_CLICK_ENABLED;
        private Boolean searchExternalClassPath = DEFAULT_SEARCH_EXTERNAL_CLASSPATH;
        private Size resourceFormSize;
        private Size typeFormSize;
        private Size outlineFormSize;

        [Browsable(false)]
        public Size ResourceFormSize
        {
            get { return resourceFormSize; }
            set { resourceFormSize = value; }
        }

        [DisplayName("Open Resource")]
        [LocalizedCategory("QuickNavigate.Category.Shortcuts")]
        [LocalizedDescription("QuickNavigate.Description.OpenResourceShortcut")]
        [DefaultValue(DEFAULT_RESOURCE_SHORTCUT)]
        public Keys OpenResourceShortcut
        {
            get { return openResourceShortcut; }
            set { openResourceShortcut = value; }
        }

        [DisplayName("Enable Navigation By Ctrl+Click")]
        [LocalizedDescription("QuickNavigate.Description.CtrlClickEnabled")]
        [DefaultValue(DEFAULT_SEARCH_EXTERNAL_CLASSPATH)]
        public Boolean CtrlClickEnabled
        {
            get { return ctrlClickEnabled; }
            set { ctrlClickEnabled = value; }
        }
        
        [DisplayName("Search In External Classpath")]
        [LocalizedDescription("QuickNavigate.Description.SearchExternalClassPath")]
        [DefaultValue(DEFAULT_CTRL_CLICK_ENABLED)]
        public Boolean SearchExternalClassPath
        {
            get { return searchExternalClassPath; }
            set { searchExternalClassPath = value; }
        }

    }

}