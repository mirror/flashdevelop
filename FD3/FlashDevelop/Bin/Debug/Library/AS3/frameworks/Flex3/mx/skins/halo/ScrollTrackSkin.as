package mx.skins.halo
{
	import flash.display.GradientType;
	import mx.core.FlexVersion;
	import mx.skins.Border;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;

	/**
	 *  The skin for the track in a ScrollBar.
	 */
	public class ScrollTrackSkin extends Border
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
		public function ScrollTrackSkin ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
