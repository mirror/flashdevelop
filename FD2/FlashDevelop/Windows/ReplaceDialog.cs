using System;
using System.Drawing;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using FlashDevelop.Utilities;
using ScintillaNet;
using PluginCore;

namespace FlashDevelop.Windows
{
	public class ReplaceDialog : System.Windows.Forms.Form
	{		
		private System.Windows.Forms.CheckBox useRegexCheckBox;
		private System.Windows.Forms.CheckBox multilineCheckBox;
		private System.Windows.Forms.Button replaceButton;
		private System.Windows.Forms.GroupBox optionsGroupBox;
		private System.Windows.Forms.Button findPrevButton;
		private System.Windows.Forms.Button replaceAllButton;
		private System.Windows.Forms.ComboBox findComboBox;
		private System.Windows.Forms.ComboBox replaceComboBox;
		private System.Windows.Forms.Button closeButton;
		private System.Windows.Forms.CheckBox wholeWordCheckBox;
		private System.Windows.Forms.Button findNextButton;
		private System.Windows.Forms.Label infoLabel;
		private System.Windows.Forms.PictureBox infoPictureBox;
		private System.Windows.Forms.CheckBox matchCaseCheckBox;
		private System.Windows.Forms.Label replaceLabel;
		private System.Windows.Forms.Label findLabel;
		private FlashDevelop.MainForm mainForm;
		private MatchCollection results;
		private Match previousMatch;
		
		public ReplaceDialog(MainForm mainForm)
		{
			this.mainForm = mainForm;
			this.InitializeComponent();
			this.Owner = mainForm;
			this.ShowMessage("No results available.", 0);
		}
		
		#region Windows Forms Designer generated code
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			this.findLabel = new System.Windows.Forms.Label();
			this.replaceLabel = new System.Windows.Forms.Label();
			this.matchCaseCheckBox = new System.Windows.Forms.CheckBox();
			this.infoPictureBox = new System.Windows.Forms.PictureBox();
			this.infoLabel = new System.Windows.Forms.Label();
			this.findNextButton = new System.Windows.Forms.Button();
			this.wholeWordCheckBox = new System.Windows.Forms.CheckBox();
			this.closeButton = new System.Windows.Forms.Button();
			this.replaceComboBox = new System.Windows.Forms.ComboBox();
			this.findComboBox = new System.Windows.Forms.ComboBox();
			this.replaceAllButton = new System.Windows.Forms.Button();
			this.findPrevButton = new System.Windows.Forms.Button();
			this.optionsGroupBox = new System.Windows.Forms.GroupBox();
			this.replaceButton = new System.Windows.Forms.Button();
			this.multilineCheckBox = new System.Windows.Forms.CheckBox();
			this.useRegexCheckBox = new System.Windows.Forms.CheckBox();
			this.optionsGroupBox.SuspendLayout();
			this.SuspendLayout();
			// 
			// findLabel
			// 
			this.findLabel.Location = new System.Drawing.Point(30, 18);
			this.findLabel.Name = "findLabel";
			this.findLabel.Size = new System.Drawing.Size(29, 14);
			this.findLabel.TabIndex = 0;
			this.findLabel.Text = "Find:";
			// 
			// replaceLabel
			// 
			this.replaceLabel.Location = new System.Drawing.Point(12, 48);
			this.replaceLabel.Name = "replaceLabel";
			this.replaceLabel.Size = new System.Drawing.Size(47, 14);
			this.replaceLabel.TabIndex = 3;
			this.replaceLabel.Text = "Replace:";
			// 
			// matchCaseCheckBox
			// 
			this.matchCaseCheckBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.matchCaseCheckBox.Location = new System.Drawing.Point(17, 15);
			this.matchCaseCheckBox.Name = "matchCaseCheckBox";
			this.matchCaseCheckBox.Size = new System.Drawing.Size(87, 24);
			this.matchCaseCheckBox.TabIndex = 1;
			this.matchCaseCheckBox.Text = " Match &Case";
			// 
			// infoPictureBox
			// 
			this.infoPictureBox.BackColor = System.Drawing.SystemColors.Control;
			this.infoPictureBox.Location = new System.Drawing.Point(31, 148);
			this.infoPictureBox.Name = "infoPictureBox";
			this.infoPictureBox.Size = new System.Drawing.Size(10, 10);
			this.infoPictureBox.TabIndex = 15;
			this.infoPictureBox.TabStop = false;
			// 
			// infoLabel
			// 
			this.infoLabel.Location = new System.Drawing.Point(45, 146);
			this.infoLabel.Name = "infoLabel";
			this.infoLabel.Size = new System.Drawing.Size(238, 14);
			this.infoLabel.TabIndex = 13;
			this.infoLabel.Text = "No suitable result found.";
			// 
			// findNextButton
			// 
			this.findNextButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.findNextButton.Location = new System.Drawing.Point(295, 14);
			this.findNextButton.Name = "findNextButton";
			this.findNextButton.TabIndex = 4;
			this.findNextButton.Text = "Find &Next";
			this.findNextButton.Click += new System.EventHandler(this.FindButtonClick);
			// 
			// wholeWordCheckBox
			// 
			this.wholeWordCheckBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.wholeWordCheckBox.Location = new System.Drawing.Point(17, 36);
			this.wholeWordCheckBox.Name = "wholeWordCheckBox";
			this.wholeWordCheckBox.Size = new System.Drawing.Size(87, 24);
			this.wholeWordCheckBox.TabIndex = 2;
			this.wholeWordCheckBox.Text = " &Whole Word";
			// 
			// closeButton
			// 
			this.closeButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.closeButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.closeButton.Location = new System.Drawing.Point(295, 134);
			this.closeButton.Name = "closeButton";
			this.closeButton.TabIndex = 8;
			this.closeButton.Text = "&Close";
			this.closeButton.Click += new System.EventHandler(this.CloseButtonClick);
			// 
			// replaceComboBox
			// 
			this.replaceComboBox.Location = new System.Drawing.Point(60, 45);
			this.replaceComboBox.Name = "replaceComboBox";
			this.replaceComboBox.Size = new System.Drawing.Size(225, 21);
			this.replaceComboBox.TabIndex = 2;
			// 
			// findComboBox
			// 
			this.findComboBox.Location = new System.Drawing.Point(60, 15);
			this.findComboBox.Name = "findComboBox";
			this.findComboBox.Size = new System.Drawing.Size(225, 21);
			this.findComboBox.TabIndex = 1;
			// 
			// replaceAllButton
			// 
			this.replaceAllButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.replaceAllButton.Location = new System.Drawing.Point(295, 104);
			this.replaceAllButton.Name = "replaceAllButton";
			this.replaceAllButton.TabIndex = 7;
			this.replaceAllButton.Text = "Replace &All";
			this.replaceAllButton.Click += new System.EventHandler(this.ReplaceAllButtonClick);
			// 
			// findPrevButton
			// 
			this.findPrevButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.findPrevButton.Location = new System.Drawing.Point(296, 44);
			this.findPrevButton.Name = "findPrevButton";
			this.findPrevButton.TabIndex = 5;
			this.findPrevButton.Text = "Find &Prev";
			this.findPrevButton.Click += new System.EventHandler(this.FindButtonClick);
			// 
			// optionsGroupBox
			// 
			this.optionsGroupBox.Controls.Add(this.useRegexCheckBox);
			this.optionsGroupBox.Controls.Add(this.wholeWordCheckBox);
			this.optionsGroupBox.Controls.Add(this.matchCaseCheckBox);
			this.optionsGroupBox.Controls.Add(this.multilineCheckBox);
			this.optionsGroupBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.optionsGroupBox.Location = new System.Drawing.Point(29, 74);
			this.optionsGroupBox.Name = "optionsGroupBox";
			this.optionsGroupBox.Size = new System.Drawing.Size(256, 65);
			this.optionsGroupBox.TabIndex = 3;
			this.optionsGroupBox.TabStop = false;
			this.optionsGroupBox.Text = " Options";
			// 
			// replaceButton
			// 
			this.replaceButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.replaceButton.Location = new System.Drawing.Point(295, 74);
			this.replaceButton.Name = "replaceButton";
			this.replaceButton.TabIndex = 6;
			this.replaceButton.Text = "&Replace";
			this.replaceButton.Click += new System.EventHandler(this.ReplaceButtonClick);
			// 
			// multilineCheckBox
			// 
			this.multilineCheckBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.multilineCheckBox.Location = new System.Drawing.Point(110, 36);
			this.multilineCheckBox.Name = "multilineCheckBox";
			this.multilineCheckBox.Size = new System.Drawing.Size(125, 24);
			this.multilineCheckBox.TabIndex = 4;
			this.multilineCheckBox.Text = " &Multiline Mode";
			// 
			// useRegexCheckBox
			// 
			this.useRegexCheckBox.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.useRegexCheckBox.Location = new System.Drawing.Point(110, 15);
			this.useRegexCheckBox.Name = "useRegexCheckBox";
			this.useRegexCheckBox.Size = new System.Drawing.Size(125, 24);
			this.useRegexCheckBox.TabIndex = 3;
			this.useRegexCheckBox.Text = " &Regular Expressions";
			// 
			// ReplaceDialog
			// 
			this.AcceptButton = this.findNextButton;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.CancelButton = this.closeButton;
			this.ClientSize = new System.Drawing.Size(386, 173);
			this.Controls.Add(this.infoPictureBox);
			this.Controls.Add(this.infoLabel);
			this.Controls.Add(this.optionsGroupBox);
			this.Controls.Add(this.findPrevButton);
			this.Controls.Add(this.replaceAllButton);
			this.Controls.Add(this.replaceButton);
			this.Controls.Add(this.replaceLabel);
			this.Controls.Add(this.replaceComboBox);
			this.Controls.Add(this.closeButton);
			this.Controls.Add(this.findLabel);
			this.Controls.Add(this.findComboBox);
			this.Controls.Add(this.findNextButton);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "ReplaceDialog";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = " Replace";
			this.Closing += new System.ComponentModel.CancelEventHandler(this.ReplaceDialogClosing);
			this.VisibleChanged += new System.EventHandler(this.OnVisibleChanged);
			this.optionsGroupBox.ResumeLayout(false);
			this.ResumeLayout(false);
		}
		
		#endregion
		
		#region MethodsAndEventHandlers
		
		/**
		* Shows the info message in dialog
		*/ 
		public void ShowMessage(string msg, int img)
		{
			System.Drawing.Image image;
			if (img == 1) image = (Image)this.mainForm.Resources.GetObject("Images.DialogWarning");
			else if (img == 2) image = (Image)this.mainForm.Resources.GetObject("Images.DialogError");
			else image = (Image)this.mainForm.Resources.GetObject("Images.DialogInfo");
			this.infoPictureBox.Image = image;
			this.infoLabel.Text = msg;
		}
		
		/**
		* Some event handling when showing the form
		*/
		public void OnVisibleChanged(object sender, System.EventArgs e)
		{
			if (this.Visible)
			{
				this.CenterToParent();
				this.ReplaceDialogLoad();
			}
		}
		
		/**
		* If there is a word selected, insert it to the find box
		*/
		public void ReplaceDialogLoad()
		{
			ScintillaControl sci = this.mainForm.CurSciControl;
			if (sci.SelText.Length>0)
			{
				this.findComboBox.Text = this.mainForm.CurSciControl.SelText;
				this.replaceComboBox.Select();
				this.replaceComboBox.SelectAll();
			} 
			else 
			{
				this.SelectText();
			}
		}
		
		/**
		* Resets the find results
		*/
		public void ResetResults()
		{
			this.results = null;
			this.ShowMessage("No results available.", 0);
		}
		
		/**
		* Adds the item to findComboBox items
		*/
		public void AddToFindItems(string val)
		{
			if (!this.findComboBox.Items.Contains((string)val))
			{
				this.findComboBox.Items.Insert(0, val);
				this.findComboBox.SelectedIndex = 0;
			}
		}
		
		/**
		* Adds the item to replaceComboBox items
		*/
		public void AddToReplaceItems(string val)
		{
			if (!this.replaceComboBox.Items.Contains((string)val))
			{
				this.replaceComboBox.Items.Insert(0, val);
				this.replaceComboBox.SelectedIndex = 0;
			}
		}
		
		/**
		* Selects the text in the textfield.
		*/
		public void SelectText()
		{
			this.findComboBox.Select();
			this.findComboBox.SelectAll();
		}
		
		/**
		* Parses the data for the Regex search
		*/
		public string GetFindText()
		{
			string pattern = this.findComboBox.Text;
			//
			if (!this.useRegexCheckBox.Checked)
			{
				pattern = Regex.Escape(pattern);
			}
			if (this.wholeWordCheckBox.Checked)
			{
				pattern = "(?<!\\w)"+pattern+"(?!\\w)";
			}
			return pattern;
		}
				
		/**
		* Parses the data for the Regex search
		*/
		public string GetReplaceText()
		{
			return this.replaceComboBox.Text;
		}
		
		/**
		* Retrives the Regex options
		*/
		public RegexOptions GetOptions()
		{
			RegexOptions options = RegexOptions.None;
			if (!this.matchCaseCheckBox.Checked)
			{
				options |= RegexOptions.IgnoreCase;
			}
			if (this.multilineCheckBox.Checked)
			{
				options |= RegexOptions.Multiline;
			}
			return options;
		}
		
		/**
		* Finds the next result based on current position
		*/
		public Match GetNearestResult(int curPos, bool dirForward)
		{
			ScintillaControl sci = this.mainForm.CurSciControl;
			if (this.results.Count > 0)
			{
				Match nearestMatch = this.results[0];
				for (int i = 0; i<this.results.Count; i++)
				{
					Match result = this.results[i];
					if (!dirForward && sci.MBSafePosition(result.Index) > sci.MBSafePosition(nearestMatch.Index) && sci.MBSafePosition(result.Index)+sci.MBSafeTextLength(result.Value) < curPos)
					{
						nearestMatch = result;
					}
					else if (dirForward && sci.MBSafePosition(result.Index) > curPos)
					{
						this.previousMatch = result;
						return this.previousMatch;
					}
					else if (dirForward && i == this.results.Count-1)
					{
						this.previousMatch = this.results[0];
						return this.previousMatch;
					}
				}
				if (!dirForward && previousMatch.Index == nearestMatch.Index)
				{
					this.previousMatch = this.results[this.results.Count-1];
					return this.previousMatch;
				}
				this.previousMatch = nearestMatch;
				return this.previousMatch;
			}
			return null;
		}
		
		/**
		* Gets the index number of the Match
		*/
		public int GetMatchIndex(Match match)
		{
			for (int i = 0; i<this.results.Count; i++)
			{
				if (match == this.results[i])
				{
					return i+1;
				}
			}
			return -1;
		}
		
		/**
		* Selects the current correct result
		*/
		public void ShowCorrectResult(bool dirForward)
		{
			ScintillaControl sci = this.mainForm.CurSciControl;
			if (!dirForward && sci.SelText.Length>0)
			{
				sci.CurrentPos = sci.CurrentPos-sci.MBSafeTextLength(sci.SelText)+2;
			}
			Match match = this.GetNearestResult(sci.CurrentPos-1, dirForward);
			if (match != null)
			{
				int pos = sci.MBSafePosition(match.Index);
				this.AddToFindItems(this.findComboBox.Text);
				sci.EnsureVisible(sci.LineFromPosition(pos));
				sci.MBSafeSetSel(match.Index, match.Value);
				this.ShowMessage("Showing result "+this.GetMatchIndex(match)+" of "+this.results.Count+".", 0);
				return;
			}
			this.ShowMessage("No results found.", 0);
		}
		
		/**
		* Finds the next result specified by user input
		*/
		public void FindButtonClick(object sender, System.EventArgs e)
		{
			try 
			{
				ScintillaControl sci = this.mainForm.CurSciControl;
				if (this.findComboBox.Text != "")
				{
					this.results = Regex.Matches(sci.Text, this.GetFindText(), this.GetOptions());
					this.ShowCorrectResult(true);
					this.SelectText();
				}
			} 
			catch
			{
				this.ShowMessage("Error while running find.", 2);
			}
		}
		
		/**
		* Finds the next result specified by user input
		*/
		public void FindNextButtonClick(object sender, System.EventArgs e)
		{
			try 
			{
				ScintillaControl sci = this.mainForm.CurSciControl;
				if (this.findComboBox.Text != "")
				{
					this.results = Regex.Matches(sci.Text, this.GetFindText(), this.GetOptions());
					this.ShowCorrectResult(true);
					this.SelectText();
				}
			}
			catch
			{
				this.ShowMessage("Error while running find next.", 2);
			}
		}
		
		/**
		* Finds the previous result specified by user input
		*/
		public void FindPrevButtonClick(object sender, System.EventArgs e)
		{
			try 
			{
				ScintillaControl sci = this.mainForm.CurSciControl;
				if (this.findComboBox.Text != "")
				{
					this.results = Regex.Matches(sci.Text, this.GetFindText(), this.GetOptions());
					this.ShowCorrectResult(false);
					this.SelectText();
				}
			}
			catch
			{
				this.ShowMessage("Error while running find previous.", 2);
			}
		}
		
		/**
		* Replaces the next result specified by user input
		*/
		public void ReplaceButtonClick(object sender, System.EventArgs e)
		{
			try 
			{
				ScintillaControl sci = this.mainForm.CurSciControl;
				this.results = Regex.Matches(sci.Text, this.GetFindText(), this.GetOptions());
				if (sci.SelText.Length>0)
				{
					string replaceText = this.GetReplaceText();
					this.AddToReplaceItems(replaceText);
					sci.ReplaceSel(replaceText);
					this.ShowMessage("Replace was completed successfully.", 0);
				} 
				else
				{
					Match result = this.GetNearestResult(sci.CurrentPos, true);
					if (result != null) 
					{
						sci.MBSafeSetSel(result.Index, result.Value);
					} 
					else 
					{
						this.ShowMessage("There are nothing to replace.", 0);
					}
				}
			}
			catch
			{
				this.ShowMessage("Error while running replace.", 2);
			}
		}
		
		/**
		* Replaces all results specified by user input
		*/
		public void ReplaceAllButtonClick(object sender, System.EventArgs e)
		{
			try 
			{
				ScintillaControl sci = this.mainForm.CurSciControl;
				int pointX = sci.PointXFromPosition(sci.CurrentPos);
				int pointY = sci.PointYFromPosition(sci.CurrentPos);
				sci.Text = Regex.Replace(sci.Text, this.GetFindText(), this.GetReplaceText());
				this.ShowMessage("Replace all was completed successfully.", 0);
				int position = sci.PositionFromPoint(pointX, pointY);
				string replaceText = this.GetReplaceText();
				this.AddToReplaceItems(replaceText);
				sci.SetSel(position, position);
			} 
			catch
			{
				this.ShowMessage("Error while running replace all.", 2);
			}
		}
				
		/**
		* Closes the find dialog
		*/
		public void CloseButtonClick(object sender, System.EventArgs e)
		{
			this.Close();
		}
		
		/**
		* Hides only the dialog when user closes it
		*/
		private void ReplaceDialogClosing(object sender, System.ComponentModel.CancelEventArgs e)
		{
			e.Cancel = true;
			this.mainForm.CurSciControl.Focus();
			this.Hide();
		}
		
		#endregion
		
	}
	
}
