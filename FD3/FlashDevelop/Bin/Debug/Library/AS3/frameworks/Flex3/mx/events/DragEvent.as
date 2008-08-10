/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.MouseEvent;
	import mx.core.IUIComponent;
	import mx.core.DragSource;
	public class DragEvent extends MouseEvent {
		/**
		 * The requested action.
		 *  One of DragManager.COPY, DragManager.LINK,
		 *  DragManager.MOVE, or DragManager.NONE.
		 */
		public var action:String;
		/**
		 * If the dragInitiator property contains
		 *  an IAutomationObject object,
		 *  this property contains the child IAutomationObject object near the mouse cursor.
		 *  If the dragInitiator property does not contain
		 *  an IAutomationObject object,  this proprty is null.
		 */
		public var draggedItem:Object;
		/**
		 * The component that initiated the drag.
		 */
		public var dragInitiator:IUIComponent;
		/**
		 * The DragSource object containing the data being dragged.
		 */
		public var dragSource:DragSource;
		/**
		 * Constructor.
		 *  Normally called by the Flex control and not used in application code.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = true)> Specifies whether the behavior associated with the event can be prevented.
		 * @param dragInitiator     <IUIComponent (default = null)> IUIComponent that specifies the component initiating
		 *                            the drag.
		 * @param dragSource        <DragSource (default = null)> A DragSource object containing the data being dragged.
		 * @param action            <String (default = null)> The specified drop action, such as DragManager.MOVE.
		 * @param ctrlKey           <Boolean (default = false)> Indicates whether the Ctrl key was pressed.
		 * @param altKey            <Boolean (default = false)> Indicates whether the Alt key was pressed.
		 * @param shiftKey          <Boolean (default = false)> Indicates whether the Shift key was pressed.
		 */
		public function DragEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, dragInitiator:IUIComponent = null, dragSource:DragSource = null, action:String = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false);
		/**
		 * The DragEvent.DRAG_COMPLETE constant defines the value of the
		 *  type property of the event object for a dragComplete event.
		 */
		public static const DRAG_COMPLETE:String = "dragComplete";
		/**
		 * The DragEvent.DRAG_DROP constant defines the value of the
		 *  type property of the event object for a dragDrop event.
		 */
		public static const DRAG_DROP:String = "dragDrop";
		/**
		 * The DragEvent.DRAG_ENTER constant defines the value of the
		 *  type property of the event object for a dragEnter event.
		 */
		public static const DRAG_ENTER:String = "dragEnter";
		/**
		 * The DragEvent.DRAG_EXIT constant defines the value of the
		 *  type property of the event object for a dragExit event.
		 */
		public static const DRAG_EXIT:String = "dragExit";
		/**
		 * The DragEvent.DRAG_OVER constant defines the value of the
		 *  type property of the event object for a dragOver event.
		 */
		public static const DRAG_OVER:String = "dragOver";
		/**
		 * The DragEvent.DRAG_START constant defines the value of the
		 *  type property of the event object for a dragStart event.
		 */
		public static const DRAG_START:String = "dragStart";
	}
}
