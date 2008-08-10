/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	public final  class CollectionEventKind {
		/**
		 * Indicates that the collection added an item or items.
		 */
		public static const ADD:String = "add";
		/**
		 * Indicates that the item has moved from the position identified
		 *  by the CollectionEvent oldLocation property to the
		 *  position identified by the location property.
		 */
		public static const MOVE:String = "move";
		/**
		 * Indicates that the collection applied a sort, a filter, or both.
		 *  This change can potentially be easier to handle than a RESET.
		 */
		public static const REFRESH:String = "refresh";
		/**
		 * Indicates that the collection removed an item or items.
		 */
		public static const REMOVE:String = "remove";
		/**
		 * Indicates that the item at the position identified by the
		 *  CollectionEvent location property has been replaced.
		 */
		public static const REPLACE:String = "replace";
		/**
		 * Indicates that the collection has changed so drastically that
		 *  a reset is required.
		 */
		public static const RESET:String = "reset";
		/**
		 * Indicates that one or more items were updated within the collection.
		 *  The affected item(s) or their associated ObjectChangeEvent objects
		 *  are stored in the items property.
		 */
		public static const UPDATE:String = "update";
	}
}
