/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.filesystem {
	import flash.events.EventDispatcher;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	public class FileStream extends EventDispatcher implements IDataInput, IDataOutput {
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
		 * Specifies whether the AMF3 or AMF0 format is used when writing or reading binary data by using the
		 *  readObject() or writeObject() method.
		 */
		public function get objectEncoding():uint;
		public function set objectEncoding(value:uint):void;
		/**
		 * The current position in the file.
		 */
		public function get position():Number;
		public function set position(value:Number):void;
		/**
		 * When reading files asynchronously, the amount of data requested.
		 */
		public function get readAhead():Number;
		public function set readAhead(value:Number):void;
		/**
		 * Creates a FileStream object.
		 *  Use the open()
		 *  or openAsync() method to open a file.
		 */
		public function FileStream();
		/**
		 * Closes the FileStream object.
		 */
		public function close():void;
		/**
		 * Opens the FileStream object synchronously, pointing to the file specified by the file parameter.
		 *
		 * @param file              <File> The File object specifying the file to open.
		 * @param fileMode          <String> A string from the FileMode class that defines the capabilities of the FileStream, such as
		 *                            the ability to read from or write to the file.
		 */
		public function open(file:File, fileMode:String):void;
		/**
		 * Opens the FileStream object asynchronously, pointing to the file specified by the file parameter.
		 *
		 * @param file              <File> The File object specifying the file to open.
		 * @param fileMode          <String> A string from the FileMode class that defines the capabilities of the FileStream, such as
		 *                            the ability to read from or write to the file.
		 */
		public function openAsync(file:File, fileMode:String):void;
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
		/**
		 * Truncates the file at the position specified by the position property of the FileStream
		 *  object.
		 */
		public function truncate():void;
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
