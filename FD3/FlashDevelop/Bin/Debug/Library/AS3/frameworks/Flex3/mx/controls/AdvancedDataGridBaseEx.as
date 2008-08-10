/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.controls.advancedDataGridClasses.AdvancedDataGridBase;
	import mx.core.IIMESupport;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.collections.ICollectionView;
	import mx.core.UIComponent;
	import flash.display.Sprite;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	public class AdvancedDataGridBaseEx extends AdvancedDataGridBase implements IIMESupport {
		/**
		 * An array of AdvancedDataGridColumn objects, one for each column that
		 *  can be displayed. If not explicitly set, the AdvancedDataGrid control
		 *  attempts to examine the first data provider item to determine the
		 *  set of properties and display those properties in alphabetic
		 *  order.
		 */
		public var columns:Array;
		/**
		 * Indicates whether you are allowed to reorder columns.
		 *  If true, you can reorder the columns
		 *  of the AdvancedDataGrid control by dragging the header cells.
		 */
		public function get draggableColumns():Boolean;
		public function set draggableColumns(value:Boolean):void;
		/**
		 * Indicates whether or not the user can edit items in the data provider.
		 */
		public function get editable():String;
		public function set editable(value:String):void;
		/**
		 * The column and row index of the item renderer for the
		 *  data provider item being edited, if any.
		 */
		public function get editedItemPosition():Object;
		public function set editedItemPosition(value:Object):void;
		/**
		 * A reference to the item renderer
		 *  in the AdvancedDataGrid control whose item is currently being edited.
		 */
		public function get editedItemRenderer():IListItemRenderer;
		/**
		 * Contains true if the headerInfos property
		 *  has been initialized with AdvancedDataGridHeaderInfo instances.
		 */
		protected var headerInfoInitialized:Boolean = false;
		/**
		 * The offset into the content from the left edge.
		 *  This can be a pixel offset in some subclasses or some other metric
		 *  like the number of columns in an AdvancedDataGrid control.
		 *  The AdvancedDataGrid scrolls by columns so the value of the
		 *  horizontalScrollPosition property is always
		 *  in the range of 0 to the index of the columns
		 *  that will make the last column visible.
		 *  This is different from the List control, which scrolls by pixels.
		 *  The AdvancedDataGrid control always aligns the left edge
		 *  of a column with the left edge of the AdvancedDataGrid control.
		 */
		public function get horizontalScrollPosition():Number;
		public function set horizontalScrollPosition(value:Number):void;
		/**
		 * Specifies the IME (input method editor) mode.
		 *  The IME mode enables users to enter text in Chinese, Japanese, and Korean.
		 *  Flex sets the specified IME mode when the control gets the focus,
		 *  and sets it back to the previous value when the control loses the focus.
		 */
		public function get imeMode():String;
		public function set imeMode(value:String):void;
		/**
		 * Contains true if a key press is in progress.
		 */
		protected var isKeyPressed:Boolean = false;
		/**
		 * A reference to the currently active instance of the item editor,
		 *  if it exists.
		 */
		public var itemEditorInstance:IListItemRenderer;
		/**
		 * The type look-ahead duration, in milliseconds, for multi-character look ahead.
		 *  Setting it to 0 will turn off multiple character type ahead lookup.
		 */
		public var lookAheadDuration:Number = 400;
		/**
		 * The minimum width of the columns, in pixels.  If not NaN,
		 *  the AdvancedDataGrid control applies this value as the minimum width for
		 *  all columns.  Otherwise, individual columns can have
		 *  their own minimum widths.
		 */
		public function get minColumnWidth():Number;
		public function set minColumnWidth(value:Number):void;
		/**
		 * An ordered list of AdvancedDataGridHeaderInfo instances that
		 *  correspond to the visible column headers.
		 */
		protected var orderedHeadersList:Array;
		/**
		 * A flag that indicates whether the user can change the size of the
		 *  columns.
		 *  If true, the user can stretch or shrink the columns of
		 *  the AdvancedDataGrid control by dragging the grid lines between the header cells.
		 *  If true, individual columns must also have their
		 *  resizeable properties set to false to
		 *  prevent the user from resizing a particular column.
		 */
		public var resizableColumns:Boolean = true;
		/**
		 * A flag that indicates whether the user can sort the data provider items
		 *  by clicking on a column header cell.
		 *  If true, the user can sort the data provider items by
		 *  clicking on a column header cell.
		 *  The AdvancedDataGridColumn.dataField property of the column
		 *  or the AdvancedDataGridColumn.sortCompareFunction property
		 *  of the column is used as the sort field.
		 *  If a column is clicked more than once,
		 *  the sort alternates between ascending and descending order.
		 *  If true, individual columns can be made to not respond
		 *  to a click on a header by setting the column's sortable
		 *  property to false.
		 */
		public var sortableColumns:Boolean = true;
		/**
		 * By default, the sortExpertMode property is set to false,
		 *  which means you click in the header area of a column to sort the rows of
		 *  the AdvancedDataGrid control by that column.
		 *  You then click in the multiple-column sort area of the header to sort by additional columns.
		 *  If you set the sortExpertMode property to true,
		 *  you use the Control key to select every column after the first column to perform sort.
		 */
		public var sortExpertMode:Boolean;
		/**
		 * Constructor.
		 */
		public function AdvancedDataGridBaseEx();
		/**
		 * Converts an absolute column index to the corresponding index in the
		 *  displayed columns. Because users can reorder columns, the
		 *  absolute column index may be different from the index of the
		 *  displayed column.
		 *
		 * @param columnIndex       <int> Absolute index of the column.
		 * @return                  <int> The index of the column as it is currently displayed,
		 *                            or -1 if columnIndex is not found.
		 */
		protected function absoluteToDisplayColumnIndex(columnIndex:int):int;
		/**
		 * Converts an absolute column index to the corresponding index in the
		 *  visible columns. Because users can reorder columns, the
		 *  absolute column index may be different from the index of the
		 *  visible column.
		 *
		 * @param columnIndex       <int> Absolute index of the column.
		 * @return                  <int> The index of the column as it is currently visible,
		 *                            or -1 if columnIndex is not currently visible.
		 */
		protected function absoluteToVisibleColumnIndex(columnIndex:int):int;
		/**
		 * Convert an absolute row index and column index into the corresponding
		 *  row index and column index of the item as it is currently displayed by the control.
		 *
		 * @param rowIndex          <int> An absolute row index.
		 * @param columnIndex       <int> An absolute column index.
		 * @return                  <Object> An Object containing two fields, rowIndex and columnIndex,
		 *                            that contain the row index and column index of the item as it is currently displayed by the control.
		 */
		protected function absoluteToVisibleIndices(rowIndex:int, columnIndex:int):Object;
		/**
		 * Adds a data field to the list of sort fields.
		 *  Indicate the data field by specifying its column location.
		 *
		 * @param columnName        <String> The name of the column that corresponds to the data field.
		 * @param columnNumber      <int> The column index in the AdvancedDataGrid control.
		 * @param collection        <ICollectionView> The data collection that contains the data field.
		 */
		protected function addSortField(columnName:String, columnNumber:int, collection:ICollectionView):void;
		/**
		 * Removes column header separators that you normally use
		 *  to resize columns.
		 */
		protected function clearSeparators():void;
		/**
		 * Returns the index of a column as it is currently displayed.
		 *  This method is useful when all columns of the control are not currently visible.
		 *
		 * @param colNum            <int> Absolute index of the column.
		 * @return                  <int> The index of the column as it is currently displayed,
		 *                            or -1 if colNum is not found.
		 */
		protected function colNumToIndex(colNum:int):int;
		/**
		 * Creates the header separators between column headers,
		 *  and populates the separators Array with the separators created.
		 *
		 * @param n                 <int> The number of separators to create.
		 * @param seperators        <Array> Array to be populated with the header objects.
		 * @param headerLines       <UIComponent> The parent component of the header separators to which the separators are added.
		 *                            That is, Flex calls the headerLines.addChild() method internally to add the separators to the display.
		 */
		protected function createHeaderSeparators(n:int, seperators:Array, headerLines:UIComponent):void;
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
		 *  You typically call this method only from within the event listener
		 *  for the itemEditEnd event, after
		 *  you have already called the preventDefault() method to
		 *  prevent the default event listener from executing.
		 */
		public function destroyItemEditor():void;
		/**
		 * Converts the current display column index of a column to
		 *  its corresponding absolute index.
		 *  Because users can reorder columns, the
		 *  absolute column index may be different from the index of the
		 *  displayed column.
		 *
		 * @param columnIndex       <int> Index of the column as it is currently displayed by the control.
		 * @return                  <int> The absolute index of the column.
		 */
		protected function displayToAbsoluteColumnIndex(columnIndex:int):int;
		/**
		 * Draws a column background for a column with the suggested color.
		 *  This implementation creates a Shape as a
		 *  child of the input Sprite and fills it with the appropriate color.
		 *
		 * @param s                 <Sprite> A Sprite that will contain a display object
		 *                            that contains the graphics for that column.
		 * @param columnIndex       <int> The column's index in the set of displayed columns.
		 *                            The left-most visible column has a column index of 0.
		 *                            This is used to keep track of the objects used for drawing
		 *                            backgrounds, so a particular column can re-use the same display object
		 *                            even though the index of the AdvancedDataGridColumn for that column has changed.
		 * @param color             <uint> The suggested color for the indicator.
		 * @param column            <AdvancedDataGridColumn> The column of the AdvancedDataGrid control that you are drawing the background for.
		 */
		protected function drawColumnBackground(s:Sprite, columnIndex:int, color:uint, column:AdvancedDataGridColumn):void;
		/**
		 * Draws the background of the headers into the given
		 *  UIComponent.  The graphics drawn can be scaled horizontally
		 *  if the component's width changes, or this method will be
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
		 *                            header does not count; the top-most visible row has a row index of 0.
		 *                            This is used to keep track of the objects used for drawing
		 *                            backgrounds so a particular row can re-use the same display object
		 *                            even though the index of the item that row is rendering has changed.
		 * @param color             <uint> The suggested color for the indicator.
		 * @param y                 <Number> The suggested y position for the background.
		 */
		protected function drawHorizontalLine(s:Sprite, rowIndex:int, color:uint, y:Number):void;
		/**
		 * Draws lines between columns, and column backgrounds.
		 *  This implementation calls the drawHorizontalLine(),
		 *  drawVerticalLine(),
		 *  and drawColumnBackground() methods as needed.
		 *  It creates a
		 *  Sprite that contains all of these graphics and adds it as a
		 *  child of the listContent at the front of the z-order.
		 */
		protected function drawLinesAndColumnBackgrounds():void;
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
		 * @param y                 <Number> The suggested y position for the background.
		 * @param height            <Number> The suggested height for the indicator.
		 * @param color             <uint> The suggested color for the indicator.
		 * @param dataIndex         <int> The index of the item for that row in the
		 *                            data provider.  This can be used to color the tenth item differently,
		 *                            for example.
		 */
		protected function drawRowBackground(s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int):void;
		/**
		 * Creates and displays the column header separators that the user
		 *  normally uses to resize columns.  This implementation uses
		 *  the same Sprite as the lines and column backgrounds, adds
		 *  instances of the headerSeparatorSkin, and attaches mouse
		 *  listeners to them in order to know when the user wants
		 *  to resize a column.
		 */
		protected function drawSeparators():void;
		/**
		 * Draws lines between columns.  This implementation draws a line
		 *  directly into the given Sprite.  The Sprite has been cleared
		 *  before lines are drawn into it.
		 *
		 * @param s                 <Sprite> A Sprite that will contain a display object
		 *                            that contains the graphics for that row.
		 * @param colIndex          <int> The column's index in the set of displayed columns.
		 *                            The left most visible column has a column index of 0.
		 * @param color             <uint> The suggested color for the indicator.
		 * @param x                 <Number> The suggested x position for the background.
		 */
		protected function drawVerticalLine(s:Sprite, colIndex:int, color:uint, x:Number):void;
		/**
		 * Returns the column index corresponding to the field name of a sortable field.
		 *
		 * @param name              <String> The name of a sortable field of the data provider, as defined by
		 *                            an instance of the SortField class.
		 * @return                  <int> The column index of the sortable field.
		 */
		protected function findSortField(name:String):int;
		/**
		 * Returns a SortInfo instance containing sorting information for the column.
		 *
		 * @param column            <AdvancedDataGridColumn> The column index.
		 * @return                  <SortInfo> A SortInfo instance.
		 */
		public function getFieldSortInfo(column:AdvancedDataGridColumn):SortInfo;
		/**
		 * Returns the header separators between column headers,
		 *  and populates the separators Array with the separators returned.
		 *
		 * @param i                 <int> The number of separators to return.
		 * @param seperators        <Array> Array to be populated with the header objects.
		 * @param headerLines       <UIComponent> The parent component of the header separators.
		 *                            Flex calls the headerLines.getChild() method internally to return the separators.
		 * @return                  <UIComponent> The header separators between column headers.
		 */
		protected function getSeparator(i:int, seperators:Array, headerLines:UIComponent):UIComponent;
		/**
		 * Returns the column number of a currently displayed column
		 *  as it is currently displayed.
		 *  This method is useful when all columns of the control are not currently visible.
		 *
		 * @param columnIndex       <int> The index of the column as it is currently displayed.
		 * @return                  <int> The column number of the displayed column in the control,
		 *                            or -1 if columnIndex is not found.
		 */
		protected function indexToColNum(columnIndex:int):int;
		/**
		 * Returns true if the specified row in a column is visible.
		 *
		 * @param columnIndex       <int> The column index.
		 * @param rowIndex          <int (default = -1)> A row index in the column. If omitted, the method uses the
		 *                            current value of the verticalScrollPosition property.
		 * @return                  <Boolean> true if the specified row in the column is visible.
		 */
		protected function isColumnFullyVisible(columnIndex:int, rowIndex:int = -1):Boolean;
		/**
		 * Checks if editing is allowed for a group or summary row.
		 *
		 * @param data              <Object> Data provider Object for the row.
		 * @return                  <Boolean> true if editing is allowed for the group or summary row.
		 */
		protected function isDataEditable(data:Object):Boolean;
		/**
		 * Moves focus to the specified column header.
		 *
		 * @param columnIndex       <int (default = -1)> The index of the column to receive focus.
		 *                            If you specify an invalid column index, the method returns without moving focus.
		 */
		public function moveFocusToHeader(columnIndex:int = -1):void;
		/**
		 * Removes a data field from the list of sort fields.
		 *  Indicate the data field by specifying its column location.
		 *
		 * @param columnName        <String> The name of the column that corresponds to the data field.
		 * @param columnNumber      <int> The column index in the AdvancedDataGrid control.
		 * @param collection        <ICollectionView> The data collection that contains the data field.
		 */
		protected function removeSortField(columnName:String, columnNumber:int, collection:ICollectionView):void;
		/**
		 * Changes the value of the horizontalScrollPosition property
		 *  to make the specified column visible.
		 *  This method is useful when all columns of the control are not currently visible.
		 *
		 * @param newColumnIndex    <int> The desired index of the column in the currently displayed columns.
		 * @param columnIndex       <int> The index of the column to display.
		 */
		protected function scrollToViewColumn(newColumnIndex:int, columnIndex:int):void;
		/**
		 * Selects the specified column header.
		 *
		 * @param columnNumber      <int> The index of the column to receive focus.
		 *                            If you specify an invalid column index, the method returns without moving focus.
		 */
		protected function selectColumnHeader(columnNumber:int):void;
		/**
		 * Deselects the specified column header.
		 *
		 * @param columnNumber      <int> The index of the column.
		 *                            If you specify an invalid column index, the method does nothing.
		 * @param completely        <Boolean (default = false)> If true, clear the caretIndex property
		 *                            and selects the first column header in the control.
		 */
		protected function unselectColumnHeader(columnNumber:int, completely:Boolean = false):void;
		/**
		 * Converts the current visible column index of a column to
		 *  its corresponding absolute index.
		 *  Because users can reorder columns, the
		 *  absolute column index may be different from the index of the
		 *  visible column.
		 *
		 * @param columnIndex       <int> Index of a currently visible column in the control.
		 * @return                  <int> The absolute index of the column.
		 */
		protected function visibleToAbsoluteColumnIndex(columnIndex:int):int;
	}
}
