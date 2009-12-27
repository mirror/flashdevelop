package mx.skins.halo
{
	import mx.skins.Border;

include "../../core/Version.as"
	/**
	 *  The skin for the border of a SwatchPanel.
	 */
	public class SwatchPanelSkin extends Border
	{
		/**
		 *  Constructor.
		 */
		public function SwatchPanelSkin ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
