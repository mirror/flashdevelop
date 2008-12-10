package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import mx.controls.colorPickerClasses.SwatchPanel;
	import mx.controls.colorPickerClasses.WebSafePalette;
	import mx.core.FlexVersion;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.Tween;
	import mx.events.ColorPickerEvent;
	import mx.events.DropdownEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.InterManagerRequest;
	import mx.events.SandboxMouseEvent;
	import mx.managers.IFocusManager;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	import mx.managers.SystemManager;
	import mx.skins.halo.SwatchSkin;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when the selected color  *  changes as a result of user interaction. * *  @eventType mx.events.ColorPickerEvent.CHANGE *  @helpid 4918
	 */
	[Event(name="change", type="mx.events.ColorPickerEvent")] 
	/**
	 *  Dispatched when the swatch panel closes. * *  @eventType mx.events.DropdownEvent.CLOSE *  @helpid 4921
	 */
	[Event(name="close", type="mx.events.DropdownEvent")] 
	/**
	 *  Dispatched if the ColorPicker <code>editable</code> *  property is set to <code>true</code> *  and the user presses Enter after typing in a hexadecimal color value. * *  @eventType mx.events.ColorPickerEvent.ENTER *  @helpid 4919
	 */
	[Event(name="enter", type="mx.events.ColorPickerEvent")] 
	/**
	 *  Dispatched when the user rolls the mouse out of a swatch *  in the SwatchPanel object. * *  @eventType mx.events.ColorPickerEvent.ITEM_ROLL_OUT *  @helpid 4924
	 */
	[Event(name="itemRollOut", type="mx.events.ColorPickerEvent")] 
	/**
	 *  Dispatched when the user rolls the mouse over a swatch *  in the SwatchPanel object. * *  @eventType mx.events.ColorPickerEvent.ITEM_ROLL_OVER *  @helpid 4923
	 */
	[Event(name="itemRollOver", type="mx.events.ColorPickerEvent")] 
	/**
	 *  Dispatched when the color swatch panel opens. * *  @eventType mx.events.DropdownEvent.OPEN *  @helpid 4920
	 */
	[Event(name="open", type="mx.events.DropdownEvent")] 
	/**
	 *  Color of the SwatchPanel object's background. *  The default value is <code>0xE5E6E7</code>.
	 */
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Color of the outer border on the SwatchPanel object. *  The default value is <code>0xA5A9AE</code>.
	 */
	[Style(name="borderColor", type="uint", format="Color", inherit="no")] 
	/**
	 *  Length of a close transition, in milliseconds. *  The default value is 250.
	 */
	[Style(name="closeDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  Easing function to control component tweening. *  The default value is <code>undefined</code>.
	 */
	[Style(name="closeEasingFunction", type="Function", inherit="no")] 
	/**
	 *  Number of columns in the swatch grid. *  The default value is 20.
	 */
	[Style(name="columnCount", type="int", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Alphas used for the background fill of controls. *  The default value is <code>[ 0.6, 0.4 ]</code>.
	 */
	[Style(name="fillAlphas", type="Array", arrayType="Number", inherit="no")] 
	/**
	 *  Colors used to tint the background of the control. *  Pass the same color for both values for a flat-looking control. *  The default value is <code>[ 0xFFFFFF, 0xCCCCCC ]</code>.
	 */
	[Style(name="fillColors", type="Array", arrayType="uint", format="Color", inherit="no")] 
	/**
	 *  Alphas used for the highlight fill of controls. *  The default value is <code>[ 0.3, 0.0 ]</code>.
	 */
	[Style(name="highlightAlphas", type="Array", arrayType="Number", inherit="no")] 
	/**
	 *  Horizontal gap between swatches in the swatch grid. *  The default value is 0.
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Length of an open transition, in milliseconds. *  The default value is 250.
	 */
	[Style(name="openDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  Easing function to control component tweening. *  The default value is <code>undefined</code>.
	 */
	[Style(name="openEasingFunction", type="Function", inherit="no")] 
	/**
	 *  Bottom padding of SwatchPanel object below the swatch grid. *  The default value is 5.
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Left padding of SwatchPanel object to the side of the swatch grid. *  The default value is 5.
	 */
	[Style(name="paddingLeft", type="Number", format="Length", inherit="no")] 
	/**
	 *  Right padding of SwatchPanel object to the side of the swatch grid. *  The default value is 5.
	 */
	[Style(name="paddingRight", type="Number", format="Length", inherit="no")] 
	/**
	 *  Top padding of SwatchPanel object above the swatch grid. *  The default value is 4.
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 
	/**
	 *  Height of the larger preview swatch that appears above the swatch grid on *  the upper left of the SwatchPanel object. *  The default value is 22.
	 */
	[Style(name="previewHeight", type="Number", format="Length", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Width of the larger preview swatch. *  The default value is 45.
	 */
	[Style(name="previewWidth", type="Number", format="Length", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Color of the swatches' borders. *  The default value is <code>0x000000</code>.
	 */
	[Style(name="swatchBorderColor", type="uint", format="Color", inherit="no")] 
	/**
	 *  Size of the outlines of the swatches' borders. *  The default value is 1.
	 */
	[Style(name="swatchBorderSize", type="Number", format="Length", inherit="no")] 
	/**
	 *  Color of the background rectangle behind the swatch grid. *  The default value is <code>0x000000</code>.
	 */
	[Style(name="swatchGridBackgroundColor", type="uint", format="Color", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Size of the single border around the grid of swatches. *  The default value is 0.
	 */
	[Style(name="swatchGridBorderSize", type="Number", format="Length", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Height of each swatch. *  The default value is 12.
	 */
	[Style(name="swatchHeight", type="Number", format="Length", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Color of the highlight that appears around the swatch when the user *  rolls over a swatch. *  The default value is <code>0xFFFFFF</code>.
	 */
	[Style(name="swatchHighlightColor", type="uint", format="Color", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Size of the highlight that appears around the swatch when the user *  rolls over a swatch. *  The default value is 1.
	 */
	[Style(name="swatchHighlightSize", type="Number", format="Length", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Name of the class selector that defines style properties for the swatch panel. *  The default value is <code>undefined</code>. The following example shows the default style properties *  that are defined by the <code>swatchPanelStyleName</code>.  *  <pre> *  ColorPicker { *      swatchPanelStyleName:mySwatchPanelStyle; *  } *   *  .mySwatchPanelStyle { *      backgroundColor:#E5E6E7; *      columnCount:20; *      horizontalGap:0; *      previewHeight:22; *      previewWidth:45; *      swatchGridBackgroundColor:#000000; *      swatchGridBorderSize:0; *      swatchHeight:12; *      swatchHighlightColor:#FFFFFF; *      swatchHighlightSize:1; *      swatchWidth:12; *      textFieldWidth:72; *      verticalGap:0; *  } *  </pre>
	 */
	[Style(name="swatchPanelStyleName", type="String", inherit="no")] 
	/**
	 *  Width of each swatch. *  The default value is 12.
	 */
	[Style(name="swatchWidth", type="Number", format="Length", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Name of the style sheet definition to configure the text input control. *  The default value is "swatchPanelTextField"
	 */
	[Style(name="textFieldStyleName", type="String", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Width of the text box that appears above the swatch grid. *  The default value is 72.
	 */
	[Style(name="textFieldWidth", type="Number", format="Length", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 
	/**
	 *  Vertical gap between swatches in the grid. *  The default value is 0.
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no", deprecatedReplacement="swatchPanelStyleName", deprecatedSince="3.0")] 

	/**
	 *  The ColorPicker control provides a way for a user to choose a color from a swatch list. *  The default mode of the component shows a single swatch in a square button. *  When the user clicks the swatch button, the swatch panel appears and *  displays the entire swatch list. * *  <p>The ColorPicker control has the following default sizing characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>ColorPicker: 22 by 22 pixels *          <br>Swatch panel: Sized to fit the ColorPicker control width</br></td> *        </tr> *        <tr> *           <td>Minimum size</td> *           <td>0 pixels by 0 pixels</td> *        </tr> *        <tr> *           <td>Maximum size</td> *           <td>Undefined</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:ColorPicker&gt;</code> tag inherits all of the properties of its *  superclass, and the following properties:</p> * *  <pre> *  &lt;mx:ColorPicker *    <b>Properties</b> *    colorField="color" *    labelField="label" *    selectedColor="0x000000" *    selectedIndex="0" *    showTextField="true|false" *  *    <b>Styles</b> *    borderColor="0xA5A9AE" *    closeDuration="250" *    closeEasingFunction="undefined" *    color="0x0B333C" *    disabledIconColor="0x999999" *    fillAlphas="[0.6,0.4]" *    fillColors="[0xFFFFFF, 0xCCCCCC]" *    focusAlpha="0.5" *    focusRoundedCorners="tl tr bl br" *    fontAntiAliasType="advanced" *    fontfamily="Verdana" *    fontGridFitType="pixel" *    fontSharpness="0"" *    fontSize="10" *    fontStyle="normal" *    fontThickness="0" *    fontWeight="normal" *    highlightAlphas="[0.3,0.0]" *    iconColor="0x000000" *    leading="2" *    openDuration="250" *    openEasingFunction="undefined" *    paddingBottom="5" *    paddingLeft="5" *    paddingRight="5" *    paddingTop="4" *    swatchBorderColor="0x000000" *    swatchBorderSize="1" *    swatchPanelStyleName="undefined" *    textAlign="left" *    textDecoration="none" *    textIndent="0" *  *    <b>Events</b> *    change="<i>No default</i>" *    close="<i>No default</i>" *    enter="<i>No default</i>" *    itemRollOut="<i>No default</i>" *    itemRollOver="<i>No default</i>" *    open="<i>No default</i>" *    /&gt; *  </pre> * *  @see mx.controls.List *  @see mx.effects.Tween *  @see mx.managers.PopUpManager * *  @includeExample examples/ColorPickerExample.mxml * *  @helpid 4917
	 */
	public class ColorPicker extends ComboBase
	{
		/**
		 *  @private     *  Placeholder for mixin by SliderAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private     *  Used by SwatchPanel
		 */
		local var showingDropdown : Boolean;
		/**
		 *  @private     *  Used by SwatchPanel
		 */
		local var isDown : Boolean;
		/**
		 *  @private     *  Used by SwatchPanel
		 */
		local var isOpening : Boolean;
		/**
		 *  @private
		 */
		private var dropdownGap : Number;
		/**
		 *  @private
		 */
		private var indexFlag : Boolean;
		/**
		 *  @private
		 */
		private var initializing : Boolean;
		/**
		 *  @private
		 */
		private var isModelInited : Boolean;
		/**
		 *  @private
		 */
		private var collectionChanged : Boolean;
		/**
		 *  @private
		 */
		private var swatchPreview : SwatchSkin;
		/**
		 *  @private
		 */
		private var dropdownSwatch : SwatchPanel;
		/**
		 *  @private
		 */
		private var triggerEvent : Event;
		/**
		 *  @private
		 */
		private var _editable : Boolean;
		/**
		 *  @private     *  Storage for the colorField property.
		 */
		private var _colorField : String;
		/**
		 *  Storage for the labelField property.
		 */
		private var _labelField : String;
		/**
		 *  @private     *  Storage for the selectedColor property.
		 */
		private var _selectedColor : uint;
		/**
		 *  @private     *  Storage for the showTextField property.
		 */
		private var _showTextField : Boolean;
		private static const _swatchStyleFilters : Object;

		/**
		 *  @private     *  The dataProvider for the ColorPicker control.     *  The default dataProvider is an Array that includes all     *  the web-safe colors.     *     *  @helpid 4929
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  @private     *  Specifies whether the user can type a hexadecimal color value     *  in the text box.     *     *  @default true     *  @helpid 4930
		 */
		public function get editable () : Boolean;
		/**
		 *  @private
		 */
		public function set editable (value:Boolean) : void;
		/**
		 *  Index in the dataProvider of the selected item in the     *  SwatchPanel object.     *  Setting this property sets the selected color to the color that     *  corresponds to the index, sets the selected index in the drop-down     *  swatch to the <code>selectedIndex</code> property value,      *  and displays the associated label in the text box.     *  The default value is the index corresponding to      *  black(0x000000) color if found, else it is 0.     *     *  @helpid 4931
		 */
		public function set selectedIndex (value:int) : void;
		/**
		 *  @private     *  If the dataProvider is a complex object, this property is a     *  reference to the selected item in the SwatchPanel object.     *  If the dataProvider is an Array of color values, this     *  property is the selected color value.     *  If the dataProvider is a complex object, modifying fields of     *  this property modifies the dataProvider and its views.     *     *  <p>If the dataProvider is a complex object, this property is     *  read-only. You cannot change its value directly.     *  If the dataProvider is an Array of hexadecimal color values,     *  you can change this value directly.      *  The default value is undefined for complex dataProviders;     *  0 if the dataProvider is an Array of color values.     *     *  @helpid 4933
		 */
		public function set selectedItem (value:Object) : void;
		/**
		 *  Name of the field in the objects of the dataProvider Array that     *  specifies the hexadecimal values of the colors that the swatch     *  panel displays.     *     *  <p>If the dataProvider objects do not contain a color     *  field, set the <code>colorField</code> property to use the correct field name.     *  This property is available, but not meaningful, if the     *  dataProvider is an Array of hexadecimal color values.</p>     *     *  @default "color"     *  @helpid 4927
		 */
		public function get colorField () : String;
		/**
		 *  @private
		 */
		public function set colorField (value:String) : void;
		/**
		 *  A reference to the SwatchPanel object that appears when you expand     *  the ColorPicker control.     *     *  @helpid 4922
		 */
		function get dropdown () : SwatchPanel;
		/**
		 *  Name of the field in the objects of the dataProvider Array that     *  contain text to display as the label in the SwatchPanel object text box.     *     *  <p>If the dataProvider objects do not contain a label     *  field, set the <code>labelField</code> property to use the correct field name.     *  This property is available, but not meaningful, if the     *  dataProvider is an Array of hexadecimal color values.</p>     *     *  @default "label"     *  @helpid 4928
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;
		/**
		 *  The value of the currently selected color in the     *  SwatchPanel object.      *  In the &lt;mx:ColorPicker&gt; tag only, you can set this property to      *  a standard string color name, such as "blue".     *  If the dataProvider contains an entry for black (0x000000), the     *  default value is 0; otherwise, the default value is the color of     *  the item at index 0 of the data provider.     *     *  @helpid 4932
		 */
		public function get selectedColor () : uint;
		/**
		 *  @private
		 */
		public function set selectedColor (value:uint) : void;
		/**
		 *  Specifies whether to show the text box that displays the color     *  label or hexadecimal color value.     *     *  @default true
		 */
		public function get showTextField () : Boolean;
		/**
		 *  @private
		 */
		public function set showTextField (value:Boolean) : void;
		/**
		 *  Set of styles to pass from the ColorPicker through to the preview swatch.      *  @see mx.styles.StyleProxy     *  @review
		 */
		protected function get swatchStyleFilters () : Object;

		/**
		 *  Constructor.
		 */
		public function ColorPicker ();
		/**
		 *  @private
		 */
		function initializeAccessibility () : void;
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
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private     *  Invalidate Style
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  Displays the drop-down SwatchPanel object     *  that shows colors that users can select.     *     *  @helpid 4925
		 */
		public function open () : void;
		/**
		 *  Hides the drop-down SwatchPanel object.     *     *  @helpid 4926
		 */
		public function close (trigger:Event = null) : void;
		/**
		 *  @private     *  Dropdown Creation
		 */
		function getDropdown () : SwatchPanel;
		/**
		 *  @private     *  Display Dropdown
		 */
		function displayDropdown (show:Boolean, trigger:Event = null) : void;
		/**
		 *  @private     *  Load Default Palette
		 */
		private function loadDefaultPalette () : void;
		/**
		 *  @private     *  Update Color Preview
		 */
		private function updateColor (color:Number) : void;
		/**
		 *  @private     *  Find Color by Name
		 */
		private function findColorByName (name:Number) : int;
		/**
		 *  @private     *  Get Color Value
		 */
		private function getColor (location:int) : Number;
		/**
		 *  @private
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private     *  On Down Arrow
		 */
		protected function downArrowButton_buttonDownHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function dropdownSwatch_itemRollOverHandler (event:ColorPickerEvent) : void;
		/**
		 *  @private
		 */
		private function dropdownSwatch_itemRollOutHandler (event:ColorPickerEvent) : void;
		/**
		 *  @private
		 */
		private function dropdownSwatch_mouseDownOutsideHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function onTweenUpdate (value:Number) : void;
		/**
		 *  @private
		 */
		function onTweenEnd (value:Number) : void;
	}
}
