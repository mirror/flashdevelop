using System;
using System.IO;
using System.Text;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;
using PluginCore.Managers;
using PluginCore.Utilities;
using PluginCore.Helpers;

namespace PluginCore.Controls
{
    public class SmartForm : Form
    {
        private String formGuid;
        private FormProps formProps;

        public SmartForm()
        {
            this.formProps = new FormProps();
            this.formGuid = Guid.Empty.ToString().ToUpper();
            this.Load += new EventHandler(this.SmartFormLoad);
            this.Shown += new EventHandler(this.SmartFormShown);
            this.FormClosing += new FormClosingEventHandler(this.SmartFormClosing);
        }

        /// <summary>
        /// Gets or sets the form guid
        /// </summary>
        public String FormGuid
        {
            get { return this.formGuid; }
            set { this.formGuid = value.ToUpper(); }
        }

        /// <summary>
        /// Path to the unique setting file
        /// </summary>
        private String FormPropsFile
        {
            get { return Path.Combine(this.FormStatesDir, this.formGuid + ".fdb"); }
        }

        /// <summary>
        /// Path to the form state file directory
        /// </summary>
        private String FormStatesDir
        {
            get
            {
                String settingDir = PathHelper.SettingDir;
                String formStatesDir = Path.Combine(settingDir, "FormStates");
                if (!Directory.Exists(formStatesDir)) Directory.CreateDirectory(formStatesDir);
                return formStatesDir;
            }
        }

        /// <summary>
        /// Center the dialog to parent if requested
        /// </summary>
        private void SmartFormShown(Object sender, EventArgs e)
        {
            if (this.StartPosition == FormStartPosition.CenterParent)
            {
                this.CenterToParent();
            }
        }

        /// <summary>
        /// Load the form state from a setting file and applies it
        /// </summary>
        private void SmartFormLoad(Object sender, EventArgs e)
        {
            if (File.Exists(this.FormPropsFile))
            {
                Object obj = ObjectSerializer.Deserialize(this.FormPropsFile, this.formProps);
                this.formProps = (FormProps)obj;
            }
            if (!this.formProps.WindowSize.IsEmpty)
            {
                this.Size = this.formProps.WindowSize;
            }
        }

        /// <summary>
        /// Saves the current form state to a setting file
        /// </summary>
        private void SmartFormClosing(Object sender, FormClosingEventArgs e)
        {
            if (!this.Size.IsEmpty)
            {
                this.formProps.WindowSize = this.Size;
                ObjectSerializer.Serialize(this.FormPropsFile, this.formProps);
            }
        }

    }

    [Serializable]
    public class FormProps
    {
        public Size WindowSize;

        public FormProps()
        {
            this.WindowSize = Size.Empty;
        }
    }

}
