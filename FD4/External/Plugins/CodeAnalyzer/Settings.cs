using System;
using System.IO;
using System.Text;
using System.Collections;
using System.ComponentModel;
using System.Drawing.Design;
using System.Collections.Generic;
using System.Windows.Forms.Design;
using System.Xml.Serialization;
using PluginCore.Localization;
using System.Windows.Forms;
using PluginCore.Managers;
using PluginCore;

namespace CodeAnalyzer
{
	[Serializable]
	public class Settings
	{
        private String pmdRuleset = String.Empty;
        private Keys analyzeShortcut = Keys.None;
        
        /// <summary>
        /// Get and sets the ruleset file
        /// </summary>
		[DisplayName("Default Ruleset File")]
        [LocalizedDescription("CodeAnalyzer.Description.PMDRuleset"), DefaultValue("")]
		[Editor(typeof(FileNameEditor), typeof(UITypeEditor))]
        public String PMDRuleset
		{
			get { return pmdRuleset; }
            set { pmdRuleset = value; }
		}
		
		/// <summary>
		/// Get and sets the shortcut
		/// </summary>
        [LocalizedDescription("CodeAnalyzer.Description.AnalyzeShortcut")]
        [DisplayName("Analyze Project Shortcut"), DefaultValue(Keys.None)]
        public Keys AnalyzeShortcut
		{
            get { return this.analyzeShortcut; }
            set { this.analyzeShortcut = value; }
		}

	}

}
