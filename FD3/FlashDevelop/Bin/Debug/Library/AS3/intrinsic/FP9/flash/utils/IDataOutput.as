package flash.utils
{
	import flash.utils.ByteArray;

	/// The IDataOutput interface provides a set of methods for writing binary data.
	public interface IDataOutput
	{
		/// The byte order for the data, either the BIG_ENDIAN or LITTLE_ENDIAN constant from the Endian class.
		public function get endian () : String;
		public function set endian (type:String) : void;

		/// Used to determine whether the AMF3 or AMF0 format is used when writing or reading binary data using the writeObject() method.
		public function get objectEncoding () : uint;
		public function set objectEncoding (version:uint) : void;

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
