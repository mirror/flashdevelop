package mx.collections
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.getQualifiedClassName;
	import mx.core.IPropertyChangeNotifier;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.PropertyChangeEvent;
	import mx.events.PropertyChangeEventKind;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.ArrayUtil;
	import mx.utils.UIDUtil;

	/**
	 *  Dispatched when the IList has been updated in some way.
 *  
 *  @eventType mx.events.CollectionEvent.COLLECTION_CHANGE
	 */
	[Event(name="collectionChange", type="mx.events.CollectionEvent")] 

include "../core/Version.as"
	/**
	 *  @private
 *  A simple implementation of IList that uses a backing Array.
 *  This base class will not throw ItemPendingErrors but it
 *  is possible that a subclass might.
	 */
	public class ArrayList extends EventDispatcher implements IList
	{
		/**
		 *  @private
	 *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  indicates if events should be dispatched.
	 *  calls to enableEvents() and disableEvents() effect the value when == 0
	 *  events should be dispatched.
		 */
		private var _dispatchEvents : int;
		private var _source : Array;
		private var _uid : String;

		/**
		 *  Get the number of items in the list.  An ArrayList should always
     *  know its length so it shouldn't return -1, though a subclass may 
     *  override that behavior.
     *
     *  @return int representing the length of the source.
		 */
		public function get length () : int;

		/**
		 *  The source array for this ArrayList.  
     *  Any changes done through the IList interface will be reflected in the 
     *  source array.  
     *  If no source array was supplied the ArrayList will create one internally.
     *  Changes made directly to the underlying Array (e.g., calling 
     *  <code>theList.source.pop()</code> will not cause <code>CollectionEvents</code> 
     *  to be dispatched.
     *
	 *  @return An Array that represents the underlying source.
		 */
		public function get source () : Array;
		public function set source (s:Array) : void;

		/**
		 *  Provides access to the unique id for this list.
     *  
     *  @return String representing the internal uid.
		 */
		public function get uid () : String;
		public function set uid (value:String) : void;

		/**
		 *  Construct a new ArrayList using the specified array as its source.
     *  If no source is specified an empty array will be used.
		 */
		public function ArrayList (source:Array = null);

		/**
		 *  Get the item at the specified index.
     * 
     *  @param 	index the index in the list from which to retrieve the item
     *  @param	prefetch int indicating both the direction and amount of items
     *			to fetch during the request should the item not be local.
     *  @return the item at that index, null if there is none
     *  @throws ItemPendingError if the data for that index needs to be 
     *                           loaded from a remote location
     *  @throws RangeError if the index < 0 or index >= length
		 */
		public function getItemAt (index:int, prefetch:int = 0) : Object;

		/**
		 *  Place the item at the specified index.  
     *  If an item was already at that index the new item will replace it and it 
     *  will be returned.
     *
     *  @param 	item the new value for the index
     *  @param 	index the index at which to place the item
     *  @return the item that was replaced, null if none
     *  @throws RangeError if index is less than 0 or greater than or equal to length
		 */
		public function setItemAt (item:Object, index:int) : Object;

		/**
		 *  Add the specified item to the end of the list.
     *  Equivalent to addItemAt(item, length);
     * 
     *  @param item the item to add
		 */
		public function addItem (item:Object) : void;

		/**
		 *  Add the item at the specified index.  
     *  Any item that was after this index is moved out by one.  
     * 
     *  @param item the item to place at the index
     *  @param index the index at which to place the item
     *  @throws RangeError if index is less than 0 or greater than the length
		 */
		public function addItemAt (item:Object, index:int) : void;

		/**
		 *  @copy mx.collections.ListCollectionView#addAll
		 */
		public function addAll (addList:IList) : void;

		/**
		 *  @copy mx.collections.ListCollectionView#addAllAt
		 */
		public function addAllAt (addList:IList, index:int) : void;

		/**
		 *  Return the index of the item if it is in the list such that
     *  getItemAt(index) == item.  
     *  Note that in this implementation the search is linear and is therefore 
     *  O(n).
     * 
     *  @param item the item to find
     *  @return the index of the item, -1 if the item is not in the list.
		 */
		public function getItemIndex (item:Object) : int;

		/**
		 *  Removes the specified item from this list, should it exist.
     *
     *	@param	item Object reference to the item that should be removed.
     *  @return	Boolean indicating if the item was removed.
		 */
		public function removeItem (item:Object) : Boolean;

		/**
		 *  Remove the item at the specified index and return it.  
     *  Any items that were after this index are now one index earlier.
     *
     *  @param index the index from which to remove the item
     *  @return the item that was removed
     *  @throws RangeError is index < 0 or index >= length
		 */
		public function removeItemAt (index:int) : Object;

		/**
		 *  Remove all items from the list.
		 */
		public function removeAll () : void;

		/**
		 *  Notify the view that an item has been updated.  
     *  This is useful if the contents of the view do not implement 
     *  <code>IEventDispatcher</code>.  
     *  If a property is specified the view may be able to optimize its 
     *  notification mechanism.
     *  Otherwise it may choose to simply refresh the whole view.
     *
     *  @param item The item within the view that was updated.
	 *
     *  @param property A String, QName, or int
	 *  specifying the property that was updated.
	 *
     *  @param oldValue The old value of that property.
	 *  (If property was null, this can be the old value of the item.)
	 *
     *  @param newValue The new value of that property.
	 *  (If property was null, there's no need to specify this
	 *  as the item is assumed to be the new value.)
     *
     *  @see mx.events.CollectionEvent
     *  @see mx.core.IPropertyChangeNotifier
     *  @see mx.events.PropertyChangeEvent
		 */
		public function itemUpdated (item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null) : void;

		/**
		 *  Return an Array that is populated in the same order as the IList
     *  implementation.  
     * 
     *  @throws ItemPendingError if the data is not yet completely loaded
     *  from a remote location
		 */
		public function toArray () : Array;

		/**
		 *  Ensures that only the source property is seralized.
     *  @private
		 */
		public function readExternal (input:IDataInput) : void;

		/**
		 *  Ensures that only the source property is serialized.
     *  @private
		 */
		public function writeExternal (output:IDataOutput) : void;

		/**
		 *  Pretty prints the contents of this ArrayList to a string and returns it.
		 */
		public function toString () : String;

		/**
		 *  Enables event dispatch for this list.
		 */
		private function enableEvents () : void;

		/**
		 *  Disables event dispatch for this list.
	 *  To re-enable events call enableEvents(), enableEvents() must be called
	 *  a matching number of times as disableEvents().
		 */
		private function disableEvents () : void;

		/**
		 *  Dispatches a collection event with the specified information.
	 *
	 *  @param kind String indicates what the kind property of the event should be
	 *  @param item Object reference to the item that was added or removed
	 *  @param location int indicating where in the source the item was added.
		 */
		private function internalDispatchEvent (kind:String, item:Object = null, location:int = -1) : void;

		/**
		 *  Called whenever any of the contained items in the list fire an
     *  ObjectChange event.  
     *  Wraps it in a CollectionEventKind.UPDATE.
		 */
		protected function itemUpdateHandler (event:PropertyChangeEvent) : void;

		/**
		 *  If the item is an IEventDispatcher watch it for updates.  
     *  This is called by addItemAt and when the source is initially
     *  assigned.
		 */
		protected function startTrackUpdates (item:Object) : void;

		/**
		 *  If the item is an IEventDispatcher stop watching it for updates.
     *  This is called by removeItemAt, removeAll, and before a new
     *  source is assigned.
		 */
		protected function stopTrackUpdates (item:Object) : void;
	}
}
