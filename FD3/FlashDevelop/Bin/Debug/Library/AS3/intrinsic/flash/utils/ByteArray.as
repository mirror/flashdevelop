/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.utils {
	public class ByteArray implements IDataInput, IDataOutput {
		/**
		 * The number of bytes of data available for reading
		 *  from the current position in the byte array to the
		 *  end of the array.
		 */
		public function get bytesAvailable():uint;
		/**
		 * Denotes the default object encoding for the ByteArray class to use for a new ByteArray instance.
		 *  When you create a new ByteArray instance, the encoding on that instance starts
		 *  with the value of defaultObjectEncoding.
		 *  The defaultObjectEncoding property is initialized to ObjectEncoding.AMF3.
		 */
		public static function get defaultObjectEncoding():uint;
		public function set defaultObjectEncoding(value:uint):void;
		/**
		 * Changes or reads the byte order for the data; either Endian.BIG_ENDIAN or
		 *  Endian.LITTLE_ENDIAN.
		 */
		public function get endian():String;
		public function set endian(value:String):void;
		/**
		 * The length of the ByteArray object, in bytes.
		 */
		public function get length():uint;
		public function set length(value:uint):void;
		/**
		 * Used to determine whether the ActionScript 3.0, ActionScript 2.0, or ActionScript 1.0 format should be
		 *  used when writing to, or reading from, a ByteArray instance. The value is a
		 *  constant from the ObjectEncoding class.
		 */
		public function get objectEncoding():uint;
		public function set objectEncoding(value:uint):void;
		/**
		 * Moves, or returns the current position, in bytes, of the file
		 *  pointer into the ByteArray object. This is the
		 *  point at which the next call to a read
		 *  method starts reading or a write
		 *  method starts writing.
		 */
		public function get position():uint;
		public function set position(value:uint):void;
		/**
		 * Creates a ByteArray instance representing a packed array of bytes, so that you can use the methods and properties in this class to optimize your data storage and stream.
		 */
		public function ByteArray();
		/**
		 * Compresses the byte array. The entire byte array is compressed. For content
		 *  running in Adobe AIR, you can specify a compression algorithm by passing a
		 *  value (defined in the CompressionAlgorithm class) as the algorithm
		 *  parameter. Flash Player supports only the default
		 *  algorithm, deflate.
		 *
		 * @param algorithm         <String (default = NaN)> The compression algorithm to use when compressing. Valid values are defined as
		 *                            constants in the CompressionAlgorithm class. The default is to use zlib format. This parameter
		 *                            is only recognized for content running in Adobe AIR. Flash Player
		 *                            supports only the default algorithm, deflate, and throws an exception if you attempt to pass
		 *                            a value for this parameter.
		 */
		public function compress(algorithm:String):void;
		/**
		 * Reads a Boolean value from the byte stream. A single byte is read,
		 *  and true is returned if the byte is nonzero,
		 *  false otherwise.
		 *
		 * @return                  <Boolean> Returns true if the byte is nonzero, false otherwise.
		 */
		public function readBoolean():Boolean;
		/**
		 * Reads a signed byte from the byte stream.
		 *
		 * @return                  <int> An integer between -128 and 127.
		 */
		public function readByte():int;
		/**
		 * Reads the number of data bytes, specified by the length parameter, from the byte stream.
		 *  The bytes are read into the ByteArray object specified by the bytes parameter,
		 *  and the bytes are written into the destination ByteArray starting at the position specified by offset.
		 *
		 * @param bytes             <ByteArray> The ByteArray object to read data into.
		 * @param offset            <uint (default = 0)> The offset (position) in bytes at which the read data should be written.
		 * @param length            <uint (default = 0)> The number of bytes to read.  The default value of 0 causes all available data to be read.
		 */
		public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void;
		/**
		 * Reads an IEEE 754 double-precision (64-bit) floating-point number from the byte stream.
		 *
		 * @return                  <Number> A double-precision (64-bit) floating-point number.
		 */
		public function readDouble():Number;
		/**
		 * Reads an IEEE 754 single-precision (32-bit) floating-point number from the byte stream.
		 *
		 * @return                  <Number> A single-precision (32-bit) floating-point number.
		 */
		public function readFloat():Number;
		/**
		 * Reads a signed 32-bit integer from the byte stream.
		 *
		 * @return                  <int> A 32-bit signed integer between -2147483648 and 2147483647.
		 */
		public function readInt():int;
		/**
		 * Reads a multibyte string of specified length from the byte stream using the
		 *  specified character set.
		 *
		 * @param length            <uint> The number of bytes from the byte stream to read.
		 * @param charSet           <String> The string denoting the character set to use to interpret the bytes.
		 *                            Possible character set strings include "shift-jis", "cn-gb",
		 *                            "iso-8859-1", and others.
		 *                            For a complete list, see Supported Character Sets.
		 *                            Note: If the value for the charSet parameter
		 *                            is not recognized by the current system, the application uses the system's default
		 *                            code page as the character set. For example, a value for the charSet parameter,
		 *                            as in myTest.readMultiByte(22, "iso-8859-01") that uses 01 instead of
		 *                            1 might work on your development machine, but not on another machine.
		 *                            On the other machine, the application will use the system's default code page.
		 * @return                  <String> UTF-8 encoded string.
		 */
		public function readMultiByte(length:uint, charSet:String):String;
		/**
		 * Reads an object from the byte array, encoded in AMF
		 *  serialized format.
		 *
		 * @return                  <*> The deserialized object.
		 */
		public function readObject():*;
		/**
		 * Reads a signed 16-bit integer from the byte stream.
		 *
		 * @return                  <int> A 16-bit signed integer between -32768 and 32767.
		 */
		public function readShort():int;
		/**
		 * Reads an unsigned byte from the byte stream.
		 *
		 * @return                  <uint> A 32-bit unsigned integer between 0 and 255.
		 */
		public function readUnsignedByte():uint;
		/**
		 * Reads an unsigned 32-bit integer from the byte stream.
		 *
		 * @return                  <uint> A 32-bit unsigned integer between 0 and 4294967295.
		 */
		public function readUnsignedInt():uint;
		/**
		 * Reads an unsigned 16-bit integer from the byte stream.
		 *
		 * @return                  <uint> A 16-bit unsigned integer between 0 and 65535.
		 */
		public function readUnsignedShort():uint;
		/**
		 * Reads a UTF-8 string from the byte stream.  The string
		 *  is assumed to be prefixed with an unsigned short indicating
		 *  the length in bytes.
		 *
		 * @return                  <String> UTF-8 encoded  string.
		 */
		public function readUTF():String;
		/**
		 * Reads a sequence of UTF-8 bytes specified by the length
		 *  parameter from the byte stream and returns a string.
		 *
		 * @param length            <uint> An unsigned short indicating the length of the UTF-8 bytes.
		 * @return                  <String> A string composed of the UTF-8 bytes of the specified length.
		 */
		public function readUTFBytes(length:uint):String;
		/**
		 * Converts the byte array to a string.
		 *  If the data in the array begins with a Unicode byte order mark, the application will honor that mark
		 *  when converting to a string. If System.useCodePage is set to true, the
		 *  application will treat the data in the array as being in the current system code page when converting.
		 *
		 * @return                  <String> The string representation of the byte array.
		 */
		public function toString():String;
		/**
		 * Decompresses the byte array. For content running in Adobe AIR, you can specify
		 *  a compression algorithm by passing a value (defined in the CompressionAlgorithm class)
		 *  as the algorithm parameter. The byte array must have been compressed
		 *  using the same algorithm. Flash Player supports only the
		 *  default algorithm, deflate.
		 *
		 * @param algorithm         <String (default = NaN)> The compression algorithm to use when decompressing. This must be the
		 *                            same compression algorithm used to compress the data. Valid values are defined as
		 *                            constants in the CompressionAlgorithm class. The default is to use zlib format. This parameter
		 *                            is only recognized for content running in Adobe AIR. Flash Player
		 *                            supports only the default algorithm, deflate, and throws an exception if you attempt to pass
		 *                            a value for this parameter.
		 */
		public function uncompress(algorithm:String):void;
		/**
		 * Writes a Boolean value. A single byte is written according to the value parameter,
		 *  either 1 if true or 0 if false.
		 *
		 * @param value             <Boolean> A Boolean value determining which byte is written. If the parameter is true,
		 *                            the method writes a 1; if false, the method writes a 0.
		 */
		public function writeBoolean(value:Boolean):void;
		/**
		 * Writes a byte to the byte stream.
		 *
		 * @param value             <int> A 32-bit integer. The low 8 bits are written to the byte stream.
		 */
		public function writeByte(value:int):void;
		/**
		 * Writes a sequence of length bytes from the
		 *  specified byte array, bytes,
		 *  starting offset (zero-based index) bytes
		 *  into the byte stream.
		 *
		 * @param bytes             <ByteArray> The ByteArray object.
		 * @param offset            <uint (default = 0)> A zero-based index indicating the position into the array to begin writing.
		 * @param length            <uint (default = 0)> An unsigned integer indicating how far into the buffer to write.
		 */
		public function writeBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void;
		/**
		 * Writes an IEEE 754 double-precision (64-bit) floating-point number to the byte stream.
		 *
		 * @param value             <Number> A double-precision (64-bit) floating-point number.
		 */
		public function writeDouble(value:Number):void;
		/**
		 * Writes an IEEE 754 single-precision (32-bit) floating-point number to the byte stream.
		 *
		 * @param value             <Number> A single-precision (32-bit) floating-point number.
		 */
		public function writeFloat(value:Number):void;
		/**
		 * Writes a 32-bit signed integer to the byte stream.
		 *
		 * @param value             <int> An integer to write to the byte stream.
		 */
		public function writeInt(value:int):void;
		/**
		 * Writes a multibyte string to the byte stream using the specified character set.
		 *
		 * @param value             <String> The string value to be written.
		 * @param charSet           <String> The string denoting the character set to use. Possible character set strings
		 *                            include "shift-jis", "cn-gb", "iso-8859-1", and others.
		 *                            For a complete list, see Supported Character Sets.
		 */
		public function writeMultiByte(value:String, charSet:String):void;
		/**
		 * Writes an object into the byte array in AMF
		 *  serialized format.
		 *
		 * @param object            <*> The object to serialize.
		 */
		public function writeObject(object:*):void;
		/**
		 * Writes a 16-bit integer to the byte stream. The low 16 bits of the parameter are used.
		 *  The high 16 bits are ignored.
		 *
		 * @param value             <int> 32-bit integer, whose low 16 bits are written to the byte stream.
		 */
		public function writeShort(value:int):void;
		/**
		 * Writes a 32-bit unsigned integer to the byte stream.
		 *
		 * @param value             <uint> An unsigned integer to write to the byte stream.
		 */
		public function writeUnsignedInt(value:uint):void;
		/**
		 * Writes a UTF-8 string to the byte stream. The length of the UTF-8 string in bytes
		 *  is written first, as a 16-bit integer, followed by the bytes representing the
		 *  characters of the string.
		 *
		 * @param value             <String> The string value to be written.
		 */
		public function writeUTF(value:String):void;
		/**
		 * Writes a UTF-8 string to the byte stream. Similar to the writeUTF() method,
		 *  but writeUTFBytes() does not prefix the string with a 16-bit length word.
		 *
		 * @param value             <String> The string value to be written.
		 */
		public function writeUTFBytes(value:String):void;
	}
}
