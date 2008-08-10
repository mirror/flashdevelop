using System;
using System.Windows.Forms;
using System.Text;
using System.IO;
using PluginCore.Controls;

namespace PluginCore
{
	public class ErrorHandler
	{
		/**
		* Enables/disables the log file output.
		*/
		public static bool OutputIsEnabled = true;
		
		/**
		* Shows a visible info message to the user.
		*/
		public static void ShowInfo(string info)
		{
			MessageBox.Show(info, " Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
		}
		
		/**
		* Shows a visible warning message to the user.
		*/
		public static void ShowWarning(string info, object exception)
		{
			MessageBox.Show(info, " Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			if (OutputIsEnabled) AddToLog(info, exception);
		}
		
		/**
		* Shows a visible error message to the user.
		*/
		public static void ShowError(string info, object exception)
		{
			MessageBox.Show(info, " Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
			if (OutputIsEnabled) AddToLog(info, exception);
		}
		
		/**
		* Adds the recieved exception to the log file.
		*/
		public static void AddToLog(object exception)
		{
			AddToLog(null, exception);
		}
		
		/**
		* Adds the recieved exception with info to the log file.
		*/
		public static void AddToLog(string info, object exception)
		{
			try
			{
				string text;
				Exception ex = (Exception)exception;
				string date = DateTime.Now.ToString();
				if (info == null) text = date+"\r\n\r\n"+ex.ToString()+"\r\n\r\n";
				else text = date+"\r\n\r\n"+info+"\r\n\r\n"+ex.ToString()+"\r\n\r\n";
				string path = Path.GetDirectoryName(Application.ExecutablePath)+"\\ErrorList.log";
				using (StreamWriter sw = new StreamWriter(path, true, Encoding.Default))
            	{
					sw.Write(text);
            	}
			}
			catch { /* Do nothing.. */ }
		}
		
	}
	
}
