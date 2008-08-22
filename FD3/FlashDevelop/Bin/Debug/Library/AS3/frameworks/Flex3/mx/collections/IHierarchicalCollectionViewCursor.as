/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	import flash.events.IEventDispatcher;
	public interface IHierarchicalCollectionViewCursor extends IViewCursor, IEventDispatcher {
		/**
		 * Contains the depth of the node at the location
		 *  in the source collection referenced by this cursor.
		 *  If the cursor is beyond the end of the collection,
		 *  this property contains 0.
		 */
		public function get currentDepth():int;
	}
}
