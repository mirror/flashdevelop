/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	public interface IList extends <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * The number of items in this collection.
		 *  0 means no items while -1 means the length is unknown.
		 */
		public function get length():int;
		/**
		 * Adds the specified item to the end of the list.
		 *  Equivalent to addItemAt(item, length).
		 *
		 * @param item              <Object> The item to add.
		 */
		public function addItem(item:Object):void;
		/**
		 * Adds the item at the specified index.
		 *  The index of any item greater than the index of the added item is increased by one.
		 *  If the the specified index is less than zero or greater than the length
		 *  of the list, a RangeError is thrown.
		 *
		 * @param item              <Object> The item to place at the index.
		 * @param index             <int> The index at which to place the item.
		 */
		public function addItemAt(item:Object, index:int):void;
		/**
		 * Gets the item at the specified index.
		 *
		 * @param index             <int> The index in the list from which to retrieve the item.
		 * @param prefetch          <int (default = 0)> An int indicating both the direction
		 *                            and number of items to fetch during the request if the item is
		 *                            not local.
		 * @return                  <Object> The item at that index, or null if there is none.
		 */
		public function getItemAt(index:int, prefetch:int = 0):Object;
		/**
		 * Returns the index of the item if it is in the list such that
		 *  getItemAt(index) == item.
		 *
		 * @param item              <Object> The item to find.
		 * @return                  <int> The index of the item, or -1 if the item is not in the list.
		 */
		public function getItemIndex(item:Object):int;
		/**
		 * Notifies the view that an item has been updated.
		 *  This is useful if the contents of the view do not implement
		 *  IEventDispatcher and dispatches a
		 *  PropertyChangeEvent.
		 *  If a property is specified the view may be able to optimize its
		 *  notification mechanism.
		 *  Otherwise it may choose to simply refresh the whole view.
		 *
		 * @param item              <Object> The item within the view that was updated.
		 * @param property          <Object (default = null)> The name of the property that was updated.
		 * @param oldValue          <Object (default = null)> The old value of that property. (If property was null,
		 *                            this can be the old value of the item.)
		 * @param newValue          <Object (default = null)> The new value of that property. (If property was null,
		 *                            there's no need to specify this as the item is assumed to be
		 *                            the new value.)
		 */
		public function itemUpdated(item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null):void;
		/**
		 * Removes all items from the list.
		 */
		public function removeAll():void;
		/**
		 * Removes the item at the specified index and returns it.
		 *  Any items that were after this index are now one index earlier.
		 *
		 * @param index             <int> The index from which to remove the item.
		 * @return                  <Object> The item that was removed.
		 */
		public function removeItemAt(index:int):Object;
		/**
		 * Places the item at the specified index.
		 *  If an item was already at that index the new item will replace it
		 *  and it will be returned.
		 *
		 * @param item              <Object> The new item to be placed at the specified index.
		 * @param index             <int> The index at which to place the item.
		 * @return                  <Object> The item that was replaced, or null if none.
		 */
		public function setItemAt(item:Object, index:int):Object;
		/**
		 * Returns an Array that is populated in the same order as the IList
		 *  implementation.
		 *  This method may throw an ItemPendingError.
		 */
		public function toArray():Array;
	}
}
