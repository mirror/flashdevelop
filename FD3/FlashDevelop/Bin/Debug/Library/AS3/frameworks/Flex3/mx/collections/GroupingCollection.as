/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	public class GroupingCollection extends HierarchicalData implements IGroupingCollection {
		/**
		 * Specifies the Grouping instance applied to the source data.
		 *  Setting the grouping property
		 *  does not automatically refresh the view,
		 *  so you must call the refresh() method
		 *  after setting this property.
		 */
		public function get grouping():Grouping;
		public function set grouping(value:Grouping):void;
		/**
		 * The source collection containing the flat data to be grouped.
		 *  If the source is not a collection, it will be auto-wrapped into a collection.
		 */
		public function get source():Object;
		public function set source(value:Object):void;
		/**
		 * Array of SummaryRow instances that define any root-level data summaries.
		 */
		public var summaries:Array;
		/**
		 * The timer which is associated with an asynchronous refresh operation.
		 *  You can use it to change the timing interval, pause the refresh,
		 *  or perform other actions.
		 *  The default value for the delay property of the
		 *  Timer instance is 1, corresponding to 1 millisecond.
		 */
		protected var timer:Timer;
		/**
		 * Constructor.
		 */
		public function GroupingCollection();
		/**
		 * If the refresh is performed asynchronously,
		 *  cancels the refresh operation and stops the building of the groups.
		 *  This method only cancels the refresh
		 *  if it is initiated by a call to the refresh() method
		 *  with an argument of true, corresponding to an asynchronous refresh.
		 */
		public function cancelRefresh():void;
		/**
		 * Returns the parent of a node.
		 *  The parent of a top-level node is null.
		 *
		 * @param node              <Object> The Object that defines the node.
		 * @return                  <*> The parent node containing the node as child,
		 *                            null for a top-level node,
		 *                            and undefined if the parent cannot be determined.
		 */
		protected function getParent(node:Object):*;
		/**
		 * Return super.source, if the grouping property is set,
		 *  and an ICollectionView instance that refers to super.source if not.
		 */
		public override function getRoot():Object;
		/**
		 * Applies the grouping to the view.
		 *  The IGroupingCollection does not detect changes to a group
		 *  automatically, so you must call the refresh()
		 *  method to update the view after setting the group property.
		 *
		 * @param async             <Boolean (default = false)> If true, defines the refresh to be asynchronous.
		 *                            By default it is false denoting synchronous refresh.
		 * @return                  <Boolean> true if the refresh() method completed,
		 *                            and false if the refresh is incomplete,
		 *                            which can mean that items are still pending.
		 */
		public function refresh(async:Boolean = false):Boolean;
	}
}
