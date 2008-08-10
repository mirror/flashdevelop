/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.sliderClasses {
	import mx.core.UIComponent;
	public class Slider extends UIComponent {
		/**
		 * If set to false, then each thumb can only be moved to the edge of
		 *  the adjacent thumb.
		 *  If true, then each thumb can be moved to any position on the track.
		 */
		public var allowThumbOverlap:Boolean = false;
		/**
		 * Specifies whether clicking on the track will move the slider thumb.
		 */
		public var allowTrackClick:Boolean = true;
		/**
		 * Callback function that formats the data tip text.
		 *  The function takes a single Number as an argument
		 *  and returns a formatted String.
		 */
		public function get dataTipFormatFunction():Function;
		public function set dataTipFormatFunction(value:Function):void;
		/**
		 * The orientation of the slider control.
		 *  Valid values in MXML are "horizontal" or "vertical".
		 */
		public function get direction():String;
		public function set direction(value:String):void;
		/**
		 * An array of strings used for the slider labels.
		 *  Flex positions the labels at the beginning of the track,
		 *  and spaces them evenly between the beginning of the track
		 *  and the end of the track.
		 */
		public function get labels():Array;
		public function set labels(value:Array):void;
		/**
		 * Specifies whether live dragging is enabled for the slider.
		 *  If false, Flex sets the value and
		 *  values properties and dispatches the change
		 *  event when the user stops dragging the slider thumb.
		 *  If true,  Flex sets the value and
		 *  values properties and dispatches the change
		 *  event continuously as the user moves the thumb.
		 */
		public var liveDragging:Boolean = false;
		/**
		 * The maximum allowed value on the slider.
		 */
		public function get maximum():Number;
		public function set maximum(value:Number):void;
		/**
		 * The minimum allowed value on the slider control.
		 */
		public function get minimum():Number;
		public function set minimum(value:Number):void;
		/**
		 * If set to true, show a data tip during user interaction
		 *  containing the current value of the slider.
		 */
		public var showDataTip:Boolean = true;
		/**
		 * A reference to the class to use for the data tip.
		 */
		public function get sliderDataTipClass():Class;
		public function set sliderDataTipClass(value:Class):void;
		/**
		 * A reference to the class to use for each thumb.
		 */
		public function get sliderThumbClass():Class;
		public function set sliderThumbClass(value:Class):void;
		/**
		 * Specifies the increment value of the slider thumb
		 *  as the user moves the thumb.
		 *  For example, if snapInterval is 2,
		 *  the minimum value is 0,
		 *  and the maximum value is 10,
		 *  the thumb snaps to the values 0, 2, 4, 6, 8, and 10
		 *  as the user move the thumb.
		 *  A value of 0, means that the slider moves continuously
		 *  between the minimum and maximum values.
		 */
		public function get snapInterval():Number;
		public function set snapInterval(value:Number):void;
		/**
		 * The number of thumbs allowed on the slider.
		 *  Possible values are 1 or 2.
		 *  If set to 1, then the value property contains
		 *  the current value of the slider.
		 *  If set to 2, then the values property contains
		 *  an array of values representing the value for each thumb.
		 */
		public function get thumbCount():int;
		public function set thumbCount(value:int):void;
		/**
		 * Set of styles to pass from the Slider to the thumbs.
		 */
		protected function get thumbStyleFilters():Object;
		/**
		 * The spacing of the tick marks relative to the maximum value
		 *  of the control.
		 *  Flex displays tick marks whenever you set the tickInterval
		 *  property to a nonzero value.
		 */
		public function get tickInterval():Number;
		public function set tickInterval(value:Number):void;
		/**
		 * The positions of the tick marks on the slider. The positions correspond
		 *  to the values on the slider and should be between
		 *  the minimum and maximum values.
		 *  For example, if the tickValues property
		 *  is [0, 2.5, 7.5, 10] and maximum is 10, then a tick mark is placed
		 *  in the following positions along the slider: the beginning of the slider,
		 *  1/4 of the way in from the left,
		 *  3/4 of the way in from the left, and at the end of the slider.
		 */
		public function get tickValues():Array;
		public function set tickValues(value:Array):void;
		/**
		 * Contains the position of the thumb, and is a number between the
		 *  minimum and maximum properties.
		 *  Use the value property when thumbCount is 1.
		 *  When thumbCount is greater than 1, use the
		 *  values property instead.
		 *  The default value is equal to the minimum property.
		 */
		public function get value():Number;
		public function set value(value:Number):void;
		/**
		 * An array of values for each thumb when thumbCount
		 *  is greater than 1.
		 */
		public function get values():Array;
		public function set values(value:Array):void;
		/**
		 * Constructor.
		 */
		public function Slider();
		/**
		 * Returns the thumb object at the given index. Use this method to
		 *  style and customize individual thumbs in a slider control.
		 *
		 * @param index             <int> The zero-based index number of the thumb.
		 * @return                  <SliderThumb> A reference to the SliderThumb object.
		 */
		public function getThumbAt(index:int):SliderThumb;
		/**
		 * Calculates the amount of space that the component takes up.
		 *  A horizontal slider control calculates its height by examining
		 *  the position of its labels, tick marks, and thumbs
		 *  relative to the track.
		 *  The height of the control is equivalent to the position
		 *  of the bottom of the lowest element subtracted
		 *  from the position of the top of the highest element.
		 *  The width of a horizontal slider control defaults to 250 pixels.
		 *  For a vertical slider control, the width and the length
		 *  measurements are reversed.
		 */
		protected override function measure():void;
		/**
		 * This method sets the value of a slider thumb, and updates the display.
		 *
		 * @param index             <int> The zero-based index number of the thumb to set
		 *                            the value of, where a value of 0 corresponds to the first thumb.
		 * @param value             <Number> The value to set the thumb to
		 */
		public function setThumbValueAt(index:int, value:Number):void;
		/**
		 * Positions the elements of the control.
		 *  The track, thumbs, labels, and tick marks are all positioned
		 *  and sized by this method.
		 *  The track is sized based on the length of the labels and on the track margin.
		 *  If you specify a trackMargin, then the size of the track
		 *  is equal to the available width minus the trackMargin times 2.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void;
	}
}
