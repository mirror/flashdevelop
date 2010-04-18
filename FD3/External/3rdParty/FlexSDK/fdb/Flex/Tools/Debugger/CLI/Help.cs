////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2004-2006 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
using System;
using System.Collections;
using System.IO;
using System.Text;
using Fdb.Properties;

using SystemProperties = JavaCompatibleClasses.SystemProperties;

namespace Flex.Tools.Debugger.CLI
{
	public class Help
	{
		public static Stream ResourceAsStream
		{
			get
			{
                IList resourceNames = calculateLocalizedNames("fdbhelp", "", System.Threading.Thread.CurrentThread.CurrentCulture);
                for (int i = resourceNames.Count - 1; i >= 0; i--)
                {
                    String resString = Resources.ResourceManager.GetString(resourceNames[i].ToString());

                    if (resString != null)
                    {
                        UTF8Encoding encoding = new UTF8Encoding();
                        Char[] chars = resString.ToCharArray();

                        return new MemoryStream(encoding.GetBytes(chars));
                    }
                }

				IList fileNames = calculateLocalizedNames("fdbhelp", ".txt", System.Threading.Thread.CurrentThread.CurrentCulture); //$NON-NLS-1$ //$NON-NLS-2$
                for (int i = fileNames.Count - 1; i >= 0; --i)
				{
                    Stream stm = SystemProperties.getResourceAsStream((String)fileNames[i]);
					if (stm != null)
					{
						return stm;
					}
				}
				return null;
			}
		}

        private Help()
		{
		}
		
		/// <summary> Returns an array of filenames that might match the given baseName and locale.
		/// For example, if baseName is "fdbhelp", the extension is ".txt", and the locale
		/// is "en_US", then the returned array will be (in this order):
		/// 
		/// <ul>
		/// <li> <code>fdbhelp.txt</code> </li>
		/// <li> <code>fdbhelp_en.txt</code> </li>
		/// <li> <code>fdbhelp_en_US.txt</code> </li>
		/// </ul>
		/// </summary>
		private static System.Collections.IList calculateLocalizedNames(String baseName, String extensionWithDot, System.Globalization.CultureInfo locale)
		{
			System.Collections.IList names = new System.Collections.ArrayList();
			String language = locale.TwoLetterISOLanguageName;
			String country = new System.Globalization.RegionInfo(locale.LCID).TwoLetterISORegionName;
			//String variant = locale.getVariant();
			
			names.Add(baseName + extensionWithDot);
			
			if (language.Length + country.Length == 0)
			{
				//The locale is "", "", "".
				return names;
			}
			System.Text.StringBuilder temp = new System.Text.StringBuilder(baseName);
			temp.Append('_');
			temp.Append(language);
			if (language.Length > 0)
			{
				names.Add(temp.ToString() + extensionWithDot);
			}
			
			if (country.Length == 0)
			{
				return names;
			}
			temp.Append('_');
			temp.Append(country);
			if (country.Length > 0)
			{
				names.Add(temp.ToString() + extensionWithDot);
			}
			
			return names;
		}
	}
}
