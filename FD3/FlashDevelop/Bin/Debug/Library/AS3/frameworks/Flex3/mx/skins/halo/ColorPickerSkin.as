package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.skins.Border;

include "../../core/Version.as"
	/**
	 *  The skin for all the states of a ColorPicker.
	 */
	public class ColorPickerSkin extends Border
	{
		/**
		 *  @private
		 */
		private var borderShadowColor : uint;
		/**
		 *  @private
		 */
		private var borderHighlightColor : uint;
		/**
		 *  @private
		 */
		private var backgroundColor : uint;
		/**
		 *  @private
		 */
		private var borderSize : Number;
		/**
		 *  @private
		 */
		private var bevelSize : Number;
		/**
		 *  @private
		 */
		private var arrowWidth : Number;
		/**
		 *  @private
		 */
		private var arrowHeight : Number;

		/**
		 *  Constructor.
		 */
		public function ColorPickerSkin ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;

		/**
		 *  @private
		 */
		private function drawBorder (x:Number, y:Number, w:Number, h:Number, c1:Number, c2:Number, s:Number, a:Number) : void;

		/**
		 *  @private
		 */
		private function drawFill (x:Number, y:Number, w:Number, h:Number, c:Number, a:Number) : void;

		/**
		 *  @private
		 */
		private function drawArrow (x:Number, y:Number, w:Number, h:Number, c:Number, a:Number) : void;
	}
}
