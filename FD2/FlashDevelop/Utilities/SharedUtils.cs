using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Text;

namespace FlashDevelop.Utilities
{
	public class SharedUtils
	{
		/**
		* Converts a short filename to a long one
		*/
		[DllImport("kernel32.dll", CharSet = CharSet.Auto)]
		private static extern int GetLongPathName([MarshalAs(UnmanagedType.LPTStr)] string path, [MarshalAs(UnmanagedType.LPTStr)] StringBuilder longPath, int longPathLength);
		public static string GetLongPathName(string shortName)
		{
			StringBuilder longNameBuffer = new StringBuilder(256);
			GetLongPathName(shortName, longNameBuffer, longNameBuffer.Capacity);
			return longNameBuffer.ToString();
		}
		
		/**
		* Converts a color to a string
		*/
		public static string ColorToHex(Color color)
		{
    		return String.Concat("#", color.R.ToString("X2", null), color.G.ToString("X2", null), color.B.ToString("X2", null));
		}
		
		/**
		* Converts a string to a color
		*/
		public static int ResolveColor(string aColor)
		{
			if (aColor != null)
			{
				System.Drawing.Color c = System.Drawing.Color.FromName(aColor);
				if (c.ToArgb() == 0)
				{
					if (aColor.IndexOf("0x") == 0)
					{
						return TO_COLORREF(Int32.Parse(aColor.Substring(2), System.Globalization.NumberStyles.HexNumber));
					}
					else
					{
						try
						{
							return TO_COLORREF(Int32.Parse(aColor));
						}
						catch { /* Do nothing. */ }
					}
				}
				return TO_COLORREF(c.ToArgb()&0x00ffffff);
			}
			return 0;
		}
		private static int TO_COLORREF(int c)
		{
			return (((c&0xff0000)>>16)+((c&0x0000ff)<<16)+(c&0x00ff00));
		}
		
		/**
		* Converts image to an icon 
		*/
		public static Icon ImageToIcon(Image image)
		{
			try 
			{
				Bitmap bmp = new Bitmap(image);
  				IntPtr hIcon = bmp.GetHicon();
  				return Icon.FromHandle(hIcon);
			} 
			catch
			{
				return null;
			}
		}
		
		/**
		* Converts text to another encoding
		*/
		public static string ConvertText(string text, int from, int to)
		{
			Encoding toEnc = Encoding.GetEncoding(from);
			Encoding fromEnc = Encoding.GetEncoding(to);
			byte[] fromBytes = fromEnc.GetBytes(text);
			byte[] toBytes = Encoding.Convert(fromEnc, toEnc, fromBytes);
			return toEnc.GetString(toBytes);
		}
		
	}
	
}
