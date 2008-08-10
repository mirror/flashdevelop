/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	public class CursorBookmark {
		/**
		 * A bookmark representing the current item for the IViewCursor in
		 *  an ICollectionView.
		 */
		public static function get CURRENT():CursorBookmark;
		/**
		 * A bookmark for the first item in an ICollectionView.
		 */
		public static function get FIRST():CursorBookmark;
		/**
		 * A bookmark for the last item in an ICollectionView.
		 *  If the view has no items, the cursor is at this bookmark.
		 */
		public static function get LAST():CursorBookmark;
		/**
		 * The underlying marker representation of the bookmark.
		 *  This value is generally understood only by the IViewCursor
		 *  or ICollectionView implementation.
		 */
		public function get value():Object;
		/**
		 * Creates a new instance of a bookmark with the specified value.
		 *
		 * @param value             <Object> The value of this bookmark.
		 */
		public function CursorBookmark(value:Object);
		/**
		 * Get the approximate index of the item represented by this bookmark
		 *  in its view.  If the item has been paged out this method could throw an
		 *  ItemPendingError.  If the item is not in the current view -1 is
		 *  returned.  This method also returns -1 if index-based location is not
		 *  possible.
		 */
		public function getViewIndex():int;
	}
}
