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
using System.ComponentModel;

namespace FlexDbg.Localization
{
    [AttributeUsage(AttributeTargets.All)]
    public class LocalizedCategoryAttribute : CategoryAttribute
    {
        public LocalizedCategoryAttribute(String key) : base(key) { }

        /// <summary>
        /// Gets the localized string
        /// </summary>
        protected override String GetLocalizedString(String key)
        {
            return TextHelper.GetString(key);
        }

    }

	[AttributeUsage(AttributeTargets.All)]
	public class LocalizedDisplayNameAttribute : DisplayNameAttribute
	{
		public LocalizedDisplayNameAttribute(String key) : base(key) { }

		/// <summary>
		/// Gets the localized string
		/// </summary>
		public override String DisplayName
		{
			get
			{
				return TextHelper.GetString(base.DisplayName);
			}
		}

	}

    [AttributeUsage(AttributeTargets.All)]
    public class LocalizedDescriptionAttribute : DescriptionAttribute
    {
        private Boolean initialized = false;

        public LocalizedDescriptionAttribute(String key) : base(key) { }

        /// <summary>
        /// Gets the description of the string
        /// </summary>
        public override string Description
        {
            get
            {
                if (!initialized)
                {
                    String key = base.Description;
                    DescriptionValue = TextHelper.GetString(key);
                    if (DescriptionValue == null) DescriptionValue = String.Empty;
                    initialized = true;
                }
                return DescriptionValue;
            }
        }
    }

    [AttributeUsage(AttributeTargets.All)]
    public class StringValueAttribute : Attribute
    {
        private String m_Value;

        public StringValueAttribute(String value)
        {
            m_Value = value;
        }

        /// <summary>
        /// Gets the string value of the class
        /// </summary>
        public String Value
        {
            get { return m_Value; }
        }
    }
}
