package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFlexDisplayObject;
	import mx.core.IIMESupport;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.NumericStepperEvent;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when the value of the NumericStepper control changes
 *  as a result of user interaction.
 *
 *  @eventType mx.events.NumericStepperEvent.CHANGE
	 */
	[Event(name="change", type="mx.events.NumericStepperEvent")] 

	/**
	 *  Dispatched when the <code>data</code> property changes.
 *
 *  <p>When you use a component as an item renderer,
 *  the <code>data</code> property contains the data to display.
 *  You can listen for this event and update the component
 *  when the <code>data</code> property changes.</p>
 * 
 *  @eventType mx.events.FlexEvent.DATA_CHANGE
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 

include "../styles/metadata/BorderStyles.as"
include "../styles/metadata/FocusStyles.as"
include "../styles/metadata/IconColorStyles.as"
include "../styles/metadata/LeadingStyle.as"
include "../styles/metadata/PaddingStyles.as"
include "../styles/metadata/TextStyles.as"
	/**
	 *  Name of the class to use as the default skin for the down arrow.
 * 
 *  @default mx.skins.halo.NumericStepperDownSkin
	 */
	[Style(name="downArrowSkin", type="Class", inherit="no", states="up, over, down, disabled")] 

	/**
	 *  Name of the class to use as the skin for the Down arrow
 *  when the arrow is disabled.
 *
 *  @default mx.skins.halo.NumericStepperDownSkin
	 */
	[Style(name="downArrowDisabledSkin", type="Class", inherit="no")] 

	/**
	 *  Name of the class to use as the skin for the Down arrow
 *  when the arrow is enabled and a user presses the mouse button over the arrow.
 *
 *  @default mx.skins.halo.NumericStepperDownSkin
	 */
	[Style(name="downArrowDownSkin", type="Class", inherit="no")] 

	/**
	 *  Name of the class to use as the skin for the Down arrow
 *  when the arrow is enabled and the mouse pointer is over the arrow.
 *  
 *  @default mx.skins.halo.NumericStepperDownSkin
	 */
	[Style(name="downArrowOverSkin", type="Class", inherit="no")] 

	/**
	 *  Name of the class to use as the skin for the Down arrow
 *  when the arrow is enabled and the mouse pointer is not on the arrow.
 *  There is no default.
	 */
	[Style(name="downArrowUpSkin", type="Class", inherit="no")] 

	/**
	 *  Alphas used for the highlight fill of controls.
 *
 *  @default [ 0.3, 0.0 ]
	 */
	[Style(name="highlightAlphas", type="Array", arrayType="Number", inherit="no")] 

	/**
	 *  Name of the class to use as the default skin for the up arrow.
 *  
 *  @default mx.skins.halo.NumericStepperUpSkin
	 */
	[Style(name="upArrowSkin", type="Class", inherit="no", states="up, over, down, disabled")] 

	/**
	 *  Name of the class to use as the skin for the Up arrow
 *  when the arrow is disabled.
 *
 *  @default mx.skins.halo.NumericStepperUpSkin
	 */
	[Style(name="upArrowDisabledSkin", type="Class", inherit="no")] 

	/**
	 *  Name of the class to use as the skin for the Up arrow
 *  when the arrow is enabled and a user presses the mouse button over the arrow.
 *
 *  @default mx.skins.halo.NumericStepperUpSkin
	 */
	[Style(name="upArrowDownSkin", type="Class", inherit="no")] 

	/**
	 *  Name of the class to use as the skin for the Up arrow
 *  when the arrow is enabled and the mouse pointer is over the arrow.
 *
 *  @default mx.skins.halo.NumericStepperUpSkin
	 */
	[Style(name="upArrowOverSkin", type="Class", inherit="no")] 

	/**
	 *  Name of the class to use as the skin for the Up arrow
 *  when the arrow is enabled and the mouse pointer is not on the arrow.
 *
 *  @default mx.skins.halo.NumericStepperUpSkin
	 */
	[Style(name="upArrowUpSkin", type="Class", inherit="no")] 

include "../core/Version.as"
	/**
	 *  The NumericStepper control lets the user select
 *  a number from an ordered set.
 *  The NumericStepper control consists of a single-line
 *  input text field and a pair of arrow buttons
 *  for stepping through the possible values.
 *  The Up Arrow and Down Arrow keys also cycle through the values.
 *
 *  <p>The NumericStepper control has the following default characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>Wide enough to display the maximum number of digits used by the control</td>
 *        </tr>
 *        <tr>
 *           <td>Minimum size</td>
 *           <td>Based on the size of the text.</td>
 *        </tr>
 *        <tr>
 *           <td>Maximum size</td>
 *           <td>Undefined</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *
 *  The <code>&lt;mx:NumericStepper&gt;</code> tag inherits all of the tag
 *  attributes of its superclass, and adds the following tag attributes:
 *
 *  <pre>
 *  &lt;mx:NumericStepper
 *    <strong>Properties</strong>
 *    imeMode="null"
 *    maxChars="10"
 *    maximum="10"
 *    minimum="0"
 *    stepSize="1"
 *    value="0"
 *  
 *    <strong>Styles</strong>
 *    backgroundAlpha="1.0"
 *    backgroundColor="undefined"
 *    backgroundImage="undefined"
 *    backgroundSize="auto"
 *    borderColor="0xAAB3B3"
 *    borderSides="left top right bottom"
 *    borderSkin="HaloBorder"
 *    borderStyle="inset"
 *    borderThickness="1"
 *    color="0x0B333C"
 *    cornerRadius="0"
 *    disabledColor="0xAAB3B3"
 *    disabledIconColor="0x999999"
 *    downArrowDisabledSkin="NumericStepperDownSkin"
 *    downArrowDownSkin="NumericStepperDownSkin"
 *    downArrowOverSkin="NumericStepperDownSkin"
 *    downArrowUpSkin="NumericStepperDownSkin"
 *    dropShadowEnabled="false"
 *    dropShadowColor="0x000000"
 *    focusAlpha="0.5"
 *    focusRoundedCorners="tl tr bl br"
 *    fontAntiAliasType="advanced"
 *    fontFamily="Verdana"
 *    fontGridFitType="pixel"
 *    fontSharpness="0"
 *    fontSize="10"
 *    fontStyle="normal|italic"
 *    fontThickness="0"
 *    fontWeight="normal|bold"
 *    highlightAlphas="[0.3,0.0]"
 *    iconColor="0x111111"
 *    leading="2"
 *    paddingLeft="0"
 *    paddingRight="0"
 *    shadowDirection="center"
 *    shadowDistance="2"
 *    textAlign="left|center|right"
 *    textDecoration="none|underline"
 *    textIndent="0"
 *    upArrowDisabledSkin="NumericStepperUpSkin"
 *    upArrowDownSkin="NumericStepperUpSkin"
 *    upArrowOverSkin="NumericStepperUpSkin"
 *    upArrowUpSkin="NumericStepperUpSkin"
 *  
 *    <strong>Events</strong>
 *    change="<i>No default</i>"
 *    dataChange="<i>No default</i>"
 *  /&gt;
 *  </pre>
 *
 *  @includeExample examples/NumericStepperExample.mxml
 *
	 */
	public class NumericStepper extends UIComponent implements IDataRenderer
	{
		/**
		 *  @private
		 */
		var inputField : TextInput;
		/**
		 *  @private
		 */
		var nextButton : Button;
		/**
		 *  @private
		 */
		var prevButton : Button;
		/**
		 *  @private
     *  Flag that will block default data/listData behavior
		 */
		private var valueSet : Boolean;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  @private
     *  Storage for the tabIndex property.
		 */
		private var _tabIndex : int;
		/**
		 *  @private
		 */
		private var tabIndexChanged : Boolean;
		/**
		 *  @private
     *  Storage for the data property.
		 */
		private var _data : Object;
		private static var _downArrowStyleFilters : Object;
		/**
		 *  @private
		 */
		private var _imeMode : String;
		private static var _inputFieldStyleFilters : Object;
		/**
		 *  @private
     *  Storage for the listData property.
		 */
		private var _listData : BaseListData;
		/**
		 *  @private
     *  Storage for the maxChars property.
		 */
		private var _maxChars : int;
		/**
		 *  @private
		 */
		private var maxCharsChanged : Boolean;
		/**
		 *  @private
     *  Storage for maximum property.
		 */
		private var _maximum : Number;
		/**
		 *  @private
     *  Storage for minimum property.
		 */
		private var _minimum : Number;
		/**
		 *  @private
     *  Storage for the nextValue property.
		 */
		private var _nextValue : Number;
		/**
		 *  @private
     *  Storage for the previousValue property.
		 */
		private var _previousValue : Number;
		/**
		 *  @private
     *  Storage for the stepSize property.
		 */
		private var _stepSize : Number;
		private static var _upArrowStyleFilters : Object;
		/**
		 *  @private
     *  Storage for the value property.
		 */
		private var _value : Number;
		/**
		 *  @private
     *  last value we send CHANGE for.
     *  _value will hold uncommitted values as well
		 */
		private var lastValue : Number;
		/**
		 *  @private
     *  Holds the value of the value property
     *  until it is committed in commitProperties().
		 */
		private var proposedValue : Number;
		/**
		 *  @private
     *  Keeps track of whether we need to update
     *  the value in commitProperties().
		 */
		private var valueChanged : Boolean;

		/**
		 *  @private
     *  The baselinePosition of a NumericStepper is calculated
     *  for its inputField.
		 */
		public function get baselinePosition () : Number;

		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get enabled () : Boolean;

		/**
		 *  @private
     *  Tab order in which the control receives the focus when navigating
     *  with the Tab key.
     *
     *  @default -1
     *  @tiptext tabIndex of the component
     *  @helpid 3198
		 */
		public function get tabIndex () : int;
		/**
		 *  @private
		 */
		public function set tabIndex (value:int) : void;

		/**
		 *  The <code>data</code> property lets you pass a value to the component
     *  when you use it in an item renderer or item editor.
     *  You typically use data binding to bind a field of the <code>data</code>
     *  property to a property of this component.
     *
     *  <p>When you use the control as a drop-in item renderer or drop-in
     *  item editor, Flex automatically writes the current value of the item
     *  to the <code>value</code> property of this control.</p>
     *
     *  @default null
     *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;

		/**
		 *  Set of styles to pass from the NumericStepper to the down arrow.
     *  @see mx.styles.StyleProxy
		 */
		protected function get downArrowStyleFilters () : Object;

		/**
		 *  Specifies the IME (Input Method Editor) mode.
     *  The IME enables users to enter text in Chinese, Japanese, and Korean.
     *  Flex sets the specified IME mode when the control gets the focus
     *  and sets it back to previous value when the control loses the focus.
     *
     * <p>The flash.system.IMEConversionMode class defines constants for the
     *  valid values for this property.
     *  You can also specify <code>null</code> to specify no IME.</p>
     *
     *  @see flash.system.IMEConversionMode
     *
     *  @default null
		 */
		public function get imeMode () : String;
		/**
		 *  @private
		 */
		public function set imeMode (value:String) : void;

		/**
		 *  Set of styles to pass from the NumericStepper to the input field.
     *  @see mx.styles.StyleProxy
		 */
		protected function get inputFieldStyleFilters () : Object;

		/**
		 *  When a component is used as a drop-in item renderer or drop-in
     *  item editor, Flex initializes the <code>listData</code> property
     *  of the component with the appropriate data from the List control.
     *  The component can then use the <code>listData</code> property
     *  to initialize the <code>data</code> property of the drop-in
     *  item renderer or drop-in item editor.
     *
     *  <p>You do not set this property in MXML or ActionScript;
     *  Flex sets it when the component is used as a drop-in item renderer
     *  or drop-in item editor.</p>
     *
     *  @default null
     *  @see mx.controls.listClasses.IDropInListItemRenderer
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;

		/**
		 *  The maximum number of characters that can be entered in the field.
     *  A value of 0 means that any number of characters can be entered.
     *
     *  @default 0
		 */
		public function get maxChars () : int;
		public function set maxChars (value:int) : void;

		/**
		 *  Maximum value of the NumericStepper.
     *  The maximum can be any number, including a fractional value.
     *
     *  @default 10
		 */
		public function get maximum () : Number;
		public function set maximum (value:Number) : void;

		/**
		 *  Minimum value of the NumericStepper.
     *  The minimum can be any number, including a fractional value.
     *
     *  @default 0
		 */
		public function get minimum () : Number;
		public function set minimum (value:Number) : void;

		/**
		 *  The value that is one step larger than the current <code>value</code>
     *  property and not greater than the <code>maximum</code> property value.
		 */
		public function get nextValue () : Number;

		/**
		 *  The value that is one step smaller than the current <code>value</code>
     *  property and not smaller than the <code>maximum</code> property value.
		 */
		public function get previousValue () : Number;

		/**
		 *  Non-zero unit of change between values.
     *  The <code>value</code> property must be a multiple of this number.
     *
     *  @default 1
		 */
		public function get stepSize () : Number;
		/**
		 *  @private
		 */
		public function set stepSize (value:Number) : void;

		/**
		 *  Set of styles to pass from the NumericStepper to the up arrow.
     *  @see mx.styles.StyleProxy
		 */
		protected function get upArrowStyleFilters () : Object;

		/**
		 *  Current value displayed in the text area of the NumericStepper control.
     *  If a user enters number that is not a multiple of the
     *  <code>stepSize</code> property or is not in the range
     *  between the <code>maximum</code> and <code>minimum</code> properties,
     *  this property is set to the closest valid value.
     *
     *  @default 0
		 */
		public function get value () : Number;
		/**
		 *  @private
		 */
		public function set value (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function NumericStepper ();

		/**
		 *  @private
		 */
		protected function createChildren () : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  @private
     *  Return the preferred sizes of the stepper.
		 */
		protected function measure () : void;

		/**
		 *  @private
     *  Place the buttons to the right of the text field.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
     *  Update the text field.
		 */
		public function setFocus () : void;

		/**
		 *  @private
		 */
		protected function isOurFocus (target:DisplayObject) : Boolean;

		/**
		 *  @private
     *  Verify that the value is within range.
		 */
		private function checkRange (v:Number) : Boolean;

		/**
		 *  @private
		 */
		private function checkValidValue (value:Number) : Number;

		/**
		 *  @private
		 */
		private function setValue (value:Number, sendEvent:Boolean = true, trigger:Event = null) : void;

		/**
		 *  @private
     *  Checks the value in the text field. If it is valid value
     *  and different from the current value, it is taken as new value.
		 */
		private function takeValueFromTextField (trigger:Event = null) : void;

		/**
		 *  @private
     *  Increase/decrease the current value.
		 */
		private function buttonPress (button:Button, trigger:Event = null) : void;

		/**
		 *  @private
     *  Remove the focus from the text field.
		 */
		protected function focusInHandler (event:FocusEvent) : void;

		/**
		 *  @private
     *  Remove the focus from the text field.
		 */
		protected function focusOutHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		private function buttonDownHandler (event:FlexEvent) : void;

		/**
		 *  @private
		 */
		private function buttonClickHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function inputField_focusInHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		private function inputField_focusOutHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		private function inputField_keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		private function inputField_changeHandler (event:Event) : void;
	}
}
