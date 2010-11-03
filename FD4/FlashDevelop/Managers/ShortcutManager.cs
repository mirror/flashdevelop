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
        public static void RegisterItem(String key, String location, ToolStripMenuItem item)
        {
            ShortcutItem registered = new ShortcutItem(key, location, item);
            RegistedItems.Add(registered);
        }

        /// <summary>
        /// Applies all shortcuts to the items
        /// </summary>
        public static void ApplyAllShortcuts()
        {
            foreach (ShortcutItem item in RegistedItems)
            {
                DataEvent de = new DataEvent(EventType.Shortcut, item.Key, item.Item.ShortcutKeys);
                EventManager.DispatchEvent(Globals.MainForm, de); // Ask from plugins...
                if (de.Handled) item.Item.ShortcutKeys = (Keys)de.Data;
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

}
