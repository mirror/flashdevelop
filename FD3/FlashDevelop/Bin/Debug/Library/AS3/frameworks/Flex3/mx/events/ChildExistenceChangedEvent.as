/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	import flash.display.DisplayObject;
	public class ChildExistenceChangedEvent extends Event {
		/**
		 * Reference to the child object that was created or destroyed.
		 */
		public var relatedObject:DisplayObject;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param relatedObject     <DisplayObject (default = null)> Reference to the child object that was created or destroyed.
		 */
		public function ChildExistenceChangedEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, relatedObject:DisplayObject = null);
		/**
		 * The ChildExistenceChangedEvent.CHILD_ADD constant
		 *  defines the value of the type property of the event
		 *  object for a childAdd event.
		 */
		public static const CHILD_ADD:String = "childAdd";
		/**
		 * The ChildExistenceChangedEvent.CHILD_REMOVE constant
		 *  defines the value of the type property of the event
		 *  object for a childRemove event.
		 */
		public static const CHILD_REMOVE:String = "childRemove";
		/**
		 * The ChildExistenceChangedEvent.OVERLAY_CREATED constant
		 *  defines the value of the type property of the event object
		 *  for a overlayCreated event.
		 */
		public static const OVERLAY_CREATED:String = "overlayCreated";
	}
}
