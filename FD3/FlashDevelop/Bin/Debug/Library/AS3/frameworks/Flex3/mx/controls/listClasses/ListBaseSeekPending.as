package mx.controls.listClasses
{
	import mx.collections.CursorBookmark;

include "../../core/Version.as"
	/**
	 *  An object that stores data about a seek operation
 *  that was interrupted by an ItemPendingError error.
 *
 *  @see mx.collections.errors.ItemPendingError
 *  @see mx.controls.listClasses.ListBase#lastSeekPending
	 */
	public class ListBaseSeekPending
	{
		/**
		 *  The bookmark that was being used in the seek operation.
		 */
		public var bookmark : CursorBookmark;
		/**
		 *  The offset from the bookmark that was the target of the seek operation.
		 */
		public var offset : int;

		/**
		 *  Constructor.
	 * 
	 *  @param bookmark The bookmark that was being used in the 
	 *                  seek operation.
	 *  @param offset The offset from the bookmark that was the target of
	 *                  the seek operation.
		 */
		public function ListBaseSeekPending (bookmark:CursorBookmark, offset:int);
	}
}
