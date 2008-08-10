package fl.controls
{
import fl.controls.BaseButton;
import fl.controls.TextInput;
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.events.ComponentEvent;
import fl.managers.IFocusManagerComponent;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.ui.Keyboard;

/**
* The NumericStepper component displays an ordered set of numbers from which	 * the user can make a selection. This component includes a single-line field 	 * for text input and a pair of arrow buttons that can be used to step through 	 * the set of values. The Up and Down arrow keys can also be used to view the 	 * set of values. The NumericStepper component dispatches a <code>change</code> 	 * event after there is a change in its current value. This component also contains	 * the <code>value</code> property; you can use this property to obtain the current 	 * value of the component.	 *     * @includeExample examples/NumericStepperExample.as     *     * @langversion 3.0     * @playerversion Flash 9.0.28.0
*/
public class NumericStepper extends UIComponent implements IFocusManagerComponent
{
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var inputField : TextInput;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var upArrow : BaseButton;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var downArrow : BaseButton;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _maximum : Number;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _minimum : Number;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _value : Number;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _stepSize : Number;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _precision : Number;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		private static var defaultStyles : Object;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected static const DOWN_ARROW_STYLES : Object;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected static const UP_ARROW_STYLES : Object;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected static const TEXT_INPUT_STYLES : Object;

	/**
	* @copy fl.core.UIComponent#enabled         *         * @default true         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get enabled () : Boolean;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set enabled (value:Boolean) : Void;

	/**
	* Gets or sets the maximum value in the sequence of numeric values.         *         * @default 10         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get maximum () : Number;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set maximum (value:Number) : Void;

	/**
	* Gets or sets the minimum number in the sequence of numeric values.         *         * @default 0         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get minimum () : Number;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set minimum (value:Number) : Void;

	/**
	* Gets the next value in the sequence of values.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get nextValue () : Number;

	/**
	* Gets the previous value in the sequence of values.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get previousValue () : Number;

	/**
	* Gets or sets a nonzero number that describes the unit of change between 		 * values. The <code>value</code> property is a multiple of this number 		 * less the minimum. The NumericStepper component rounds the resulting value to the 		 * nearest step size.         *         * @default 1         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get stepSize () : Number;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set stepSize (value:Number) : Void;

	/**
	* Gets or sets the current value of the NumericStepper component.         *         * @default 1         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get value () : Number;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set value (value:Number) : Void;

	/**
	* Gets a reference to the TextInput component that the NumericStepper		 * component contains. Use this property to access and manipulate the 		 * underlying TextInput component. For example, you can use this		 * property to change the current selection in the text box or to		 * restrict the characters that the text box accepts.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get textField () : TextInput;

	/**
	* @copy fl.controls.TextArea#imeMode         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get imeMode () : String;

	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set imeMode (value:String) : Void;

	/**
	* Creates a new NumericStepper component instance.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function NumericStepper ();
	/**
	* @copy fl.core.UIComponent#getStyleDefinition()         *		 * @includeExample ../core/examples/UIComponent.getStyleDefinition.1.as -noswf		 *         * @see fl.core.UIComponent#getStyle()         * @see fl.core.UIComponent#setStyle()         * @see fl.managers.StyleManager         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static function getStyleDefinition () : Object;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function configUI () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function setValue (value:Number, fireEvent:Boolean =true) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function keyDownHandler (event:KeyboardEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function stepperPressHandler (event:ComponentEvent) : void;
	/**
	* @copy fl.core.UIComponent#drawFocus()         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function drawFocus (event:Boolean) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function focusOutHandler (event:FocusEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function draw () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function drawLayout () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function onTextChange (event:Event) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function passEvent (event:Event) : void;
	/**
	* Sets focus to the component instance.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function setFocus () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function isOurFocus (target:DisplayObject) : Boolean;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function setStyles () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function inRange (num:Number) : Boolean;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function inStep (num:Number) : Boolean;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function getValidValue (num:Number) : Number;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function getPrecision () : Number;
}
}
