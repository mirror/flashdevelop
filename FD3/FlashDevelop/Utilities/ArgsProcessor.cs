using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Windows.Forms;
using FlashDevelop.Settings;
using PluginCore.Utilities;
using FlashDevelop.Managers;
using PluginCore.Managers;
using PluginCore.Helpers;
using ScintillaNet;
using PluginCore;
using System.Text.RegularExpressions;

namespace FlashDevelop.Utilities
{
	public class ArgsProcessor
	{
        /// <summary>
        /// Regexes for tab and var replacing
        /// </summary>
        private static Regex reTabs = new Regex("^\\t+", RegexOptions.Multiline | RegexOptions.Compiled);
        private static Regex reArgs = new Regex("\\$\\(([a-z]+)\\)", RegexOptions.IgnoreCase | RegexOptions.Compiled);

        /// <summary>
        /// Gets the FlashDevelop root directory
		/// </summary>
        private static String GetAppDir()
		{
			return PathHelper.AppDir;
		}

        /// <summary>
        /// Gets the users FlashDevelop directory
        /// </summary>
        private static String GetUserAppDir()
        {
            return PathHelper.UserAppDir;
        }

        /// <summary>
        /// Gets the data file directory
        /// </summary>
        private static String GetBaseDir()
        {
            return PathHelper.BaseDir;
        }

		/// <summary>
		/// Gets the selected text
		/// </summary>
        private static String GetSelText()
		{
            if (!Globals.CurrentDocument.IsEditable)
            {
                return String.Empty;
            }
            return Globals.SciControl.SelText;
		}
		
		/// <summary>
		/// Gets the current file
		/// </summary>
        private static String GetCurFile()
		{
            if (!Globals.CurrentDocument.IsEditable)
            {
                return String.Empty;
            }
            return Globals.CurrentDocument.FileName;
		}

		/// <summary>
		/// Gets the current file's path or last active path
		/// </summary>
        private static String GetCurDir()
		{
            if (!Globals.CurrentDocument.IsEditable)
            {
                return Globals.MainForm.WorkingDirectory;
            }
            return Path.GetDirectoryName(GetCurFile());
		}
		
		/// <summary>
		/// Gets the name of the current file
		/// </summary>
        private static String GetCurFilename()
		{
            if (!Globals.CurrentDocument.IsEditable)
            {
                return String.Empty;
            }
            return Path.GetFileName(GetCurFile());
		}

        /// <summary>
        /// Gets the timestamp
        /// </summary>
        private static String GetTimestamp()
        {
            return DateTime.Now.ToString("g");
        }

		/// <summary>
		/// Gets the current word
		/// </summary>
        private static String GetCurWord()
		{
            if (!Globals.CurrentDocument.IsEditable)
            {
                return String.Empty;
            }
            ScintillaControl sci = Globals.SciControl;
            String curWord = sci.GetWordFromPosition(sci.CurrentPos);
			if (curWord != null) return curWord;
			else return String.Empty;
		}
		
		/// <summary>
		/// Gets the desktop path
		/// </summary>
        private static String GetDesktopDir()
		{
			return Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
		}
		
		/// <summary>
		/// Gets the system path
		/// </summary>
        private static String GetSystemDir()
		{
			return Environment.GetFolderPath(Environment.SpecialFolder.System);
		}
		
		/// <summary>
		/// Gets the program files path
		/// </summary>
        private static String GetProgramsDir()
		{
			return Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles);
		}
		
		/// <summary>
		/// Gets the users personal files path
		/// </summary>
        private static String GetPersonalDir()
		{
			return Environment.GetFolderPath(Environment.SpecialFolder.Personal);
		}
		
		/// <summary>
		/// Gets the working directory
		/// </summary>
        public static String GetWorkingDir()
		{
            return Globals.MainForm.WorkingDirectory;
		}
		
		/// <summary>
		/// Gets the user selected file for opening
		/// </summary>
        private static String GetOpenFile()
		{
			OpenFileDialog ofd = new OpenFileDialog();
			ofd.InitialDirectory = GetCurDir();
			ofd.Multiselect = false;
            if (ofd.ShowDialog(Globals.MainForm) == DialogResult.OK)
			{
				return ofd.FileName;
			}
            else return String.Empty;
		}
		
		/// <summary>
		/// Gets the user selected file for saving
		/// </summary>
        private static String GetSaveFile()
		{
			SaveFileDialog sfd = new SaveFileDialog();
			sfd.InitialDirectory = GetCurDir();
            if (sfd.ShowDialog(Globals.MainForm) == DialogResult.OK)
			{
				return sfd.FileName;
			}
            else return String.Empty;
		}
		
		/// <summary>
		/// Gets the user selected folder
		/// </summary>
		private static String GetOpenDir()
		{
			FolderBrowserDialog fbd = new FolderBrowserDialog();
            fbd.RootFolder = Environment.SpecialFolder.MyComputer;
            if (fbd.ShowDialog(Globals.MainForm) == DialogResult.OK)
			{
				return fbd.SelectedPath;
			}
            else return String.Empty;
		}
		
		/// <summary>
		/// Gets the clipboard text
		/// </summary>
		private static String GetClipboard()
		{
			IDataObject cbdata = Clipboard.GetDataObject();
			if (cbdata.GetDataPresent("System.String", true)) 
			{
				return cbdata.GetData("System.String", true).ToString();
			}
            else return String.Empty;
		}

        /// <summary>
        /// Gets the correct coding style line break chars
        /// </summary>
        public static String ProcessCodeStyleLineBreaks(String text)
        {
            String CSLB = "$(CSLB)";
            Int32 nextIndex = text.IndexOf(CSLB);
            if (nextIndex < 0) return text;
            CodingStyle cs = Globals.Settings.CodingStyle;
            if (cs == CodingStyle.BracesOnLine) return text.Replace(CSLB, "");
            Int32 eolMode = (Int32)Globals.Settings.EOLMode;
            String lineBreak = LineEndDetector.GetNewLineMarker(eolMode);
            String result = ""; Int32 currentIndex = 0;
            while (nextIndex >= 0)
            {
                result += text.Substring(currentIndex, nextIndex - currentIndex) + lineBreak + GetLineIndentation(text, nextIndex);
                currentIndex = nextIndex + CSLB.Length;
                nextIndex = text.IndexOf(CSLB, currentIndex);
            }
            return result + text.Substring(currentIndex);
        }

        /// <summary>
        /// Gets the line intendation from the text
        /// </summary>
        private static String GetLineIndentation(String text, Int32 position)
        {
            Char c;
            Int32 startPos = position;
            while (startPos > 0)
            {
                c = text[startPos];
                if (c == 10 || c == 13) break;
                startPos--;
            }
            Int32 endPos = ++startPos;
            while (endPos < position)
            {
                c = text[endPos];
                if (c != '\t' && c != ' ') break;
                endPos++;
            }
            return text.Substring(startPos, endPos-startPos);
        }

		/// <summary>
		/// Processes the argument String variables
		/// </summary>
		public static String ProcessString(String args, Boolean dispatch)
		{
            try
            {
                String result = args;
                if (result == null) return String.Empty;
                result = ProcessCodeStyleLineBreaks(result);
                if (!Globals.Settings.UseTabs) result = reTabs.Replace(result, new MatchEvaluator(ReplaceTabs));
                result = reArgs.Replace(result, new MatchEvaluator(ReplaceVars));
                if (!dispatch || result.IndexOf('$') < 0) return result;
                TextEvent te = new TextEvent(EventType.ProcessArgs, result);
                EventManager.DispatchEvent(Globals.MainForm, te);
                return te.Value;
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return String.Empty;
            }
		}

        /// <summary>
        /// Match evaluator for tabs
        /// </summary>
        private static String ReplaceTabs(Match match)
        {
            return new String(' ', match.Length * Globals.Settings.IndentSize);
        }
        
        /// <summary>
        /// Match evaluator for vars
        /// </summary>
        private static String ReplaceVars(Match match)
        {
            if (match.Groups.Count > 0)
            {
                string name = match.Groups[1].Value;
                switch (name)
                {
                    case "Quote": return "\"";
                    case "AppDir": return GetAppDir();
                    case "UserAppDir": return GetUserAppDir();
                    case "BaseDir": return GetBaseDir();
                    case "SelText": return GetSelText();
                    case "CurFilename": return GetCurFilename();
                    case "CurFile": return GetCurFile();
                    case "CurDir": return GetCurDir();
                    case "CurWord": return GetCurWord();
                    case "Timestamp": return GetTimestamp();
                    case "OpenFile": return GetOpenFile();
                    case "SaveFile": return GetSaveFile();
                    case "OpenDir": return GetOpenDir();
                    case "DesktopDir": return GetDesktopDir();
                    case "SystemDir": return GetSystemDir();
                    case "ProgramsDir": return GetProgramsDir();
                    case "PersonalDir": return GetPersonalDir();
                    case "WorkingDir": return GetWorkingDir();
                    case "Clipboard": return GetClipboard();
                }
                foreach (Argument arg in Globals.Settings.CustomArguments)
                {
                    if (name == arg.Key) return arg.Value;
                }
                return "$(" + name + ")";
            }
            else return match.Value;
        }

	}
	
}
