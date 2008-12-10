package mx.skins.halo
{
	import mx.skins.Border;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;

	/**
	 *  The skin for a ProgressBar.
	 */
	public class ProgressBarSkin extends Border
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
		public function ProgressBarSkin ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
