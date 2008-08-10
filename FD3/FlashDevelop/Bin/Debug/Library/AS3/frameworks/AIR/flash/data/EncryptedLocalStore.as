/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	import flash.utils.ByteArray;
	public class EncryptedLocalStore {
		/**
		 * Returns the data for the item with the given name in the encrypted local store.
		 *  If an item does not exist by the specified name, this method returns null.
		 *
		 * @param name              <String> The name of the item in the encrypted local store.
		 * @return                  <ByteArray> The ByteArray data. If there is no data for the provided name,
		 *                            the method returns null.
		 */
		public static function getItem(name:String):ByteArray;
		/**
		 * Removes the item with the given name from the encrypted local store.
		 *
		 * @param name              <String> The name of the item in the encrypted local store.
		 */
		public static function removeItem(name:String):void;
		/**
		 * Clears the entire encrypted local store, deleting all data.
		 */
		public static function reset():void;
		/**
		 * Sets the item with the given name to the provided ByteArray data.
		 *
		 * @param name              <String> The name of the item in the encrypted local store.
		 * @param data              <ByteArray> The data.
		 * @param stronglyBound     <Boolean (default = false)> If set to true, the stored item is strongly bound to the
		 *                            digital signature and bits of the AIR application, in addition to the application's publisher ID.
		 *                            A subsequent call to getItem() for this item results in a run-time exception if the
		 *                            calling AIR application's bits do not match those of the storing application. If you update your
		 *                            application, it cannot read strongly bound data that was previously written to the encrypted
		 *                            local store.
		 *                            By default, an AIR application cannot read the encrypted local store of another application.
		 *                            The stronglyBound setting provides extra binding (to the data in the application bits)
		 *                            that prevents an attacker application from attempting to read from your application's
		 *                            encrypted local store by trying to hijack your application's publisher ID.
		 */
		public static function setItem(name:String, data:ByteArray, stronglyBound:Boolean = false):void;
	}
}
