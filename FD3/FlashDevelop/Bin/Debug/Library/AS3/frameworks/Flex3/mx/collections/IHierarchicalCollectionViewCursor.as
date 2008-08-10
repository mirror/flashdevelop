/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	public interface IHierarchicalCollectionViewCursor extends <a href="../../mx/collections/IViewCursor.html">IViewCursor</a> , <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * Contains the depth of the node at the location
		 *  in the source collection referenced by this cursor.
		 *  If the cursor is beyond the end of the collection,
		 *  this property contains 0.
		 */
		public function get currentDepth():int;
	}
}
