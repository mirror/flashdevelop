/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	import flash.events.EventDispatcher;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	public class Socket extends EventDispatcher implements IDataInput, IDataOutput {
		/**
		 * The number of bytes of data available for reading in the input buffer.
		 */
		public function get bytesAvailable():uint;
		/**
		 * Indicates whether this Socket object is currently connected.
		 *  A call to this property returns a value of true if the socket
		 *  is currently connected, or false otherwise.
		 */
		public function get connected():Boolean;
		/**
		 * Indicates the byte order for the data; possible values are
		 *  constants from the flash.utils.Endian class,
		 *  Endian.BIG_ENDIAN or Endian.LITTLE_ENDIAN.
		 */
		public function get endian():String;
		public function set endian(value:String):void;
		/**
		 * Controls the version of AMF used when writing or reading an object.
		 */
		public function get objectEncoding():uint;
		public function set objectEncoding(value:uint):void;
		/**
		 * Creates a Socket object.  If no
		 *  parameters are specified, an initially disconnected socket
		 *  is created.  If parameters are specified, a connection
		 *  is attempted to the specified host and port.
		 *
		 * @param host              <String (default = null)> The name of the host to connect to. If this parameter is not specified, an initially disconnected socket
		 *                            is created.
		 * @param port              <int (default = 0)> The port number to connect to. If this parameter is not specified, an initially disconnected socket
		 *                            is created.
		 */
		public function Socket(host:String = null, port:int = 0);
		/**
		 * Closes the socket. You cannot read or write any data after the close() method
		 *  has been called.
		 */
		public function close():void;
		/**
		 * Connects the socket to the specified host and port.
		 *  If the connection fails immediately, either an event is dispatched
		 *  or an exception is thrown: an error event is dispatched if a host was
		 *  specified, and an exception is thrown if no host was specified.
		 *  Otherwise, the status of the connection is reported by an event.
		 *  If the socket is already connected, the existing connection is closed first.
		 *
		 * @param host              <String> The name of the host to connect to. If no host is specified,
		 *                            the host that is contacted is the host where the calling file
		 *                            resides. If you do not specify a host, use an event listener to
		 *                            determine whether the connection was successful.
		 * @param port              <int> The port number to connect to.
		 */
		public function connect(host:String, port:int):void;
		/**
		 * Flushes any accumulated data in the socket's output buffer.
		 *  Data written by the write methods is not
		 *  immediately transmitted; it is queued until the
		 *  flush() method is called.
		 */
		public function flush():void;
		/**
		 * Reads a Boolean value from the socket. After reading a single byte, the
		 *  method returns true if the byte is nonzero, and
		 *  false otherwise.
		 *
		 * @return                  <Boolean> A value of true if the byte read is nonzero,
		 *                            otherwise false.
		 */
		public function readBoolean():Boolean;
		/**
		 * Reads a signed byte from the socket.
		 *
		 * @return                  <int> A value from -128 to 127.
		 */
		public function readByte():int;
		/**
		 * Reads the number of data bytes specified by the length
		 *  parameter from the socket. The bytes are read into the specified byte
		 *  array, starting at the position indicated by offset.
		 *
		 * @param bytes             <ByteArray> The ByteArray object to read data into.
		 * @param offset            <uint (default = 0)> The offset at which data reading should begin in the byte
		 *                            array.
		 * @param length            <uint (default = 0)> The number of bytes to read. The default value of 0 causes
		 *                            all available data to be read.
		 */
		public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void;
		/**
		 * Reads an IEEE 754 double-precision floating-point number from the socket.
		 *
		 * @return                  <Number> An IEEE 754 double-precision floating-point number.
		 */
		public function readDouble():Number;
		/**
		 * Reads an IEEE 754 single-precision floating-point number from the socket.
		 *
		 * @return                  <Number> An IEEE 754 single-precision floating-point number.
		 */
		public function readFloat():Number;
		/**
		 * Reads a signed 32-bit integer from the socket.
		 *
		 * @return                  <int> A value from -2147483648 to 2147483647.
		 */
		public function readInt():int;
		/**
		 * Reads a multibyte string from the byte stream, using the specified character set.
		 *
		 * @param length            <uint> The number of bytes from the byte stream to read.
		 * @param charSet           <String> The string denoting the character set to use to interpret the bytes.
		 *                            Possible character set strings include "shift_jis", "CN-GB", and
		 *                            "iso-8859-1".
		 *                            For a complete list, see Supported Character Sets.
		 *                            Note: If the value for the charSet parameter is not recognized
		 *                            by the current system, then the application uses the system's default code page as the character set.
		 *                            For example, a value for the charSet parameter, as in myTest.readMultiByte(22,
		 *                            "iso-8859-01") that uses 01 instead of 1 might work on your
		 *                            development machine, but not on another machine. On the other machine, the application
		 *                            will use the system's default code page.
		 * @return                  <String> A UTF-8 encoded string.
		 */
		public function readMultiByte(length:uint, charSet:String):String;
		/**
		 * Reads an object from the socket, encoded in AMF serialized format.
		 *
		 * @return                  <*> The deserialized object
		 */
		public function readObject():*;
		/**
		 * Reads a signed 16-bit integer from the socket.
		 *
		 * @return                  <int> A value from -32768 to 32767.
		 */
		public function readShort():int;
		/**
		 * Reads an unsigned byte from the socket.
		 *
		 * @return                  <uint> A value from 0 to 255.
		 */
		public function readUnsignedByte():uint;
		/**
		 * Reads an unsigned 32-bit integer from the socket.
		 *
		 * @return                  <uint> A value from 0 to 4294967295.
		 */
		public function readUnsignedInt():uint;
		/**
		 * Reads an unsigned 16-bit integer from the socket.
		 *
		 * @return                  <uint> A value from 0 to 65535.
		 */
		public function readUnsignedShort():uint;
		/**
		 * Reads a UTF-8 string from the socket.  The string is assumed to be prefixed
		 *  with an unsigned short integer that indicates the length in bytes.
		 *
		 * @return                  <String> A UTF-8 string.
		 */
		public function readUTF():String;
		/**
		 * Reads the number of UTF-8 data bytes specified by the length
		 *  parameter from the socket, and returns a string.
		 *
		 * @param length            <uint> The number of bytes to read.
		 * @return                  <String> A UTF-8 string.
		 */
		public function readUTFBytes(length:uint):String;
		/**
		 * Writes a Boolean value to the socket. This method writes a single byte,
		 *  with either a value of 1 (true) or 0 (false).
		 *
		 * @param value             <Boolean> The value to write to the socket: 1 (true) or 0 (false).
		 */
		public function writeBoolean(value:Boolean):void;
		/**
		 * Writes a byte to the socket.
		 *
		 * @param value             <int> The value to write to the socket. The low 8 bits of the
		 *                            value are used; the high 24 bits are ignored.
		 */
		public function writeByte(value:int):void;
		/**
		 * Writes a sequence of bytes from the specified byte array. The write
		 *  operation starts at the position specified by offset.
		 *
		 * @param bytes             <ByteArray> The ByteArray object to write data from.
		 * @param offset            <uint (default = 0)> The zero-based offset into the bytes ByteArray
		 *                            object at which data writing should begin.
		 * @param length            <uint (default = 0)> The number of bytes to write.  The default value of 0 causes
		 *                            the entire buffer to be written, starting at the value specified by
		 *                            the offset parameter.
		 */
		public function writeBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void;
		/**
		 * Writes an IEEE 754 double-precision floating-point number to the socket.
		 *
		 * @param value             <Number> The value to write to the socket.
		 */
		public function writeDouble(value:Number):void;
		/**
		 * Writes an IEEE 754 single-precision floating-point number to the socket.
		 *
		 * @param value             <Number> The value to write to the socket.
		 */
		public function writeFloat(value:Number):void;
		/**
		 * Writes a 32-bit signed integer to the socket.
		 *
		 * @param value             <int> The value to write to the socket.
		 */
		public function writeInt(value:int):void;
		/**
		 * Writes a multibyte string from the byte stream, using the specified character set.
		 *
		 * @param value             <String> The string value to be written.
		 * @param charSet           <String> The string denoting the character set to use to interpret the bytes.
		 *                            Possible character set strings include "shift_jis", "CN-GB",
		 *                            and "iso-8859-1". For a complete list, see
		 *                            Supported Character Sets.
		 */
		public function writeMultiByte(value:String, charSet:String):void;
		/**
		 * Write an object to the socket in AMF serialized format.
		 *
		 * @param object            <*> The object to be serialized.
		 */
		public function writeObject(object:*):void;
		/**
		 * Writes a 16-bit integer to the socket.
		 *
		 * @param value             <int> The value to write to the socket.
		 */
		public function writeShort(value:int):void;
		/**
		 * Writes a 32-bit unsigned integer to the socket.
		 *
		 * @param value             <uint> The value to write to the socket.
		 */
		public function writeUnsignedInt(value:uint):void;
		/**
		 * Writes the following data to the socket: a 16-bit unsigned integer, which
		 *  indicates the length of the specified UTF-8 string in bytes, followed by
		 *  the string itself.
		 *
		 * @param value             <String> The string to write to the socket.
		 */
		public function writeUTF(value:String):void;
		/**
		 * Writes a UTF-8 string to the socket.
		 *
		 * @param value             <String> The string to write to the socket.
		 */
		public function writeUTFBytes(value:String):void;
	}
}
