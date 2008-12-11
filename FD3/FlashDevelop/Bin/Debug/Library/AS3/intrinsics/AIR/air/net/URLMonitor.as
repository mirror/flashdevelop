package air.net
{
	/// The URLMonitor class monitors availablity of an HTTP- or HTTPS-based service.
	public class URLMonitor extends air.net.ServiceMonitor
	{
		/// [AIR] The URLRequest object representing the probe request.
		public var urlRequest:flash.net.URLRequest;

		/// [AIR] The numeric status codes representing a successful result.
		public var acceptableStatusCodes:Array;

		/// [AIR] Creates a URLMonitor Object for a specified HTTP- or HTTPS-based service.
		public function URLMonitor(urlRequest:flash.net.URLRequest, acceptableStatusCodes:Array=null);

		/// [AIR] Attempts to load content from a URL in the background, to check for a returned HTTP status code.
		public function checkStatus():void;

		/// [AIR] Returns the string representation of the specified object.
		public function toString():String;

	}

}

