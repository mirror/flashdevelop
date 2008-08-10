package fl.controls
{
import fl.core.UIComponent;
import fl.core.InvalidationType;
import fl.controls.BaseButton;
import fl.controls.TextInput;
import fl.controls.TextArea;
import fl.events.ComponentEvent;
import fl.events.ColorPickerEvent;
import fl.managers.IFocusManager;
import fl.managers.IFocusManagerComponent;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.FocusEvent;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.ui.Keyboard;
import flash.system.IME;

/**
* The ColorPicker component displays a list of one or more swatches      * from which the user can select a color.      *     * <p>By default, the component displays a single swatch of color on a      * square button. When the user clicks this button, a panel opens to       * display the complete list of swatches.</p>     *     * @includeExample examples/ColorPickerExample.as     *     * @see fl.events.ColorPickerEvent ColorPickerEvent     *     * @langversion 3.0     * @playerversion Flash 9.0.28.0
*/
public class ColorPicker extends UIComponent implements IFocusManagerComponent
{
	/**
	* A reference to the internal text field of the ColorPicker component.         *         * @see #showTextField         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public var textField : TextField;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var customColors : Array;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static var defaultColors : Array;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var colorHash : Object;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var paletteBG : DisplayObject;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var selectedSwatch : Sprite;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _selectedColor : uint;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var rollOverColor : int;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _editable : Boolean;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _showTextField : Boolean;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var isOpen : Boolean;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var doOpen : Boolean;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var swatchButton : BaseButton;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var colorWell : DisplayObject;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var swatchSelectedSkin : DisplayObject;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var palette : Sprite;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var textFieldBG : DisplayObject;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var swatches : Sprite;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var swatchMap : Array;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var currRowIndex : int;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var currColIndex : int;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		private static var defaultStyles : Object;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected static const POPUP_BUTTON_STYLES : Object;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected static const SWATCH_STYLES : Object;

	/**
	* Gets or sets the swatch that is currently highlighted in the palette of the ColorPicker component.         *         * @default 0x000000         *         * @includeExample examples/ColorPicker.selectedColor.1.as -noswf         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get selectedColor () : uint;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set selectedColor (value:uint) : Void;

	/**
	* Gets the string value of the current color selection.         *         * @includeExample examples/ColorPicker.hexValue.1.as -noswf         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get hexValue () : String;

	/**
	* @copy fl.core.UIComponent#enabled         *         * @default true         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get enabled () : Boolean;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set enabled (value:Boolean) : Void;

	/**
	* Gets or sets a Boolean value that indicates whether the internal text field of the         * ColorPicker component is editable. A value of <code>true</code> indicates that          * the internal text field is editable; a value of <code>false</code> indicates          * that it is not.         *         * @default true         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get editable () : Boolean;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set editable (value:Boolean) : Void;

	/**
	* Gets or sets a Boolean value that indicates whether the internal text field          * of the ColorPicker component is displayed. A value of <code>true</code> indicates         * that the internal text field is displayed; a value of <code>false</code> indicates         * that it is not.         *         * @default true         *         * @includeExample examples/ColorPicker.showTextField.1.as -noswf         *         * @see #textField         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get showTextField () : Boolean;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set showTextField (value:Boolean) : Void;

	/**
	* Gets or sets the array of custom colors that the ColorPicker component         * provides. The ColorPicker component draws and displays the colors that are          * described in this array.         *         * <p><strong>Note:</strong> The maximum number of colors that the ColorPicker          * component can display is 1024.</p>         *         * <p>By default, this array contains 216 autogenerated colors.</p>         *         * @includeExample examples/ColorPicker.colors.1.as -noswf         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0         *
	*/
		public function get colors () : Array;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set colors (value:Array) : Void;

	/**
	* @copy fl.controls.TextArea#imeMode         *         * @see flash.system.IMEConversionMode IMEConversionMode         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get imeMode () : String;

	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set imeMode (value:String) : Void;

	/**
	* @copy fl.core.UIComponent#getStyleDefinition()         *         * @includeExample ../core/examples/UIComponent.getStyleDefinition.1.as -noswf         *         * @see fl.core.UIComponent#getStyle() UIComponent.getStyle()         * @see fl.core.UIComponent#setStyle() UIComponent.setStyle()         * @see fl.managers.StyleManager StyleManager         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static function getStyleDefinition () : Object;
	/**
	* Creates an instance of the ColorPicker class.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function ColorPicker ();
	/**
	* Shows the color palette. Calling this method causes the <code>open</code>          * event to be dispatched. If the color palette is already open or disabled,          * this method has no effect.         *         * @includeExample examples/ColorPicker.open.2.as -noswf         *         * @see #close()         * @see #event:open         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function open () : void;
	/**
	* Hides the color palette. Calling this method causes the <code>close</code>          * event to be dispatched. If the color palette is already closed or disabled,          * this method has no effect.         *         * @see #event:close         * @see #open()         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function close () : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		private function addCloseListener (event:Event);
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function onStageClick (event:MouseEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function setStyles () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function cleanUpSelected () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function onPopupButtonClick (event:MouseEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function draw () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function showPalette () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function setEmbedFonts () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function drawSwatchHighlight () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function drawPalette () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function drawTextField () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function drawSwatches () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function drawBG () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function positionPalette () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function setTextEditable () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function keyUpHandler (event:KeyboardEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function positionTextField () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function setColorDisplay () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function setSwatchHighlight (swatch:Sprite) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function findSwatch (color:uint) : Sprite;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function onSwatchClick (event:MouseEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function onSwatchOver (event:MouseEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function onSwatchOut (event:MouseEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function setColorText (color:uint) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function colorToString (color:uint) : String;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function setColorWellColor (colorTransform:ColorTransform) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function createSwatch (color:uint) : Sprite;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function addStageListener (event:Event = null) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function removeStageListener (event:Event = null) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function focusInHandler (event:FocusEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function focusOutHandler (event:FocusEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function isOurFocus (target:DisplayObject) : Boolean;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function keyDownHandler (event:KeyboardEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function configUI () : void;
}
}
