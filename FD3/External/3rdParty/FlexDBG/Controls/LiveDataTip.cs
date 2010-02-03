/*
    Copyright (C) 2009  Robert Nelson

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/

using System;
using System.Drawing;
using System.Windows.Forms;
using Flash.Tools.Debugger;
using Flash.Tools.Debugger.Expression;
using FlexDbg.Controls;
using PluginCore;
using PluginCore.Controls;
using ScintillaNet;

namespace FlexDbg
{
    class LiveDataTip
    {
        private DataTipForm m_ToolTip;
		private MouseMessageFilter m_MouseMessageFilter;

		public LiveDataTip()
		{
			m_ToolTip = new DataTipForm();
			m_ToolTip.Dock = DockStyle.Fill;
			m_ToolTip.Visible = false;

			m_MouseMessageFilter = new MouseMessageFilter();
			m_MouseMessageFilter.AddControls(new Control[] { m_ToolTip, m_ToolTip.DataTree });
			m_MouseMessageFilter.MouseDownEvent += new MouseDownEventHandler(MouseMessageFilter_MouseDownEvent);

			Application.AddMessageFilter(m_MouseMessageFilter);

			UITools.Manager.OnMouseHover += new UITools.MouseHoverHandler(Manager_OnMouseHover);
		}

		public void Show(Point point, Variable variable)
		{
			m_ToolTip.Location = point;
			m_ToolTip.SetVariable(variable);
			m_ToolTip.Visible = true;
			m_ToolTip.Location = point;
			m_ToolTip.BringToFront();
			m_ToolTip.Focus();
		}

		public void Hide()
		{
			m_ToolTip.Visible = false;
		}

		private void MouseMessageFilter_MouseDownEvent(MouseButtons button, Point e)
		{
			if (m_ToolTip.Visible &&
				!m_ToolTip.DataTree.Tree.ContextMenuStrip.Visible &&
				!m_ToolTip.DataTree.Viewer.Visible)
			{
				Hide();
			}
		}

		private void Manager_OnMouseHover(ScintillaControl sci, Int32 position)
		{
			DebuggerManager debugManager = PluginMain.debugManager;
			FlashInterface flashInterface = debugManager.FlashInterface;

			if (!PluginBase.MainForm.EditorMenu.Visible && flashInterface != null &&
				flashInterface.isDebuggerStarted && flashInterface.isDebuggerSuspended)
			{
				if (debugManager.CurrentLocation != null &&
					debugManager.CurrentLocation.File != null)
				{
					String localPath = debugManager.GetLocalPath(debugManager.CurrentLocation.File);

					if (localPath == null || localPath != PluginBase.MainForm.CurrentDocument.FileName)
					{
						return;
					}
				}
				else
				{
					return;
				}

				Point dataTipPoint = Control.MousePosition;
				Rectangle rect = new Rectangle(m_ToolTip.Location, m_ToolTip.Size);

				if (m_ToolTip.Visible && rect.Contains(dataTipPoint))
				{
					return;
				}

				position = sci.WordEndPosition(position, true);
				String leftword = GetWordAtPosition(sci, position);
				if (leftword != String.Empty)
				{
					try
					{
						ASTBuilder builder = new ASTBuilder(true);

						ValueExp exp = builder.parse(new System.IO.StringReader(leftword));
						ExpressionContext context = new ExpressionContext(flashInterface.Session);

						context.Depth = debugManager.CurrentFrame;

						Object obj = exp.evaluate(context);

						Show(dataTipPoint, (Variable)obj);
					}
					catch (Exception e)
					{
					}
				}
			}
		}

		private String GetWordAtPosition(ScintillaControl sci, Int32 position)
		{
			Char c;
			System.Text.StringBuilder sb = new System.Text.StringBuilder();

			for (Int32 startPosition = position - 1; startPosition >= 0; startPosition--)
			{
				c = (Char)sci.CharAt(startPosition);
				if (!(Char.IsLetterOrDigit(c) || c == '_' || c == '$' || c == '.'))
				{
					break;
				}
				sb.Insert(0, c);
			}
			return sb.ToString();
		}
    }

    public delegate void MouseDownEventHandler(MouseButtons button, Point e);
    public class MouseMessageFilter : IMessageFilter
    {
        public event MouseDownEventHandler MouseDownEvent = null;

		private Control[] m_ControlList;

        public void AddControls(Control[] controls)
        {
            m_ControlList = controls;
        }

        #region IMessageFilter

        public bool PreFilterMessage(ref Message m)
        {
            if (m.Msg == Win32.WM_LBUTTONDOWN)
            {
				FlexDbgTrace.TraceInfo("PreFilterMessage: WM_LBUTTONDOWN - wParam = " + m.WParam.ToString("x") + ", lParam = " + m.LParam.ToString("x"));

				Control target = Control.FromHandle(m.HWnd);

				foreach (Control c in m_ControlList)
                {
					if (c == target || c.Contains(target))
					{
						return false;
					}
                }

				if (MouseDownEvent != null)
				{
					MouseDownEvent(MouseButtons.Left, new Point(m.LParam.ToInt32()));
				}
            }
            return false;
        }

        #endregion
    }
}
