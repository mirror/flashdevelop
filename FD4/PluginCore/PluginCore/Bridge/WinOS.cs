using System;
using System.Runtime.InteropServices;

namespace PluginCore.Bridge
{
	public class WinOS
	{
		[DllImport("mpr.dll")] 
        [return: MarshalAs(UnmanagedType.U4)] 
        static extern int WNetGetUniversalName( 
                string lpLocalPath, 
                [MarshalAs(UnmanagedType.U4)] int dwInfoLevel, 
                IntPtr lpBuffer, 
                [MarshalAs(UnmanagedType.U4)] ref int lpBufferSize); 
		
        static public UNCInfo GetUNC(string path) 
        { 
            int bufferSize = 2000; 
            IntPtr buffer = Marshal.AllocHGlobal(bufferSize); 
            int ret = WNetGetUniversalName(path, 2, buffer, ref bufferSize); 
			UNCInfo unc = null;
            if (ret == 0) 
            { 
                    unc = new UNCInfo(); 
                    Marshal.PtrToStructure(buffer, unc); 
                    Console.WriteLine(unc.UniversalName); 
            } 
            Marshal.FreeHGlobal(buffer); 
            return unc; 
        } 
	}
	
	[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Unicode), Serializable()] 
    public class UNCInfo
    { 
        [MarshalAs(UnmanagedType.LPStr)] 
        public string UniversalName; 
        [MarshalAs(UnmanagedType.LPStr)] 
        public string ConnectionName; 
        [MarshalAs(UnmanagedType.LPStr)] 
        public string RemainingPath; 
    }
	
}

