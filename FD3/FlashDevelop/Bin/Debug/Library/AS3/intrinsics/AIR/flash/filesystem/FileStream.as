package flash.filesystem
{
	/// A FileStream object is used to read and write files.
	public class FileStream extends flash.events.EventDispatcher
	{
		/** 
		 * [AIR] Signals that the end of the stream has been reached.
		 * @eventType flash.events.Event.COMPLETE
		 */
		[Event(name="complete", type="flash.events.Event")]

		/** 
		 * [AIR] Signals that buffered data has been written to the file.
		 * @eventType flash.events.OutputProgressEvent.OUTPUT_PROGRESS
		 */
		[Event(name="outputProgress", type="flash.events.OutputProgressEvent")]

		/** 
		 * [AIR] Signals the availability of new data on the stream.
		 * @eventType flash.events.ProgressEvent.PROGRESS
		 */
		[Event(name="progress", type="flash.events.ProgressEvent")]

		/** 
		 * [AIR] Indicates that an error occurred during an asynchronous file I/O operation.
		 * @eventType flash.events.IOErrorEvent.IO_ERROR
		 */
		[Event(name="ioError", type="flash.events.IOErrorEvent")]

		/** 
		 * [AIR] Indicates that the stream has been closed by an explicit call to the close() method.
		 * @eventType flash.events.Event.CLOSE
		 */
		[Event(name="close", type="flash.events.Event")]

		/// [AIR] The current position in the file.
		public var position:Number;

		/// [AIR] When reading files asynchronously, the amount of data requested.
		public var readAhead:Number;

		/// [AIR] Returns the number of bytes of data available for reading in the input buffer.
		public var bytesAvailable:uint;

		/// [AIR] The byte order for the data, either the "bigEndian" or "littleEndian" constant from the Endian class.
		public var endian:String;

		/// [AIR] Specifies whether the AMF3 or AMF0 format is used when writing or reading binary data by using the readObject() or writeObject() method.
		public var objectEncoding:uint;

		/// [AIR] Creates a FileStream object.
		public function FileStream();

		/// [AIR] Opens the FileStream object synchronously, pointing to the file specified by the file parameter.
		public function open(file:flash.filesystem.File, fileMode:String):void;

		/// [AIR] Opens the FileStream object asynchronously, pointing to the file specified by the file parameter.
		public function openAsync(file:flash.filesystem.File, fileMode:String):void;

		/// [AIR] Truncates the file at the position specified by the position property of the FileStream object.
		public function truncate():void;

		/// [AIR] Closes the FileStream object.
		public function close():void;

		/// [AIR] Reads a Boolean value from the byte stream or byte array.
		public function readBoolean():Boolean;

		/// [AIR] Reads a signed byte from the byte stream or byte array.
		public function readByte():int;

		/// [AIR] Reads the number of data bytes, specified by the length parameter, from the byte stream or byte array.
		public function readBytes(bytes:flash.utils.ByteArray, offset:uint=0, length:uint=0):void;

		/// [AIR] Reads an IEEE 754 double-precision floating point number from the byte stream or byte array.
		public function readDouble():Number;

		/// [AIR] Reads an IEEE 754 single-precision floating point number from the byte stream or byte array.
		public function readFloat():Number;

		/// [AIR] Reads a signed 32-bit integer from the byte stream or byte array.
		public function readInt():int;

		/// [AIR] Reads a multibyte string of specified length from the byte stream using the specified character set.
		public function readMultiByte(length:uint, charSet:String):String;

		/// [AIR] Reads an object from the byte stream or byte array, encoded in AMF serialized format.
		public function readObject():void;

		/// [AIR] Reads a signed 16-bit integer from the byte stream or byte array.
		public function readShort():int;

		/// [AIR] Reads an unsigned byte from the byte stream or byte array.
		public function readUnsignedByte():uint;

		/// [AIR] Reads an unsigned 32-bit integer from the byte stream or byte array.
		public function readUnsignedInt():uint;

		/// [AIR] Reads an unsigned 16-bit integer from the byte stream or byte array.
		public function readUnsignedShort():uint;

		/// [AIR] Reads a UTF-8 string from the byte stream or byte array.
		public function readUTF():String;

		/// [AIR] Reads a sequence of length UTF-8 bytes from the byte stream or byte array and returns a string.
		public function readUTFBytes(length:uint):String;

		/// [AIR] Writes a Boolean value.
		public function writeBoolean(value:Boolean):void;

		/// [AIR] Writes a byte.
		public function writeByte(value:int):void;

		/// [AIR] Writes a sequence of length bytes from the specified byte array, bytes, starting offset(zero-based index) bytes into the byte stream.
		public function writeBytes(bytes:flash.utils.ByteArray, offset:uint=0, length:uint=0):void;

		/// [AIR] Writes an IEEE 754 double-precision (64-bit) floating point number.
		public function writeDouble(value:Number):void;

		/// [AIR] Writes an IEEE 754 single-precision (32-bit) floating point number.
		public function writeFloat(value:Number):void;

		/// [AIR] Writes a 32-bit signed integer.
		public function writeInt(value:int):void;

		/// [AIR] Writes a multibyte string to the byte stream using the specified character set.
		public function writeMultiByte(value:String, charSet:String):void;

		/// [AIR] Writes an object to the byte stream or byte array in AMF serialized format.
		public function writeObject(object:*):void;

		/// [AIR] Writes a 16-bit integer.
		public function writeShort(value:int):void;

		/// [AIR] Writes a 32-bit unsigned integer.
		public function writeUnsignedInt(value:uint):void;

		/// [AIR] Writes a UTF-8 string to the byte stream.
		public function writeUTF(value:String):void;

		/// [AIR] Writes a UTF-8 string.
		public function writeUTFBytes(value:String):void;

	}

}

