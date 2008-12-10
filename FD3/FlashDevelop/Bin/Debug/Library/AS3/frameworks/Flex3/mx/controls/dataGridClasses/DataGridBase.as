package mx.controls.dataGridClasses
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.setInterval;
	import mx.collections.CursorBookmark;
	import mx.collections.IViewCursor;
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListBase;
	import mx.controls.listClasses.ListBaseContentHolder;
	import mx.controls.listClasses.ListBaseSeekPending;
	import mx.controls.listClasses.ListRowInfo;
	import mx.core.EdgeMetrics;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.core.IUITextField;
	import mx.core.mx_internal;
	import mx.core.SpriteAsset;
	import mx.core.UIComponentGlobals;
	import mx.core.UITextField;
	import mx.events.DragEvent;
	import mx.events.ListEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.events.ScrollEventDirection;
	import mx.events.TweenEvent;
	import mx.skins.halo.ListDropIndicator;

	/**
	 *  The DataGridBase class is the base class for controls *  that display lists of items in multiple columns. *  It is not used directly in applications. *   *  @mxml *   *  <p>The DataGridBase class inherits all the properties of its parent classes *  and adds the following properties:</p> *   *  <pre> *  &lt;mx:<i>tagname</i> *    headerHeight="depends on styles and header renderer" *    showHeaders="true|false" *  /&gt; *  </pre>
	 */
	public class DataGridBase extends ListBase implements IFontContextComponent
	{
		/**
		 *  A map of item renderes to columns.     *  Like <code>ListBase.rowMap</code>, this property contains      *  a hash map of item renderers and the columns they belong to.     *  Item renderers are indexed by their DisplayObject name.     *     *  @see mx.controls.listClasses.ListBase#rowMap
		 */
		protected var columnMap : Object;
		/**
		 *  A per-column table of unused item renderers.      *  Most list classes recycle item renderers that they have already created      *  as they scroll off screen.      *  The recycled renderers are stored here.     *  The table is a Dictionary where the entries are Arrays indexed     *  by the actual DataGridColumn (not the column's dataField or other     *  properties), and each array is a stack of currently unused renderers.
		 */
		protected var freeItemRenderersTable : Dictionary;
		/**
		 *  The set of visible columns.
		 */
		local var visibleColumns : Array;
		/**
		 *  The set of visible locked columns.
		 */
		local var visibleLockedColumns : Array;
		/**
		 *  The header sub-component.
		 */
		protected var header : DataGridHeaderBase;
		/**
		 *  The class to use as the DGHeader.
		 */
		local var headerClass : Class;
		/**
		 * @private
		 */
		protected var headerMask : Shape;
		/**
		 *  The header sub-component for locked columns.
		 */
		protected var lockedColumnHeader : DataGridHeaderBase;
		private var lockedColumnHeaderMask : Shape;
		/**
		 *  The sub-component that contains locked rows.
		 */
		protected var lockedRowContent : DataGridLockedRowContentHolder;
		private var lockedRowMask : Shape;
		/**
		 *  The sub-component that contains locked rows for locked columns.
		 */
		protected var lockedColumnAndRowContent : DataGridLockedRowContentHolder;
		private var lockedColumnAndRowMask : Shape;
		/**
		 *  The sub-component that contains locked columns.
		 */
		protected var lockedColumnContent : ListBaseContentHolder;
		private var lockedColumnMask : Shape;
		/**
		 *  Flag specifying that the set of visible columns and/or their sizes needs to     *  be recomputed.
		 */
		local var columnsInvalid : Boolean;
		private var bShiftKey : Boolean;
		private var bCtrlKey : Boolean;
		private var lastKey : uint;
		private var bSelectItem : Boolean;
		private var inSelectItem : Boolean;
		/**
		 *  @private     *  Storage for the headerHeight property.
		 */
		local var _headerHeight : Number;
		/**
		 *  @private
		 */
		local var _explicitHeaderHeight : Boolean;
		private var lockedColumnCountChanged : Boolean;
		/**
		 *  @private     *  Storage for the lockedColumnCount property.
		 */
		local var _lockedColumnCount : int;
		private var lockedRowCountChanged : Boolean;
		/**
		 *  @private     *  Storage for the lockedRowCount property.
		 */
		local var _lockedRowCount : int;
		/**
		 *  @private     *  Storage for the showHeaders property.
		 */
		private var _showHeaders : Boolean;
		/**
		 *  The DisplayObject that contains the graphics that indicates     *  which renderer is highlighted for lockedColumns.
		 */
		protected var columnHighlightIndicator : Sprite;
		/**
		 *  The DisplayObject that contains the graphics that indicates     *  which renderer is the caret for lockedColumns.
		 */
		protected var columnCaretIndicator : Sprite;
		private var indicatorDictionary : Dictionary;

		/**
		 *  @private     *  automation
		 */
		function get dataGridHeader () : DataGridHeaderBase;
		/**
		 *  @private     *  automation
		 */
		function get dataGridLockedColumnHeader () : DataGridHeaderBase;
		/**
		 *  @private     *  automation
		 */
		function get dataGridLockedColumnAndRows () : ListBaseContentHolder;
		/**
		 *  @private     *  automation
		 */
		function get dataGridLockedRows () : ListBaseContentHolder;
		/**
		 *  @private     *  automation
		 */
		function get dataGridLockedColumns () : ListBaseContentHolder;
		/**
		 *  @private     *  must be overridden by subclasses
		 */
		public function get columns () : Array;
		/**
		 *  @private
		 */
		public function set columns (value:Array) : void;
		/**
		 *  @inheritDoc
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  The height of the header cell of the column, in pixels.     *  If set explicitly, that height will be used for all of     *  the headers. If not set explicitly,      *  the height will based on style settings and the header     *  renderer.
		 */
		public function get headerHeight () : Number;
		/**
		 *  @private
		 */
		public function set headerHeight (value:Number) : void;
		/**
		 *  The index of the first column in the control that scrolls.     *  Columns with indexes that are lower than this value remain fixed     *  in view. Not supported by all list classes.     *      *  @default 0
		 */
		public function get lockedColumnCount () : int;
		/**
		 *  @private
		 */
		public function set lockedColumnCount (value:int) : void;
		/**
		 *  The index of the first row in the control that scrolls.     *  Rows above this one remain fixed in view.     *      *  @default 0
		 */
		public function get lockedRowCount () : int;
		/**
		 *  @private
		 */
		public function set lockedRowCount (value:int) : void;
		/**
		 *  A flag that indicates whether the control should show     *  column headers.     *  If <code>true</code>, the control shows column headers.      *     *  @default true
		 */
		public function get showHeaders () : Boolean;
		/**
		 *  @private
		 */
		public function set showHeaders (value:Boolean) : void;
		/**
		 *  @private     *  headers are not renderered if showHeaders = false     *  or headerheight = 0, so this test is whether row0 is     *  a header or not.
		 */
		function get headerVisible () : Boolean;
		/**
		 *  @private
		 */
		function get gridColumnMap () : Object;
		/**
		 *  @private
		 */
		protected function set allowItemSizeChangeNotification (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function DataGridBase ();
		/**
		 *  @private     *  must be overridden by subclasses
		 */
		function columnRendererChanged (c:DataGridColumn) : void;
		/**
		 *  @private     *  must be overridden by subclasses
		 */
		function resizeColumn (col:int, w:Number) : void;
		/**
		 *  @private     *  Sizes and positions the column headers, columns, and items based on the     *  size of the DataGrid.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		protected function makeRowsAndColumns (left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0) : Point;
		/**
		 *  @private
		 */
		protected function makeRows (contentHolder:ListBaseContentHolder, left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0, alwaysCleanup:Boolean = false) : Point;
		/**
		 *  Ensures that there is a slot in the row arrays for the given row number.     *       *  @param contentHolder The set of rows (locked rows, regular rows).     *       *  @param rowNum The row number.
		 */
		protected function prepareRowArray (contentHolder:ListBaseContentHolder, rowNum:int) : void;
		/**
		 *  Creates the renderers for the given rowNum, dataObject and uid.     *       *  @param contentHolder The set of rows (locked rows, regular rows).     *  @param rowNum The row number.     *  @param left The offset from the left side for the first column.     *  @param right The offset from the right side for the last column.     *  @param yy The y position of the row.     *  @param data The data for the row.     *  @param uid The uid for the data.     *       *  @return Height of the row.
		 */
		protected function makeRow (contentHolder:ListBaseContentHolder, rowNum:int, left:Number, right:Number, yy:Number, data:Object, uid:String) : Number;
		/**
		 *  Removes renderers from a row that should be empty for the given rowNum.     *       *  @param contentHolder The set of rows (locked rows, regular rows).     *  @param rowNum The row number.
		 */
		protected function clearRow (contentHolder:ListBaseContentHolder, rowNum:int) : void;
		/**
		 *  Adjusts the size and positions of the renderers for the given rowNum, row position and height.     *       *  @param contentHolder The set of rows (locked rows, regular rows).     *  @param rowNum The row number.     *  @param yy The y position of the row.     *  @param hh The height of the row.
		 */
		protected function adjustRow (contentHolder:ListBaseContentHolder, rowNum:int, yy:Number, hh:Number) : void;
		/**
		 *  Sets the rowInfo for the given rowNum, row position and height.     *       *  @param contentHolder The set of rows (locked rows, regular rows).     *  @param rowNum The row number.     *  @param yy The y position of the row.     *  @param hh The height of the row.     *  @param uid The UID for the data.
		 */
		protected function setRowInfo (contentHolder:ListBaseContentHolder, rowNum:int, yy:Number, hh:Number, uid:String) : void;
		/**
		 *  Removes extra row from the end of the contentHolder.     *       *  @param contentHolder The set of rows (locked rows, regular rows).
		 */
		protected function removeExtraRow (contentHolder:ListBaseContentHolder) : void;
		/**
		 *  Sets up an item renderer for a column and put it in the listItems array     *  at the requested position.     *       *  @param c The DataGridColumn for the renderer.     *  @param contentHolder The set of rows (locked rows, regular rows).     *  @param rowNum The row number.     *  @param colNum The column number.     *  @param data The data for the row.     *  @param uid The uid for the data.     *       *  @return The renderer for this column and row.
		 */
		protected function setupColumnItemRenderer (c:DataGridColumn, contentHolder:ListBaseContentHolder, rowNum:int, colNum:int, data:Object, uid:String) : IListItemRenderer;
		/**
		 *  Sizes and temporarily positions an itemRenderer for a column, returning its size as a Point.     *  The final position might be adjusted later due to alignment settings.     *       *  @param c The DataGridColumn for the renderer.     *  @param item The renderer.     *  @param xx The x position.     *  @param yy The y position.     *       *  @return Size of the renderer as a Point.
		 */
		protected function layoutColumnItemRenderer (c:DataGridColumn, item:IListItemRenderer, xx:Number, yy:Number) : Point;
		/**
		 *  Draws an item if it is visible.     *       *  @param uid The uid used to find the renderer.     *  @param selected <code>true</code> if the renderer should be drawn in     *  its selected state.     *  @param highlighted <code>true</code> if the renderer should be drawn in     *  its highlighted state.     *  @param caret <code>true</code> if the renderer should be drawn as if     *  it is the selection caret.     *  @param transition <code>true</code> if the selection state should fade in     *  via an effect.
		 */
		protected function drawVisibleItem (uid:String, selected:Boolean = false, highlighted:Boolean = false, caret:Boolean = false, transition:Boolean = false) : void;
		/**
		 *  @private
		 */
		protected function drawItem (item:IListItemRenderer, selected:Boolean = false, highlighted:Boolean = false, caret:Boolean = false, transition:Boolean = false) : void;
		/**
		 *  Redraws the renderer synchronously.     *       *  @param r The renderer;
		 */
		protected function updateRendererDisplayList (r:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function addToFreeItemRenderers (item:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function purgeItemRenderers () : void;
		/**
		 *  @private
		 */
		public function indicesToIndex (rowIndex:int, colIndex:int) : int;
		/**
		 *  Creates a new DataGridListData instance and populates the fields based on     *  the input data provider item.      *       *  @param data The data provider item used to populate the ListData.     *  @param uid The UID for the item.     *  @param rowNum The index of the item in the data provider.     *  @param columnNum The columnIndex associated with this item.      *  @param column The column associated with this item.     *       *  @return A newly constructed ListData object.
		 */
		protected function makeListData (data:Object, uid:String, rowNum:int, columnNum:int, column:DataGridColumn) : BaseListData;
		/**
		 *  @private     *  This grid just returns the column size,     *  but could handle column spanning.
		 */
		function getWidthOfItem (item:IListItemRenderer, col:DataGridColumn) : Number;
		/**
		 *  Calculates the row height of columns in a row.     *  If <code>skipVisible</code> is <code>true></code>,      *  the DataGridBase already knows the height of     *  the renderers for the column that do fit in the display area     *  so this method only needs to calculate for the item renderers     *  that would exist if other columns in that row were in the     *  display area. This is needed so that if the user scrolls     *  horizontally, the height of the row does not adjust as different     *  columns appear and disappear.     *     *  @param data The data provider item for the row.     *     *  @param hh The current height of the row.     *     *  @param skipVisible If <code>true</code>, there is no need to measure item     *  renderers in visible columns.     *     *  @return The row height, in pixels.
		 */
		protected function calculateRowHeight (data:Object, hh:Number, skipVisible:Boolean = false) : Number;
		/**
		 *  Returns the item renderer for a column cell or for a column header.      *  This method returns the default item renderer if no custom render is assigned     *  to the column.     *     *  <p>This method is public so that is can be accessed by the DataGridHeader class,      *  and is primarily used in subclasses of the DataGrid control.</p>     *      *  @param c The DataGridColumn instance of the item renderer.     *      *  @param forHeader <code>true</code> to return the header item renderer,      *  and <code>false</code> to return the item render for the column cells.     *      *  @param data If <code>forHeader</code> is <code>false</code>,      *  the <code>data</code> Object for the item renderer.      *  If <code>forHeader</code> is <code>true</code>,      *  the DataGridColumn instance.       *      *  @return The item renderer.
		 */
		public function createColumnItemRenderer (c:DataGridColumn, forHeader:Boolean, data:Object) : IListItemRenderer;
		/**
		 *  Gets the headerWordWrap for a column, using the default wordWrap if none is specified.     *       *  @param c The column to get the headerWordWrap for.     *       *  @return <code>true</code> if the value of the column's <code>headerWordWrap</code> property is <code>true</code>, or     *  <code>false</code> if the value is <code>false</code>.
		 */
		function columnHeaderWordWrap (c:DataGridColumn) : Boolean;
		/**
		 *  Gets the wordWrap for a column, using the default wordWrap if none is specified.     *       *  @param c The column to get the wordWrap for.     *      *  @return <code>true</code> if the value of the column's <code>wordWrap</code> property is <code>true</code>, or     *  <code>false</code> if the value is <code>false</code>.
		 */
		function columnWordWrap (c:DataGridColumn) : Boolean;
		/**
		 *  @private
		 */
		protected function clearIndicators () : void;
		/**
		 *  @private
		 */
		protected function drawHighlightIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function clearHighlightIndicator (indicator:Sprite, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function drawCaretIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function clearCaretIndicator (indicator:Sprite, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function drawSelectionIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		private function selectionRemovedListener (event:Event) : void;
		/**
		 *  @private
		 */
		function mouseEventToItemRendererOrEditor (event:MouseEvent) : IListItemRenderer;
		/**
		 *  Determines the column under the mouse for dropping a column, if any.     *  This method only checks horizontal position, and assumes the y value is within headers.
		 */
		function getAllVisibleColumns () : Array;
		/**
		 *  @private
		 */
		protected function UIDToItemRenderer (uid:String) : IListItemRenderer;
		/**
		 *  @private     *  By default, there's a single large clip mask applied to the entire     *  listContent area of the List.  When the List contains a mixture of     *  device text and vector graphics (e.g.: there are custom item renderers),     *  that clip mask imposes a rendering overhead.     *     *  When graphical (non-text) item renderers are used, we optimize by only     *  applying a clip mask to the list items in the last row ... and then     *  only when it's needed.     *     *  This optimization breaks down when there's a horizontal scrollbar.     *  Rather than attempting to apply clip masks to every item along the left     *  and right edges, we give up and use the default clip mask that covers     *  the entire List.     *     *  For Lists and DataGrids containing custom item renderers, this     *  optimization yields a 25% improvement in scrolling speed.
		 */
		function addClipMask (layoutChanged:Boolean) : void;
		/**
		 *  @private
		 */
		public function itemRendererToIndex (itemRenderer:IListItemRenderer) : int;
		/**
		 *  @private
		 */
		function selectionTween_updateHandler (event:TweenEvent) : void;
		/**
		 *  @private
		 */
		protected function destroyRow (i:int, numCols:int) : void;
		/**
		 *  @private
		 */
		protected function moveRowVertically (i:int, numCols:int, moveBlockDistance:Number) : void;
		/**
		 *  @private
		 */
		protected function shiftRow (oldIndex:int, newIndex:int, numCols:int, shiftItems:Boolean) : void;
		/**
		 *  @private
		 */
		protected function moveIndicatorsVertically (uid:String, moveBlockDistance:Number) : void;
		/**
		 *  @private
		 */
		protected function truncateRowArrays (numRows:int) : void;
		/**
		 *  @private
		 */
		protected function addToRowArrays () : void;
		/**
		 *  @private
		 */
		protected function restoreRowArrays (modDeltaPos:int) : void;
		/**
		 *  @private
		 */
		protected function removeFromRowArrays (i:int) : void;
		/**
		 *  @private
		 */
		protected function clearVisibleData () : void;
		/**
		 *  @private
		 */
		protected function indexToRow (index:int) : int;
		/**
		 *  Moves the selection in a vertical direction in response     *  to the user selecting items with the up arrow or down arrow     *  keys and modifiers such as the Shift and Ctrl keys. This method     *  might change the <code>horizontalScrollPosition</code>,      *  <code>verticalScrollPosition</code>, and <code>caretIndex</code>     *  properties, and call the <code>finishKeySelection()</code>method     *  to update the selection.     *     *  @param code The key that was pressed (for example, <code>Keyboard.DOWN</code>).     *       *  @param shiftKey <code>true</code> if the Shift key was held down when     *  the keyboard key was pressed.     *       *  @param ctrlKey <code>true</code> if the Ctrl key was held down when     *  the keyboard key was pressed
		 */
		protected function moveSelectionVertically (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;
		/**
		 *  Sets selected items based on the <code>caretIndex</code> and      *  <code>anchorIndex</code> properties.       *  This method is called by the keyboard selection handlers     *  and by the <code>updateDisplayList()</code> method in case the      *  keyboard selection handler received a page fault while scrolling to get more items.
		 */
		protected function finishKeySelection () : void;
		/**
		 *  Returns a Point object that defines the <code>columnIndex</code> and <code>rowIndex</code> properties of an     *  item renderer. Because item renderers are only created for items     *  within the set of viewable rows, you cannot use this method to get the indices for items     *  that are not visible. Also, item renderers     *  are recycled so the indices that you get for an item might change     *  if that item renderer is reused to display a different item.     *  Usually, this method is called during mouse and keyboard handling     *  when the set of data displayed by the item renderers has not yet changed.     *     *  @param item An item renderer.     *     *  @return A Point object. The <code>x</code> property is the <code>columnIndex</code>     *  and the <code>y</code> property is the <code>rowIndex</code>.
		 */
		protected function itemRendererToIndices (item:IListItemRenderer) : Point;
		/**
		 *  @private     *  the inselectItem is a flag that converts relative seeks to absolute
		 */
		protected function selectItem (item:IListItemRenderer, shiftKey:Boolean, ctrlKey:Boolean, transition:Boolean = true) : Boolean;
		/**
		 *  @private
		 */
		public function showDropFeedback (event:DragEvent) : void;
		/**
		 *  @private     *  If there are locked rows but there weren't enough collection items, the iterator     *  is not in the right place and needs fixing.
		 */
		protected function adjustAfterAdd (items:Array, location:int) : Boolean;
		/**
		 *  @private     *  If there are locked rows but there weren't enough collection items, the iterator     *  is not in the right place and needs fixing.
		 */
		protected function adjustAfterRemove (items:Array, location:int, requiresValueCommit:Boolean) : Boolean;
	}
}
