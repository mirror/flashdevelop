using System;
using System.Text;
using System.Collections;
using System.Diagnostics;
using System.IO;
using WeifenLuo.WinFormsUI;
using PluginCore;

namespace ProjectExplorer.Actions
{
	/// <summary>
	/// Exposes methods for controlling FlashDevelop.
	/// </summary>
	public class FlashDevelopActions
	{
		static char sep = Path.DirectorySeparatorChar;

		IMainForm mainForm;

		public FlashDevelopActions(IMainForm mainForm)
		{
			this.mainForm = mainForm;
		}

		public void CloseDocument(string path)
		{
			foreach (DockContent document in mainForm.GetDocuments())
			{
				if (document.Controls.Count == 0) continue;
				string docPath = mainForm.GetSciControl(document).FileName;
				if (docPath == null) continue;

				// in case "path" is a directory, this method will close all open
				// file inside that directory, since they no longer exist
				if (docPath == path || docPath.StartsWith(path+sep))
					document.Close();
			}
		}

		// update any documents open in the editor with this change
		public void MoveDocument(string oldPath, string newPath)
		{
			ScintillaNet.ScintillaControl sci;
			foreach (DockContent document in mainForm.GetDocuments())
			{
				if (document.Controls.Count < 1) continue;
				sci = mainForm.GetSciControl(document);
				string path = sci.FileName;

				if (path == oldPath)
				{
					bool hasStar = document.Text.IndexOf("*") > -1;
					sci.FileName = newPath;
					document.Text = Path.GetFileName(newPath);

					if (hasStar) document.Text += "*";
				}
				else if (path.StartsWith(oldPath+sep)) // you renamed a directory
				{
					string endPart = path.Substring(oldPath.Length);
					string docPath = newPath+endPart;
					sci.FileName = docPath;
				}
			}
		}
		
		/**
		* Mika: extra methods added
		*/ 
		public Encoding GetDefaultEncoding()
		{
			int codepage = mainForm.MainSettings.GetInt("FlashDevelop.DefaultCodePage");
			return Encoding.GetEncoding(codepage);
			
		}
		public string GetDefaultEOLMarker()
		{
			int eolMode = mainForm.MainSettings.GetInt("FlashDevelop.EOLMode");
			return mainForm.GetNewLineMarker(eolMode);
			
		}
		
	}
	
}
