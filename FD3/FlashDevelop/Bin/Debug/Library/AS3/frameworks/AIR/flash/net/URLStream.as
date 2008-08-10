/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.net {
	import flash.events.EventDispatcher;
	import flash.utils.IDataInput;
	import flash.utils.ByteArray;
	public class URLStream extends EventDispatcher implements IDataInput {
		/**
		 * Returns the number of bytes of data available for reading
		 *  in the input buffer.
		 *  Your code must call the bytesAvailable property to ensure
		 *  that sufficient data is available before you try to read
		 *  it with one of the read methods.
		 */
		public function get bytesAvailable():uint;
		/**
		 * Indicates whether this URLStream object is
		 *  currently connected. A call to this property returns a value of true
		 *  if the URLStream object is connected, or false otherwise.
		 */
		public function get connected():Boolean;
		/**
		 * Indicates the byte order for the data. Possible values are
		 *  Endian.BIG_ENDIAN or Endian.LITTLE_ENDIAN.
		 */
		public function get endian():String;
		public function set endian(value:String):void;
		/**
		 * Controls the version of Action Message Format (AMF) used when writing or reading an object.
		 */
		public function get objectEncoding():uint;
		public function set objectEncoding(value:uint):void;
		/**
		 * Immediately closes the stream and
		 *  cancels the download operation.
		 *  No data can be read from the stream after the close() method is called.
		 */
		public function close():void;
		/**
		 * Begins downloading the URL specified in the request parameter.
		 *
		 * @param request           <URLRequest> A URLRequest object specifying the URL to download. If the value of
		 *                            this parameter or the URLRequest.url property of the URLRequest object
		 *                            passed are null, the application throws a null pointer error.
		 */
		public function load(request:URLRequest):void;
		/**
		 * Reads a Boolean value from the stream. A single byte is read,
		 *  and true is returned if the byte is nonzero,
		 *  false otherwise.
		 *
		 * @return                  <Boolean> True is returned if the byte is nonzero, false otherwise.
		 */
		public function readBoolean():Boolean;
		/**
		 * Reads a signed byte from the stream.
		 *
		 * @return                  <int> Value in the range -128...127.
		 */
		public function readByte():int;
		/**
		 * Reads length bytes of data from the stream.
		 *  The bytes are read into the ByteArray object specified
		 *  by bytes, starting offset bytes into
		 *  the ByteArray object.
		 *
		 * @param bytes             <ByteArray> The ByteArray object to read
		 *                            data into.
		 * @param offset            <uint (default = 0)> The offset into bytes at which data
		 *                            read should begin.  Defaults to 0.
		 * @param length            <uint (default = 0)> The number of bytes to read.  The default value
		 *                            of 0 will cause all available data to be read.
		 */
		public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void;
		/**
		 * Reads an IEEE 754 double-precision floating-point number from the stream.
		 *
		 * @return                  <Number> An IEEE 754 double-precision floating-point number from the stream.
		 */
		public function readDouble():Number;
		/**
		 * Reads an IEEE 754 single-precision floating-point number from the stream.
		 *
		 * @return                  <Number> An IEEE 754 single-precision floating-point number from the stream.
		 */
		public function readFloat():Number;
		/**
		 * Reads a signed 32-bit integer from the stream.
		 *
		 * @return                  <int> Value in the range -2147483648...2147483647.
		 */
		public function readInt():int;
		/**
		 * Reads a multibyte string of specified length from the byte stream using the
		 *  specified character set.
		 *
		 * @param length            <uint> The number of bytes from the byte stream to read.
		 * @param charSet           <String> The string denoting the character set to use to interpret the bytes.
		 *                            Possible character set strings include "shift_jis", "CN-GB",
		 *                            "iso-8859-1", and others.
		 *                            For a complete list, see Supported Character Sets.
		 *                            Note: If the value for the charSet parameter is not recognized
		 *                            by the current system, the application uses the system's default code page as the character set.
		 *                            For example, a value for the charSet parameter, as in
		 *                            myTest.readMultiByte(22, "iso-8859-01") that uses 01 instead of 1
		 *                            might work on your development machine, but not on another machine. On the other machine,
		 *                            the application will use the system's default code page.
		 * @return                  <String> UTF-8 encoded string.
		 */
		public function readMultiByte(length:uint, charSet:String):String;
		/**
		 * Reads an object from the socket, encoded in Action Message Format (AMF).
		 *
		 * @return                  <*> The deserialized object.
		 */
		public function readObject():*;
		/**
		 * Reads a signed 16-bit integer from the stream.
		 *
		 * @return                  <int> Value in the range -32768...32767.
		 */
		public function readShort():int;
		/**
		 * Reads an unsigned byte from the stream.
		 *
		 * @return                  <uint> Value in the range 0...255.
		 */
		public function readUnsignedByte():uint;
		/**
		 * Reads an unsigned 32-bit integer from the stream.
		 *
		 * @return                  <uint> Value in the range 0...4294967295.
		 */
		public function readUnsignedInt():uint;
		/**
		 * Reads an unsigned 16-bit integer from the stream.
		 *
		 * @return                  <uint> Value in the range 0...65535.
		 */
		public function readUnsignedShort():uint;
		/**
		 * Reads a UTF-8 string from the stream.  The string
		 *  is assumed to be prefixed with an unsigned short indicating
		 *  the length in bytes.
		 *
		 * @return                  <String> A UTF-8 string.
		 */
		public function readUTF():String;
		/**
		 * Reads a sequence of length UTF-8
		 *  bytes from the stream, and returns a string.
		 *
		 * @param length            <uint> A sequence of UTF-8 bytes.
		 * @return                  <String> A UTF-8 string produced by the byte representation of characters of specified length.
		 */
		public function readUTFBytes(length:uint):String;
	}
}
