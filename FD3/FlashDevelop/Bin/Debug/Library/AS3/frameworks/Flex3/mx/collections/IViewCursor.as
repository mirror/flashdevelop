/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	import flash.events.IEventDispatcher;
	public interface IViewCursor extends IEventDispatcher {
		/**
		 * If the cursor is located after the last item in the view,
		 *  this property is true .
		 *  If the ICollectionView is empty (length == 0),
		 *  this property is true.
		 */
		public function get afterLast():Boolean;
		/**
		 * If the cursor is located before the first item in the view,
		 *  this property is true.
		 *  If the ICollectionView is empty (length == 0),
		 *  this property is true.
		 */
		public function get beforeFirst():Boolean;
		/**
		 * Provides access to a bookmark that corresponds to the item
		 *  returned by the current property.
		 *  The bookmark can be used to move the cursor
		 *  to a previously visited item, or to a position relative to that item.
		 *  (See the seek() method for more information.)
		 */
		public function get bookmark():CursorBookmark;
		/**
		 * Provides access the object at the location
		 *  in the source collection referenced by this cursor.
		 *  If the cursor is beyond the ends of the collection
		 *  (beforeFirst, afterLast)
		 *  this will return null.
		 */
		public function get current():Object;
		/**
		 * A reference to the ICollectionView with which this cursor is associated.
		 */
		public function get view():ICollectionView;
		/**
		 * Finds an item with the specified properties within the collection
		 *  and positions the cursor to that item.
		 *  If the item can not be found, the cursor location does not change.
		 *
		 * @param values            <Object> 
		 */
		public function findAny(values:Object):Boolean;
		/**
		 * Finds the first item with the specified properties within the collection
		 *  and positions the cursor to that item.
		 *  If the item can not be found, no cursor location does not change.
		 *
		 * @param values            <Object> 
		 */
		public function findFirst(values:Object):Boolean;
		/**
		 * Finds the last item with the specified properties within the collection
		 *  and positions the cursor on that item.
		 *  If the item can not be found, the cursor location does not chanage.
		 *
		 * @param values            <Object> 
		 */
		public function findLast(values:Object):Boolean;
		/**
		 * Inserts the specified item before the cursor's current position.
		 *  If the cursor is afterLast,
		 *  the insertion occurs at the end of the view.
		 *  If the cursor is beforeFirst on a non-empty view,
		 *  an error is thrown.
		 *
		 * @param item              <Object> 
		 */
		public function insert(item:Object):void;
		/**
		 * Moves the cursor to the next item within the collection.
		 *  On success the current property is updated
		 *  to reference the object at this new location.
		 *  Returns true if the resulting current
		 *  property is valid, or false if not
		 *  (the property value is afterLast).
		 *
		 * @return                  <Boolean> true if still in the list,
		 *                            false if the current value initially was
		 *                            or now is afterLast.
		 */
		public function moveNext():Boolean;
		/**
		 * Moves the cursor to the previous item within the collection.
		 *  On success the current property is updated
		 *  to reference the object at this new location.
		 *  Returns true if the resulting current
		 *  property is valid, or false if not
		 *  (the property value is beforeFirst).
		 *
		 * @return                  <Boolean> true if still in the list,
		 *                            false if the current value initially was or
		 *                            now is beforeFirst.
		 */
		public function movePrevious():Boolean;
		/**
		 * Removes the current item and returns it.
		 *  If the cursor location is beforeFirst or
		 *  afterLast, throws a CursorError.
		 *  If you remove any item other than the last item,
		 *  the cursor moves to the next item. If you remove the last item, the
		 *  cursor is at the AFTER_LAST bookmark.
		 */
		public function remove():Object;
		/**
		 * Moves the cursor to a location at an offset from the specified
		 *  bookmark.
		 *  The offset can be negative, in which case the cursor is positioned
		 *  an offset number of items prior to the specified bookmark.
		 *
		 * @param bookmark          <CursorBookmark> CursorBookmark reference to marker
		 *                            information that allows repositioning to a specific location.
		 *                            You can set this parameter to value returned from the
		 *                            bookmark property, or to one of the following constant
		 *                            bookmark values:
		 *                            CursorBookmark.FIRST -
		 *                            Seek from the start (first element) of the collection
		 *                            CursorBookmark.CURRENT -
		 *                            Seek from the current position in the collection
		 *                            CursorBookmark.LAST -
		 *                            Seek from the end (last element) of the collection
		 * @param offset            <int (default = 0)> Indicates how far from the specified bookmark to seek.
		 *                            If the specified number is negative, the cursor attempts to
		 *                            move prior to the specified bookmark.
		 *                            If the offset specified is beyond the end of the collection,
		 *                            the cursor is be positioned off the end, to the
		 *                            beforeFirst or afterLast location.
		 * @param prefetch          <int (default = 0)> Used for remote data. Indicates an intent to iterate
		 *                            in a specific direction once the seek operation completes.
		 *                            This reduces the number of required network round trips during a seek.
		 *                            If the iteration direction is known at the time of the request,
		 *                            the appropriate amount of data can be returned ahead of the request
		 *                            to iterate it.
		 */
		public function seek(bookmark:CursorBookmark, offset:int = 0, prefetch:int = 0):void;
	}
}
