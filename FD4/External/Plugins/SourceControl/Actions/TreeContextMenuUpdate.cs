using System;
using System.Text;
using System.Collections.Generic;
using ProjectManager.Controls.TreeView;
using SourceControl.Managers;
using System.Windows.Forms;
using SourceControl.Sources;
using PluginCore.Localization;

namespace SourceControl.Actions
{
    class TreeContextMenuUpdate
    {
        private static ToolStripMenuItem scItem = new ToolStripMenuItem();

        static internal void SetMenu(ProjectTreeView tree, ProjectSelectionState state)
        {
            if (tree == null || state.Manager == null) return;
            
            ContextMenuStrip menu = tree.ContextMenuStrip;
            
            IVCMenuItems menuItems = state.Manager.MenuItems;
            if (menuItems == null) return;
            
            ClearItems(menu, menuItems);

            menuItems.CurrentNodes = (TreeNode[])tree.SelectedNodes.ToArray(typeof(TreeNode));
            menuItems.CurrentManager = state.Manager;

            List<ToolStripItem> items = new List<ToolStripItem>();

            // generic
            items.Add(menuItems.Update);
            items.Add(menuItems.Commit);
            items.Add(menuItems.Push);
            items.Add(menuItems.ShowLog);
            int minLen = items.Count;

            // specific
            if (state.Files == 2 && state.Total == 2) items.Add(menuItems.Diff);
            if (state.Conflict == 1 && state.Total == 1) items.Add(menuItems.EditConflict);

            if (state.Unknown + state.Ignored > 0 || state.Dirs > 0) items.Add(menuItems.Add);
            if (state.Unknown + state.Ignored == state.Total) items.Add(menuItems.Ignore);

            if (state.Unknown + state.Ignored < state.Total)
            {
                if (state.Added > 0) items.Add(menuItems.UndoAdd);
                else if (state.Revert > 0)
                {
                    if (state.Diff > 0) items.Add(menuItems.DiffChange);
                    items.Add(menuItems.Revert);
                }
                else if (state.Total == 1) items.Add(menuItems.DiffChange);
            }
            if (items.Count > minLen) items.Insert(minLen, menuItems.MidSeparator);
            items.RemoveAll(item => item == null);
            if (scItem.Owner == null) AddSCMainItem(menu);
            scItem.DropDownItems.AddRange(items.ToArray());
        }

        private static void AddSCMainItem(ContextMenuStrip menu)
        {
            Int32 index = GetFirstSeparatorIndex(menu) + 1;
            scItem.Text = TextHelper.GetString("Label.SourceControl");
            menu.Items.Insert(index, scItem);
            menu.Items.Insert(index + 1, new ToolStripSeparator());
        }

        private static Int32 GetFirstSeparatorIndex(ContextMenuStrip menu)
        {
            Int32 index = -1;
            foreach (ToolStripItem item in menu.Items)
            {
                index++;
                if (item is ToolStripSeparator) return index;
            }
            return -1;
        }

        private static void ClearItems(ContextMenuStrip menu, IVCMenuItems menuItems)
        {
            RemoveItem(menuItems.Add);
            RemoveItem(menuItems.Commit);
            RemoveItem(menuItems.Diff);
            RemoveItem(menuItems.DiffChange);
            RemoveItem(menuItems.EditConflict);
            RemoveItem(menuItems.MidSeparator);
            RemoveItem(menuItems.Revert);
            RemoveItem(menuItems.UndoAdd);
            RemoveItem(menuItems.Update);
        }

        private static void RemoveItem(ToolStripItem item)
        {
            if (item != null && item.Owner != null) item.Owner.Items.Remove(item);
        }

    }

}
