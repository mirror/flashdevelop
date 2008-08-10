/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.dataGridClasses {
	import mx.controls.listClasses.ListBase;
	import mx.core.IFontContextComponent;
	import mx.core.IFlexModuleFactory;
	import mx.controls.listClasses.ListBaseContentHolder;
	import mx.controls.listClasses.IListItemRenderer;
	public class DataGridBase extends ListBase implements IFontContextComponent {
		/**
		 * The DisplayObject that contains the graphics that indicates
		 *  which renderer is the caret for lockedColumns.
		 */
		protected var columnCaretIndicator:Sprite;
		/**
		 * The DisplayObject that contains the graphics that indicates
		 *  which renderer is highlighted for lockedColumns.
		 */
		protected var columnHighlightIndicator:Sprite;
		/**
		 * A map of item renderes to columns.
		 *  Like ListBase.rowMap, this property contains
		 *  a hash map of item renderers and the columns they belong to.
		 *  Item renderers are indexed by their DisplayObject name
		 */
		protected var columnMap:Object;
		/**
		 * The module factory that provides the font context for this component.
		 */
		public function get fontContext():IFlexModuleFactory;
		public function set fontContext(value:IFlexModuleFactory):void;
		/**
		 * A per-column table of unused item renderers.
		 *  Most list classes recycle item renderers that they have already created
		 *  as they scroll off screen.
		 *  The recycled renderers are stored here.
		 *  The table is a Dictionary where the entries are Arrays indexed
		 *  by the actual DataGridColumn (not the column's dataField or other
		 *  properties), and each array is a stack of currently unused renderers
		 */
		protected var freeItemRenderersTable:Dictionary;
		/**
		 * The header sub-component
		 */
		protected var header:DataGridHeaderBase;
		/**
		 * The height of the header cell of the column, in pixels.
		 *  If set explicitly, that height will be used for all of
		 *  the headers.  If not set explicitly,
		 *  the height will based on style settings and the header
		 *  renderer.
		 */
		public function get headerHeight():Number;
		public function set headerHeight(value:Number):void;
		/**
		 */
		protected var headerMask:Shape;
		/**
		 * The sub-component that contains locked rows for locked columns
		 */
		protected var lockedColumnAndRowContent:DataGridLockedRowContentHolder;
		/**
		 * The sub-component that contains locked columns
		 */
		protected var lockedColumnContent:ListBaseContentHolder;
		/**
		 * The index of the first column in the control that scrolls.
		 *  Columns with indexes that are lower than this value remain fixed
		 *  in view.  Not supported by all list classes.
		 */
		public function get lockedColumnCount():int;
		public function set lockedColumnCount(value:int):void;
		/**
		 * The header sub-component for locked columns
		 */
		protected var lockedColumnHeader:DataGridHeaderBase;
		/**
		 * The sub-component that contains locked rows
		 */
		protected var lockedRowContent:DataGridLockedRowContentHolder;
		/**
		 * The index of the first row in the control that scrolls.
		 *  Rows above this one remain fixed in view.
		 */
		public function get lockedRowCount():int;
		public function set lockedRowCount(value:int):void;
		/**
		 * A flag that indicates whether the control should show
		 *  column headers.
		 *  If true, the control shows column headers.
		 */
		public function get showHeaders():Boolean;
		public function set showHeaders(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function DataGridBase();
		/**
		 * Adjust size and positions of the renderers for the given rowNum, row position and height
		 *
		 * @param contentHolder     <ListBaseContentHolder> The set of rows (locked rows, regular rows)
		 * @param rowNum            <int> The row number
		 * @param yy                <Number> The y position of the row
		 * @param hh                <Number> The height of the row
		 */
		protected function adjustRow(contentHolder:ListBaseContentHolder, rowNum:int, yy:Number, hh:Number):void;
		/**
		 * Calculates the row height of columns in a row.
		 *  If skipVisible is true>
		 *  the DataGridBase already knows the height of
		 *  the renderers for the column that do fit in the display area
		 *  so this method only needs to calculate for the item renderers
		 *  that would exist if other columns in that row were in the
		 *  display area.  This is needed so that if the user scrolls
		 *  horizontally, the height of the row does not adjust as different
		 *  columns appear and disappear.
		 *
		 * @param data              <Object> The data provider item for the row.
		 * @param hh                <Number> The current height of the row.
		 * @param skipVisible       <Boolean (default = false)> If true, no need to measure item
		 *                            renderers in visible columns
		 * @return                  <Number> The row height, in pixels.
		 */
		protected function calculateRowHeight(data:Object, hh:Number, skipVisible:Boolean = false):Number;
		/**
		 * Remove renderers from a row that should be empty for the given rowNum
		 *
		 * @param contentHolder     <ListBaseContentHolder> The set of rows (locked rows, regular rows)
		 * @param rowNum            <int> The row number
		 */
		protected function clearRow(contentHolder:ListBaseContentHolder, rowNum:int):void;
		/**
		 * Returns the item renderer for a column cell or for a column header.
		 *  This method returns the default item renderer if no custom render is assigned
		 *  to the column.
		 *
		 * @param c                 <DataGridColumn> The DataGridColumn instance of the item renderer.
		 * @param forHeader         <Boolean> true to return the header item renderer,
		 *                            and false to return the item render for the column cells.
		 * @param data              <Object> If forHeader is false,
		 *                            the data Object for the item renderer.
		 *                            If forHeader is true,
		 *                            the DataGridColumn instance.
		 * @return                  <IListItemRenderer> The item renderer.
		 */
		public function createColumnItemRenderer(c:DataGridColumn, forHeader:Boolean, data:Object):IListItemRenderer;
		/**
		 * Draw an item if it is visible.
		 *
		 * @param uid               <String> The uid used to find the renderer.
		 * @param selected          <Boolean (default = false)> true if the renderer should be drawn in
		 *                            its selected state.
		 * @param highlighted       <Boolean (default = false)> true if the renderer should be drawn in
		 *                            its highlighted state.
		 * @param caret             <Boolean (default = false)> true if the renderer should be drawn as if
		 *                            it is the selection caret.
		 * @param transition        <Boolean (default = false)> true if the selection state should fade in
		 *                            via an effect.
		 */
		protected function drawVisibleItem(uid:String, selected:Boolean = false, highlighted:Boolean = false, caret:Boolean = false, transition:Boolean = false):void;
		/**
		 * Sets selected items based on the caretIndex and
		 *  anchorIndex properties.
		 *  Called by the keyboard selection handlers
		 *  and by the updateDisplayList method in case the
		 *  keyboard selection handler
		 *  got a page fault while scrolling to get more items.
		 */
		protected override function finishKeySelection():void;
		/**
		 * Returns a Point containing the columnIndex and rowIndex of an
		 *  item renderer.  Since item renderers are only created for items
		 *  within the set of viewable rows
		 *  you cannot use this method to get the indices for items
		 *  that are not visible.  Also note that item renderers
		 *  are recycled so the indices you get for an item may change
		 *  if that item renderer is reused to display a different item.
		 *  Usually, this method is called during mouse and keyboard handling
		 *  when the set of data displayed by the item renderers hasn't yet
		 *  changed.
		 *
		 * @param item              <IListItemRenderer> An item renderer
		 * @return                  <Point> A Point.  The x property is the columnIndex
		 *                            and the y property is the rowIndex.
		 */
		protected override function itemRendererToIndices(item:IListItemRenderer):Point;
		/**
		 * Size and temporarily position an itemRenderer for a column, returning its size as a Point
		 *  Its final position may be adjusted later due to alignment settings
		 *
		 * @param c                 <DataGridColumn> The DataGridColumn for the renderer
		 * @param item              <IListItemRenderer> The renderer
		 * @param xx                <Number> The x position
		 * @param yy                <Number> The y position
		 * @return                  <Point> Size of the renderer as a Point
		 */
		protected function layoutColumnItemRenderer(c:DataGridColumn, item:IListItemRenderer, xx:Number, yy:Number):Point;
		/**
		 * Creates a new DataGridListData instance and populates the fields based on
		 *  the input data provider item.
		 *
		 * @param data              <Object> The data provider item used to populate the ListData.
		 * @param uid               <String> The UID for the item.
		 * @param rowNum            <int> The index of the item in the data provider.
		 * @param columnNum         <int> The columnIndex associated with this item.
		 * @param column            <DataGridColumn> The column associated with this item.
		 * @return                  <BaseListData> A newly constructed ListData object.
		 */
		protected function makeListData(data:Object, uid:String, rowNum:int, columnNum:int, column:DataGridColumn):BaseListData;
		/**
		 * Make the renderers for the given rowNum, dataObject and uid
		 *
		 * @param contentHolder     <ListBaseContentHolder> The set of rows (locked rows, regular rows)
		 * @param rowNum            <int> The row number
		 * @param left              <Number> The offset from the left side for the first column
		 * @param right             <Number> The offset from the right side for the last column
		 * @param yy                <Number> The y position of the row
		 * @param data              <Object> The data for the row
		 * @param uid               <String> The uid for the data
		 * @return                  <Number> Height of the row
		 */
		protected function makeRow(contentHolder:ListBaseContentHolder, rowNum:int, left:Number, right:Number, yy:Number, data:Object, uid:String):Number;
		/**
		 * Moves the selection in a vertical direction in response
		 *  to the user selecting items using the up-arrow or down-arrow
		 *  Keys and modifiers such as the Shift and Ctrl keys.  This method
		 *  might change the horizontalScrollPosition,
		 *  verticalScrollPosition, and caretIndex
		 *  properties, and call the finishKeySelection()method
		 *  to update the selection
		 *
		 * @param code              <uint> The key that was pressed (e.g. Keyboard.DOWN)
		 * @param shiftKey          <Boolean> true if the shift key was held down when
		 *                            the keyboard key was pressed.
		 * @param ctrlKey           <Boolean> true if the ctrl key was held down when
		 *                            the keyboard key was pressed
		 */
		protected override function moveSelectionVertically(code:uint, shiftKey:Boolean, ctrlKey:Boolean):void;
		/**
		 * Make sure there's a slot in the row arrays for the given row number
		 *
		 * @param contentHolder     <ListBaseContentHolder> The set of rows (locked rows, regular rows)
		 * @param rowNum            <int> The row number
		 */
		protected function prepareRowArray(contentHolder:ListBaseContentHolder, rowNum:int):void;
		/**
		 * Remove extra row from the end of the contentHolder
		 *
		 * @param contentHolder     <ListBaseContentHolder> The set of rows (locked rows, regular rows)
		 */
		protected function removeExtraRow(contentHolder:ListBaseContentHolder):void;
		/**
		 * Set the rowInfo for the given rowNum, row position and height
		 *
		 * @param contentHolder     <ListBaseContentHolder> The set of rows (locked rows, regular rows)
		 * @param rowNum            <int> The row number
		 * @param yy                <Number> The y position of the row
		 * @param hh                <Number> The height of the row
		 * @param uid               <String> The UID for the data
		 */
		protected function setRowInfo(contentHolder:ListBaseContentHolder, rowNum:int, yy:Number, hh:Number, uid:String):void;
		/**
		 * Setup an item renderer for a column and put it in the listItems array
		 *  at the requested position
		 *
		 * @param c                 <DataGridColumn> The DataGridColumn for the renderer
		 * @param contentHolder     <ListBaseContentHolder> The set of rows (locked rows, regular rows)
		 * @param rowNum            <int> The row number
		 * @param colNum            <int> The column number
		 * @param data              <Object> The data for the row
		 * @param uid               <String> The uid for the data
		 * @return                  <IListItemRenderer> The renderer for this column and row
		 */
		protected function setupColumnItemRenderer(c:DataGridColumn, contentHolder:ListBaseContentHolder, rowNum:int, colNum:int, data:Object, uid:String):IListItemRenderer;
		/**
		 * redraw the renderer synchronously
		 *
		 * @param r                 <IListItemRenderer> the renderer;
		 */
		protected function updateRendererDisplayList(r:IListItemRenderer):void;
	}
}
