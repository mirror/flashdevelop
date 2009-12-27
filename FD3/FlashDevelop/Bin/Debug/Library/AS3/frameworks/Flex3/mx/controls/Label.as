package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.styles.StyleManager;

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
	 *  Dispatched when a user clicks a hyperlink in an 
 *  HTML-enabled text field, where the URL begins with <code>"event:"</code>. 
 *  The remainder of the URL after 
 *  <code>"event:"</code> is placed in the text property of the <code>link</code> event object.
 *
 *  <p>When you handle the <code>link</code> event, the hyperlink is not automatically executed; 
 *  you need to execute the hyperlink from within your event handler. 
 *  You typically use the <code>navigateToURL()</code> method to execute the hyperlink.
 *  This allows you to modify the hyperlink, or even prohibit it from occurring, 
 *  in your application. </p>
 *
 *  <p>The Label control must have the <code>selectable</code> property set 
 *  to <code>true</code> to generate the <code>link</code> event.</p>
 *
 *  @eventType flash.events.TextEvent.LINK
	 */
	[Event(name="link", type="flash.events.TextEvent")] 

include "../styles/metadata/TextStyles.as"
	/**
	 *  Number of pixels between the left of the Label and 
 *  the left of the text. 
 *  
 *  @default 0
	 */
	[Style(name="paddingLeft", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the right of the Label and 
 *  the right of the text. 
 *  
 *  @default 0
	 */
	[Style(name="paddingRight", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the bottom of the Label and 
 *  the bottom of the text. 
 *  
 *  @default 0
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the top of the Label and 
 *  the top of the text. 
 *  
 *  @default 0
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	[Exclude(name="focusEnabled", kind="property")] 

	[Exclude(name="focusPane", kind="property")] 

	[Exclude(name="mouseFocusEnabled", kind="property")] 

	[Exclude(name="tabEnabled", kind="property")] 

	[Exclude(name="focusBlendMode", kind="style")] 

	[Exclude(name="focusSkin", kind="style")] 

	[Exclude(name="focusThickness", kind="style")] 

	[Exclude(name="themeColor", kind="style")] 

	[Exclude(name="setFocus", kind="method")] 

include "../core/Version.as"
	/**
	 *  The Label control displays a single line of noneditable text.
 *  Use the Text control to create blocks of multiline
 *  noneditable text.
 *
 *  <p>You can format Label text by using HTML tags,
 *  which are applied after the Label control's CSS styles are applied.
 *  You can also put padding around the four sides of the text.
 *  The text of a Label is nonselectable by default,
 *  but you can make it selectable.</p>
 *
 *  <p>If a Label is sized to be smaller than its text,
 *  you can control whether the text is simply clipped or whether
 *  it is truncated with a localizable string such as "...".
 *  (Note: Plain text can be truncated, but HTML text cannot.)
 *  If the entire text of the Label, either plain or HTML, 
 *  is not completely visible, and you haven't assigned a tooltip
 *  to the Label, an automatic "truncation tip" 
 *  displays the complete plain text when a user holds the mouse over the Label control.</p>
 *
 *  <p>Label controls do not have backgrounds or borders
 *  and cannot take focus.</p>
 *
 *  <p>The Label control has the following default sizing characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>Width and height large enough for the text</td>
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
 *  <p>The <code>&lt;mx:Label&gt;</code> tag inherits all of the tag attributes
 *  of its superclass, and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:Label
 *    <b>Properties</b>
 *    condenseWhite="true|false"
 *    data="null"
 *    htmlText=""
 *    listData="null"
 *    selectable="true|false"
 *    text=""
 *    truncateToFit="true|false"
 *    &nbsp;
 *    <b>Styles</b>
 *    color="0x0B333C"
 *    disabledColor="0xAAB3B3"
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
 *    paddingTop="0"
 *    paddingBottom="0"
 *    styleSheet="null"
 *    textAlign="left|right|center"
 *    textDecoration="none|underline"
 *    textIndent="0"
 *    &nbsp;
 *    <b>Events</b>
 *    dataChange="<i>No default</i>"
 *  /&gt;
 *  </pre>
 *
 *  @includeExample examples/LabelExample.mxml
 *
 *  @see mx.controls.Text
 *  @see mx.controls.TextInput
 *  @see mx.controls.TextArea
 *  @see mx.controls.RichTextEditor
	 */
	public class Label extends UIComponent implements IDataRenderer
	{
		/**
		 *  @private
     *  Flag that will block default data/listData behavior.
		 */
		private var textSet : Boolean;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  The internal UITextField that renders the text of this Label.
		 */
		protected var textField : IUITextField;
		/**
		 *  @private
		 */
		private var toolTipSet : Boolean;
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
		var htmlTextChanged : Boolean;
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
     *  Storage for the listData property.
		 */
		private var _listData : BaseListData;
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
     *  Storage for the tabIndex property.
		 */
		private var _tabIndex : int;
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
		var textChanged : Boolean;
		/**
		 *  @private
     *  Storage for the textHeight property.
		 */
		private var _textHeight : Number;
		/**
		 *  @private
     *  Storage for the textWidth property.
		 */
		private var _textWidth : Number;
		/**
		 *  If this propery is <code>true</code>, and the Label control size is
     *  smaller than its text, the text of the 
     *  Label control is truncated using 
     *  a localizable string, such as <code>"..."</code>.
     *  If this property is <code>false</code>, text that does not fit is clipped.
     * 
     *  @default true
		 */
		public var truncateToFit : Boolean;

		/**
		 *  @private
     *  The baselinePosition of a Label is calculated for its textField.
		 */
		public function get baselinePosition () : Number;

		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function set toolTip (value:String) : void;

		/**
		 *  Specifies whether extra white space (spaces, line breaks,
     *  and so on) should be removed in a Label control with HTML text.
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
		 *  @inheritDoc
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;

		/**
		 *  Specifies the text displayed by the Label control, including HTML markup that
     *  expresses the styles of that text. 
     *  When you specify HTML text in this property, you can use the subset of HTML 
     *  tags that is supported by the Flash TextField control.
     * 
     *  <p>When you set this property, the HTML markup is applied
     *  after the CSS styles for the Label instance are applied.
     *  When you get this property, the HTML markup includes
     *  the CSS styles.</p>
     *  
     *  <p>For example, if you set this to be a string such as,
     *  <code>"This is an example of &lt;b&gt;bold&lt;/b&gt; markup"</code>,
     *  the text "This is an example of <b>bold</b> markup" appears
     *  in the Label with whatever CSS styles normally apply.
     *  Also, the word "bold" appears in boldface font because of the
     *  <code>&lt;b&gt;</code> markup.</p>
     *
     *  <p>HTML markup uses characters such as &lt; and &gt;,
     *  which have special meaning in XML (and therefore in MXML). So,  
     *  code such as the following does not compile:</p>
     *  
     *  <pre>
     *  &lt;mx:Label htmlText="This is an example of &lt;b&gt;bold&lt;/b&gt; markup"/&gt;
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
     *  &lt;mx:Label id="myLabel" initialize="myLabel_initialize()"/&gt;
     *  </pre>
     *  
     *  <p>where the <code>myLabel_initialize</code> method is in a script CDATA section:</p>
     *  
     *  <pre>
     *  &lt;mx:Script&gt;
     *  &lt;![CDATA[
     *  private function myLabel_initialize():void {
     *      myLabel.htmlText = "This is an example of &lt;b&gt;bold&lt;/b&gt; markup";
     *  }
     *  ]]&gt;
     *  &lt;/mx:Script&gt;
     *  
     *  </pre>
     *  
     *  <p>This is the simplest approach because the HTML markup
     *  remains easily readable.
     *  Notice that you must assign an <code>id</code> to the label
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
     *  &lt;mx:Label&gt;
     *      &lt;mx:htmlText&gt;&lt;![CDATA[This is an example of &lt;b&gt;bold&lt;/b&gt; markup]]&gt;&lt;/mx:htmlText&gt;
     *  &lt;mx:Label/&gt;
     *  </pre>
     *  
     *  <p>You must write the <code>htmlText</code> property as a child tag
     *  rather than as an attribute on the <code>&lt;mx:Label&gt;</code> tag
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
     *  &lt;mx:Label htmlText="This is an example of &amp;lt;b&amp;gt;bold&amp;lt;/b&amp;gt; markup"/&amp;gt;
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
     *  The default value for <code>condenseWhite</code> is
     *  <co
		 */
		public function get htmlText () : String;
		/**
		 *  @private
		 */
		public function set htmlText (value:String) : void;

		/**
		 *  @private
		 */
		private function get isHTML () : Boolean;

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
		 *  Specifies whether the text can be selected. 
     *  Making the text selectable lets you copy text from the control.
     *
     *  <p>When a <code>link</code> event is specified in the Label control, the <code>selectable</code> property must be set 
     *  to <code>true</code> to execute the <code>link</code> event.</p>
     *
     *  @default false;
		 */
		public function get selectable () : Boolean;
		/**
		 *  @private
		 */
		public function set selectable (value:Boolean) : void;

		/**
		 *  A flash.text.StyleSheet object that can perform rendering
    *  on the Label control's text.
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
		 *  @private
     *  Although Label/Text do not receive stage focus 
     *  since they are not tabEnabled or 
     *  implement IFocusManagerComponent,
     *  for accessible applications, developers may set their
     *  tabIndex to specify reading order 
     *  of Screen Reader's virtual cursor.
     *  The default value is <code>-1</code>.
     *
     *  @tiptext tabIndex of the component
     *  @helpid 3198
		 */
		public function get tabIndex () : int;
		/**
		 *  @private
		 */
		public function set tabIndex (value:int) : void;

		/**
		 *  Specifies the plain text displayed by this control.
     *  Its appearance is determined by the CSS styles of this Label control.
     *
     *  <p>When you set this property, any characters that might
     *  look like HTML markup in the string have no special meaning
     *  and appear as entered.</p>
     *
     *  <p>To display text formatted by using HTML tags,
     *  use the <code>htmlText</code> property instead.
     *  If you set the <code>htmlText</code> property,
     *  the HTML replaces any text that you set using this property, and the
     *  <code>text</code> property returns a plain-text version of the
     *  HTML text, with all HTML tags stripped out.</p>
     *
     *  <p>To include the special characters left angle  bracket (&lt;),
     *  right angle bracket (&gt;), or ampersand (&amp;) in the text,
     *  wrap the text string in the CDATA tag.
     *  Alternatively, you can use HTML character entities for the
     *  special characters, for example, <code>&amp;lt;</code>.</p>
     *
     *  <p>If the text is wider than the Label control,
     *  the text is truncated and terminated by an ellipsis (...).
     *  The full text displays as a tooltip when
     *  you move the mouse over the Label control.
     *  If you also set a tooltip by using the <code>tooltip</code>
     *  property, the tooltip is displayed rather than the text.</p>
     *
     *  <p>If you try to set this property to <code>null</code>,
     *  it is set, instead, to the empty string.
     *  The <code>text</code> property can temporarily have the value <code>null</code>,
     *  which indicates that the <code>htmlText</code> has been recently set
     *  and the corresponding <code>text</code> value
     *  has not yet been determined.</p>
     *
     *  @default ""
     *  @tiptext Gets or sets the Label content
     *  @helpid 3907
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
		public function Label ();

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
     *  Measure min/max/preferred sizes.
		 */
		protected function measure () : void;

		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

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
     *  If you set <code>text</code> and then immediately call
     *  <code>getLineMetrics()</code> you may receive an incorrect value.
     *  You should either wait for the component to validate
     *  or call <code>validateNow()</code>.
     *  This is behavior differs from that of the flash.text.TextField class,
     *  which updates the value immediately.
     * 
     *  @param lineIndex The zero-based index of the line for which to get the metrics. 
     *  For the Label control, which has only a single line, must be 0.
     * 
     *  @return The TextLineMetrics object that contains information about the text.
     *
     *  @see flash.text.TextField
     *  @see flash.text.TextLineMetrics
		 */
		public function getLineMetrics (lineIndex:int) : TextLineMetrics;

		/**
		 *  @private
     *  Setting the 'htmlText' of textField changes its 'text',
     *  and vice versa, so afterwards doing so we call this method
     *  to update the storage vars for various properties.
     *  Afterwards, the Label's 'text', 'htmlText', 'textWidth',
     *  and 'textHeight' are all in sync with each other
     *  and are identical to the TextField's.
		 */
		private function textFieldChanged (styleChangeOnly:Boolean) : void;

		/**
		 *  @private
		 */
		private function measureTextFieldBounds (s:String) : Rectangle;

		/**
		 *  @private
     *  Some other components which use a Label as an internal
     *  subcomponent need access to its UITextField, but can't access the
     *  textField var because it is protected and therefore available
     *  only to subclasses.
		 */
		function getTextField () : IUITextField;

		/**
		 *  @private
		 */
		function getMinimumText (t:String) : String;

		/**
		 *  @private
		 */
		private function textField_textFieldStyleChangeHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function textField_textModifiedHandler (event:Event) : void;
	}
}
