using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using PluginCore.Managers;
using System.Collections;
using EnhancedArguments.Controls;

namespace EnhancedArguments.Dialogs
{
	public partial class ReplaceVariablesDialog : Form
	{
		private static Regex reArg;
		Dictionary<String, String> argDictionary = new Dictionary<string, string>();
		public String text = "";

		public ReplaceVariablesDialog(String s, Regex reg)
		{
			text = s;
			reArg = reg;

			InitializeComponent();
			BuildInterface(s);
			if (argPanel.Controls.Count == 0) Close();
		}

        /// <summary>
        /// Create arg editor controls to edit arguments
        /// </summary>
		private void BuildInterface(string s)
		{
			Match match = reArg.Match(text);
			ArgEditor ae;
			String arg;
			String value;

			while (match.Success)
			{
				arg = match.Groups[1].Value;
				if(!argPanel.Controls.ContainsKey(arg))
				{
					value = "";
					if (match.Groups.Count == 3) value = match.Groups[2].Value;
                    ae = new ArgEditor(arg, value.Split(",".ToCharArray()));
					ae.Name = arg;
					argPanel.Controls.Add(ae);
				}
				match = match.NextMatch();
			}
		}

        /// <summary>
        /// Build argDictionary for arg/value lookup
        /// </summary>
		private void BuildDictionary()
		{
			ArgEditor ae;
			foreach (Control c in argPanel.Controls)
			{
				ae = c as ArgEditor;
				argDictionary.Add(ae.Arg, ae.Value);
			}
		}

        /// <summary>
        /// Accept Dialog
        /// </summary>
        private void ok_Click(object sender, EventArgs e)
        {
            //text = reEnhancedArgs.Replace(text, new MatchEvaluator(ReplaceVars));
            BuildDictionary();
            Close();
        }

        /// <summary>
        /// Cancel Dialog
        /// </summary>
		private void cancel_Click(object sender, EventArgs e)
		{
			text = null;
			Close();
		}

        /// <summary>
        /// Select first arg editor when form recieves focus
        /// </summary>
		private void ReplaceVariablesDialog_Activated(object sender, EventArgs e)
		{
			argPanel.Controls[0].Focus();
		}

		/// <summary>
		/// Returns Dictionary of the Arguments and Values
		/// </summary>
		public Dictionary<String, String> ArgDictionary
		{
			get { return argDictionary; }
		}
	}
}
