using System;
using System.Net.NetworkInformation;
using System.IO;
using PluginCore.Managers;

namespace PluginCore.Bridge
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
                        ip = "invalid";
                }
                return ip;
            }
        }

        static public int BridgePort { get { return port; } }

        static string DetectIP()
        {
            try
            {
                string issue = "Unable to find a gateway";
                foreach (NetworkInterface f in NetworkInterface.GetAllNetworkInterfaces())
                {
                    issue += "\n" + f.Name + ", " + f.Description;
                    if (f.OperationalStatus == OperationalStatus.Up)
                        foreach (GatewayIPAddressInformation d in f.GetIPProperties().GatewayAddresses)
                        {
                            return d.Address.ToString();
                        }
                }
                throw new Exception(issue);
            }
            catch (Exception ex)
            {
                ErrorManager.AddToLog("Gateway detection", ex);
            }
            return null;
        }

        #endregion

        public bool Connected { get { return conn != null && conn.Connected; } }

        public BridgeClient()
            : base(BridgeIP, BridgePort)
        {
            if (!isInvalid) ConnectClient();
        }
    }
}

