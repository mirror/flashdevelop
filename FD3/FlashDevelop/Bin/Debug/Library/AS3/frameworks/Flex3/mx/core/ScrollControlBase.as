/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import flash.events.MouseEvent;
	import mx.controls.scrollClasses.ScrollBar;
	import flash.events.Event;
	public class ScrollControlBase extends UIComponent {
		/**
		 * The border object.
		 */
		protected var border:IFlexDisplayObject;
		/**
		 * Returns an EdgeMetrics object that has four properties:
		 *  left, top, right,
		 *  and bottom.
		 *  The value of each property is equal to the thickness of one side
		 *  of the border, expressed in pixels.
		 */
		public function get borderMetrics():EdgeMetrics;
		/**
		 * The horizontal scroll bar.
		 *  This property is null if no horizontal scroll bar
		 *  is currently displayed.
		 *  In general you do not access this property directly.
		 *  Manipulation of the horizontalScrollPolicy
		 *  and horizontalScrollPosition
		 *  properties should provide sufficient control over the scroll bar.
		 */
		protected var horizontalScrollBar:ScrollBar;
		/**
		 * A property that indicates whether the horizontal scroll
		 *  bar is always on, always off,
		 *  or automatically changes based on the parameters passed to the
		 *  setScrollBarProperties() method.
		 *  Allowed values are ScrollPolicy.ON,
		 *  ScrollPolicy.OFF, and ScrollPolicy.AUTO.
		 *  MXML values can be "on", "off",
		 *  and "auto".
		 */
		public function get horizontalScrollPolicy():String;
		public function set horizontalScrollPolicy(value:String):void;
		/**
		 * The offset into the content from the left edge.  This can
		 *  be a pixel offset in some subclasses or some other metric
		 *  like the number of columns in a DataGrid or number of items
		 *  in a HorizontalList or TileList.
		 */
		public function get horizontalScrollPosition():Number;
		public function set horizontalScrollPosition(value:Number):void;
		/**
		 * A flag that indicates whether scrolling is live as the
		 *  scrollbar thumb is moved
		 *  or the view is not updated until the thumb is released.
		 *  The default value is true.
		 */
		public var liveScrolling:Boolean = true;
		/**
		 * The mask. This property may be undefined if no scroll bars
		 *  are currently displayed or in some subclasses which
		 *  have a different masking mechanism.
		 *  A mask defined the viewable area of a displayable object.
		 *  Thus this mask is used to hide the portions of the content
		 *  that are not currently viewable.
		 *  In general you do not access this property directly.
		 *  Manipulation of the horizontalScrollPolicy,
		 *  verticalScrollPolicy, horizontalScrollPosition,
		 *  and verticalScrollPosition properties
		 *  should provide sufficient control over the mask.
		 */
		protected var maskShape:Shape;
		/**
		 * The maximum value for the horizontalScrollPosition property.
		 *  Note that this is not the width of the content because the
		 *  maxHorizontalScrollPosition property contains the width
		 *  of the content minus the width of the displayable area.
		 */
		public function get maxHorizontalScrollPosition():Number;
		public function set maxHorizontalScrollPosition(value:Number):void;
		/**
		 * The maximum value for the verticalScrollPosition property.
		 *  Note that this is not the height of the content because the
		 *  maxVerticalScrollPosition property contains the height
		 *  of the content minus the height of the displayable area.
		 */
		public function get maxVerticalScrollPosition():Number;
		public function set maxVerticalScrollPosition(value:Number):void;
		/**
		 * A flag that the scrolling area changed due to the appearance or disappearance of
		 *  scrollbars.  Used by most layout methods to re-adjust the scrolling properties again.
		 */
		protected var scrollAreaChanged:Boolean;
		/**
		 * A function that computes the string to be displayed as the ScrollTip.
		 *  This function is called if the showScrollTips property
		 *  is set to true and the scroll thumb is being dragged.
		 *  The function should return a String that used as a ScrollTip.
		 *  The function is passed two parameters.
		 *  The first is the direction of the scroll bar.
		 */
		public function get scrollTipFunction():Function;
		public function set scrollTipFunction(value:Function):void;
		/**
		 * A flag that indicates whether a tooltip should appear
		 *  near the scroll thumb when it is being dragged.
		 *  The default value is false to disable the tooltip.
		 */
		public var showScrollTips:Boolean = false;
		/**
		 * The vertical scroll bar.
		 *  This property is null if no vertical scroll bar
		 *  is currently displayed.
		 *  In general you do not access this property directly.
		 *  Manipulation of the verticalScrollPolicy
		 *  and verticalScrollPosition
		 *  properties should provide sufficient control over the scroll bar.
		 */
		protected var verticalScrollBar:ScrollBar;
		/**
		 * A property that indicates whether the vertical scroll bar is always on, always off,
		 *  or automatically changes based on the parameters passed to the
		 *  setScrollBarProperties() method.
		 *  Allowed values are ScrollPolicy.ON,
		 *  ScrollPolicy.OFF, and ScrollPolicy.AUTO.
		 *  MXML values can be "on", "off",
		 *  and "auto".
		 */
		public function get verticalScrollPolicy():String;
		public function set verticalScrollPolicy(value:String):void;
		/**
		 * The offset into the content from the top edge.  This can
		 *  be a pixel offset in some subclasses or some other metric
		 *  like number of lines in a List or number of tiles in
		 *  a TileList.
		 */
		public function get verticalScrollPosition():Number;
		public function set verticalScrollPosition(value:Number):void;
		/**
		 * An EdgeMetrics object taking into account the scroll bars,
		 *  if visible.
		 */
		public function get viewMetrics():EdgeMetrics;
		/**
		 * Constructor.
		 */
		public function ScrollControlBase();
		/**
		 * Creates the border for this component.
		 *  Normally the border is determined by the
		 *  borderStyle and borderSkin styles.
		 *  It must set the border property to the instance
		 *  of the border.
		 */
		protected function createBorder():void;
		/**
		 * Creates objects that are children of this ScrollControlBase,
		 *  which in this case are the border and mask.
		 *  Flex calls this method when the ScrollControlBase is first created.
		 *  If a subclass overrides this method, the subclass should call
		 *  the super.createChildren() method so that the logic
		 *  in the ScrollControlBase.createChildren() method is executed.
		 */
		protected override function createChildren():void;
		/**
		 * Responds to size changes by setting the positions and sizes
		 *  of this control's borders.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected function layoutChrome(unscaledWidth:Number, unscaledHeight:Number):void;
		/**
		 * Event handler for the mouse wheel scroll event.
		 *
		 * @param event             <MouseEvent> The event object.
		 */
		protected function mouseWheelHandler(event:MouseEvent):void;
		/**
		 * @param bar               <ScrollBar> 
		 * @param unscaledWidth     <Number> 
		 * @param unscaledHeight    <Number> 
		 */
		protected function roomForScrollBar(bar:ScrollBar, unscaledWidth:Number, unscaledHeight:Number):Boolean;
		/**
		 * Default event handler for the scroll event.
		 *
		 * @param event             <Event> The event object.
		 */
		protected function scrollHandler(event:Event):void;
		/**
		 * Causes the ScrollControlBase to show or hide scrollbars based
		 *  on the parameters passed in. If a TextArea can only show 100 pixels
		 *  across and 5 lines of text, but the actual text to display is 200 pixels wide
		 *  and 30 lines of text, then the setScrollBarProperties() method
		 *  is called as
		 *  setScrollBarProperties(200, 100, 30, 5).
		 *
		 * @param totalColumns      <int> The number of horizontal units that need to be displayed.
		 * @param visibleColumns    <int> The number of horizontal units that can be displayed at one time.
		 * @param totalRows         <int> The number of vertical units that need to be displayed.
		 * @param visibleRows       <int> The number of vertical units that can be displayed at one time
		 */
		protected function setScrollBarProperties(totalColumns:int, visibleColumns:int, totalRows:int, visibleRows:int):void;
	}
}
