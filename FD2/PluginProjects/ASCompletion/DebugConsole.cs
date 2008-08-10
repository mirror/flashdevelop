/*
 * Output debug messages to the output panel
 */

using System;
using PluginCore;

namespace ASCompletion
{
	public class DebugConsole
	{
		static readonly private string SETTING_DEBUG = "ASCompletion.EnableDebugging";
		
		[System.Diagnostics.Conditional("DEBUG")] 
		static public void Trace(object value)
		{
			try
			{
				if (ASContext.Panel.checkBoxDebug.Checked)
					ASContext.MainForm.AddTraceLogEntry(value.ToString(), 1);
			}
			catch {}
		}
		
		[System.Diagnostics.Conditional("DEBUG")] 
		static public void CheckSettings()
		{
			if (!ASContext.MainForm.MainSettings.HasKey(SETTING_DEBUG))
				ASContext.MainForm.MainSettings.AddValue(SETTING_DEBUG, "false");
		}

		[System.Diagnostics.Conditional("DEBUG")] 
		static public void SettingsChanged()
		{
			ASContext.Panel.panelDebug.Visible = ASContext.MainForm.MainSettings.GetBool(SETTING_DEBUG);
		}
	}
}
