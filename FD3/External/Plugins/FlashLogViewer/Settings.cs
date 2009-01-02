using System;
using System.Text;
using System.Windows.Forms;
using System.ComponentModel;
using System.Drawing.Design;
using System.Collections.Generic;
using System.Windows.Forms.Design;
using PluginCore.Localization;
using PluginCore.Managers;
using PluginCore;

namespace FlashLogViewer
{
    [Serializable]
    public class Settings
    {
        private String flashLogFile = "";
        private String policyLogFile = "";
        private Boolean colourWarnings = true;
        private Boolean keepPopupTopMost = true;
        private StartType trackingStartType = StartType.Manually;

        /// <summary> 
        /// Get or sets the flashLogFile.
        /// </summary>
        [DisplayName("Flash Log File")]
        [LocalizedCategory("FlashLogViewer.Category.Files")]
        [LocalizedDescription("FlashLogViewer.Description.FlashLogFile")]
        [Editor(typeof(FileNameEditor), typeof(UITypeEditor))]
        public String FlashLogFile 
        {
            get { return this.flashLogFile; }
            set { this.flashLogFile = value; }
        }

        /// <summary> 
        /// Get or sets the policyLogFile.
        /// </summary>
        [DisplayName("Policy Log File")]
        [LocalizedCategory("FlashLogViewer.Category.Files")]
        [LocalizedDescription("FlashLogViewer.Description.PolicyLogFile")]
        [Editor(typeof(FileNameEditor), typeof(UITypeEditor))]
        public String PolicyLogFile
        {
            get { return this.policyLogFile; }
            set { this.policyLogFile = value; }
        }

        /// <summary> 
        /// Get or sets the colourWarnings.
        /// </summary>
        [DefaultValue(true)]
        [DisplayName("Colour Warnings")]
        [LocalizedDescription("FlashLogViewer.Description.ColourWarnings")]
        public Boolean ColourWarnings
        {
            get { return this.colourWarnings; }
            set { this.colourWarnings = value; }
        }

        /// <summary> 
        /// Get or sets the keepPopupTopMost.
        /// </summary>
        [DefaultValue(true)]
        [DisplayName("Keep Popup Top Most")]
        [LocalizedDescription("FlashLogViewer.Description.KeepPopupTopMost")]
        public Boolean KeepPopupTopMost
        {
            get { return this.keepPopupTopMost; }
            set { this.keepPopupTopMost = value; }
        }

        /// <summary> 
        /// Get or sets the trackingStartType.
        /// </summary>
        [DisplayName("Start Tracking")]
        [DefaultValue(StartType.Manually)]
        [LocalizedDescription("FlashLogViewer.Description.TrackingStartType")]
        public StartType TrackingStartType
        {
            get { return this.trackingStartType; }
            set { this.trackingStartType = value; }
        }

     }

    public enum StartType
    {
        OnProgramStart,
        OnBuildComplete,
        Manually
    }

}
