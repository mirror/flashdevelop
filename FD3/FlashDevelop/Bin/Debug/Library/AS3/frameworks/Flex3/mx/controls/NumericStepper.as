/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.UIComponent;
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.managers.IFocusManagerComponent;
	import mx.core.IIMESupport;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.BaseListData;
	public class NumericStepper extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IFocusManagerComponent, IIMESupport, IListItemRenderer {
		/**
		 * The data property lets you pass a value to the component
		 *  when you use it in an item renderer or item editor.
		 *  You typically use data binding to bind a field of the data
		 *  property to a property of this component.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * Set of styles to pass from the NumericStepper to the down arrow.
		 */
		protected function get downArrowStyleFilters():Object;
		/**
		 * Specifies the IME (Input Method Editor) mode.
		 *  The IME enables users to enter text in Chinese, Japanese, and Korean.
		 *  Flex sets the specified IME mode when the control gets the focus
		 *  and sets it back to previous value when the control loses the focus.
		 */
		public function get imeMode():String;
		public function set imeMode(value:String):void;
		/**
		 * Set of styles to pass from the NumericStepper to the input field.
		 */
		protected function get inputFieldStyleFilters():Object;
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
		 * The maximum number of characters that can be entered in the field.
		 *  A value of 0 means that any number of characters can be entered.
		 */
		public function get maxChars():int;
		public function set maxChars(value:int):void;
		/**
		 * Maximum value of the NumericStepper.
		 *  The maximum can be any number, including a fractional value.
		 */
		public function get maximum():Number;
		public function set maximum(value:Number):void;
		/**
		 * Minimum value of the NumericStepper.
		 *  The minimum can be any number, including a fractional value.
		 */
		public function get minimum():Number;
		public function set minimum(value:Number):void;
		/**
		 * The value that is one step larger than the current value
		 *  property and not greater than the maximum property value.
		 */
		public function get nextValue():Number;
		/**
		 * The value that is one step smaller than the current value
		 *  property and not smaller than the maximum property value.
		 */
		public function get previousValue():Number;
		/**
		 * Non-zero unit of change between values.
		 *  The value property must be a multiple of this number.
		 */
		public function get stepSize():Number;
		public function set stepSize(value:Number):void;
		/**
		 * Set of styles to pass from the NumericStepper to the up arrow.
		 */
		protected function get upArrowStyleFilters():Object;
		/**
		 * Current value displayed in the text area of the NumericStepper control.
		 *  If a user enters number that is not a multiple of the
		 *  stepSize property or is not in the range
		 *  between the maximum and minimum properties,
		 *  this property is set to the closest valid value.
		 */
		public function get value():Number;
		public function set value(value:Number):void;
		/**
		 * Constructor.
		 */
		public function NumericStepper();
	}
}
