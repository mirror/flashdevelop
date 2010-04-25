/*
    Copyright (C) 2009  Robert Nelson

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/

using System;
using System.Reflection;
using System.Resources;
using TraceManager = PluginCore.Managers.TraceManager;

namespace FlexDbg.Localization
{
    public class TextHelper
    {
		private static ResourceManager m_ResourceManager = null;

        /// <summary>
        /// Gets the specified localized string
        /// </summary>
        public static String GetString(String key)
		{
            String result = null;
            Assembly assembly = Assembly.GetCallingAssembly();
            if (m_ResourceManager == null)
            {
                m_ResourceManager = new ResourceManager("FlexDbg.Resources.Strings", assembly);
            }
            try
            {
                result = m_ResourceManager.GetString(key);
            }
            catch (MissingManifestResourceException) { }
            if (result == null)
            {
                TraceManager.AddAsync("No localized string found: " + key);
                result = "[" + key + "]";
            }
            return result;
		}

    }

}
