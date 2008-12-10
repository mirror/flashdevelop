package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IBorder;
	import mx.core.IButton;
	import mx.core.IDataRenderer;
	import mx.core.IFlexAsset;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IInvalidating;
	import mx.core.IRectangularBorder;
	import mx.core.IUIComponent;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.MoveEvent;
	import mx.events.SandboxMouseEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.states.State;
	import mx.styles.ISimpleStyleClient;
	import mx.core.IStateClient;
	import mx.core.IProgrammaticSkin;

	/**
	 *  Dispatched when the user presses the Button control. *  If the <code>autoRepeat</code> property is <code>true</code>, *  this event is dispatched repeatedly as long as the button stays down. * *  @eventType mx.events.FlexEvent.BUTTON_DOWN
	 */
	[Event(name="buttonDown", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the <code>selected</code> property  *  changes for a toggle Button control. A toggle Button control means that the  *  <code>toggle</code> property is set to <code>true</code>.  *  *  For the RadioButton controls, this event is dispatched when the <code>selected</code>  *  property changes. *  *  For the CheckBox controls, this event is dispatched only when the  *  user interacts with the control by using the mouse. * *  @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")] 
	/**
	 *  Dispatched when the <code>data</code> property changes. * *  <p>When you use a component as an item renderer, *  the <code>data</code> property contains the data to display. *  You can listen for this event and update the component *  when the <code>data</code> property changes.</p> *  *  @eventType mx.events.FlexEvent.DATA_CHANGE
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 
	/**
	 *  Gap between the label and icon, when the <code>labelPlacement</code> property *  is set to <code>left</code> or <code>right</code>. *  *  @default 2
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the component's bottom border *  and the bottom of its content area. *   *  @default 0
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the component's top border *  and the top of its content area. *   *  @default 0
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of milliseconds to wait after the first <code>buttonDown</code> *  event before repeating <code>buttonDown</code> events at each  *  <code>repeatInterval</code>. *  *  @default 500
	 */
	[Style(name="repeatDelay", type="Number", format="Time", inherit="no")] 
	/**
	 *  Number of milliseconds between <code>buttonDown</code> events *  if the user presses and holds the mouse on a button. *   *  @default 35
	 */
	[Style(name="repeatInterval", type="Number", format="Time", inherit="no")] 
	/**
	 *  Text color of the label as the user moves the mouse pointer over the button. *   *  @default 0x2B333C
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Text color of the label as the user presses it. *   *  @default 0x000000
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Gap between the button's label and icon when the <code>labelPlacement</code> *  property is set to <code>"top"</code> or <code>"bottom"</code>. *  *  @default 2
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Name of the class to use as the default skin for the background and border.  *  @default "mx.skins.halo.ButtonSkin"
	 */
	[Style(name="skin", type="Class", inherit="no", states="up, over, down, disabled, selectedUp, selectedOver, selectedDown, selectedDisabled")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when the button is not selected and the mouse is not over the control. *   *  @default "mx.skins.halo.ButtonSkin"
	 */
	[Style(name="upSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when the button is not selected and the mouse is over the control. *   *  @default "mx.skins.halo.ButtonSkin"
	 */
	[Style(name="overSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when the button is not selected and the mouse button is down. *   *  @default "mx.skins.halo.ButtonSkin"
	 */
	[Style(name="downSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when the button is not selected and is disabled. *  *  @default "mx.skins.halo.ButtonSkin"
	 */
	[Style(name="disabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when a toggle button is selected and the mouse is not over the control. *  *  @default "mx.skins.halo.ButtonSkin"
	 */
	[Style(name="selectedUpSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when a toggle button is selected and the mouse is over the control. *   *  @default "mx.skins.halo.ButtonSkin"
	 */
	[Style(name="selectedOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when a toggle button is selected and the mouse button is down. *   *  @default "mx.skins.halo.ButtonSkin"
	 */
	[Style(name="selectedDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when a toggle button is selected and disabled. *  *  @default "mx.skins.halo.ButtonSkin"
	 */
	[Style(name="selectedDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the default icon.  *  Setting any other icon style overrides this setting. *   *  @default null
	 */
	[Style(name="icon", type="Class", inherit="no", states="up, over, down, disabled, selectedUp, selectedOver, selectedDown, selectedDisabled")] 
	/**
	 *  Name of the class to use as the icon when a toggle button is not  *  selected and the mouse is not over the button. *  *  @default null
	 */
	[Style(name="upIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon when the button is not  *  selected and the mouse is over the control. *  *  @default null
	 */
	[Style(name="overIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon when the button is not  *  selected and the mouse button is down. *  *  @default null
	 */
	[Style(name="downIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon *  when the button is disabled and not selected. *  *  @default null
	 */
	[Style(name="disabledIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon *  when the button is selected and the mouse button is up. *  *  @default null
	 */
	[Style(name="selectedUpIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon *  when the button is selected and the mouse is over the control. *  *  @default null
	 */
	[Style(name="selectedOverIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon *  when the button is selected and the mouse button is down. *  *  @default null
	 */
	[Style(name="selectedDownIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon *  when the button is selected and disabled. *  *  @default null
	 */
	[Style(name="selectedDisabledIcon", type="Class", inherit="no")] 

	/**
	 *  The Button control is a commonly used rectangular button. *  Button controls look like they can be pressed. *  They can have a text label, an icon, or both on their face. * *  <p>Buttons typically use event listeners to perform an action  *  when the user selects the control. When a user clicks the mouse  *  on a Button control, and the Button control is enabled,  *  it dispatches a <code>click</code> event and a <code>buttonDown</code> event.  *  A button always dispatches events such as the <code>mouseMove</code>,  *  <code>mouseOver</code>, <code>mouseOut</code>, <code>rollOver</code>,  *  <code>rollOut</code>, <code>mouseDown</code>, and  *  <code>mouseUp</code> events whether enabled or disabled.</p> * *  <p>You can customize the look of a Button control *  and change its functionality from a push button to a toggle button. *  You can change the button appearance by using a skin *  for each of the button's states.</p> * *  <p>The label of a Button control uses a bold typeface. If you embed  *  a font that you want to use for the label of the Button control, you must  *  embed the bold typeface; for example:</p> *  *  <pre> *  &lt;mx:style&gt; *    &#64;font-face { *      src:url("../MyFont-Bold.ttf");         *      fontFamily: myFont; *      fontWeight: bold; *    } *   .myBoldStyle { *      fontFamily: myFont; *      fontWeight: bold; *    }  *  &lt;/mx:style&gt; *  ... *  &lt;mx:Button ... styleName="myBoldStyle"/&gt; *  </pre> *   *  <p>The Button control has the following default characteristics:</p> *  <table class="innertable"> *     <tr><th>Characteristic</th><th>Description</th></tr> *     <tr><td>Default size</td><td>A size large enough to hold the label text, and any icon</td></tr> *     <tr><td>Minimum size</td><td>0 pixels</td></tr> *     <tr><td>Maximum size</td><td>No limit</td></tr> *  </table> * *  @mxml * *  <p>The <code>&lt;mx:Button&gt;</code> tag inherits all the tag attributes *  of its superclass, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:Button *    <b>Properties</b> *    autoRepeat="false|true" *    emphasized="false|true" *    fontContext="<i>IFontModuleFactory</i>" *    label="" *    labelPlacement="right|left|bottom|top" *    selected="false|true" *    selectedField="null" *    stickyHighlighting="false|true" *    toggle="false|true" *  *    <b>Styles</b> *    borderColor="0xAAB3B3" *    color="0x0B333C" *    cornerRadius="4" *    disabledColor="0xAAB3B3" *    disabledIcon="null" *    disabledSkin="mx.skins.halo.ButtonSkin" *    downIcon="null" *    downSkin="mx.skins.halo.ButtonSkin" *    fillAlphas="[0.6, 0.4]" *    fillColors="[0xE6EEEE, 0xFFFFFF]" *    focusAlpha="0.5" *    focusRoundedCorners"tl tr bl br" *    fontAntiAliasType="advanced" *    fontFamily="Verdana" *    fontGridFitType="pixel" *    fontSharpness="0" *    fontSize="10" *    fontStyle="normal|italic" *    fontThickness="0" *    fontWeight="bold|normal" *    highlightAlphas="[0.3, 0.0]" *    horizontalGap="2" *    icon="null" *    kerning="false|true" *    leading="2" *    letterSpacing="0" *    overIcon="null" *    overSkin="mx.skins.halo.ButtonSkin" *    paddingBottom="0" *    paddingLeft="0" *    paddingRight="0" *    paddingTop="0" *    repeatDelay="500" *    repeatInterval="35" *    selectedDisabledIcon="null" *    selectedDisabledSkin="mx.skins.halo.ButtonSkin" *    selectedDownIcon="null" *    selectedDownSkin="mx.skins.halo.ButtonSkin" *    selectedOverIcon="null" *    selectedOverSkin="mx.skins.halo.ButtonSkin" *    selectedUpIcon="null" *    selectedUpSkin="mx.skins.halo.ButtonSkin" *    skin="mx.skins.halo.ButtonSkin" *    textAlign="center|left|right" *    textDecoration="none|underline" *    textIndent="0" *    textRollOverColor="0x2B333C" *    textSelectedColor="0x000000" *    upIcon="null" *    upSkin="mx.skins.halo.ButtonSkin" *    verticalGap="2" *  *    <b>Events</b> *    buttonDown="<i>No default</i>" *    change="<i>No default</i>" *    dataChange="<i>No de
	 */
	public class Button extends UIComponent implements IDataRenderer
	{
		/**
		 *  @private     *  Placeholder for mixin by ButtonAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private     *  Skins for the various states (falseUp, trueOver, etc.)     *  are created just-in-time as they are needed.     *  Each skin is a child Sprite of this Button.     *  Each skin has a name property indicating which skin it is;     *  for example, the instance of the class specified by the falseUpSkin     *  style has the name "falseUpSkin" and can be found using     *  getChildByName(). Note that there is no falseUpSkin property     *  of Button containing a reference to this skin instance.     *  This array contains references to all skins that have been created,     *  for looping over them; without this array we wouldn't know     *  which of the children are the skins.     *  New skins are created and added to this array in viewSkin().
		 */
		private var skins : Array;
		/**
		 *  @private     *  A reference to the current skin.     *  Set by viewSkin().
		 */
		local var currentSkin : IFlexDisplayObject;
		/**
		 *  @private     *  Skins for the various states (falseUp, trueOver, etc.)     *  are created just-in-time as they are needed.     *  Each icon is a child Sprite of this Button.     *  Each icon has a name property indicating which icon it is;     *  for example, the instance of the class specified by the falseUpIcon     *  style has the name "falseUpIcon" and can be found using     *  getChildByName(). Note that there is no falseUpIcon property     *  of Button containing a reference to this icon instance.     *  This array contains references to all icons that have been created,     *  for looping over them; without this array we wouldn't know     *  which of the children are the icons.     *  New icons are created and added to this array in viewIcon().
		 */
		private var icons : Array;
		/**
		 *  @private     *  A reference to the current icon.     *  Set by viewIcon().
		 */
		local var currentIcon : IFlexDisplayObject;
		/**
		 *  @private     *  Timer for doing auto-repeat.
		 */
		private var autoRepeatTimer : Timer;
		/**
		 *  @private     *  Number used to offset the label and/or icon     *  when button is pressed.
		 */
		local var buttonOffset : Number;
		/**
		 *  @private     *  used by old measure/layout logic
		 */
		local var centerContent : Boolean;
		/**
		 *  @private     *  used by old measure/layout logic
		 */
		local var extraSpacing : Number;
		/**
		 *  @private
		 */
		static var TEXT_WIDTH_PADDING : Number;
		/**
		 *  @private
		 */
		private var styleChangedFlag : Boolean;
		/**
		 *  @private     *  The measured width of the first skin loaded.
		 */
		private var skinMeasuredWidth : Number;
		/**
		 *  @private     *  The measured height of the first skin loaded.
		 */
		private var skinMeasuredHeight : Number;
		/**
		 *  @private     *  The value of the unscaledWidth parameter during the most recent     *  call to updateDisplayList
		 */
		private var oldUnscaledWidth : Number;
		/**
		 *  @private     *  Flags that will block default data/listData behavior
		 */
		private var selectedSet : Boolean;
		private var labelSet : Boolean;
		/**
		 *  @private     *  Flags used to save information about the skin and icon styles
		 */
		local var checkedDefaultSkin : Boolean;
		local var defaultSkinUsesStates : Boolean;
		local var checkedDefaultIcon : Boolean;
		local var defaultIconUsesStates : Boolean;
		/**
		 *  @private     *  Skin names.     *  Allows subclasses to re-define the skin property names.
		 */
		local var skinName : String;
		local var upSkinName : String;
		local var overSkinName : String;
		local var downSkinName : String;
		local var disabledSkinName : String;
		local var selectedUpSkinName : String;
		local var selectedOverSkinName : String;
		local var selectedDownSkinName : String;
		local var selectedDisabledSkinName : String;
		/**
		 *  @private     *  Icon names.     *  Allows subclasses to re-define the icon property names.
		 */
		local var iconName : String;
		local var upIconName : String;
		local var overIconName : String;
		local var downIconName : String;
		local var disabledIconName : String;
		local var selectedUpIconName : String;
		local var selectedOverIconName : String;
		local var selectedDownIconName : String;
		local var selectedDisabledIconName : String;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  The internal UITextField object that renders the label of this Button.     *      *  @default null
		 */
		protected var textField : IUITextField;
		/**
		 *  @private
		 */
		private var toolTipSet : Boolean;
		/**
		 *  @private     *  Storage for the autoRepeat property.
		 */
		private var _autoRepeat : Boolean;
		/**
		 *  @private     *  Storage for the data property;
		 */
		private var _data : Object;
		/**
		 *  @private     *  Storage for the emphasized property.
		 */
		local var _emphasized : Boolean;
		/**
		 *  @private
		 */
		private var emphasizedChanged : Boolean;
		/**
		 *  @private     *  Storage for label property.
		 */
		private var _label : String;
		/**
		 *  @private
		 */
		private var labelChanged : Boolean;
		/**
		 *  @private     *  Storage for labelPlacement property.
		 */
		local var _labelPlacement : String;
		/**
		 *  @private     *  Storage for the listData property.
		 */
		private var _listData : BaseListData;
		/**
		 *  @private     *  Mouse and focus events set this to     *  ButtonPhase.UP, ButtonPhase.OVER, or ButtonPhase.DOWN.
		 */
		private var _phase : String;
		/**
		 *  @private     *  Storage for selected property.
		 */
		local var _selected : Boolean;
		/**
		 *  The name of the field in the <code>data</code> property which specifies     *  the value of the Button control's <code>selected</code> property.      *  You can set this property when you use the Button control in an item renderer.     *  The default value is null, which means that the Button control does      *  not set its selected state based on a property in the <code>data</code> property.     *     *  @default null
		 */
		public var selectedField : String;
		/**
		 *  If <code>false</code>, the Button displays its down skin     *  when the user presses it but changes to its over skin when     *  the user drags the mouse off of it.     *  If <code>true</code>, the Button displays its down skin     *  when the user presses it, and continues to display this skin     *  when the user drags the mouse off of it.     *     *  <p>Button subclasses, such as the SliderThumb and ScrollThumb classes     *  or the up and down arrows of a ScrollBar, set      *  this property to <code>true</code>.</p>     *     *  @default false
		 */
		public var stickyHighlighting : Boolean;
		/**
		 *  @private     *  Storage for toggle property.
		 */
		local var _toggle : Boolean;
		/**
		 *  @private
		 */
		local var toggleChanged : Boolean;

		/**
		 *  @private     *  The baselinePosition of a Button is calculated for its label.
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private     *  This is called whenever the enabled state changes.
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set toolTip (value:String) : void;
		/**
		 *  Specifies whether to dispatch repeated <code>buttonDown</code>     *  events if the user holds down the mouse button.     *     *  @default false
		 */
		public function get autoRepeat () : Boolean;
		/**
		 *  @private
		 */
		public function set autoRepeat (value:Boolean) : void;
		/**
		 *  The <code>data</code> property lets you pass a value     *  to the component when you use it as an item renderer or item editor.     *  You typically use data binding to bind a field of the <code>data</code>     *  property to a property of this component.     *     *  <p>When you use the control as a drop-in item renderer or drop-in     *  item editor, Flex automatically writes the current value of the item     *  to the <code>selected</code> property of this control.</p>     *     *  <p>You do not set this property in MXML.</p>     *     *  @default null     *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  Draws a thick border around the Button control     *  when the control is in its up state if <code>emphasized</code>     *  is set to <code>true</code>.      *     *  @default false
		 */
		public function get emphasized () : Boolean;
		/**
		 *  @private
		 */
		public function set emphasized (value:Boolean) : void;
		/**
		 *  @inheritDoc
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  Text to appear on the Button control.     *     *  <p>If the label is wider than the Button control,     *  the label is truncated and terminated by an ellipsis (...).     *  The full label displays as a tooltip     *  when the user moves the mouse over the Button control.     *  If you have also set a tooltip by using the <code>tooltip</code>     *  property, the tooltip is displayed rather than the label text.</p>     *     *  @default ""
		 */
		public function get label () : String;
		/**
		 *  @private
		 */
		public function set label (value:String) : void;
		/**
		 *  Orientation of the label in relation to a specified icon.     *  Valid MXML values are <code>right</code>, <code>left</code>,     *  <code>bottom</code>, and <code>top</code>.     *     *  <p>In ActionScript, you can use the following constants     *  to set this property:     *  <code>ButtonLabelPlacement.RIGHT</code>,     *  <code>ButtonLabelPlacement.LEFT</code>,     *  <code>ButtonLabelPlacement.BOTTOM</code>, and     *  <code>ButtonLabelPlacement.TOP</code>.</p>     *     *  @default ButtonLabelPlacement.RIGHT
		 */
		public function get labelPlacement () : String;
		/**
		 *  @private
		 */
		public function set labelPlacement (value:String) : void;
		/**
		 *  When a component is used as a drop-in item renderer or drop-in     *  item editor, Flex initializes the <code>listData</code> property     *  of the component with the appropriate data from the list control.     *  The component can then use the <code>listData</code> property     *  to initialize the <code>data</code> property     *  of the drop-in item renderer or drop-in item editor.     *     *  <p>You do not set this property in MXML or ActionScript;     *  Flex sets it when the component is used as a drop-in item renderer     *  or drop-in item editor.</p>     *     *  @default null     *  @see mx.controls.listClasses.IDropInListItemRenderer
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;
		/**
		 *  @private
		 */
		function get phase () : String;
		/**
		 *  @private
		 */
		function set phase (value:String) : void;
		/**
		 *  Indicates whether a toggle button is toggled     *  on (<code>true</code>) or off (<code>false</code>).     *  This property can be set only if the <code>toggle</code> property     *  is set to <code>true</code>.     *     *  <p>For a CheckBox control, indicates whether the box     *  is displaying a check mark. For a RadioButton control,      *  indicates whether the control is selected.</p>     *     *  <p>The user can change this property by clicking the control,     *  but you can also set the property programmatically.</p>     *     *  <p>In previous versions, If the <code>toggle</code> property      *  was set to <code>true</code>, changing this property also dispatched      *  a <code>change</code> event. Starting in version 3.0, setting this      *  property programmatically only dispatches a      *  <code>valueCommit</code> event.</p>     *     *  @default false
		 */
		public function get selected () : Boolean;
		/**
		 *  @private
		 */
		public function set selected (value:Boolean) : void;
		/**
		 *  Controls whether a Button is in a toggle state or not.      *      *  If <code>true</code>, clicking the button toggles it     *  between a selected and an unselected state.     *  You can get or set this state programmatically     *  by using the <code>selected</code> property.     *     *  If <code>false</code>, the button does not stay pressed     *  after the user releases it.     *  In this case, its <code>selected</code> property     *  is always <code>false</code>.     *  Buttons like this are used for performing actions.     *     *  When <code>toggle</code> is set to <code>false</code>,     *  <code>selected</code> is forced to <code>false</code>     *  because only toggle buttons can be selected.     *     *  @default false
		 */
		public function get toggle () : Boolean;
		/**
		 *  @private
		 */
		public function set toggle (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function Button ();
		function setSelected (value:Boolean, isProgrammatic:Boolean = false) : void;
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private      *  Old version of the measure function
		 */
		private function previousVersion_measure () : void;
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
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		protected function adjustFocusRect (object:DisplayObject = null) : void;
		/**
		 *  @private     *  Displays one of the eight possible skins,     *  creating it if it doesn't already exist.
		 */
		function viewSkin () : void;
		/**
		 *  @private     *  Displays one of the several possible skins,     *  depending on the skinName and creating     *  it if it doesn't already exist.
		 */
		function viewSkinForPhase (tempSkinName:String, stateName:String) : void;
		/**
		 *  @private     *  Gets the currentIconName (string) based on the Button's phase.
		 */
		function getCurrentIconName () : String;
		/**
		 *  @private     *  gets the currentIcon based on the button.phase
		 */
		function getCurrentIcon () : IFlexDisplayObject;
		/**
		 *  @private     *  Displays one of the eight possible icons,     *  creating it if it doesn't already exist.
		 */
		function viewIcon () : void;
		/**
		 *  @private     *  Displays one of the several possible icons,     *  depending on the iconName and creating it if it     *  doesn't already exist.
		 */
		function viewIconForPhase (tempIconName:String) : IFlexDisplayObject;
		private function previousVersion_layoutContents (unscaledWidth:Number, unscaledHeight:Number, offset:Boolean) : void;
		/**
		 *  @private     *  Controls the layout of the icon and the label within the button.     *  The text/icon are aligned based on the textAlign style setting.
		 */
		function layoutContents (unscaledWidth:Number, unscaledHeight:Number, offset:Boolean) : void;
		/**
		 *  @private
		 */
		function changeSkins () : void;
		/**
		 *  @private
		 */
		function changeIcons () : void;
		/**
		 *  @private
		 */
		function buttonPressed () : void;
		/**
		 *  @private
		 */
		function buttonReleased () : void;
		/**
		 *  @private     *  Some other components which use a Button as an internal     *  subcomponent need access to its UITextField, but can't access the     *  textField var because it is protected and therefore available     *  only to subclasses.
		 */
		function getTextField () : IUITextField;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;
		/**
		 *  The default handler for the <code>MouseEvent.ROLL_OVER</code> event.     *     *  @param The event object.
		 */
		protected function rollOverHandler (event:MouseEvent) : void;
		/**
		 *  The default handler for the <code>MouseEvent.ROLL_OUT</code> event.     *     *  @param The event object.
		 */
		protected function rollOutHandler (event:MouseEvent) : void;
		/**
		 *  The default handler for the <code>MouseEvent.MOUSE_DOWN</code> event.     *     *  @param The event object.
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  The default handler for the <code>MouseEvent.MOUSE_UP</code> event.     *     *  @param The event object.
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  The default handler for the <code>MouseEvent.CLICK</code> event.     *     *  @param The event object.
		 */
		protected function clickHandler (event:MouseEvent) : void;
		/**
		 *  @private     *  This method is called when the user has pressed the Button     *  and then released the mouse button anywhere.     *  It's purpose is to get the mouseUp event when the user has     *  dragged out of the Button before releasing.     *  However, it gets an inside mouseUp as well;     *  we have to check for this case becuase mouseHandler()     *  already deals with it..
		 */
		private function systemManager_mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  @private     *  This method is called when the user has pressed the Button,     *  dragged of the stage, and released the mouse button.
		 */
		private function stage_mouseLeaveHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function autoRepeatTimer_timerDelayHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function autoRepeatTimer_timerHandler (event:Event) : void;
	}
}
