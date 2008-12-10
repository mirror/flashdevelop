package mx.collections
{
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import flash.events.Event;
	import mx.collections.ICollectionView;
	import mx.collections.errors.CollectionViewError;
	import mx.collections.errors.CursorError;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.core.mx_internal;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;
	import mx.events.PropertyChangeEvent;
	import flash.utils.Dictionary;
	import mx.collections.ModifiedCollectionView;
	import mx.collections.CursorBookmark;
	import flash.events.EventDispatcher;
	import mx.collections.IViewCursor;
	import mx.events.CollectionEvent;
	import mx.collections.ICollectionView;
	import mx.core.mx_internal;
	import mx.collections.errors.CursorError;
	import mx.collections.errors.CollectionViewError;
	import mx.collections.errors.ItemPendingError;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.collections.errors.CursorError;
	import flash.display.InteractiveObject;

	/**
	 *  Dispatched whenever the cursor position is updated. * *  @eventType mx.events.FlexEvent.CURSOR_UPDATE
	 */
	[Event(name="cursorUpdate", type="mx.events.FlexEvent")] 

	/**
	 * @private	 *  The ModifiedCollectionView class wraps a ListCollectionView object in order 	 *  to provide control over when removed, added, and replaced items are actually	 *  shown. It is used by list data change effects in order to determine the start	 *  and end state for effects after changes occur in a collection.	 * 	 *  Although it is marked as implementing ICollectionView for interface 	 *  compatibility reasons, many of the properties and methods aren't 	 *  implemented.
	 */
	public class ModifiedCollectionView implements ICollectionView
	{
		public static const REMOVED : String = "removed";
		public static const ADDED : String = "added";
		public static const REPLACED : String = "replaced";
		public static const REPLACEMENT : String = "replacement";
		/**
		 *  @private		 *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private	     *  The underlying collection that this view is wrapping.
		 */
		private var list : ICollectionView;
		/**
		 *  @private	     *  The number of items that have been added/removed from the	     *  underlying collection which are being ignored/preserved in this	     *  collection. Any addition to the underlying collection decrements	     *  this value, any removal increments it.
		 */
		private var deltaLength : int;
		/**
		 *  @private	     *  An array of adds/removes from the underlying collection which  	     *  are being ignored/preserved in this wrapper. This elements in 	     *  this array are CollectionModification objects storing changes,	     *  and are kept in sorted order, according to the location in the 	     *  underlying collection where they occurred.
		 */
		private var deltas : Array;
		private var removedItems : Dictionary;
		private var addedItems : Dictionary;
		private var replacedItems : Dictionary;
		private var replacementItems : Dictionary;
		private var itemWrappersByIndex : Array;
		private var itemWrappersByCollectionMod : Dictionary;
		private var _showPreserved : Boolean;

		/**
		 *  @private
		 */
		public function get length () : int;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function get filterFunction () : Function;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function set filterFunction (value:Function) : void;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function get sort () : Sort;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function set sort (value:Sort) : void;
		/**
		 *  Enables or suppresses the ability of the collection to show		 *  previous or "preserved" state. If set to false, the		 *  ModifiedCollectionView will present a view equivalent to the		 *  current state of the ListCollectionView it is wrapping. If 		 *  set to true, it will present a view of the ListCollectionView		 *  ignoring any changes that have been integrated into the 		 *  ModifiedCollectionView.
		 */
		public function get showPreservedState () : Boolean;
		public function set showPreservedState (show:Boolean) : void;

		public function ModifiedCollectionView (list:ICollectionView);
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function disableAutoUpdate () : void;
		public function createCursor () : IViewCursor;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function contains (item:Object) : Boolean;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function itemUpdated (item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null) : void;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function refresh () : Boolean;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function enableAutoUpdate () : void;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function hasEventListener (type:String) : Boolean;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function willTrigger (type:String) : Boolean;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0.0, useWeakReference:Boolean = false) : void;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function dispatchEvent (event:Event) : Boolean;
		/**
		 *  Create a bookmark for this view.  This method is called by	     *  ModifiedCollectionViewCursor.	     *	     *  @param ModifiedCollectionViewCursor The cursor for which to create the bookmark	     * 	     *  @return a new bookmark instance	     * 	     *  @throws a CollectionViewError if the index is out of bounds
		 */
		function getBookmark (mcvCursor:ModifiedCollectionViewCursor) : ModifiedCollectionViewBookmark;
		/**
		 *  Given a bookmark find the location for the value.  If the	     *  view has been modified since the bookmark was created attempt	     *  to relocate the item.  If the bookmark represents an item	     *  that is no longer in the view (removed or filtered out) return	     *  -1.	     *	     *  @param bookmark the bookmark to locate	     * 	     *  @return the new location of the bookmark, -1 if not in the view anymore	     * 	     *  @throws CollectionViewError if the bookmark is invalid
		 */
		function getBookmarkIndex (bookmark:CursorBookmark) : int;
		/**
		 *  Given a cursor, and an index, return a wrapped version of the item at		 *  that index. The item may come either from the underlying collection		 *  (retrieved through the cursor) or from the annotations stored within		 *  the modifiedCollectionView.		 * 		 *  This method also adjusts the cursor as necessary.		 *
		 */
		function getWrappedItemUsingCursor (mcvCursor:ModifiedCollectionViewCursor, newIndex:int) : Object;
		public function getSemantics (itemWrapper:ItemWrapper) : String;
		/**
		 *  Processes a collection event generated by the underlying view. If the	     *  event is of type ADD, REMOVE, or REPLACE, it is integrated so that	     *  its effects are ignored if showPreserved is set to true.	     * 	     *  @param event A CollectionEvent generated by the ListCollectionView this	     *  ModifiedCollectionView is wrapping.	     * 	     *  @param startItemIndex	     * 	     *  @param endItemIndex
		 */
		public function processCollectionEvent (event:CollectionEvent, startItemIndex:int, endItemIndex:int) : void;
		/**
		 *  Stops showing an item that has been removed or replaced		 *  in the underlying ListCollectionView but which is still		 *  being shown by the ModifiedCollectionView.		 * 		 *  This function is meant to be called by ListBase in response to		 *  a RemoveItemAction effect.		 * 		 *  @param item The item to remove from the collection. This must have		 *  been removed from the original collection.
		 */
		public function removeItem (itemWrapper:ItemWrapper) : void;
		/**
		 *  Starts showing an item that has been added to the 		 *  underlying ListCollectionView but which is still		 *  being ignored by the ModifiedCollectionView.		 * 		 *  This function is meant to be called by ListBase in response to		 *  a AddItemAction effect.		 * 		 *  @param item The item to start showing in the collection. This must 		 *  have been added to the original collection.
		 */
		public function addItem (itemWrapper:ItemWrapper) : void;
		/**
		 *  @private		 *  Determines if a change to a collection should be considered		 *  active or suppressed.		 * 		 *  Currently, this is just based on the <code>showPreserved</code>		 *  property.
		 */
		private function isActive (mod:CollectionModification) : Boolean;
		/**
		 *  @private		 * 		 *  Removes a particular CollectionModification from the		 *  deltas array.
		 */
		private function removeModification (mod:CollectionModification) : Boolean;
		/**
		 *  @private		 * 		 *  Does the work of modifying the object to handle a collectionEvent of 		 *  collectionEventKind.REMOVE so that the removal can be ignored
		 */
		private function integrateRemovedElements (event:CollectionEvent, startItemIndex:int, endItemIndex:int) : void;
		/**
		 *  @private		 * 		 *  Does the work of modifying the object to handle a collectionEvent of 		 *  collectionEventKind.ADD so that the addition can be ignored
		 */
		private function integrateAddedElements (event:CollectionEvent, startItemIndex:int, endItemIndex:int) : void;
		/**
		 *  @private		 * 		 *  Does the work of modifying the object to handle a collectionEvent of 		 *  collectionEventKind.REPLACE so that the replacement can be ignored
		 */
		private function integrateReplacedElements (event:CollectionEvent, startItemIndex:int, endItemIndex:int) : void;
		private function getUniqueItemWrapper (item:Object, mod:CollectionModification, index:int, isReplacement:Boolean = false) : Object;
	}
	/**
	 *  @private *  The internal implementation of cursor for the ModifiedCollectionView. *  This cursor wraps a cursor to the underlying collection, and maintains *  additional state.
	 */
	internal class ModifiedCollectionViewCursor extends EventDispatcher implements IViewCursor
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
		private var _view : ModifiedCollectionView;
		/**
		 *  @private     *  An cursor into the underlying collection wrapped by the Modified     *  collection view.
		 */
		public var internalCursor : IViewCursor;
		/**
		 *  @private     *  The current overall index into the ModifiedCollectionView.
		 */
		local var currentIndex : int;
		/**
		 *  @private     *  The position of the internalCursor in its ICollectionView.     *  This is not part of the IViewCursor interface, so we     *  maintain it independently.
		 */
		public var internalIndex : int;
		/**
		 *  @private
		 */
		private var currentValue : Object;
		/**
		 *  @private
		 */
		private var invalid : Boolean;
		/**
		 *  @private	 *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  Get a reference to the view that this cursor is associated with.     *  @return the associated <code>ICollectionView</code>
		 */
		public function get view () : ICollectionView;
		/**
		 *  Provides access the object at the current location referenced by     *  this cursor within the source collection.     *  If the cursor is beyond the ends of the collection (beforeFirst,     *  afterLast) this will return <code>null</code>.     *     *  @see mx.collections.IViewCursor#moveNext     *  @see mx.collections.IViewCursor#movePrevious     *  @see mx.collections.IViewCursor#seek     *  @see mx.collections.IViewCursor#beforeFirst     *  @see mx.collections.IViewCursor#afterLast
		 */
		public function get current () : Object;
		/**
		 *  Provides access to the bookmark of the item returned by the     *  <code>current</code> property.     *  The bookmark can be used to move the cursor to a previously visited     *  item, or one relative to it (see the <code>seek()</code> method for     *  more information).     *     *  @see mx.collections.IViewCursor#current     *  @see mx.collections.IViewCursor#seek
		 */
		public function get bookmark () : CursorBookmark;
		/**
		 * true if the current is sitting before the first item in the view.     * If the ICollectionView is empty (length == 0) this will always     * be true.
		 */
		public function get beforeFirst () : Boolean;
		/**
		 * true if the cursor is sitting after the last item in the view.     * If the ICollectionView is empty (length == 0) this will always     * be true.
		 */
		public function get afterLast () : Boolean;

		/**
		 *  Constructor.     *     *  Creates the cursor for the view.     *      *  @param view The ModifiedCollectionView for which this is a cursor.     *      *  @param cursor A cursor into the underlying collection wrapped by the     *  ModifiedCollectionView.     *      *  @param current The item this cursor is currently pointing at.
		 */
		public function ModifiedCollectionViewCursor (view:ModifiedCollectionView, cursor:IViewCursor, current:Object);
		/**
		 *  Finds the item with the specified properties within the     *  collection and positions the cursor on that item.     *  If the item can not be found no change to the current location will be     *  made.     *  <code>findAny()</code> can only be called on sorted views, if the view     *  isn't sorted a <code>CursorError</code> will be thrown.     *  <p>     *  If the associated collection is remote, and not all of the items have     *  been cached locally this method will begin an asynchronous fetch from the     *  remote collection, or if one is already in progress wait for it to     *  complete before making another fetch request.     *  If multiple items can match the search criteria then the item found is     *  non-deterministic.     *  If it is important to find the first or last occurrence of an item in a     *  non-unique index use the <code>findFirst()</code> or     *  <code>findLast()</code>.     *  The values specified must be configured as name-value pairs, as in an     *  associative array (or the actual object to search for).     *  The values of the names specified must match those properties specified in     *  the sort. for example     *  If properties "x", "y", and "z" are the in the current index, the values     *  specified should be {x:x-value, y:y-value,z:z-value}.     *  When all of the data is local this method will return <code>true</code> if     *  the item can be found and false otherwise.     *  If the data is not local and an asynchronous operation must be performed,     *  an <code>ItemPendingError</code> will be thrown.     *     *  @see mx.collections.IViewCursor#findFirst     *  @see mx.collections.IViewCursor#findLast     *  @see mx.collections.errors.ItemPendingError
		 */
		public function findAny (values:Object) : Boolean;
		/**
		 *  Finds the first item with the specified properties     *  within the collection and positions the cursor on that item.     *  If the item can not be found no change to the current location will be     *  made.     *  <code>findFirst()</code> can only be called on sorted views, if the view     *  isn't sorted a <code>CursorError</code> will be thrown.     *  <p>     *  If the associated collection is remote, and not all of the items have been     *  cached locally this method will begin an asynchronous fetch from the     *  remote collection, or if one is already in progress wait for it to     *  complete before making another fetch request.     *  If it is not important to find the first occurrence of an item in a     *  non-unique index use <code>findAny()</code> as it may be a little faster.     *  The values specified must be configured as name-value pairs, as in an     *  associative array (or the actual object to search for).     *  The values of the names specified must match those properties specified in     *  the sort. for example If properties "x", "y", and "z" are the in the current     *  index, the values specified should be {x:x-value, y:y-value,z:z-value}.     *  When all of the data is local this method will     *  return <code>true</code> if the item can be found and false otherwise.     *  If the data is not local and an asynchronous operation must be performed,     *  an <code>ItemPendingError</code> will be thrown.     *     *  @see mx.collections.IViewCursor#findAny     *  @see mx.collections.IViewCursor#findLast     *  @see mx.collections.errors.ItemPendingError
		 */
		public function findFirst (values:Object) : Boolean;
		/**
		 *  Finds the last item with the specified properties     *  within the collection and positions the cursor on that item.     *  If the item can not be found no change to the current location will be     *  made.     *  <code>findLast()</code> can only be called on sorted views, if the view     *  isn't sorted a <code>CursorError</code> will be thrown.     *  <p>     *  If the associated collection is remote, and not all of the items have been     *  cached locally this method will begin an asynchronous fetch from the     *  remote collection, or if one is already in progress wait for it to     *  complete before making another fetch request.     *  If it is not important to find the last occurrence of an item in a     *  non-unique index use <code>findAny()</code> as it may be a little faster.     *  The values specified must be configured as  name-value pairs, as in an     *  associative array (or the actual object to search for).     *  The values of the names specified must match those properties specified in     *  the sort. for example If properties "x", "y", and "z" are the in the current     *  index, the values specified should be {x:x-value, y:y-value,z:z-value}.     *  When all of the data is local this method will     *  return <code>true</code> if the item can be found and false otherwise.     *  If the data is not local and an asynchronous operation must be performed,     *  an <code>ItemPendingError</code> will be thrown.     *     *  @see mx.collections.IViewCursor#findAny     *  @see mx.collections.IViewCursor#findFirst     *  @see mx.collections.errors.ItemPendingError
		 */
		public function findLast (values:Object) : Boolean;
		/**
		 * Insert the specified item before the cursor's current position.     * If the cursor is <code>afterLast</code> the insertion     * will happen at the end of the View.  If the cursor is     * <code>beforeFirst</code> on a non-empty view an error will be thrown.
		 */
		public function insert (item:Object) : void;
		/**
		 *  Moves the cursor to the next item within the collection. On success     *  the <code>current</code> property will be updated to reference the object at this     *  new location.  Returns true if current is valid, false if not (afterLast).     *  If the data is not local and an asynchronous operation must be performed, an     *  <code>ItemPendingError</code> will be thrown. See the ItemPendingError docs     *  as well as the collections documentation for more information on using the     *  ItemPendingError.     *     *  @return true if still in the list, false if current is now afterLast     *     *  @see mx.collections.IViewCursor#current     *  @see mx.collections.IViewCursor#movePrevious     *  @see mx.collections.errors.ItemPendingError     *  @see mx.collections.events.ItemAvailableEvent     *  @example     *  <pre>     *    var myArrayCollection:ICollectionView = new ArrayCollection(["Bobby", "Mark", "Trevor", "Jacey", "Tyler"]);     *    var cursor:IViewCursor = myArrayCollection.createCursor();     *    while (!cursor.afterLast)     *    {     *       trace(cursor.current);     *       cursor.moveNext();     *     }     *  </pre>
		 */
		public function moveNext () : Boolean;
		/**
		 *  Moves the cursor to the previous item within the collection. On success     *  the <code>current</code> property will be updated to reference the object at this     *  new location.  Returns true if current is valid, false if not (beforeFirst).     *  If the data is not local and an asynchronous operation must be performed, an     *  <code>ItemPendingError</code> will be thrown. See the ItemPendingError docs     * as well as the collections documentation for more information on using the     * ItemPendingError.     *     *  @return true if still in the list, false if current is now beforeFirst     *     *  @see mx.collections.IViewCursor#current     *  @see mx.collections.IViewCursor#moveNext     *  @see mx.collections.errors.ItemPendingError     *  @see mx.collections.events.ItemAvailableEvent     *  @example     *  <pre>     *     var myArrayCollection:ICollectionView = new ArrayCollection(["Bobby", "Mark", "Trevor", "Jacey", "Tyler"]);     *     var cursor:ICursor = myArrayCollection.createCursor();     *     cursor.seek(CursorBookmark.last);     *     while (!cursor.beforeFirst)     *     {     *        trace(current);     *        cursor.movePrevious();     *      }     *  </pre>
		 */
		public function movePrevious () : Boolean;
		/**
		 * Remove the current item and return it.  If the cursor is     * <code>beforeFirst</code> or <code>afterLast</code> throw a     * CursorError.
		 */
		public function remove () : Object;
		/**
		 *  Moves the cursor to a location at an offset from the specified     *  bookmark.     *  The offset can be negative in which case the cursor is positioned an     *  offset number of items prior to the specified bookmark.     *  If the associated collection is remote, and not all of the items have been     *  cached locally this method will begin an asynchronous fetch from the     *  remote collection.     *     *  If the data is not local and an asynchronous operation must be performed, an     *  <code>ItemPendingError</code> will be thrown. See the ItemPendingError docs     *  as well as the collections documentation for more information on using the     *  ItemPendingError.     *     *     *  @param bookmark <code>CursorBookmark</code> reference to marker information that     *                 allows repositioning to a specific location.     *           In addition to supplying a value returned from the <code>bookmark</code>     *           property, there are three constant bookmark values that can be     *           specified:     *            <ul>     *                <li><code>CursorBookmark.FIRST</code> - seek from     *                the start (first element) of the collection</li>     *                <li><code>CursorBookmark.CURRENT</code> - seek from     *                the current position in the collection</li>     *                <li><code>CursorBookmark.LAST</code> - seek from the     *                end (last element) of the collection</li>     *            </ul>     *  @param offset indicates how far from the specified bookmark to seek.     *           If the specified number is negative the cursor will attempt to     *           move prior to the specified bookmark, if the offset specified is     *           beyond the end points of the collection the cursor will be     *           positioned off the end (beforeFirst or afterLast).     *  @param prefetch indicates the intent to iterate in a specific direction once the     *           seek operation completes, this reduces the number of required     *           network round trips during a seek.     *           If the iteration direction is known at the time of the request     *           the appropriate amount of data can be returned ahead of the     *           request to iterate it.
		 */
		public function seek (bookmark:CursorBookmark, offset:int = 0, prefetch:int = 0) : void;
		private function checkValid () : void;
		/**
		 *  @private
		 */
		private function setCurrent (value:Object, dispatch:Boolean = true) : void;
	}
	/**
	 *  @private *  Encapsulates the positional aspects of a cursor within an ModifiedCollectionView. *  Only the ModifiedCollectionView should construct this.
	 */
	internal class ModifiedCollectionViewBookmark extends CursorBookmark
	{
		local var index : int;
		local var view : ModifiedCollectionView;
		local var viewRevision : int;
		local var internalBookmark : CursorBookmark;
		local var internalIndex : int;

		/**
		 *  @private
		 */
		public function ModifiedCollectionViewBookmark (value:Object, view:ModifiedCollectionView, viewRevision:int, index:int, internalBookmark:CursorBookmark, internalIndex:int);
		/**
		 * Get the approximate index of the item represented by this bookmark     * in its view.  If the item has been paged out this may throw an     * ItemPendingError.  If the item is not in the current view -1 will be     * returned.  This method may also return -1 if index-based location is not     * possible.
		 */
		public function getViewIndex () : int;
	}
	/**
	 * @private *  Represents a single modification to a collection that a  *  ModifiedCollectionView can either use or ignore in order to *  present "before" and "after" views of the change. *   *  A CollectionModification represents a single element only *  (add/remove/replace)
	 */
	internal class CollectionModification
	{
		public static const REMOVE : String = "remove";
		public static const ADD : String = "add";
		public static const REPLACE : String = "replace";
		/**
		 * The point at which elements in the collection were removed or added     * (More precisely, the index of the a current element in the collection      * to which this modification is attached.
		 */
		public var index : int;
		/**
		 * Removed element, if applicable
		 */
		public var item : Object;
		public var modificationType : String;
		private var _modCount : int;
		public var showOldReplace : Boolean;
		public var showNewReplace : Boolean;

		public function get isRemove () : Boolean;
		/**
		 * The number of removed elements being preserved in the modified collection,     * minus the number of added elements not in the original collection
		 */
		public function get modCount () : int;

		public function CollectionModification (index:int, item:Object, modificationType:String);
		/**
		 * For CollectionModifications representing replaced elements	 * in a collection, starts showing the replaced value.	 * 	 * For replaces, the original and replacement values may	 * be shown independently.
		 */
		public function startShowingReplacementValue () : void;
		/**
		 * For CollectionModifications representing replaced elements	 * in a collection, stops showing the replaced value.	 * 	 * For replaces, the original and replacement values may	 * be shown independently.
		 */
		public function stopShowingReplacedValue () : void;
	}
}
