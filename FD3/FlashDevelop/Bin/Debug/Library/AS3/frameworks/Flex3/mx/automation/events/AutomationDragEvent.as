/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.events {
	import flash.events.MouseEvent;
	public class AutomationDragEvent extends MouseEvent {
		/**
		 * The requested action.
		 *  One of DragManager.COPY, DragManager.LINK,
		 *  DragManager.MOVE, or DragManager.NONE.
		 */
		public var action:String;
		/**
		 * Contains the child IAutomationObject object that is being dragged.
		 */
		public var draggedItem:IAutomationObject;
		/**
		 * The IAutomationObject object that parents the dropped item.
		 */
		public var dropParent:IAutomationObject;
		/**
		 * Constructor.
		 *  Normally called by the Flex control and not used in application code.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = true)> Specifies whether the behavior associated with the event can be prevented.
		 * @param action            <String (default = null)> The specified drop action, such as DragManager.MOVE.
		 * @param ctrlKey           <Boolean (default = false)> Indicates whether the Control key was pressed.
		 * @param altKey            <Boolean (default = false)> Indicates whether the Alt key was pressed.
		 * @param shiftKey          <Boolean (default = false)> Indicates whether the Shift key was pressed.
		 */
		public function AutomationDragEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, action:String = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false);
		/**
		 * Defines the value of the
		 *  type property of the event object for a dragComplete event.
		 */
		public static const DRAG_COMPLETE:String = "dragComplete";
		/**
		 * Defines the value of the
		 *  type property of the event object for a dragDrop event.
		 */
		public static const DRAG_DROP:String = "dragDrop";
		/**
		 * Defines the value of the
		 *  type property of the event object for a dragStart event.
		 */
		public static const DRAG_START:String = "dragStart";
	}
}
