/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class CollectionEvent extends Event {
		/**
		 * When the kind is CollectionEventKind.ADD
		 *  or CollectionEventKind.REMOVE the items property
		 *  is an Array of added/removed items.
		 *  When the kind is CollectionEventKind.REPLACE
		 *  or CollectionEventKind.UPDATE the items property
		 *  is an Array of PropertyChangeEvent objects with information about the items
		 *  affected by the event.
		 *  When a value changes, query the newValue and
		 *  oldValue fields of the PropertyChangeEvent objects
		 *  to find out what the old and new values were.
		 *  When the kind is CollectionEventKind.REFRESH
		 *  or CollectionEventKind.RESET, this array has zero length.
		 */
		public var items:Array;
		/**
		 * Indicates the kind of event that occurred.
		 *  The property value can be one of the values in the
		 *  CollectionEventKind class,
		 *  or null, which indicates that the kind is unknown.
		 */
		public var kind:String;
		/**
		 * When the kind value is CollectionEventKind.ADD,
		 *  CollectionEventKind.MOVE,
		 *  CollectionEventKind.REMOVE, or
		 *  CollectionEventKind.REPLACE, this property is the
		 *  zero-base index in the collection of the item(s) specified in the
		 *  items property.
		 */
		public var location:int;
		/**
		 * When the kind value is CollectionEventKind.MOVE,
		 *  this property is the zero-based index in the target collection of the
		 *  previous location of the item(s) specified by the items property.
		 */
		public var oldLocation:int;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that triggered the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param kind              <String (default = null)> Indicates the kind of event that occured.
		 *                            The parameter value can be one of the values in the CollectionEventKind
		 *                            class, or null, which indicates that the kind is unknown.
		 * @param location          <int (default = -1)> When the kind is
		 *                            CollectionEventKind.ADD,
		 *                            CollectionEventKind.MOVE,
		 *                            CollectionEventKind.REMOVE, or
		 *                            CollectionEventKind.REPLACE,
		 *                            this value indicates at what location the item(s) specified
		 *                            in the items property can be found
		 *                            within the target collection.
		 * @param oldLocation       <int (default = -1)> When the kind is
		 *                            CollectionEventKind.MOVE, this value indicates
		 *                            the old location within the target collection
		 *                            of the item(s) specified in the items property.
		 * @param items             <Array (default = null)> Array of objects with information about the items
		 *                            affected by the event, as described in the items property.
		 *                            When the kind is CollectionEventKind.REFRESH
		 *                            or CollectionEventKind.RESET, this Array has zero length.
		 */
		public function CollectionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, kind:String = null, location:int = -1, oldLocation:int = -1, items:Array = null);
		/**
		 * The CollectionEvent.COLLECTION_CHANGE constant defines the value of the
		 *  type property of the event object for an event that is
		 *  dispatched when a collection has changed.
		 */
		public static const COLLECTION_CHANGE:String = "collectionChange";
	}
}
