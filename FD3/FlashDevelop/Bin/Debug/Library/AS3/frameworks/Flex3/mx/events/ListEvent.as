/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	import mx.controls.listClasses.IListItemRenderer;
	public class ListEvent extends Event {
		/**
		 * The zero-based index of the column that contains
		 *  the item renderer where the event occurred.
		 */
		public var columnIndex:int;
		/**
		 * The item renderer where the event occurred.
		 *  You can access the data provider item using this property.
		 */
		public var itemRenderer:IListItemRenderer;
		/**
		 * The reason the itemEditEnd event was dispatched.
		 *  Valid only for events with type ITEM_EDIT_END.
		 *  The possible values are defined in the ListEventReason class.
		 */
		public var reason:String;
		/**
		 * In the zero-based index of the row that contains
		 *  the item renderer where the event occured, or for editing events,
		 *  the index of the item in the data provider that is being edited.
		 */
		public var rowIndex:int;
		/**
		 * Constructor.
		 *  Normally called by the Flex control and not used in application code.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param columnIndex       <int (default = -1)> The zero-based index of the column that contains
		 *                            the renderer.
		 * @param rowIndex          <int (default = -1)> The zero-based index of the row that contains
		 *                            the renderer, or for editing events, the index of the item in
		 *                            the data provider that is being edited
		 * @param reason            <String (default = null)> The reason for an itemEditEnd event.
		 * @param itemRenderer      <IListItemRenderer (default = null)> The item renderer for the data provider item.
		 */
		public function ListEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, columnIndex:int = -1, rowIndex:int = -1, reason:String = null, itemRenderer:IListItemRenderer = null);
		/**
		 * The ListEvent.CHANGE constant defines the value of the
		 *  type property of the ListEvent object for a
		 *  change event, which indicates that selection
		 *  changed as a result of user interaction.
		 */
		public static const CHANGE:String = "change";
		/**
		 * The ListEvent.ITEM_CLICK constant defines the value of the
		 *  type property of the ListEvent object for an
		 *  itemClick event, which indicates that the
		 *  user clicked the mouse over a visual item in the control.
		 */
		public static const ITEM_CLICK:String = "itemClick";
		/**
		 * The ListEvent.ITEM_DOUBLE_CLICK constant defines the value of the
		 *  type property of the ListEvent object for an
		 *  itemDoubleClick event, which indicates that the
		 *  user double clicked the mouse over a visual item in the control.
		 */
		public static const ITEM_DOUBLE_CLICK:String = "itemDoubleClick";
		/**
		 * The ListEvent.ITEM_EDIT_BEGIN constant defines the value of the
		 *  type property of the event object for a
		 *  itemEditBegin event, which indicates that an
		 *  item is ready to be edited.
		 */
		public static const ITEM_EDIT_BEGIN:String = "itemEditBegin";
		/**
		 * The ListEvent.ITEM_EDIT_BEGINNING constant defines the value of the
		 *  type property of the ListEvent object for a
		 *  itemEditBeginning event, which indicates that the user has
		 *  prepared to edit an item, for example, by releasing the mouse button
		 *  over the item.
		 */
		public static const ITEM_EDIT_BEGINNING:String = "itemEditBeginning";
		/**
		 * The ListEvent.ITEM_EDIT_END constant defines the value of the
		 *  type property of the ListEvent object for a
		 *  itemEditEnd event, which indicates that an edit
		 *  session is ending.
		 */
		public static const ITEM_EDIT_END:String = "itemEditEnd";
		/**
		 * The ListEvent.ITEM_FOCUS_IN constant defines the value of the
		 *  type property of the ListEvent object for an
		 *  itemFocusIn event, which indicates that an item
		 *  has received the focus.
		 */
		public static const ITEM_FOCUS_IN:String = "itemFocusIn";
		/**
		 * The ListEvent.ITEM_FOCUS_OUT constant defines the value of the
		 *  type property of the ListEvent object for an
		 *  itemFocusOut event, which indicates that an item
		 *  has lost the focus.
		 */
		public static const ITEM_FOCUS_OUT:String = "itemFocusOut";
		/**
		 * The ListEvent.ITEM_ROLL_OUT constant defines the value of the
		 *  type property of the ListEvent object for an
		 *  itemRollOut event, which indicates that the user rolled
		 *  the mouse pointer out of a visual item in the control.
		 */
		public static const ITEM_ROLL_OUT:String = "itemRollOut";
		/**
		 * The ListEvent.ITEM_ROLL_OVER constant defines the value of the
		 *  type property of the ListEvent object for an
		 *  itemRollOver event, which indicates that the user rolled
		 *  the mouse pointer over a visual item in the control.
		 */
		public static const ITEM_ROLL_OVER:String = "itemRollOver";
	}
}
