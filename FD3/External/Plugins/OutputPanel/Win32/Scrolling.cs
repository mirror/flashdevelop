using System;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace OutputPanel.Win32
{
	public class Scrolling
	{
		#region Imports 

        [DllImport("User32.dll", CharSet = CharSet.Auto)]
        public static extern Boolean GetScrollRange(IntPtr hWnd, Int32 nBar, out Int32 lpMinPos, out Int32 lpMaxPos); 

        [DllImport("User32.dll", CharSet = CharSet.Auto)]
        public static extern IntPtr SendMessage(IntPtr hWnd, Int32 msg, Int32 wParam, Int32 lParam);

        [DllImport("User32.dll")]
        public static extern Int32 GetScrollPos(IntPtr hWnd, Int32 nBar);

        #endregion
        
        public const Int32 SB_HORZ = 0;
        public const Int32 SB_VERT = 1;
        public const Int32 SB_LEFT = 6;
        public const Int32 SB_RIGHT = 7;
        public const Int32 WM_HSCROLL = 0x0114;
        public const Int32 WM_VSCROLL = 0x0115;

        /// <summary>
        /// Scrolls the control to the bottom
        /// </summary> 
        public static void ScrollToBottom(Control ctrl)
		{
            Int32 min, max;
		    GetScrollRange(ctrl.Handle, SB_VERT, out min, out max);
		    SendMessage(ctrl.Handle, WM_VSCROLL, SB_RIGHT, max);
		}

        /// <summary>
        /// Scrolls the control to the right
        /// </summary> 
        public static void ScrollToRight(Control ctrl)
        {
            Int32 min, max;
            GetScrollRange(ctrl.Handle, SB_HORZ, out min, out max);
            SendMessage(ctrl.Handle, WM_HSCROLL, SB_RIGHT, max);
        }

        /// <summary>
        /// Scrolls the control to the top
        /// </summary>
		public static void ScrollToTop(Control ctrl)
		{
			SendMessage(ctrl.Handle, WM_VSCROLL, SB_LEFT, 0);
		}

        /// <summary>
        /// Scrolls the control to the left
        /// </summary>
		public static void ScrollToLeft(Control ctrl)
		{
			SendMessage(ctrl.Handle, WM_HSCROLL, SB_LEFT, 0);
		}

	}

}
