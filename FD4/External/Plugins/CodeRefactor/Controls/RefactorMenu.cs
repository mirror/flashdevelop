﻿using System;
using System.Text;
using System.Windows.Forms;
using PluginCore.Localization;
using CodeRefactor.CustomControls;
using PluginCore;

namespace CodeRefactor.Controls
{
    public class RefactorMenu : ToolStripMenuItem
    {
        private SurroundMenu surroundMenu;
        private ToolStripMenuItem renameMenuItem;
        private ToolStripMenuItem truncateMenuItem;
        private ToolStripMenuItem organizeMenuItem;
        private ToolStripMenuItem delegateMenuItem;
        private ToolStripMenuItem generatorMenuItem;
        private ToolStripMenuItem extractMethodMenuItem;
        private ToolStripMenuItem extractLocalVariableMenuItem;

        public RefactorMenu(Boolean createSurroundMenu)
        {
            this.Text = TextHelper.GetString("Label.Refactor");
            this.renameMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.Rename"), null) as ToolStripMenuItem;
            this.extractMethodMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.ExtractMethod"), null) as ToolStripMenuItem;
            this.extractLocalVariableMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.ExtractLocalVariable"), null) as ToolStripMenuItem;
			this.delegateMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.DelegateMethods"), null) as ToolStripMenuItem;
            if (createSurroundMenu)
            {
                this.surroundMenu = new SurroundMenu();
                this.DropDownItems.Add(this.surroundMenu);
            }
            this.DropDownItems.Add(new ToolStripSeparator());
            this.generatorMenuItem = new ToolStripMenuItem(TextHelper.GetString("Label.InvokeCodeGenerator"), null, null, createSurroundMenu ? Keys.Control | Keys.Shift | Keys.D1 : Keys.None);
            this.DropDownItems.Add(this.generatorMenuItem);
            this.DropDownItems.Add(new ToolStripSeparator());
            this.organizeMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.OrganizeImports"), null) as ToolStripMenuItem;
            this.truncateMenuItem = this.DropDownItems.Add(TextHelper.GetString("Label.TruncateImports"), null) as ToolStripMenuItem;
            if (createSurroundMenu) RegisterMenuItems();
        }

        /// <summary>
        /// Registers the items with shortcut management
        /// </summary>
        private void RegisterMenuItems()
        {
            PluginBase.MainForm.RegisterShortcutItem("RefactorMenu.Rename", this.renameMenuItem);
            PluginBase.MainForm.RegisterShortcutItem("RefactorMenu.ExtractMethod", this.extractMethodMenuItem);
            PluginBase.MainForm.RegisterShortcutItem("RefactorMenu.ExtractLocalVariable", this.extractLocalVariableMenuItem);
            PluginBase.MainForm.RegisterShortcutItem("RefactorMenu.GenerateDelegateMethods", this.delegateMenuItem);
            PluginBase.MainForm.RegisterShortcutItem("RefactorMenu.OrganizeImports", this.organizeMenuItem);
            PluginBase.MainForm.RegisterShortcutItem("RefactorMenu.TruncateImports", this.truncateMenuItem);
            PluginBase.MainForm.RegisterShortcutItem("RefactorMenu.CodeGenerator", this.generatorMenuItem);
        }

        /// <summary>
        /// Accessor to the SurroundMenu
        /// </summary>
        public SurroundMenu SurroundMenu
        {
            get { return this.surroundMenu; }
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
        /// Accessor to the CodeGeneratorMenuItem
        /// </summary>
        public ToolStripMenuItem CodeGeneratorMenuItem
        {
            get { return this.generatorMenuItem; }
        }

    }

}
