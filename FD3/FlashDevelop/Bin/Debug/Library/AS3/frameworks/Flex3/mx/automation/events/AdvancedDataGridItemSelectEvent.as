/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.events {
	import flash.events.Event;
	import mx.controls.listClasses.IListItemRenderer;
	public class AdvancedDataGridItemSelectEvent extends Event {
		/**
		 * Indicates whether the Alt key was pressed at the time of the event, true,
		 *  or not, false.
		 */
		public var altKey:Boolean;
		/**
		 * The data provider index of the item to be selected.
		 */
		public var columnIndex:int;
		/**
		 * Indicates whether the Ctrl key was pressed at the time of the event, true,
		 *  or not, false.
		 */
		public var ctrlKey:Boolean;
		/**
		 * The data field of the current column being selected
		 */
		public var dataField:String;
		/**
		 * The data field of the current column being selected
		 *  If HEADER_RELEASE event, which part of the header was clicked.
		 */
		public var headerPart:String;
		/**
		 * The automationValue string of the item to be selected.
		 *  This is used when the item to be selected is not visible in the control.
		 */
		public var itemAutomationValue:String;
		/**
		 * Item renderer object for the item being selected or deselected.
		 *  You can access the cell data using this property.
		 */
		public var itemRenderer:IListItemRenderer;
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
		 * @param columnIndex       <int (default = -1)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param dataField         <String (default = "")> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param headerPart        <String (default = "")> The item renderer object for the item.
		 * @param bubbles           <Boolean (default = false)> The event, such as a mouse or keyboard event, that
		 *                            triggered the selection action.
		 * @param cancelable        <Boolean (default = false)> Whether the Alt key was pressed at the time of the event.
		 * @param itemRenderer      <IListItemRenderer (default = null)> Whether the Ctrl key was pressed at the time of the event.
		 * @param triggerEvent      <Event (default = null)> Whether the Shift key was pressed at the time of the event.
		 * @param ctrlKey           <Boolean (default = false)> 
		 * @param altKey            <Boolean (default = false)> 
		 * @param shiftKey          <Boolean (default = false)> 
		 */
		public function AdvancedDataGridItemSelectEvent(type:String, columnIndex:int = -1, dataField:String = "", headerPart:String = "", bubbles:Boolean = false, cancelable:Boolean = false, itemRenderer:IListItemRenderer = null, triggerEvent:Event = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false);
		/**
		 * The AdvancedDataGridEvent.HEADER_RELEASE constant defines the value of the
		 *  type property of the event object for a
		 *  headerRelease event, which indicates that the
		 *  user pressed and released the mouse on a column header.
		 */
		public static const HEADER_RELEASE:String = "headerRelease";
	}
}
