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
        private Keys extractLocalVariableShortcut = Keys.None;
        private Keys generateDelegateMethodsShortcut = Keys.None;
        private Keys extractMethodShortcut = Keys.None;
        private Boolean separatePackages = false;

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

        [DisplayName("Extract Local Variable")]
        [LocalizedCategory("CodeRefactor.Category.Shortcuts")]
        [LocalizedDescription("CodeRefactor.Description.ExtractLocalVariableShortcut"), DefaultValue(Keys.None)]
        public Keys ExtractLocalVariableShortcut
        {
            get { return this.extractLocalVariableShortcut; }
            set { this.extractLocalVariableShortcut = value; }
        }

        [DisplayName("Extract Method")]
        [LocalizedCategory("CodeRefactor.Category.Shortcuts")]
        [LocalizedDescription("CodeRefactor.Description.ExtractMethodShortcut"), DefaultValue(Keys.None)]
        public Keys ExtractMethodShortcut
        {
            get { return this.extractMethodShortcut; }
            set { this.extractMethodShortcut = value; }
        }

        [DisplayName("Generate Delegate Methods")]
        [LocalizedCategory("CodeRefactor.Category.Shortcuts")]
        [LocalizedDescription("CodeRefactor.Description.GenerateDelegateMethodsShortcut"), DefaultValue(Keys.None)]
        public Keys GenerateDelegateMethodsShortcut
        {
            get { return this.generateDelegateMethodsShortcut; }
            set { this.generateDelegateMethodsShortcut = value; }
        }

        [DisplayName("Separate Packages")]
        [LocalizedDescription("CodeRefactor.Description.SeparatePackages"), DefaultValue(false)]
        public Boolean SeparatePackages
        {
            get { return this.separatePackages; }
            set { this.separatePackages = value; }
        }

    }

}
