/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.utils {
	public interface IDataInput {
		/**
		 * Returns the number of bytes of data available for reading
		 *  in the input buffer.
		 *  User code must call bytesAvailable to ensure
		 *  that sufficient data is available before trying to read
		 *  it with one of the read methods.
		 */
		public function get bytesAvailable():uint;
		/**
		 * The byte order for the data, either the BIG_ENDIAN or LITTLE_ENDIAN constant
		 *  from the Endian class.
		 */
		public function get endian():String;
		public function set endian(value:String):void;
		/**
		 * Used to determine whether the AMF3 or AMF0 format is used when writing or reading binary data using the
		 *  readObject() method. The value is a constant from the ObjectEncoding class.
		 */
		public function get objectEncoding():uint;
		public function set objectEncoding(value:uint):void;
		/**
		 * Reads a Boolean value from the file stream, byte stream, or byte array. A single byte is read
		 *  and true is returned if the byte is nonzero,
		 *  false otherwise.
		 *
		 * @return                  <Boolean> A Boolean value, true if the byte is nonzero,
		 *                            false otherwise.
		 */
		public function readBoolean():Boolean;
		/**
		 * Reads a signed byte from the file stream, byte stream, or byte array.
		 *
		 * @return                  <int> The returned value is in the range -128 to 127.
		 */
		public function readByte():int;
		/**
		 * Reads the number of data bytes, specified by the length parameter,
		 *  from the file stream, byte stream, or byte array. The bytes are read into the
		 *  ByteArray objected specified by the bytes parameter, starting at
		 *  the position specified by offset.
		 *
		 * @param bytes             <ByteArray> The ByteArray object to read
		 *                            data into.
		 * @param offset            <uint (default = 0)> The offset into the bytes parameter at which data
		 *                            read should begin.
		 * @param length            <uint (default = 0)> The number of bytes to read.  The default value
		 *                            of 0 causes all available data to be read.
		 */
		public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void;
		/**
		 * Reads an IEEE 754 double-precision floating point number from the file stream, byte stream, or byte array.
		 *
		 * @return                  <Number> An IEEE 754 double-precision floating point number.
		 */
		public function readDouble():Number;
		/**
		 * Reads an IEEE 754 single-precision floating point number from the file stream, byte stream, or byte array.
		 *
		 * @return                  <Number> An IEEE 754 single-precision floating point number.
		 */
		public function readFloat():Number;
		/**
		 * Reads a signed 32-bit integer from the file stream, byte stream, or byte array.
		 *
		 * @return                  <int> The returned value is in the range -2147483648 to 2147483647.
		 */
		public function readInt():int;
		/**
		 * Reads a multibyte string of specified length from the file stream, byte stream, or byte array using the
		 *  specified character set.
		 *
		 * @param length            <uint> The number of bytes from the byte stream to read.
		 * @param charSet           <String> The string denoting the character set to use to interpret the bytes.
		 *                            Possible character set strings include "shift-jis", "cn-gb",
		 *                            "iso-8859-1", and others.
		 *                            For a complete list, see Supported Character Sets.
		 *                            Note: If the value for the charSet parameter is not recognized by the current
		 *                            system, then Adobe® Flash® Player or
		 *                            Adobe® AIR™ uses the system's default
		 *                            code page as the character set. For example, a value for the charSet parameter, as in
		 *                            myTest.readMultiByte(22, "iso-8859-01"), that uses  01 instead of
		 *                            1 might work on your development machine, but not on another machine. On the other
		 *                            machine, Flash Player or the AIR runtime will use the system's
		 *                            default code page.
		 * @return                  <String> UTF-8 encoded string.
		 */
		public function readMultiByte(length:uint, charSet:String):String;
		/**
		 * Reads an object from the file stream, byte stream, or byte array, encoded in AMF
		 *  serialized format.
		 *
		 * @return                  <*> The deserialized object
		 */
		public function readObject():*;
		/**
		 * Reads a signed 16-bit integer from the file stream, byte stream, or byte array.
		 *
		 * @return                  <int> The returned value is in the range -32768 to 32767.
		 */
		public function readShort():int;
		/**
		 * Reads an unsigned byte from the file stream, byte stream, or byte array.
		 *
		 * @return                  <uint> The returned value is in the range 0 to 255.
		 */
		public function readUnsignedByte():uint;
		/**
		 * Reads an unsigned 32-bit integer from the file stream, byte stream, or byte array.
		 *
		 * @return                  <uint> The returned value is in the range 0 to 4294967295.
		 */
		public function readUnsignedInt():uint;
		/**
		 * Reads an unsigned 16-bit integer from the file stream, byte stream, or byte array.
		 *
		 * @return                  <uint> The returned value is in the range 0 to 65535.
		 */
		public function readUnsignedShort():uint;
		/**
		 * Reads a UTF-8 string from the file stream, byte stream, or byte array.  The string
		 *  is assumed to be prefixed with an unsigned short indicating
		 *  the length in bytes.
		 *
		 * @return                  <String> A UTF-8 string produced by the byte representation of characters.
		 */
		public function readUTF():String;
		/**
		 * Reads a sequence of UTF-8 bytes from the byte stream or byte array and returns a string.
		 *
		 * @param length            <uint> The number of bytes to read.
		 * @return                  <String> A UTF-8 string produced by the byte representation of characters of the specified length.
		 */
		public function readUTFBytes(length:uint):String;
	}
}
