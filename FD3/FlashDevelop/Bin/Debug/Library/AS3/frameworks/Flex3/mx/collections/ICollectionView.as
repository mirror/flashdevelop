/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	import flash.events.IEventDispatcher;
	public interface ICollectionView extends IEventDispatcher {
		/**
		 * A function that the view will use to eliminate items that do not
		 *  match the function's criteria.
		 */
		public function get filterFunction():Function;
		public function set filterFunction(value:Function):void;
		/**
		 * The number of items in this view.
		 *  0 means no items, while -1 means that the length is unknown.
		 */
		public function get length():int;
		/**
		 * The Sort that will be applied to the ICollectionView.
		 *  Setting the sort does not automatically refresh the view,
		 *  so you must call the refresh() method
		 *  after setting this property.
		 *  If sort is unsupported an error will be thrown when accessing
		 *  this property.
		 */
		public function get sort():Sort;
		public function set sort(value:Sort):void;
		/**
		 * Returns whether the view contains the specified object.
		 *  Unlike the IViewCursor.findxxx
		 *  methods,
		 *  this search is succesful only if it finds an item that exactly
		 *  matches the parameter.
		 *  If the view has a filter applied to it this method may return
		 *  false even if the underlying collection
		 *  does contain the item.
		 *
		 * @param item              <Object> The object to look for.
		 * @return                  <Boolean> true if the ICollectionView, after applying any filter,
		 *                            contains the item; false otherwise.
		 */
		public function contains(item:Object):Boolean;
		/**
		 * Creates a new IViewCursor that works with this view.
		 *
		 * @return                  <IViewCursor> A new IViewCursor implementation.
		 */
		public function createCursor():IViewCursor;
		/**
		 * Prevents changes to the collection itself and items within the
		 *  collection from being dispatched by the view.
		 *  Also prevents the view from updating the positions of items
		 *  if the positions change in the collection.
		 *  The changes will be queued and dispatched appropriately
		 *  after enableAutoUpdate is called.
		 *  If more events than updates to a single item occur,
		 *  the view may end up resetting.
		 *  The disableAutoUpdate method acts cumulatively;
		 *  the same number of calls to enableAutoUpdate
		 *  are required for the view to dispatch events and refresh.
		 *  Note that disableAutoUpdate only affects the
		 *  individual view; edits may be detected on an individual
		 *  basis by other views.
		 */
		public function disableAutoUpdate():void;
		/**
		 * Enables auto-updating.
		 *  See disableAutoUpdate for more information.
		 */
		public function enableAutoUpdate():void;
		/**
		 * Notifies the view that an item has been updated.
		 *  This method is useful if the contents of the view do not implement
		 *  IPropertyChangeNotifier.
		 *  If the call to this method includes a property parameter,
		 *  the view may be able to optimize its notification mechanism.
		 *  Otherwise it may choose to simply refresh the whole view.
		 *
		 * @param item              <Object> The item within the view that was updated.
		 * @param property          <Object (default = null)> The name of the property that was updated.
		 * @param oldValue          <Object (default = null)> The old value of that property. (If property
		 *                            was null, this can be the old value of the item.).
		 * @param newValue          <Object (default = null)> The new value of that property. (If property
		 *                            was null, there's no need to specify this as the item is assumed
		 *                            to be the new value.)
		 */
		public function itemUpdated(item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null):void;
		/**
		 * Applies the sort and filter to the view.
		 *  The ICollectionView does not detect changes to a sort or
		 *  filter automatically, so you must call the refresh()
		 *  method to update the view after setting the sort
		 *  or filterFunction property.
		 *  If your ICollectionView implementation also implements
		 *  the IMXMLObject interface, you should to call the
		 *  refresh() method from your initialized()
		 *  method.
		 *
		 * @return                  <Boolean> true if the refresh() was complete,
		 *                            false if the refresh() is incomplete.
		 */
		public function refresh():Boolean;
	}
}
