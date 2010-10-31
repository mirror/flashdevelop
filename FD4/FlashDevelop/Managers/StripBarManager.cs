using System;
using System.Xml;
using System.Text;
using System.Windows.Forms;
using System.Collections.Generic;
using PluginCore.Localization;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore;

namespace FlashDevelop.Managers
{
    static class StripBarManager
    {
        public static List<Keys> ShortcutKeys = new List<Keys>();
        public static List<ToolStripItem> Items = new List<ToolStripItem>();

        /// <summary>
        /// Finds the tool or menu strip item by name
        /// </summary>
        public static ToolStripItem FindMenuItem(String name)
        {
            for (Int32 i = 0; i < Items.Count; i++)
            {
                ToolStripItem item = Items[i];
                if (item.Name == name) return item;
            }
            return null;
        }

        /// <summary>
        /// Finds the tool or menu strip items by name
        /// </summary>
        public static List<ToolStripItem> FindMenuItemsByName(String name)
        {
            List<ToolStripItem> found = new List<ToolStripItem>();
            for (Int32 i = 0; i < Items.Count; i++)
            {
                ToolStripItem item = Items[i];
                if (item.Name == name) found.Add(item);
            }
            return found;
        }

        /// <summary>
        /// Populates the specified list with all items in the menu
        /// </summary>
        public static void PopulateMenuList(ToolStripItemCollection children, List<ToolStripItem> all)
        {
            foreach (ToolStripItem item in children)
            {
                all.Add(item);
                if (item is ToolStripMenuItem && ((ToolStripMenuItem)item).HasDropDownItems)
                {
                    PopulateMenuList(((ToolStripMenuItem)item).DropDownItems, all);
                }
            }
        }

        /// <summary>
        /// Gets a menu strip from the specified xml file
        /// </summary>
        public static MenuStrip GetMenuStrip(String file)
        {
            MenuStrip menuStrip = new MenuStrip();
            XmlNode rootNode = XmlHelper.LoadXmlDocument(file);
            foreach (XmlNode subNode in rootNode.ChildNodes)
            {
                FillMenuItems(menuStrip.Items, subNode);
            }
            return menuStrip;
        }

        /// <summary>
        /// Gets a tool strip from the specified xml file
        /// </summary>
        public static ToolStrip GetToolStrip(String file)
        {
            ToolStrip toolStrip = new ToolStrip();
            XmlNode rootNode = XmlHelper.LoadXmlDocument(file);
            foreach (XmlNode subNode in rootNode.ChildNodes)
            {
                FillToolItems(toolStrip.Items, subNode);
            }
            return toolStrip;
        }

        /// <summary>
        /// Gets a context menu strip from the specified xml file
        /// </summary>
        public static ContextMenuStrip GetContextMenu(String file)
        {
            ContextMenuStrip contextMenu = new ContextMenuStrip();
            XmlNode rootNode = XmlHelper.LoadXmlDocument(file);
            foreach (XmlNode subNode in rootNode.ChildNodes)
            {
                FillMenuItems(contextMenu.Items, subNode);
            }
            return contextMenu;
        }

        /// <summary>
        /// Fills items to the specified tool strip item collection
        /// </summary>
        public static void FillMenuItems(ToolStripItemCollection items, XmlNode node)
        {
            switch (node.Name)
            {
                case "menu" :
                    items.Add(GetMenu(node));
                    break;
                case "separator" :
                    items.Add(GetSeparator(node));
                    break;
                case "button" : 
                    items.Add(GetMenuItem(node));
                    break;
            }
        }

        /// <summary>
        /// Fills items to the specified tool strip item collection
        /// </summary>
        public static void FillToolItems(ToolStripItemCollection items, XmlNode node)
        {
            switch (node.Name)
            {
                case "separator":
                    items.Add(GetSeparator(node));
                    break;
                case "button":
                    items.Add(GetButtonItem(node));
                    break;
            }
        }

        /// <summary>
        /// Gets a menu from the specified xml node
        /// </summary>
        public static ToolStripMenuItem GetMenu(XmlNode node)
        {
            ToolStripMenuItem menu = new ToolStripMenuItem();
            String name = XmlHelper.GetAttribute(node, "name");
            String image = XmlHelper.GetAttribute(node, "image");
            String label = XmlHelper.GetAttribute(node, "label");
            String click = XmlHelper.GetAttribute(node, "click");
            String flags = XmlHelper.GetAttribute(node, "flags");
            String enabled = XmlHelper.GetAttribute(node, "enabled");
            String tag = XmlHelper.GetAttribute(node, "tag");
            menu.Tag = new ItemData(tag, flags);
            menu.Text = GetLocalizedString(label);
            if (name != null) menu.Name = name; // Use the given name
            else menu.Name = label; // Use the locale id as a name
            if (enabled != null) menu.Enabled = Convert.ToBoolean(enabled);
            if (image != null) menu.Image = Globals.MainForm.FindImage(image);
            if (click != null) menu.Click += GetEventHandler(click);
            foreach (XmlNode subNode in node.ChildNodes)
            {
                FillMenuItems(menu.DropDownItems, subNode);
            }
            Items.Add(menu);
            return menu;
        }

        /// <summary>
        /// Gets a button item from the specified xml node
        /// </summary>
        public static ToolStripItem GetButtonItem(XmlNode node)
        {
            ToolStripButton button = new ToolStripButton();
            String name = XmlHelper.GetAttribute(node, "name");
            String image = XmlHelper.GetAttribute(node, "image");
            String label = XmlHelper.GetAttribute(node, "label");
            String click = XmlHelper.GetAttribute(node, "click");
            String flags = XmlHelper.GetAttribute(node, "flags");
            String enabled = XmlHelper.GetAttribute(node, "enabled");
            String tag = XmlHelper.GetAttribute(node, "tag");
            button.Tag = new ItemData(tag, flags); 
            label = GetStrippedLocalizedString(label);
            if (image != null) button.ToolTipText = label;
            else button.Text = label; // Set text with image
            if (name != null) button.Name = name; // Use the given name
            else button.Name = label; // Use the locale id as a name
            if (enabled != null) button.Enabled = Convert.ToBoolean(enabled);
            if (image != null) button.Image = Globals.MainForm.FindImage(image);
            if (click != null) button.Click += GetEventHandler(click);
            Items.Add(button);
            return button;
        }

        /// <summary>
        /// Get a menu item from the specified xml node
        /// </summary>
        public static ToolStripMenuItem GetMenuItem(XmlNode node)
        {
            ToolStripMenuItem menu = new ToolStripMenuItem();
            String name = XmlHelper.GetAttribute(node, "name");
            String image = XmlHelper.GetAttribute(node, "image");
            String label = XmlHelper.GetAttribute(node, "label");
            String click = XmlHelper.GetAttribute(node, "click");
            String enabled = XmlHelper.GetAttribute(node, "enabled");
            String shortcut = XmlHelper.GetAttribute(node, "shortcut");
            String keytext = XmlHelper.GetAttribute(node, "keytext");
            String flags = XmlHelper.GetAttribute(node, "flags");
            String tag = XmlHelper.GetAttribute(node, "tag");
            menu.Tag = new ItemData(tag, flags);
            menu.Text = GetLocalizedString(label);
            if (name != null) menu.Name = name; // Use the given name
            else menu.Name = label; // Use the locale id as a name
            if (image != null) menu.Image = Globals.MainForm.FindImage(image);
            if (enabled != null) menu.Enabled = Convert.ToBoolean(enabled);
            if (shortcut != null) menu.ShortcutKeys = GetKeys(shortcut);
            if (keytext != null) menu.ShortcutKeyDisplayString = GetKeyText(keytext);
            if (click != null) menu.Click += GetEventHandler(click);
            Items.Add(menu);
            return menu;
        }

        /// <summary>
        /// Gets a new tool strip separetor item
        /// </summary>
        public static ToolStripSeparator GetSeparator(XmlNode node)
        {
            return new ToolStripSeparator();
        }
        
        /// <summary>
        /// Gets a localized string if available and removes extras
        /// </summary>
        private static String GetStrippedLocalizedString(String key)
        {
            String result = GetLocalizedString(key);
            result = result.Replace("...", "");
            result = result.Replace("&", "");
            return result;
        }

        /// <summary>
        /// Gets a localized string if available
        /// </summary>
        private static String GetLocalizedString(String key)
        {
            try
            {
                if (!key.StartsWith("Label.")) return key;
                else return TextHelper.GetString(key);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return String.Empty;
            }
        }

        /// <summary>
        /// Gets a shortcut key string from a string
        /// </summary>
        private static String GetKeyText(String data)
        {
            data = data.Replace("|", "+");
            data = data.Replace("Control", "Ctrl");
            return data;
        }

        /// <summary>
        /// Gets a shortcut keys from a string
        /// </summary>
        private static Keys GetKeys(String data)
        {
            try
            {
                Keys shortcut = Keys.None;
                String[] keys = data.Split('|');
                for (Int32 i = 0; i < keys.Length; i++) shortcut = shortcut | (Keys)Enum.Parse(typeof(Keys), keys[i]);
                if (!ShortcutKeys.Contains(shortcut)) ShortcutKeys.Add(shortcut);
                return (Keys)shortcut;
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return Keys.None;
            }
        }

        /// <summary>
        /// Gets a click handler from a string
        /// </summary>
        private static EventHandler GetEventHandler(String method)
        {
            try
            {
                return (EventHandler)Delegate.CreateDelegate(typeof(EventHandler), Globals.MainForm, method);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return null;
            }
        }

    }

}
