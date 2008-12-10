package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.core.FlexVersion;
	import mx.skins.Border;
	import mx.utils.ColorUtil;

	/**
	 *  The skin for all the states of the next-year and previous-year *  buttons in a DateChooser.
	 */
	public class DateChooserYearArrowSkin extends Border
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
		public function DateChooserYearArrowSkin ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
