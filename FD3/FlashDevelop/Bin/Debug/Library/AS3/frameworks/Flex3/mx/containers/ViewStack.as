package mx.containers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import mx.automation.IAutomationObject;
	import mx.core.Container;
	import mx.core.ContainerCreationPolicy;
	import mx.core.EdgeMetrics;
	import mx.managers.IHistoryManagerClient;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.effects.Effect;
	import mx.effects.EffectManager;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.graphics.RoundedRectangle;
	import mx.managers.HistoryManager;

	/**
	 *  Dispatched when the selected child container changes.
 *
 *  @eventType mx.events.IndexChangedEvent.CHANGE
	 */
	[Event(name="change", type="mx.events.IndexChangedEvent")] 

include "../styles/metadata/GapStyles.as"
	/**
	 *  Number of pixels between the container's bottom border and its content area.
 *  The default value is 0.
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the container's top border and its content area.
 *  The default value is 0.
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	[Exclude(name="autoLayout", kind="property")] 

	[Exclude(name="defaultButton", kind="property")] 

	[Exclude(name="horizontalLineScrollSize", kind="property")] 

	[Exclude(name="horizontalPageScrollSize", kind="property")] 

	[Exclude(name="horizontalScrollBar", kind="property")] 

	[Exclude(name="horizontalScrollPolicy", kind="property")] 

	[Exclude(name="horizontalScrollPosition", kind="property")] 

	[Exclude(name="maxHorizontalScrollPosition", kind="property")] 

	[Exclude(name="maxVerticalScrollPosition", kind="property")] 

	[Exclude(name="verticalLineScrollSize", kind="property")] 

	[Exclude(name="verticalPageScrollSize", kind="property")] 

	[Exclude(name="verticalScrollBar", kind="property")] 

	[Exclude(name="verticalScrollPolicy", kind="property")] 

	[Exclude(name="verticalScrollPosition", kind="property")] 

	[Exclude(name="focusIn", kind="event")] 

	[Exclude(name="focusOut", kind="event")] 

	[Exclude(name="scroll", kind="event")] 

	[Exclude(name="focusBlendMode", kind="style")] 

	[Exclude(name="focusSkin", kind="style")] 

	[Exclude(name="focusThickness", kind="style")] 

	[Exclude(name="horizontalScrollBarStyleName", kind="style")] 

	[Exclude(name="verticalScrollBarStyleName", kind="style")] 

	[Exclude(name="focusInEffect", kind="effect")] 

	[Exclude(name="focusOutEffect", kind="effect")] 

include "../core/Version.as"
	/**
	 *  A ViewStack navigator container consists of a collection of child
 *  containers stacked on top of each other, where only one child
 *  at a time is visible.
 *  When a different child container is selected, it seems to replace
 *  the old one because it appears in the same location.
 *  However, the old child container still exists; it is just invisible.
 *
 *  <p>A ViewStack container does not provide a user interface
 *  for selecting which child container is currently visible.
 *  Typically, you set its <code>selectedIndex</code> or
 *  <code>selectedChild</code> property in ActionScript in response to
 *  some user action. Alternately, you can associate a LinkBar, TabBar or ToggleButtonBar
 *  container with a ViewStack container to provide a navigation interface.
 *  To do so, specify the ViewStack container as the value of the
 *  <code>dataProvider</code> property of the LinkBar, TabBar or
 *  ToggleButtonBar container.</p>
 *
 *  <p>You might decide to use a more complex navigator container than the
 *  ViewStack container, such as a TabNavigator container or Accordion
 *  container. In addition to having a collection of child containers,
 *  these containers provide their own user interface controls
 *  for navigating between their children.</p>
 *
 *  <p>When you change the currently visible child container, 
 *  you can use the <code>hideEffect</code> property of the container being
 *  hidden and the <code>showEffect</code> property of the newly visible child
 *  container to apply an effect to the child containers.
 *  The ViewStack container waits for the <code>hideEffect</code> of the child
 *  container being hidden  to complete before it reveals the new child
 *  container. 
 *  You can interrupt a currently playing effect if you change the 
 *  <code>selectedIndex</code> property of the ViewStack container 
 *  while an effect is playing.</p>
 *
 *  <p>The ViewStack container has the following default sizing characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>The width and height of the initial active child.</td>
 *        </tr>
 *        <tr>
 *           <td>Container resizing rules</td>
 *           <td>By default, ViewStack containers are sized only once to fit the size of the 
 *               first child container. They do not resize when you navigate to other child 
 *               containers. To force ViewStack containers to resize when you navigate 
 *               to a different child container, set the resizeToContent property to true.</td>
 *        </tr>
 *        <tr>
 *           <td>Child sizing rules</td>
 *           <td>Children are sized to their default size. If the child is larger than the ViewStack 
 *               container, it is clipped. If the child is smaller than the ViewStack container, 
 *               it is aligned to the upper-left corner of the ViewStack container.</td>
 *        </tr>
 *        <tr>
 *           <td>Default padding</td>
 *           <td>0 pixels for top, bottom, left, and right values.</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:ViewStack&gt;</code> tag inherits the
 *  tag attributes of its superclass, with the exception of scrolling-related
 *  attributes, and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:ViewStack
 *    <b>Properties</b>
 *    historyManagementEnabled="false|true"
 *    resizeToContent="false|true"
 *    selectedIndex="0"
 *    
 *    <b>Styles</b>
 *    horizontalGap="8"
 *    paddingBottom="0"
 *    paddingTop="0"
 *    verticalGap="6"
 *    
 *    <b>Events</b>
 *    change="<i>No default</i>"
 *    &gt;
 *      ...
 *      <i>child tags</i>
 *      ...
 *  &lt;/mx:ViewStack&gt;
 *  </pre>
 *
 *  @includeExample examples/ViewStackExample.mxml
 *
 *  @see mx.controls.LinkBar
 *  @see mx.managers.HistoryManager
 *  @see mx.managers.LayoutManager
	 */
	public class ViewStack extends Container implements IHistoryManagerClient
	{
		/**
		 *  @private
		 */
		private var needToInstantiateSelectedChild : Boolean;
		/**
		 *  @private
     *  This flag gets set when selectedIndex is set.
     *  Later, when measure()
     *  is called, it causes the HistoryManager to save the state.
		 */
		private var bSaveState : Boolean;
		/**
		 *  @private
     *  This flag gets set by loadState().
     *  It prevents the newly restored state from being saved.
		 */
		private var bInLoadState : Boolean;
		/**
		 *  @private
     *  True until commitProperties has been called at least once.
		 */
		private var firstTime : Boolean;
		/**
		 *  @private
     *  We'll measure ourselves once and then store the results here
     *  for the lifetime of the ViewStack
		 */
		var vsMinWidth : Number;
		var vsMinHeight : Number;
		var vsPreferredWidth : Number;
		var vsPreferredHeight : Number;
		/**
		 *  @private
     *  Remember which child has an overlay mask, if any.
		 */
		private var overlayChild : Container;
		/**
		 *  @private
     *  Keep track of the overlay's targetArea
		 */
		private var overlayTargetArea : RoundedRectangle;
		/**
		 *  @private
     *  Store the last selectedIndex
		 */
		private var lastIndex : int;
		/**
		 *  @private
     *  Whether a change event has to be dispatched in commitProperties()
		 */
		private var dispatchChangeEventPending : Boolean;
		/**
		 *  @private
     *  Storage for the historyManagementEnabled property.
		 */
		var _historyManagementEnabled : Boolean;
		/**
		 *  @private
		 */
		private var historyManagementEnabledChanged : Boolean;
		/**
		 *  @private
     *  Storage for the resizeToContent property.
		 */
		private var _resizeToContent : Boolean;
		/**
		 *  @private
     *  Storage for the selectedIndex property.
		 */
		private var _selectedIndex : int;
		/**
		 *  @private
		 */
		private var proposedSelectedIndex : int;
		/**
		 *  @private
		 */
		private var initialSelectedIndex : int;

		/**
		 *  @private
     *  autoLayout is always true for ViewStack.
		 */
		public function get autoLayout () : Boolean;
		/**
		 *  @private
     *  autoLayout is always true for ViewStack
     *  and can't be changed by this setter.
     *
     *  We can probably find a way to make autoLayout work with Accordion
     *  and ViewStack, but right now there are problems if deferred
     *  instantiation runs at the same time as an effect. (Bug 79174)
		 */
		public function set autoLayout (value:Boolean) : void;

		/**
		 *  @private
     *  horizontalScrollPolicy is always OFF for ViewStack.
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
     *  horizontalScrollPolicy is always OFF for ViewStack
     *  and can't be changed by this setter.
		 */
		public function set horizontalScrollPolicy (value:String) : void;

		/**
		 *  @private
     *  verticalScrollPolicy is always OFF for ViewStack.
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
     *  verticalScrollPolicy is always OFF for ViewStack
     *  and can't be changed by this setter.
		 */
		public function set verticalScrollPolicy (value:String) : void;

		/**
		 *  The height of the area, in pixels, in which content is displayed.
     *  You can override this getter if your content
     *  does not occupy the entire area of the ViewStack container.
		 */
		protected function get contentHeight () : Number;

		/**
		 *  The width of the area, in pixels, in which content is displayed.
     *  You can override this getter if your content
     *  does not occupy the entire area of the ViewStack container.
		 */
		protected function get contentWidth () : Number;

		/**
		 *  The x coordinate of the area of the ViewStack container
     *  in which content is displayed, in pixels.
     *  The default value is equal to the value of the
     *  <code>paddingLeft</code> style property,
     *  which has a default value of 0.
     *
     *  Override the <code>get()</code> method if you do not want
     *  your content to start layout at x = 0.
		 */
		protected function get contentX () : Number;

		/**
		 *  The y coordinate of the area of the ViewStack container
     *  in which content is displayed, in pixels.
     *  The default value is equal to the value of the
     *  <code>paddingTop</code> style property,
     *  which has a default value of 0.
     *
     *  Override the <code>get()</code> method if you do not want
     *  your content to start layout at y = 0.
		 */
		protected function get contentY () : Number;

		/**
		 *  If <code>true</code>, enables history management
     *  within this ViewStack container.
     *  As the user navigates from one child to another,
     *  the browser remembers which children were visited.
     *  The user can then click the browser's Back and Forward buttons
     *  to move through this navigation history.
     *
     *  @default false
     *
     *  @see mx.managers.HistoryManager
		 */
		public function get historyManagementEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set historyManagementEnabled (value:Boolean) : void;

		/**
		 *  If <code>true</code>, the ViewStack container automatically
     *  resizes to the size of its current child.
     *
     *  @default false
		 */
		public function get resizeToContent () : Boolean;
		/**
		 *  @private
		 */
		public function set resizeToContent (value:Boolean) : void;

		/**
		 *  A reference to the currently visible child container.
     *  The default is a reference to the first child.
     *  If there are no children, this property is <code>null</code>.
     * 
     *  <p><strong>Note:</strong> You can only set this property in an
     *  ActionScript statement, not in MXML.</p>
		 */
		public function get selectedChild () : Container;
		/**
		 *  @private
		 */
		public function set selectedChild (value:Container) : void;

		/**
		 *  The zero-based index of the currently visible child container.
     *  Child indexes are in the range 0, 1, 2, ..., n - 1,
     *  where <i>n</i> is the number of children.
     *  The default value is 0, corresponding to the first child.
     *  If there are no children, the value of this property is <code>-1</code>.
     * 
     *  <p><strong>Note:</strong> When you add a new child to a ViewStack 
     *  container, the <code>selectedIndex</code> property is automatically 
     *  adjusted, if necessary, so that the selected child remains selected.</p>
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;

		/**
		 *  Constructor.
		 */
		public function ViewStack ();

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  Calculates the default sizes and minimum and maximum values of the
     *  ViewStack container.
     *  For more information about the <code>measure()</code> method,
     *  see the <code>UIComponent.measure()</code> method.
     *
     *  <p>The default size of a ViewStack container is the default size
     *  of its currently selected child, plus the padding and borders.
     *  If the ViewStack container has no children, its default size
     *  is just large enough for its padding and borders.</p>
     *
     *  <p>The minimum size of a ViewStack container is the minimum size
     *  of its currently selected child, plus the padding and borders.
     *  If the ViewStack container has no children, its minimum size
     *  is just large enough for its padding and borders.</p>
     *
     *  <p>This method does not change the maximum size of a ViewStack
     *  container - it remains unbounded.</p>
     * 
     *  @see mx.core.UIComponent#measure()
		 */
		protected function measure () : void;

		/**
		 *  Responds to size changes by setting the positions and sizes
     *  of this container's children.
     *  For more information about the <code>updateDisplayList()</code> method,
     *  see the <code>UIComponent.updateDisplayList()</code> method.
     *
     *  <p>Only one of its children is visible at a time, therefore,
     *  a ViewStack container positions and sizes only that child.</p>
     *
     *  <p>The selected child is positioned in the ViewStack container's
     *  upper-left corner, and allows for the ViewStack container's
     *  padding and borders. </p>
     *
     *  <p>If the selected child has a percentage <code>width</code> or
     *  <code>height</code> value, it is resized in that direction
     *  to fill the specified percentage of the ViewStack container's
     *  content area (i.e., the region inside its padding).</p>
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
     * 
     *  @see mx.core.UIComponent#updateDisplayList()
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
     *  When asked to create an overlay mask, create it on the selected child
     *  instead. That way, the chrome around the edge of the ViewStack
     *  (e.g. the tabs in a TabNavigator) is not occluded by the overlay mask
     *  (Bug 99029)
		 */
		function addOverlay (color:uint, targetArea:RoundedRectangle = null) : void;

		/**
		 *  @private
		 */
		function removeOverlay () : void;

		/**
		 *  @private
		 */
		function setActualCreationPolicies (policy:String) : void;

		/**
		 *  @private
		 */
		public function createComponentsFromDescriptors (recurse:Boolean = true) : void;

		/**
		 *  @copy mx.managers.IHistoryManagerClient#saveState()
		 */
		public function saveState () : Object;

		/**
		 *  @copy mx.managers.IHistoryManagerClient#loadState()
		 */
		public function loadState (state:Object) : void;

		/**
		 *  Commits the selected index. This function is called during the commit 
     *  properties phase when the selectedIndex (or selectedItem) property
     *  has changed.
		 */
		protected function commitSelectedIndex (newIndex:int) : void;

		private function hideEffectEndHandler (event:EffectEvent) : void;

		/**
		 *  @private
		 */
		private function instantiateSelectedChild () : void;

		/**
		 *  @private
		 */
		private function dispatchChangeEvent (oldIndex:int, newIndex:int) : void;

		/**
		 *  @private
     *  Handles "addedToStage" event
		 */
		private function addedToStageHandler (event:Event) : void;

		/**
		 *  @private
     *  Handles "removedFromStage" event
		 */
		private function removedFromStageHandler (event:Event) : void;

		/**
		 *  @private
     *  Called when we are running a Dissolve effect
     *  and the initialize event has been dispatched
     *  or the children already exist
		 */
		private function initializeHandler (event:FlexEvent) : void;

		/**
		 *  @private
     *  Handles when the new selectedChild has finished being created.
		 */
		private function childCreationCompleteHandler (event:FlexEvent) : void;

		/**
		 *  @private
		 */
		private function childAddHandler (event:ChildExistenceChangedEvent) : void;

		/**
		 *  @private
     *  When a child is removed, adjust the selectedIndex such that the current
     *  child remains selected; or if the current child was removed, then the
     *  next (or previous) child gets automatically selected; when the last
     *  remaining child is removed, the selectedIndex is set to -1.
		 */
		private function childRemoveHandler (event:ChildExistenceChangedEvent) : void;
	}
}
