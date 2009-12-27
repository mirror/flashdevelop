package mx.controls
{
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.system.IME;
	import flash.system.IMEConversionMode;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IIMESupport;
	import mx.core.IInvalidating;
	import mx.core.IRectangularBorder;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.styles.ISimpleStyleClient;

	/**
	 *  Dispatched when text in the TextInput control changes
 *  through user input.
 *  This event does not occur if you use data binding or 
 *  ActionScript code to change the text.
 *
 *  <p>Even though the default value of the <code>Event.bubbles</code> property 
 *  is <code>true</code>, this control dispatches the event with 
 *  the <code>Event.bubbles</code> property set to <code>false</code>.</p>
 *
 *  @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")] 

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

	/**
	 *  Dispatched when the user presses the Enter key.
 *
 *  @eventType mx.events.FlexEvent.ENTER
	 */
	[Event(name="enter", type="mx.events.FlexEvent")] 

	/**
	 *  Dispatched when the user types, deletes, or pastes text into the control.
 *
 *  <p>Even though the default value of the <code>TextEvent.bubbles</code> property 
 *  is <code>true</code>, this control dispatches the event with 
 *  the <code>TextEvent.bubbles</code> property set to <code>false</code>.</p>
 *
 *  @eventType flash.events.TextEvent.TEXT_INPUT
	 */
	[Event(name="textInput", type="flash.events.TextEvent")] 

include "../styles/metadata/BorderStyles.as"
include "../styles/metadata/FocusStyles.as"
include "../styles/metadata/PaddingStyles.as"
include "../styles/metadata/TextStyles.as"
	/**
	 *  Number of pixels between the component's bottom border
 *  and the bottom edge of its content area.
 *
 *  @default 0
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the component's top border
 *  and the top edge of its content area.
 *  
 *  @default 0
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

include "../core/Version.as"
	/**
	 *  The TextInput control is a single-line text field
 *  that is optionally editable.
 *  All text in this control must use the same styling
 *  unless it is HTML text.
 *  The TextInput control supports the HTML rendering
 *  capabilities of Flash Player and AIR.
 *
 *  <p>TextInput controls do not include a label, although you
 *  can add one by using a Label control or by nesting the
 *  TextInput control in a FormItem control in a Form container.
 *  When used in a FormItem control, a TextInput control
 *  indicates whether a value is required.
 *  TextInput controls have a number of states, including filled,
 *  selected, disabled, and error.
 *  TextInput controls support formatting, validation, and keyboard
 *  equivalents; they also dispatch change and enter events.</p>
 *
 *  <p>If you disable a TextInput control, it displays its contents
 *  in the color specified by the <code>disabledColor</code>
 *  style.
 *  To disallow editing the text, you set the <code>editable</code>
 *  property to <code>false</code>.
 *  To conceal the input text by displaying asterisks instead of the
 *  characters entered, you set the <code>displayAsPassword</code> property
 *  to <code>true</code>.</p>
 * 
 *  <p>The TextInput control is used as a subcomponent in several other controls,
 *  such as the RichTextEditor, NumericStepper, and ComboBox controls. As a result,
 *  if you assign style properties to a TextInput control by using a CSS type selector, 
 *  Flex applies those styles to the TextInput when it appears in the other controls 
 *  unless you explicitly override them.</p>
 *
 *  <p>The TextInput control has the following default sizing characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>The size of the text with a default minimum size of 22 pixels high and 160 pixels wide</td>
 *        </tr>
 *        <tr>
 *           <td>Minimum size</td>
 *           <td>0 pixels</td>
 *        </tr>
 *        <tr>
 *           <td>Maximum size</td>
 *           <td>10000 by 10000 pixels</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:TextInput&gt;</code> tag inherits the attributes
 *  of its superclass and adds the following attributes:</p>
 *
 *  <pre>
 *  &lt;mx:TextInput
 *    <b>Properties</b>
 *    condenseWhite="false|true"
 *    data="undefined"
 *    displayAsPassword="false|true"
 *    editable="true|false"
 *    horizontalScrollPosition="0"
 *    htmlText=""
 *    imeMode="null"
 *    length="0"
 *    listData="null"
 *    maxChars="0"
 *    restrict="null"
 *    selectionBeginIndex="0"
 *    selectionEndIndex="0"
 *    text=""
 *    textHeight="0"
 *    textWidth="0"
 *    &nbsp;
 *    <b>Styles</b>
 *    backgroundAlpha="1.0"
 *    backgroundColor="undefined"
 *    backgroundImage="undefined"
 *    backgroundSize="auto"
 *    borderColor="0xAAB3B3"
 *    borderSides="left top right bottom"
 *    borderSkin="mx.skins.halo.HaloBorder"
 *    borderStyle="inset"
 *    borderThickness="1"
 *    color="0x0B333C"
 *    cornerRadius="0"
 *    disabledColor="0xAAB3B3"
 *    dropShadowColor="0x000000"
 *    dropShadowEnabled="false"
 *    focusAlpha="0.5"
 *    focusRoundedCorners"tl tr bl br"
 *    fontAntiAliasType="advanced|normal"
 *    fontFamily="Verdana"
 *    fontGridFitType="pixel|none|subpixel"
 *    fontSharpness="0"
 *    fontSize="10"
 *    fontStyle="normal|italic"
 *    fontThickness="0"
 *    fontWeight="normal|bold"
 *    paddingLeft="0"
 *    paddingRight="0"
 *    shadowDirection="center"
 *    shadowDistance="2"
 *    textAlign="left|right|center"
 *    textDecoration="none|underline"
 *    textIndent="0"
 *    &nbsp;
 *    <b>Events</b>
 *    change="<i>No default</i>"
 *    dataChange="<i>No default</i>"
 *    enter="<i>No default</i>"
 *    textInput="<i>No default</i>"
 *  /&gt;
 *  </pre>
 *
 *  @includeExample examples/TextInputExample.mxml
 *
 *  @see mx.controls.Label
 *  @see mx.controls.Text
 *  @se
	 */
	public class TextInput extends UIComponent implements IDataRenderer
	{
		/**
		 *  The internal subcontrol that draws the border and background.
		 */
		var border : IFlexDisplayObject;
		/**
		 *  @private
     *  Flag that will block default data/listData behavior.
		 */
		private var textSet : Boolean;
		/**
		 *  @private
		 */
		private var selectionChanged : Boolean;
		/**
		 *  @private
     *  If true, pass calls to drawFocus() up to the parent.
     *  This is used when a TextInput is part of a composite control
     *  like NumericStepper or ComboBox;
		 */
		var parentDrawsFocus : Boolean;
		/**
		 *  @private
     *  Previous imeMode.
		 */
		private var prevMode : String;
		/**
		 *  @private
		 */
		private var errorCaught : Boolean;
		/**
		 *  @private
     *  Storage for the accessibilityProperties property.
		 */
		private var _accessibilityProperties : AccessibilityProperties;
		/**
		 *  @private
		 */
		private var accessibilityPropertiesChanged : Boolean;
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
		 */
		private var _condenseWhite : Boolean;
		/**
		 *  @private
		 */
		private var condenseWhiteChanged : Boolean;
		/**
		 *  @private
     *  Storage for the data property.
		 */
		private var _data : Object;
		/**
		 *  @private
     *  Storage for the displayAsPassword property.
		 */
		private var _displayAsPassword : Boolean;
		/**
		 *  @private
		 */
		private var displayAsPasswordChanged : Boolean;
		/**
		 *  @private
     *  Storage for the editable property.
		 */
		private var _editable : Boolean;
		/**
		 *  @private
		 */
		private var editableChanged : Boolean;
		/**
		 *  @private
     *  Used to store the init time value if any.
		 */
		private var _horizontalScrollPosition : Number;
		/**
		 *  @private
		 */
		private var horizontalScrollPositionChanged : Boolean;
		/**
		 *  @private
     *  Storage for the htmlText property.
     *  In addition to being set in the htmlText setter,
     *  it is automatically updated at two other times.
     *  1. When the 'text' or 'htmlText' is pushed down into
     *  the textField in commitProperties(), this causes
     *  the textField to update its own 'htmlText'.
     *  Therefore in commitProperties() we reset this storage var
     *  to be in sync with the textField.
     *  2. When the TextFormat of the textField changes
     *  because a CSS style has changed (see validateNow()
     *  in UITextField), the textField also updates its own 'htmlText'.
     *  Therefore in textField_textFieldStyleChangeHandler()
		 */
		private var _htmlText : String;
		/**
		 *  @private
		 */
		private var htmlTextChanged : Boolean;
		/**
		 *  @private
     *  The last value of htmlText that was set.
     *  We have to keep track of this because when you set the htmlText
     *  of a TextField and read it back, you don't get what you set.
     *  In general it will have additional HTML markup corresponding
     *  to the defaultTextFormat set from the CSS styles.
     *  If this var is null, it means that 'text' rather than 'htmlText'
     *  was last set.
		 */
		private var explicitHTMLText : String;
		/**
		 *  @private
		 */
		private var _imeMode : String;
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
     *  Storage for the restrict property.
		 */
		private var _restrict : String;
		/**
		 *  @private
		 */
		private var restrictChanged : Boolean;
		/**
		 *  @private
     *  Used to make TextInput function correctly in the components that use it
     *  as a subcomponent. ComboBox, at this point.
		 */
		private var _selectable : Boolean;
		/**
		 *  @private
		 */
		private var selectableChanged : Boolean;
		/**
		 *  @private
     *  Storage for the selectionBeginIndex property.
		 */
		private var _selectionBeginIndex : int;
		/**
		 *  @private
     *  Storage for the selectionEndIndex property.
		 */
		private var _selectionEndIndex : int;
		/**
		 *  @private
     *  Storage for the text property.
     *  In addition to being set in the 'text' setter,
     *  it is automatically updated at another time:
     *  When the 'text' or 'htmlText' is pushed down into
     *  the textField in commitProperties(), this causes
     *  the textField to update its own 'text'.
     *  Therefore in commitProperties() we reset this storage var
     *  to be in sync with the textField.
		 */
		private var _text : String;
		/**
		 *  @private
		 */
		private var textChanged : Boolean;
		/**
		 *  The internal UITextField that renders the text of this TextInput.
		 */
		protected var textField : IUITextField;
		/**
		 *  @private
		 */
		private var _textHeight : Number;
		/**
		 *  @private
		 */
		private var _textWidth : Number;

		/**
		 *  @private
     *  Storage for the accessibilityProperties property.
		 */
		public function get accessibilityProperties () : AccessibilityProperties;
		/**
		 *  @private
     *  Accessibility data.
     *
     *  @tiptext
     *  @helpid 3199
		 */
		public function set accessibilityProperties (value:AccessibilityProperties) : void;

		/**
		 *  @private
     *  The baselinePosition of a TextInput is calculated for its textField.
		 */
		public function get baselinePosition () : Number;

		/**
		 *  @private
     *  Disable TextField when we're disabled.
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  @inheritDoc
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;

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
		 *  Specifies whether extra white space (spaces, line breaks,
     *  and so on) should be removed in a TextInput control with HTML text.
     *
     *  <p>The <code>condenseWhite</code> property affects only text set with
     *  the <code>htmlText</code> property, not the <code>text</code> property.
     *  If you set text with the <code>text</code> property,
     *  <code>condenseWhite</code> is ignored.</p>
     *
     *  <p>If you set the <code>condenseWhite</code> property to <code>true</code>,
     *  you must use standard HTML commands, such as <code>&lt;br&gt;</code>
     *  and <code>&lt;p&gt;</code>, to place line breaks in the text field.</p>
     *
     *  @default false;
		 */
		public function get condenseWhite () : Boolean;
		/**
		 *  @private
		 */
		public function set condenseWhite (value:Boolean) : void;

		/**
		 *  Lets you pass a value to the component
     *  when you use it in an item renderer or item editor.
     *  You typically use data binding to bind a field of the <code>data</code>
     *  property to a property of this component.
     *
     *  <p>When you use the control as a drop-in item renderer or drop-in
     *  item editor, Flex automatically writes the current value of the item
     *  to the <code>text</code> property of this control.</p>
     *
     *  <p>You do not set this property in MXML.</p>
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
		 *  Indicates whether this control is used for entering passwords.
     *  If <code>true</code>, the field does not display entered text,
     *  instead, each text character entered into the control
     *  appears as the  character "&#42;".
     *
     *  @default false
     *  @tiptext Specifies whether to display '*'
     *  instead of the actual characters
     *  @helpid 3197
		 */
		public function get displayAsPassword () : Boolean;
		/**
		 *  @private
		 */
		public function set displayAsPassword (value:Boolean) : void;

		/**
		 *  Indicates whether the user is allowed to edit the text in this control.
     *  If <code>true</code>, the user can edit the text.
     *
     *  @default true
     * 
     *  @tiptext Specifies whether the component is editable or not
     *  @helpid 3196
		 */
		public function get editable () : Boolean;
		/**
		 *  @private
		 */
		public function set editable (value:Boolean) : void;

		/**
		 *  Pixel position in the content area of the leftmost pixel
     *  that is currently displayed. 
     *  (The content area includes all contents of a control, not just 
     *  the portion that is currently displayed.)
     *  This property is always set to 0, and ignores changes,
     *  if <code>wordWrap</code> is set to <code>true</code>.
     * 
     *  @default 0

     *  @tiptext The pixel position of the left-most character
     *  that is currently displayed
     *  @helpid 3194
		 */
		public function get horizontalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set horizontalScrollPosition (value:Number) : void;

		/**
		 *  Specifies the text displayed by the TextInput control, including HTML markup that
     *  expresses the styles of that text.
     *  When you specify HTML text in this property, you can use the subset of HTML 
     *  tags that is supported by the Flash TextField control.
     * 
     *  <p> When you set this property, the HTML markup is applied
     *  after the CSS styles for the TextInput instance are applied.
     *  When you get this property, the HTML markup includes
     *  the CSS styles.</p>
     *  
     *  <p>For example, if you set this to be a string such as,
     *  <code>"This is an example of &lt;b&gt;bold&lt;/b&gt; markup"</code>,
     *  the text "This is an example of <b>bold</b> markup" appears
     *  in the TextInput with whatever CSS styles normally apply.
     *  Also, the word "bold" appears in boldface font because of the
     *  <code>&lt;b&gt;</code> markup.</p>
     *
     *  <p>HTML markup uses characters such as &lt; and &gt;,
     *  which have special meaning in XML (and therefore in MXML). So,  
     *  code such as the following does not compile:</p>
     *  
     *  <pre>
     *  &lt;mx:TextInput htmlText="This is an example of &lt;b&gt;bold&lt;/b&gt; markup"/&gt;
     *  </pre>
     *  
     *  <p>There are three ways around this problem.</p>
     *  
     *  <ul>
     *  
     *  <li>
     *  
     *  <p>Set the <code>htmlText</code> property in an ActionScript method called as 
     *  an <code>initialize</code> handler:</p>
     *  
     *  <pre>
     *  &lt;mx:TextInput id="myTextInput" initialize="myTextInput_initialize()"/&gt;
     *  </pre>
     *  
     *  <p>where the <code>myTextInput_initialize</code> method is in a script CDATA section:</p>
     *  
     *  <pre>
     *  &lt;mx:Script&gt;
     *  &lt;![CDATA[
     *  private function myTextInput_initialize():void {
     *      myTextInput.htmlText = "This is an example of &lt;b&gt;bold&lt;/b&gt; markup";
     *  }
     *  ]]&gt;
     *  &lt;/mx:Script&gt;
     *  
     *  </pre>
     *  
     *  <p>This is the simplest approach because the HTML markup
     *  remains easily readable.
     *  Notice that you must assign an <code>id</code> to the TextInput
     *  so you can refer to it in the <code>initialize</code>
     *  handler.</p>
     *  
     *  </li>
     *  
     *  <li>
     *  
     *  <p>Specify the <code>htmlText</code> property by using a child tag
     *  with a CDATA section. A CDATA section in XML contains character data
     *  where characters like &lt; and &gt; aren't given a special meaning.</p>
     *  
     *  <pre>
     *  &lt;mx:TextInput&gt;
     *      &lt;mx:htmlText&gt;&lt;![CDATA[This is an example of &lt;b&gt;bold&lt;/b&gt; markup]]&gt;&lt;/mx:htmlText&gt;
     *  &lt;mx:TextInput/&gt;
     *  </pre>
     *  
     *  <p>You must write the <code>htmlText</code> property as a child tag
     *  rather than as an attribute on the <code>&lt;mx:TextInput&gt;</code> tag
     *  because XML doesn't allow CDATA for the value of an attribute.
     *  Notice that the markup is readable, but the CDATA section makes 
     *  this approach more complicated.</p>
     *  
     *  </li>
     *  
     *  <li>
     *  
     *  <p>Use an <code>hmtlText</code> attribute where any occurences
     *  of the HTML markup characters &lt; and &gt; in the attribute value
     *  are written instead as the XML "entities" <code>&amp;lt;</code>
     *  and <code>&amp;gt;</code>:</p>
     *  
     *  <pre>
     *  &lt;mx:TextInput htmlText="This is an example of &amp;lt;b&amp;gt;bold&amp;lt;/b&amp;gt; markup"/&amp;gt;
     *  </pre>
     *  
     *  Adobe does not recommend this approach because the HTML markup becomes
     *  nearly impossible to read.
     *  
     *  </li>
     *  
     *  </ul>
     *  
     *  <p>If the <code>condenseWhite</code> property is <code>true</code> 
     *  when you set the <code>htmlText</code> property, multiple
     *  white-space characters are condensed, as in HTML-based browsers;
     *  for example, three consecutive spaces are displayed
     *  as a single space.
     *  The
		 */
		public function get htmlText () : String;
		/**
		 *  @private
		 */
		public function set htmlText (value:String) : void;

		/**
		 *  Specifies the IME (input method editor) mode.
     *  The IME enables users to enter text in Chinese, Japanese, and Korean.
     *  Flex sets the specified IME mode when the control gets the focus,
     *  and sets it back to the previous value when the control loses the focus.
     *
     *  <p>The flash.system.IMEConversionMode class defines constants for the
     *  valid values for this property.
     *  You can also specify <code>null</code> to specify no IME.</p>
     *
     *  @default null
     * 
     *  @see flash.system.IMEConversionMode
		 */
		public function get imeMode () : String;
		/**
		 *  @private
		 */
		public function set imeMode (value:String) : void;

		/**
		 *  @private
		 */
		private function get isHTML () : Boolean;

		/**
		 *  The number of characters of text displayed in the TextArea.
     *
     *  @default 0
     *  @tiptext The number of characters in the TextInput.
     *  @helpid 3192
		 */
		public function get length () : int;

		/**
		 *  When a component is used as a drop-in item renderer or drop-in
     *  item editor, Flex initializes the <code>listData</code> property
     *  of the component with the appropriate data from the list control.
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
		 *  Maximum number of characters that users can enter in the text field.
     *  This property does not limit the length of text specified by the
     *  setting the control's <code>text</code> or <code>htmlText</code> property.
     * 
     *  <p>The default value is 0, which is a special case
     *  meaning an unlimited number.</p>
     *
     *  @tiptext The maximum number of characters
     *  that the TextInput can contain
     *  @helpid 3191
		 */
		public function get maxChars () : int;
		/**
		 *  @private
		 */
		public function set maxChars (value:int) : void;

		/**
		 *  @private 
     *  Maximum value of <code>horizontalScrollPosition</code>.
     * 
     *  <p>The default value is 0, which means that horizontal scrolling is not 
     *  required.</p>
     *
     *  <p>The value of the <code>maxHorizontalScrollPosition</code> property is
     *  computed from the data and size of component, and must not be set by
     *  the application code.</p>
		 */
		public function get maxHorizontalScrollPosition () : Number;

		/**
		 *  Indicates the set of characters that a user can enter into the control. 
     *  If the value of the <code>restrict</code> property is <code>null</code>, 
     *  you can enter any character. If the value of the <code>restrict</code> 
     *  property is an empty string, you cannot enter any character.
     *  This property only restricts user interaction; a script
     *  can put any text into the text field. If the value of
     *  the <code>restrict</code> property is a string of characters,
     *  you may enter only characters in that string into the
     *  text field.
     *
     *  <p>Flex scans the string from left to right. You can specify a range by 
     *  using the hyphen (-) character.
     *  If the string begins with a caret (^) character, all characters are 
     *  initially accepted and succeeding characters in the string are excluded 
     *  from the set of accepted characters. If the string does not begin with a 
     *  caret (^) character, no characters are initially accepted and succeeding 
     *  characters in the string are included in the set of accepted characters.</p>
     * 
     *  <p>Because some characters have a special meaning when used
     *  in the <code>restrict</code> property, you must use
     *  backslash characters to specify the literal characters -, &#094;, and \.
     *  When you use the <code>restrict</code> property as an attribute
     *  in an MXML tag, use single backslashes, as in the following 
     *  example: \&#094;\-\\.
     *  When you set the <code>restrict</code> In and ActionScript expression,
     *  use double backslashes, as in the following example: \\&#094;\\-\\\.</p>
     *
     *  @default null
     *  @see flash.text.TextField#restrict
     *  @tiptext The set of characters that may be entered
     *  into the TextInput.
     *  @helpid 3193
		 */
		public function get restrict () : String;
		/**
		 *  @private
		 */
		public function set restrict (value:String) : void;

		/**
		 *  @private
		 */
		function get selectable () : Boolean;
		/**
		 *  @private
		 */
		function set selectable (value:Boolean) : void;

		/**
		 *  The zero-based character index value of the first character
     *  in the current selection.
     *  For example, the first character is 0, the second character is 1,
     *  and so on.
     *  When the control gets the focus, the selection is visible if the 
     *  <code>selectionBeginIndex</code> and <code>selectionEndIndex</code>
     *  properties are both set.
     *
     *  @default 0
     * 
     *  @tiptext The zero-based index value of the first character
     *  in the selection.
		 */
		public function get selectionBeginIndex () : int;
		/**
		 *  @private
		 */
		public function set selectionBeginIndex (value:int) : void;

		/**
		 *  The zero-based index of the position <i>after</i> the last character
     *  in the current selection (equivalent to the one-based index of the last
     *  character).
     *  If the last character in the selection, for example, is the fifth
     *  character, this property has the value 5.
     *  When the control gets the focus, the selection is visible if the 
     *  <code>selectionBeginIndex</code> and <code>selectionEndIndex</code>
     *  properties are both set.
     *
     *  @default 0
     *
     *  @tiptext The zero-based index value of the last character
     *  in the selection.
		 */
		public function get selectionEndIndex () : int;
		/**
		 *  @private
		 */
		public function set selectionEndIndex (value:int) : void;

		/**
		 *  Plain text that appears in the control.
     *  Its appearance is determined by the CSS styles of this Label control.
     *  
     *  <p>Any HTML tags in the text string are ignored,
     *  and appear as entered in the string. 
     *  To display text formatted using HTML tags,
     *  use the <code>htmlText</code> property instead.
     *  If you set the <code>htmlText</code> property,
     *  the HTML replaces any text you had set using this propety, and the
     *  <code>text</code> property returns a plain-text version of the
     *  HTML text, with all HTML tags stripped out. For more information
     *  see the <code>htmlText</code> property.</p>
     *
     *  <p>To include the special characters left angle  bracket (&lt;),
     *  right angle bracket (&gt;), or ampersand (&amp;) in the text,
     *  wrap the text string in the CDATA tag.
     *  Alternatively, you can use HTML character entities for the
     *  special characters, for example, <code>&amp;lt;</code>.</p>
     *
     *  <p>If you try to set this property to <code>null</code>,
     *  it is set, instead, to the empty string.
     *  The <code>text</code> property can temporarily have the value <code>null</code>,
     *  which indicates that the <code>htmlText</code> has been recently set
     *  and the corresponding <code>text</code> value
     *  has not yet been determined.</p>
     *
     *  @default ""
     *  @tiptext Gets or sets the TextInput content
     *  @helpid 3190
		 */
		public function get text () : String;
		/**
		 *  @private
		 */
		public function set text (value:String) : void;

		/**
		 *  The height of the text.
     *
     *  <p>The value of the <code>textHeight</code> property is correct only
     *  after the component has been validated.
     *  If you set <code>text</code> and then immediately ask for the
     *  <code>textHeight</code>, you might receive an incorrect value.
     *  You should wait for the component to validate
     *  or call the <code>validateNow()</code> method before you get the value.
     *  This behavior differs from that of the flash.text.TextField control,
     *  which updates the value immediately.</p>
     *
     *  @see flash.text.TextField
		 */
		public function get textHeight () : Number;

		/**
		 *  The width of the text.
     *
     *  <p>The value of the <code>textWidth</code> property is correct only
     *  after the component has been validated.
     *  If you set <code>text</code> and then immediately ask for the
     *  <code>textWidth</code>, you might receive an incorrect value.
     *  You should wait for the component to validate
     *  or call the <code>validateNow()</code> method before you get the value.
     *  This behavior differs from that of the flash.text.TextField control,
     *  which updates the value immediately.</p>
     *
     *  @see flash.text.TextField
		 */
		public function get textWidth () : Number;

		/**
		 *  Constructor.
		 */
		public function TextInput ();

		/**
		 *  @private
     *  Create child objects.
		 */
		protected function createChildren () : void;

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
     *  Stretch the border and fit the TextField inside it.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
     *  Focus should always be on the internal TextField.
		 */
		public function setFocus () : void;

		/**
		 *  @private
		 */
		protected function isOurFocus (target:DisplayObject) : Boolean;

		/**
		 *  @private
     *  Forward the drawFocus to the parent, if requested
		 */
		public function drawFocus (isFocused:Boolean) : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
     *  Creates the text field child and adds it as a child of this component.
     * 
     *  @param childIndex The index of where to add the child.
     *  If -1, the text field is appended to the end of the list.
		 */
		function createTextField (childIndex:int) : void;

		/**
		 *  @private
     *  Removes the text field from this component.
		 */
		function removeTextField () : void;

		/**
		 *  Creates the border for this component.
     *  Normally the border is determined by the
     *  <code>borderStyle</code> and <code>borderSkin</code> styles.  
     *  It must set the border property to the instance
     *  of the border.
		 */
		protected function createBorder () : void;

		/**
		 *  Returns a TextLineMetrics object with information about the text 
     *  position and measurements for a line of text in the control.
     *  The component must be validated to get a correct number.
     *  If you set the <code>text</code> or <code>htmlText</code> property
     *  and then immediately call
     *  <code>getLineMetrics()</code> you may receive an incorrect value.
     *  You should either wait for the component to validate
     *  or call <code>validateNow()</code>.
     *  This is behavior differs from that of the flash.text.TextField class,
     *  which updates the value immediately.
     * 
     *  @param lineIndex The zero-based index of the line for which to get the metrics. 
     *
     *  @return The object that contains information about the text position
     *  and measurements for the specified line of text in the control.
     * 
     *  @see flash.text.TextField
     *  @see flash.text.TextLineMetrics
		 */
		public function getLineMetrics (lineIndex:int) : TextLineMetrics;

		/**
		 *  Selects the text in the range specified by the parameters.
     *  If the control is not in focus, the selection highlight will not show 
     *  until the control gains focus. Also, if the focus is gained by clicking 
     *  on the control, any previous selection would be lost.
     *  If the two parameter values are the same,
     *  the new selection is an insertion point.
     *
     *  @param beginIndex The zero-based index of the first character in the
     *  selection; that is, the first character is 0, the second character
     *  is 1, and so on.
     *
     *  @param endIndex The zero-based index of the position <i>after</i>
     *  the last character in the selection (equivalent to the one-based
     *  index of the last character).
     *  If the parameter is 5, the last character in the selection, for
     *  example, is the fifth character.
     *  When the TextInput control gets the focus, the selection is visible 
     *  if the <code>selectionBeginIndex</code> and <code>selectionEndIndex</code>
     *  properties are both set.
     *
     *  @tiptext Sets a new text selection.
		 */
		public function setSelection (beginIndex:int, endIndex:int) : void;

		/**
		 *  @private
     *  Setting the 'htmlText' of textField changes its 'text',
     *  and vice versa, so afterwards doing so we call this method
     *  to update the storage vars for various properties.
     *  Afterwards, the TextInput's 'text', 'htmlText', 'textWidth',
     *  and 'textHeight' are all in sync with each other
     *  and are identical to the TextField's.
		 */
		private function textFieldChanged (styleChangeOnly:Boolean, dispatchValueCommitEvent:Boolean) : void;

		/**
		 *  @private
     *  Some other components which use a TextInput as an internal
     *  subcomponent need access to its UITextField, but can't access the
     *  textField var because it is protected and therefore available
     *  only to subclasses.
		 */
		function getTextField () : IUITextField;

		/**
		 *  @private
     *  Gets called by internal field so we draw a focus rect around us.
		 */
		protected function focusInHandler (event:FocusEvent) : void;

		/**
		 *  @private
     *  Gets called by internal field so we remove focus rect.
		 */
		protected function focusOutHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		private function textField_changeHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function textField_nativeDragDropHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function textField_textInputHandler (event:TextEvent) : void;

		/**
		 *  @private
		 */
		private function textField_scrollHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function textField_textFieldStyleChangeHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function textField_textFormatChangeHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function textField_textModifiedHandler (event:Event) : void;
	}
}
