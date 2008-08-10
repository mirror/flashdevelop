/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	public interface IGroupingCollection extends <a href="../../mx/collections/IHierarchicalData.html">IHierarchicalData</a> , <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * The Grouping object applied to the source data.
		 *  Setting this property does not automatically refresh the view;
		 *  therefore, you must call the refresh() method
		 *  after setting this property.
		 */
		public function get grouping():Grouping;
		public function set grouping(value:Grouping):void;
		/**
		 * If the refresh is performed asynchronously,
		 *  cancels the refresh operation and stops the building of the groups.
		 *  This method only cancels the refresh
		 *  if it is initiated by a call to the refresh() method
		 *  with an argument of true, corresponding to an asynchronous refresh.
		 */
		public function cancelRefresh():void;
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
