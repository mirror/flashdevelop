using System;
using System.Text;
using System.Collections;
using System.Windows.Forms;
using System.Collections.Generic;
using PluginCore.Managers;
using PluginCore;

namespace FlashDevelop.Managers
{
    class ShortcutManager
    {
        public static List<Keys> AllShortcuts = new List<Keys>();
        public static List<ShortcutItem> RegistedItems = new List<ShortcutItem>();

        /// <summary>
        /// Registers a shortcut item
        /// </summary>
        public static void RegisterItem(String key, Keys keys)
        {
            ShortcutItem registered = new ShortcutItem(key, keys);
            RegistedItems.Add(registered);
        }

        /// <summary>
        /// Registers a shortcut item
        /// </summary>
        public static void RegisterItem(String key, ToolStripMenuItem item)
        {
            ShortcutItem registered = new ShortcutItem(key, item);
            RegistedItems.Add(registered);
        }

        /// <summary>
        /// Applies all shortcuts to the items
        /// </summary>
        public static void ApplyAllShortcuts()
        {
            foreach (ShortcutItem item in RegistedItems)
            {
                if (item.Default == item.Custom) return;
                if (item.Item == null) // Tell plugins to apply...
                {
                    DataEvent de = new DataEvent(EventType.Shortcut, item.Id, item.Custom);
                    EventManager.DispatchEvent(Globals.MainForm, de);
                }
                else item.Item.ShortcutKeys = item.Custom;
            }
            UpdateAllShortcuts();
        }

        /// <summary>
        /// Updates the list of all shortcuts
        /// </summary>
        public static List<Keys> UpdateAllShortcuts()
        {
            List<Keys> keys = new List<Keys>();
            foreach (ShortcutItem item in RegistedItems)
            {
                keys.Add(item.Item.ShortcutKeys);
            }
            return AllShortcuts = keys;
        }

    }

    public class ShortcutItem
    {
        public Keys Custom = Keys.None;
        public Keys Default = Keys.None;
        public ToolStripMenuItem Item = null;
        public String Id = String.Empty;

        public ShortcutItem(String id, Keys keys)
        {
            this.Id = id;
            this.Default = keys;
        }

        public ShortcutItem(String id, ToolStripMenuItem item)
        {
            this.Id = id;
            this.Item = item;
            this.Default = item.ShortcutKeys;
        }

    }

}
