package air.net
{
	/// A SocketMonitor object monitors availablity of a TCP endpoint.
	public class SocketMonitor extends ServiceMonitor
	{
		/// [AIR] The host being monitored.
		public function get host () : String;

		/// [AIR] The port being monitored.
		public function get port () : int;

		/// [AIR] Creates a SocketMonitor object for a specified TCP endpoint.
		public function SocketMonitor (host:String, port:int);

		/// [AIR] Returns the string representation of the specified object.
		public function toString () : String;
	}
}
