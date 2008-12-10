package mx.utils
{
	import flash.utils.ByteArray;

	/**
	 * A utility class to encode a String or ByteArray as a Base64 encoded String.
	 */
	public class Base64Encoder
	{
		public static const CHARSET_UTF_8 : String = "UTF-8";
		/**
		 * The character codepoint to be inserted into the encoded output to     * denote a new line if <code>insertNewLines</code> is true.     *      * The default is <code>10</code> to represent the line feed <code>\n</code>.
		 */
		public static var newLine : int;
		/**
		 * A Boolean flag to control whether the sequence of characters specified     * for <code>Base64Encoder.newLine</code> are inserted every 76 characters     * to wrap the encoded output.     *      * The default is true.
		 */
		public var insertNewLines : Boolean;
		/**
		 * An Array of buffer Arrays.
		 */
		private var _buffers : Array;
		private var _count : uint;
		private var _line : uint;
		private var _work : Array;
		/**
		 * This value represents a safe number of characters (i.e. arguments) that     * can be passed to String.fromCharCode.apply() without exceeding the AVM+     * stack limit.     *      * @private
		 */
		public static const MAX_BUFFER_SIZE : uint = 32767;
		private static const ESCAPE_CHAR_CODE : Number = 61;
		/**
		 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',        'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',        'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',        'o', 'p', 'q', 'r', 's', 't', 'u', 'v',        'w', 'x', 'y', 'z', '0', '1', '2', '3',        '4', '5', '6', '7', '8', '9', '+', '/'
		 */
		private static const ALPHABET_CHAR_CODES : Array = [];

		/**
		 * Constructor.
		 */
		public function Base64Encoder ();
		/**
		 * @private
		 */
		public function drain () : String;
		/**
		 * Encodes the characters of a String in Base64 and adds the result to     * an internal buffer. Subsequent calls to this method add on to the     * internal buffer. After all data have been encoded, call     * <code>toString()</code> to obtain a Base64 encoded String.     *      * @param data The String to encode.     * @param offset The character position from which to start encoding.     * @param length The number of characters to encode from the offset.
		 */
		public function encode (data:String, offset:uint = 0, length:uint = 0) : void;
		/**
		 * Encodes the UTF-8 bytes of a String in Base64 and adds the result to an     * internal buffer. The UTF-8 information does not contain a length prefix.      * Subsequent calls to this method add on to the internal buffer. After all     * data have been encoded, call <code>toString()</code> to obtain a Base64     * encoded String.     *      * @param data The String to encode.
		 */
		public function encodeUTFBytes (data:String) : void;
		/**
		 * Encodes a ByteArray in Base64 and adds the result to an internal buffer.     * Subsequent calls to this method add on to the internal buffer. After all     * data have been encoded, call <code>toString()</code> to obtain a     * Base64 encoded String.     *      * @param data The ByteArray to encode.     * @param offset The index from which to start encoding.     * @param length The number of bytes to encode from the offset.
		 */
		public function encodeBytes (data:ByteArray, offset:uint = 0, length:uint = 0) : void;
		/**
		 * @private
		 */
		public function flush () : String;
		/**
		 * Clears all buffers and resets the encoder to its initial state.
		 */
		public function reset () : void;
		/**
		 * Returns the current buffer as a Base64 encoded String. Note that     * calling this method also clears the buffer and resets the      * encoder to its initial state.     *      * @return The Base64 encoded String.
		 */
		public function toString () : String;
		/**
		 * @private
		 */
		private function encodeBlock () : void;
	}
}
