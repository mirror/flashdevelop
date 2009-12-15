package air.net
{
	import flash.net.Socket;

	/// A SocketMonitor object monitors availablity of a TCP endpoint.
	public class SocketMonitor extends ServiceMonitor
	{
		/// The host being monitored.
		public function get host () : String;

		/// The port being monitored.
		public function get port () : int;

		/// Creates a SocketMonitor object for a specified TCP endpoint.
		public function SocketMonitor (host:String, port:int);

		/// Returns the string representation of the specified object.
		public function toString () : String;
	}
}
