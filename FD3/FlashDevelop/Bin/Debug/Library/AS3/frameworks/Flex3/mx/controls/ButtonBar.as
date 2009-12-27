package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import mx.containers.BoxDirection;
	import mx.controls.buttonBarClasses.ButtonBarButton;
	import mx.core.ClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.ItemClickEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;

	/**
	 *  Dispatched when a user clicks a button.
 *  This event is only dispatched if the <code>dataProvider</code> property
 *  does not refer to a ViewStack container.
 *
 *  @eventType mx.events.ItemClickEvent.ITEM_CLICK
	 */
	[Event(name="itemClick", type="mx.events.ItemClickEvent")] 

	/**
	 *  Height of each button, in pixels.
 *  If undefined, the height of each button is determined by the font styles
 *  applied to the container.
 *  If you set this property, the specified value overrides this calculation.
	 */
	[Style(name="buttonHeight", type="Number", format="Length", inherit="no")] 

	/**
	 *  Name of CSS style declaration that specifies styles for the buttons.
	 */
	[Style(name="buttonStyleName", type="String", inherit="no")] 

	/**
	 *  Width of each button, in pixels.
 *  If undefined, the default width of each button is calculated from its label text.
	 */
	[Style(name="buttonWidth", type="Number", format="Length", inherit="no")] 

	/**
	 *  Name of CSS style declaration that specifies styles for the first button.
 *  If this is unspecified, the default value
 *  of the <code>buttonStyleName</code> style property is used.
	 */
	[Style(name="firstButtonStyleName", type="String", inherit="no")] 

	/**
	 * Horizontal alignment of all buttons within the ButtonBar. Since individual 
 * buttons stretch to fill the entire ButtonBar, this style is only useful if you
 * use the buttonWidth style and the combined widths of the buttons are less than
 * than the width of the ButtonBar.
 * Possible values are <code>"left"</code>, <code>"center"</code>,
 * and <code>"right"</code>.
 *
 * @default "center"
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 

	/**
	 *  Number of pixels between children in the horizontal direction.
 *
 *  @default 0
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 

	/**
	 * Vertical alignment of all buttons within the ButtonBar. Since individual 
 * buttons stretch to fill the entire ButtonBar, this style is only useful if you
 * use the buttonHeight style and the combined heights of the buttons are less than
 * than the width of the ButtonBar.
 * Possible values are <code>"top"</code>, <code>"middle"</code>,
 * and <code>"bottom"</code>.
 *
 * @default "middle"
	 */
	[Style(name="lastButtonStyleName", type="String", inherit="no")] 

	/**
	 * Vertical alignment of all buttons within the ButtonBar. Since individual 
 * buttons stretch to fill the entire ButtonBar, this style is only useful if you
 * use the buttonHeight style and the combined heights of the buttons are less than
 * than the width of the ButtonBar.
 * Possible values are <code>"top"</code>, <code>"middle"</code>,
 * and <code>"bottom"</code>.
 *
 * @default "middle"
	 */
	[Style(name="verticalAlign", type="String", enumeration="top,middle,bottom", inherit="no")] 

	/**
	 *  Number of pixels between children in the vertical direction.
 *
 *  @default 0
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 

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

	[Exclude(name="scroll", kind="event")] 

	[Exclude(name="click", kind="event")] 

	[Exclude(name="backgroundAlpha", kind="style")] 

	[Exclude(name="backgroundAttachment", kind="style")] 

	[Exclude(name="backgroundColor", kind="style")] 

	[Exclude(name="backgroundImage", kind="style")] 

	[Exclude(name="backgroundSize", kind="style")] 

	[Exclude(name="borderColor", kind="style")] 

	[Exclude(name="borderSides", kind="style")] 

	[Exclude(name="borderSkin", kind="style")] 

	[Exclude(name="borderStyle", kind="style")] 

	[Exclude(name="borderThickness", kind="style")] 

	[Exclude(name="cornerRadius", kind="style")] 

	[Exclude(name="dropShadowColor", kind="style")] 

	[Exclude(name="dropShadowEnabled", kind="style")] 

	[Exclude(name="horizontalScrollBarStyleName", kind="style")] 

	[Exclude(name="shadowCapColor", kind="style")] 

	[Exclude(name="shadowColor", kind="style")] 

	[Exclude(name="shadowDirection", kind="style")] 

	[Exclude(name="shadowDistance", kind="style")] 

	[Exclude(name="verticalScrollBarStyleName", kind="style")] 

	[DefaultProperty("dataProvider")] 

	[MaxChildren(0)] 

include "../core/Version.as"
	/**
	 *  The ButtonBar control defines a horizontal or vertical group of 
 *  logically related push buttons with a common look and navigation.
 *
 *  <p>A push button is one that does not remember its selected state
 *  when selected.
 *  The typical use for a push button in a button bar is for grouping
 *  a set of related buttons together, which gives them a common look
 *  and navigation, and handling the logic for the <code>click</code> event
 *  in a single place. </p>
 *
 *  <p>The ButtonBar control creates Button controls based on the value of 
 *  its <code>dataProvider</code> property. 
 *  Even though ButtonBar is a subclass of Container, do not use methods such as 
 *  <code>Container.addChild()</code> and <code>Container.removeChild()</code> 
 *  to add or remove Button controls. 
 *  Instead, use methods such as <code>addItem()</code> and <code>removeItem()</code> 
 *  to manipulate the <code>dataProvider</code> property. 
 *  The ButtonBar control automatically adds or removes the necessary children based on 
 *  changes to the <code>dataProvider</code> property.</p>
 *
 *  <p>To control the styling of the buttons of the ButtonBar control, use the 
 *  <code>buttonStyleName</code>, <code>firstButtonStyleName</code>, 
 *  and <code>lastButtonStyleName</code> style properties; 
 *  do not try to style the individual Button controls 
 *  that make up the ButtonBar control.</p>
 *
 *  <p>You can use the ToggleButtonBar control to define a group
 *  of toggle buttons.</p>
 *
 *  <p>ButtonBar control has the following default characteristics:</p>
 *  <table class="innertable">
 *     <tr>
 *        <th>Characteristic</th>
 *        <th>Description</th>
 *     </tr>
 *     <tr>
 *        <td>Preferred size</td>
 *        <td>Wide enough to contain all buttons with their label text and icons, if any, plus any padding and separators, and high enough to accommodate the button height.</td>
 *     </tr>
 *     <tr>
 *        <td>Control resizing rules</td>
 *        <td>The controls do not resize by default. Specify percentage sizes if you want your ButtonBar to resize based on the size of its parent container.</td>
 *     </tr>
 *     <tr>
 *        <td>Padding</td>
 *        <td>0 pixels for the top, bottom, left, and right properties.</td>
 *     </tr>
 *  </table>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:ButtonBar&gt;</code> tag inherits all the tag attributes
 *  of its superclass, and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:ButtonBar
 *    <b>Styles</b>
 *    buttonHeight="undefined"
 *    buttonStyleName="<i>Name of CSS style declaration, which specifies
 *    styles for the buttons</i>"
 *    buttonWidth="undefined"
 *    firstButtonStyleName="<i>The value of</i> <code>buttonStyleName</code>"
 *    horizontalAlign="center|left|right"
 *    horizontalGap="0"
 *    lastButtonStyleName="<i>The value of</i> <code>buttonStyleName</code>"
 *    verticalAlign="middle|top|bottom"
 *    verticalGap="0"
 *     
 *    <b>Events</b>
 *    itemClick="<i>No default</i>"
 *    &gt;
 *    ...
 *       <i>child tags</i>
 *    ...
 *  &lt;/mx:ButtonBar&gt;
 *  </pre>
 *
 *  @see mx.controls.ToggleButtonBar
 *  @see mx.controls.LinkBar
 *  @includeExample examples/ButtonBarExample.mxml
	 */
	public class ButtonBar extends NavBar implements IFocusManagerComponent
	{
		/**
		 *  @private
     *  Internal flag to indicate when a click event has been triggered
     *  programmatically, as opposed to an actual user click.
     *  This happens when the button selection happens by keyboard navigation
     *  or when selectedIndex is set programmatically.
     *  When this is true, the focus rect shouldn't be drawn
     *  for the currently selected button.
		 */
		var simulatedClickTriggerEvent : Event;
		/**
		 *  @private
     *  Name of style used to specify buttonStyleName.
     *  Overridden by TabBar.
		 */
		var buttonStyleNameProp : String;
		/**
		 *  @private
     *  Name of style used to specify buttonStyleName.
     *  Overridden by TabBar.
		 */
		var firstButtonStyleNameProp : String;
		/**
		 *  @private
     *  Name of style used to specify buttonStyleName.
     *  Overridden by TabBar.
		 */
		var lastButtonStyleNameProp : String;
		/**
		 *  @private
     *  Name of style used to specify buttonWidth.
     *  Overridden by TabBar.
		 */
		var buttonWidthProp : String;
		/**
		 *  @private
     *  Name of style used to specify buttonHeight.
     *  Overridden by TabBar.
		 */
		var buttonHeightProp : String;
		/**
		 *  @private
     *  Flag indicating whether buttons widths should be recalculated.
		 */
		private var recalcButtonWidths : Boolean;
		/**
		 *  @private
     *  Flag indicating whether buttons heights should be recalculated.
		 */
		private var recalcButtonHeights : Boolean;
		/**
		 *  @private
     *  The value of the unscaledWidth parameter during the most recent
     *  call to updateDisplayList
		 */
		private var oldUnscaledWidth : Number;
		/**
		 *  @private
     *  The value of the unscaledHeight parameter during the most recent
     *  call to updateDisplayList
		 */
		private var oldUnscaledHeight : Number;
		/**
		 *  @private
     *  Index of currently focused child.
		 */
		var focusedIndex : int;
		/**
		 *  @private
     *  Flag indicating whether direction has changed.
		 */
		private var directionChanged : Boolean;

		/**
		 *  @private
		 */
		public function get borderMetrics () : EdgeMetrics;

		/**
		 *  @private
		 */
		public function set direction (value:String) : void;

		/**
		 *  @private
		 */
		public function get viewMetrics () : EdgeMetrics;

		/**
		 *  Constructor.
		 */
		public function ButtonBar ();

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  @private
		 */
		protected function measure () : void;

		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		public function drawFocus (isFocused:Boolean) : void;

		/**
		 *  @private
		 */
		protected function createNavItem (label:String, icon:Class = null) : IFlexDisplayObject;

		/**
		 *  @private
		 */
		protected function resetNavItems () : void;

		/**
		 *  @private
		 */
		private function calcFullWidth () : Number;

		/**
		 *  @private
		 */
		private function calcFullHeight () : Number;

		/**
		 *  @private
     *  Returns the previous valid child index, or -1 if there are no children.
     *  Used by keyboard navigation.
		 */
		function prevIndex (index:int) : int;

		/**
		 *  @private
     *  Returns the next valid child index, or -1 if there are no children.
     *  Used by keyboard navigation.
		 */
		function nextIndex (index:int) : int;

		/**
		 *  @private
		 */
		function drawButtonFocus (index:int, focused:Boolean) : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		protected function clickHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function childRemoveHandler (event:ChildExistenceChangedEvent) : void;

		/**
		 *  @private
     *  Reset buttons widths so that it can be recalculated.
		 */
		protected function resetButtonWidths () : void;

		/**
		 *  @private
     *  Reset buttons heights so that it can be recalculated.
		 */
		protected function resetButtonHeights () : void;

		/**
		 *  @private
		 */
		private function scaleChangedHandler (event:Event) : void;
	}
}
