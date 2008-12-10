package mx.skins.halo
{
	import flash.display.GradientType;
	import mx.skins.Border;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;

	/**
	 *  The skin for the track in a Slider.
	 */
	public class SliderTrackSkin extends Border
	{
		/**
		 *  @private
		 */
		public function get measuredWidth () : Number;
		/**
		 *  @private
		 */
		public function get measuredHeight () : Number;

		/**
		 *  Constructor.
		 */
		public function SliderTrackSkin ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
