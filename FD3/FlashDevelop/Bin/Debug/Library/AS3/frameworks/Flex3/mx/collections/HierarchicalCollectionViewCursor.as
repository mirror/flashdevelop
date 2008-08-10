/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	import flash.events.EventDispatcher;
	public class HierarchicalCollectionViewCursor extends EventDispatcher implements IHierarchicalCollectionViewCursor {
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
		 * Contains the depth of the node at the location
		 *  in the source collection referenced by this cursor.
		 *  If the cursor is beyond the end of the collection,
		 *  this property contains 0.
		 */
		public function get currentDepth():int;
		/**
		 * A reference to the ICollectionView with which this cursor is associated.
		 */
		public function get view():ICollectionView;
		/**
		 * Constructor.
		 *
		 * @param collection        <HierarchicalCollectionView> The HierarchicalCollectionView instance referenced by this cursor.
		 * @param model             <ICollectionView> The source data collection.
		 * @param hierarchicalData  <IHierarchicalData> The data used to create the HierarchicalCollectionView instance.
		 */
		public function HierarchicalCollectionViewCursor(collection:HierarchicalCollectionView, model:ICollectionView, hierarchicalData:IHierarchicalData);
	}
}
