using System;
using System.Runtime.InteropServices;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace ProjectExplorer.Helpers
{
	public class ExtractIconClass
	{
		[DllImport("Kernel32.dll")]
		public static extern int GetModuleHandle
			(
			string lpModuleName
			);

		[DllImport("Shell32.dll")]
		public static extern IntPtr ExtractIcon(int hInst,string FileName,int
			nIconIndex);

		[DllImport("Shell32.dll")]
		public static extern int DestroyIcon(IntPtr hIcon);

		[DllImport("Shell32.dll")]
		public static extern IntPtr ExtractIconEx(string FileName,int nIconIndex,
			int[] lgIcon,int[] smIcon,int nIcons);

		[DllImport("Shell32.dll")]
		private static extern int SHGetFileInfo
			(
			string pszPath,
			uint dwFileAttributes,
			out SHFILEINFO psfi,
			uint cbfileInfo,
			SHGFI uFlags
			);

		[StructLayout(LayoutKind.Sequential)]
			private struct SHFILEINFO
		{
			public SHFILEINFO(bool b)
			{
				hIcon=IntPtr.Zero;
				iIcon=0;
				dwAttributes=0;
				szDisplayName="";
				szTypeName="";
			}
			public IntPtr hIcon;
			public int iIcon;
			public uint dwAttributes;
			[MarshalAs(UnmanagedType.LPStr, SizeConst=260)]
			public string szDisplayName;
			[MarshalAs(UnmanagedType.LPStr, SizeConst=80)]
			public string szTypeName;
		};

		private enum SHGFI
		{
			SmallIcon   = 0x00000001,
			LargeIcon   = 0x00000000,
			Icon    = 0x00000100,
			DisplayName   = 0x00000200,
			Typename   = 0x00000400,
			SysIconIndex  = 0x00004000,
			UseFileAttributes = 0x00000010
		}

		/// <summary>
		/// Get the associated Icon for a file or application, this method always returns
		/// an icon.  If the strPath is invalid or there is no idonc the default icon is returned
		/// </summary>
		/// <param name="strPath">full path to the file</param>
		/// <param name="bSmall">if true, the 16x16 icon is returned otherwise the 32x32</param>
		public static Icon GetIcon(string strPath, bool bSmall)
		{
			SHFILEINFO info = new SHFILEINFO(true);
			int cbFileInfo = Marshal.SizeOf(info);
			SHGFI flags;
			if (bSmall)
				flags = SHGFI.Icon|SHGFI.SmallIcon|SHGFI.UseFileAttributes;
			else
				flags = SHGFI.Icon|SHGFI.LargeIcon|SHGFI.UseFileAttributes;

			SHGetFileInfo(strPath, 256, out info,(uint)cbFileInfo, flags);
			return Icon.FromHandle(info.hIcon);
		}

		public static Icon GetSysIcon(int icNo)
		{
			IntPtr HIcon = ExtractIcon( GetModuleHandle(String.Empty), "Shell32.dll",
				icNo );
			return Icon.FromHandle( HIcon );
		} 
	}
}