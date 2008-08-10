using System;
using System.Drawing;
using System.Collections;
using System.Runtime.InteropServices;
using System.Drawing.Drawing2D;
using System.ComponentModel;
using System.Windows.Forms;

namespace PluginCore.Utilities
{
    public class IconExtractor
	{
		[DllImport("Kernel32.dll")]
		public static extern Int32 GetModuleHandle(String lpModuleName);

		[DllImport("Shell32.dll")]
        public static extern IntPtr ExtractIcon(Int32 hInst, String FileName, Int32 nIconIndex);

		[DllImport("Shell32.dll")]
        public static extern Int32 DestroyIcon(IntPtr hIcon);

		[DllImport("Shell32.dll")]
        public static extern IntPtr ExtractIconEx(String FileName, Int32 nIconIndex, Int32[] lgIcon, Int32[] smIcon, Int32 nIcons);

		[DllImport("Shell32.dll")]
        private static extern Int32 SHGetFileInfo(String pszPath, UInt32 dwFileAttributes, out SHFILEINFO psfi, UInt32 cbfileInfo, SHGFI uFlags);

		[StructLayout(LayoutKind.Sequential)]
		private struct SHFILEINFO
		{
			public SHFILEINFO(Boolean b)
			{
				hIcon = IntPtr.Zero;
				iIcon = 0;
				dwAttributes = 0;
				szDisplayName = "";
				szTypeName = "";
			}
			public IntPtr hIcon;
            public Int32 iIcon;
            public UInt32 dwAttributes;
			[MarshalAs(UnmanagedType.LPStr, SizeConst=260)]
			public String szDisplayName;
			[MarshalAs(UnmanagedType.LPStr, SizeConst=80)]
			public String szTypeName;
		};

		private enum SHGFI
		{
			SmallIcon = 0x00000001,
			LargeIcon = 0x00000000,
			Icon = 0x00000100,
			DisplayName = 0x00000200,
			Typename = 0x00000400,
			SysIconIndex = 0x00004000,
			UseFileAttributes = 0x00000010
		}

        public static Icon GetSysIcon(Int32 icNo)
		{
			IntPtr HIcon = ExtractIcon(GetModuleHandle(String.Empty), "Shell32.dll", icNo);
			return Icon.FromHandle(HIcon);
		}

        /// <summary>
        /// Get the associated Icon for a file or application, this method always returns
        /// an icon. If the strPath is invalid or there is no icon, the default icon is returned.
        /// </summary>
        public static Icon GetIcon(String strPath, Boolean bSmall)
        {
            SHGFI flags;
            SHFILEINFO info = new SHFILEINFO(true);
            Int32 cbFileInfo = Marshal.SizeOf(info);
            if (bSmall) flags = SHGFI.Icon | SHGFI.SmallIcon | SHGFI.UseFileAttributes;
            else flags = SHGFI.Icon | SHGFI.LargeIcon | SHGFI.UseFileAttributes;
            SHGetFileInfo(strPath, 256, out info, (UInt32)cbFileInfo, flags);
            return Icon.FromHandle(info.hIcon);
        }

	}
	
}
