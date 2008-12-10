package mx.controls.listClasses
{
	import mx.collections.CursorBookmark;

	/**
	 *  @private *  The object that we use to store seek data *  that was interrupted by an ItemPendingError. *  Used when trying to select several items at once *  and match a selectedItem to its index.
	 */
	public class ListBaseSelectionDataPending
	{
		/**
		 *  The bookmark we have to seek to
		 */
		public var bookmark : CursorBookmark;
		/**
		 *  The index into the iterator when we hit the page fault
		 */
		public var index : int;
		/**
		 *  The list if items being selected
		 */
		public var items : Array;
		/**
		 *  The offset from the bookmark we have to seek to
		 */
		public var offset : int;
		/**
		 *  True if we use findAny, false if we iterate the collection
		 */
		public var useFind : Boolean;

		/**
		 *  Constructor.
		 */
		public function ListBaseSelectionDataPending (useFind:Boolean, index:int, items:Array, bookmark:CursorBookmark, offset:int);
	}
}
