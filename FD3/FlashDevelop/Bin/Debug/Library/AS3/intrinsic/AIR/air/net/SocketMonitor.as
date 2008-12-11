package air.net
{
	/// A SocketMonitor object monitors availablity of a TCP endpoint.
	public class SocketMonitor extends air.net.ServiceMonitor
	{
		/// [AIR] The host being monitored.
		public var host:String;

		/// [AIR] The port being monitored.
		public var port:int;

		/// [AIR] Creates a SocketMonitor object for a specified TCP endpoint.
		public function SocketMonitor(host:String, port:int);

		/// [AIR] Calling the checkStatus() method of a SocketMonitor object causes the application to try connecting to the socket, to check for a connect event.
		public function checkStatus():void;

		/// [AIR] Returns the string representation of the specified object.
		public function toString():String;

	}

}

