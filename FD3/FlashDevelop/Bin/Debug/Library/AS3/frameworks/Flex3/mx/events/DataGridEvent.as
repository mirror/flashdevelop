/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	import mx.controls.listClasses.IListItemRenderer;
	public class DataGridEvent extends Event {
		/**
		 * The zero-based index in the DataGrid object's columns array
		 *  of the column associated with the event.
		 */
		public var columnIndex:int;
		/**
		 * The name of the field or property in the data associated with the column.
		 */
		public var dataField:String;
		/**
		 * The item renderer for the item that is being edited or the header
		 *  render that is being clicked or stretched.
		 *  You can access the data provider item using this property.
		 */
		public var itemRenderer:IListItemRenderer;
		/**
		 * The column's x-position; used for replaying column stretch events.
		 */
		public var localX:Number;
		/**
		 * The reason the itemEditEnd event was dispatched.
		 *  Valid only for events with type ITEM_EDIT_END.
		 *  The possible values are defined in the DataGridEventReason class.
		 */
		public var reason:String;
		/**
		 * The zero-based index of the item in the data provider.
		 */
		public var rowIndex:int;
		/**
		 * Constructor.
		 *  Normally called by the DataGrid object; not used in application code.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param columnIndex       <int (default = -1)> The zero-based index of the column where the event occurred.
		 * @param dataField         <String (default = null)> The name of the field or property in the data associated with the column.
		 * @param rowIndex          <int (default = -1)> The zero-based index of the item in the in the data provider.
		 * @param reason            <String (default = null)> The reason for an itemEditEnd event.
		 * @param itemRenderer      <IListItemRenderer (default = null)> The item renderer that is being edited or the header renderer that
		 *                            was clicked..
		 * @param localX            <Number (default = NaN)> Column x-position for replaying columnStretch events.
		 */
		public function DataGridEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, columnIndex:int = -1, dataField:String = null, rowIndex:int = -1, reason:String = null, itemRenderer:IListItemRenderer = null, localX:Number = NaN);
		/**
		 * The DataGridEvent.COLUMN_STRETCH constant defines the value of the
		 *  type property of the event object for a
		 *  columnStretch event, which indicates that a
		 *  user expanded a column horizontally.
		 */
		public static const COLUMN_STRETCH:String = "columnStretch";
		/**
		 * The DataGridEvent.HEADER_RELEASE constant defines the value of the
		 *  type property of the event object for a
		 *  headerRelease event, which indicates that the
		 *  user pressed and released the mouse on a column header.
		 */
		public static const HEADER_RELEASE:String = "headerRelease";
		/**
		 * The DataGridEvent.ITEM_EDIT_BEGIN constant defines the value of the
		 *  type property of the event object for a
		 *  itemEditBegin event, which indicates that an
		 *  item is ready to be edited.
		 */
		public static const ITEM_EDIT_BEGIN:String = "itemEditBegin";
		/**
		 * The DataGridEvent.ITEM__EDIT_BEGINNING constant defines the value of the
		 *  type property of the event object for a
		 *  itemEditBeginning event, which indicates that the user has
		 *  prepared to edit an item, for example, by releasing the mouse button
		 *  over the item.
		 */
		public static const ITEM_EDIT_BEGINNING:String = "itemEditBeginning";
		/**
		 * The DataGridEvent.ITEM_EDIT_END constant defines the value of the
		 *  type property of the event object for a
		 *  itemEditEnd event, which indicates that an edit
		 *  session is ending.
		 */
		public static const ITEM_EDIT_END:String = "itemEditEnd";
		/**
		 * The DataGridEvent.ITEM_FOCUS_IN constant defines the value of the
		 *  type property of the event object for a
		 *  itemFocusIn event, which indicates that an
		 *  item has received the focus.
		 */
		public static const ITEM_FOCUS_IN:String = "itemFocusIn";
		/**
		 * The DataGridEvent.ITEM_FOCUS_OUT constant defines the value of the
		 *  type property of the event object for a
		 *  itemFocusOut event, which indicates that an
		 *  item has lost the focus.
		 */
		public static const ITEM_FOCUS_OUT:String = "itemFocusOut";
	}
}
