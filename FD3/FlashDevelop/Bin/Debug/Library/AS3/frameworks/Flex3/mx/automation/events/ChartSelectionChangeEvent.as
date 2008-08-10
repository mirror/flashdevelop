/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.events {
	import flash.events.Event;
	public class ChartSelectionChangeEvent extends Event {
		/**
		 * Indicates whether the Alt key was pressed at the time of the event, true,
		 *  or not, false.
		 */
		public var altKey:Boolean;
		/**
		 * Indicates whether the Ctrl key was pressed at the time of the event, true,
		 *  or not, false.
		 */
		public var ctrlKey:Boolean;
		/**
		 * The automationValue string of the item to be selected.
		 *  This is used when the item to be selected is not visible in the control.
		 */
		public var itemAutomationValue:String;
		/**
		 */
		public var selectionInfo:Array;
		/**
		 * Indicates whether the Shift key was pressed at the time of the event, true,
		 *  or not, false.
		 */
		public var shiftKey:Boolean;
		/**
		 * Event that triggered the item selection event,
		 *  such as a keyboard or mouse event.
		 */
		public var triggerEvent:Event;
		/**
		 * Constructor.
		 *  Normally called by the Flex control and not used in application code.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param selectionInfo     <Array (default = null)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param cancelable        <Boolean (default = false)> The item renderer object for the item.
		 * @param triggerEvent      <Event (default = null)> The event, such as a mouse or keyboard event, that
		 *                            triggered the selection action.
		 * @param ctrlKey           <Boolean (default = false)> Whether the Alt key was pressed at the time of the event.
		 * @param altKey            <Boolean (default = false)> Whether the Ctrl key was pressed at the time of the event.
		 * @param shiftKey          <Boolean (default = false)> Whether the Shift key was pressed at the time of the event.
		 */
		public function ChartSelectionChangeEvent(type:String, selectionInfo:Array = null, bubbles:Boolean = false, cancelable:Boolean = false, triggerEvent:Event = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false);
		/**
		 * The data provider index of the item to be selected.
		 */
		public override function clone():Event;
		/**
		 * The AdvancedDataGridEvent.HEADER_RELEASE constant defines the value of the
		 *  type property of the event object for a
		 *  headerRelease event, which indicates that the
		 *  user pressed and released the mouse on a column header.
		 */
		public static const CHANGE:String = "change";
	}
}
