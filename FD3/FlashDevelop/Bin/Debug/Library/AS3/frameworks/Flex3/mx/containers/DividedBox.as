package mx.containers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import mx.containers.dividedBoxClasses.BoxDivider;
	import mx.core.EdgeMetrics;
	import mx.core.IFlexDisplayObject;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.DividerEvent;
	import mx.managers.CursorManager;
	import mx.managers.CursorManagerPriority;
	import mx.styles.StyleManager;

	/**
	 *  Dispatched multiple times as the user drags any divider.
 *
 *  The <code>dividerDrag</code> event is dispatched
 *  after the <code>dividerPress</code> event
 *  and before the <code>dividerRelease</code> event.
 *
 *  @eventType mx.events.DividerEvent.DIVIDER_DRAG
	 */
	[Event(name="dividerDrag", type="mx.events.DividerEvent")] 

	/**
	 *  Dispatched when the user presses any divider in this container.
 *
 *  The <code>dividerPress</code> event is dispatched
 *  before any <code>dividerDrag</code> events are dispatched.
 *
 *  @eventType mx.events.DividerEvent.DIVIDER_PRESS
	 */
	[Event(name="dividerPress", type="mx.events.DividerEvent")] 

	/**
	 *  Dispatched when the user releases a divider.
 *
 *  The <code>dividerRelease</code> event is dispatched
 *  after the <code>dividerDrag</code> events,
 *  but before the container's children are resized.
 *  The divider's x and y properties are not updated until
 *  after this event is triggered. As a result, a call to
 *  <code>hDividerBox.getDividerAt(0).x</code> will return
 *  the value of the original x position of the first divider. If you want the
 *  position of the divider after the move, you can access it when the
 *  DividerBox's updateComplete event has been triggered.
 *
 *  @eventType mx.events.DividerEvent.DIVIDER_RELEASE
	 */
	[Event(name="dividerRelease", type="mx.events.DividerEvent")] 

	/**
	 *  Thickness in pixels of the area where the user can click to drag a
 *  divider.
 *  This area is centered in the gaps between the container's children,
 *  which are determined by the <code>horizontalGap</code> or
 *  <code>verticalGap</code> style property.
 *  The affordance cannot be set to a value larger than the gap size.
 *  A resize cursor appears when the mouse is over this area.
 *
 *  @default 6
	 */
	[Style(name="dividerAffordance", type="Number", format="Length", inherit="no")] 

	/**
	 *  The alpha value that determines the transparency of the dividers.
 *  A value of <code>0.0</code> means completely transparent
 *  and a value of <code>1.0</code> means completely opaque.
 *
 *  @default 0.75
	 */
	[Style(name="dividerAlpha", type="Number", inherit="no")] 

	/**
	 *  Color of the dividers when the user presses or drags the dividers
 *  if the <code>liveDragging</code> property is set to <code>false</code>.
 *  If the <code>liveDragging</code> property is set to <code>true</code>,
 *  only the divider's knob is shown.
 *
 *  @default 0x6F7777
	 */
	[Style(name="dividerColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The divider skin.
 *
 *  The default value is the "mx.skin.BoxDividerSkin" symbol in the Assets.swf file.
	 */
	[Style(name="dividerSkin", type="Class", inherit="no")] 

	/**
	 *  Thickness in pixels of the dividers when the user presses or drags the
 *  dividers, if the <code>liveDragging</code> property is set to <code>false</code>.
 *  (If the <code>liveDragging</code> property is set to <code>true</code>,
 *  only the divider's knob is shown.)
 *  The visible thickness cannot be set to a value larger than the affordance.
 *
 *  @default 3
	 */
	[Style(name="dividerThickness", type="Number", format="Length", inherit="no")] 

	/**
	 *  The cursor skin for a horizontal DividedBox.
 *
 *  The default value is the "mx.skins.cursor.HBoxDivider" symbol in the Assets.swf file.
	 */
	[Style(name="horizontalDividerCursor", type="Class", inherit="no")] 

	/**
	 *  The cursor skin for a vertical DividedBox.
 *
 *  The default value is the "mx.skins.cursor.VBoxDivider" symbol in the Assets.swf file.
	 */
	[Style(name="verticalDividerCursor", type="Class", inherit="no")] 

	[Exclude(name="focusIn", kind="event")] 

	[Exclude(name="focusOut", kind="event")] 

	[Exclude(name="focusBlendMode", kind="style")] 

	[Exclude(name="focusSkin", kind="style")] 

	[Exclude(name="focusThickness", kind="style")] 

	[Exclude(name="focusInEffect", kind="effect")] 

	[Exclude(name="focusOutEffect", kind="effect")] 

include "../core/Version.as"
	/**
	 *  A DividedBox container measures and lays out its children
 *  horizontally or vertically in exactly the same way as a
 *  Box container, but it inserts
 *  draggable dividers in the gaps between the children.
 *  Users can drag any divider to resize the children on each side.
 *
 *  <p>The DividedBox class is the base class for the more commonly used
 *  HDividedBox and VDividedBox classes.</p>
 *
 *  <p>The <code>direction</code> property of a DividedBox container, inherited
 *  from Box container, determines whether it has horizontal
 *  or vertical layout.</p>
 *
 *  <p>A DividedBox, HDividedBox, or VDividedBox container has the following default sizing characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td><strong>Vertical DividedBox</strong> Height is large enough to hold all of its children at the default or explicit
 *               heights of the children, plus any vertical gap between the children, plus the top and bottom padding of the
 *               container. The width is the default or explicit width of the widest child, plus the left and right padding of
 *               the container.
 *               <br><strong>Horizontal DividedBox</strong> Width is large enough to hold all of its children at the
 *               default or explicit widths of the children, plus any horizontal gap between the children, plus the left and
 *               right padding of the container. Height is the default or explicit height of the tallest child
 *               plus the top and bottom padding of the container.</br></td>
 *        </tr>
 *        <tr>
 *           <td>Default padding</td>
 *           <td>0 pixels for the top, bottom, left, and right values.</td>
 *        </tr>
 *        <tr>
 *           <td>Default gap</td>
 *           <td>10 pixels for the horizontal and vertical gaps.</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:DividedBox&gt;</code> tag inherits all of the tag
 *  attributes of its superclass, and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:DividedBox
 *    <strong>Properties</strong>
 *    liveDragging="false|true"
 *    resizeToContent="false|true"
 *
 *    <strong>Styles</strong>
 *    dividerAffordance="6"
 *    dividerAlpha="0.75"
 *    dividerColor="0x6F7777"
 *    dividerSkin="<i>'mx.skins.BoxDividerSkin' symbol in Assets.swf</i>"
 *    dividerThickness="3"
 *    horizontalDividerCursor="<i>'mx.skins.cursor.HBoxDivider' symbol in Assets.swf</i>"
 *    verticalDividerCursor="<i>'mx.skins.cursor.VBoxDivider' symbol in Assets.swf</i>"
 *
 *    <strong>Events</strong>
 *    dividerPress="<i>No default</i>"
 *    dividerDrag="<i>No default</i>"
 *    dividerRelease="<i>No default</i>"
 *    &gt;
 *      ...
 *      <i>child tags</i>
 *      ...
 *  &lt;/mx:DividedBox&gt;
 *  </pre>
 *
 *  @see mx.containers.HDividedBox
 *  @see mx.containers.VDividedBox
 *
 *  @includeExample examples/DividedBoxExample.mxml
	 */
	public class DividedBox extends Box
	{
		/**
		 *  @private
		 */
		private static const PROXY_DIVIDER_INDEX : int = 999;
		/**
		 *  @private
		 */
		private static var classInitialized : Boolean;
		/**
		 *  @private
     *  Container for holding divider objects.
		 */
		private var dividerLayer : UIComponent;
		/**
		 *  @private
		 */
		var activeDivider : BoxDivider;
		/**
		 *  @private
		 */
		private var activeDividerIndex : int;
		/**
		 *  @private
		 */
		private var activeDividerStartPosition : Number;
		/**
		 *  @private
		 */
		private var dragStartPosition : Number;
		/**
		 *  @private
		 */
		private var dragDelta : Number;
		/**
		 *  @private
		 */
		private var oldChildSizes : Array;
		/**
		 *  @private
		 */
		private var minDelta : Number;
		/**
		 *  @private
		 */
		private var maxDelta : Number;
		/**
		 *  @private
     *  Only allow a single divider to move at a time.
		 */
		private var dontCoalesceDividers : Boolean;
		/**
		 *  @private
		 */
		private var cursorID : int;
		/**
		 *  @private
     *  We'll measure ourselves once and then store the results here
     *  for the lifetime of the DividedBox.
		 */
		private var dbMinWidth : Number;
		private var dbMinHeight : Number;
		private var dbPreferredWidth : Number;
		private var dbPreferredHeight : Number;
		/**
		 *  @private
		 */
		private var layoutStyleChanged : Boolean;
		/**
		 *  @private
		 */
		private var _resizeToContent : Boolean;
		/**
		 *  @private
     *  Number of children with their includeInLayout set to true.  The rest of
     *  the children don't count.
		 */
		private var numLayoutChildren : int;
		/**
		 *  The class for the divider between the children.
     *
     *  @default mx.containers.dividedBoxClasses.BoxDivider
		 */
		protected var dividerClass : Class;
		/**
		 *  If <code>true</code>, the children adjacent to a divider
     *  are continuously resized while the user drags it.
     *  If <code>false</code>, they are not resized
     *  until the user releases the divider.
     *  @default false
		 */
		public var liveDragging : Boolean;
		/**
		 *  @private
     *  During preLayoutAdjustment, we make some changes to the children's
     *  widths and heights.  We keep track of the original values in postLayoutChanges
     *  so we can later go back and reset them so another layout pass is working 
     *  with the correct values rather than these modified values.
		 */
		private var postLayoutChanges : Array;

		/**
		 *  @private
		 */
		public function set direction (value:String) : void;

		/**
		 *  The number of dividers.
     *  The count is always <code>numChildren</code> - 1.
     *
     *  @return The number of dividers.
		 */
		public function get numDividers () : int;

		/**
		 *  If <code>true</code>, the DividedBox automatically resizes to the size
     *  of its children.
     *  @default false
		 */
		public function get resizeToContent () : Boolean;
		/**
		 *  @private
		 */
		public function set resizeToContent (value:Boolean) : void;

		/**
		 *  @private
     *  This method gets called once at first instance construction
     *  rather than during class initialization.
     *  In order for calls to StyleManager methods to work,
     *  the factory class for the application or module
     *  must have already registered StyleManagerImpl with Singleton.
     *  This may not be the case at class initialization time.
		 */
		private static function initializeClass () : void;

		/**
		 *  Constructor.
		 */
		public function DividedBox ();

		/**
		 *  @private
     *  Override of the measure method of Box.
     *
     *  <p>This function is almost identical to the Box version except
     *  that more extensive testing of the min, max
     *  boundary conditions is performed. This is because the DividedBox allows
     *  default values to be less than the min value of a control.</p>
		 */
		protected function measure () : void;

		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		protected function scrollChildren () : void;

		/**
		 *  Returns a reference to the specified BoxDivider object
     *  in this DividedBox container.
     *
     *  @param i Zero-based index of a divider, counting from
     *  the left for a horizontal DividedBox,
     *  or from the top for a vertical DividedBox.
     *
     *  @return A BoxDivider object.
		 */
		public function getDividerAt (i:int) : BoxDivider;

		/**
		 *  Move a specific divider a given number of pixels.
     *
     *  @param i Zero-based index of a divider, counting from
     *  the left for a horizontal DividedBox,
     *  or from the top for a vertical DividedBox.
     *
     *  @param amt The number of pixels to move the divider.
     *  A negative number can be specified in order to move
     *  a divider up or left. The divider movement is
     *  constrained in the same manner as if a user
     *  had moved it.
		 */
		public function moveDivider (i:int, amt:Number) : void;

		/**
		 *  @private
		 */
		private function createDivider (i:int) : BoxDivider;

		/**
		 *  @private
		 */
		private function layoutDivider (i:int, unscaledWidth:Number, unscaledHeight:Number, prevChild:IUIComponent, nextChild:IUIComponent) : void;

		/**
		 *  @private
		 */
		function changeCursor (divider:BoxDivider) : void;

		/**
		 *  @private
		 */
		function restoreCursor () : void;

		/**
		 *  @private
		 */
		function getDividerIndex (divider:BoxDivider) : int;

		/**
		 *  @private
		 */
		private function getMousePosition (event:MouseEvent) : Number;

		/**
		 *  @private
		 */
		function startDividerDrag (divider:BoxDivider, trigger:MouseEvent) : void;

		/**
		 *  @private
     *  Store away some important information about
     *  each child for us to use while we move the divider.
		 */
		private function cacheSizes () : void;

		/**
		 *  @private
		 */
		private function cacheChildSizes () : void;

		/**
		 *  @private
		 */
		private function mouseMoveHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *
     *  @param trigger May be null if the event is not a MouseEvent but
     *  a mouse event from another sandbox.
		 */
		function stopDividerDrag (divider:BoxDivider, trigger:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function resetDividerTracking () : void;

		/**
		 *  @private
     *  Determine the maximum amount of movement that
     *  a divider, i, can move both up and down.
     *
     *  We base this calculation on the amount of
     *  travel that each divider supports, assuming
     *  that as one divider reaches its limits, the next
     *  divider will move.  In this way dividers will
     *  cascade.
		 */
		private function computeAllowableMovement (at:int) : void;

		/**
		 *  @private
		 */
		private function computeMinAndMaxDelta () : void;

		/**
		 *  @private
		 */
		private function limitDelta (delta:Number) : Number;

		/**
		 *  @private
     *  We distribute the delta space in the same
     *  fashion that we calculated it. That is we
     *  start at the divider and give out space
     *  until we hit a limit on the component or
     *  we run out of space to distribute.
     *  We need to do this in both directions since
     *  in one direction we are shrinking and
     *  in the other we are growing.
		 */
		private function distributeDelta () : void;

		/**
		 *  @private
     *  For 1.5 we normalize all children to the smallest one
     *  So that we can remove n-1 children and still guarantee
     *  one child can consume 100%.
     *  Also we support the concept of fixed sized children,
     *  which allows us to have one or more children be rigid
     *  in the DividedBox in this case, the dividers above
     *  and below the fixed component move in unison.
		 */
		private function adjustChildSizes () : void;

		/**
		 *  @private
     *  Algorithm employed pre-layout to ensure that
     *  we don't leave any dangling space and to ensure
     *  that only explicit min/max values are honored.
     *
     *  We first compute the sum of %'s across all
     *  children to ensure that we have at least 100%.
     *  If so, we are done.  If not, then we attempt
     *  to attach the remaining amount to the last
     *  component, if not, then we distribute the
     *  percentages evenly across all % components.
     *
		 */
		private function preLayoutAdjustment () : void;

		/**
		 *  @private
     *  Post layout work.  In preLayoutAdjustment() 
     *  sometimes we set a child's percentWidth/percentHeight.  
     *  postLayoutAdjustment() will reset the child's width or height
     *  back to what it was.
		 */
		private function postLayoutAdjustment () : void;

		/**
		 *  @private
		 */
		private function childAddHandler (event:ChildExistenceChangedEvent) : void;

		/**
		 *  @private
		 */
		private function childRemoveHandler (event:ChildExistenceChangedEvent) : void;

		/**
		 *  @private
     *  When a child's includeInLayout changes, we either remove or add a
     *  divider.
		 */
		private function child_includeInLayoutChangedHandler (event:Event) : void;
	}
	/**
	 *  @private
	 */
	private class ChildSizeInfo
	{
		/**
		 *  @private
		 */
		public var deltaMin : Number;
		/**
		 *  @private
		 */
		public var deltaMax : Number;
		/**
		 *  @private
		 */
		public var min : Number;
		/**
		 *  @private
		 */
		public var max : Number;
		/**
		 *  @private
		 */
		public var size : Number;

		/**
		 *  @private
		 */
		public function ChildSizeInfo (size:Number, min:Number = 0, max:Number = 0, deltaMin:Number = 0, deltaMax:Number = 0);
	}
}
