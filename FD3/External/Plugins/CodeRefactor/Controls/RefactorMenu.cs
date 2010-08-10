using System;
using System.Text;
using System.Windows.Forms;
using PluginCore.Localization;
using PluginCore;

namespace CodeRefactor.Controls
{
    public class RefactorMenu : ToolStripMenuItem
    {
        private Settings settings;
        private ToolStripMenuItem renameMenuItem;
        private ToolStripMenuItem truncateMenuItem;
        private ToolStripMenuItem organizeMenuItem;
        private ToolStripMenuItem extractMethodMenuItem;
        private ToolStripMenuItem delegateMenuItem;
        private ToolStripMenuItem extractLocalVariableMenuItem;

        public RefactorMenu(Settings settings)
        {
            this.settings = settings;
            this.Text = TextHelper.GetString("Label.Refactor");
            this.renameMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.Rename"), null) as ToolStripMenuItem;
            this.extractMethodMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.ExtractMethod"), null) as ToolStripMenuItem;
            this.extractLocalVariableMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.ExtractLocalVariable"), null) as ToolStripMenuItem;
			this.delegateMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.DelegateMethods"), null) as ToolStripMenuItem;
            this.DropDownItems.Add(new ToolStripSeparator());
            this.organizeMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.OrganizeImports"), null) as ToolStripMenuItem;
            this.truncateMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.TruncateImports"), null) as ToolStripMenuItem;
            this.ApplyShortcutKeys();
        }

        /// <summary>
        /// Accessor to the RenameMenuItem
        /// </summary>
        public ToolStripMenuItem RenameMenuItem
        {
            get { return this.renameMenuItem; }
        }

        /// <summary>
        /// Accessor to the TruncateMenuItem
        /// </summary>
        public ToolStripMenuItem TruncateMenuItem
        {
            get { return this.truncateMenuItem; }
        }

        /// <summary>
        /// Accessor to the OrganizeMenuItem
        /// </summary>
        public ToolStripMenuItem OrganizeMenuItem
        {
            get { return this.organizeMenuItem; }
        }

        /// <summary>
        /// Accessor to the ExtractMethodMenuItem
        /// </summary>
        public ToolStripMenuItem ExtractMethodMenuItem
        {
            get { return this.extractMethodMenuItem; }
        }

        /// <summary>
        /// Accessor to the DelegateMenuItem
        /// </summary>
        public ToolStripMenuItem DelegateMenuItem
        {
            get { return this.delegateMenuItem; }
        }

        /// <summary>
        /// Accessor to the ExtractLocalVariableMenuItem
        /// </summary>
        public ToolStripMenuItem ExtractLocalVariableMenuItem
        {
            get { return this.extractLocalVariableMenuItem; }
        }

        /// <summary>
        /// Applies the shortcut keys from the settings
        /// </summary>
        public void ApplyShortcutKeys()
        {
            this.renameMenuItem.ShortcutKeys = this.settings.RenameShortcut;
            this.organizeMenuItem.ShortcutKeys = this.settings.OrganizeShortcut;
            this.truncateMenuItem.ShortcutKeys = this.settings.TruncateShortcut;
        }

    }

}
