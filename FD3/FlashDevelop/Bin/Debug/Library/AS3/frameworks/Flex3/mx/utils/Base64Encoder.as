/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	import flash.utils.ByteArray;
	public class Base64Encoder {
		/**
		 * A Boolean flag to control whether the sequence of characters specified
		 *  for Base64Encoder.newLine are inserted every 76 characters
		 *  to wrap the encoded output.
		 *  The default is true.
		 */
		public var insertNewLines:Boolean = true;
		/**
		 * The character codepoint to be inserted into the encoded output to
		 *  denote a new line if insertNewLines is true.
		 *  The default is 10 to represent the line feed \n.
		 */
		public static var newLine:int = 10;
		/**
		 * Constructor.
		 */
		public function Base64Encoder();
		/**
		 * Encodes the characters of a String in Base64 and adds the result to
		 *  an internal buffer. Subsequent calls to this method add on to the
		 *  internal buffer. After all data have been encoded, call
		 *  toString() to obtain a Base64 encoded String.
		 *
		 * @param data              <String> The String to encode.
		 * @param offset            <uint (default = 0)> The character position from which to start encoding.
		 * @param length            <uint (default = 0)> The number of characters to encode from the offset.
		 */
		public function encode(data:String, offset:uint = 0, length:uint = 0):void;
		/**
		 * Encodes a ByteArray in Base64 and adds the result to an internal buffer.
		 *  Subsequent calls to this method add on to the internal buffer. After all
		 *  data have been encoded, call toString() to obtain a
		 *  Base64 encoded String.
		 *
		 * @param data              <ByteArray> The ByteArray to encode.
		 * @param offset            <uint (default = 0)> The index from which to start encoding.
		 * @param length            <uint (default = 0)> The number of bytes to encode from the offset.
		 */
		public function encodeBytes(data:ByteArray, offset:uint = 0, length:uint = 0):void;
		/**
		 * Encodes the UTF-8 bytes of a String in Base64 and adds the result to an
		 *  internal buffer. The UTF-8 information does not contain a length prefix.
		 *  Subsequent calls to this method add on to the internal buffer. After all
		 *  data have been encoded, call toString() to obtain a Base64
		 *  encoded String.
		 *
		 * @param data              <String> The String to encode.
		 */
		public function encodeUTFBytes(data:String):void;
		/**
		 * Clears all buffers and resets the encoder to its initial state.
		 */
		public function reset():void;
		/**
		 * Returns the current buffer as a Base64 encoded String. Note that
		 *  calling this method also clears the buffer and resets the
		 *  encoder to its initial state.
		 *
		 * @return                  <String> The Base64 encoded String.
		 */
		public function toString():String;
		/**
		 */
		public static const CHARSET_UTF_8:String = "UTF-8";
	}
}
