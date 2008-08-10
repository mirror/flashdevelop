/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	public class ArrayUtil {
		/**
		 * Returns the index of the item in the Array.
		 *  Note that in this implementation the search is linear and is therefore
		 *  O(n).
		 *
		 * @param item              <Object> The item to find in the Array.
		 * @param source            <Array> The Array to search for the item.
		 * @return                  <int> The index of the item, and -1 if the item is not in the list.
		 */
		public static function getItemIndex(item:Object, source:Array):int;
		/**
		 * Ensures that an Object can be used as an Array.
		 *
		 * @param obj               <Object> Object that you want to ensure is an array.
		 * @return                  <Array> An Array. If the original Object is already an Array,
		 *                            the original Array is returned. Otherwise, a new Array whose
		 *                            only element is the Object is returned or an empty Array if
		 *                            the Object was null.
		 */
		public static function toArray(obj:Object):Array;
	}
}
