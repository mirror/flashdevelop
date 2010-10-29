using System;
using System.Text;
using System.ComponentModel;
using System.Collections.Generic;
using PluginCore.Localization;

namespace FlashConnect
{
    [Serializable]
    public class Settings
    {
        private Int32 port = 1978;
        private String host = "127.0.0.1";
        private Boolean enabled = true;

        /// <summary> 
        /// Get and sets the enabled
        /// </summary>
        [LocalizedDescription("FlashConnect.Description.Enabled"), DefaultValue(true)]
        public Boolean Enabled
        {
            get { return this.enabled; }
            set { this.enabled = value; }
        }

        /// <summary> 
        /// Get and sets the address
        /// </summary>
        [LocalizedDescription("FlashConnect.Description.Host"), DefaultValue("127.0.0.1")]
        public String Host
        {
            get { return this.host; }
            set { this.host = value; }
        }

        /// <summary> 
        /// Get and sets the port
        /// </summary>
        [LocalizedDescription("FlashConnect.Description.Port"), DefaultValue(1978)]
        public Int32 Port
        {
            get { return this.port; }
            set { this.port = value; }
        }

    }

}
