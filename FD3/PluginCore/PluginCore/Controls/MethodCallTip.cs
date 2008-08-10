using System;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using ScintillaNet;

namespace PluginCore.Controls
{
    
    public class MethodCallTip: RichToolTip
    {
        public delegate void UpdateCallTipHandler(ScintillaControl sender, int position);

        // events
        public event UpdateCallTipHandler OnUpdateCallTip;

        // state
        protected bool isActive;
        protected int memberPos;
        protected int startPos;
        protected int currentPos;
        protected int currentLine;

        public MethodCallTip(IMainForm mainForm): base(mainForm)
        {
        }

        public bool CallTipActive
        {
            get { return isActive; }
        }

        public bool Focused
        {
            get { return toolTipRTB.Focused; }
        }

        public override void Hide()
        {
			if (isActive)
			{
				isActive = false;
                UITools.Manager.UnlockControl(); // unlock keys
			}
            faded = false;
            base.Hide();
        }

        public bool CheckPosition(int position)
        {
            return position == currentPos;
        }

        public void CallTipShow(ScintillaControl sci, int position, string text)
        {
            if (toolTip.Visible && position == memberPos && text == Text)
                return;
            toolTip.Visible = false;
            Text = text;
            AutoSize();
            memberPos = position;
            startPos = memberPos + text.IndexOf('(');
            currentPos = sci.CurrentPos;
            currentLine = sci.LineFromPosition(currentPos);
            PositionControl(sci);
            // state
            isActive = true;
            faded = false;
            UITools.Manager.LockControl(sci);
        }

        public void PositionControl(ScintillaControl sci)
        {
            // compute control location
            Point p = new Point(sci.PointXFromPosition(memberPos), sci.PointYFromPosition(memberPos));
            p = ((Form)PluginBase.MainForm).PointToClient(((Control)sci).PointToScreen(p));
            toolTip.Left = p.X + sci.Left;
            bool hasListUp = !CompletionList.Active || CompletionList.listUp;
            if (currentLine > sci.LineFromPosition(memberPos) || !hasListUp) toolTip.Top = p.Y - toolTip.Height + sci.Top;
            else toolTip.Top = p.Y + UITools.Manager.LineHeight(sci) + sci.Top;
            // show
            toolTip.Show();
            toolTip.BringToFront();
        }

        public void CallTipSetHlt(int start, int end)
        {
            SetRichText();
            if (start != end)
            {
                try
                {
                    toolTipRTB.Select(start, end - start);
                    toolTipRTB.SelectionFont = new Font(toolTipRTB.Font.FontFamily, toolTipRTB.Font.Size, FontStyle.Bold);
                    AutoSize();
                }
                catch { }
            }
        }

        #region Keys handling

        public void OnChar(ScintillaControl sci, int value)
        {
            currentPos++;
            UpdateTip(sci);
        }

        public void UpdateTip(ScintillaControl sci)
        {
            if (OnUpdateCallTip != null) OnUpdateCallTip(sci, currentPos);
        }

        public bool HandleKeys(ScintillaControl sci, Keys key)
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
                    if (!CompletionList.Active)
                    {
                        sci.CharRight();
                        currentPos = sci.CurrentPos;
                        if (sci.LineFromPosition(sci.CurrentPos) != currentLine) Hide();
                        else if (OnUpdateCallTip != null) OnUpdateCallTip(sci, currentPos);
                    }
                    return true;

                case Keys.Left:
                    if (!CompletionList.Active)
                    {
                        sci.CharLeft();
                        currentPos = sci.CurrentPos;
                        if (currentPos < startPos) Hide();
                        else
                        {
                            if (sci.LineFromPosition(sci.CurrentPos) != currentLine) Hide();
                            else if (OnUpdateCallTip != null) OnUpdateCallTip(sci, currentPos);
                        }
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
                    if (!CompletionList.Active) Hide();
                    return false;
            }
        }

        #endregion

        #region Controls fading on Control key
        private static bool faded;

        internal void FadeOut()
        {
            if (faded) return;
            faded = true;
            base.Hide();
        }

        internal void FadeIn()
        {
            if (!faded) return;
            faded = false;
            base.Show();
        }
        #endregion
    }
}
