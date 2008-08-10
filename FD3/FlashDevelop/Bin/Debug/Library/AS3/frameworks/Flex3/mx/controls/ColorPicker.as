/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import flash.events.Event;
	public class ColorPicker extends ComboBase {
		/**
		 * Name of the field in the objects of the dataProvider Array that
		 *  specifies the hexadecimal values of the colors that the swatch
		 *  panel displays.
		 */
		public function get colorField():String;
		public function set colorField(value:String):void;
		/**
		 * Name of the field in the objects of the dataProvider Array that
		 *  contain text to display as the label in the SwatchPanel object text box.
		 */
		public function get labelField():String;
		public function set labelField(value:String):void;
		/**
		 * The value of the currently selected color in the
		 *  SwatchPanel object.
		 *  In the <mx:ColorPicker> tag only, you can set this property to
		 *  a standard string color name, such as "blue".
		 *  If the dataProvider contains an entry for black (0x000000), the
		 *  default value is 0; otherwise, the default value is the color of
		 *  the item at index 0 of the data provider.
		 */
		public function get selectedColor():uint;
		public function set selectedColor(value:uint):void;
		/**
		 * Index in the dataProvider of the selected item in the
		 *  SwatchPanel object.
		 *  Setting this property sets the selected color to the color that
		 *  corresponds to the index, sets the selected index in the drop-down
		 *  swatch to the selectedIndex property value,
		 *  and displays the associated label in the text box.
		 *  The default value is the index corresponding to
		 *  black(0x000000) color if found, else it is 0.
		 */
		public function set selectedIndex(value:int):void;
		/**
		 * Specifies whether to show the text box that displays the color
		 *  label or hexadecimal color value.
		 */
		public function get showTextField():Boolean;
		public function set showTextField(value:Boolean):void;
		/**
		 * Set of styles to pass from the ColorPicker through to the preview swatch.
		 */
		protected function get swatchStyleFilters():Object;
		/**
		 * Constructor.
		 */
		public function ColorPicker();
		/**
		 * Hides the drop-down SwatchPanel object.
		 *
		 * @param trigger           <Event (default = null)> 
		 */
		public function close(trigger:Event = null):void;
		/**
		 * Displays the drop-down SwatchPanel object
		 *  that shows colors that users can select.
		 */
		public function open():void;
	}
}
