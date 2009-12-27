package mx.skins.halo
{
	import mx.skins.Border;

include "../../core/Version.as"
	/**
	 *  The skin for the highlighted state of the track of a Slider.
	 */
	public class SliderHighlightSkin extends Border
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
		public function SliderHighlightSkin ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
