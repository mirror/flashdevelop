/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.channels {
	import flash.net.NetConnection;
	public class NetConnectionChannel extends PollingChannel {
		/**
		 * Provides access to the associated NetConnection for this Channel.
		 */
		public function get netConnection():NetConnection;
		/**
		 * Creates a new NetConnectionChannel instance.
		 *
		 * @param id                <String (default = null)> The id of this Channel.
		 * @param uri               <String (default = null)> The uri for this Channel.
		 */
		public function NetConnectionChannel(id:String = null, uri:String = null);
	}
}
