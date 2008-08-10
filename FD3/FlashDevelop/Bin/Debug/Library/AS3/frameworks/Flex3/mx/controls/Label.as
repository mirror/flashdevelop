/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.UIComponent;
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.IFontContextComponent;
	import mx.core.IFlexModuleFactory;
	import mx.controls.listClasses.BaseListData;
	public class Label extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer, IFontContextComponent {
		/**
		 * Specifies whether extra white space (spaces, line breaks,
		 *  and so on) should be removed in a Label control with HTML text.
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
		 * The module factory that provides the font context for this component.
		 */
		public function get fontContext():IFlexModuleFactory;
		public function set fontContext(value:IFlexModuleFactory):void;
		/**
		 * Specifies the text displayed by the Label control, including HTML markup that
		 *  expresses the styles of that text.
		 *  When you specify HTML text in this property, you can use the subset of HTML
		 *  tags that is supported by the Flash TextField control.
		 */
		public function get htmlText():String;
		public function set htmlText(value:String):void;
		/**
		 * When a component is used as a drop-in item renderer or drop-in
		 *  item editor, Flex initializes the listData property
		 *  of the component with the appropriate data from the List control.
		 *  The component can then use the listData property
		 *  to initialize the data property of the drop-in
		 *  item renderer or drop-in item editor.
		 */
		public function get listData():BaseListData;
		public function set listData(value:BaseListData):void;
		/**
		 * Specifies whether the text can be selected.
		 *  Making the text selectable lets you copy text from the control.
		 */
		public function get selectable():Boolean;
		public function set selectable(value:Boolean):void;
		/**
		 * Specifies the plain text displayed by this control.
		 *  Its appearance is determined by the CSS styles of this Label control.
		 */
		public function get text():String;
		public function set text(value:String):void;
		/**
		 * The internal UITextField that renders the text of this Label.
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
		 * If this propery is true, and the Label control size is
		 *  smaller than its text, the text of the
		 *  Label control is truncated using
		 *  a localizable string, such as "...".
		 *  If this property is false, text that does not fit is clipped.
		 */
		public var truncateToFit:Boolean = true;
		/**
		 * Constructor.
		 */
		public function Label();
		/**
		 * Returns a TextLineMetrics object with information about the text
		 *  position and measurements for a line of text in the control.
		 *  The component must be validated to get a correct number.
		 *  If you set text and then immediately call
		 *  getLineMetrics() you may receive an incorrect value.
		 *  You should either wait for the component to validate
		 *  or call validateNow().
		 *  This is behavior differs from that of the flash.text.TextField class,
		 *  which updates the value immediately.
		 *
		 * @param lineIndex         <int> The zero-based index of the line for which to get the metrics.
		 *                            For the Label control, which has only a single line, must be 0.
		 */
		public function getLineMetrics(lineIndex:int):TextLineMetrics;
	}
}
