/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.events {
	import flash.events.Event;
	import mx.controls.listClasses.IListItemRenderer;
	public class ListItemSelectEvent extends Event {
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
		 * The data provider index of the item to be selected.
		 */
		public var itemIndex:uint;
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
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param itemRenderer      <IListItemRenderer (default = null)> The item renderer object for the item.
		 * @param triggerEvent      <Event (default = null)> The event, such as a mouse or keyboard event, that
		 *                            triggered the selection action.
		 * @param ctrlKey           <Boolean (default = false)> Whether the Alt key was pressed at the time of the event.
		 * @param altKey            <Boolean (default = false)> Whether the Ctrl key was pressed at the time of the event.
		 * @param shiftKey          <Boolean (default = false)> Whether the Shift key was pressed at the time of the event.
		 */
		public function ListItemSelectEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, itemRenderer:IListItemRenderer = null, triggerEvent:Event = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false);
		/**
		 * The ListItemSelectEvent.DESELECT constant defines the value of the
		 *  type property of the event object for an event that is
		 *  dispatched when a previously selected item is deselected.
		 */
		public static const DESELECT:String = "deselect";
		/**
		 * The ListItemSelectEvent.MULTI_SELECT constant defines the value of the
		 *  type property of the event object for an event that is
		 *  dispatched when an  item is selected as part of an
		 *  action that selects multiple items.
		 */
		public static const MULTI_SELECT:String = "multiSelect";
		/**
		 * The ListItemSelectEvent.SELECT constant defines the value of the
		 *  type property of the event object for an event that is
		 *  dispatched when a single item is selected.
		 */
		public static const SELECT:String = "select";
		/**
		 * The ListItemSelectEvent.SELECT constant defines the value of the
		 *  type property of the event object for an event that is
		 *  dispatched when a single item is selected.
		 */
		public static const SELECT_INDEX:String = "selectIndex";
	}
}
