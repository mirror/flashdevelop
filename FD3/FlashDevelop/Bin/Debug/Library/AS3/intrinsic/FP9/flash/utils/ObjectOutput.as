package flash.utils
{
	import flash.utils.ByteArray;

	public class ObjectOutput extends Object implements IDataOutput
	{
		public function get endian () : String;
		public function set endian (type:String) : void;

		public function get objectEncoding () : uint;
		public function set objectEncoding (version:uint) : void;

		public function writeBoolean (value:Boolean) : void;

		public function writeByte (value:int) : void;

		public function writeBytes (bytes:ByteArray, offset:uint, length:uint) : void;

		public function writeDouble (value:Number) : void;

		public function writeFloat (value:Number) : void;

		public function writeInt (value:int) : void;

		public function writeMultiByte (value:String, charSet:String) : void;

		public function writeObject (object:*) : void;

		public function writeShort (value:int) : void;

		public function writeUnsignedInt (value:uint) : void;

		public function writeUTF (value:String) : void;

		public function writeUTFBytes (value:String) : void;
	}
}
