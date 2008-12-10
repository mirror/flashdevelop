package mx.containers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import mx.automation.IAutomationObject;
	import mx.containers.accordionClasses.AccordionHeader;
	import mx.controls.Button;
	import mx.core.ClassFactory;
	import mx.core.ComponentDescriptor;
	import mx.core.Container;
	import mx.core.ContainerCreationPolicy;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.IHistoryManagerClient;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.effects.Effect;
	import mx.effects.Tween;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.graphics.RoundedRectangle;
	import mx.managers.HistoryManager;
	import mx.styles.StyleManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when the selected child container changes. * *  @eventType mx.events.IndexChangedEvent.CHANGE *  @helpid 3012 *  @tiptext change event
	 */
	[Event(name="change", type="mx.events.IndexChangedEvent")] 
	/**
	 *  Specifies the alpha transparency values used for the background fill of components. *  You should set this to an Array of either two or four numbers. *  Elements 0 and 1 specify the start and end values for *  an alpha gradient. *  If elements 2 and 3 exist, they are used instead of elements 0 and 1 *  when the component is in a mouse-over state. *  The global default value is <code>[ 0.60, 0.40, 0.75, 0.65 ]</code>. *  Some components, such as the ApplicationControlBar container, *  have a different default value. For the ApplicationControlBar container,  *  the default value is <code>[ 0.0, 0.0 ]</code>.
	 */
	[Style(name="fillAlphas", type="Array", arrayType="Number", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Specifies the colors used to tint the background fill of the component. *  You should set this to an Array of either two or four uint values *  that specify RGB colors. *  Elements 0 and 1 specify the start and end values for *  a color gradient. *  If elements 2 and 3 exist, they are used instead of elements 0 and 1 *  when the component is in a mouse-over state. *  For a flat-looking control, set the same color for elements 0 and 1 *  and for elements 2 and 3, *  The default value is *  <code>[ 0xFFFFFF, 0xCCCCCC, 0xFFFFFF, 0xEEEEEE ]</code>. *  <p>Some components, such as the ApplicationControlBar container, *  have a different default value. For the ApplicationControlBar container,  *  the default value is <code>[ 0xFFFFFF, 0xFFFFFF ]</code>.</p>
	 */
	[Style(name="fillColors", type="Array", arrayType="uint", format="Color", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Specifies the alpha transparency value of the focus skin. *   *  @default 0.4
	 */
	[Style(name="focusAlpha", type="Number", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Specifies which corners of the focus rectangle should be rounded. *  This value is a space-separated String that can contain any *  combination of <code>"tl"</code>, <code>"tr"</code>, <code>"bl"</code> *  and <code>"br"</code>. *  For example, to specify that the right side corners should be rounded, *  but the left side corners should be square, use <code>"tr br"</code>. *  The <code>cornerRadius</code> style property specifies *  the radius of the rounded corners. *  The default value depends on the component class; if not overridden for *  the class, default value is <code>"tl tr bl br"</code>. *
	 */
	[Style(name="focusRoundedCorners", type="String", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Skin used to draw the focus rectangle. * *  @default mx.skins.halo.HaloFocusRect
	 */
	[Style(name="focusSkin", type="Class", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Thickness, in pixels, of the focus rectangle outline. * *  @default 2
	 */
	[Style(name="focusThickness", type="Number", format="Length", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Name of the CSS style declaration that specifies styles for the accordion *  headers (tabs). *  *  <p>You can use this class selector to set the values of all the style properties  *  of the AccordionHeader class, including <code>fillAlphas</code>, <code>fillColors</code>,  *  <code>focusAlpha</code>, <code>focusRounderCorners</code>,  *  <code>focusSkin</code>, <code>focusThickness</code>, and <code>selectedFillColors</code>.</p>
	 */
	[Style(name="headerStyleName", type="String", inherit="no")] 
	/**
	 *  Number of pixels between children in the horizontal direction. *  The default value is 8.
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Height of each accordion header, in pixels. *  The default value is automatically calculated based on the font styles for *  the header.
	 */
	[Style(name="headerHeight", type="Number", format="Length", inherit="no")] 
	/**
	 *  Duration, in milliseconds, of the animation from one child to another. *  The default value is 250.
	 */
	[Style(name="openDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  Tweening function used by the animation from one child to another.
	 */
	[Style(name="openEasingFunction", type="Function", inherit="no")] 
	/**
	 *  Number of pixels between the container's bottom border and its content area. *  The default value is -1, so the bottom border of the last header *  overlaps the Accordion container's bottom border.
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the container's top border and its content area. *  The default value is -1, so the top border of the first header *  overlaps the Accordion container's top border.
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 
	/**
	 *  The two colors used to tint the background of the component *  when in its selected state. *  Pass the same color for both values for "flat" looking control. *  The default value is <code>undefined</code>, which means the colors *  are derived from <code>themeColor</code>.
	 */
	[Style(name="selectedFillColors", type="Array", arrayType="uint", format="Color", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Color of header text when rolled over. *  The default value is 0x2B333C.
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Color of selected text. *  The default value is 0x2B333C.
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Number of pixels between children in the vertical direction. *  The default value is -1, so the top and bottom borders *  of adjacent headers overlap.
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  An Accordion navigator container has a collection of child containers, *  but only one of them at a time is visible. *  It creates and manages navigator buttons (accordion headers), which you use *  to navigate between the children. *  There is one navigator button associated with each child container, *  and each navigator button belongs to the Accordion container, not to the child. *  When the user clicks a navigator button, the associated child container *  is displayed. *  The transition to the new child uses an animation to make it clear to *  the user that one child is disappearing and a different one is appearing. * *  <p>The Accordion container does not extend the ViewStack container, *  but it implements all the properties, methods, styles, and events *  of the ViewStack container, such as <code>selectedIndex</code> *  and <code>selectedChild</code>.</p> * *  <p>An Accordion container has the following default sizing characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>The width and height of the currently active child.</td> *        </tr> *        <tr> *           <td>Container resizing rules</td> *           <td>Accordion containers are only sized once to fit the size of the first child container by default.  *               They do not resize when you navigate to other child containers by default.  *               To force Accordion containers to resize when you navigate to a different child container,  *               set the resizeToContent property to true.</td> *        </tr> *        <tr> *           <td>Child sizing rules</td> *           <td>Children are sized to their default size. The child is clipped if it is larger than the Accordion container.  *               If the child is smaller than the Accordion container, it is aligned to the upper-left corner of the  *               Accordion container.</td> *        </tr> *        <tr> *           <td>Default padding</td> *           <td>-1 pixel for the top, bottom, left, and right values.</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:Accordion&gt;</code> tag inherits all of the *  tag attributes of its superclass, with the exception of scrolling-related *  attributes, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:Accordion *    <strong>Properties</strong> *    headerRenderer="<i>IFactory</i>" *    historyManagementEnabled="true|false" *    resizeToContent="false|true" *    selectedIndex="undefined" *   *    <strong>Styles</strong> *    headerHeight="depends on header font styles" *    headerStyleName="<i>No default</i>" *    horizontalGap="8" *    openDuration="250" *    openEasingFunction="undefined" *    paddingBottom="-1" *    paddingTop="-1" *    textRollOverColor="0xB333C" *    textSelectedColor="0xB333C" *    verticalGap="-1" *   *    <strong>Events</strong> *    change="<i>No default</i>" *    &gt; *      ... *      <i>child tags</i> *      ... *  &lt;/mx:Accordion&gt; *  </pre> * *  @includeExample examples/AccordionExample.mxml * *  @see mx.containers.accordionClasses.AccordionHeader * *  @tiptext Accordion allows for navigation between different child views *  @helpid 3013
	 */
	public class Accordion extends Container implements IHistoryManagerClient
	{
		/**
		 *  @private     *  Base for all header names (_header0 - _headerN).
		 */
		private static const HEADER_NAME_BASE : String = "_header";
		/**
		 *  @private     *  Is the accordian currently sliding between views?
		 */
		private var bSliding : Boolean;
		/**
		 *  @private
		 */
		private var initialSelectedIndex : int;
		/**
		 *  @private     *  If true, call HistoryManager.save() when setting currentIndex.
		 */
		private var bSaveState : Boolean;
		/**
		 *  @private
		 */
		private var bInLoadState : Boolean;
		/**
		 *  @private
		 */
		private var firstTime : Boolean;
		/**
		 *  @private
		 */
		private var showFocusIndicator : Boolean;
		/**
		 *  @private     *  Cached tween properties to speed up tweening calculations.
		 */
		private var tweenViewMetrics : EdgeMetrics;
		private var tweenContentWidth : Number;
		private var tweenContentHeight : Number;
		private var tweenOldSelectedIndex : int;
		private var tweenNewSelectedIndex : int;
		private var tween : Tween;
		/**
		 *  @private     *  We'll measure ourselves once and then store the results here     *  for the lifetime of the ViewStack.
		 */
		private var accMinWidth : Number;
		private var accMinHeight : Number;
		private var accPreferredWidth : Number;
		private var accPreferredHeight : Number;
		/**
		 *  @private     *  When a child is added or removed, this flag is set true     *  and it causes a re-measure.
		 */
		private var childAddedOrRemoved : Boolean;
		/**
		 *  @private     *  Remember which child has an overlay mask, if any.
		 */
		private var overlayChild : IUIComponent;
		/**
		 *  @private     *  Keep track of the overlay's targetArea
		 */
		private var overlayTargetArea : RoundedRectangle;
		/**
		 *  @private
		 */
		private var layoutStyleChanged : Boolean;
		/**
		 *  @private
		 */
		private var currentDissolveEffect : Effect;
		/**
		 *  @private
		 */
		private var _focusedIndex : int;
		/**
		 *  @private     *  Storage for the headerRenderer property.
		 */
		private var _headerRenderer : IFactory;
		/**
		 *  @private     *  Storage for historyManagementEnabled property.
		 */
		private var _historyManagementEnabled : Boolean;
		/**
		 *  @private
		 */
		private var historyManagementEnabledChanged : Boolean;
		/**
		 *  @private     *  Storage for the resizeToContent property.
		 */
		private var _resizeToContent : Boolean;
		/**
		 *  @private     *  Storage for the selectedIndex and selectedChild properties.
		 */
		private var _selectedIndex : int;
		/**
		 *  @private
		 */
		private var proposedSelectedIndex : int;

		/**
		 *  @private
		 */
		public function get autoLayout () : Boolean;
		/**
		 *  @private
		 */
		public function set autoLayout (value:Boolean) : void;
		/**
		 *  @private     *  The baselinePosition of an Accordion is calculated     *  for the label of the first header.     *  If there are no children, a child is temporarily added     *  to do the computation.
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		public function get clipContent () : Boolean;
		/**
		 *  @private
		 */
		public function set clipContent (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;
		/**
		 *  @private
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;
		/**
		 *  @private
		 */
		function get focusedIndex () : int;
		/**
		 *  The height of the area, in pixels, in which content is displayed.     *  You can override this getter if your content     *  does not occupy the entire area of the container.
		 */
		protected function get contentHeight () : Number;
		/**
		 *  The width of the area, in pixels, in which content is displayed.     *  You can override this getter if your content     *  does not occupy the entire area of the container.
		 */
		protected function get contentWidth () : Number;
		/**
		 *  A factory used to create the navigation buttons for each child.     *  The default value is a factory which creates a     *  <code>mx.containers.accordionClasses.AccordionHeader</code>. The     *  created object must be a subclass of Button and implement the     *  <code>mx.core.IDataRenderer</code> interface. The <code>data</code>     *  property is set to the content associated with the header.     *     *  @see mx.containers.accordionClasses.AccordionHeader
		 */
		public function get headerRenderer () : IFactory;
		/**
		 *  @private
		 */
		public function set headerRenderer (value:IFactory) : void;
		/**
		 *  If set to <code>true</code>, this property enables history management     *  within this Accordion container.     *  As the user navigates from one child to another,     *  the browser remembers which children were visited.     *  The user can then click the browser's Back and Forward buttons     *  to move through this navigation history.     *     *  @default true     *     *  @see mx.managers.HistoryManager
		 */
		public function get historyManagementEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set historyManagementEnabled (value:Boolean) : void;
		/**
		 *  If set to <code>true</code>, this Accordion automatically resizes to     *  the size of its current child.     *      *  @default false
		 */
		public function get resizeToContent () : Boolean;
		/**
		 *  @private
		 */
		public function set resizeToContent (value:Boolean) : void;
		/**
		 *  A reference to the currently visible child container.     *  The default value is a reference to the first child.     *  If there are no children, this property is <code>null</code>.     *     *  <p><b>Note:</b> You can only set this property in an ActionScript statement,      *  not in MXML.</p>     *     *  @tiptext Specifies the child view that is currently displayed     *  @helpid 3401
		 */
		public function get selectedChild () : Container;
		/**
		 *  @private
		 */
		public function set selectedChild (value:Container) : void;
		/**
		 *  The zero-based index of the currently visible child container.     *  Child indexes are in the range 0, 1, 2, ..., n - 1, where n is the number     *  of children.     *  The default value is 0, corresponding to the first child.     *  If there are no children, this property is <code>-1</code>.     *     *  @default 0     *     *  @tiptext Specifies the index of the child view that is currently displayed     *  @helpid 3402
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;

		/**
		 *  Constructor.
		 */
		public function Accordion ();
		/**
		 *  @private
		 */
		public function createComponentsFromDescriptors (recurse:Boolean = true) : void;
		/**
		 *  @private
		 */
		public function setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @private
		 */
		private function shuffleHeaders (oldIndex:int, newIndex:int) : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private     *  Arranges the layout of the accordion contents.     *     *  @tiptext Arranges the layout of the Accordion's contents     *  @helpid 3017
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		function setActualCreationPolicies (policy:String) : void;
		/**
		 *  @private
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		public function drawFocus (isFocused:Boolean) : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private     *  When asked to create an overlay mask, create it on the selected child     *  instead.  That way, the chrome around the edge of the Accordion (e.g. the     *  header buttons) is not occluded by the overlay mask (bug 99029).
		 */
		function addOverlay (color:uint, targetArea:RoundedRectangle = null) : void;
		/**
		 *  @private     *  Called when we are running a Dissolve effect     *  and the initialize event has been dispatched     *  or the children already exist
		 */
		private function initializeHandler (event:FlexEvent) : void;
		/**
		 *  @private     *  Handle key down events
		 */
		function removeOverlay () : void;
		/**
		 *  @copy mx.managers.IHistoryManagerClient#saveState()
		 */
		public function saveState () : Object;
		/**
		 *  @copy mx.managers.IHistoryManagerClient#loadState()
		 */
		public function loadState (state:Object) : void;
		/**
		 *  Returns a reference to the navigator button for a child container.     *     *  @param index Zero-based index of the child.     *     *  @return Button object representing the navigator button.
		 */
		public function getHeaderAt (index:int) : Button;
		/**
		 *  @private     *  Returns the height of the header control. All header controls are the same     *  height.
		 */
		private function getHeaderHeight () : Number;
		/**
		 *  @private     *  Utility method to create the segment header
		 */
		private function createHeader (content:DisplayObject, i:int) : void;
		/**
		 *  @private
		 */
		private function calcContentWidth () : Number;
		/**
		 *  @private
		 */
		private function calcContentHeight () : Number;
		/**
		 *  @private
		 */
		private function drawHeaderFocus (headerIndex:int, isFocused:Boolean) : void;
		/**
		 *  @private
		 */
		private function headerClickHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function commitSelectedIndex () : void;
		/**
		 *  @private
		 */
		private function instantiateChild (child:Container) : void;
		/**
		 *  @private
		 */
		private function dispatchChangeEvent (oldIndex:int, newIndex:int, cause:Event = null) : void;
		/**
		 *  @private
		 */
		private function startTween (oldSelectedIndex:int, newSelectedIndex:int) : void;
		/**
		 *  @private
		 */
		function onTweenUpdate (value:Number) : void;
		/**
		 *  @private
		 */
		function onTweenEnd (value:Number) : void;
		/**
		 *  @private     *  Handles "keyDown" event.
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private     *  Handles "addedToStage" event
		 */
		private function addedToStageHandler (event:Event) : void;
		/**
		 *  @private     *  Handles "removedFromStage" event
		 */
		private function removedFromStageHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function childAddHandler (event:ChildExistenceChangedEvent) : void;
		/**
		 *  @private
		 */
		private function childRemoveHandler (event:ChildExistenceChangedEvent) : void;
		/**
		 *  @private     *  Handles "labelChanged" event.
		 */
		private function labelChangedHandler (event:Event) : void;
		/**
		 *  @private     *  Handles "iconChanged" event.
		 */
		private function iconChangedHandler (event:Event) : void;
	}
}
