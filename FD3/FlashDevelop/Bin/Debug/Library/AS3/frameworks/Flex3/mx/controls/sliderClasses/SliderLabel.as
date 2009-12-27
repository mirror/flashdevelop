package mx.controls.sliderClasses
{
	import flash.text.TextLineMetrics;
	import mx.controls.Label;
	import mx.core.mx_internal;

include "../../core/Version.as"
	/**
	 *  The SliderLabel class defines the label used in the mx.controls.Slider component. 
 *  The class adds no additional functionality to mx.controls.Label.
 *  It is used to apply a type selector style.
 *  	
 *  @see mx.controls.HSlider
 *  @see mx.controls.VSlider
 *  @see mx.controls.sliderClasses.Slider
 *  @see mx.controls.sliderClasses.SliderDataTip
 *  @see mx.controls.sliderClasses.SliderThumb
	 */
	public class SliderLabel extends Label
	{
		/**
		 *  Constructor.
		 */
		public function SliderLabel ();

		/**
		 *  @private
		 */
		function getMinimumText (t:String) : String;
	}
}
