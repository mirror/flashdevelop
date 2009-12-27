package mx.controls.sliderClasses
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import mx.controls.Button;
	import mx.controls.ButtonPhase;
	import mx.core.mx_internal;
	import mx.events.SliderEvent;
	import mx.managers.ISystemManager;

include "../../core/Version.as"
	/**
	 *  The SliderThumb class represents a thumb of a Slider control.
 *  The SliderThumb class can only be used within the context
 *  of a Slider control.
 *  You can create a subclass of the SliderThumb class,
 *  and use it with a Slider control by setting the 
 *  <code>sliderThumbClass</code>
 *  property of the Slider control to your subclass. 
 *  		
 *  @see mx.controls.HSlider
 *  @see mx.controls.VSlider
 *  @see mx.controls.sliderClasses.Slider
 *  @see mx.controls.sliderClasses.SliderDataTip
 *  @see mx.controls.sliderClasses.SliderLabel
	 */
	public class SliderThumb extends Button
	{
		/**
		 *  @private
	 *  The zero-based index number of this thumb.
		 */
		var thumbIndex : int;
		/**
		 *  @private
	 *  x-position offset.
		 */
		private var xOffset : Number;

		/**
		 *  @private
	 *  Handle changes to the x-position value of the thumb.
		 */
		public function set x (value:Number) : void;

		/**
		 *  Specifies the position of the center of the thumb on the x-axis.
		 */
		public function get xPosition () : Number;
		/**
		 *  @private
		 */
		public function set xPosition (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function SliderThumb ();

		/**
		 *  @private
		 */
		protected function measure () : void;

		/**
		 *  @private
		 */
		public function drawFocus (isFocused:Boolean) : void;

		/**
		 *  @private
		 */
		function buttonReleased () : void;

		/**
		 *  @private
	 *  Move the thumb into the correct position.
		 */
		private function moveXPos (value:Number, overrideSnap:Boolean = false, noUpdate:Boolean = false) : Number;

		/**
		 *  @private
	 *  Ask the Slider if we should be moving into a snap position 
	 *  and make sure we haven't exceeded the min or max position
		 */
		private function calculateXPos (value:Number, overrideSnap:Boolean = false) : Number;

		/**
		 *	@private
	 *	Used by the Slider for animating the sliding of the thumb.
		 */
		function onTweenUpdate (value:Number) : void;

		/**
		 *	@private
	 *	Used by the Slider for animating the sliding of the thumb.
		 */
		function onTweenEnd (value:Number) : void;

		/**
		 *  @private
	 *  Tells the Slider to update its value for the thumb based on the thumb's
	 *  current position
		 */
		private function updateValue () : void;

		/**
		 *  @private
	 *  Handle key presses when focus is on the thumb.
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;

		/**
		 *  @private
	 *  Internal function to handle mouse movements
	 *  when the thumb is in a pressed state
	 *  We want the thumb to follow the x-position of the mouse.
		 */
		private function mouseMoveHandler (event:MouseEvent) : void;
	}
}
