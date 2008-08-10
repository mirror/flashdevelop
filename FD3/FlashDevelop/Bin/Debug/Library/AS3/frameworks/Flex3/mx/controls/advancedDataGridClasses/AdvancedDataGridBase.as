/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.advancedDataGridClasses {
	import mx.controls.listClasses.AdvancedListBase;
	import mx.core.IFactory;
	import mx.controls.listClasses.IListItemRenderer;
	public class AdvancedDataGridBase extends AdvancedListBase {
		/**
		 * A map of item renderers to columns.
		 *  Like AdvancedListBase.rowMap, this property contains
		 *  a hash map of item renderers and the columns they belong to.
		 *  Item renderers are indexed by their DisplayObject name.
		 */
		protected var columnMap:Object;
		/**
		 * Contains the index of the column for which a renderer is currently being created.
		 */
		protected var currentColNum:int;
		/**
		 * Contains the top position of the renderer that is currently being created.
		 */
		protected var currentItemTop:Number;
		/**
		 * The height, in pixels, of the current row.
		 */
		protected var currentRowHeight:Number;
		/**
		 * Contains the index of the row for which a renderer is currently being created.
		 */
		protected var currentRowNum:int;
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
		 * An Array of AdvancedDataGridHeaderInfo instances for all columns
		 *  in the control.
		 */
		protected var headerInfos:Array;
		/**
		 * The header renderer used to display the header rows of the column.
		 */
		public function get headerRenderer():IFactory;
		public function set headerRenderer(value:IFactory):void;
		/**
		 * An Array of ListRowInfo instances that cache header height and
		 *  other information for the headers in the headerItems Array.
		 */
		protected var headerRowInfo:Array;
		/**
		 * If true, specifies that text in the header is
		 *  wrapped if it does not fit on one line.
		 *  If the headerWordWrap property is set in AdvancedDataGridColumn,
		 *  this property will not have any effect.
		 */
		public function get headerWordWrap():Boolean;
		public function set headerWordWrap(value:Boolean):void;
		/**
		 * Maps item renderers to the Factory instacne from which they have been created.
		 */
		protected var itemRendererToFactoryMap:Dictionary;
		/**
		 * The selection mode of the control. Possible values are:
		 *  MULTIPLE_CELLS, MULTIPLE_ROWS, NONE,
		 *  SINGLE_CELL, and SINGLE_ROW.
		 *  Changing the value of this property
		 *  sets the selectedCells property to null.
		 */
		public function get selectionMode():String;
		public function set selectionMode(value:String):void;
		/**
		 * A flag that indicates whether the control should show
		 *  column headers.
		 *  If true, the control shows column headers.
		 */
		public function get showHeaders():Boolean;
		public function set showHeaders(value:Boolean):void;
		/**
		 * The sort item renderer to be used to display the sort icon in the
		 *  column header.
		 */
		public function get sortItemRenderer():IFactory;
		public function set sortItemRenderer(value:IFactory):void;
		/**
		 * A callback function called while rendering each cell.
		 */
		public function get styleFunction():Function;
		public function set styleFunction(value:Function):void;
		/**
		 * An Array of AdvancedDataGridHeaderRenderer instances that
		 *  define the header item renderers for the displayable columns.
		 */
		protected var visibleHeaderInfos:Array;
		/**
		 * Constructor.
		 */
		public function AdvancedDataGridBase();
		/**
		 * Calculates the row height of columns in a row.
		 *  If skipVisible is true
		 *  the AdvancedDataGridBase already knows the height of
		 *  the renderers for the column that do fit in the display area,
		 *  so this method only needs to calculate for the item renderers
		 *  that would exist if other columns in that row were in the
		 *  display area.  This is needed so that if the user scrolls
		 *  horizontally, the height of the row does not adjust as different
		 *  columns appear and disappear.
		 *
		 * @param data              <Object> The data provider item for the row.
		 * @param hh                <Number> The current height of the row.
		 * @param skipVisible       <Boolean (default = false)> If true, no need to measure item
		 *                            renderers in visible columns.
		 * @return                  <Number> The row height, in pixels.
		 */
		protected function calculateRowHeight(data:Object, hh:Number, skipVisible:Boolean = false):Number;
		/**
		 * Removes all selection and highlight and caret indicators.
		 */
		protected override function clearIndicators():void;
		/**
		 * Creates the column headers.
		 *  After creating the headers, this method updates the currentItemTop property
		 *  with the height of the header area.
		 *  It also updates the headerHeight property
		 *  if headerHeight has not been specified explicitly.
		 *
		 * @param left              <Number> The x coordinate of the header renderer.
		 * @param top               <Number> The y coordinate of the header renderer.
		 */
		protected function createHeaders(left:Number, top:Number):void;
		/**
		 * Creates the locked rows, if necessary.
		 *
		 * @param left              <Number> The x coordinate of the upper-left corner of the header renderer.
		 * @param top               <Number> The y coordinate of the upper-left corner of the header renderer.
		 * @param right             <Number> The x coordinate of the lower-right corner of the header renderer.
		 * @param bottom            <Number> The y coordinate of the lower-right corner of the header renderer.
		 */
		protected function createLockedRows(left:Number, top:Number, right:Number, bottom:Number):void;
		/**
		 * Draws the item renderer corresponding to the specified UID.
		 *
		 * @param uid               <String> The UID of the selected cell.
		 * @param selected          <Boolean (default = false)> Set to true to draw the cell as selected.
		 * @param highlighted       <Boolean (default = false)> Set to true to draw the cell as highlighted.
		 * @param caret             <Boolean (default = false)> Set to true to draw the cell with a caret.
		 * @param transition        <Boolean (default = false)> to true to animate the change to the cell's appearance.
		 */
		protected function drawVisibleItem(uid:String, selected:Boolean = false, highlighted:Boolean = false, caret:Boolean = false, transition:Boolean = false):void;
		/**
		 * Returns the header item renderer.
		 *
		 * @param c                 <AdvancedDataGridColumn> The column of the control.
		 * @return                  <IListItemRenderer> The header item renderer.
		 */
		protected function getHeaderRenderer(c:AdvancedDataGridColumn):IListItemRenderer;
		/**
		 * Returns the row height.
		 *
		 * @param itemData          <Object (default = null)> The data provider object for the row.
		 * @return                  <Number> The height of the row, in pixels.
		 */
		protected function getRowHeight(itemData:Object = null):Number;
		/**
		 * Returns true if selectedMode is
		 *  SINGLE_CELL or MULTIPLE_CELLS.
		 *
		 * @return                  <Boolean> true if selectedMode is
		 *                            SINGLE_CELL or MULTIPLE_CELLS.
		 */
		protected function isCellSelectionMode():Boolean;
		/**
		 * Return true if selectedMode is
		 *  SINGLE_ROW or MULTIPLE_ROWS.
		 */
		protected function isRowSelectionMode():Boolean;
		/**
		 * Creates a new AdvancedDataGridListData instance and populates the fields based on
		 *  the input data provider item.
		 *
		 * @param data              <Object> The data provider item used to populate the ListData.
		 * @param uid               <String> The UID for the item.
		 * @param rowNum            <int> The index of the item in the data provider.
		 * @param columnNum         <int> The column index associated with this item.
		 * @param column            <AdvancedDataGridColumn> The column associated with this item.
		 * @return                  <BaseListData> A newly constructed AdvancedDataGridListData object.
		 */
		protected function makeListData(data:Object, uid:String, rowNum:int, columnNum:int, column:AdvancedDataGridColumn):BaseListData;
		/**
		 * Sets the cell defined by uid to use the item renderer
		 *  specified by item.
		 *
		 * @param uid               <String> The UID of the cell.
		 * @param item              <IListItemRenderer> The item renderer to use for the cell.
		 */
		protected function setVisibleDataItem(uid:String, item:IListItemRenderer):void;
		/**
		 * Constant definition for the selectionMode property
		 *  to allow the selection of multiple cells.
		 *  Click any cell in the row to select the cell.
		 *  While holding down the Control key, click any cell to select
		 *  the cell for discontiguous selection.
		 *  While holding down the Shift key, click any cell to select
		 *  multiple, contiguous cells.
		 */
		public static const MULTIPLE_CELLS:String = "multipleCells";
		/**
		 * Constant definition for the selectionMode property
		 *  to allow the selection of multiple rows.
		 *  Click any cell in the row to select the row.
		 *  While holding down the Control key, click any cell in another row to select
		 *  the row for discontiguous selection.
		 *  While holding down the Shift key, click any cell in another row to select
		 *  multiple, contiguous rows.
		 */
		public static const MULTIPLE_ROWS:String = "multipleRows";
		/**
		 * Constant definition for the selectionMode property.
		 *  No selection is allowed in the control,
		 *  and the selectedCells property is null.
		 */
		public static const NONE:String = "none";
		/**
		 * Constant definition for the selectionMode property
		 *  to allow the selection of a single cell.
		 *  Click any cell to select the cell.
		 */
		public static const SINGLE_CELL:String = "singleCell";
		/**
		 * Constant definition for the selectionMode property
		 *  to allow the selection of a single row.
		 *  Click any cell in the row to select the row.
		 */
		public static const SINGLE_ROW:String = "singleRow";
	}
}
