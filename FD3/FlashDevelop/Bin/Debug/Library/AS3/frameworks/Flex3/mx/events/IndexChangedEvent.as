/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	import flash.display.DisplayObject;
	public class IndexChangedEvent extends Event {
		/**
		 * The zero-based index after the change. For change events
		 *  it is the index of the current child. For childIndexChange
		 *  events, it is the new index of the child. For headerShift
		 *  events, it is the new index of the header.
		 */
		public var newIndex:Number;
		/**
		 * The zero-based index before the change.
		 *  For change events it is the index of the previous child.
		 *  For childIndexChange events, it is the previous index
		 *  of the child.
		 *  For headerShift events, it is the previous index of
		 *  the header.
		 */
		public var oldIndex:Number;
		/**
		 * The child object whose index changed, or the object associated with
		 *  the new index. This property is not set for header changes.
		 */
		public var relatedObject:DisplayObject;
		/**
		 * The event that triggered this event.
		 *  Indicates whether this event was caused by a mouse or keyboard interaction.
		 *  The value is null when a container dispatches a
		 *  childIndexChanged event.
		 */
		public var triggerEvent:Event;
		/**
		 * Constructor.
		 *  Normally called by a Flex control and not used in application code.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param relatedObject     <DisplayObject (default = null)> The child object associated with the index change.
		 * @param oldIndex          <Number (default = -1)> The zero-based index before the change.
		 * @param newIndex          <Number (default = -1)> The zero-based index after the change.
		 * @param triggerEvent      <Event (default = null)> The event that triggered this event.
		 */
		public function IndexChangedEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, relatedObject:DisplayObject = null, oldIndex:Number = -1, newIndex:Number = -1, triggerEvent:Event = null);
		/**
		 * The IndexChangedEvent.CHANGE constant defines the value of the
		 *  type property of the event object for a change event,
		 *  which indicates that an index has changed, such as when and Accordion control
		 *  changes the displayed panel or a ViewStack changes views.
		 */
		public static const CHANGE:String = "change";
		/**
		 * The IndexChangedEvent.CHILD_INDEX_CHANGE constant defines the value of the
		 *  type property of the event object for a childIndexChange event,
		 *  which indicates that a component's index among a container's children
		 *  has changed.
		 */
		public static const CHILD_INDEX_CHANGE:String = "childIndexChange";
		/**
		 * The IndexChangedEvent.HEADER_SHIFT constant defines the value of the
		 *  type property of the event object for a headerShift event,
		 *  which indicates that a header has changed its index, as when a user drags
		 *  a DataGrid column to a new position.
		 */
		public static const HEADER_SHIFT:String = "headerShift";
	}
}
