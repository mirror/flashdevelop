/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.events {
	public class AutomationDragEventWithPositionInfo extends AutomationDragEvent {
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
		 * @param localx            <int (default = -1)> 
		 * @param localy            <int (default = -1)> 
		 */
		public function AutomationDragEventWithPositionInfo(type:String, bubbles:Boolean = false, cancelable:Boolean = true, action:String = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, localx:int = -1, localy:int = -1);
		/**
		 * The requested action.
		 *  One of DragManager.COPY, DragManager.LINK,
		 *  DragManager.MOVE, or DragManager.NONE.
		 */
		public override function clone():Event;
		/**
		 * Contains the child IAutomationObject object being dragged.
		 */
		public override function clone():Event;
		/**
		 * The IAutomationObject object which will be parenting the dropped item.
		 */
		public override function clone():Event;
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
