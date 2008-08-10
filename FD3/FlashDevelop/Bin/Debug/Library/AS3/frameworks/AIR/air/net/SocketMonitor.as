/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package air.net {
	public class SocketMonitor extends ServiceMonitor {
		/**
		 * The host being monitored.
		 */
		public function get host():String;
		/**
		 * The port being monitored.
		 */
		public function get port():int;
		/**
		 * Creates a SocketMonitor object for a specified TCP endpoint.
		 *
		 * @param host              <String> The host to monitor.
		 * @param port              <int> The port to monitor.
		 */
		public function SocketMonitor(host:String, port:int);
		/**
		 * Calling the checkStatus() method of a SocketMonitor object causes
		 *  the application to try connecting to the socket, to check for a
		 *  connect event.
		 */
		protected override function checkStatus():void;
		/**
		 * Returns the string representation of the specified object.
		 *
		 * @return                  <String> A string representation of the object.
		 */
		public override function toString():String;
	}
}
