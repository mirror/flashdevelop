package mx.core
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import mx.controls.HScrollBar;
	import mx.controls.ToolTip;
	import mx.controls.VScrollBar;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.events.ScrollEventDirection;
	import mx.managers.ToolTipManager;
	import mx.styles.ISimpleStyleClient;

	/**
	 *  Dispatched when the content is scrolled.
 *
 *  @eventType mx.events.ScrollEvent.SCROLL
 *  @helpid 3269
	 */
	[Event(name="scroll", type="mx.events.ScrollEvent")] 

include "../styles/metadata/BorderStyles.as"
include "../styles/metadata/LeadingStyle.as"
include "../styles/metadata/TextStyles.as"
	/**
	 *  Style name for horizontal scrollbar.  This allows more control over
 *  the appearance of the scrollbar.
 *
 *  @default undefined
	 */
	[Style(name="horizontalScrollBarStyleName", type="String", inherit="no")] 

	/**
	 *  Style name for vertical scrollbar.  This allows more control over
 *  the appearance of the scrollbar.
 *
 *  @default undefined
	 */
	[Style(name="verticalScrollBarStyleName", type="String", inherit="no")] 

include "../core/Version.as"
	/**
	 *  The ScrollControlBase class is the base class for controls
 *  with scroll bars.
 *  The user interacts with the scroll bar or the developer accesses
 *  methods and properties that alter the viewable area.
 *  The ScrollControlBase takes a single child object and positions and
 *  masks or sizes that object to display the viewable content.
 *  All items to be scrolled must be children of that content object
 *
 *  @mxml
 *
 *  <p>The <code>&lt;ScrollControlBase&gt;</code> tag inherits all the tag attributes
 *  of its superclass, and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:<i>tagname</i>
 *  <b>Properties</b>
 *  border="<i>object of border skin style</i>"
 *  horizontalScrollPolicy="off|on|auto"
 *  horizontalScrollPosition="0"
 *  liveScrolling="true|false"
 *  maxHorizontalScrollPosition="NaN"
 *  maxVerticalScrollPosition="NaN"
 *  scrollTipFunction="undefined"
 *  showScrollTips="false|true"
 *  verticalScrollPolicy="auto|off|on"
 *  verticalScrollPosition="0" 
 *  <b>Styles</b>
 *  backgroundAlpha="1.0"
 *  backgroundColor="undefined"
 *  backgroundImage="undefined"
 *  backgroundSize="auto"
 *  borderColor="0xAAB3B3"
 *  borderSides="left top right bottom"
 *  borderSkin="ClassReference('mx.skins.halo.HaloBorder')"
 *  borderStyle="inset"
 *  borderThickness="1"
 *  color="0x0B333C"
 *  cornerRadius="0"
 *  disabledColor="0xAAB3B3"
 *  dropShadowColor="0x000000"
 *  dropShadowEnabled="false"
 *  fontFamily="Verdana"
 *  fontSize="10"
 *  fontStyle="normal|italic"
 *  fontWeight="normal|bold"
 *  horizontalScrollBarStyleName=""
 *  leading="2"
 *  shadowDirection="center"
 *  shadowDistance="2"
 *  textAlign="<i>value; see detail.</i>"
 *  textDecoration="none|underline"
 *  textIndent="0"
 *  verticalScrollBarStyleName=""
 * 
 *  <b>Events</b>
 *  scroll="<i>No default</i>"
 *  /&gt;
 *  </pre>
 *
 *  @helpid 3270
 *  @tiptext base class for views/containers that support scrolling
	 */
	public class ScrollControlBase extends UIComponent
	{
		/**
		 *  The border object.
		 */
		protected var border : IFlexDisplayObject;
		/**
		 *  @private
     *  Offsets including borders and scrollbars.
		 */
		private var _viewMetrics : EdgeMetrics;
		/**
		 *  The mask. This property may be undefined if no scroll bars
     *  are currently displayed or in some subclasses which
     *  have a different masking mechanism.
     *  A mask defined the viewable area of a displayable object.
     *  Thus this mask is used to hide the portions of the content
     *  that are not currently viewable.
     *  In general you do not access this property directly.
     *  Manipulation of the <code>horizontalScrollPolicy</code>, 
     *  <code>verticalScrollPolicy</code>, <code>horizontalScrollPosition</code>, 
     *  and <code>verticalScrollPosition</code> properties
     *  should provide sufficient control over the mask.
		 */
		protected var maskShape : Shape;
		/**
		 *  The horizontal scroll bar.
     *  This property is null if no horizontal scroll bar
     *  is currently displayed.
     *  In general you do not access this property directly.
     *  Manipulation of the <code>horizontalScrollPolicy</code> 
     *  and <code>horizontalScrollPosition</code>
     *  properties should provide sufficient control over the scroll bar.
		 */
		protected var horizontalScrollBar : ScrollBar;
		/**
		 *  The vertical scroll bar.
     *  This property is null if no vertical scroll bar
     *  is currently displayed.
     *  In general you do not access this property directly.
     *  Manipulation of the <code>verticalScrollPolicy</code> 
     *  and <code>verticalScrollPosition</code>
     *  properties should provide sufficient control over the scroll bar.
		 */
		protected var verticalScrollBar : ScrollBar;
		/**
		 *  @private
		 */
		private var numberOfCols : Number;
		/**
		 *  @private
		 */
		private var numberOfRows : Number;
		/**
		 *  @private
		 */
		var _maxVerticalScrollPosition : Number;
		var _maxHorizontalScrollPosition : Number;
		/**
		 *  @private
		 */
		private var viewableRows : Number;
		private var viewableColumns : Number;
		/**
		 *  @private
		 */
		private var propsInited : Boolean;
		/**
		 *  A flag that the scrolling area changed due to the appearance or disappearance of
     *  scrollbars.  Used by most layout methods to re-adjust the scrolling properties again.
		 */
		protected var scrollAreaChanged : Boolean;
		/**
		 *  @private
		 */
		private var invLayout : Boolean;
		/**
		 *  @private
     *  Instance of the scrollTip. (There can be only one.)
		 */
		private var scrollTip : ToolTip;
		/**
		 *  @private
     *  Base position for the scrollTip.
		 */
		private var scrollThumbMidPoint : Number;
		/**
		 *  @private
     *  Keep track of the whether the ToolTipManager was enabled
     *  before dealing with scroll tips.
		 */
		private var oldTTMEnabled : Boolean;
		/**
		 *  @private
     *  Storage for the horizontalScrollPosition property.
		 */
		var _horizontalScrollPosition : Number;
		/**
		 *  @private
     *  Storage for the horizontalScrollPolicy property.
		 */
		var _horizontalScrollPolicy : String;
		/**
		 *  A flag that indicates whether scrolling is live as the 
     *  scrollbar thumb is moved
     *  or the view is not updated until the thumb is released.
     *  The default value is <code>true</code>.
		 */
		public var liveScrolling : Boolean;
		/**
		 *  @private
     *  Storage for the scrollTipFunction property.
		 */
		private var _scrollTipFunction : Function;
		/**
		 *  A flag that indicates whether a tooltip should appear
     *  near the scroll thumb when it is being dragged.
     *  The default value is <code>false</code> to disable the tooltip.
		 */
		public var showScrollTips : Boolean;
		/**
		 *  @private
     *  Storage for the verticalScrollPosition property.
		 */
		var _verticalScrollPosition : Number;
		/**
		 *  @private
     *  Storage for the verticalScrollPolicy property.
		 */
		var _verticalScrollPolicy : String;

		/**
		 *  @private
     *  Scrollbars must be enabled/disabled when we are.
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  Returns an EdgeMetrics object that has four properties:
     *  <code>left</code>, <code>top</code>, <code>right</code>,
     *  and <code>bottom</code>.
     *  The value of each property is equal to the thickness of one side
     *  of the border, expressed in pixels.
     *
     *  @return EdgeMetrics object with the left, right, top,
     *  and bottom properties.
		 */
		public function get borderMetrics () : EdgeMetrics;

		/**
		 *  The offset into the content from the left edge.  This can
     *  be a pixel offset in some subclasses or some other metric
     *  like the number of columns in a DataGrid or number of items
     *  in a HorizontalList or TileList.
     *
     *  @default 0
		 */
		public function get horizontalScrollPosition () : Number;
		/**
		 *  @private
     *  This only moves the scrollBars -- assumes the call emanated
     *  from the scrollable content.
		 */
		public function set horizontalScrollPosition (value:Number) : void;

		/**
		 *  A property that indicates whether the horizontal scroll 
     *  bar is always on, always off,
     *  or automatically changes based on the parameters passed to the
     *  <code>setScrollBarProperties()</code> method.
     *  Allowed values are <code>ScrollPolicy.ON</code>,
     *  <code>ScrollPolicy.OFF</code>, and <code>ScrollPolicy.AUTO</code>.
     *  MXML values can be <code>"on"</code>, <code>"off"</code>,
     *  and <code>"auto"</code>.
     *
     *  <p>Setting this property to <code>ScrollPolicy.OFF</code> for ListBase
     *  subclasses does not affect the <code>horizontalScrollPosition</code>
     *  property; you can still scroll the contents programmatically.</p>
     *
     *  <p>Note that the policy can affect the measured size of the component
     *  If the policy is <code>ScrollPolicy.AUTO</code> the
     *  scrollbar is not factored in the measured size.  This is done to
     *  keep the layout from recalculating when the scrollbar appears.  If you
     *  know that you will have enough data for scrollbars you should set
     *  the policy to <code>ScrollPolicy.ON</code>.  If you
     *  don't know, you may need to set an explicit width or height on
     *  the component to allow for scrollbars to appear later.</p>
     *
     *  @default ScrollPolicy.OFF
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;

		/**
		 *  The maximum value for the <code>horizontalScrollPosition</code> property.
     *  Note that this is not the width of the content because the
     *  <code>maxHorizontalScrollPosition</code> property contains the width 
     *  of the content minus the width of the displayable area.
     *
     *  <p>In most components, the value of the 
     *  <code>maxHorizontalScrollPosition</code> property is computed from the
     *  data and size of component, and must not be set by
     *  the application code.</p>
		 */
		public function get maxHorizontalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set maxHorizontalScrollPosition (value:Number) : void;

		/**
		 *  The maximum value for the <code>verticalScrollPosition</code> property.
     *  Note that this is not the height of the content because the
     *  <code>maxVerticalScrollPosition</code> property contains the height 
     *  of the content minus the height of the displayable area.
     *
     *  <p>The value of the 
     *  <code>maxVerticalScrollPosition</code> property is computed from the
     *  data and size of component, and must not be set by
     *  the application code.</p>
		 */
		public function get maxVerticalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set maxVerticalScrollPosition (value:Number) : void;

		/**
		 *  A function that computes the string to be displayed as the ScrollTip.
     *  This function is called if the <code>showScrollTips</code> property
     *  is set to <code>true</code> and the scroll thumb is being dragged.
     *  The function should return a String that used as a ScrollTip.
     *  The function is passed two parameters.
     *  The first is the <code>direction</code> of the scroll bar.
     *  The second is its <code>scrollPosition</code>, as the following example shows:
     *  
     *  <pre>
     *  function scrollTipFunction(direction:String, position:Number):String 
     *  {
     *    if (direction == "vertical") return myToolTips[position];
     *    else return "";
     *  }</pre>
		 */
		public function get scrollTipFunction () : Function;
		/**
		 *  @private
		 */
		public function set scrollTipFunction (value:Function) : void;

		/**
		 *  An EdgeMetrics object taking into account the scroll bars,
     *  if visible.
     *
     *  @return EdgeMetrics object with the thickness, in pixels,
     *  of the left, top, right, and bottom edges.
		 */
		public function get viewMetrics () : EdgeMetrics;

		/**
		 *  The offset into the content from the top edge.  This can
     *  be a pixel offset in some subclasses or some other metric
     *  like number of lines in a List or number of tiles in
     *  a TileList.
     * 
     *  @default 0
		 */
		public function get verticalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set verticalScrollPosition (value:Number) : void;

		/**
		 *  A property that indicates whether the vertical scroll bar is always on, always off,
     *  or automatically changes based on the parameters passed to the
     *  <code>setScrollBarProperties()</code> method.
     *  Allowed values are <code>ScrollPolicy.ON</code>,
     *  <code>ScrollPolicy.OFF</code>, and <code>ScrollPolicy.AUTO</code>.
     *  MXML values can be <code>"on"</code>, <code>"off"</code>,
     *  and <code>"auto"</code>.
     * 
     *  <p>Setting this property to <code>ScrollPolicy.OFF</code> for ListBase
     *  subclasses does not affect the <code>verticalScrollPosition</code>
     *  property; you can still scroll the contents programmatically.</p>
     *
     *  <p>Note that the policy can affect the measured size of the component
     *  If the policy is <code>ScrollPolicy.AUTO</code> the
     *  scrollbar is not factored in the measured size.  This is done to
     *  keep the layout from recalculating when the scrollbar appears.  If you
     *  know that you will have enough data for scrollbars you should set
     *  the policy to <code>ScrollPolicy.ON</code>.  If you
     *  don't know, you may need to set an explicit width or height on
     *  the component to allow for scrollbars to appear later.</p>
     *
     *  @default ScrollPolicy.AUTO
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;

		/**
		 *  @private
		 */
		function get scroll_verticalScrollBar () : ScrollBar;

		/**
		 *  @private
		 */
		function get scroll_horizontalScrollBar () : ScrollBar;

		/**
		 *  Constructor.
		 */
		public function ScrollControlBase ();

		/**
		 *  Creates objects that are children of this ScrollControlBase,
     *  which in this case are the border and mask.
     *  Flex calls this method when the ScrollControlBase is first created.
     *  If a subclass overrides this method, the subclass should call
     *  the <code>super.createChildren()</code> method so that the logic
     *  in the <code>ScrollControlBase.createChildren()</code> method is executed.
		 */
		protected function createChildren () : void;

		/**
		 *  @private
     *  Sets the position and size of the scroll bars and content
     *  and adjusts the mask.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  Responds to size changes by setting the positions and sizes
     *  of this control's borders.
     *
     *  <p>The <code>ScrollControlBase.layoutChrome()</code> method sets the
     *  position and size of the ScrollControlBase's border.
     *  In every subclass of ScrollControlBase, the subclass's <code>layoutChrome()</code>
     *  method should call the <code>super.layoutChrome()</code> method,
     *  so that the border is positioned properly.</p>
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
		 */
		protected function layoutChrome (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  Creates the border for this component.
     *  Normally the border is determined by the
     *  <code>borderStyle</code> and <code>borderSkin</code> styles.  
     *  It must set the border property to the instance
     *  of the border.
		 */
		protected function createBorder () : void;

		/**
		 *  Returns <code>true</code> if a border is needed for this component based
     *  on the borderStyle and whether or not there is a background
     *  for the component.
		 */
		private function isBorderNeeded () : Boolean;

		/**
		 *  Causes the ScrollControlBase to show or hide scrollbars based
     *  on the parameters passed in. If a TextArea can only show 100 pixels
     *  across and 5 lines of text, but the actual text to display is 200 pixels wide
     *  and 30 lines of text, then the <code>setScrollBarProperties()</code> method 
     *  is called as
     *  <code>setScrollBarProperties(200, 100, 30, 5)</code>.
     *
     *  @param totalColumns The number of horizontal units that need to be displayed.
     *
     *  @param visibleColumns The number of horizontal units that can be displayed at one time.
     *
     *  @param totalRows The number of vertical units that need to be displayed.
     *
     *  @param visibleRows The number of vertical units that can be displayed at one time
		 */
		protected function setScrollBarProperties (totalColumns:int, visibleColumns:int, totalRows:int, visibleRows:int) : void;

		/**
		 *  @private
     *  Create the HScrollBar
		 */
		private function createHScrollBar (visible:Boolean) : ScrollBar;

		/**
		 *  @private
     *  Create the VScrollBar
		 */
		private function createVScrollBar (visible:Boolean) : ScrollBar;

		/**
		 *  Determines if there is enough space in this component to display 
     *  a given scrollbar.
     *
     *  @param bar The scrollbar
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
     *
     *  @return Returns true if there is enough space for a scrollbar.
		 */
		protected function roomForScrollBar (bar:ScrollBar, unscaledWidth:Number, unscaledHeight:Number) : Boolean;

		/**
		 *  Default event handler for the <code>scroll</code> event.
     *
     *  @param event The event object.
		 */
		protected function scrollHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function scrollTipHandler (event:Event) : void;

		/**
		 *  Event handler for the mouse wheel scroll event.
     *
     *  @param event The event object.
		 */
		protected function mouseWheelHandler (event:MouseEvent) : void;
	}
}
