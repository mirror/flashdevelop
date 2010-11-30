using System;
using System.Net.NetworkInformation;
using System.IO;

namespace PluginCore.PluginCore.System.Bridge
{
    public class BridgeClient : ServerSocket
    {
        #region configuration
        static private string ip;
        static private int port = 8007;

        static public string BridgeIP
        {
            get
            {
                if (ip == null)
                {
                    ip = DetectIP();
                    if (ip == null)
                    {
                        ip = "invalid";
                        Console.WriteLine("Gateway not detected");
                    }
                }
                return ip;
            }
        }

        static public int BridgePort { get { return port; } }

        static string DetectIP()
        {
            foreach (NetworkInterface f in NetworkInterface.GetAllNetworkInterfaces())
            {
                //Console.WriteLine(f.Description);
                if (f.OperationalStatus == OperationalStatus.Up)
                    foreach (GatewayIPAddressInformation d in f.GetIPProperties().GatewayAddresses)
                    {
                        return d.Address.ToString();
                    }
            }
            return null;
        }

        #endregion

        public bool Connected { get { return conn != null && conn.Connected; } }

        public BridgeClient()
            : base(BridgeIP, BridgePort)
        {
            if (ConnectClient()) return;

            while (true)
            {
                string msg = Console.ReadLine();
                if (msg.Length == 0)
                    break;
                Send(msg);
            }
        }
    }
}

