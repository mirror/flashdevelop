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

        public RefactorMenu(Settings settings)
        {
            this.settings = settings;
            this.Text = TextHelper.GetString("Label.Refactor");
            this.renameMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.Rename"), null) as ToolStripMenuItem;
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
