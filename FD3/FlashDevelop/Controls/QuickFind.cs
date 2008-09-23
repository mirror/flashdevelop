using System;
using System.Text;
using System.Media;
using System.Drawing;
using System.Collections;
using System.Windows.Forms;
using System.Drawing.Drawing2D;
using System.Collections.Generic;
using PluginCore.Localization;
using FlashDevelop.Utilities;
using FlashDevelop.Helpers;
using FlashDevelop.Docking;
using PluginCore.FRService;
using PluginCore.Managers;
using PluginCore.Utilities;
using ScintillaNet;
using PluginCore;

namespace FlashDevelop.Controls
{
    public class QuickFind : ToolStrip, IEventHandler
    {
        private Timer highlightTimer;
        private CheckBox highlightCheckBox;
        private CheckBox matchCaseCheckBox;
        private ToolStripButton nextButton;
        private ToolStripButton closeButton;
        private ToolStripControlHost matchCaseHost;
        private ToolStripControlHost highlightHost;
        private ToolStripButton previousButton;
        private EscapeTextBox findTextBox;
        private ToolStripLabel findLabel;
        private Timer typingTimer;

        public QuickFind()
        {
            this.Font = Globals.Settings.DefaultFont;
            this.InitializeComponent();
            this.InitializeEvents();
            this.InitializeTimers();
        }

        #region Internal Events

        /// <summary>
        /// Initializes the internals events
        /// </summary>
        private void InitializeEvents()
        {
            EventManager.AddEventHandler(this, EventType.FileSwitch);
        }

        /// <summary>
        /// Handles the internal events
        /// </summary>
        public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority priority)
        {
            this.ApplyFixedDocumentPadding();
        }

        #endregion

        #region Initialize Component

        public void InitializeComponent()
        {
            this.highlightTimer = new Timer();
            this.matchCaseCheckBox = new CheckBox();
            this.highlightCheckBox = new CheckBox();
            this.nextButton = new ToolStripButton();
            this.closeButton = new ToolStripButton();
            this.highlightHost = new ToolStripControlHost(this.highlightCheckBox);
            this.matchCaseHost = new ToolStripControlHost(this.matchCaseCheckBox);
            this.previousButton = new ToolStripButton();
            this.findTextBox = new EscapeTextBox();
            this.findLabel = new ToolStripLabel();
            this.SuspendLayout();
            //
            // highlightTimer
            //
            this.highlightTimer = new Timer();
            this.highlightTimer.Interval = 500;
            this.highlightTimer.Enabled = false;
            this.highlightTimer.Tick += delegate { this.HighlightTimerTick(); };
            //
            // findLabel
            //
            this.findLabel.BackColor = Color.Transparent;
            this.findLabel.Text = TextHelper.GetString("Info.Find");
            this.findLabel.Margin = new Padding(0, 0, 0, 3);
            //
            // highlightCheckBox
            //
            this.highlightHost.Margin = new Padding(0, 2, 6, 1);
            this.highlightCheckBox.Text = TextHelper.GetString("Label.HighlightAll");
            this.highlightCheckBox.BackColor = Color.Transparent;
            this.highlightCheckBox.Click += new EventHandler(this.HighlightAllCheckBoxClick);
            //
            // matchCaseCheckBox
            //
            this.matchCaseHost.Margin = new Padding(0, 2, 6, 1);
            this.matchCaseCheckBox.Text = TextHelper.GetString("Label.MatchCase");
            this.matchCaseCheckBox.BackColor = Color.Transparent;
            //
            // nextButton
            //
            this.nextButton.DisplayStyle = ToolStripItemDisplayStyle.ImageAndText;
            this.nextButton.Image = Image.FromStream(ResourceHelper.GetStream("QuickFindNext.png"));
            this.nextButton.Click += new EventHandler(this.FindNextButtonClick);
            this.nextButton.Text = TextHelper.GetString("Label.Next");
            this.nextButton.Margin = new Padding(0, 1, 2, 2);
            //
            // previousButton
            //
            this.previousButton.DisplayStyle = ToolStripItemDisplayStyle.ImageAndText;
            this.previousButton.Image = Image.FromStream(ResourceHelper.GetStream("QuickFindPrev.png"));
            this.previousButton.Click += new EventHandler(this.FindPrevButtonClick);
            this.previousButton.Text = TextHelper.GetString("Label.Previous");
            this.previousButton.Margin = new Padding(0, 1, 7, 2);
            //
            // closeButton
            //
            this.closeButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            this.closeButton.Image = Image.FromStream(ResourceHelper.GetStream("QuickFindClose.png"));
            this.closeButton.Click += new EventHandler(this.CloseButtonClick);
            this.closeButton.Margin = new Padding(0, 1, 5, 2);
            //
            // findTextBox
            //
            this.findTextBox.Size = new Size(150, 21);
            this.findTextBox.KeyPress += new KeyPressEventHandler(this.FindTextBoxKeyPress);
            this.findTextBox.TextChanged += new EventHandler(this.FindTextBoxTextChanged);
            this.findTextBox.OnKeyEscape += new KeyEscapeEvent(this.FindTextBoxOnKeyEscape);
            this.findTextBox.Margin = new Padding(0, 1, 7, 2);
            //
            // QuickFind
            //
            this.Items.Add(this.closeButton);
            this.Items.Add(this.findLabel);
            this.Items.Add(this.findTextBox);
            this.Items.Add(this.nextButton);
            this.Items.Add(this.previousButton);
            this.Items.Add(this.matchCaseHost);
            this.Items.Add(this.highlightHost);
            this.GripStyle = ToolStripGripStyle.Hidden;
            this.Renderer = new QuickFindRenderer();
            this.Padding = new Padding(3, 4, 0, 3);
            this.Dock = DockStyle.Bottom;
            this.CanOverflow = false;
            this.Visible = false;
            this.ResumeLayout(false);
        }

        #endregion

        #region Methods And Event Handlers
        
        /// <summary>
        /// The document that contains this control
        /// </summary>
        public ITabbedDocument Document
        {
            get { return ((ITabbedDocument)this.Parent); }
        }

        /// <summary>
        /// Enables or disables controls
        /// </summary>
        public Boolean CanSearch
        {
            get { return this.findTextBox.Enabled; }
            set
            {
                this.nextButton.Enabled = value;
                this.previousButton.Enabled = value;
                this.matchCaseCheckBox.Enabled = value;
                this.highlightCheckBox.Enabled = value;
                this.findTextBox.Enabled = value;
            }
        }

        /// <summary>
        /// Initializes the timers used in the control.
        /// </summary>
        private void InitializeTimers()
        {
            this.typingTimer = new Timer();
            this.typingTimer.Tick += new EventHandler(this.TypingTimerTick);
            this.typingTimer.Interval = 500;
        }

        /// <summary>
        /// Set the text to search
        /// </summary>
        public void SetFindText(String text)
        {
            this.findTextBox.TextChanged -= new EventHandler(this.FindTextBoxTextChanged);
            this.findTextBox.Text = text; // Change the value...
            this.findTextBox.TextChanged += new EventHandler(this.FindTextBoxTextChanged);
        }

        /// <summary>
        /// Shows the quick find control
        /// </summary>
        public void ShowControl()
        {
            this.Show();
            this.UpdateFindText();
            this.ApplyFixedDocumentPadding();
            this.findTextBox.Focus();
            this.findTextBox.SelectAll();
        }

        /// <summary>
        /// Executes the search for next match
        /// </summary>
        public void FindNextButtonClick(Object sender, EventArgs e)
        {
            this.UpdateFindText();
            if (this.findTextBox.Text.Trim() != "")
            {
                this.FindNext(this.findTextBox.Text, false);
            }
        }

        /// <summary>
        /// Executes the search for previous match
        /// </summary>
        public void FindPrevButtonClick(Object sender, EventArgs e)
        {
            this.UpdateFindText();
            if (this.findTextBox.Text.Trim() != "")
            {
                this.FindPrev(this.findTextBox.Text, false);
            }
        }

        /// <summary>
        /// If there is a word selected, insert it to the find box
        /// </summary>
        private void UpdateFindText()
        {
            ScintillaControl sci = Globals.SciControl;
            if (sci != null && sci.SelText.Length > 0)
            {
                this.findTextBox.Text = sci.SelText;
            }
        }

        /// <summary>
        /// Text into the main search textbox has changed, then 
        /// process with find next occurrence of the word
        /// </summary>
        private void FindTextBoxTextChanged(Object sender, EventArgs e)
        {
            this.typingTimer.Stop();
            this.typingTimer.Start();
        }

        /// <summary>
        /// When the typing timer ticks update the search
        /// </summary>
        private void TypingTimerTick(Object sender, EventArgs e)
        {
            this.typingTimer.Stop();
            if (this.findTextBox.Text.Trim() != "")
            {
                this.FindCorrect(this.findTextBox.Text, this.highlightCheckBox.Checked);
            }
            Globals.MainForm.SetFindText(this, this.findTextBox.Text);
        }

        /// <summary>
        /// Escape key has been pressed into the toolstriptextbox then 
        /// assign the current focus to the current scintilla control
        /// </summary>
        private void FindTextBoxOnKeyEscape()
        {
            Globals.SciControl.Focus();
            this.CloseButtonClick(null, null);
        }

        /// <summary>
        /// Pressed key on the main textbox
        /// </summary>
        private void FindTextBoxKeyPress(Object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (Char)Keys.Return && this.findTextBox.Text.Trim() != "")
            {
                e.Handled = true;
                this.FindNext(this.findTextBox.Text, false);
            }
        }

        /// <summary>
        /// Timed highlight of all current items
        /// </summary>
        private void HighlightTimerTick()
        {
            this.highlightTimer.Stop();
            if (this.highlightTimer.Tag != null && this.highlightTimer.Tag is Hashtable)
            {
                try
                {
                    ScintillaControl sci = ((Hashtable)this.highlightTimer.Tag)["sci"] as ScintillaControl;
                    List<SearchMatch> matches = ((Hashtable)this.highlightTimer.Tag)["matches"] as List<SearchMatch>;
                    this.AddHighlights(sci, matches);
                }
                catch (Exception ex)
                {
                    ErrorManager.ShowError(ex);
                }
            }
        }

        /// <summary>
        /// Highlights or removes highlights for all results
        /// </summary>
        private void HighlightAllCheckBoxClick(Object sender, EventArgs e)
        {
            ScintillaControl sci = Globals.SciControl;
            if (this.highlightCheckBox.Checked)
            {
                if (this.findTextBox.Text.Trim() == "") return;
                List<SearchMatch> matches = this.GetResults(sci, this.findTextBox.Text);
                if (matches != null && matches.Count != 0)
                {
                    this.RemoveHighlights(sci);
                    if (this.highlightTimer.Enabled) this.highlightTimer.Stop();
                    if (this.highlightCheckBox.Checked) this.AddHighlights(sci, matches);
                }
            }
            else this.RemoveHighlights(sci);
        }

        /// <summary>
        /// Finds the correct match based on the current position
        /// </summary>
        private void FindCorrect(String text, Boolean refreshHighlights)
        {
            if (text == "") return;
            ScintillaControl sci = Globals.SciControl;
            this.findTextBox.BackColor = SystemColors.Window;
            List<SearchMatch> matches = this.GetResults(sci, text);
            if (matches != null && matches.Count != 0)
            {
                SearchMatch match = FRDialogGenerics.GetNextDocumentMatch(sci, matches, true, true);
                if (match != null) FRDialogGenerics.SelectMatch(sci, match);
                if (refreshHighlights) this.RefreshHighlights(sci, matches);
            }
            else this.findTextBox.BackColor = Color.Salmon;
        }

        /// <summary>
        /// Finds the next match based on the current position
        /// </summary>
        private void FindNext(String text, Boolean refreshHighlights)
        {
            if (text == "") return;
            ScintillaControl sci = Globals.SciControl;
            this.findTextBox.BackColor = SystemColors.Window;
            List<SearchMatch> matches = this.GetResults(sci, text);
            if (matches != null && matches.Count != 0)
            {
                SearchMatch match = FRDialogGenerics.GetNextDocumentMatch(sci, matches, true, false);
                if (match != null) FRDialogGenerics.SelectMatch(sci, match);
                if (refreshHighlights) this.RefreshHighlights(sci, matches);
            }
            else this.findTextBox.BackColor = Color.Salmon;
        }

        /// <summary>
        /// Finds the previous match based on the current position
        /// </summary>
        private void FindPrev(String text, Boolean refreshHighlights)
        {
            if (text == "") return;
            ScintillaControl sci = Globals.SciControl;
            this.findTextBox.BackColor = SystemColors.Window;
            List<SearchMatch> matches = this.GetResults(sci, text);
            if (matches != null && matches.Count != 0)
            {
                SearchMatch match = FRDialogGenerics.GetNextDocumentMatch(sci, matches, false, false);
                if (match != null) FRDialogGenerics.SelectMatch(sci, match);
                if (refreshHighlights) this.RefreshHighlights(sci, matches);
            }
            else this.findTextBox.BackColor = Color.Salmon;
        }

        /// <summary>
        /// Fix the padding of documents when quick find is visible
        /// </summary>
        private void ApplyFixedDocumentPadding()
        {
            foreach (ITabbedDocument castable in Globals.MainForm.Documents)
            {
                TabbedDocument document = castable as TabbedDocument;
                if (document.IsEditable)
                {
                    if (this.Visible) document.Padding = new Padding(0, 0, 0, this.Height);
                    else document.Padding = new Padding(0);
                }
            }
        }

        /// <summary>
        /// Remove the status strip elements
        /// </summary>
        private void CloseButtonClick(Object sender, EventArgs e)
        {
            this.Hide();
            this.ApplyFixedDocumentPadding();
        }

        /// <summary>
        /// Adds highlights to the correct sci control
        /// </summary>
        private void AddHighlights(ScintillaControl sci, List<SearchMatch> matches)
        {
            foreach (SearchMatch match in matches)
            {
                Int32 start = sci.MBSafePosition(match.Index);
                Int32 end = start + sci.MBSafeTextLength(match.Value);
                Int32 line = sci.LineFromPosition(start);
                Int32 position = start;
                Int32 es = sci.EndStyled;
                Int32 mask = 1 << sci.StyleBits;
                sci.SetIndicStyle(0, (Int32)ScintillaNet.Enums.IndicatorStyle.Max);
                sci.SetIndicFore(0, DataConverter.ColorToInt32(Globals.Settings.HighlightAllColor));
                sci.StartStyling(position, mask);
                sci.SetStyling(end - start, mask);
                sci.StartStyling(es, mask - 1);
            }
        }

        /// <summary>
        /// Refreshes the highlights
        /// </summary>
        private void RefreshHighlights(ScintillaControl sci, List<SearchMatch> matches)
        {
            this.RemoveHighlights(sci);
            if (this.highlightTimer.Enabled) this.highlightTimer.Stop();
            Hashtable table = new Hashtable();
            table["sci"] = sci;
            table["matches"] = matches;
            this.highlightTimer.Tag = table;
            this.highlightTimer.Start();
        }

        /// <summary>
        /// Removes the highlights from the correct sci control
        /// </summary>
        private void RemoveHighlights(ScintillaControl sci)
        {
            Int32 es = sci.EndStyled;
            Int32 mask = (1 << sci.StyleBits);
            sci.StartStyling(0, mask);
            sci.SetStyling(sci.TextLength, 0);
            sci.StartStyling(es, mask - 1);
        }

        /// <summary>
        /// Gets search results for a sci control
        /// </summary>
        private List<SearchMatch> GetResults(ScintillaControl sci, String text)
        {
            String pattern = text;
            FRSearch search = new FRSearch(pattern);
            search.Filter = SearchFilter.None;
            search.NoCase = !this.matchCaseCheckBox.Checked;
            return search.Matches(sci.Text);
        }

        #endregion

        #region QuickFind Renderer

        public class QuickFindRenderer : ToolStripRenderer
        {
            private ToolStripRenderer renderer;

            public QuickFindRenderer()
            {
                UiRenderMode renderMode = Globals.Settings.RenderMode;
                if (renderMode == UiRenderMode.System) this.renderer = new ToolStripSystemRenderer();
                else this.renderer = new ToolStripProfessionalRenderer();
            }

            protected override void OnRenderToolStripBorder(ToolStripRenderEventArgs e)
            {
                Rectangle r = e.AffectedBounds;
                e.Graphics.DrawLine(SystemPens.ControlLightLight, r.Left, r.Top + 1, r.Right, r.Top + 1);
                e.Graphics.DrawLine(SystemPens.ControlLightLight, r.Left, r.Bottom, r.Right, r.Bottom);
                e.Graphics.DrawLine(SystemPens.GrayText, r.Left, r.Bottom - 1, r.Right, r.Bottom - 1);
                e.Graphics.DrawLine(SystemPens.GrayText, r.Right - 1, r.Top, r.Right - 1, r.Bottom);
                e.Graphics.DrawLine(SystemPens.GrayText, r.Left, r.Top, r.Left, r.Bottom);
                e.Graphics.DrawLine(SystemPens.GrayText, r.Left, r.Top, r.Right, r.Top);
            }

            #region Reuse Some Renderer Stuff

            protected override void OnRenderGrip(ToolStripGripRenderEventArgs e)
            {
                this.renderer.DrawGrip(e);
            }

            protected override void OnRenderSeparator(ToolStripSeparatorRenderEventArgs e)
            {
                this.renderer.DrawSeparator(e);
            }

            protected override void OnRenderButtonBackground(ToolStripItemRenderEventArgs e)
            {
                this.renderer.DrawButtonBackground(e);
            }

            protected override void OnRenderToolStripBackground(ToolStripRenderEventArgs e)
            {
                this.renderer.DrawToolStripBackground(e);
            }

            protected override void OnRenderDropDownButtonBackground(ToolStripItemRenderEventArgs e)
            {
                this.renderer.DrawDropDownButtonBackground(e);
            }

            protected override void OnRenderItemBackground(ToolStripItemRenderEventArgs e)
            {
                this.renderer.DrawItemBackground(e);
            }

            protected override void OnRenderItemCheck(ToolStripItemImageRenderEventArgs e)
            {
                this.renderer.DrawItemCheck(e);
            }

            protected override void OnRenderItemText(ToolStripItemTextRenderEventArgs e)
            {
                this.renderer.DrawItemText(e);
            }

            protected override void OnRenderItemImage(ToolStripItemImageRenderEventArgs e)
            {
                this.renderer.DrawItemImage(e);
            }

            protected override void OnRenderArrow(ToolStripArrowRenderEventArgs e)
            {
                this.renderer.DrawArrow(e);
            }

            protected override void OnRenderImageMargin(ToolStripRenderEventArgs e)
            {
                this.renderer.DrawImageMargin(e);
            }

            protected override void OnRenderLabelBackground(ToolStripItemRenderEventArgs e)
            {
                this.renderer.DrawLabelBackground(e);
            }

            protected override void OnRenderMenuItemBackground(ToolStripItemRenderEventArgs e)
            {
                this.renderer.DrawMenuItemBackground(e);
            }

            protected override void OnRenderOverflowButtonBackground(ToolStripItemRenderEventArgs e)
            {
                this.renderer.DrawOverflowButtonBackground(e);
            }

            protected override void OnRenderSplitButtonBackground(ToolStripItemRenderEventArgs e)
            {
                this.renderer.DrawSplitButton(e);
            }

            protected override void OnRenderStatusStripSizingGrip(ToolStripRenderEventArgs e)
            {
                this.renderer.DrawStatusStripSizingGrip(e);
            }

            protected override void OnRenderToolStripContentPanelBackground(ToolStripContentPanelRenderEventArgs e)
            {
                this.renderer.DrawToolStripContentPanelBackground(e);
            }

            protected override void OnRenderToolStripPanelBackground(ToolStripPanelRenderEventArgs e)
            {
                this.renderer.DrawToolStripPanelBackground(e);
            }

            protected override void OnRenderToolStripStatusLabelBackground(ToolStripItemRenderEventArgs e)
            {
                this.renderer.DrawToolStripStatusLabelBackground(e);
            }

            #endregion

        }

        #endregion

        #region Custom Controls

        public delegate void KeyEscapeEvent();

        public class EscapeTextBox : ToolStripTextBox
        {
            public event KeyEscapeEvent OnKeyEscape;

            public EscapeTextBox() : base() {}

            protected override Boolean ProcessCmdKey(ref Message m, Keys keyData)
            {
                if (keyData == Keys.Escape) OnPressEscapeKey();
                return false;
            }

            protected void OnPressEscapeKey()
            {
                if (OnKeyEscape != null) OnKeyEscape();
            }

        }

        #endregion

    }

}
