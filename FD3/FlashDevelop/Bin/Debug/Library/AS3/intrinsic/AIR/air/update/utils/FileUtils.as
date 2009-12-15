package air.update.utils
{
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import air.update.logging.Logger;

	public class FileUtils extends Object
	{
		public static function deleteFile (file:File) : void;

		public static function deleteFolder (file:File) : void;

		public function FileUtils ();

		public static function getDocumentsStateFile () : File;

		public static function getFilenameFromURL (url:String) : String;

		public static function getLocalDescriptorFile () : File;

		public static function getLocalUpdateFile () : File;

		public static function getStorageStateFile () : File;

		public static function readByteArrayFromFile (file:File) : ByteArray;

		public static function readUTFBytesFromFile (file:File) : String;

		public static function readXMLFromFile (file:File) : XML;

		public static function saveXMLToFile (xml:XML, file:File) : void;
	}
}
