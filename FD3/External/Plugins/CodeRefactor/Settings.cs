using System;
using System.Text;
using System.ComponentModel;
using System.Collections.Generic;
using PluginCore.Localization;
using System.Windows.Forms;

namespace CodeRefactor
{
    [Serializable]
    public class Settings
    {
        private Keys renameShortcut = Keys.None;
        private Keys findRefsShortcut = Keys.None;
        private Keys organizeShortcut = Keys.None;
        private Keys truncateShortcut = Keys.None;

        [DisplayName("Rename")]
        [LocalizedCategory("CodeRefactor.Category.Shortcuts")]
        [LocalizedDescription("CodeRefactor.Description.RenameShortcut"), DefaultValue(Keys.None)]
        public Keys RenameShortcut
        {
            get { return this.renameShortcut; }
            set { this.renameShortcut = value; }
        }

        [DisplayName("Find All References")]
        [LocalizedCategory("CodeRefactor.Category.Shortcuts")]
        [LocalizedDescription("CodeRefactor.Description.FindRefsShortcut"), DefaultValue(Keys.None)]
        public Keys FindRefsShortcut
        {
            get { return this.findRefsShortcut; }
            set { this.findRefsShortcut = value; }
        }

        [DisplayName("Organize Imports")]
        [LocalizedCategory("CodeRefactor.Category.Shortcuts")]
        [LocalizedDescription("CodeRefactor.Description.OrganizeShortcut"), DefaultValue(Keys.None)]
        public Keys OrganizeShortcut
        {
            get { return this.organizeShortcut; }
            set { this.organizeShortcut = value; }
        }

        [DisplayName("Truncate Imports")]
        [LocalizedCategory("CodeRefactor.Category.Shortcuts")]
        [LocalizedDescription("CodeRefactor.Description.TruncateShortcut"), DefaultValue(Keys.None)]
        public Keys TruncateShortcut
        {
            get { return this.truncateShortcut; }
            set { this.truncateShortcut = value; }
        }

    }

}
