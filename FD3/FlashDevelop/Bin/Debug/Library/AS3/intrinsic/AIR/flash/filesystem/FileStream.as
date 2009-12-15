package flash.filesystem
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.filesystem.File;

	/**
	 * Signals that the end of the stream has been reached.
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")] 

	/**
	 * Signals that buffered data has been written to the file.
	 * @eventType flash.events.OutputProgressEvent.OUTPUT_PROGRESS
	 */
	[Event(name="outputProgress", type="flash.events.OutputProgressEvent")] 

	/**
	 * Signals the availability of new data on the stream.
	 * @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")] 

	/**
	 * Indicates that an error occurred during an asynchronous file I/O operation.
	 * @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event(name="ioError", type="flash.events.IOErrorEvent")] 

	/**
	 * Indicates that the stream has been closed by an explicit call to the close() method.
	 * @eventType flash.events.Event.CLOSE
	 */
	[Event(name="close", type="flash.events.Event")] 

	/// A FileStream object is used to read and write files.
	public class FileStream extends EventDispatcher implements IDataInput, IDataOutput
	{
		/// Returns the number of bytes of data available for reading in the input buffer.
		public function get bytesAvailable () : uint;

		/// The byte order for the data, either the BIG_ENDIAN or LITTLE_ENDIAN constant from the Endian class.
		public function get endian () : String;
		public function set endian (value:String) : void;

		/// Specifies whether the AMF3 or AMF0 format is used when writing or reading binary data by using the readObject() or writeObject() method.
		public function get objectEncoding () : uint;
		public function set objectEncoding (value:uint) : void;

		/// The current position in the file.
		public function get position () : Number;
		public function set position (value:Number) : void;

		/// When reading files asynchronously, the amount of data requested.
		public function get readAhead () : Number;
		public function set readAhead (value:Number) : void;

		/// Closes the FileStream object.
		public function close () : void;

		/// Creates a FileStream object.
		public function FileStream ();

		/// Opens the FileStream object synchronously, pointing to the file specified by the file parameter.
		public function open (file:File, fileMode:String) : void;

		/// Opens the FileStream object asynchronously, pointing to the file specified by the file parameter.
		public function openAsync (file:File, fileMode:String) : void;

		/// Reads a Boolean value from the file stream, byte stream, or byte array.
		public function readBoolean () : Boolean;

		/// Reads a signed byte from the file stream, byte stream, or byte array.
		public function readByte () : int;

		/// Reads the number of data bytes, specified by the length parameter, from the file stream, byte stream, or byte array.
		public function readBytes (bytes:ByteArray, offset:uint = 0, length:uint = 0) : void;

		/// Reads an IEEE 754 double-precision floating point number from the file stream, byte stream, or byte array.
		public function readDouble () : Number;

		/// Reads an IEEE 754 single-precision floating point number from the file stream, byte stream, or byte array.
		public function readFloat () : Number;

		/// Reads a signed 32-bit integer from the file stream, byte stream, or byte array.
		public function readInt () : int;

		/// Reads a multibyte string of specified length from the file stream, byte stream, or byte array using the specified character set.
		public function readMultiByte (length:uint, charSet:String) : String;

		/// Reads an object from the file stream, byte stream, or byte array, encoded in AMF serialized format.
		public function readObject () : *;

		/// Reads a signed 16-bit integer from the file stream, byte stream, or byte array.
		public function readShort () : int;

		/// Reads an unsigned byte from the file stream, byte stream, or byte array.
		public function readUnsignedByte () : uint;

		/// Reads an unsigned 32-bit integer from the file stream, byte stream, or byte array.
		public function readUnsignedInt () : uint;

		/// Reads an unsigned 16-bit integer from the file stream, byte stream, or byte array.
		public function readUnsignedShort () : uint;

		/// Reads a UTF-8 string from the file stream, byte stream, or byte array.
		public function readUTF () : String;

		/// Reads a sequence of UTF-8 bytes from the byte stream or byte array and returns a string.
		public function readUTFBytes (length:uint) : String;

		/// Truncates the file at the position specified by the position property of the FileStream object.
		public function truncate () : void;

		/// Writes a Boolean value.
		public function writeBoolean (value:Boolean) : void;

		/// Writes a byte.
		public function writeByte (value:int) : void;

		/// Writes a sequence of bytes from the specified byte array, bytes, starting at the byte specified by offset (using a zero-based index) with a length specified by length, into the file stream, byte stream, or byte array.
		public function writeBytes (bytes:ByteArray, offset:uint = 0, length:uint = 0) : void;

		/// Writes an IEEE 754 double-precision (64-bit) floating point number.
		public function writeDouble (value:Number) : void;

		/// Writes an IEEE 754 single-precision (32-bit) floating point number.
		public function writeFloat (value:Number) : void;

		/// Writes a 32-bit signed integer.
		public function writeInt (value:int) : void;

		/// Writes a multibyte string to the file stream, byte stream, or byte array, using the specified character set.
		public function writeMultiByte (value:String, charSet:String) : void;

		/// Writes an object to the file stream, byte stream, or byte array, in AMF serialized format.
		public function writeObject (object:*) : void;

		/// Writes a 16-bit integer.
		public function writeShort (value:int) : void;

		/// Writes a 32-bit unsigned integer.
		public function writeUnsignedInt (value:uint) : void;

		/// Writes a UTF-8 string to the file stream, byte stream, or byte array.
		public function writeUTF (value:String) : void;

		/// Writes a UTF-8 string.
		public function writeUTFBytes (value:String) : void;
	}
}
