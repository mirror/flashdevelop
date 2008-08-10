/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.events {
	import flash.events.Event;
	public class AdvancedDataGridHeaderShiftEvent extends Event {
		/**
		 * The automationValue string of the item to be selected.
		 *  This is used when the item to be selected is not visible in the control.
		 */
		public var itemAutomationValue:String;
		/**
		 * The data provider index of the item to be selected.
		 */
		public var movingColumnIndex:int;
		/**
		 */
		public var newColumnIndex:int;
		/**
		 */
		public var oldColumnIndex:int;
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
		 * @param movingColumnIndex <int (default = -1)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param oldColumnIndex    <int (default = -1)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param newColumnIndex    <int (default = -1)> The item renderer object for the item.
		 * @param bubbles           <Boolean (default = false)> The event, such as a mouse or keyboard event, that
		 *                            triggered the selection action.
		 * @param cancelable        <Boolean (default = false)> Whether the Alt key was pressed at the time of the event.
		 * @param triggerEvent      <Event (default = null)> Whether the Ctrl key was pressed at the time of the event.
		 */
		public function AdvancedDataGridHeaderShiftEvent(type:String, movingColumnIndex:int = -1, oldColumnIndex:int = -1, newColumnIndex:int = -1, bubbles:Boolean = false, cancelable:Boolean = false, triggerEvent:Event = null);
		/**
		 * The AdvancedDataGridEvent.HEADER_RELEASE constant defines the value of the
		 *  type property of the event object for a
		 *  headerRelease event, which indicates that the
		 *  user pressed and released the mouse on a column header.
		 */
		public static const HEADER_RELEASE:String = "headerRelease";
	}
}
