using System;
using System.Text;
using System.ComponentModel;
using System.Windows.Forms;
using System.Collections.Generic;
using PluginCore.Localization;

namespace TaskListPanel
{
    public delegate void GroupsChangedEvent();
    public delegate void ExtensionChangedEvent();
    public delegate void ImagesIndexChangedEvent();

    [Serializable]
    public class Settings
    {
        public event GroupsChangedEvent OnGroupsChanged;
        public event ImagesIndexChangedEvent OnImagesIndexChanged;
        public event ExtensionChangedEvent OnExtensionChanged;

        private Boolean useGrouping = true;
        private Int32[] images = new Int32[] { 229, 197 };
        private String[] extensions = new String[]{ ".as", ".txt" };
        private String[] groups = new String[]{ "TODO", "BUG" };

        /// <summary> 
        /// File extensions to listen for changes
        /// </summary>
        [DisplayName("File Extensions")]
        [LocalizedDescription("TaskListPanel.Description.FileExtensions")]
        [DefaultValue(new String[] { ".as", ".txt" })]
        public String[] FileExtensions
        {
            get { return this.extensions; }
            set 
            { 
                this.extensions = value;
                if (OnExtensionChanged != null) OnExtensionChanged();
            }
        }

        /// <summary> 
        /// Group values to look for.
        /// </summary>
        [DisplayName("Group Values")]
        [LocalizedDescription("TaskListPanel.Description.GroupValues")]
        [DefaultValue(new String[] { "TODO", "FIXME", "BUG" })]
        public String[] GroupValues
        {
            get { return this.groups; }
            set 
            { 
                this.groups = value;
                if (OnGroupsChanged != null) OnGroupsChanged();
            }
        }

        /// <summary> 
        /// Image indexes of the results.
        /// </summary>
        [DisplayName("Image Indexes")]
        [LocalizedDescription("TaskListPanel.Description.ImageIndexes")]
        [DefaultValue(new Int32[] { 229, 197 })]
        public Int32[] ImageIndexes
        {
            get { return this.images; }
            set
            {
                this.images = value;
                if (OnImagesIndexChanged != null) OnImagesIndexChanged();
            }
        }

        /// <summary> 
        /// Grouping the results by project/class path.
        /// </summary>
        [DisplayName("Use Grouping")]
        [LocalizedDescription("TaskListPanel.Description.UseGrouping")]
        [DefaultValue(true)]
        public Boolean UseGrouping {
            get { return this.useGrouping; }
            set 
            {
                this.useGrouping = value;
                if (OnGroupsChanged != null) OnGroupsChanged();
            }
        }

    }

}
