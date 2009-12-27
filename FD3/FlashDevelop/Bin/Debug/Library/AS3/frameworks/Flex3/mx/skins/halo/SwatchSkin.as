package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.collections.IList;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

include "../../core/Version.as"
	/**
	 *  The skin used for all color swatches in a ColorPicker.
	 */
	public class SwatchSkin extends UIComponent
	{
		/**
		 *  @private
		 */
		var color : uint;
		/**
		 *  @private
		 */
		var colorField : String;

		/**
		 *  Constructor.
		 */
		public function SwatchSkin ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;

		/**
		 *  @private
		 */
		function updateGrid (dp:IList) : void;

		/**
		 *  @private
		 */
		function updateSkin (c:Number) : void;

		/**
		 *  @private
		 */
		private function drawGrid (dp:IList, cf:String) : void;

		/**
		 *  @private
		 */
		private function drawSwatch (x:Number, y:Number, w:Number, h:Number, c:Number) : void;

		/**
		 *  @private
		 */
		private function drawBorder (x:Number, y:Number, w:Number, h:Number, c1:Number, c2:Number, s:Number, a:Number) : void;

		/**
		 *  @private
		 */
		private function drawFill (x:Number, y:Number, w:Number, h:Number, c:Number, a:Number) : void;
	}
}
