package air.net
{
	import flash.net.URLRequest;

	/// The URLMonitor class monitors availablity of an HTTP- or HTTPS-based service.
	public class URLMonitor extends ServiceMonitor
	{
		/// [AIR] The numeric status codes representing a successful result.
		public function get acceptableStatusCodes () : Array;
		public function set acceptableStatusCodes (value:Array) : void;

		/// [AIR] The URLRequest object representing the probe request.
		public function get urlRequest () : URLRequest;

		/// [AIR] Returns the string representation of the specified object.
		public function toString () : String;

		/// [AIR] Creates a URLMonitor Object for a specified HTTP- or HTTPS-based service.
		public function URLMonitor (urlRequest:URLRequest = null, acceptableStatusCodes:Array = null);
	}
}
