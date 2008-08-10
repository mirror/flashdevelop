/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	public class Base64Decoder {
		/**
		 * Constructor.
		 */
		public function Base64Decoder();
		/**
		 * Decodes a Base64 encoded String and adds the result to an internal
		 *  buffer. Subsequent calls to this method add on to the internal
		 *  buffer. After all data have been encoded, call toByteArray()
		 *  to obtain a decoded flash.utils.ByteArray.
		 *
		 * @param encoded           <String> The Base64 encoded String to decode.
		 */
		public function decode(encoded:String):void;
		/**
		 * Clears all buffers and resets the decoder to its initial state.
		 */
		public function reset():void;
		/**
		 * Returns the current buffer as a decoded flash.utils.ByteArray.
		 *  Note that calling this method also clears the buffer and resets the
		 *  decoder to its initial state.
		 *
		 * @return                  <ByteArray> The decoded flash.utils.ByteArray.
		 */
		public function toByteArray():ByteArray;
	}
}
