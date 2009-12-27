package mx.controls.listClasses
{
	import mx.collections.CursorBookmark;

include "../../core/Version.as"
	/**
	 *  @private
 *  The object that we use to store seek data
 *  that was interrupted by an ItemPendingError.
 *  Used when searching for a string.
	 */
	public class ListBaseFindPending
	{
		/**
		 *  The bookmark we have to seek to when the data arrives
		 */
		public var bookmark : CursorBookmark;
		/**
		 *  The currentIndex we are looking at when we hit the page fault
		 */
		public var currentIndex : int;
		/**
		 *  The offset from the bookmark we have to seek to when the data arrives
		 */
		public var offset : int;
		/**
		 *  The string we were searching for when the hit the page fault
		 */
		public var searchString : String;
		/**
		 *  The bookmark where we were when we started
		 */
		public var startingBookmark : CursorBookmark;
		/**
		 *  The index we should stop at
		 */
		public var stopIndex : int;

		/**
		 *  Constructor.
		 */
		public function ListBaseFindPending (searchString:String, startingBookmark:CursorBookmark, bookmark:CursorBookmark, offset:int, currentIndex:int, stopIndex:int);
	}
}
