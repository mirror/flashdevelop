package mx.controls.scrollClasses
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import mx.controls.Button;
	import mx.core.FlexVersion;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.SandboxMouseEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.managers.ISystemManager;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleProxy;

	/**
	 *  Name of the class to use as the default skin for the down arrow button of  *  the scroll bar. *  *  @default mx.skins.halo.ScrollArrowSkin
	 */
	[Style(name="downArrowSkin", type="Class", inherit="no", states="up, over, down, disabled")] 
	/**
	 *  Name of the class to use as the skin for the down arrow button of the  *  scroll bar when it is disabled.  *  *  If you change the skin, either graphically or programmatically,  *  you should ensure that the new skin is the same height  *  (for horizontal ScrollBars) or width (for vertical ScrollBars) as the track. *  *  @default mx.skins.halo.ScrollArrowSkin
	 */
	[Style(name="downArrowDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the down arrow button of the  *  scroll bar when you click the arrow button * .  *  If you change the skin, either graphically or programmatically,  *  you should ensure that the new skin is the same height  *  (for horizontal ScrollBars) or width (for vertical ScrollBars) as the track. *   *  @default mx.skins.halo.ScrollArrowSkin
	 */
	[Style(name="downArrowDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the down arrow button of the  *  scroll bar when the mouse pointer is over the arrow button.  *  *  If you change the skin, either graphically or programmatically,  *  you should ensure that the new skin is the same height  *  (for horizontal ScrollBars) or width (for vertical ScrollBars) as the track. *   *  @default mx.skins.halo.ScrollArrowSkin
	 */
	[Style(name="downArrowOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the down arrow button of  *  the scroll bar.  *   *  If you change the skin, either graphically or programmatically,  *  you should ensure that the new skin is the same height  *  (for horizontal ScrollBars) or width (for vertical ScrollBars) as the track. *   *  @default mx.skins.halo.ScrollArrowSkin
	 */
	[Style(name="downArrowUpSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the default skin for the down arrow button of  *  the scroll bar.  *   *  @default mx.skins.halo.ScrollArrowSkin
	 */
	[Style(name="thumbSkin", type="Class", inherit="no", states="up, over, down")] 
	/**
	 *  Name of the class to use as the skin for the thumb of the scroll bar  *  when you click the thumb.  *  *  @default mx.skins.halo.ScrollThumbSkin
	 */
	[Style(name="thumbDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon for the thumb of the scroll bar.  *   *  @default "undefined"
	 */
	[Style(name="thumbIcon", type="Class", inherit="no")] 
	/**
	 *  The number of pixels to offset the scroll thumb from the center of the scroll bar.  *  *  @default 0
	 */
	[Style(name="thumbOffset", type="Number", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the thumb of the scroll bar  *  when the mouse pointer is over the thumb.  *  *  @default mx.skins.halo.ScrollThumbSkin
	 */
	[Style(name="thumbOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the thumb of the scroll bar. *   *  @default mx.skins.halo.ScrollThumbSkin
	 */
	[Style(name="thumbUpSkin", type="Class", inherit="no")] 
	/**
	 *  The colors of the track, as an array of two colors. *  You can use the same color twice for a solid track color. *  *  @default [0x94999b, 0xe7e7e7]
	 */
	[Style(name="trackColors", type="Array", arrayType="uint", format="Color", inherit="no")] 
	/**
	 *  Name of the class to use as the default skin for the track of the scroll bar.  *  *  @default mx.skins.halo.ScrollTrackSkin
	 */
	[Style(name="trackSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the track of the scroll bar  *  when the scroll bar is disabled. *  *  @default undefined
	 */
	[Style(name="trackDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the track of the scroll bar  *  when you click on the track. *  *  @default undefined
	 */
	[Style(name="trackDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the track of the scroll bar  *  when the mouse pointer is over the scroll bar. *  *  @default undefined
	 */
	[Style(name="trackOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the track of the scroll bar. *  *  @default undefined
	 */
	[Style(name="trackUpSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the default skin for the up arrow button of the scroll bar.  *  *  @default mx.skins.halo.ScrollArrowSkin
	 */
	[Style(name="upArrowSkin", type="Class", inherit="no", states="up, over, down, disabled")] 
	/**
	 *  Name of the class to use as the skin for the up arrow button of the scroll bar  *  when it is disabled.  *  *  If you change the skin, either graphically or programmatically,  *  you should ensure that the new skin is the same height  *  (for horizontal ScrollBars) or width (for vertical ScrollBars) as the track. *   *  @default mx.skins.halo.ScrollArrowSkin
	 */
	[Style(name="upArrowDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the up arrow button of the scroll bar  *  when you click the arrow button.  *  *  If you change the skin, either graphically or programmatically,  *  you should ensure that the new skin is the same height  *  (for horizontal ScrollBars) or width (for vertical ScrollBars) as the track. *   *  @default mx.skins.halo.ScrollArrowSkin
	 */
	[Style(name="upArrowDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the up arrow button of the scroll bar  *  when the mouse pointer is over the arrow button. *   *  If you change the skin, either graphically or programmatically,  *  you should ensure that the new skin is the same height  *  (for horizontal ScrollBars) or width (for vertical ScrollBars) as the track. *   *  @default mx.skins.halo.ScrollArrowSkin
	 */
	[Style(name="upArrowOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the up arrow button of the  *  scroll bar.  *   *  If you change the skin, either graphically or programmatically,  *  you should ensure that the new skin is the same height  *  (for horizontal ScrollBars) or width (for vertical ScrollBars) as the track. *     *  @default mx.skins.halo.ScrollArrowSkin
	 */
	[Style(name="upArrowUpSkin", type="Class", inherit="no")] 

	/**
	 *  The ScrollBar class is the base class for the HScrollBar and VScrollBar *  controls. *  A ScrollBar consists of two arrow buttons, a track between them, *  and a variable-size scroll thumb. The scroll thumb can move by  *  clicking on either of the two arrow buttons, dragging the scroll thumb *  along the track, or clicking on the track.  * *  <p>The width of a scroll bar is equal to the largest width of its subcomponents  *  (up arrow, down arrow, thumb, and track).  *  Every subcomponent is centered in the scroll bar.</p> * *  @mxml * *  <p>The <code>&lt;mx:ScrollBar&gt;</code> tag inherits all of the tag attributes *  of its superclass, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:ScrollBar *    <strong>Properties</strong> *    direction="vertical|horizontal" *    lineScrollSize="1" *    maxScrollPosition="0" *    minScrollPosition="0" *    pageScrollSize="<i>Reset to the pageSize parameter of setScrollProperties</i>" *    pageSize="0" *    scrollPosition="0" *  *    <strong>Styles</strong> *    borderColor="0xB7BABC"  *    cornerRadius="0"  *    disabledIconColor="0x999999" *    downArrowDisabledSkin="mx.skins.halo.ScrollArrowSkin" *    downArrowDownSkin="mx.skins.halo.ScrollArrowSkin" *    downArrowOverSkin="mx.skins.halo.ScrollArrowSkin" *    downArrowUpSkin="mx.skins.halo.ScrollArrowSkin" *    fillAlphas="[0.6, 0.4]"  *    fillColors="[0xFFFFFF, 0xCCCCCC]"  *    highlightAlphas="[0.3, 0.0]"  *    iconColor="0x111111" *    thumbDownSkin="mx.skins.halo.ScrollThumbSkin" *    thumbIcon="undefined" *    thumbOffset="0" *    thumbOverSkin="mx.skins.halo.ScrollThumbSkin" *    thumbUpSkin="mx.skins.halo.ScrollThumbSkin" *    trackColors="[0x94999b, 0xe7e7e7]" *    trackSkin="mx.skins.halo.ScrollTrackSkin" *    upArrowDisabledSkin="mx.skins.halo.ScrollArrowSkin" *    upArrowDownSkin="mx.skins.halo.ScrollArrowSkin" *    upArrowOverSkin="mx.skins.halo.ScrollArrowSkin" *    upArrowUpSkin="mx.skins.halo.ScrollArrowSkin" *  /&gt; *  </pre> * *  @see mx.controls.HScrollBar *  @see mx.controls.VScrollBar *  @see mx.controls.Button *  @see mx.controls.scrollClasses.ScrollThumb *
	 */
	public class ScrollBar extends UIComponent
	{
		/**
		 *  The width of a vertical scrollbar, or the height of a horizontal     *  scrollbar, in pixels.
		 */
		public static const THICKNESS : Number = 16;
		/**
		 *  @private     *  The up arrow button.
		 */
		local var upArrow : Button;
		/**
		 *  @private     *  The down arrow button.
		 */
		local var downArrow : Button;
		/**
		 *  @private     *  The scroll track
		 */
		local var scrollTrack : Button;
		/**
		 *  @private     *  The scroll thumb
		 */
		local var scrollThumb : ScrollThumb;
		/**
		 *  @private     *  Used to keep track of minimums because of the orientation change.
		 */
		local var _minWidth : Number;
		/**
		 *  @private
		 */
		local var _minHeight : Number;
		/**
		 *  @private     *  true if servicing a scroll event.
		 */
		local var isScrolling : Boolean;
		/**
		 *  @private     *  Timer used to autoscroll when holding the mouse down on the track.
		 */
		private var trackScrollTimer : Timer;
		/**
		 *  @private     *  The direction we're going when in track scroll repeat.
		 */
		private var trackScrollRepeatDirection : int;
		/**
		 *  @private     *  The direction we're going when in track scroll repeat.
		 */
		private var trackScrolling : Boolean;
		/**
		 *  @private     *  Where the mouse is on the track.
		 */
		private var trackPosition : Number;
		/**
		 *  @private     *  Old position, used to compute deltas when button presses are auto     *  repeated
		 */
		local var oldPosition : Number;
		/**
		 *  @private     *  Storage for the direction property.
		 */
		private var _direction : String;
		/**
		 *  @private     *  Storage for the lineScrollSize property.
		 */
		private var _lineScrollSize : Number;
		/**
		 *  @private     *  Storage for the maxScrollPosition property.
		 */
		private var _maxScrollPosition : Number;
		/**
		 *  @private     *  Storage for the minScrollPosition property.
		 */
		private var _minScrollPosition : Number;
		/**
		 *  @private     *  Storage for the pageSize property.
		 */
		private var _pageSize : Number;
		/**
		 *  @private     *  Storage for the pageScrollSize property.l
		 */
		private var _pageScrollSize : Number;
		/**
		 *  @private     *  Storage for the scrollPosition property.
		 */
		private var _scrollPosition : Number;

		/**
		 *  @private     *  Scrollbars cannot be doubleClickEnabled.     *  It messes up fast clicking on its buttons.
		 */
		public function set doubleClickEnabled (value:Boolean) : void;
		/**
		 *  @private     *  Turn off buttons, or turn on buttons and resync thumb.
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  Specifies whether the ScrollBar is for horizontal or vertical scrolling.     *  Valid values in MXML are <code>"vertical"</code> and <code>"horizontal"</code>.     *     *  <p>In ActionScript, you use the following constants     *  to set this property:     *  <code>ScrollBarDirection.VERTICAL</code> and     *  <code>ScrollBarDirection.HORIZONTAL</code>.</p>     *     *  @default ScrollBarDirection.VERTICAL     *     *  @see mx.controls.scrollClasses.ScrollBarDirection
		 */
		public function get direction () : String;
		/**
		 *  @private
		 */
		public function set direction (value:String) : void;
		/**
		 *  Set of styles to pass from the ScrollBar to the down arrow.     *  @see mx.styles.StyleProxy
		 */
		protected function get downArrowStyleFilters () : Object;
		/**
		 *  @private     *  String used to set the detail property of a ScrollEvent.
		 */
		function get lineMinusDetail () : String;
		/**
		 *  @private     *  String used to set the detail property of a ScrollEvent.
		 */
		function get linePlusDetail () : String;
		/**
		 *  Amount to scroll when an arrow button is pressed, in pixels.     *     *  @default 1
		 */
		public function get lineScrollSize () : Number;
		/**
		 *  @private
		 */
		public function set lineScrollSize (value:Number) : void;
		/**
		 *  @private     *  String used to set the detail property of a ScrollEvent.
		 */
		private function get maxDetail () : String;
		/**
		 *  Number which represents the maximum scroll position.     *     *  @default 0
		 */
		public function get maxScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set maxScrollPosition (value:Number) : void;
		/**
		 *  @private     *  String used to set the detail property of a ScrollEvent.
		 */
		private function get minDetail () : String;
		/**
		 *  Number that represents the minimum scroll position.     *     *  @default 0
		 */
		public function get minScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set minScrollPosition (value:Number) : void;
		/**
		 *  @private     *  String used to set the detail property of a ScrollEvent.
		 */
		function get pageMinusDetail () : String;
		/**
		 *  @private     *  String used to set the detail property of a ScrollEvent.     *  Can be <code>ScrollEventDetail.PAGE_RIGHT</code> or     *  <code>ScrollEventDetail.PAGE_DOWN</code>.
		 */
		function get pagePlusDetail () : String;
		/**
		 *  The number of lines equivalent to one page.     *     *  @default 0
		 */
		public function get pageSize () : Number;
		/**
		 *  @private
		 */
		public function set pageSize (value:Number) : void;
		/**
		 *  Amount to move the scroll thumb when the scroll bar      *  track is pressed, in pixels.     *     *  @default 0
		 */
		public function get pageScrollSize () : Number;
		/**
		 *  @private
		 */
		public function set pageScrollSize (value:Number) : void;
		/**
		 *  Number that represents the current scroll position.     *      *  The value is between <code>minScrollPosition</code> and     *  <code>maxScrollPosition</code> inclusively.     *       *  @default 0
		 */
		public function get scrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set scrollPosition (value:Number) : void;
		/**
		 *  Set of styles to pass from the ScrollBar to the thumb.     *  @see mx.styles.StyleProxy
		 */
		protected function get thumbStyleFilters () : Object;
		/**
		 *  @private
		 */
		private function get trackHeight () : Number;
		/**
		 *  @private
		 */
		private function get trackY () : Number;
		/**
		 *  Set of styles to pass from the ScrollBar to the up arrow.     *  @see mx.styles.StyleProxy
		 */
		protected function get upArrowStyleFilters () : Object;
		/**
		 *  @private     *  For internal use only.     *  Used by horizontal bar to deal with rotation.
		 */
		function get virtualHeight () : Number;
		/**
		 *  @private     *  For internal use only.     *  Used by horizontal bar to deal with rotation.
		 */
		function get virtualWidth () : Number;

		/**
		 *  Constructor.
		 */
		public function ScrollBar ();
		/**
		 *  @private     *  Create child objects.
		 */
		protected function createChildren () : void;
		/**
		 *  @private     *  Determine our min width/height based on the up and down     *  arrow sizes.
		 */
		protected function measure () : void;
		/**
		 *  @private     *  Size changed so re-position everything.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Sets the range and viewport size of the ScrollBar control.      *      *  The ScrollBar control updates the state of the arrow buttons and      *  size of the scroll thumb accordingly.     *     *  @param pageSize Number which represents the size of one page.      *     *  @param minScrollPosition Number which represents the bottom of the      *  scrolling range.     *     *  @param maxScrollPosition Number which represents the top of the      *  scrolling range.     *     *  @param pageScrollSize Number which represents the increment to move when      *  the scroll track is pressed.     *
		 */
		public function setScrollProperties (pageSize:Number, minScrollPosition:Number, maxScrollPosition:Number, pageScrollSize:Number = 0) : void;
		/**
		 *  @private
		 */
		function lineScroll (direction:int) : void;
		/**
		 *  @private
		 */
		function pageScroll (direction:int) : void;
		/**
		 *  @private     *  Dispatch a scroll event.
		 */
		function dispatchScrollEvent (oldPosition:Number, detail:String) : void;
		/**
		 *  @private     *  Returns true if it is a scrollbar key.     *  It will execute the equivalent code for that key as well.
		 */
		function isScrollBarKey (key:uint) : Boolean;
		/**
		 *  @private     *  Callback when the up-arrow button is pressed or autorepeated.
		 */
		private function upArrow_buttonDownHandler (event:FlexEvent) : void;
		/**
		 *  @private     *  Callback when the down-arrow button is pressed or autorepeated.
		 */
		private function downArrow_buttonDownHandler (event:FlexEvent) : void;
		/**
		 *  @private     *  Show the over skin of the scrollTrack if there is one.
		 */
		private function scrollTrack_mouseOverHandler (event:MouseEvent) : void;
		/**
		 *  @private     *  Hide the over skin of the scrollTrack.
		 */
		private function scrollTrack_mouseOutHandler (event:MouseEvent) : void;
		/**
		 *  @private     *  Set up the repeating events when pressing on the track.
		 */
		private function scrollTrack_mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private     *  This gets called at certain intervals     *  to repeat the scroll event when pressing the track.
		 */
		private function trackScrollTimerHandler (event:Event) : void;
		/**
		 *  @private     *  Stop repeating events because the track is no longer pressed     *  special case to restore focus when we've released the mouse
		 */
		private function scrollTrack_mouseUpHandler (event:MouseEvent) : void;
		private function scrollTrack_mouseLeaveHandler (event:Event) : void;
		/**
		 *  @private     *  Stop repeating events because the track is no longer pressed     *  special case to restore focus when we've released the mouse
		 */
		private function scrollTrack_mouseMoveHandler (event:MouseEvent) : void;
	}
}
