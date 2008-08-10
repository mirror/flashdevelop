using System;
using System.Windows.Forms;
using System.IO;
using PluginCore;

namespace FlashDevelop.Utilities
{
	public class Arguments
	{
		private MainForm mainForm;
		
		public Arguments(MainForm mainForm)
		{
			this.mainForm = mainForm;
		}
		
		/**
		* Gets the FlashDevelop root path
		*/
		private string GetAppPath()
		{
			return FilePaths.AppPath;
		}
		
		/**
		* Gets the selected text
		*/
		private string GetSelText()
		{
			return this.mainForm.CurSciControl.SelText;
		}
		
		/**
		* Gets the current file
		*/
		private string GetCurFile()
		{
			return this.mainForm.CurFile;
		}
		
		/**
		* Gets the current file's path
		*/
		private string GetCurDir()
		{
			return Path.GetDirectoryName(this.mainForm.CurFile);
		}
		
		/**
		* Gets the name of the current file
		*/
		private string GetCurFilename()
		{
			return Path.GetFileName(this.mainForm.CurFile);
		}
		
		/**
		* Gets the current word
		*/
		private string GetCurWord()
		{
			int curPos = this.mainForm.CurSciControl.CurrentPos;
			string curWord = this.mainForm.CurSciControl.GetWordFromPosition(curPos);
			if (curWord != null)
			{
				return curWord;
			}
			else return "";
		}
		
		/**
		* Gets the timestamp
		*/
		private string GetTimestamp()
		{
			return DateTime.Now.ToString("g");
		}
		
		/**
		* Gets the desktop path
		*/
		private string GetDesktop()
		{
			return Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
		}
		
		/**
		* Gets the system path
		*/
		private string GetSystem()
		{
			return Environment.GetFolderPath(Environment.SpecialFolder.System);
		}
		
		/**
		* Gets the program files path
		*/
		private string GetProgramFiles()
		{
			return Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles);
		}
		
		/**
		* Gets the users personal files path
		*/
		private string GetPersonal()
		{
			return Environment.GetFolderPath(Environment.SpecialFolder.Personal);
		}
		
		/**
		* Gets the working directory
		*/
		public string GetWorkingDir()
		{
			return Directory.GetCurrentDirectory();
		}
		
		/**
		* Gets the user selected file for opening
		*/
		private string GetSelectedFile(string txt)
		{
			if(txt.IndexOf("@SELFILE") > -1)
			{
				OpenFileDialog ofd = new OpenFileDialog();
				ofd.InitialDirectory = this.GetCurDir();
				ofd.Multiselect = false;
				if (ofd.ShowDialog(this.mainForm) == DialogResult.OK)
				{
					return ofd.FileName;
				} 
				else return "";
			}
			else return "";
		}
		
		/**
		* Gets the user selected file for saving
		*/
		private string GetTargetFile(string txt)
		{
			if(txt.IndexOf("@TRGFILE") > -1)
			{
				SaveFileDialog sfd = new SaveFileDialog();
				sfd.InitialDirectory = this.GetCurDir();
				if (sfd.ShowDialog(this.mainForm) == DialogResult.OK)
				{
					return sfd.FileName;
				} 
				else return "";
			}
			else return "";
		}
		
		/**
		* Gets the user selected folder
		*/
		private string GetSelectedFolder(string txt)
		{
			if (txt.IndexOf("@SELDIR") > -1)
			{
				FolderBrowserDialog fbd = new FolderBrowserDialog();
				fbd.RootFolder = System.Environment.SpecialFolder.MyComputer;
				if (fbd.ShowDialog(this.mainForm) == DialogResult.OK)
				{
					return fbd.SelectedPath;
				} 
				else return "";
			}
			else return "";
		}
		
		/**
		* Gets the clipboard text
		*/
		private string GetClipboardText()
		{
			IDataObject cbdata = Clipboard.GetDataObject();
			if (cbdata.GetDataPresent("System.String", true)) 
			{
				return cbdata.GetData("System.String", true).ToString();
			}
			else return "";
		}
		
		/**
		* Processes the user defined arguments
		*/
		private string ProcessCustomArgs(string src)
		{
			try 
			{
				string result = src;
				int count = this.mainForm.Settings.Settings.Count;
				for (int i = 0; i<count; i++)
				{
					string txt = result;
					SettingEntry se = (SettingEntry)this.mainForm.Settings.Settings[i];
					if (se.Key.StartsWith("FlashDevelop.UserDefined."))
					{
						string pKey = se.Key.Replace("FlashDevelop.UserDefined.", "");
						result = txt.Replace(pKey, se.Value);
					}
				}
				return result;
			} 
			catch (Exception ex)
			{
				ErrorHandler.AddToLog(ex);
				return src;
			}
		}
		
		/**
		* Processes the argument string variables
		*/
		public string ProcessString(string args)
		{
			string result = args;
			result = result.Replace("@QUOTE", "\"");
			result = result.Replace("@APPDIR", this.GetAppPath());
			result = result.Replace("@SELTEXT", this.GetSelText());
			result = result.Replace("@CURFILENAME", this.GetCurFilename());
			result = result.Replace("@CURFILE", this.GetCurFile());
			result = result.Replace("@CURDIR", this.GetCurDir());
			result = result.Replace("@TIMESTAMP", this.GetTimestamp());
			result = result.Replace("@CURWORD", this.GetCurWord());
			result = result.Replace("@SELFILE", this.GetSelectedFile(result));
			result = result.Replace("@TRGFILE", this.GetTargetFile(result));
			result = result.Replace("@SELDIR", this.GetSelectedFolder(result));
			result = result.Replace("@DESKTOP", this.GetDesktop());
			result = result.Replace("@SYSTEM", this.GetSystem());
			result = result.Replace("@PROGDIR", this.GetProgramFiles());
			result = result.Replace("@PERSONAL", this.GetPersonal());
			result = result.Replace("@WORKINGDIR", this.GetWorkingDir());
			result = result.Replace("@CLIPBOARD", this.GetClipboardText());
			/** 
			* Process custom arguments 
			*/
			result = this.ProcessCustomArgs(result);
			/**
			* Now let plugins process the arguments 
			*/
			TextEvent te = new TextEvent(EventType.ProcessArgs, result);
			Global.Plugins.NotifyPlugins(this, te);
			//
			return te.Text;
		}
		
	}
	
}
