package mx.skins.halo
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;
	import mx.core.IProgrammaticSkin;

include "../../core/Version.as"
	/**
	 *  The skin for all the states of a PopUpButton.
	 */
	public class PopUpButtonSkin extends UIComponent implements IProgrammaticSkin
	{
		/**
		 *  @private
		 */
		private static var cache : Object;

		/**
		 *  @private
		 */
		public function get measuredWidth () : Number;

		/**
		 *  @private
		 */
		public function get measuredHeight () : Number;

		/**
		 *  @private
	 *  Several colors used for drawing are calculated from the base colors
	 *  of the component (themeColor, borderColor and fillColors).
	 *  Since these calculations can be a bit expensive,
	 *  we calculate once per color set and cache the results.
		 */
		private static function calcDerivedStyles (themeColor:uint, fillColor0:uint, fillColor1:uint) : Object;

		/**
		 *  Constructor.
		 */
		public function PopUpButtonSkin ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;

		/**
		 *  @private
		 */
		private function getRadius (r:Number, left:Boolean) : Object;
	}
}
