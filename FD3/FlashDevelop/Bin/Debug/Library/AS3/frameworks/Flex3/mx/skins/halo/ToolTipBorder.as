package mx.skins.halo
{
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	import mx.core.EdgeMetrics;
	import mx.graphics.RectangularDropShadow;
	import mx.skins.RectangularBorder;

	/**
	 *  The skin for a ToolTip.
	 */
	public class ToolTipBorder extends RectangularBorder
	{
		/**
		 *  @private
		 */
		private var dropShadow : RectangularDropShadow;
		/**
		 *  @private	 *  Storage for the borderMetrics property.
		 */
		private var _borderMetrics : EdgeMetrics;

		/**
		 *  @private
		 */
		public function get borderMetrics () : EdgeMetrics;

		/**
		 *  Constructor.
		 */
		public function ToolTipBorder ();
		/**
		 *  @private	 *  If borderStyle may have changed, clear the cached border metrics.
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private	 *  Draw the background and border.
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
