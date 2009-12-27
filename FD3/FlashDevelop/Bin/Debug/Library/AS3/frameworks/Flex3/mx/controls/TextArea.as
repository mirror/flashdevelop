package mx.controls
{
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.system.IME;
	import flash.system.IMEConversionMode;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IIMESupport;
	import mx.core.IInvalidating;
	import mx.core.IUITextField;
	import mx.core.ScrollControlBase;
	import mx.core.ScrollPolicy;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.events.ScrollEventDirection;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

	/**
	 *  Dispatched when text in the TextArea control changes
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
	 *  Dispatched when a user clicks a hyperlink in text defined by the
 *  <code>htmlText</code> property, where the URL begins with <code>"event:"</code>. 
 *  The remainder of the URL after 
 *  <code>"event:"</code> is placed in the text property of the <code>link</code> event object.
 *
 *  <p>When you handle the <code>link</code> event, the hyperlink is not automatically executed; 
 *  you need to execute the hyperlink from within your event handler. 
 *  You typically use the <code>navigateToURL()</code> method to execute the hyperlink.
 *  This allows you to modify the hyperlink, or even prohibit it from occurring, 
 *  in your application. </p>
 *
 *  @eventType flash.events.TextEvent.LINK
	 */
	[Event(name="link", type="flash.events.TextEvent")] 

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

include "../styles/metadata/FocusStyles.as"
include "../styles/metadata/PaddingStyles.as"
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

	/**
	 *  Color of the component if it is disabled.
 * 
 *  @default 0xAAB3B3
	 */
	[Style(name="disabledColor", type="uint", format="Color", inherit="yes")] 

	[Exclude(name="maxHorizontalScrollPosition", kind="property")] 

	[Exclude(name="maxVerticalScrollPosition", kind="property")] 

include "../core/Version.as"
	/**
	 *  The TextArea control is a multiline text field
 *  with a border and optional scroll bars.
 *  The TextArea control supports the HTML rendering capabilities
 *  of Flash Player and AIR.
 *
 *  <p>If you disable a TextArea control, it displays its contents in the
 *  color specified by the <code>disabledColor</code> style.
 *  You can also set a TextArea control to read-only
 *  to disallow editing of the text.
 *  To conceal input text by displaying characters as asterisks,
 *  set the TextArea's <code>displayAsPassword</code> property.</p>
 *
 *  <p>The TextArea control has the following default sizing characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>width: 160 pixels; height: 44 pixels</td>
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
 *  <p>The <code>&lt;mx:TextArea&gt;</code> tag inherits the attributes
 *  of its superclass and adds the following attributes:</p>
 *
 *  <pre>
 *  &lt;mx:TextArea
 *    <b>Properties</b>
 *    condenseWhite="false|true"
 *    data="undefined"
 *    displayAsPassword="false|true"
 *    editable="true|false"
 *    horizontalScrollPolicy="auto|on|off"
 *    horizontalScrollPosition="0"
 *    htmlText="null"
 *    imeMode="null"
 *    length="0"
 *    listData="null"
 *    maxChars="0"
 *    restrict="null"
 *    selectionBeginIndex="0"
 *    selectionEndIndex="0"
 *    styleSheet="null"
 *    text=""
 *    textHeight="<i>height of text</i>" [read-only]
 *    textWidth="<i>width of text</i>" [read-only]
 *    verticalScrollPolicy="auto|on|off"
 *    verticalScrollPosition="0"
 *    wordWrap="true|false"
 *    &nbsp;
 *    <b>Styles</b>
 *    disabledColor="0xAAB3B3"
 *    focusAlpha="0.5"
 *    focusRoundedCorners"tl tr bl br"
 *    paddingLeft="0""
 *    paddingRight="0""
 *    &nbsp;
 *    <b>Events</b>
 *    change="<i>No default</i>"
 *  /&gt;
 *  </pre>
 *
 *  @see mx.controls.Label
 *  @see mx.controls.Text
 *  @see mx.controls.TextInput
 *  @see mx.controls.RichTextEditor
 *  @see mx.controls.textClasses.TextRange
 *
 *  @includeExample examples/TextAreaExample.mxml
 *
	 */
	public class TextArea extends ScrollControlBase implements IDataRenderer
	{
		/**
		 *  @private
     *  Flag that indicates whether scroll Events should be dispatched
		 */
		private var allowScrollEvent : Boolean;
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
     *  Position of the horizontal scrollbar.
		 */
		private var _hScrollPosition : Number;
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
		 *  The internal UITextField that renders the text of this TextArea.
		 */
		protected var textField : IUITextField;
		/**
		 *  @private
     *  Position of the vertical scrollbar.
		 */
		private var _vScrollPosition : Number;
		/**
		 *  @private
     *  Storage for the condenseWhite property.
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
     *  Storage for the displayAsPassword proeprty.
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
     *  Storage for the restrict property.
		 */
		private var _restrict : String;
		/**
		 *  @private
		 */
		private var restrictChanged : Boolean;
		/**
		 *  @private
     *  Storage for selectable property.
		 */
		private var _selectable : Boolean;
		/**
		 *  @private
     *  Change flag for selectable property.
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
     *  Change flag for the styleSheet property
		 */
		private var styleSheetChanged : Boolean;
		/**
		 *  @private
     *  Storage for the styleSheet property.
		 */
		private var _styleSheet : StyleSheet;
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
		 *  @private
		 */
		private var _textHeight : Number;
		/**
		 *  @private
		 */
		private var _textWidth : Number;
		/**
		 *  @private
     *  Storage for the wordWrap property.
		 */
		private var _wordWrap : Boolean;
		/**
		 *  @private
		 */
		private var wordWrapChanged : Boolean;

		/**
		 *  @private
     *  Accessibility data.
     *
     *  @tiptext
     *  @helpid 3185
		 */
		public function get accessibilityProperties () : AccessibilityProperties;
		/**
		 *  @private
		 */
		public function set accessibilityProperties (value:AccessibilityProperties) : void;

		/**
		 *  @private
     *  The baselinePosition of a TextArea is calculated for its textField.
		 */
		public function get baselinePosition () : Number;

		/**
		 *  @private
     *  Disable scrollbars and text field if we're disabled.
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;

		/**
		 *  Pixel position in the content area of the leftmost pixel
     *  that is currently displayed. 
     *  (The content area includes all contents of a control, not just 
     *  the portion that is currently displayed.)
     *  This property is always set to 0, and ignores changes,
     *  if <code>wordWrap</code> is set to <code>true</code>.
     * 
     *  @default 0
     *
		 */
		public function set horizontalScrollPosition (value:Number) : void;

		/**
		 *  Specifies whether the horizontal scroll bar is
     *  always on (<code>ScrollPolicy.ON</code>),
     *  always off (<code>ScrollPolicy.OFF</code>),
     *  or turns on when needed (<code>ScrollPolicy.AUTO</code>).
     *
     *  @default ScrollPolicy.AUTO
     *
		 */
		public function get horizontalScrollPolicy () : String;

		/**
		 *  Maximum value of <code>horizontalScrollPosition</code>.
     *  <p>The default value is 0, which means that horizontal scrolling is not 
     *  required.</p>
     *  This property is always set to 0
     *  if <code>wordWrap</code> is set to <code>true</code>.
     * 
     *  <p>The value of the <code>maxHorizontalScrollPosition</code> property is
     *  computed from the data and size of component, and must not be set by
     *  the application code.</p>
     * 
     *  @default 0
     *
		 */
		public function get maxHorizontalScrollPosition () : Number;

		/**
		 *  Maximum value of <code>verticalScrollPosition</code>.
     *  The default value is 0, which means that vertical scrolling is not 
     *  required.
     *
     *  <p>The value of the <code>maxVerticalScrollPosition</code> property is
     *  computed from the data and size of component, and must not be set by
     *  the application code.</p>
     * 
     *  @tiptext The maximum pixel offset into the content from the top edge
     *  @helpid 3182
		 */
		public function get maxVerticalScrollPosition () : Number;

		/**
		 *  @private
     *  Tab order in which the control receives the focus when navigating
     *  with the Tab key.
     *
     *  @default -1
     *  @tiptext tabIndex of the component
     *  @helpid 3184
		 */
		public function get tabIndex () : int;
		/**
		 *  @private
		 */
		public function set tabIndex (value:int) : void;

		/**
		 *  Line number of the top row of characters that is currently displayed.
     *  The default value is 0.
     *
     *  @tiptext The pixel offset into the content from the top edge
     *  @helpid 3181
		 */
		public function set verticalScrollPosition (value:Number) : void;

		/**
		 *  Whether the vertical scroll bar is
     *  always on (<code>ScrollPolicy.ON</code>),
     *  always off (<code>ScrollPolicy.OFF</code>),
     *  or turns on when needed (<code>ScrollPolicy.AUTO</code>).
     *
     *  @default ScrollPolicy.AUTO
     *  @tiptext Specifies if vertical scrollbar is on, off,
     *  or automatically adjusts
     *  @helpid 3428
		 */
		public function get verticalScrollPolicy () : String;

		/**
		 *  Specifies whether extra white space (spaces, line breaks,
     *  and so on) should be removed in a TextArea control with HTML text.
     *  
     *  <p>The <code>condenseWhite</code> property only affects text set with
     *  the <code>htmlText</code> property, not the <code>text</code> property.
     *  If you set text with the <code>text</code> property,
     *  <code>condenseWhite</code> is ignored.</p>
     *
     *  <p>If you set the <code>condenseWhite</code> property to <code>true</code>,
     *  you must use standard HTML commands such as <code>&lt;br&gt;</code>
     *  and <code>&lt;p&gt;</code> to place line breaks in the text field.</p>
     *
     *  @default false
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
     * 
     *  @tiptext Specifies whether to display '*'
     *  instead of the actual characters
     *  @helpid 3177
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
     *  @default true;
     * 
     *  @tiptext Specifies whether the component is editable or not
     *  @helpid 3176
		 */
		public function get editable () : Boolean;
		/**
		 *  @private
		 */
		public function set editable (value:Boolean) : void;

		/**
		 *  Specifies the text displayed by the TextArea control, including HTML markup that
     *  expresses the styles of that text.  
     *  When you specify HTML text in this property, you can use the subset of HTML 
     *  tags that is supported by the Flash TextField control.
     * 
     *  <p>When you set this property, the HTML markup is applied
     *  after the CSS styles for the TextArea instance are applied.
     *  When you get this property, the HTML markup includes
     *  the CSS styles.</p>
     *  
     *  <p>For example, if you set this to be a string such as,
     *  <code>"This is an example of &lt;b&gt;bold&lt;/b&gt; markup"</code>,
     *  the text "This is an example of <b>bold</b> markup" appears
     *  in the TextArea with whatever CSS styles normally apply.
     *  Also, the word "bold" appears in boldface font because of the
     *  <code>&lt;b&gt;</code> markup.</p>
     *
     *  <p>HTML markup uses characters such as &lt; and &gt;,
     *  which have special meaning in XML (and therefore in MXML). So,  
     *  code such as the following does not compile:</p>
     *  
     *  <pre>
     *  &lt;mx:TextArea htmlText="This is an example of &lt;b&gt;bold&lt;/b&gt; markup"/&gt;
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
     *  &lt;mx:TextArea id="myTextArea" initialize="myTextArea_initialize()"/&gt;
     *  </pre>
     *  
     *  <p>where the <code>myTextArea_initialize</code> method is in a script CDATA section:</p>
     *  
     *  <pre>
     *  &lt;mx:Script&gt;
     *  &lt;![CDATA[
     *  private function myTextArea_initialize():void {
     *      myTextArea.htmlText = "This is an example of &lt;b&gt;bold&lt;/b&gt; markup";
     *  }
     *  ]]&gt;
     *  &lt;/mx:Script&gt;
     *  
     *  </pre>
     *  
     *  <p>This is the simplest approach because the HTML markup
     *  remains easily readable.
     *  Notice that you must assign an <code>id</code> to the TextArea
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
     *  &lt;mx:TextArea&gt;
     *      &lt;mx:htmlText&gt;&lt;![CDATA[This is an example of &lt;b&gt;bold&lt;/b&gt; markup]]&gt;&lt;/mx:htmlText&gt;
     *  &lt;mx:TextArea/&gt;
     *  </pre>
     *  
     *  <p>You must write the <code>htmlText</code> property as a child tag
     *  rather than as an attribute on the <code>&lt;mx:TextArea&gt;</code> tag
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
     *  &lt;mx:TextArea htmlText="This is an example of &amp;lt;b&amp;gt;bold&amp;lt;/b&amp;gt; markup"/&amp;gt;
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
     *  The default value
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
     * @see flash.system.IMEConversionMode
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
     * 
     *  @tiptext The number of characters in the TextArea
     *  @helpid 3173
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
     *  setting the control's <code>text</code> or <code>htmlText</code>property.
     * 
     *  <p>The default value of 0, which indicates no limit.</p>
     *
     *  @tiptext The maximum number of characters that the TextArea can contain
     *  @helpid 3172
		 */
		public function get maxChars () : int;
		/**
		 *  @private
		 */
		public function set maxChars (value:int) : void;

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
     * 
     *  @see flash.text.TextField#restrict
     * 
     *  @tiptext The set of characters that may be entered into the TextArea
     *  @helpid 3174
		 */
		public function get restrict () : String;
		/**
		 *  @private
		 */
		public function set restrict (value:String) : void;

		/**
		 *  Specifies whether the text can be selected.
     *  Making the text selectable lets you copy text from the control.
     *
     *  @default true
		 */
		public function get selectable () : Boolean;
		/**
		 *  @private
		 */
		public function set selectable (value:Boolean) : void;

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
		 *  The zero-based index of the position <i>after</i>the last character
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
		 *  A flash.text.StyleSheet object that can perform rendering
    *  on the TextArea control's text.
    *  Used for detailed control of HTML styles for the text.
    *  For more information, see the flash.text.StyleSheet
    *  class documentation.
    * 
    *  @see flash.text.StyleSheet
    *
    *  @default null
		 */
		public function get styleSheet () : StyleSheet;
		/**
		 *  @private
		 */
		public function set styleSheet (value:StyleSheet) : void;

		/**
		 *  Plain text that appears in the control.
     *  Its appearance is determined by the CSS styles of this Label control.
     *  
     *  <p>Any HTML tags in the text string are ignored,
     *  and appear as  entered in the string.  
     *  To display text formatted using HTML tags,
     *  use the <code>htmlText</code> property instead.
     *  If you set the <code>htmlText</code> property,
     *  the HTML replaces any text you had set using this propety, and the
     *  <code>text</code> property returns a plain-text version of the
     *  HTML text, with all HTML tags stripped out. 
     *  For more information see the <code>htmlText</code> property.</p>
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
     *  @tiptext Gets or sets the TextArea content
     *  @helpid 3179
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
		 *  Indicates whether the text automatically wraps at the end of a line.
     *  If <code>true</code>, the text wraps to occupy 
     *  multiple lines, if necessary.
     *
     *  @default true
     * 
     *  @tiptext If true, lines will wrap. If false, long lines get clipped.
     *  @helpid 3175
		 */
		public function get wordWrap () : Boolean;
		/**
		 *  @private
		 */
		public function set wordWrap (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function TextArea ();

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
		 */
		protected function measure () : void;

		/**
		 *  @private
     *  Position the internal textfield taking scrollbars into consideration.
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
     *  When the TextArea control gets the focus, the selection is visible 
     *  if the <code>selectionBeginIndex</code> and <code>selectionEndIndex</code>
     *  properties are both set.
		 */
		public function setSelection (beginIndex:int, endIndex:int) : void;

		/**
		 *  @private
     *  Setting the 'htmlText' of textField changes its 'text',
     *  and vice versa, so afterwards doing so we call this method
     *  to update the storage vars for various properties.
     *  Afterwards, the Label's 'text', 'htmlText', 'textWidth',
     *  and 'textHeight' are all in sync with each other
     *  and are identical to the TextField's.
		 */
		private function textFieldChanged (styleChangeOnly:Boolean, dispatchValueCommitEvent:Boolean) : void;

		/**
		 *  @private
		 */
		private function adjustScrollBars () : void;

		/**
		 *  @private
     *  Some other components which use a TextArea as an internal
     *  subcomponent need access to its UITextField, but can't access the
     *  textField var because it is protected and therefore available
     *  only to subclasses.
		 */
		function getTextField () : IUITextField;

		/**
		 *  @private
		 */
		protected function focusInHandler (event:FocusEvent) : void;

		/**
		 *  @private
     *  Gets called by internal field so we remove focus rect.
		 */
		protected function focusOutHandler (event:FocusEvent) : void;

		/**
		 *  @private
     *  Mouse wheel scroll handler.
     *  TextField scrolls automatically so we don't need to handle this.
		 */
		protected function mouseWheelHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  We got a scroll event so update everything
		 */
		protected function scrollHandler (event:Event) : void;

		/**
		 *  @private
     *  Only gets called on keyboard not programmatic setting of text.
		 */
		private function textField_changeHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function textField_scrollHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function textField_ioErrorHandler (event:IOErrorEvent) : void;

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
