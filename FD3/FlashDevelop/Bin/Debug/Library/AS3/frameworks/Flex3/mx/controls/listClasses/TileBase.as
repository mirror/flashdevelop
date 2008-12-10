package mx.controls.listClasses
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.setInterval;
	import mx.collections.CursorBookmark;
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.core.ClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.FlexShape;
	import mx.core.FlexSprite;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.events.ScrollEventDirection;
	import mx.skins.halo.ListDropIndicator;
	import mx.styles.StyleManager;
	import mx.collections.ItemWrapper;
	import mx.collections.ModifiedCollectionView;

	/**
	 *  The TileBase class is the base class for controls *  that display data items in a sequence of rows and columns. *  TileBase-derived classes ignore the <code>variableRowHeight</code> *  and <code>wordWrap</code> properties inherited from their parent class. *  All items in a TileList are the same width and height. * *  <p>This class is not used directly in applications.</p>
	 */
	public class TileBase extends ListBase
	{
		private var bShiftKey : Boolean;
		private var bCtrlKey : Boolean;
		private var lastKey : uint;
		private var bSelectItem : Boolean;
		private var lastColumnCount : int;
		private var lastRowCount : int;
		/**
		 *  Cache of measuring objects by factory.
		 */
		protected var measuringObjects : Dictionary;
		/**
		 *  @private     *  Storage for direction property.
		 */
		private var _direction : String;
		/**
		 *  @private     *  Storage for the maxColumns property.
		 */
		private var _maxColumns : int;
		/**
		 *  @private     *  Storage for the maxRows property.
		 */
		private var _maxRows : int;

		/**
		 *  The direction in which this control lays out its children.     *  Possible values are <code>TileBaseDirection.HORIZONTAL</code>     *  and <code>TileBaseDirection.VERTICAL</code>.     *  The default value is <code>TileBaseDirection.HORIZONTAL</code>.     *     *  <p>If the value is <code>TileBaseDirection.HORIZONTAL</code>, the tiles are     *  laid out along the first row until the number of visible columns or maxColumns     *  is reached and then a new row is started.  If more rows are created     *  than can be displayed at once, the control will display a vertical scrollbar.     *  The opposite is true if the value is <code>TileBaseDirection.VERTICAL</code>.</p>
		 */
		public function get direction () : String;
		/**
		 *  @private
		 */
		public function set direction (value:String) : void;
		/**
		 *  The maximum number of columns that the control can have.     *  If 0, then there are no limits to the number of     *  columns.  This value is ignored     *  if the direction is <code>TileBaseDirection.VERTICAL</code>     *  because the control will have as many columns as it needs to      *  to display all the data.     *     *  <p>The default value is 0 (no limit).</p>
		 */
		public function get maxColumns () : int;
		/**
		 *  @private
		 */
		public function set maxColumns (value:int) : void;
		/**
		 *  The maximum number of rows that the control can have.     *  If 0, then there is no limit to the number of     *  rows.  This value is ignored     *  if the direction is <code>TileBaseDirection.HORIZONTAL</code>     *  because the control will have as many rows as it needs to      *  to display all the data.     *     *  <p>The default value is 0 (no limit).</p>
		 */
		public function get maxRows () : int;
		/**
		 *  @private
		 */
		public function set maxRows (value:int) : void;
		/**
		 *  @private
		 */
		public function set itemRenderer (value:IFactory) : void;
		/**
		 *  @private
		 */
		protected function get dragImageOffsets () : Point;

		/**
		 *  Constructor.
		 */
		public function TileBase ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function makeRowsAndColumns (left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0) : Point;
		private function moveNextSafely (more:Boolean) : Boolean;
		/**
		 *  @private
		 */
		private function getPreparedItemRenderer (rowNum:int, colNum:int, wrappedData:Object, data:Object, uid:String) : IListItemRenderer;
		/**
		 *  @private
		 */
		private function placeAndDrawItemRenderer (item:IListItemRenderer, xx:Number, yy:Number, uid:String) : void;
		/**
		 *  @private
		 */
		protected function configureScrollBars () : void;
		/**
		 *  @private     *  Move any rows that don't need rerendering     *  Move and rerender any rows left over.
		 */
		protected function scrollVertically (pos:int, deltaPos:int, scrollUp:Boolean) : void;
		/**
		 *  @inheritDoc
		 */
		protected function scrollHorizontally (pos:int, deltaPos:int, scrollUp:Boolean) : void;
		/**
		 *  @private
		 */
		protected function moveSelectionVertically (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;
		/**
		 *  @private
		 */
		protected function moveSelectionHorizontally (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;
		private function displayingPartialRow () : Boolean;
		private function displayingPartialColumn () : Boolean;
		/**
		 *  @private
		 */
		protected function finishKeySelection () : void;
		/**
		 *  @private
		 */
		public function itemRendererToIndex (item:IListItemRenderer) : int;
		/**
		 *  @private
		 */
		public function indexToItemRenderer (index:int) : IListItemRenderer;
		/**
		 *  @private
		 */
		public function calculateDropIndex (event:DragEvent = null) : int;
		/**
		 *  @private
		 */
		public function showDropFeedback (event:DragEvent) : void;
		/**
		 *  @private
		 */
		public function measureWidthOfItems (index:int = -1, count:int = 0) : Number;
		/**
		 *  @private
		 */
		function getMeasuringRenderer (data:Object) : IListItemRenderer;
		/**
		 *  @private
		 */
		function purgeMeasuringRenderers () : void;
		/**
		 *  Get the appropriate renderer, using the default renderer if none is specified.     *       *  @param data The renderer's data structure.     *       *  @return The item renderer.
		 */
		public function createItemRenderer (data:Object) : IListItemRenderer;
		/**
		 *  @private
		 */
		function setupRendererFromData (item:IListItemRenderer, data:Object) : void;
		/**
		 *  @private
		 */
		public function measureHeightOfItems (index:int = -1, count:int = 0) : Number;
		/**
		 *  @private
		 */
		protected function scrollPositionToIndex (horizontalScrollPosition:int, verticalScrollPosition:int) : int;
		/**
		 *  @private     *     *  see ListBase.as
		 */
		function addClipMask (layoutChanged:Boolean) : void;
		/**
		 *  @private     *     *  Undo the effects of the addClipMask function (above)
		 */
		function removeClipMask () : void;
		/**
		 *  @private
		 */
		function adjustOffscreenRowsAndColumns () : void;
		/**
		 *  Creates a new ListData instance and populates the fields based on     *  the input data provider item.      *       *  @param data The data provider item used to populate the ListData.     *  @param uid The UID for the item.     *  @param rowNum The index of the item in the data provider.     *  @param columnNum The columnIndex associated with this item.      *       *  @return A newly constructed ListData object.
		 */
		protected function makeListData (data:Object, uid:String, rowNum:int, columnNum:int) : BaseListData;
		/**
		 *  @private     *  Assumes horizontal.
		 */
		private function lastRowInColumn (index:int) : int;
		/**
		 *  @private     *  Assumes vertical.
		 */
		private function lastColumnInRow (index:int) : int;
		/**
		 *  @private
		 */
		protected function indexToRow (index:int) : int;
		/**
		 *  @private
		 */
		protected function indexToColumn (index:int) : int;
		/**
		 *  @private
		 */
		public function indicesToIndex (rowIndex:int, columnIndex:int) : int;
		/**
		 *  @private
		 */
		protected function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function reconstructDataFromListItems () : Array;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Draws the backgrounds, if any, behind all of the tiles.     *  This implementation makes a Sprite names "tileBGs" if     *  it doesn't exist, adds it to the back     *  of the z-order in the <code>listContent</code>, and     *  calls <code>drawTileBackground()</code> for each visible     *  tile.
		 */
		protected function drawTileBackgrounds () : void;
		/**
		 *  Draws the background for an individual tile.      *  Takes a Sprite object, applies the background dimensions     *  and color, and returns the sprite with the values applied.     *       *  @param s The Sprite that contains the individual tile backgrounds.     *  @param rowIndex The index of the row that contains the tile.     *  @param columnIndex The index of the column that contains the tile.     *  @param width The width of the background.     *  @param height The height of the background.     *  @param color The fill color for the background.     *  @param item The item renderer for the tile.     *      *  @return The background Sprite.     *
		 */
		protected function drawTileBackground (s:Sprite, rowIndex:int, columnIndex:int, width:Number, height:Number, color:uint, item:IListItemRenderer) : DisplayObject;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function scrollHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function scrollToIndex (index:int) : Boolean;
		/**
		 *  Called from the <code>updateDisplayList()</code> method to adjust the size and position of     *  listContent.     *       *  @param unscaledWidth The width of the listContent before any external scaling is applied.     *       *  @param unscaledHeight The height of the listContent before any external scaling is applied.
		 */
		protected function adjustListContent (unscaledWidth:Number = -1, unscaledHeight:Number = -1) : void;
	}
}
