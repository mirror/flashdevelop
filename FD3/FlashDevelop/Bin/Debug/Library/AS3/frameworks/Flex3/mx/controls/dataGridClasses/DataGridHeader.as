package mx.controls.dataGridClasses
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.DataGrid;
	import mx.core.EdgeMetrics;
	import mx.core.FlexSprite;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.events.DataGridEvent;
	import mx.events.SandboxMouseEvent;
	import mx.managers.CursorManager;
	import mx.managers.CursorManagerPriority;
	import mx.skins.halo.DataGridColumnDropIndicator;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleManager;
	import mx.core.mx_internal;
	import mx.effects.easing.Back;

	/**
	 *  The DataGridHeader class defines the default header
 *  renderer for a DataGrid control.  
 *  By default, the header renderer
 *  draws the text associated with each header in the list, and an optional
 *  sort arrow (if sorted by that column).
 *
 *  @see mx.controls.DataGrid
	 */
	public class DataGridHeader extends DataGridHeaderBase
	{
		/**
		 *  @private
     *  Additional affordance given to header separators.
		 */
		private var separatorAffordance : Number;
		/**
		 *  The DataGrid control associated with this renderer.
		 */
		protected var dataGrid : DataGrid;
		/**
		 *  An Array of header renderer instances.
		 */
		protected var headerItems : Array;
		/**
		 *  The cached header height, in pixels.
		 */
		protected var cachedHeaderHeight : Number;
		/**
		 *  The cached padding for the bottom of the renderer, in pixels.
		 */
		protected var cachedPaddingBottom : Number;
		/**
		 *  The cached padding for the top of the renderer, in pixels.
		 */
		protected var cachedPaddingTop : Number;
		/**
		 *  Whether we need the separator on the far right
		 */
		public var needRightSeparator : Boolean;
		/**
		 *  Whether we need the separator events on the far right
		 */
		public var needRightSeparatorEvents : Boolean;
		/**
		 *  @private
		 */
		private var resizeCursorID : int;
		/**
		 *  @private
     *  A tmp var to store the stretching col's X coord.
		 */
		private var startX : Number;
		/**
		 *  @private
     *  A tmp var to store the stretching col's min X coord for column's minWidth.
		 */
		private var minX : Number;
		/**
		 *  @private
     *  A tmp var to store the last point (in dataGrid coords) received while dragging.
		 */
		private var lastPt : Point;
		/**
		 *  @private
     *  List of header separators for column resizing.
		 */
		private var separators : Array;
		/**
		 *  Specifies a graphic that shows the proposed column width as the user stretches it.
		 */
		private var resizeGraphic : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var lastItemDown : IListItemRenderer;
		/**
		 *  @private
     *  Index of column before which to drop
		 */
		private var dropColumnIndex : int;
		/**
		 *  @private
		 */
		var columnDropIndicator : IFlexDisplayObject;
		/**
		 *  The small arrow graphic used to show sortable columns and direction.
		 */
		var sortArrow : IFlexDisplayObject;
		/**
		 *  The offset, in pixels, from the left side of the content of the renderer.
		 */
		public var leftOffset : Number;
		/**
		 *  The offset, in pixels, from the top of the content of the renderer.
		 */
		public var topOffset : Number;
		/**
		 *  The offset, in pixels, from the right side of the content of the renderer.
		 */
		public var rightOffset : Number;
		/**
		 *  The offset, in pixels, from the bottom of the content of the renderer.
		 */
		public var bottomOffset : Number;
		/**
		 *  @private
		 */
		private var allowItemSizeChangeNotification : Boolean;
		private var headerBGSkinChanged : Boolean;
		private var headerSepSkinChanged : Boolean;

		/**
		 *  @copy mx.core.IUIComponent#enabled
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  @private
     *  The column that is being resized.
		 */
		private function get resizingColumn () : DataGridColumn;
		/**
		 *  @private
     *  The column that is being resized.
		 */
		private function set resizingColumn (value:DataGridColumn) : void;

		/**
		 *  diagnostics
		 */
		function get rendererArray () : Array;

		/**
		 *  Constructor.
		 */
		public function DataGridHeader ();

		/**
		 *  a function to clear selections
		 */
		function clearSelectionLayer () : void;

		/**
		 *  @inheritDoc
		 */
		protected function createChildren () : void;

		/**
		 *  @inheritDoc
		 */
		protected function measure () : void;

		/**
		 *  @inheritDoc
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;

		function _drawHeaderBackground (headerBG:UIComponent) : void;

		/**
		 *  Draws the background of the headers into the given 
     *  UIComponent. The graphics drawn may be scaled horizontally
     *  if the component's width changes or this method will be
     *  called again to redraw at a different width and/or height
     *
     *  @param headerBG A UIComponent that will contain the header
     *  background graphics.
		 */
		protected function drawHeaderBackground (headerBG:UIComponent) : void;

		private function drawHeaderBackgroundSkin (headerBGSkin:IFlexDisplayObject) : void;

		function _clearSeparators () : void;

		/**
		 *  Removes column header separators that the user normally uses
     *  to resize columns.
		 */
		protected function clearSeparators () : void;

		function _drawSeparators () : void;

		/**
		 *  Creates and displays the column header separators that the user 
     *  normally uses to resize columns.  This implementation uses
     *  the same Sprite as the lines and column backgrounds and adds
     *  instances of the <code>headerSeparatorSkin</code> and attaches mouse
     *  listeners to them in order to know when the user wants
     *  to resize a column.
		 */
		protected function drawSeparators () : void;

		/**
		 *  Draws the highlight indicator into the given Sprite
     *  at the position, width and height specified using the
     *  color specified.
     * 
     *  @param indicator A Sprite that should contain the graphics
     *  that make a renderer look highlighted.
     *
     *  @param x The suggested x position for the indicator.
     *
     *  @param y The suggested y position for the indicator.
     *
     *  @param width The suggested width for the indicator.
     *
     *  @param height The suggested height for the indicator.
     *
     *  @param color The suggested color for the indicator.
     *
     *  @param itemRenderer The item renderer that is being highlighted.
     *
		 */
		protected function drawHeaderIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;

		/**
		 *  Draws the selection indicator into the given Sprite
     *  at the position, width and height specified using the
     *  color specified.
     * 
     *  @param indicator A Sprite that should contain the graphics
     *  that make a renderer look selected.
     *
     *  @param x The suggested x position for the indicator.
     *
     *  @param y The suggested y position for the indicator.
     *
     *  @param width The suggested width for the indicator.
     *
     *  @param height The suggested height for the indicator.
     *
     *  @param color The suggested color for the indicator.
     *
     *  @param itemRenderer The item renderer that is being selected.
     *
		 */
		protected function drawSelectionIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;

		/**
		 *  Draws the overlay on the dragged column into the given Sprite
     *  at the position, width and height specified using the
     *  color specified.
     * 
     *  @param indicator A Sprite that should contain the graphics
     *  that indicate that a column is being dragged.
     *
     *  @param x The suggested x position for the indicator.
     *
     *  @param y The suggested y position for the indicator.
     *
     *  @param width The suggested width for the indicator.
     *
     *  @param height The suggested height for the indicator.
     *
     *  @param color The suggested color for the indicator.
     *
     *  @param itemRenderer The item renderer that is being dragged.
     *
		 */
		protected function drawColumnDragOverlay (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;

		/**
		 *  @private
		 */
		private function columnResizeMouseOverHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function columnResizeMouseOutHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  Indicates where the right side of a resized column appears.
		 */
		private function columnResizeMouseDownHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function columnResizingHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  Determines how much to resize the column.
		 */
		private function columnResizeMouseUpHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function columnDraggingMouseMoveHandler (event:MouseEvent) : void;

		/**
		 *  @private
     * 
     *  @param event MouseEvent or SandboxMouseEvent.
		 */
		private function columnDraggingMouseUpHandler (event:Event) : void;

		/**
		 *  @private
		 */
		protected function mouseOverHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		protected function mouseOutHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;

		function _placeSortArrow () : void;

		/**
		 *  Draws the sort arrow graphic on the column that is the current sort key.
     *  This implementation creates or reuses an instance of the skin specified
     *  by <code>sortArrowSkin</code> style property and places 
     *  it in the appropriate column header.  It
     *  also shrinks the size of the column header if the text in the header
     *  would be obscured by the sort arrow.
		 */
		protected function placeSortArrow () : void;

		/**
		 *  @private
		 */
		public function invalidateSize () : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		function getSeparators () : Array;
	}
}
