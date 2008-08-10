using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using PluginCore.Localization;
using System.Windows.Forms;

namespace ResultsPanel
{
    [Serializable]
    public class PanelSettings
    {
        public const Keys DEFAULT_NEXTERROR = Keys.F12;
        public const Keys DEFAULT_PREVIOUSERROR = Keys.Shift | Keys.F12;

        private Keys nextError = DEFAULT_NEXTERROR;
        private Keys previousError = DEFAULT_PREVIOUSERROR;

        [DisplayName("Next Error")]
        [Category("Shortcuts"), LocalizedDescription("ResultsPanel.Description.NextError"), DefaultValue(DEFAULT_NEXTERROR)]
        public Keys NextError
        {
            get { return nextError; }
            set { nextError = value; }
        }

        [DisplayName("Previous Error")]
        [Category("Shortcuts"), LocalizedDescription("ResultsPanel.Description.PreviousError"), DefaultValue(DEFAULT_PREVIOUSERROR)]
        public Keys PreviousError
        {
            get { return previousError; }
            set { previousError = value; }
        }
    }
}
