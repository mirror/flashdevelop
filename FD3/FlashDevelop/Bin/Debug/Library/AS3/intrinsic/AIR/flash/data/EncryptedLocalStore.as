package flash.data
{
	import flash.utils.ByteArray;

	/// The EncryptedLocalStore class provides methods for setting and getting objects in the encrypted local data store for an AIR application.
	public class EncryptedLocalStore extends Object
	{
		public function EncryptedLocalStore ();

		/// [AIR] Returns the data for the item with the given name in the encrypted local store.
		public static function getItem (name:String) : ByteArray;

		/// [AIR] Removes the item with the given name from the encrypted local store.
		public static function removeItem (name:String) : void;

		/// [AIR] Clears the entire encrypted local store, deleting all data.
		public static function reset () : void;

		/// [AIR] Sets the item with the given name to the provided ByteArray data.
		public static function setItem (name:String, data:ByteArray, stronglyBound:Boolean = false) : void;
	}
}
