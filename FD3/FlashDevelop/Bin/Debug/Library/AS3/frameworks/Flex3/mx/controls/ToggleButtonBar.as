package mx.controls
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;

	/**
	 *  Name of CSS style declaration that specifies styles for the text of the
 *  selected button.
	 */
	[Style(name="selectedButtonTextStyleName", type="String", inherit="no")] 

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

include "../core/Version.as"
	/**
	 *  The ToggleButtonBar control defines a horizontal or vertical 
 *  group of buttons that maintain their selected or deselected state.
 *  Only one button in the ToggleButtonBar control
 *  can be in the selected state.
 *  This means that when a user selects a button in a ToggleButtonBar control,
 *  the button stays in the selected state until the user selects a different button.
 *
 *  <p>If you set the <code>toggleOnClick</code> property of the
 *  ToggleButtonBar container to <code>true</code>,
 *  selecting the currently selected button deselects it.
 *  By default the <code>toggleOnClick</code> property is set to
 *  <code>false</code>.</p>
 *
 *  <p>You can use the ButtonBar control to define a group
 *  of push buttons.</p>
 *
 *  <p>The typical use for a toggle button is for maintaining selection
 *  among a set of options, such as switching between views in a ViewStack
 *  container.</p>
 *
 *  <p>The ToggleButtonBar control creates Button controls based on the value of 
 *  its <code>dataProvider</code> property. 
 *  Even though ToggleButtonBar is a subclass of Container, do not use methods such as 
 *  <code>Container.addChild()</code> and <code>Container.removeChild()</code> 
 *  to add or remove Button controls. 
 *  Instead, use methods such as <code>addItem()</code> and <code>removeItem()</code> 
 *  to manipulate the <code>dataProvider</code> property. 
 *  The ToggleButtonBar control automatically adds or removes the necessary children based on 
 *  changes to the <code>dataProvider</code> property.</p>
 *
 *  <p>To control the styling of the buttons of the ToggleButtonBar control, 
 *  use the <code>buttonStyleName</code>, <code>firstButtonStyleName</code>, 
 *  and <code>lastButtonStyleName</code> style properties; 
 *  do not try to style the individual Button controls 
 *  that make up the ToggleButtonBar control.</p>
 *
 *  <p>ToggleButtonBar control has the following default characteristics:</p>
 *  <table class="innertable">
 *     <tr>
 *        <th>Characteristic</th>
 *        <th>Description</th>
 *     </tr>
 *     <tr>
 *        <td>Preferred size</td>
 *        <td>Wide enough to contain all buttons with their label text and icons, if any, plus any 
 *            padding and separators, and high enough to accommodate the button height.</td>
 *     </tr>
 *     <tr>
 *        <td>Control resizing rules</td>
 *        <td>The controls do not resize by default. Specify percentage sizes if you want your 
 *            ToggleButtonBar to resize based on the size of its parent container.</td>
 *     </tr>
  *     <tr>
 *        <td>selectedIndex</td>
 *        <td>Determines which button will be selected when the control is created. The default value is "0" 
 *            and selects the leftmost button in the bar. Setting the selectedIndex property to "-1" deselects 
 *            all buttons in the bar.</td>
 *     </tr>
*     <tr>
 *        <td>Padding</td>
 *        <td>0 pixels for the top, bottom, left, and right properties.</td>
 *     </tr>
 *  </table>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:ToggleButtonBar&gt;</code> tag inherits all of the tag attributes
 *  of its superclass, and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:ToggleButtonBar
 *    <b>Properties</b>
 *    selectedIndex="0"
 *    toggleOnClick="false|true"
 * 
 *    <b>Styles</b>
 *    selectedButtonTextStyleName="<i>Name of CSS style declaration that specifies styles for the text of the selected button.</i>"&gt;
 *    ...
 *       <i>child tags</i>
 *    ...
 *  &lt;/mx:ToggleButtonBar&gt;
 *  </pre>
 *
 *  @includeExample examples/ToggleButtonBarExample.mxml
 *
 *  @see mx.controls.ButtonBar
 *  @see mx.controls.LinkBar
	 */
	public class ToggleButtonBar extends ButtonBar
	{
		/**
		 *  @private.
		 */
		private var initializeSelectedButton : Boolean;
		/**
		 *  @private
     *  Name of style used to specify selectedButtonTextStyleName.
     *  Overridden by TabBar.
		 */
		var selectedButtonTextStyleNameProp : String;
		/**
		 *  @private
     *  Storage for the selectedIndex property.
		 */
		private var _selectedIndex : int;
		/**
		 *  @private.
		 */
		private var selectedIndexChanged : Boolean;
		/**
		 *  @private
     *  Storage for the toggleOnClick property.
		 */
		private var _toggleOnClick : Boolean;

		/**
		 *  Index of the selected button.
     *  Indexes are in the range of 0, 1, 2, ..., n - 1,
     *  where <i>n</i> is the number of buttons.
     *
     *  <p>The default value is 0.
	 *  A value of -1 deselects all the buttons in the bar.</p>
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private.
		 */
		public function set selectedIndex (value:int) : void;

		/**
		 *  Specifies whether the currently selected button can be deselected by
     *  the user.
     *
     *  By default, the currently selected button gets deselected
     *  automatically only when another button in the group is selected.
     *  Setting this property to <code>true</code> lets the user
     *  deselect it.
     *  When the currently selected button is deselected,
     *  the <code>selectedIndex</code> property is set to <code>-1</code>.
     *
     *  @default false
		 */
		public function get toggleOnClick () : Boolean;
		/**
		 *  @private
		 */
		public function set toggleOnClick (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function ToggleButtonBar ();

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

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
		protected function createNavItem (label:String, icon:Class = null) : IFlexDisplayObject;

		/**
		 *  @private
		 */
		protected function hiliteSelectedNavItem (index:int) : void;

		/**
		 *  @private
		 */
		protected function resetNavItems () : void;

		/**
		 *  @private
     *  Select the button at the specified index.
		 */
		function selectButton (index:int, updateFocusIndex:Boolean = false, trigger:Event = null) : void;

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
	}
}
