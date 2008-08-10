using System;
using System.Drawing;
using System.Windows.Forms;
using System.Collections;
using ScintillaNet;

namespace PluginCore.Controls
{
	/// <summary>
	/// RichTextBox-based tooltip
	/// </summary>
	public class InfoTip
	{
		// events
		public delegate void UpdateCallTipHandler(ScintillaControl sender, int position);
		public delegate void MouseHoverHandler(ScintillaControl sender, int position);
		static public event UpdateCallTipHandler OnUpdateCallTip;
		static public event MouseHoverHandler OnMouseHover;
		// controls
		static private Panel toolTip;
		static private RichTextBox toolTipRTB;
		// state
		static private bool isActive;
		static private int startPos;
		static private int currentPos;
		static private int currentLine;
		static private string rawText;

		#region Public Properties
		
		static public bool Visible 
		{
			get { return toolTip.Visible; }
		}
		
		static public Point Location
		{
			get { return toolTip.Location;  }
			set { toolTip.Location = value; }
		}
		
		static public string Text 
		{
			get { return toolTipRTB.Text; }
			set 
			{
				rawText = ((value == null) ? "" : value);
				SetRichText();
				AutoSize();
			}
		}
		
		static public bool CallTipActive 
		{
			get { return isActive; }
		}
				
		#endregion
		
		#region Control creation
		
		static public void CreateControl(IMainForm mainForm)
		{
			// panel
			toolTip = new System.Windows.Forms.Panel();
			toolTip.Location = new System.Drawing.Point(0,0);
			toolTip.BackColor = Color.LightGoldenrodYellow;
			toolTip.BorderStyle = BorderStyle.FixedSingle;
			toolTip.Visible = false;
			(mainForm as Form).Controls.Add(toolTip);
			// text
			toolTipRTB = new System.Windows.Forms.RichTextBox();
			toolTipRTB.Location = new System.Drawing.Point(2,1);
			toolTipRTB.BackColor = Color.LightGoldenrodYellow;
			toolTipRTB.BorderStyle = BorderStyle.None;
			toolTipRTB.ScrollBars = RichTextBoxScrollBars.None;
			toolTipRTB.ReadOnly = true;
			toolTipRTB.WordWrap = false;
			toolTipRTB.Visible = true;
			toolTipRTB.Text = "";
			toolTip.Controls.Add(toolTipRTB);
		}
		
		#endregion
		
		#region Tip Methods
		
		static public void HandleDwellStart(ScintillaControl sci, int position)
		{
			// check dwell validity
			if (sci == null || CallTipActive) return;
			// TODO: Improve this code: I don't like this solution to check the mouse position
			// check mouse over the editor
			if ((position < 0) || Visible) return;
			Point mousePos = sci.PointToClient(Control.MousePosition);
			Rectangle bounds = sci.Bounds;
			if ((mousePos.X < 0) || (mousePos.X > bounds.Width) || (mousePos.Y < 0) || (mousePos.Y > bounds.Height)) return;
			// check no panel is over the editor
			bool valid = false;
			Form frm = (Form)UITools.MainForm;
			mousePos = frm.PointToClient(Control.MousePosition);
			Control ctrl = frm.GetChildAtPoint(mousePos);
			if (ctrl != null) 
			{
				mousePos = ctrl.PointToClient(Control.MousePosition);
				ctrl = ctrl.GetChildAtPoint(mousePos);
				if (ctrl != null) 
				{
					mousePos = ctrl.PointToClient(Control.MousePosition);
					ctrl = ctrl.GetChildAtPoint(mousePos);
					if (ctrl != null) 
					{
						mousePos = ctrl.PointToClient(Control.MousePosition);
						ctrl = ctrl.GetChildAtPoint(mousePos);
						if (ctrl != null) 
						{
							valid = (ctrl.GetType().ToString() == "FlashDevelop.TabbedDocument");
						}
					}
				}
			}
			if (valid && OnMouseHover != null) OnMouseHover(sci, position);
		}
		
		static public void HandleDwellEnd(ScintillaControl sci, int position)
		{
			if (Visible && !CompletionList.Active && !isActive) Hide();
		}
		
		static public void AutoSize()
		{
			Graphics g = ((Form)UITools.MainForm).CreateGraphics();
			SizeF textSize = g.MeasureString(toolTipRTB.Text, toolTipRTB.Font);
			int w = (int)textSize.Width+4;
			
			// tooltip larger than the window: wrap
			if (toolTip.Left+w > ((Form)UITools.MainForm).Width)
			{
				toolTipRTB.WordWrap = true;
				w = ((Form)UITools.MainForm).Width-toolTip.Left;
				textSize = g.MeasureString(toolTipRTB.Text, toolTipRTB.Font, new Size(w, ((Form)UITools.MainForm).Height));
				w = (int)textSize.Width+4;
			}
			
			if (toolTipRTB.SelectionLength > 0) w += toolTipRTB.SelectionLength/2;
			toolTipRTB.Size = new Size(w, (int)textSize.Height+2);
			toolTip.Size = new Size(w, (int)textSize.Height+3);
		}
		
		static public void ShowAtMouseLocation(string text)
		{
			toolTip.Visible = false;
			Text = text;
			AutoSize();
			ShowAtMouseLocation();
		}
		
		static public void ShowAtMouseLocation()
		{
			Point mousePos = ((Form)UITools.MainForm).PointToClient(Control.MousePosition);
			ScintillaControl sci = UITools.MainForm.CurSciControl;
			toolTip.Left = mousePos.X + sci.Left;
			toolTip.Top = mousePos.Y-toolTip.Height-10 + sci.Top;
			toolTip.Show();
			toolTip.BringToFront();
		}
		
		static public void Hide()
		{
			if (toolTip.Visible)
			{
				if (isActive)
				{
					isActive = false;
					UITools.UnlockControl(); // unlock keys
				}
				toolTip.Visible = false;
				toolTipRTB.Select(0, toolTipRTB.Text.Length);
				toolTipRTB.SelectionFont = new Font(toolTipRTB.Font.FontFamily, toolTipRTB.Font.Size, FontStyle.Regular);
			}
		}
		
		static public void Show()
		{
			toolTip.Visible = true;
			toolTip.BringToFront();
		}
		
		static private void SetRichText()
		{
			toolTipRTB.Text = "";
			toolTipRTB.WordWrap = false;
			
			ArrayList startBold = new ArrayList();
			ArrayList lenBold = new ArrayList();
			int pos = 0;
			// first
			int index = rawText.IndexOf("[B]");
			while (index > 0)
			{
				toolTipRTB.Text += rawText.Substring(pos, index-pos);
				pos = index+3;
				index = rawText.IndexOf("[/B]", pos);
				if (index < 0) break;
				startBold.Add(toolTipRTB.Text.Length);
				lenBold.Add(index-pos);
				toolTipRTB.Text += rawText.Substring(pos, index-pos);
				pos = index+4;
				// next
				index = rawText.IndexOf("[B]", pos);
			}
			toolTipRTB.Text += rawText.Substring(pos);
			// style
			Font bold = new Font(toolTipRTB.Font.FontFamily, toolTipRTB.Font.Size, FontStyle.Bold);
			for(int i=0; i<startBold.Count; i++)
			{
				toolTipRTB.Select((int)startBold[i], (int)lenBold[i]);
				toolTipRTB.SelectionFont = bold;
			}
			toolTipRTB.Select(0,0);
		}
		
		#endregion
		
		#region CallTip methods
		
		static public bool CheckPosition(int position)
		{
			return position == currentPos;
		}

		static public void CallTipShow(ScintillaControl sci, int position, string text)
		{
			toolTip.Visible = false;
			isActive = true;
			Text = text;
			AutoSize();
			// position
			startPos = position+text.IndexOf('(')+1;
			currentPos = sci.CurrentPos;
			currentLine = sci.LineFromPosition(currentPos);
			Point p = new Point(sci.PointXFromPosition(position), sci.PointYFromPosition(position));
			p = ((Form)UITools.MainForm).PointToClient(((Control)sci).PointToScreen(p));
			toolTip.Left = p.X + sci.Left;
			if (currentLine > sci.LineFromPosition(position)) toolTip.Top = p.Y-toolTip.Height + sci.Top;
			else toolTip.Top = p.Y+UITools.LineHeight(sci) + sci.Top;
			toolTip.Show();
			toolTip.BringToFront();
			UITools.LockControl(sci); // lock keys
		}
		
		static public void CallTipSetHlt(int start, int end)
		{
			SetRichText();
			if (start != end) 
			{
				try
				{
					toolTipRTB.Select(start, end-start);
					toolTipRTB.SelectionFont = new Font(toolTipRTB.Font.FontFamily, toolTipRTB.Font.Size, FontStyle.Bold);
					AutoSize();
				}
				catch {}
			}
		}
		
		#endregion
		
		#region Keys handling
		
		static public void OnChar(ScintillaControl sci, int value)
		{
			currentPos++;
			UpdateTip(sci);
		}
		
		static public void UpdateTip(ScintillaControl sci)
		{
			if (OnUpdateCallTip != null) OnUpdateCallTip(sci, currentPos);
		}
		
		static public bool HandleKeys(ScintillaControl sci, Keys key)
		{
			switch (key)
			{
				case Keys.Multiply:
				case Keys.Subtract:
				case Keys.Divide:
				case Keys.Decimal:
				case Keys.Add:
					return false;
					
				case Keys.Right:
					sci.CharRight();
					currentPos = sci.CurrentPos;
					if (sci.LineFromPosition(sci.CurrentPos) != currentLine) Hide();
					else if (OnUpdateCallTip != null) OnUpdateCallTip(sci, currentPos);
					return true;
					
				case Keys.Left:
					sci.CharLeft();
					currentPos = sci.CurrentPos;
					if (currentPos < startPos) Hide();
					else 
					{
						if (sci.LineFromPosition(sci.CurrentPos) != currentLine) Hide();
						else if (OnUpdateCallTip != null) OnUpdateCallTip(sci, currentPos);
					}
					return true;
				
				case Keys.Back:
					sci.DeleteBack();
					currentPos = sci.CurrentPos;
					if (currentPos < startPos) Hide();
					else if (OnUpdateCallTip != null) OnUpdateCallTip(sci, currentPos);
					return true;
				
				case Keys.Tab:
				case Keys.Space:
					return false;
				
				default:
					InfoTip.Hide();
					return false;
			}			
		}
		
		#endregion

	}
}
