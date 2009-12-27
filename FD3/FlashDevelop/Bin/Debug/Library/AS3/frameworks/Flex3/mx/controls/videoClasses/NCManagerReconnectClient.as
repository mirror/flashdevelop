package mx.controls.videoClasses
{
include "../../core/Version.as"
	/**
	 *  @private
 *  Holds client-side functions for remote procedure calls (RPCs) from
 *  the FCS during reconnection.
 *  One of these objects is created and passed to the
 *  <code>NetConnection.client</code> property.
	 */
	public class NCManagerReconnectClient
	{
		public var owner : NCManager;

		public function NCManagerReconnectClient (owner:NCManager = null);

		public function onBWCheck (...rest) : uint;

		public function onBWDone (...rest) : void;
	}
}
