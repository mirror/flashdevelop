/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	import flash.utils.Proxy;
	import mx.core.IMXMLObject;
	import flash.events.Event;
	public class ListCollectionView extends Proxy implements ICollectionView, IList, IMXMLObject {
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
		 * The IList that this collection view wraps.
		 */
		public function get list():IList;
		public function set list(value:IList):void;
		/**
		 * When the view is sorted or filtered the localIndex property
		 *  contains an array of items in the sorted or filtered (ordered, reduced)
		 *  view, in the sorted order.
		 *  The ListCollectionView class uses this property to access the items in
		 *  the view.
		 *  The localIndex property should never contain anything
		 *  that is not in the source, but may not have everything in the source.
		 *  This property is null when there is no sort.
		 */
		protected var localIndex:Array;
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
		 * The ListCollectionView constructor.
		 *
		 * @param list              <IList (default = null)> the IList this ListCollectionView is meant to wrap.
		 */
		public function ListCollectionView(list:IList = null);
		/**
		 * Registers an event listener object with an EventDispatcher object so that the listener
		 *  receives notification of an event. You can register event listeners on all nodes in the
		 *  display list for a specific type of event, phase, and priority.
		 *
		 * @param type              <String> The type of event.
		 * @param listener          <Function> The listener function that processes the event. This function must accept an event object
		 *                            as its only parameter and must return nothing, as this example shows:
		 *                            function(evt:Event):void
		 *                            The function can have any name.
		 * @param useCapture        <Boolean (default = false)> Determines whether the listener works in the capture phase or the target
		 *                            and bubbling phases. If useCapture is set to true, the
		 *                            listener processes the event only during the capture phase and not in the target or
		 *                            bubbling phase. If useCapture is false, the listener processes the event only
		 *                            during the target or bubbling phase. To listen for the event in all three phases, call
		 *                            addEventListener() twice, once with useCapture set to true,
		 *                            then again with useCapture set to false.
		 * @param priority          <int (default = 0)> The priority level of the event listener. Priorities are designated by a 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.
		 * @param useWeakReference  <Boolean (default = false)> Determines whether the reference to the listener is strong or weak. A strong
		 *                            reference (the default) prevents your listener from being garbage-collected. A weak
		 *                            reference does not. Class-level member functions are not subject to garbage
		 *                            collection, so you can set useWeakReference to true for
		 *                            class-level member functions without subjecting them to garbage collection. If you set
		 *                            useWeakReference to true for a listener that is a nested inner
		 *                            function, the function will be garbge-collected and no longer persistent. If you create
		 *                            references to the inner function (save it in another variable) then it is not
		 *                            garbage-collected and stays persistent.
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		/**
		 * Adds the specified item to the end of the list.
		 *  Equivalent to addItemAt(item, length).
		 *
		 * @param item              <Object> The item to add.
		 */
		public function addItem(item:Object):void;
		/**
		 * Adds the item at the specified index.
		 *  The index of any item greater than the index of the added item is increased by one.
		 *  If the the specified index is less than zero or greater than the length
		 *  of the list, a RangeError is thrown.
		 *
		 * @param item              <Object> The item to place at the index.
		 * @param index             <int> The index at which to place the item.
		 */
		public function addItemAt(item:Object, index:int):void;
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
		 * Dispatches an event into the event flow. The event target is the
		 *  EventDispatcher object upon which dispatchEvent() is called.
		 *
		 * @param event             <Event> The event object dispatched into the event flow.
		 * @return                  <Boolean> A value of true unless preventDefault() is called on the event,
		 *                            in which case it returns false.
		 */
		public function dispatchEvent(event:Event):Boolean;
		/**
		 * Enables auto-updating.
		 *  See disableAutoUpdate for more information.
		 */
		public function enableAutoUpdate():void;
		/**
		 * Gets the item at the specified index.
		 *
		 * @param index             <int> The index in the list from which to retrieve the item.
		 * @param prefetch          <int (default = 0)> An int indicating both the direction
		 *                            and number of items to fetch during the request if the item is
		 *                            not local.
		 * @return                  <Object> The item at that index, or null if there is none.
		 */
		public function getItemAt(index:int, prefetch:int = 0):Object;
		/**
		 * Returns the index of the item if it is in the list such that
		 *  getItemAt(index) == item.
		 *
		 * @param item              <Object> The item to find.
		 * @return                  <int> The index of the item, or -1 if the item is not in the list.
		 */
		public function getItemIndex(item:Object):int;
		/**
		 * Checks whether the EventDispatcher object has any listeners registered for a specific type
		 *  of event. This allows you to determine where an EventDispatcher object has altered handling of an event type in the event flow hierarchy. To determine whether
		 *  a specific event type will actually trigger an event listener, use IEventDispatcher.willTrigger().
		 *
		 * @param type              <String> The type of event.
		 * @return                  <Boolean> A value of true if a listener of the specified type is registered; false otherwise.
		 */
		public function hasEventListener(type:String):Boolean;
		/**
		 * Called automatically by the MXML compiler when the ListCollectionView
		 *  is created using an MXML tag.
		 *  If you create the ListCollectionView through ActionScript, you
		 *  must call this method passing in the MXML document and
		 *  null for the id.
		 *
		 * @param document          <Object> The MXML document containing this ListCollectionView.
		 * @param id                <String> Ignored.
		 */
		public function initialized(document:Object, id:String):void;
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
		/**
		 * Remove all items from the list.
		 */
		public function removeAll():void;
		/**
		 * Removes a listener from the EventDispatcher object. If there is no matching listener
		 *  registered with the EventDispatcher object, a call to this method has no effect.
		 *
		 * @param type              <String> The type of event.
		 * @param listener          <Function> The listener object to remove.
		 * @param useCapture        <Boolean (default = false)> Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both: one call with useCapture set to true, and another call with useCapture set to false.
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		/**
		 * Removes the item at the specified index and returns it.
		 *  Any items that were after this index are now one index earlier.
		 *
		 * @param index             <int> The index from which to remove the item.
		 * @return                  <Object> The item that was removed.
		 */
		public function removeItemAt(index:int):Object;
		/**
		 * Places the item at the specified index.
		 *  If an item was already at that index the new item will replace it
		 *  and it will be returned.
		 *
		 * @param item              <Object> The new item to be placed at the specified index.
		 * @param index             <int> The index at which to place the item.
		 * @return                  <Object> The item that was replaced, or null if none.
		 */
		public function setItemAt(item:Object, index:int):Object;
		/**
		 * Returns an Array that is populated in the same order as the IList
		 *  implementation.
		 *  This method may throw an ItemPendingError.
		 */
		public function toArray():Array;
		/**
		 * Pretty prints the contents of this view to a string and returns it.
		 */
		public function toString():String;
		/**
		 * Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type. This method returns true if an event listener is triggered during any phase of the event flow when an event of the specified type is dispatched to this EventDispatcher object or any of its descendants.
		 *
		 * @param type              <String> The type of event.
		 * @return                  <Boolean> A value of true if a listener of the specified type will be triggered; false otherwise.
		 */
		public function willTrigger(type:String):Boolean;
	}
}
