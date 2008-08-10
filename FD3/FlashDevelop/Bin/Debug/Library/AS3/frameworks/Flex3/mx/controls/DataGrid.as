/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.controls.dataGridClasses.DataGridBase;
	import mx.core.IIMESupport;
	import mx.controls.listClasses.IListItemRenderer;
	import flash.display.Sprite;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.UIComponent;
	import mx.controls.listClasses.ListBaseContentHolder;
	public class DataGrid extends DataGridBase implements IIMESupport {
		/**
		 * An array of DataGridColumn objects, one for each column that
		 *  can be displayed.  If not explicitly set, the DataGrid control
		 *  attempts to examine the first data provider item to determine the
		 *  set of properties and display those properties in alphabetic
		 *  order.
		 */
		public function get columns():Array;
		public function set columns(value:Array):void;
		/**
		 * A flag that indicates whether the user is allowed to reorder columns.
		 *  If true, the user can reorder the columns
		 *  of the DataGrid control by dragging the header cells.
		 */
		public function get draggableColumns():Boolean;
		public function set draggableColumns(value:Boolean):void;
		/**
		 * A flag that indicates whether or not the user can edit
		 *  items in the data provider.
		 *  If true, the item renderers in the control are editable.
		 *  The user can click on an item renderer to open an editor.
		 */
		public var editable:Boolean = false;
		/**
		 * The column and row index of the item renderer for the
		 *  data provider item being edited, if any.
		 */
		public function get editedItemPosition():Object;
		public function set editedItemPosition(value:Object):void;
		/**
		 * A reference to the item renderer
		 *  in the DataGrid control whose item is currently being edited.
		 */
		public function get editedItemRenderer():IListItemRenderer;
		/**
		 * The offset into the content from the left edge.
		 *  This can be a pixel offset in some subclasses or some other metric
		 *  like the number of columns in a DataGrid control.
		 *  The DataGrid scrolls by columns so the value of the
		 *  horizontalScrollPosition property is always
		 *  in the range of 0 to the index of the columns
		 *  that will make the last column visible.  This is different from the
		 *  List control that scrolls by pixels.  The DataGrid control always aligns the left edge
		 *  of a column with the left edge of the DataGrid control.
		 */
		public function get horizontalScrollPosition():Number;
		public function set horizontalScrollPosition(value:Number):void;
		/**
		 * Specifies the IME (input method editor) mode.
		 *  The IME enables users to enter text in Chinese, Japanese, and Korean.
		 *  Flex sets the specified IME mode when the control gets the focus,
		 *  and sets it back to the previous value when the control loses the focus.
		 */
		public function get imeMode():String;
		public function set imeMode(value:String):void;
		/**
		 * A reference to the currently active instance of the item editor,
		 *  if it exists.
		 */
		public var itemEditorInstance:IListItemRenderer;
		/**
		 * The minimum width of the columns, in pixels.  If not NaN,
		 *  the DataGrid control applies this value as the minimum width for
		 *  all columns.  Otherwise, individual columns can have
		 *  their own minimum widths.
		 */
		public function get minColumnWidth():Number;
		public function set minColumnWidth(value:Number):void;
		/**
		 * A flag that indicates whether the user can change the size of the
		 *  columns.
		 *  If true, the user can stretch or shrink the columns of
		 *  the DataGrid control by dragging the grid lines between the header cells.
		 *  If true, individual columns must also have their
		 *  resizable properties set to false to
		 *  prevent the user from resizing a particular column.
		 */
		public var resizableColumns:Boolean = true;
		/**
		 * A flag that indicates whether the user can sort the data provider items
		 *  by clicking on a column header cell.
		 *  If true, the user can sort the data provider items by
		 *  clicking on a column header cell.
		 *  The DataGridColumn.dataField property of the column
		 *  or the DataGridColumn.sortCompareFunction property
		 *  of the column is used as the sort field.
		 *  If a column is clicked more than once
		 *  the sort alternates between ascending and descending order.
		 *  If true, individual columns can be made to not respond
		 *  to a click on a header by setting the column's sortable
		 *  property to false.
		 */
		public var sortableColumns:Boolean = true;
		/**
		 * Constructor.
		 */
		public function DataGrid();
		/**
		 * Called from updateDisplayList() to adjust the size and position of
		 *  listContent.
		 *
		 * @param unscaledWidth     <Number (default = -1)> 
		 * @param unscaledHeight    <Number (default = -1)> 
		 */
		protected override function adjustListContent(unscaledWidth:Number = -1, unscaledHeight:Number = -1):void;
		/**
		 * Removes column header separators that the user normally uses
		 *  to resize columns.
		 */
		protected function clearSeparators():void;
		/**
		 * Creates the item editor for the item renderer at the
		 *  editedItemPosition using the editor
		 *  specified by the itemEditor property.
		 *
		 * @param colIndex          <int> The column index in the data provider of the item to be edited.
		 * @param rowIndex          <int> The row index in the data provider of the item to be edited.
		 */
		public function createItemEditor(colIndex:int, rowIndex:int):void;
		/**
		 * This method closes an item editor currently open on an item renderer.
		 *  You typically only call this method from within the event listener
		 *  for the itemEditEnd event, after
		 *  you have already called the preventDefault() method to
		 *  prevent the default event listener from executing.
		 */
		public function destroyItemEditor():void;
		/**
		 * Draws a column background for a column with the suggested color.
		 *  This implementation creates a Shape as a
		 *  child of the input Sprite and fills it with the appropriate color.
		 *
		 * @param s                 <Sprite> A Sprite that will contain a display object
		 *                            that contains the graphics for that column.
		 * @param columnIndex       <int> The column's index in the set of displayed columns.
		 *                            The left most visible column has a column index of 0.
		 *                            This is used to keep track of the objects used for drawing
		 *                            backgrounds so a particular column can re-use the same display object
		 *                            even though the index of the DataGridColumn for that column has changed.
		 * @param color             <uint> The suggested color for the indicator
		 * @param column            <DataGridColumn> The column of the DataGrid control that you are drawing the background for.
		 */
		protected function drawColumnBackground(s:Sprite, columnIndex:int, color:uint, column:DataGridColumn):void;
		/**
		 * Draws the background of the headers into the given
		 *  UIComponent.  The graphics drawn may be scaled horizontally
		 *  if the component's width changes or this method will be
		 *  called again to redraw at a different width and/or height
		 *
		 * @param headerBG          <UIComponent> A UIComponent that will contain the header
		 *                            background graphics.
		 */
		protected function drawHeaderBackground(headerBG:UIComponent):void;
		/**
		 * Draws a line between rows.  This implementation draws a line
		 *  directly into the given Sprite.  The Sprite has been cleared
		 *  before lines are drawn into it.
		 *
		 * @param s                 <Sprite> A Sprite that will contain a display object
		 *                            that contains the graphics for that row.
		 * @param rowIndex          <int> The row's index in the set of displayed rows.  The
		 *                            header does not count, the top most visible row has a row index of 0.
		 *                            This is used to keep track of the objects used for drawing
		 *                            backgrounds so a particular row can re-use the same display object
		 *                            even though the index of the item that row is rendering has changed.
		 * @param color             <uint> The suggested color for the indicator
		 * @param y                 <Number> The suggested y position for the background
		 */
		protected function drawHorizontalLine(s:Sprite, rowIndex:int, color:uint, y:Number):void;
		/**
		 * Draw lines between columns, and column backgrounds.
		 *  This implementation calls the drawHorizontalLine(),
		 *  drawVerticalLine(),
		 *  and drawColumnBackground() methods as needed.
		 *  It creates a
		 *  Sprite that contains all of these graphics and adds it as a
		 *  child of the listContent at the front of the z-order.
		 */
		protected function drawLinesAndColumnBackgrounds():void;
		/**
		 * Draw lines between columns, and column backgrounds.
		 *  This implementation calls the drawHorizontalLine(),
		 *  drawVerticalLine(),
		 *  and drawColumnBackground() methods as needed.
		 *  It creates a
		 *  Sprite that contains all of these graphics and adds it as a
		 *  child of the listContent at the front of the z-order.
		 *
		 * @param contentHolder     <ListBaseContentHolder> 
		 * @param visibleColumns    <Array> 
		 * @param separators        <Object> 
		 */
		protected function drawLinesAndColumnGraphics(contentHolder:ListBaseContentHolder, visibleColumns:Array, separators:Object):void;
		/**
		 * Draws a row background
		 *  at the position and height specified using the
		 *  color specified.  This implementation creates a Shape as a
		 *  child of the input Sprite and fills it with the appropriate color.
		 *  This method also uses the backgroundAlpha style property
		 *  setting to determine the transparency of the background color.
		 *
		 * @param s                 <Sprite> A Sprite that will contain a display object
		 *                            that contains the graphics for that row.
		 * @param rowIndex          <int> The row's index in the set of displayed rows.  The
		 *                            header does not count, the top most visible row has a row index of 0.
		 *                            This is used to keep track of the objects used for drawing
		 *                            backgrounds so a particular row can re-use the same display object
		 *                            even though the index of the item that row is rendering has changed.
		 * @param y                 <Number> The suggested y position for the background
		 * @param height            <Number> The suggested height for the indicator
		 * @param color             <uint> The suggested color for the indicator
		 * @param dataIndex         <int> The index of the item for that row in the
		 *                            data provider.  This can be used to color the 10th item differently
		 *                            for example.
		 */
		protected function drawRowBackground(s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int):void;
		/**
		 * Creates and displays the column header separators that the user
		 *  normally uses to resize columns.  This implementation uses
		 *  the same Sprite as the lines and column backgrounds and adds
		 *  instances of the headerSeparatorSkin and attaches mouse
		 *  listeners to them in order to know when the user wants
		 *  to resize a column.
		 */
		protected function drawSeparators():void;
		/**
		 * Draw lines between columns.  This implementation draws a line
		 *  directly into the given Sprite.  The Sprite has been cleared
		 *  before lines are drawn into it.
		 *
		 * @param s                 <Sprite> A Sprite that will contain a display object
		 *                            that contains the graphics for that row.
		 * @param colIndex          <int> The column's index in the set of displayed columns.
		 *                            The left most visible column has a column index of 0.
		 * @param color             <uint> The suggested color for the indicator
		 * @param x                 <Number> The suggested x position for the background
		 */
		protected function drawVerticalLine(s:Sprite, colIndex:int, color:uint, x:Number):void;
		/**
		 * Determines if the item renderer for a data provider item
		 *  is editable.
		 *
		 * @param data              <Object> The data provider item
		 * @return                  <Boolean> true if the item is editable
		 */
		public function isItemEditable(data:Object):Boolean;
		/**
		 * Draws the sort arrow graphic on the column that is the current sort key.
		 *  This implementation creates or reuses an instance of the skin specified
		 *  by sortArrowSkin style property and places
		 *  it in the appropriate column header.  It
		 *  also shrinks the size of the column header if the text in the header
		 *  would be obscured by the sort arrow.
		 */
		protected function placeSortArrow():void;
		/**
		 * Returns the data provider index for the item at the first visible
		 *  row and column for the given scroll positions.
		 *
		 * @param horizontalScrollPosition<int> The horizontalScrollPosition
		 *                            property value corresponding to the scroll position.
		 * @param verticalScrollPosition<int> The verticalScrollPosition
		 *                            property value corresponding to the scroll position.
		 * @return                  <int> The data provider index.
		 */
		protected override function scrollPositionToIndex(horizontalScrollPosition:int, verticalScrollPosition:int):int;
		/**
		 * Adjusts the renderers in response to a change
		 *  in scroll position.
		 *
		 * @param pos               <int> The new scroll position.
		 * @param deltaPos          <int> The change in position.  It is always
		 *                            a positive number.
		 * @param scrollUp          <Boolean> true if scroll position
		 *                            is getting smaller.
		 */
		protected override function scrollVertically(pos:int, deltaPos:int, scrollUp:Boolean):void;
	}
}
