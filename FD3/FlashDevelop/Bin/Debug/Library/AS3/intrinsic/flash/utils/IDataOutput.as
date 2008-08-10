/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.utils {
	public interface IDataOutput {
		/**
		 * The byte order for the data, either the BIG_ENDIAN or LITTLE_ENDIAN
		 *  constant from the Endian class.
		 */
		public function get endian():String;
		public function set endian(value:String):void;
		/**
		 * Used to determine whether the AMF3 or AMF0 format is used when writing or reading binary data using the
		 *  writeObject() method. The value is a constant from the ObjectEncoding class.
		 */
		public function get objectEncoding():uint;
		public function set objectEncoding(value:uint):void;
		/**
		 * Writes a Boolean value. A single byte is written according to the value parameter,
		 *  either 1 if true or 0 if false.
		 *
		 * @param value             <Boolean> A Boolean value determining which byte is written. If the parameter is true,
		 *                            1 is written; if false, 0 is written.
		 */
		public function writeBoolean(value:Boolean):void;
		/**
		 * Writes a byte.
		 *  The low 8 bits of the
		 *  parameter are used; the high 24 bits are ignored.
		 *
		 * @param value             <int> A byte value as an integer.
		 */
		public function writeByte(value:int):void;
		/**
		 * Writes a sequence of bytes from the
		 *  specified byte array, bytes,
		 *  starting offset(zero-based index) bytes
		 *  with a length specified by length,
		 *  into the file stream, byte stream, or byte array.
		 *
		 * @param bytes             <ByteArray> The byte array to write.
		 * @param offset            <uint (default = 0)> A zero-based index specifying the position into the array to begin writing.
		 * @param length            <uint (default = 0)> An unsigned integer specifying how far into the buffer to write.
		 */
		public function writeBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void;
		/**
		 * Writes an IEEE 754 double-precision (64-bit) floating point number.
		 *
		 * @param value             <Number> A double-precision (64-bit) floating point number.
		 */
		public function writeDouble(value:Number):void;
		/**
		 * Writes an IEEE 754 single-precision (32-bit) floating point number.
		 *
		 * @param value             <Number> A single-precision (32-bit) floating point number.
		 */
		public function writeFloat(value:Number):void;
		/**
		 * Writes a 32-bit signed integer.
		 *
		 * @param value             <int> A byte value as a signed integer.
		 */
		public function writeInt(value:int):void;
		/**
		 * Writes a multibyte string to the file stream, byte stream, or byte array, using the specified character set.
		 *
		 * @param value             <String> The string value to be written.
		 * @param charSet           <String> The string denoting the character set to use. Possible character set strings
		 *                            include "shift-jis", "cn-gb", "iso-8859-1", and others.
		 *                            For a complete list, see Supported Character Sets.
		 */
		public function writeMultiByte(value:String, charSet:String):void;
		/**
		 * Writes an object to the file stream, byte stream, or byte array, in AMF serialized
		 *  format.
		 *
		 * @param object            <*> The object to be serialized.
		 */
		public function writeObject(object:*):void;
		/**
		 * Writes a 16-bit integer. The low 16 bits of the parameter are used;
		 *  the high 16 bits are ignored.
		 *
		 * @param value             <int> A byte value as an integer.
		 */
		public function writeShort(value:int):void;
		/**
		 * Writes a 32-bit unsigned integer.
		 *
		 * @param value             <uint> A byte value as an unsigned integer.
		 */
		public function writeUnsignedInt(value:uint):void;
		/**
		 * Writes a UTF-8 string to the file stream, byte stream, or byte array. The length of the UTF-8 string in bytes
		 *  is written first, as a 16-bit integer, followed by the bytes representing the
		 *  characters of the string.
		 *
		 * @param value             <String> The string value to be written.
		 */
		public function writeUTF(value:String):void;
		/**
		 * Writes a UTF-8 string. Similar to writeUTF(),
		 *  but does not prefix the string with a 16-bit length word.
		 *
		 * @param value             <String> The string value to be written.
		 */
		public function writeUTFBytes(value:String):void;
	}
}
