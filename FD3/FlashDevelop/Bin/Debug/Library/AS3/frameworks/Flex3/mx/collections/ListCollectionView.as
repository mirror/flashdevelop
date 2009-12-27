package mx.collections
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.getQualifiedClassName;
	import mx.collections.errors.CollectionViewError;
	import mx.collections.errors.CursorError;
	import mx.collections.errors.ItemPendingError;
	import mx.collections.errors.SortError;
	import mx.core.IMXMLObject;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.ObjectUtil;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import mx.events.*;
	import mx.collections.*;
	import mx.collections.errors.*;
	import mx.core.mx_internal;
	import mx.managers.*;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  Dispatched when the ICollectionView has been updated in some way.
 *
 *  @eventType mx.events.CollectionEvent.COLLECTION_CHANGE
	 */
	[Event(name="collectionChange", type="mx.events.CollectionEvent")] 

include "../core/Version.as"
	/**
	 *  Dispatched whenever the cursor position is updated.
 *
 *  @eventType mx.events.FlexEvent.CURSOR_UPDATE
	 */
	[Event(name="cursorUpdate", type="mx.events.FlexEvent")] 

	/**
	 * The ListCollectionView class adds the properties and methods of the
 * <code>ICollectionView</code> interface to an object that conforms to the
 * <code>IList</code> interface. As a result, you can pass an object of this class
 * to anything that requires an <code>IList</code> or <code>ICollectionView</code>.
 *
 * <p>This class also lets you use [ ] array notation
 * to access the <code>getItemAt()</code> and <code>setItemAt()</code> methods.
 * If you use code such as <code>myListCollectionView[index]</code>
 * Flex calls the <code>myListCollectionView</code> object's
 * <code>getItemAt()</code> or <code>setItemAt()</code> method.</p>
 * 
 * @mxml
 *
 *  <p>The <code>&lt;mx:ListCollectionView&gt;</code> has the following attributes,
 *  which all of its subclasses inherit:</p>
 *
 *  <pre>
 *  &lt;mx:ListCollectionView
 *  <b>Properties</b>
 *  filterFunction="null"
 *  list="null"
 *  sort="null"
 *  <b>Events</b>
 *  collectionChange="<i>No default</i>"
 *  /&gt;
 *  </pre>
	 */
	public class ListCollectionView extends Proxy implements ICollectionView
	{
		/**
		 *  @private
     *  Internal event dispatcher.
		 */
		private var eventDispatcher : EventDispatcher;
		/**
		 *  @private
     *  Revisions are used for bookmark maintenace,
     *  see getBookmark() and getBookmarkIndex() along with reset().
		 */
		private var revision : int;
		/**
		 *  @private
     *  Used internally for managing disableAutoUpdate and enableAutoUpdate
     *  calls.  disableAutoUpdate increments the counter, enable decrements.
     *  When the counter reaches 0 handlePendingUpdates is called.
		 */
		private var autoUpdateCounter : int;
		/**
		 *  @private
     *  Any update events that occured while autoUpdateCounter > 0
     *  are stored here.
     *  This may be null when there are no updates.
		 */
		private var pendingUpdates : Array;
		/**
		 *  @private
     *  Flag that indicates whether a RESET type of collectionChange 
     *  event should be emitted when reset() is called.
		 */
		var dispatchResetEvent : Boolean;
		/**
		 *  @private
     *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  When the view is sorted or filtered the <code>localIndex</code> property
     *  contains an array of items in the sorted or filtered (ordered, reduced)
     *  view, in the sorted order.
     *  The ListCollectionView class uses this property to access the items in 
     *  the view.
     *  The <code>localIndex</code> property should never contain anything
     *  that is not in the source, but may not have everything in the source.  
     *  This property is <code>null</code> when there is no sort.
		 */
		protected var localIndex : Array;
		/**
		 *  @private
     *  Storage for the list property.
		 */
		private var _list : IList;
		/**
		 *  @private
     *  Storage for the filterFunction property.
		 */
		private var _filterFunction : Function;
		/**
		 *  @private
     *  Storage for the sort property.
		 */
		private var _sort : Sort;

		/**
		 *  @inheritDoc
		 */
		public function get length () : int;

		/**
		 *  The IList that this collection view wraps.
		 */
		public function get list () : IList;
		/**
		 *  @private
		 */
		public function set list (value:IList) : void;

		/**
		 *  @inheritDoc
     *
     *  @see #refresh()
		 */
		public function get filterFunction () : Function;
		/**
		 *  @private
		 */
		public function set filterFunction (f:Function) : void;

		/**
		 *  @inheritDoc
     *
     *  @see #refresh()
		 */
		public function get sort () : Sort;
		/**
		 *  @private
		 */
		public function set sort (s:Sort) : void;

		/**
		 *  The ListCollectionView constructor.
     *
     *  @param list the IList this ListCollectionView is meant to wrap.
		 */
		public function ListCollectionView (list:IList = null);

		/**
		 *  Called automatically by the MXML compiler when the ListCollectionView
      *  is created using an MXML tag.  
      *  If you create the ListCollectionView through ActionScript, you 
      *  must call this method passing in the MXML document and 
      *  <code>null</code> for the <code>id</code>.
      *
      *  @param document The MXML document containing this ListCollectionView.
      *
      *  @param id Ignored.
		 */
		public function initialized (document:Object, id:String) : void;

		/**
		 *  @inheritDoc
     *
     *  @see #enableAutoUpdate()
     *  @see mx.events.CollectionEvent
		 */
		public function contains (item:Object) : Boolean;

		/**
		 *  @inheritDoc
     * 
     *  @see mx.collections.ICollectionView#enableAutoUpdate()
     *  @see mx.events.CollectionEvent
		 */
		public function disableAutoUpdate () : void;

		/**
		 *  @inheritDoc
     * 
     *  @see mx.collections.ICollectionView#disableAutoUpdate()
		 */
		public function enableAutoUpdate () : void;

		/**
		 *  @inheritDoc
		 */
		public function createCursor () : IViewCursor;

		/**
		 *  @inheritDoc
     *
     *  @see mx.events.CollectionEvent
     *  @see mx.core.IPropertyChangeNotifier
     *  @see mx.events.PropertyChangeEvent
		 */
		public function itemUpdated (item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null) : void;

		/**
		 * @inheritDoc
		 */
		public function refresh () : Boolean;

		/**
		 * @inheritDoc
		 */
		public function getItemAt (index:int, prefetch:int = 0) : Object;

		/**
		 * @inheritDoc
		 */
		public function setItemAt (item:Object, index:int) : Object;

		/**
		 * @inheritDoc
		 */
		public function addItem (item:Object) : void;

		/**
		 * @inheritDoc
		 */
		public function addItemAt (item:Object, index:int) : void;

		/**
		 *  Adds a list of items to the current list, placing them at the end of
     *  the list in the order they are passed.
     * 
     *  @param IList The list of items to add to the current list
		 */
		public function addAll (addList:IList) : void;

		/**
		 *  Adds a list of items to the current list, placing them at the position
     *  index passed in to the function.  The items are placed at the index location
     *  and placed in the order they are recieved.
     * 
     *  @param IList The list of items to add to the current list
     *  @param index The location of the current list to place the new items.
     *  @throws RangeError if index is less than 0 or greater than the length of the list.
		 */
		public function addAllAt (addList:IList, index:int) : void;

		/**
		 * @inheritDoc
		 */
		public function getItemIndex (item:Object) : int;

		/**
		 * @inheritDoc
		 */
		function getLocalItemIndex (item:Object) : int;

		/**
		 * @private
		 */
		private function getFilteredItemIndex (item:Object) : int;

		/**
		 * @inheritDoc
		 */
		public function removeItemAt (index:int) : Object;

		/**
		 * Remove all items from the list.
		 */
		public function removeAll () : void;

		/**
		 * @inheritDoc
		 */
		public function toArray () : Array;

		/**
		 *  Prints the contents of this view to a string and returns it.
     * 
     *  @return The contents of this view, in string form.
		 */
		public function toString () : String;

		/**
		 *  @private
     *  Attempts to call getItemAt(), converting the property name into an int.
		 */
		flash_proxy function getProperty (name:*) : *;

		/**
		 *  @private
     *  Attempts to call setItemAt(), converting the property name into an int.
		 */
		flash_proxy function setProperty (name:*, value:*) : void;

		/**
		 *  @private
     *  This is an internal function.
     *  The VM will call this method for code like <code>"foo" in bar</code>
     *  
     *  @param name The property name that should be tested for existence.
		 */
		flash_proxy function hasProperty (name:*) : Boolean;

		/**
		 *  @private
		 */
		flash_proxy function nextNameIndex (index:int) : int;

		/**
		 *  @private
		 */
		flash_proxy function nextName (index:int) : String;

		/**
		 *  @private
		 */
		flash_proxy function nextValue (index:int) : *;

		/**
		 *  @private
     *  Any methods that can't be found on this class shouldn't be called,
     *  so return null
		 */
		flash_proxy function callProperty (name:*, ...rest) : *;

		/**
		 *  @inheritDoc
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;

		/**
		 *  @inheritDoc
		 */
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;

		/**
		 *  @inheritDoc
		 */
		public function dispatchEvent (event:Event) : Boolean;

		/**
		 *  @inheritDoc
		 */
		public function hasEventListener (type:String) : Boolean;

		/**
		 *  @inheritDoc
		 */
		public function willTrigger (type:String) : Boolean;

		/**
		 *  Take the item and insert it into the view.  If we don't have a sort
     *  use the sourceLocation.  Dispatch the CollectionEvent with kind ADD
     *  if dispatch is true.
     *
     *  @param items the items to add into the view
     *  @param sourceLocation the location within the list where the items were added
     *  @param extendedInfo Object reference to any additional event information
     *         that needs to be preserved.
     *  @param dispatch true if the view should dispatch a corresponding
     *                 CollectionEvent with kind ADD (default is true)
		 */
		private function addItemsToView (items:Array, sourceLocation:int, dispatch:Boolean = true) : int;

		/**
		 *  Find the item specified using the Sort find mode constants.
     *  If there is no sort assigned throw an error.
     *
     *  @param values the values object that can be passed into Sort.findItem
     *  @param mode the mode to pass to Sort.findItem (see Sort)
     *  @param insertIndex true if it should find the insertion point
     *  @return the index where the item is located, -1 if not found
		 */
		function findItem (values:Object, mode:String, insertIndex:Boolean = false) : int;

		/**
		 *  Create a bookmark for this view.  This method is called by
     *  ListCollectionViewCursor.
     *
     *  @param index the index to bookmark
     *  @return a new bookmark instance
     *  @throws a CollectionViewError if the index is out of bounds
		 */
		function getBookmark (index:int) : ListCollectionViewBookmark;

		/**
		 *  Given a bookmark find the location for the value.  If the
     *  view has been modified since the bookmark was created attempt
     *  to relocate the item.  If the bookmark represents an item
     *  that is no longer in the view (removed or filtered out) return
     *  -1.
     *
     *  @param bookmark the bookmark to locate
     *  @return the new location of the bookmark, -1 if not in the view anymore
     *  @throws CollectionViewError if the bookmark is invalid
		 */
		function getBookmarkIndex (bookmark:CursorBookmark) : int;

		/**
		 * The view is a listener of CollectionEvents on its underlying IList
		 */
		private function listChangeHandler (event:CollectionEvent) : void;

		/**
		 * Given a set of PropertyChangeEvents go through and update the view.
     * This is currently not optimized.
		 */
		private function handlePropertyChangeEvents (events:Array) : void;

		/**
		 * When enableAutoUpdates pushes autoUpdateCounter back down to 0
     * this method will execute to consolidate the pending update
     * events or turn it into a massive refresh().
		 */
		private function handlePendingUpdates () : void;

		private function internalRefresh (dispatch:Boolean) : Boolean;

		/**
		 * Remove the old value from the view and replace it with the value
		 */
		private function moveItemInView (item:Object, dispatch:Boolean = true, updateEventItems:Array = null) : void;

		/**
		 * Copy all of the data from the source list into the local index.
		 */
		private function populateLocalIndex () : void;

		/**
		 *  Take the item and remove it from the view.  If we don't have a sort
     *  use the sourceLocation.  Dispatch the CollectionEvent with kind REMOVE
     *  if dispatch is true.
     *
     *  @param items the items to remove from the view
     *  @param sourceLocation the location within the list where the item was removed
     *  @param dispatch true if the view should dispatch a corresponding
     *                 CollectionEvent with kind REMOVE (default is true)
		 */
		private function removeItemsFromView (items:Array, sourceLocation:int, dispatch:Boolean = true) : void;

		/**
		 * Items is an array of PropertyChangeEvents so replace the oldValues with the new
     * newValues.  Start at the location specified and move forward, it's unlikely
     * that the length of items is > 1.
		 */
		private function replaceItemsInView (items:Array, location:int, dispatch:Boolean = true) : void;

		/**
		 *  @private
     *  When the source list is replaced, reset.
		 */
		function reset () : void;
	}
	/**
	 *  @private
 *  The internal implementation of cursor for the ListCollectionView.
	 */
	private class ListCollectionViewCursor extends EventDispatcher implements IViewCursor
	{
		/**
		 *  @private
		 */
		private static const BEFORE_FIRST_INDEX : int = -1;
		/**
		 *  @private
		 */
		private static const AFTER_LAST_INDEX : int = -2;
		/**
		 *  @private
		 */
		private var _view : ListCollectionView;
		/**
		 *  @private
		 */
		private var currentIndex : int;
		/**
		 *  @private
		 */
		private var currentValue : Object;
		/**
		 *  @private
		 */
		private var invalid : Boolean;
		/**
		 *  @private
     *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  Get a reference to the view that this cursor is associated with.
     *  @return the associated <code>ICollectionView</code>
		 */
		public function get view () : ICollectionView;

		/**
		 *  Provides access the object at the current location referenced by
     *  this cursor within the source collection.
     *  If the cursor is beyond the ends of the collection (beforeFirst,
     *  afterLast) this will return <code>null</code>.
     *
     *  @see mx.collections.IViewCursor#moveNext
     *  @see mx.collections.IViewCursor#movePrevious
     *  @see mx.collections.IViewCursor#seek
     *  @see mx.collections.IViewCursor#beforeFirst
     *  @see mx.collections.IViewCursor#afterLast
		 */
		public function get current () : Object;

		/**
		 *  Provides access to the bookmark of the item returned by the
     *  <code>current</code> property.
     *  The bookmark can be used to move the cursor to a previously visited
     *  item, or one relative to it (see the <code>seek()</code> method for
     *  more information).
     *
     *  @see mx.collections.IViewCursor#current
     *  @see mx.collections.IViewCursor#seek
		 */
		public function get bookmark () : CursorBookmark;

		/**
		 * true if the current is sitting before the first item in the view.
     * If the ICollectionView is empty (length == 0) this will always
     * be true.
		 */
		public function get beforeFirst () : Boolean;

		/**
		 * true if the cursor is sitting after the last item in the view.
     * If the ICollectionView is empty (length == 0) this will always
     * be true.
		 */
		public function get afterLast () : Boolean;

		/**
		 *  Constructor.
     *
     *  <p>Creates the cursor for the view.</p>
		 */
		public function ListCollectionViewCursor (view:ListCollectionView);

		/**
		 *  Finds the item with the specified properties within the
     *  collection and positions the cursor on that item.
     *  If the item can not be found no change to the current location will be
     *  made.
     *  <code>findAny()</code> can only be called on sorted views, if the view
     *  isn't sorted a <code>CursorError</code> will be thrown.
     *  <p>
     *  If the associated collection is remote, and not all of the items have
     *  been cached locally this method will begin an asynchronous fetch from the
     *  remote collection, or if one is already in progress wait for it to
     *  complete before making another fetch request.
     *  If multiple items can match the search criteria then the item found is
     *  non-deterministic.
     *  If it is important to find the first or last occurrence of an item in a
     *  non-unique index use the <code>findFirst()</code> or
     *  <code>findLast()</code>.
     *  The values specified must be configured as name-value pairs, as in an
     *  associative array (or the actual object to search for).
     *  The values of the names specified must match those properties specified in
     *  the sort. for example
     *  If properties "x", "y", and "z" are the in the current index, the values
     *  specified should be {x:x-value, y:y-value,z:z-value}.
     *  When all of the data is local this method will return <code>true</code> if
     *  the item can be found and false otherwise.
     *  If the data is not local and an asynchronous operation must be performed,
     *  an <code>ItemPendingError</code> will be thrown.
     *
     *  @see mx.collections.IViewCursor#findFirst
     *  @see mx.collections.IViewCursor#findLast
     *  @see mx.collections.errors.ItemPendingError
		 */
		public function findAny (values:Object) : Boolean;

		/**
		 *  Finds the first item with the specified properties
     *  within the collection and positions the cursor on that item.
     *  If the item can not be found no change to the current location will be
     *  made.
     *  <code>findFirst()</code> can only be called on sorted views, if the view
     *  isn't sorted a <code>CursorError</code> will be thrown.
     *  <p>
     *  If the associated collection is remote, and not all of the items have been
     *  cached locally this method will begin an asynchronous fetch from the
     *  remote collection, or if one is already in progress wait for it to
     *  complete before making another fetch request.
     *  If it is not important to find the first occurrence of an item in a
     *  non-unique index use <code>findAny()</code> as it may be a little faster.
     *  The values specified must be configured as name-value pairs, as in an
     *  associative array (or the actual object to search for).
     *  The values of the names specified must match those properties specified in
     *  the sort. for example If properties "x", "y", and "z" are the in the current
     *  index, the values specified should be {x:x-value, y:y-value,z:z-value}.
     *  When all of the data is local this method will
     *  return <code>true</code> if the item can be found and false otherwise.
     *  If the data is not local and an asynchronous operation must be performed,
     *  an <code>ItemPendingError</code> will be thrown.
     *
     *  @see mx.collections.IViewCursor#findAny
     *  @see mx.collections.IViewCursor#findLast
     *  @see mx.collections.errors.ItemPendingError
		 */
		public function findFirst (values:Object) : Boolean;

		/**
		 *  Finds the last item with the specified properties
     *  within the collection and positions the cursor on that item.
     *  If the item can not be found no change to the current location will be
     *  made.
     *  <code>findLast()</code> can only be called on sorted views, if the view
     *  isn't sorted a <code>CursorError</code> will be thrown.
     *  <p>
     *  If the associated collection is remote, and not all of the items have been
     *  cached locally this method will begin an asynchronous fetch from the
     *  remote collection, or if one is already in progress wait for it to
     *  complete before making another fetch request.
     *  If it is not important to find the last occurrence of an item in a
     *  non-unique index use <code>findAny()</code> as it may be a little faster.
     *  The values specified must be configured as  name-value pairs, as in an
     *  associative array (or the actual object to search for).
     *  The values of the names specified must match those properties specified in
     *  the sort. for example If properties "x", "y", and "z" are the in the current
     *  index, the values specified should be {x:x-value, y:y-value,z:z-value}.
     *  When all of the data is local this method will
     *  return <code>true</code> if the item can be found and false otherwise.
     *  If the data is not local and an asynchronous operation must be performed,
     *  an <code>ItemPendingError</code> will be thrown.
     *
     *  @see mx.collections.IViewCursor#findAny
     *  @see mx.collections.IViewCursor#findFirst
     *  @see mx.collections.errors.ItemPendingError
		 */
		public function findLast (values:Object) : Boolean;

		/**
		 * Insert the specified item before the cursor's current position.
     * If the cursor is <code>afterLast</code> the insertion
     * will happen at the end of the View.  If the cursor is
     * <code>beforeFirst</code> on a non-empty view an error will be thrown.
		 */
		public function insert (item:Object) : void;

		/**
		 *  Moves the cursor to the next item within the collection. On success
     *  the <code>current</code> property will be updated to reference the object at this
     *  new location.  Returns true if current is valid, false if not (afterLast).
     *  If the data is not local and an asynchronous operation must be performed, an
     *  <code>ItemPendingError</code> will be thrown. See the ItemPendingError docs
     *  as well as the collections documentation for more information on using the
     *  ItemPendingError.
     *
     *  @return true if still in the list, false if current is now afterLast
     *
     *  @see mx.collections.IViewCursor#current
     *  @see mx.collections.IViewCursor#movePrevious
     *  @see mx.collections.errors.ItemPendingError
     *  @see mx.collectoins.events.ItemAvailableEvent
     *  @example
     *  <pre>
     *    var myArrayCollection:ICollectionView = new ArrayCollection(["Bobby", "Mark", "Trevor", "Jacey", "Tyler"]);
     *    var cursor:IViewCursor = myArrayCollection.createCursor();
     *    while (!cursor.afterLast)
     *    {
     *       trace(cursor.current);
     *       cursor.moveNext();
     *     }
     *  </pre>
		 */
		public function moveNext () : Boolean;

		/**
		 *  Moves the cursor to the previous item within the collection. On success
     *  the <code>current</code> property will be updated to reference the object at this
     *  new location.  Returns true if current is valid, false if not (beforeFirst).
     *  If the data is not local and an asynchronous operation must be performed, an
     *  <code>ItemPendingError</code> will be thrown. See the ItemPendingError docs
     * as well as the collections documentation for more information on using the
     * ItemPendingError.
     *
     *  @return true if still in the list, false if current is now beforeFirst
     *
     *  @see mx.collections.IViewCursor#current
     *  @see mx.collections.IViewCursor#moveNext
     *  @see mx.collections.errors.ItemPendingError
     *  @see mx.collectoins.events.ItemAvailableEvent
     *  @example
     *  <pre>
     *     var myArrayCollection:ICollectionView = new ArrayCollection(["Bobby", "Mark", "Trevor", "Jacey", "Tyler"]);
     *     var cursor:ICursor = myArrayCollection.createCursor();
     *     cursor.seek(CursorBookmark.last);
     *     while (!cursor.beforeFirst)
     *     {
     *        trace(current);
     *        cursor.movePrevious();
     *      }
     *  </pre>
		 */
		public function movePrevious () : Boolean;

		/**
		 * Remove the current item and return it.  If the cursor is
     * <code>beforeFirst</code> or <code>afterLast</code> throw a
     * CursorError.
		 */
		public function remove () : Object;

		/**
		 *  Moves the cursor to a location at an offset from the specified
     *  bookmark.
     *  The offset can be negative in which case the cursor is positioned an
     *  offset number of items prior to the specified bookmark.
     *  If the associated collection is remote, and not all of the items have been
     *  cached locally this method will begin an asynchronous fetch from the
     *  remote collection.
     *
     *  If the data is not local and an asynchronous operation must be performed, an
     *  <code>ItemPendingError</code> will be thrown. See the ItemPendingError docs
     *  as well as the collections documentation for more information on using the
     *  ItemPendingError.
     *
     *
     *  @param bookmark <code>CursorBookmark</code> reference to marker information that
     *                 allows repositioning to a specific location.
     *           In addition to supplying a value returned from the <code>bookmark</code>
     *           property, there are three constant bookmark values that can be
     *           specified:
     *            <ul>
     *                <li><code>CursorBookmark.FIRST</code> - seek from
     *                the start (first element) of the collection</li>
     *                <li><code>CursorBookmark.CURRENT</code> - seek from
     *                the current position in the collection</li>
     *                <li><code>CursorBookmark.LAST</code> - seek from the
     *                end (last element) of the collection</li>
     *            </ul>
     *  @param offset indicates how far from the specified bookmark to seek.
     *           If the specified number is negative the cursor will attempt to
     *           move prior to the specified bookmark, if the offset specified is
     *           beyond the end points of the collection the cursor will be
     *           positioned off the end (beforeFirst or afterLast).
     *  @param prefetch indicates the intent to iterate in a specific direction once the
     *           seek operation completes, this reduces the number of required
     *           network round trips during a seek.
     *           If the iteration direction is known at the time of the request
     *           the appropriate amount of data can be returned ahead of the
     *           request to iterate it.
		 */
		public function seek (bookmark:CursorBookmark, offset:int = 0, prefetch:int = 0) : void;

		private function checkValid () : void;

		private function collectionEventHandler (event:CollectionEvent) : void;

		/**
		 *  @private
		 */
		private function setCurrent (value:Object, dispatch:Boolean = true) : void;
	}
	/**
	 *  @private
 *  Encapsulates the positional aspects of a cursor within an ListCollectionView.
 *  Only the ListCollectionView should construct this.
	 */
	private class ListCollectionViewBookmark extends CursorBookmark
	{
		var index : int;
		var view : ListCollectionView;
		var viewRevision : int;

		/**
		 *  @private
		 */
		public function ListCollectionViewBookmark (value:Object, view:ListCollectionView, viewRevision:int, index:int);

		/**
		 * Get the approximate index of the item represented by this bookmark
     * in its view.  If the item has been paged out this may throw an
     * ItemPendingError.  If the item is not in the current view -1 will be
     * returned.  This method may also return -1 if index-based location is not
     * possible.
		 */
		public function getViewIndex () : int;
	}
}
