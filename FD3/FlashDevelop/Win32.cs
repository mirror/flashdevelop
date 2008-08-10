using System;
using System.Runtime.InteropServices;

namespace FlashDevelop
{
    class Win32
    {
        public const Int32 SW_HIDE = 0;
        public const Int32 SW_SHOW = 1;
        public const Int32 SW_RESTORE = 9;
        public const Int32 SW_SHOWMINIMIZED = 2;
        public const Int32 SWP_SHOWWINDOW = 64;

        [DllImport("user32.dll")]
        public static extern Int32 GetSystemMetrics(Int32 which);

        [DllImport("user32.dll")]
        public static extern Int32 ShowWindow(Int32 hWnd, Int32 nCmdShow);
        
        [DllImport("user32.dll")]
        public static extern Boolean ShowWindow(IntPtr hWnd, Int32 nCmdShow);

        [DllImport("user32.dll")]
        public static extern Int32 FindWindow(String lpszClassName, String lpszWindowName);

        [DllImport("user32.dll")]
        public static extern void SetWindowPos(IntPtr hwnd, IntPtr hwndInsertAfter, Int32 x, Int32 y, Int32 width, Int32 height, UInt32 flags);

        /// <summary>
        /// Sets the window specified by handle to fullscreen
        /// </summary>
        public static void SetWinFullScreen(IntPtr hwnd)
        {
            Int32 screenX = Win32.GetSystemMetrics(0);
            Int32 screenY = Win32.GetSystemMetrics(1);
            Win32.SetWindowPos(hwnd, IntPtr.Zero, 0, 0, screenX, screenY, Win32.SWP_SHOWWINDOW);
        }

    }

}
