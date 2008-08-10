/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.dataGridClasses {
	import flash.display.Sprite;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.UIComponent;
	public class DataGridHeader extends DataGridHeaderBase {
		/**
		 * The offset, in pixels, from the bottom of the content of the renderer.
		 */
		public var bottomOffset:Number = 0;
		/**
		 * The cached header height, in pixels.
		 */
		protected var cachedHeaderHeight:Number = 0;
		/**
		 * The cached padding for the bottom of the renderer, in pixels.
		 */
		protected var cachedPaddingBottom:Number = 0;
		/**
		 * The cached padding for the top of the renderer, in pixels.
		 */
		protected var cachedPaddingTop:Number = 0;
		/**
		 * The DataGrid control associated with this renderer.
		 */
		protected var dataGrid:DataGrid;
		/**
		 * Whether the component can accept user interaction. After setting the enabled
		 *  property to false, some components still respond to mouse interactions such
		 *  as mouseOver. As a result, to fully disable UIComponents,
		 *  you should also set the value of the mouseEnabled property to false.
		 *  If you set the enabled property to false
		 *  for a container, Flex dims the color of the container and of all
		 *  of its children, and blocks user input to the container
		 *  and to all of its children.
		 */
		public function set enabled(value:Boolean):void;
		/**
		 * An Array of header renderer instances.
		 */
		protected var headerItems:Array;
		/**
		 * The offset, in pixels, from the left side of the content of the renderer.
		 */
		public var leftOffset:Number = 0;
		/**
		 * Whether we need the separator on the far right
		 */
		public var needRightSeparator:Boolean = false;
		/**
		 * Whether we need the separator events on the far right
		 */
		public var needRightSeparatorEvents:Boolean = false;
		/**
		 * The offset, in pixels, from the right side of the content of the renderer.
		 */
		public var rightOffset:Number = 0;
		/**
		 * The offset, in pixels, from the top of the content of the renderer.
		 */
		public var topOffset:Number = 0;
		/**
		 * Constructor.
		 */
		public function DataGridHeader();
		/**
		 * Removes column header separators that the user normally uses
		 *  to resize columns.
		 */
		protected function clearSeparators():void;
		/**
		 * Create child objects of the component.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 */
		protected override function createChildren():void;
		/**
		 * Draws the overlay on the dragged column into the given Sprite
		 *  at the position, width and height specified using the
		 *  color specified.
		 *
		 * @param indicator         <Sprite> A Sprite that should contain the graphics
		 *                            that indicate that a column is being dragged.
		 * @param x                 <Number> The suggested x position for the indicator.
		 * @param y                 <Number> The suggested y position for the indicator.
		 * @param width             <Number> The suggested width for the indicator.
		 * @param height            <Number> The suggested height for the indicator.
		 * @param color             <uint> The suggested color for the indicator.
		 * @param itemRenderer      <IListItemRenderer> The item renderer that is being dragged.
		 */
		protected function drawColumnDragOverlay(indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void;
		/**
		 * Draws the background of the headers into the given
		 *  UIComponent. The graphics drawn may be scaled horizontally
		 *  if the component's width changes or this method will be
		 *  called again to redraw at a different width and/or height
		 *
		 * @param headerBG          <UIComponent> A UIComponent that will contain the header
		 *                            background graphics.
		 */
		protected function drawHeaderBackground(headerBG:UIComponent):void;
		/**
		 * Draws the highlight indicator into the given Sprite
		 *  at the position, width and height specified using the
		 *  color specified.
		 *
		 * @param indicator         <Sprite> A Sprite that should contain the graphics
		 *                            that make a renderer look highlighted.
		 * @param x                 <Number> The suggested x position for the indicator.
		 * @param y                 <Number> The suggested y position for the indicator.
		 * @param width             <Number> The suggested width for the indicator.
		 * @param height            <Number> The suggested height for the indicator.
		 * @param color             <uint> The suggested color for the indicator.
		 * @param itemRenderer      <IListItemRenderer> The item renderer that is being highlighted.
		 */
		protected function drawHeaderIndicator(indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void;
		/**
		 * Draws the selection indicator into the given Sprite
		 *  at the position, width and height specified using the
		 *  color specified.
		 *
		 * @param indicator         <Sprite> A Sprite that should contain the graphics
		 *                            that make a renderer look selected.
		 * @param x                 <Number> The suggested x position for the indicator.
		 * @param y                 <Number> The suggested y position for the indicator.
		 * @param width             <Number> The suggested width for the indicator.
		 * @param height            <Number> The suggested height for the indicator.
		 * @param color             <uint> The suggested color for the indicator.
		 * @param itemRenderer      <IListItemRenderer> The item renderer that is being selected.
		 */
		protected function drawSelectionIndicator(indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void;
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
		 * Calculates the default size, and optionally the default minimum size,
		 *  of the component. This is an advanced method that you might override when
		 *  creating a subclass of UIComponent.
		 */
		protected override function measure():void;
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
		 * Draws the object and/or sizes and positions its children.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void;
	}
}
