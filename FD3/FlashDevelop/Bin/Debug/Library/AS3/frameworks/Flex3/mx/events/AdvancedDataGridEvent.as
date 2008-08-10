/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	import mx.controls.listClasses.IListItemRenderer;
	public class AdvancedDataGridEvent extends Event {
		/**
		 * If true, animate an opening or closing operation; used for
		 *  ITEM_OPENING type events only.
		 */
		public var animate:Boolean;
		/**
		 * The AdvancedDataGridColumnGroup instance for the column that caused the event.
		 */
		public var column:AdvancedDataGridColumn;
		/**
		 * The zero-based index in the AdvancedDataGrid object's columns Array
		 *  of the column associated with the event.
		 */
		public var columnIndex:int;
		/**
		 * The name of the field or property in the data associated with the column.
		 */
		public var dataField:String;
		/**
		 * Whether to dispatch an ITEM_OPEN or
		 *  ITEM_CLOSE event after the open or close animation
		 *  is complete. Used for ITEM_OPENING events only.
		 */
		public var dispatchEvent:Boolean;
		/**
		 * If HEADER_RELEASE event, which part of the header was clicked.
		 */
		public var headerPart:String;
		/**
		 * Storage for the node property.
		 *  If you populate the AdvancedDataGrid control from XML data, access
		 *  the label and data properties for
		 *  the node as
		 *  event.node.attributes.label and
		 *  event.node.attributes.data.
		 */
		public var item:Object;
		/**
		 * The item renderer for the item that is being edited, or the header
		 *  render that is being clicked or stretched.
		 *  You can access the data provider by using this property.
		 */
		public var itemRenderer:IListItemRenderer;
		/**
		 * The column's x-position, in pixels; used for replaying column stretch events.
		 */
		public var localX:Number;
		/**
		 * If true, indicates that the new dataField property
		 *  should be used along with whatever sorting
		 *  is already in use, resulting in a multicolumn sort.
		 */
		public var multiColumnSort:Boolean;
		/**
		 * Indicates whether the item
		 *  is opening true, or closing false.
		 *  Used for an ITEM_OPENING type events only.
		 */
		public var opening:Boolean;
		/**
		 * The reason the itemEditEnd event was dispatched.
		 *  Valid only for events with type ITEM_EDIT_END.
		 *  The possible values are defined in the AdvancedDataGridEventReason class.
		 */
		public var reason:String;
		/**
		 * If true, remove the column from the multicolumn sort.
		 */
		public var removeColumnFromSort:Boolean;
		/**
		 * The zero-based index of the item in the data provider.
		 */
		public var rowIndex:int;
		/**
		 * The MouseEvent object or KeyboardEvent object for the event that triggered this
		 *  event, or null if this event was triggered programmatically.
		 */
		public var triggerEvent:Event;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param columnIndex       <int (default = -1)> The zero-based index of the column where the event occurred.
		 * @param dataField         <String (default = null)> The name of the field or property in the data associated with the column.
		 * @param rowIndex          <int (default = -1)> The zero-based index of the item in the data provider.
		 * @param reason            <String (default = null)> The reason for an itemEditEnd event.
		 * @param itemRenderer      <IListItemRenderer (default = null)> The item renderer that is being edited or the header renderer that
		 *                            was clicked.
		 * @param localX            <Number (default = NaN)> Column x position for replaying columnStretch events.
		 * @param multiColumnSort   <Boolean (default = false)> Specifies a multicolumn sort.
		 * @param removeColumnFromSort<Boolean (default = false)> Specifies to remove the column from the multicolumn sort.
		 * @param item              <Object (default = null)> Specifies the node property. .
		 * @param triggerEvent      <Event (default = null)> The MouseEvent or KeyboardEvent that triggered this
		 *                            event or null if this event was triggered programmatically.
		 * @param headerPart        <String (default = null)> 
		 */
		public function AdvancedDataGridEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, columnIndex:int = -1, dataField:String = null, rowIndex:int = -1, reason:String = null, itemRenderer:IListItemRenderer = null, localX:Number = NaN, multiColumnSort:Boolean = false, removeColumnFromSort:Boolean = false, item:Object = null, triggerEvent:Event = null, headerPart:String = null);
		/**
		 * The AdvancedDataGridEvent.COLUMN_STRETCH constant defines the value of the
		 *  type property of the event object for a
		 *  columnStretch event, which indicates that a
		 *  user expanded a column horizontally.
		 */
		public static const COLUMN_STRETCH:String = "columnStretch";
		/**
		 * The AdvancedDataGridEvent.HEADER_DRAG_OUTSIDE constant defines the value of the
		 *  type property of the event object for a
		 *  headerDragOutside event, which indicates that the
		 *  user pressed and released the mouse on a column header.
		 */
		public static const HEADER_DRAG_OUTSIDE:String = "headerDragOutside";
		/**
		 * The AdvancedDataGridEvent.HEADER_DROP_OUTSIDE constant defines the value of the
		 *  type property of the event object for a
		 *  headerDropOutside event.
		 */
		public static const HEADER_DROP_OUTSIDE:String = "headerDropOutside";
		/**
		 * The AdvancedDataGridEvent.HEADER_RELEASE constant defines the value of the
		 *  type property of the event object for a
		 *  headerRelease event, which indicates that the
		 *  user pressed and released the mouse on a column header.
		 */
		public static const HEADER_RELEASE:String = "headerRelease";
		/**
		 * The AdvancedDataGridEvent.ITEM_CLOSE event type constant indicates that a AdvancedDataGrid
		 *  branch closed or collapsed.
		 */
		public static const ITEM_CLOSE:String = "itemClose";
		/**
		 * The AdvancedDataGridEvent.ITEM_EDIT_BEGIN constant defines the value of the
		 *  type property of the event object for a
		 *  itemEditBegin event, which indicates that an
		 *  item is ready to be edited.
		 */
		public static const ITEM_EDIT_BEGIN:String = "itemEditBegin";
		/**
		 * The AdvancedDataGridEvent.ITEM__EDIT_BEGINNING constant defines the value of the
		 *  type property of the event object for a
		 *  itemEditBeginning event, which indicates that the user has
		 *  prepared to edit an item, for example, by releasing the mouse button
		 *  over the item.
		 */
		public static const ITEM_EDIT_BEGINNING:String = "itemEditBeginning";
		/**
		 * The AdvancedDataGridEvent.ITEM_EDIT_END constant defines the value of the
		 *  type property of the event object for a
		 *  itemEditEnd event, which indicates that an edit
		 *  session is ending.
		 */
		public static const ITEM_EDIT_END:String = "itemEditEnd";
		/**
		 * The AdvancedDataGridEvent.ITEM_FOCUS_IN constant defines the value of the
		 *  type property of the event object for a
		 *  itemFocusIn event, which indicates that an
		 *  item has received the focus.
		 */
		public static const ITEM_FOCUS_IN:String = "itemFocusIn";
		/**
		 * The AdvancedDataGridEvent.ITEM_FOCUS_OUT constant defines the value of the
		 *  type property of the event object for a
		 *  itemFocusOut event, which indicates that an
		 *  item has lost the focus.
		 */
		public static const ITEM_FOCUS_OUT:String = "itemFocusOut";
		/**
		 * The AdvancedDataGridEvent.ITEM_OPEN event type constant indicates that an AdvancedDataGrid
		 *  branch opened or expanded.
		 */
		public static const ITEM_OPEN:String = "itemOpen";
		/**
		 * The AdvancedDataGridEvent.ITEM_OPENING event type constant is dispatched immediately
		 *  before a AdvancedDataGrid opens or closes.
		 */
		public static const ITEM_OPENING:String = "itemOpening";
		/**
		 * The AdvancedDataGridEvent.SORT constant defines the value of the
		 *  type property of the event object for a
		 *  sort event.
		 *  The AdvancedDataGrid control performs sorting based on the value of the
		 *  dataField and multiColumnSort properties.
		 */
		public static const SORT:String = "sort";
	}
}
