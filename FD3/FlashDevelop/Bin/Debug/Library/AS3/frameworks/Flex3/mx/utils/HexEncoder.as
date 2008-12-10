package mx.utils
{
	import flash.utils.ByteArray;

	/**
	 *  Documentation is not currently available. *  Ported to ActionScript from flex/messaging/util/Hex.java *  @private
	 */
	public class HexEncoder
	{
		/**
		 *  @private     *  Set encodingStyle to this value to encode using upper case 'A'-'F'.
		 */
		public static const UPPER_CASE : String = "upper";
		/**
		 *  @private     *  Set encodingStyle to this value to encode using lower case 'a'-'f'.
		 */
		public static const LOWER_CASE : String = "lower";
		/**
		 *  @private     *  The default encoding style for all HexEncoders.
		 */
		public static var encodingStyle : String;
		/**
		 *  @private     *  The encoding style for this HexEncoder instance.     *  If not set, the default static encodingStyle is used.
		 */
		public var encodingStyle : String;
		/**
		 *  An Array of buffer Arrays.      *  @private
		 */
		private var _buffers : Array;
		/**
		 *  @private
		 */
		private var _work : int;
		/**
		 * This value represents a safe number of characters (i.e. arguments) that     * can be passed to String.fromCharCode.apply() without exceeding the AVM+     * stack limit.     *      * @private
		 */
		public static const MAX_BUFFER_SIZE : uint = 32767;
		/**
		 '0', '1', '2', '3', '4', '5', '6', '7',        '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
		 */
		private static const UPPER_CHAR_CODES : Array = [];
		/**
		 '0', '1', '2', '3', '4', '5', '6', '7',        '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'
		 */
		private static const LOWER_CHAR_CODES : Array = [];

		/**
		 *  @private     *  Constructor.
		 */
		public function HexEncoder ();
		/**
		 *  @private
		 */
		public function encode (data:ByteArray, offset:uint = 0, length:uint = 0) : void;
		/**
		 *  @private
		 */
		public function drain () : String;
		/**
		 *  @private
		 */
		public function flush () : String;
		/**
		 *  @private
		 */
		private function encodeBlock (_work:int, digits:Array) : void;
	}
}
