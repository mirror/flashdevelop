package mx.collections
{
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.PropertyChangeEvent;
	import mx.events.PropertyChangeEventKind;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.IXMLNotifiable;
	import mx.utils.XMLNotifier;
	import mx.utils.UIDUtil;

	/**
	 *  Dispatched when the IList has been updated in some way. *   *  @eventType mx.events.CollectionEvent.COLLECTION_CHANGE
	 */
	[Event(name="collectionChange", type="mx.events.CollectionEvent")] 

	/**
	 *  @private *  A simple implementation of IList that uses a backing XMLList. *  No ItemPendingErrors since the data is always local.
	 */
	public class XMLListAdapter extends EventDispatcher implements IList
	{
		/**
		 *  @private	 *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;
		private var _source : XMLList;
		/**
		 *  indicates if events should be dispatched.	 *  calls to enableEvents() and disableEvents() effect the value when == 0	 *  events should be dispatched.
		 */
		private var _dispatchEvents : int;
		/**
		 *  non-zero if we're processing an addItem or removeItem
		 */
		private var _busy : int;
		private var seedUID : String;
		private var uidCounter : int;

		/**
		 *  The number of items in this list.       *      *  @return -1 if the length is unknown while 0 means no items
		 */
		public function get length () : int;
		/**
		 *  The source XMLList for this XMLListAdapter.       *  Any changes done through the IList interface will be reflected in the      *  source XMLList.       *  If no source XMLList was supplied the XMLListAdapter will create one      *  internally.     *  Changes made directly to the underlying XMLList (e.g., calling      *  <code>delete theList[someIndex]</code> will not cause <code>CollectionEvents</code>      *  to be dispatched.
		 */
		public function get source () : XMLList;
		public function set source (s:XMLList) : void;

		/**
		 *  Construct a new XMLListAdapter using the specified XMLList as its source.     *  If no source is specified an empty XMLList will be used.
		 */
		public function XMLListAdapter (source:XMLList = null);
		/**
		 *  Add the specified item to the end of the list.     *  Equivalent to addItemAt(item, length);     *  @param item the item to add
		 */
		public function addItem (item:Object) : void;
		/**
		 *  Add the item at the specified index.  Any item that was after     *  this index is moved out by one.  If the list is shorter than      *  the specified index it will grow to accomodate the new item.     *      *  @param item the item to place at the index     *  @param index the index at which to place the item     *  @throws RangeError if index is less than 0
		 */
		public function addItemAt (item:Object, index:int) : void;
		/**
		 *  Get the item at the specified index.     *      *  @param index the index in the list from which to retrieve the item     *  @param	prefetch int indicating both the direction and amount of items     *			to fetch during the request should the item not be local.     *  @return the item at that index, null if there is none     *  @throws ItemPendingError if the data for that index needs to be      *                          loaded from a remote location     *  @throws RangeError if the index < 0 or index >= length
		 */
		public function getItemAt (index:int, prefetch:int = 0) : Object;
		/**
		 *  Return the index of the item if it is in the list such that     *  getItemAt(index) == item.  Note: unlike IViewCursor.findXXX     *  <code>getItemIndex</code> cannot take a representative object, it is     *  searching for an exact match.     *      *  @param item the item to find     *  @return the index of the item, -1 if the item is not in the list.
		 */
		public function getItemIndex (item:Object) : int;
		/**
		 *  Notify the view that an item has been updated.  This is useful if the     *  contents of the view do not implement <code>IEventDispatcher</code>      *  and dispatches a <code>PropertyChangeEvent</code>.  If a property     *  is specified the view may be able to optimize its notification mechanism.     *  Otherwise it may choose to simply refresh the whole view.     *     *  @param item The item within the view that was updated.	 *     *  @param property A String, QName, or int	 *  specifying the property that was updated.	 *     *  @param oldValue The old value of that property.	 *  (If property was null, this can be the old value of the item.)	 *     *  @param newValue The new value of that property.	 *  (If property was null, there's no need to specify this	 *  as the item is assumed to be the new value.)     *     *  @see mx.events.CollectionEvent     *  @see mx.core.IPropertyChangeNotifier     *  @see mx.events.PropertyChangeEvent
		 */
		public function itemUpdated (item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null) : void;
		/**
		 * Remove all items from the list.
		 */
		public function removeAll () : void;
		/**
		 *  Remove the item at the specified index and return it.  Any items     *  that were after this index are now one index earlier.     *     *  @param index the index from which to remove the item     *  @return the item that was removed     *  @throws RangeError is index is less than 0 or greater than length
		 */
		public function removeItemAt (index:int) : Object;
		/**
		 *  Place the item at the specified index.  If an item was already     *  at that index the new item will replace it and it will be returned.     *  If the list is shorter than the specified index it will grow to      *  to accomodate the new item.     *     *  @param item the new value for the index     *  @param index the index at which to place the item     *  @return the item that was replaced, null if none     *  @throws RangeError if index is less than 0
		 */
		public function setItemAt (item:Object, index:int) : Object;
		/**
		 *  Return an Array that is populated in the same order as the IList     *  implementation.       *      *  @throws ItemPendingError if the data is not yet completely loaded     *  from a remote location
		 */
		public function toArray () : Array;
		/**
		 *  Pretty prints the contents of this XMLListAdapter to a string and returns it.
		 */
		public function toString () : String;
		/**
		 *  True if we're processing a addItem or removeItem call
		 */
		public function busy () : Boolean;
		/**
		 *  Enables event dispatch for this list.
		 */
		protected function enableEvents () : void;
		/**
		 *  Disables event dispatch for this list.	 *  To re-enable events call enableEvents(), enableEvents() must be called	 *  a matching number of times as disableEvents().
		 */
		protected function disableEvents () : void;
		/**
		 *  clears busy flag
		 */
		private function clearBusy () : void;
		/**
		 *  Sets busy flag.  Tree DP's check it so they	 *  know whether to fake events for it or not.
		 */
		private function setBusy () : void;
		/**
		 *  Called whenever any of the contained items in the list fire an     *  ObjectChange event.       *  Wraps it in a CollectionEventKind.UPDATE.
		 */
		protected function itemUpdateHandler (event:PropertyChangeEvent) : void;
		/**
		 * Called whenever an XML object contained in our list is updated     * in some way.  The initial implementation stab is very lenient,     * any changeType will cause an update no matter how much further down     * in a hierarchy.
		 */
		public function xmlNotification (currentTarget:Object, type:String, target:Object, value:Object, detail:Object) : void;
		/**
		 *  This is called by addItemAt and when the source is initially     *  assigned.
		 */
		protected function startTrackUpdates (item:Object, uid:String) : void;
		/**
		 *  This is called by removeItemAt, removeAll, and before a new     *  source is assigned.
		 */
		protected function stopTrackUpdates (item:Object) : void;
	}
}
