package mx.events
{
include "../core/Version.as"
	/**
	 *  The InvalidateRequestData class defines constants for the values 
 *  of the <code>data</code> property of a SWFBridgeRequest object when
 *  used with the <code>SWFBridgeRequest.INVALIDATE_REQUEST</code> request.
	 */
	public class InvalidateRequestData
	{
		/**
		 *  Bit to indicate the request handler should invalidate
     *  their properties.
		 */
		public static const PROPERTIES : uint = 0x0002;
		/**
		 *  Bit to indicate the request handler should invalidate
     *  their size.
		 */
		public static const SIZE : uint = 0x0004;
		/**
		 *  Bit to indicate the request handler should invalidate
     *  their display list.
		 */
		public static const DISPLAY_LIST : uint = 0x0001;
	}
}
