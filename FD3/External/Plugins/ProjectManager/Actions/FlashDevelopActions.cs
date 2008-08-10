using System;
using System.IO;
using System.Text;
using System.Collections;
using System.Diagnostics;
using WeifenLuo.WinFormsUI;
using PluginCore.Utilities;
using PluginCore;

namespace ProjectManager.Actions
{
	public class FlashDevelopActions
	{
        private IMainForm mainForm;

		public FlashDevelopActions(IMainForm mainForm)
		{
			this.mainForm = mainForm;
		}
		
		public Encoding GetDefaultEncoding()
		{
            return Encoding.GetEncoding((Int32)mainForm.Settings.DefaultCodePage);
		}

		public string GetDefaultEOLMarker()
		{
            return LineEndDetector.GetNewLineMarker((Int32)mainForm.Settings.EOLMode);
		}
	}
}
