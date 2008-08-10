using System;
using System.IO;
using System.Text;
using System.Windows.Forms;
using System.Collections;
using System.Xml;

namespace AS2APIGUI
{
	
	public class FileSystem
	{
		/**
		* Reads the specified file and returns text.
		*/
		public static string Read(string file, Encoding enc)
		{
			try
			{
				using(StreamReader sr = new StreamReader(file, enc, true))
	            {
	            	string contents = sr.ReadToEnd();
	            	return contents;
	            }
			}
			catch
			{
				MessageBox.Show("Error while reading the file: "+file, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return null;
			}
		}
		
		/**
		* Writes a text file with the specified encoding.
		*/
		public static void Write(string file, string text, Encoding enc)
		{
			try
			{
				using(StreamWriter sw = new StreamWriter(file, false, enc))
            	{
					sw.Write(text);
            	}
			}
			catch
			{
				MessageBox.Show("Error while writing the file: "+file, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}	

	}

}
