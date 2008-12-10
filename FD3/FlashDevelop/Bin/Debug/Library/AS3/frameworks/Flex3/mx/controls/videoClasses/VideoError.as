package mx.controls.videoClasses
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The VideoError class represents the error codes for errors  *  thrown by the VideoDisplay control. * *  @see mx.controls.VideoDisplay
	 */
	public class VideoError extends Error
	{
		/**
		 *  @private     *  Base error code
		 */
		private static const BASE_ERROR_CODE : uint = 1000;
		/**
		 *  Unable to make connection to server or to find FLV on server.
		 */
		public static const NO_CONNECTION : uint = 1000;
		/**
		 *  No matching cue point found.
		 */
		public static const NO_CUE_POINT_MATCH : uint = 1001;
		/**
		 *  Illegal cue point.
		 */
		public static const ILLEGAL_CUE_POINT : uint = 1002;
		/**
		 *  Invalid seek.
		 */
		public static const INVALID_SEEK : uint = 1003;
		/**
		 *  Invalid content path.
		 */
		public static const INVALID_CONTENT_PATH : uint = 1004;
		/**
		 *  Invalid XML.
		 */
		public static const INVALID_XML : uint = 1005;
		/**
		 *  No bitrate match.
		 */
		public static const NO_BITRATE_MATCH : uint = 1006;
		/**
		 *  Cannot delete default VideoPlayer
		 */
		public static const DELETE_DEFAULT_PLAYER : uint = 1007;
		/**
		 *  @private     *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private     *  Storage for the code property.
		 */
		private var _code : uint;

		/**
		 *  Contains the error code.
		 */
		public function get code () : uint;

		/**
		 *  Constructor.     *     *  @param The error code.     *     *  @param msg The error message.
		 */
		public function VideoError (errCode:uint, msg:String = null);
	}
}
