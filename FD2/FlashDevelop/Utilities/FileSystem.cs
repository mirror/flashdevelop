using System;
using System.IO;
using System.Windows.Forms;
using System.Collections;
using FlashDevelop.Utilities;
using System.Text;
using PluginCore;

namespace FlashDevelop.Utilities
{
	public class FileSystem
	{
		/**
		* Reads the file and returns it's contents.
		*/
		public static string Read(string file, Encoding enc)
		{
			try
			{
				using (StreamReader sr = new StreamReader(file, enc, true))
	            {
	            	string contents = sr.ReadToEnd();
	            	return contents;
	            }
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while reading the file: "+file, ex);
				return null;
			}
		}
		
		/**
		* Writes a text file to the specified location.
		*/
		public static void Write(string file, string text, Encoding enc)
		{
			try
			{
				using (StreamWriter sw = new StreamWriter(file, false, enc))
            	{
					sw.Write(text);
            	}
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while writing the file: "+file, ex);
			}
		}
		
		/**
		* Adds text to the end of the specified file.
		*/
		public static void Add(string file, string text, Encoding enc)
		{
			try
			{
				using (StreamWriter sw = new StreamWriter(file, true, enc))
            	{
					sw.Write(text);
            	}
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while writing the file: "+file, ex);
			}
		}
		
		/**
		* Checks that if the file is read only
		*/
		public static bool IsReadOnly(string file)
		{
			try 
			{
				FileAttributes fileAttr = File.GetAttributes(file);
				if ((fileAttr & FileAttributes.ReadOnly) == FileAttributes.ReadOnly)
				{
					return true;
				}
				return false;
			} 
			catch (Exception ex) 
			{
				ErrorHandler.AddToLog(ex);
				return false;
			}
		}
		
		/**
		* Reads the file codepage from the file data.
		*/
		public static int GetFileCodepage(string file)
		{
			try 
			{
				byte[] bom = new byte[4];
				System.IO.FileStream fs = new System.IO.FileStream(file, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Read);
				if (fs.CanSeek)
				{
					fs.Read(bom, 0, 4); fs.Close();
					if ((bom[0] == 0xef && bom[1] == 0xbb && bom[2] == 0xbf))
					{	
						return Encoding.UTF8.CodePage;
					}
					else if ((bom[0] == 0xff && bom[1] == 0xfe))
					{
						return Encoding.Unicode.CodePage;
					}
					else if ((bom[0] == 0xfe && bom[1] == 0xff))
					{
						return Encoding.BigEndianUnicode.CodePage;
					}
					else if ((bom[0] == 0x2b && bom[1] == 0x2f && bom[2] == 0xfe && bom[3] == 0x76))
					{
						return Encoding.UTF7.CodePage;
					}
					else
					{
						return Encoding.Default.CodePage;
					}
				}
				else
				{
					return Encoding.Default.CodePage;
				}
			} 
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while reading the file: "+file, ex);
				return -1;
			}
		}
		
	}

}
