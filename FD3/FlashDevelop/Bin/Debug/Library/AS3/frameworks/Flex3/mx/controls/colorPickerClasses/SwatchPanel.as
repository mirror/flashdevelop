package mx.controls.colorPickerClasses
{
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.controls.ColorPicker;
	import mx.controls.TextInput;
	import mx.core.FlexVersion;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.ColorPickerEvent;
	import mx.managers.IFocusManagerContainer;
	import mx.skins.halo.SwatchPanelSkin;
	import mx.skins.halo.SwatchSkin;
	import mx.styles.StyleManager;

	/**
	 *  Dispatched when the selected color changes.
 *
 *  @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")] 

	/**
	 *  Dispatched when the user presses the Enter key.
 *
 *  @eventType mx.events.FlexEvent.ENTER
	 */
	[Event(name="enter", type="flash.events.Event")] 

	/**
	 *  Dispatched when the mouse rolls over a color.
 *
 *  @eventType mx.events.ColorPickerEvent.ITEM_ROLL_OVER
	 */
	[Event(name="itemRollOver", type="mx.events.ColorPickerEvent")] 

	/**
	 *  Dispatched when the mouse rolls out of a color.
 *
 *  @eventType mx.events.ColorPickerEvent.ITEM_ROLL_OUT
	 */
	[Event(name="itemRollOut", type="mx.events.ColorPickerEvent")] 

include "../../styles/metadata/GapStyles.as"
include "../../styles/metadata/PaddingStyles.as"
	/**
	 *  Background color of the component.
 *  You can either have a <code>backgroundColor</code> or a
 *  <code>backgroundImage</code>, but not both.
 *  Note that some components, like a Button, do not have a background
 *  because they are completely filled with the button face or other graphics.
 *  The DataGrid control also ignores this style.
 *  The default value is <code>undefined</code>. If both this style and the
 *  backgroundImage style are undefined, the control has a transparent background.
	 */
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no")] 

	/**
	 *  Black section of a three-dimensional border, or the color section
 *  of a two-dimensional border.
 *  The following components support this style: Button, CheckBox,
 *  ComboBox, MenuBar,
 *  NumericStepper, ProgressBar, RadioButton, ScrollBar, Slider, and all
 *  components that support the <code>borderStyle</code> style.
 *  The default value depends on the component class;
 *  if not overriden for the class, it is <code>0xAAB3B3</code>.
	 */
	[Style(name="borderColor", type="uint", format="Color", inherit="no")] 

	/**
	 *  Number of columns in the swatch grid.
 *  The default value is 20.
	 */
	[Style(name="columnCount", type="int", inherit="no")] 

	/**
	 *  Color of the control border highlight.
 *  The default value is <code>0xC4CCCC</code> (medium gray) .
	 */
	[Style(name="highlightColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Color for the left and right inside edges of a component's skin.
 *  The default value is <code>0xD5DDDD</code>.
	 */
	[Style(name="shadowCapColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Bottom inside color of a button's skin.
 *  A section of the three-dimensional border.
 *  The default value is <code>0xEEEEEE</code> (light gray).
	 */
	[Style(name="shadowColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Height of the larger preview swatch that appears above the swatch grid on
 *  the top left of the SwatchPanel object.
 *  The default value is 22.
	 */
	[Style(name="previewHeight", type="Number", format="Length", inherit="no")] 

	/**
	 *  Width of the larger preview swatch.
 *  The default value is 45.
	 */
	[Style(name="previewWidth", type="Number", format="Length", inherit="no")] 

	/**
	 *  Size of the swatchBorder outlines.
 *  The default value is 1.
	 */
	[Style(name="swatchBorderSize", type="Number", format="Length", inherit="no")] 

	/**
	 *  Color of the swatch borders.
 *  The default value is <code>0x000000</code>.
	 */
	[Style(name="swatchBorderColor", type="uint", format="Color", inherit="no")] 

	/**
	 *  Size of the single border around the grid of swatches.
 *  The default value is 0.
	 */
	[Style(name="swatchGridBorderSize", type="Number", format="Length", inherit="no")] 

	/**
	 *  Color of the background rectangle behind the swatch grid.
 *  The default value is <code>0x000000</code>.
	 */
	[Style(name="swatchGridBackgroundColor", type="uint", format="Color", inherit="no")] 

	/**
	 *  Height of each swatch.
 *  The default value is 12.
	 */
	[Style(name="swatchHeight", type="Number", format="Length", inherit="no")] 

	/**
	 *  Color of the highlight that appears around the swatch when the user
 *  rolls over a swatch.
 *  The default value is <code>0xFFFFFF</code>.
	 */
	[Style(name="swatchHighlightColor", type="uint", format="Color", inherit="no")] 

	/**
	 *  Size of the highlight that appears around the swatch when the user
 *  rolls over a swatch.
 *  The default value is 1.
	 */
	[Style(name="swatchHighlightSize", type="Number", format="Length", inherit="no")] 

	/**
	 *  Width of each swatch.
 *  The default value is 12.
	 */
	[Style(name="swatchWidth", type="Number", format="Length", inherit="no")] 

	/**
	 *  @REVIEW 
 *  Name of the style sheet definition to configure the text input control.
 *  The default value is "swatchPanelTextField"
	 */
	[Style(name="textFieldStyleName", type="String", inherit="no")] 

	/**
	 *  Width of the hexadecimal text box that appears above the swatch grid.
 *  The default value is 72.
	 */
	[Style(name="textFieldWidth", type="Number", format="Length", inherit="no")] 

include "../../core/Version.as"
	/**
	 *  @private
	 */
	public class SwatchPanel extends UIComponent implements IFocusManagerContainer
	{
		/**
		 *  @private
		 */
		var textInput : TextInput;
		/**
		 *  @private
		 */
		private var border : SwatchPanelSkin;
		/**
		 *  @private
		 */
		private var preview : SwatchSkin;
		/**
		 *  @private
		 */
		private var swatches : SwatchSkin;
		/**
		 *  @private
		 */
		private var highlight : SwatchSkin;
		/**
		 *  @private
     *  Used by ColorPicker
		 */
		var isOverGrid : Boolean;
		/**
		 *  @private
     *  Used by ColorPicker
		 */
		var isOpening : Boolean;
		/**
		 *  @private
     *  Used by ColorPicker
		 */
		var focusedIndex : int;
		/**
		 *  @private
     *  Used by ColorPicker
		 */
		var tweenUp : Boolean;
		/**
		 *  @private
		 */
		private var initializing : Boolean;
		/**
		 *  @private
		 */
		private var indexFlag : Boolean;
		/**
		 *  @private
		 */
		private var lastIndex : int;
		/**
		 *  @private
		 */
		private var grid : Rectangle;
		/**
		 *  @private
		 */
		private var rows : int;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var horizontalGap : Number;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var verticalGap : Number;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var columnCount : int;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var paddingLeft : Number;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var paddingRight : Number;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var paddingTop : Number;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var paddingBottom : Number;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var textFieldWidth : Number;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var previewWidth : Number;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var previewHeight : Number;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var swatchWidth : Number;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var swatchHeight : Number;
		/**
		 *  @private
	 *  Cached style.
		 */
		private var swatchGridBorderSize : Number;
		/**
		 *  @private
		 */
		private var cellOffset : Number;
		/**
		 *  @private
		 */
		private var itemOffset : Number;
		/**
		 *  Storage for the colorField property.
		 */
		private var _colorField : String;
		/**
		 *  Storage for the dataProvider property.
		 */
		private var _dataProvider : IList;
		/**
		 *  Storage for the editable property.
		 */
		private var _editable : Boolean;
		/**
		 *  Storage for the labelField property.
		 */
		private var _labelField : String;
		/**
		 *  Storage for the selectedColor property.
		 */
		private var _selectedColor : uint;
		/**
		 *  Storage for the selectedIndex property.
		 */
		private var _selectedIndex : int;
		/**
		 *  Storage for the showTextField property.
		 */
		private var _showTextField : Boolean;

		/**
		 *  @private
     *  We set our size internally based on style values.
	 *  Setting height has no effect on the panel.
	 *  Override to return the preferred width and height of our contents.
		 */
		public function get height () : Number;
		/**
		 *  @private
		 */
		public function set height (value:Number) : void;

		/**
		 *  @private
     *  We set our size internally based on style values.
	 *  Setting width has no effect on the panel.
	 *  Override to return the preferred width and height of our contents.
		 */
		public function get width () : Number;
		/**
		 *  @private
		 */
		public function set width (value:Number) : void;

		/**
		 *  @private
		 */
		public function get colorField () : String;
		/**
		 *  @private
		 */
		public function set colorField (value:String) : void;

		/**
		 *  @private
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;

		/**
		 *  @private
		 */
		public function get editable () : Boolean;
		/**
		 *  @private
		 */
		public function set editable (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;

		/**
		 *  @private
		 */
		public function get length () : int;

		/**
		 *  @private
		 */
		public function get selectedColor () : uint;
		/**
		 *  @private
		 */
		public function set selectedColor (value:uint) : void;

		/**
		 *  @private
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;

		/**
		 *  @private
		 */
		public function get selectedItem () : Object;
		/**
		 *  @private
		 */
		public function set selectedItem (value:Object) : void;

		/**
		 *  @private
		 */
		public function get showTextField () : Boolean;
		/**
		 *  @private
		 */
		public function set showTextField (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function SwatchPanel ();

		/**
		 *  @private
		 */
		protected function createChildren () : void;

		/**
		 *  @private
     *  Change
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
		public function drawFocus (isFocused:Boolean) : void;

		/**
		 *  @private
		 */
		public function setFocus () : void;

		/**
		 *  @private
		 */
		private function updateStyleCache () : void;

		/**
		 *  @private
		 */
		private function refresh () : void;

		/**
		 *  @private
	 *  Update color values in preview
		 */
		private function updateColor (color:uint) : void;

		/**
		 *  @private
	 *  Convert RGB offset to Hex.
		 */
		private function rgbToHex (color:uint) : String;

		/**
		 *  @private
		 */
		private function findColorByName (name:Number) : int;

		/**
		 *  @private
		 */
		private function getColor (index:int) : uint;

		/**
		 *  @private
		 */
		private function setFocusOnSwatch (index:int) : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		private function mouseMoveHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function swatches_clickHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function textInput_keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		private function textInput_changeHandler (event:Event) : void;
	}
}
