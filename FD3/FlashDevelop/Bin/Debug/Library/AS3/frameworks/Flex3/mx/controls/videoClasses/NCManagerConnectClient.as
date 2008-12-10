package mx.controls.videoClasses
{
	import flash.net.NetConnection;

	/**
	 *  @private *  <p>Holds client-side functions for remote procedure calls (rpc) from *  the FCS during initial connection.  One of these objects is created and *  passed to the <code>NetConnection.client</code> property.
	 */
	public class NCManagerConnectClient
	{
		public var owner : NCManager;
		public var netConnection : NetConnection;
		public var connIndex : uint;
		public var pending : Boolean;

		public function NCManagerConnectClient (nc:NetConnection, owner:NCManager = null, connIndex:uint = 0);
		public function onBWDone (...rest) : void;
		public function onBWCheck (...rest) : uint;
		public function onMetaData (...rest) : void;
		public function onPlayStatus (...rest) : void;
		public function close () : void;
	}
}
