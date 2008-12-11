package flash.utils
{
	/// The ByteArray class provides methods and properties to optimize reading, writing, and working with binary data.
	public class ByteArray
	{
		/// The length of the ByteArray object, in bytes.
		public var length:uint;

		/// The number of bytes of data available for reading from the current position in the byte array to the end of the array.
		public var bytesAvailable:uint;

		/// Moves, or returns the current position, in bytes, of the file pointer into the ByteArray object.
		public var position:uint;

		/// Denotes the default object encoding for the ByteArray class to use for a new ByteArray instance.
		public var defaultObjectEncoding:uint;

		/// Used to determine whether the ActionScript 3.0, ActionScript 2.0, or ActionScript 1.0 format should be used when writing to, or reading from, a ByteArray instance.
		public var objectEncoding:uint;

		/// Changes or reads the byte order for the data; either Endian.BIG_ENDIAN or Endian.LITTLE_ENDIAN.
		public var endian:String;

		/// Creates a ByteArray instance representing a packed array of bytes, so that you can use the methods and properties in this class to optimize your data storage and stream.
		public function ByteArray();

		/// Reads the number of data bytes, specified by the length parameter, from the byte stream.
		public function readBytes(bytes:flash.utils.ByteArray, offset:uint=0, length:uint=0):void;

		/// Writes a sequence of length bytes from the specified byte array, bytes, starting offset (zero-based index) bytes into the byte stream.
		public function writeBytes(bytes:flash.utils.ByteArray, offset:uint=0, length:uint=0):void;

		/// Writes a Boolean value.
		public function writeBoolean(value:Boolean):void;

		/// Writes a byte to the byte stream.
		public function writeByte(value:int):void;

		/// Writes a 16-bit integer to the byte stream.
		public function writeShort(value:int):void;

		/// Writes a 32-bit signed integer to the byte stream.
		public function writeInt(value:int):void;

		/// Writes a 32-bit unsigned integer to the byte stream.
		public function writeUnsignedInt(value:uint):void;

		/// Writes an IEEE 754 single-precision (32-bit) floating-point number to the byte stream.
		public function writeFloat(value:Number):void;

		/// Writes an IEEE 754 double-precision (64-bit) floating-point number to the byte stream.
		public function writeDouble(value:Number):void;

		/// Writes a multibyte string to the byte stream using the specified character set.
		public function writeMultiByte(value:String, charSet:String):void;

		/// Writes a UTF-8 string to the byte stream.
		public function writeUTF(value:String):void;

		/// Writes a UTF-8 string to the byte stream.
		public function writeUTFBytes(value:String):void;

		/// Reads a Boolean value from the byte stream.
		public function readBoolean():Boolean;

		/// Reads a signed byte from the byte stream.
		public function readByte():int;

		/// Reads an unsigned byte from the byte stream.
		public function readUnsignedByte():uint;

		/// Reads a signed 16-bit integer from the byte stream.
		public function readShort():int;

		/// Reads an unsigned 16-bit integer from the byte stream.
		public function readUnsignedShort():uint;

		/// Reads a signed 32-bit integer from the byte stream.
		public function readInt():int;

		/// Reads an unsigned 32-bit integer from the byte stream.
		public function readUnsignedInt():uint;

		/// Reads an IEEE 754 single-precision (32-bit) floating-point number from the byte stream.
		public function readFloat():Number;

		/// Reads an IEEE 754 double-precision (64-bit) floating-point number from the byte stream.
		public function readDouble():Number;

		/// Reads a multibyte string of specified length from the byte stream using the specified character set.
		public function readMultiByte(length:uint, charSet:String):String;

		/// Reads a UTF-8 string from the byte stream.
		public function readUTF():String;

		/// Reads a sequence of UTF-8 bytes specified by the length parameter from the byte stream and returns a string.
		public function readUTFBytes(length:uint):String;

		/// Writes an object into the byte array in AMF serialized format.
		public function writeObject(object:*):void;

		/// Reads an object from the byte array, encoded in AMF serialized format.
		public function readObject():void;

		/// Compresses the byte array.
		public function compress(algorithm:String=unknown):void;

		/// Decompresses the byte array.
		public function uncompress(algorithm:String=unknown):void;

		/// Converts the byte array to a string.
		public function toString():String;

	}

}

