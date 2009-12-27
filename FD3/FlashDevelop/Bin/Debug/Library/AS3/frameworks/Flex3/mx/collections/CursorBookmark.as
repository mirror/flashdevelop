package mx.collections
{
include "../core/Version.as"
	/**
	 *  Encapsulates the positional aspects of a cursor in an 
 *  <code>ICollectionView</code>.  Bookmarks are used to return a cursor to 
 *  an absolute position within the <code>ICollectionView</code>.
 *
 *  @see mx.collections.IViewCursor#bookmark
 *  @see mx.collections.IViewCursor#seek()
	 */
	public class CursorBookmark
	{
		private static var _first : CursorBookmark;
		private static var _last : CursorBookmark;
		private static var _current : CursorBookmark;
		private var _value : Object;

		/**
		 *  A bookmark for the first item in an <code>ICollectionView</code>.
     *
     *  @return The bookmark to the first item.
		 */
		public static function get FIRST () : CursorBookmark;

		/**
		 *  A bookmark for the last item in an <code>ICollectionView</code>.
     * If the view has no items, the cursor is at this bookmark.
     *
     *  @return The bookmark to the last item.
		 */
		public static function get LAST () : CursorBookmark;

		/**
		 *  A bookmark representing the current item for the <code>IViewCursor</code> in
     *  an <code>ICollectionView</code>.
     *
     *  @return The bookmark to the current item.
		 */
		public static function get CURRENT () : CursorBookmark;

		/**
		 *  The underlying marker representation of the bookmark.
     *  This value is generally understood only by the <code>IViewCursor</code>
     *  or <code>ICollectionView</code> implementation.
		 */
		public function get value () : Object;

		/**
		 *  Creates a new instance of a bookmark with the specified value.
     *
     *  @param value The value of this bookmark.
		 */
		public function CursorBookmark (value:Object);

		/**
		 *  Gets the approximate index of the item represented by this bookmark
     *  in its view. If the item has been paged out, this method could throw an 
     *  ItemPendingError.
     *  
     *  @return The index of the item. If the item is not in the current view, this method returns
     *  -1. This method also returns -1 if index-based location is not possible.
		 */
		public function getViewIndex () : int;
	}
}
