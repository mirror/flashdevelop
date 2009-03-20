using System;
using System.Text;
using System.ComponentModel;
using System.Drawing.Design;
using System.Collections.Generic;
using System.Windows.Forms.Design;
using PluginCore.Localization;

namespace FlashViewer
{
    [Serializable]
    public class Settings
    {
        private static Settings instance;
        private String playerPath = String.Empty;
        private ViewStyle displayStyle = ViewStyle.External;

        public Settings()
        {
            instance = this;
        }

        /// <summary>
        /// Gets the singleton instance of the class
        /// </summary> 
        public static Settings GetInstance()
        {
            return instance;
        }

        /// <summary> 
        /// Get and sets the playerPath
        /// </summary>
        [DisplayName("External Player Path")]
        [LocalizedDescription("FlashViewer.Description.PlayerPath"), DefaultValue("")]
        [Editor(typeof(FileNameEditor), typeof(UITypeEditor))]
        public String PlayerPath
        {
            get { return this.playerPath; }
            set { this.playerPath = value; }
        }

        /// <summary> 
        /// Get and sets the displayStyle
        /// </summary>
        [DisplayName("Movie Display Style")]
        [LocalizedDescription("FlashViewer.Description.DisplayStyle"), DefaultValue(ViewStyle.External)]
        public ViewStyle DisplayStyle 
        {
            get { return this.displayStyle; }
            set { this.displayStyle = value; }
        }

    }

    /// <summary>
    /// Style how the flash movies are viewed
    /// </summary>
    public enum ViewStyle
    {
        Popup,
        External,
        Document
    }

}
