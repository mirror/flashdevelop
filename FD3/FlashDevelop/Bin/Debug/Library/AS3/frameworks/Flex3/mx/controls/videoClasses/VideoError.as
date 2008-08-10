/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.videoClasses {
	public class VideoError extends Error {
		/**
		 * Contains the error code.
		 */
		public function get code():uint;
		/**
		 * Constructor
		 *
		 * @param errCode           <uint> error code.
		 * @param msg               <String (default = null)> The error message.
		 */
		public function VideoError(errCode:uint, msg:String = null);
		/**
		 * Cannot delete default VideoPlayer
		 */
		public static const DELETE_DEFAULT_PLAYER:uint = 1007;
		/**
		 * Illegal cue point.
		 */
		public static const ILLEGAL_CUE_POINT:uint = 1002;
		/**
		 * Invalid content path.
		 */
		public static const INVALID_CONTENT_PATH:uint = 1004;
		/**
		 * Invalid seek.
		 */
		public static const INVALID_SEEK:uint = 1003;
		/**
		 * Invalid XML.
		 */
		public static const INVALID_XML:uint = 1005;
		/**
		 * No bitrate match.
		 */
		public static const NO_BITRATE_MATCH:uint = 1006;
		/**
		 * Unable to make connection to server or to find FLV on server.
		 */
		public static const NO_CONNECTION:uint = 1000;
		/**
		 * No matching cue point found.
		 */
		public static const NO_CUE_POINT_MATCH:uint = 1001;
	}
}
