package mx.skins.halo
{
	import mx.core.EdgeMetrics;
	import mx.skins.Border;

include "../../core/Version.as"
	/**
	 *  The skin for all the states of a LinkButton.
	 */
	public class LinkButtonSkin extends Border
	{
		/**
		 *  @private
		 */
		public function get borderMetrics () : EdgeMetrics;

		/**
		 *  Constructor.
		 */
		public function LinkButtonSkin ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
