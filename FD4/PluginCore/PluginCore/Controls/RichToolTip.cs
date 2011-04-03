using System;
using System.Drawing;
using System.Windows.Forms;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Runtime.InteropServices;
using ScintillaNet;
using PluginCore.BBCode;


namespace PluginCore.Controls
{
	/// <summary>
	/// RichTextBox-based tooltip
	/// </summary>
	public class RichToolTip
	{
		// controls
		protected Panel toolTip;
        protected RichTextBox toolTipRTB;
        protected string rawText;
		protected string lastRawText;
		protected string cachedRtf;
		protected Dictionary<String, String> rtfCache;
		protected List<String> rtfCacheList;



		#region Public Properties
		
		public bool Visible 
		{
			get { return toolTip.Visible; }
		}

        public Size Size
        {
            get { return toolTip.Size; }
            set { toolTip.Size = value; }
        }

		public Point Location
		{
			get { return toolTip.Location;  }
			set { toolTip.Location = value; }
		}

		public string Text 
		{
			get { return toolTipRTB.Text; }
			set 
			{
				SetText(value, true);
			}
		}
				
		#endregion
		
		#region Control creation
		
		public RichToolTip(IMainForm mainForm)
		{
			// panel
			toolTip = new Panel();
			toolTip.Location = new System.Drawing.Point(0,0);
            toolTip.BackColor = System.Drawing.SystemColors.Info;
            toolTip.ForeColor = System.Drawing.SystemColors.InfoText;
			toolTip.BorderStyle = BorderStyle.FixedSingle;
			toolTip.Visible = false;
			(mainForm as Form).Controls.Add(toolTip);
			// text
			toolTipRTB = new System.Windows.Forms.RichTextBox();
			toolTipRTB.Location = new System.Drawing.Point(2,1);
            toolTipRTB.BackColor = System.Drawing.SystemColors.Info;
            toolTipRTB.ForeColor = System.Drawing.SystemColors.InfoText;
			toolTipRTB.BorderStyle = BorderStyle.None;
			toolTipRTB.ScrollBars = RichTextBoxScrollBars.None;
            toolTipRTB.DetectUrls = false;
			toolTipRTB.ReadOnly = true;
			toolTipRTB.WordWrap = false;
			toolTipRTB.Visible = true;
			toolTipRTB.Text = "";
			toolTip.Controls.Add(toolTipRTB);

			// rtf cache
			rtfCache = new Dictionary<String, String>();
			rtfCacheList = new List<String>();
		}
		
		#endregion
		
		#region Tip Methods

		public bool AutoSize()
		{
			return AutoSize(0);
		}
		public bool AutoSize(int availableRightSize)
		{
			bool tooSmall = false;
			bool wordWrap = false;
			Size txtSize = WinFormUtils.MeasureRichTextBox(toolTipRTB, false, toolTipRTB.Width, toolTipRTB.Height, false);

			// tooltip larger than the window: wrap
			int limitLeft = ((Form)PluginBase.MainForm).ClientRectangle.Left + 10;
			int limitRight = ((Form)PluginBase.MainForm).ClientRectangle.Right - 10;
			int limitBottom = ((Form)PluginBase.MainForm).ClientRectangle.Bottom - 26;
			//
			int w = txtSize.Width + 4;
			if (w > limitRight - limitLeft)
			{
				wordWrap = true;
				w = limitRight - limitLeft;
                if (w < 300)
                {
                    tooSmall = true;
					w = Math.Max(200, w);
				//	w = Math.Max(200, availableRightSize - 20);
                }

				txtSize = WinFormUtils.MeasureRichTextBox(toolTipRTB, false, w, 1000, true);
				w = txtSize.Width + 4;
			}

            int h = txtSize.Height + 2;
            int dh = 1;
            int dw = 2;
			if (h > (limitBottom - toolTip.Top))
			{
				w += 15;
				h = limitBottom - toolTip.Top;
				dh = 4;
				dw = 5;

				toolTipRTB.ScrollBars = RichTextBoxScrollBars.Vertical;
			}

			toolTipRTB.Size = new Size(w, h);
            toolTip.Size = new Size(w + dw, h + dh);

			if (toolTip.Left < limitLeft)
				toolTip.Left = limitLeft;

			if (toolTip.Left + toolTip.Width > limitRight)
				toolTip.Left = limitRight - toolTip.Width;

			if (toolTipRTB.WordWrap != wordWrap)
				toolTipRTB.WordWrap = wordWrap;

			return !tooSmall;
		}

		public void ShowAtMouseLocation(string text)
		{
            if (text != Text)
            {
                toolTip.Visible = false;
                Text = text;
            }
			ShowAtMouseLocation();
		}
		
		public void ShowAtMouseLocation()
		{
            //ITabbedDocument doc = PluginBase.MainForm.CurrentDocument;
			Point mousePos = ((Form)PluginBase.MainForm).PointToClient(Control.MousePosition);
            toolTip.Left = mousePos.X;// +sci.Left;
            if (toolTip.Right > ((Form)PluginBase.MainForm).ClientRectangle.Right)
            {
                toolTip.Left -= (toolTip.Right - ((Form)PluginBase.MainForm).ClientRectangle.Right);
            }
            toolTip.Top = mousePos.Y - toolTip.Height - 10;// +sci.Top;
			toolTip.Show();
			toolTip.BringToFront();
		}
		
		public virtual void Hide()
		{
			if (toolTip.Visible)
			{
				toolTip.Visible = false;
				toolTipRTB.Select(0, toolTipRTB.Text.Length);
				toolTipRTB.SelectionFont = new Font(toolTipRTB.Font.FontFamily, toolTipRTB.Font.Size, FontStyle.Regular);
			}
		}

        public virtual void Show()
		{
			toolTip.Visible = true;
			toolTip.BringToFront();
		}

		public void SetText(String rawText, bool redraw)
		{
			this.rawText = rawText ?? "";

			if (redraw)
				Redraw();
		}

		public void Redraw()
		{
			toolTipRTB.Rtf = getRtfFor(rawText);

			AutoSize();
		}

		protected String getRtfFor(String bbcodeText)
		{
			if (rtfCache.ContainsKey(bbcodeText))
				return rtfCache[bbcodeText];

			if (rtfCacheList.Count >= 512)
			{
				String key = rtfCacheList[0];
				rtfCache[key] = null;
				rtfCache.Remove(key);
				rtfCacheList[0] = null;
				rtfCacheList.RemoveAt(0);
			}

			toolTipRTB.Text = "";
			toolTipRTB.ScrollBars = RichTextBoxScrollBars.None;
			toolTipRTB.WordWrap = false;

			rtfCacheList.Add(bbcodeText);
			rtfCache[bbcodeText] = BBCodeUtils.bbCodeToRtf(bbcodeText, toolTipRTB);
			return rtfCache[bbcodeText];
		}

		#endregion
	}
}
