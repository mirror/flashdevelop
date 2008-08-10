/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.ScrollControlBase;
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.managers.IFocusManagerComponent;
	import mx.core.IIMESupport;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.IFontContextComponent;
	import mx.controls.listClasses.BaseListData;
	import flash.text.StyleSheet;
	public class TextArea extends ScrollControlBase implements IDataRenderer, IDropInListItemRenderer, IFocusManagerComponent, IIMESupport, IListItemRenderer, IFontContextComponent {
		/**
		 * Specifies whether extra white space (spaces, line breaks,
		 *  and so on) should be removed in a TextArea control with HTML text.
		 */
		public function get condenseWhite():Boolean;
		public function set condenseWhite(value:Boolean):void;
		/**
		 * Lets you pass a value to the component
		 *  when you use it in an item renderer or item editor.
		 *  You typically use data binding to bind a field of the data
		 *  property to a property of this component.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * Indicates whether this control is used for entering passwords.
		 *  If true, the field does not display entered text,
		 *  instead, each text character entered into the control
		 *  appears as the  character "*".
		 */
		public function get displayAsPassword():Boolean;
		public function set displayAsPassword(value:Boolean):void;
		/**
		 * Indicates whether the user is allowed to edit the text in this control.
		 *  If true, the user can edit the text.
		 */
		public function get editable():Boolean;
		public function set editable(value:Boolean):void;
		/**
		 * Specifies whether the horizontal scroll bar is
		 *  always on (ScrollPolicy.ON),
		 *  always off (ScrollPolicy.OFF),
		 *  or turns on when needed (ScrollPolicy.AUTO).
		 */
		public function get horizontalScrollPolicy():String;
		public function set horizontalScrollPolicy(value:String):void;
		/**
		 * Pixel position in the content area of the leftmost pixel
		 *  that is currently displayed.
		 *  (The content area includes all contents of a control, not just
		 *  the portion that is currently displayed.)
		 *  This property is always set to 0, and ignores changes,
		 *  if wordWrap is set to true.
		 */
		public function set horizontalScrollPosition(value:Number):void;
		/**
		 * Specifies the text displayed by the TextArea control, including HTML markup that
		 *  expresses the styles of that text.
		 *  When you specify HTML text in this property, you can use the subset of HTML
		 *  tags that is supported by the Flash TextField control.
		 */
		public function get htmlText():String;
		public function set htmlText(value:String):void;
		/**
		 * Specifies the IME (input method editor) mode.
		 *  The IME enables users to enter text in Chinese, Japanese, and Korean.
		 *  Flex sets the specified IME mode when the control gets the focus,
		 *  and sets it back to the previous value when the control loses the focus.
		 */
		public function get imeMode():String;
		public function set imeMode(value:String):void;
		/**
		 * The number of characters of text displayed in the TextArea.
		 */
		public function get length():int;
		/**
		 * When a component is used as a drop-in item renderer or drop-in
		 *  item editor, Flex initializes the listData property
		 *  of the component with the appropriate data from the list control.
		 *  The component can then use the listData property
		 *  to initialize the data property of the drop-in
		 *  item renderer or drop-in item editor.
		 */
		public function get listData():BaseListData;
		public function set listData(value:BaseListData):void;
		/**
		 * Maximum number of characters that users can enter in the text field.
		 *  This property does not limit the length of text specified by the
		 *  setting the control's text or htmlTextproperty.
		 */
		public function get maxChars():int;
		public function set maxChars(value:int):void;
		/**
		 * Indicates the set of characters that a user can enter into the control.
		 *  If the value of the restrict property is null,
		 *  you can enter any character. If the value of the restrict
		 *  property is an empty string, you cannot enter any character.
		 *  This property only restricts user interaction; a script
		 *  can put any text into the text field. If the value of
		 *  the restrict property is a string of characters,
		 *  you may enter only characters in that string into the
		 *  text field.
		 */
		public function get restrict():String;
		public function set restrict(value:String):void;
		/**
		 * Specifies whether the text can be selected.
		 *  Making the text selectable lets you copy text from the control.
		 */
		public function get selectable():Boolean;
		public function set selectable(value:Boolean):void;
		/**
		 * The zero-based character index value of the first character
		 *  in the current selection.
		 *  For example, the first character is 0, the second character is 1,
		 *  and so on.
		 *  When the control gets the focus, the selection is visible if the
		 *  selectionBeginIndex and selectionEndIndex
		 *  properties are both set.
		 */
		public function get selectionBeginIndex():int;
		public function set selectionBeginIndex(value:int):void;
		/**
		 * The zero-based index of the position afterthe last character
		 *  in the current selection (equivalent to the one-based index of the last
		 *  character).
		 *  If the last character in the selection, for example, is the fifth
		 *  character, this property has the value 5.
		 *  When the control gets the focus, the selection is visible if the
		 *  selectionBeginIndex and selectionEndIndex
		 *  properties are both set.
		 */
		public function get selectionEndIndex():int;
		public function set selectionEndIndex(value:int):void;
		/**
		 * A flash.text.StyleSheet object that can perform rendering
		 *  on the TextArea control's text.
		 *  Used for detailed control of HTML styles for the text.
		 *  For more information, see the flash.text.StyleSheet
		 *  class documentation.
		 */
		public function get styleSheet():StyleSheet;
		public function set styleSheet(value:StyleSheet):void;
		/**
		 * Plain text that appears in the control.
		 *  Its appearance is determined by the CSS styles of this Label control.
		 */
		public function get text():String;
		public function set text(value:String):void;
		/**
		 * The internal UITextField that renders the text of this TextArea.
		 */
		protected var textField:IUITextField;
		/**
		 * The height of the text.
		 */
		public function get textHeight():Number;
		/**
		 * The width of the text.
		 */
		public function get textWidth():Number;
		/**
		 * Whether the vertical scroll bar is
		 *  always on (ScrollPolicy.ON),
		 *  always off (ScrollPolicy.OFF),
		 *  or turns on when needed (ScrollPolicy.AUTO).
		 */
		public function get verticalScrollPolicy():String;
		public function set verticalScrollPolicy(value:String):void;
		/**
		 * Line number of the top row of characters that is currently displayed.
		 *  The default value is 0.
		 */
		public function set verticalScrollPosition(value:Number):void;
		/**
		 * Indicates whether the text automatically wraps at the end of a line.
		 *  If true, the text wraps to occupy
		 *  multiple lines, if necessary.
		 */
		public function get wordWrap():Boolean;
		public function set wordWrap(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function TextArea();
		/**
		 * Returns a TextLineMetrics object with information about the text
		 *  position and measurements for a line of text in the control.
		 *  The component must be validated to get a correct number.
		 *  If you set the text or htmlText property
		 *  and then immediately call
		 *  getLineMetrics() you may receive an incorrect value.
		 *  You should either wait for the component to validate
		 *  or call validateNow().
		 *  This is behavior differs from that of the flash.text.TextField class,
		 *  which updates the value immediately.
		 *
		 * @param lineIndex         <int> The zero-based index of the line for which to get the metrics.
		 */
		public function getLineMetrics(lineIndex:int):TextLineMetrics;
		/**
		 * Selects the text in the range specified by the parameters.
		 *  If the control is not in focus, the selection highlight will not show
		 *  until the control gains focus. Also, if the focus is gained by clicking
		 *  on the control, any previous selection would be lost.
		 *  If the two parameter values are the same,
		 *  the new selection is an insertion point.
		 *
		 * @param beginIndex        <int> The zero-based index of the first character in the
		 *                            selection; that is, the first character is 0, the second character
		 *                            is 1, and so on.
		 * @param endIndex          <int> The zero-based index of the position after
		 *                            the last character in the selection (equivalent to the one-based
		 *                            index of the last character).
		 *                            If the parameter is 5, the last character in the selection, for
		 *                            example, is the fifth character.
		 *                            When the TextArea control gets the focus, the selection is visible
		 *                            if the selectionBeginIndex and selectionEndIndex
		 *                            properties are both set.
		 */
		public function setSelection(beginIndex:int, endIndex:int):void;
	}
}
