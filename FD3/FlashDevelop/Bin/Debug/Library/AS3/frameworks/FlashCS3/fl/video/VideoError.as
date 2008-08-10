package fl.video
{
/**
* The VideoError exception is the primary mechanism for reporting runtime errors from the      * FLVPlayback and VideoPlayer classes.     *     * @tiptext VideoError class     * @langversion 3.0     * @playerversion Flash 9.0.28.0
*/
public class VideoError extends Error
{
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal static const BASE_ERROR_CODE : uint;
	/**
	* State variable indicating that Flash Player is unable to make a connection to the server          * or to find the FLV file on the server.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const NO_CONNECTION : uint;
	/**
	* State variable indicating the illegal cue point.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const ILLEGAL_CUE_POINT : uint;
	/**
	* State variable indicating an invalid seek.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const INVALID_SEEK : uint;
	/**
	* State variable indicating an invalid source.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const INVALID_SOURCE : uint;
	/**
	* State variable indicating invalid XML.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const INVALID_XML : uint;
	/**
	* State variable indicating that there is no bitrate match.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const NO_BITRATE_MATCH : uint;
	/**
	* State variable indicating that the user cannot delete the default VideoPlayer object.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const DELETE_DEFAULT_PLAYER : uint;
	/**
	* State variable indicating that the INCManager class is not set.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const INCMANAGER_CLASS_UNSET : uint;
	/**
	* State variable indicating that a <code>null</code> URL was sent to the          * <code>load()</code> method.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const NULL_URL_LOAD : uint;
	/**
	* State variable indicating a missing skin style.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const MISSING_SKIN_STYLE : uint;
	/**
	* State variable indicating that an unsupported property was passed to the          * INCManager class, or the <code>getProperty</code> or <code>setProperty</code>          * methods.	 *	 * @see INCManager#getProperty()	 * @see INCManager#setProperty()         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const UNSUPPORTED_PROPERTY : uint;
		private var _code : uint;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal static const ERROR_MSG : Array;

	/**
	* The code that corresponds to the error. The error code is passed into the constructor.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get code () : uint;

	/**
	* Creates a new VideoError object.         *         * @param errCode The code that corresponds to the error.         *         * @param msg The error message.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function VideoError (errCode:uint, msg:String =null);
}
}
