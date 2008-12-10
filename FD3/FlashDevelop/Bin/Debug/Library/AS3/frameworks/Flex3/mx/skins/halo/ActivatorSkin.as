package mx.skins.halo
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.filters.BlurFilter;
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	import mx.core.ApplicationGlobals;
	import mx.skins.Border;
	import mx.styles.IStyleClient;
	import mx.utils.ColorUtil;

	/**
	 *  Defines the up, down, and over states for MenuBarItem objects.
	 */
	public class ActivatorSkin extends Border
	{
		/**
		 *  @private
		 */
		private static var cache : Object;
		/**
		 *  We don't use 'is' to prevent dependency issues
		 */
		private static var acbs : Object;

		/**
		 *  @private	 *  Several colors used for drawing are calculated from the base colors	 *  of the component (themeColor, borderColor and fillColors).	 *  Since these calculations can be a bit expensive,	 *  we calculate once per color set and cache the results.
		 */
		private static function calcDerivedStyles (themeColor:uint, fillColor0:uint, fillColor1:uint) : Object;
		/**
		 *  Constructor.
		 */
		public function ActivatorSkin ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
		/**
		 *  @private
		 */
		private function drawHaloRect (w:Number, h:Number) : void;
		/**
		 *  @private	 *  The drawTranslucentHaloRect function is called when the "translucent"	 *  style is set to true, which happens when a MenuBar is inside an ACB.
		 */
		private function drawTranslucentHaloRect (w:Number, h:Number) : void;
		private static function isApplicationControlBar (parent:Object) : Boolean;
	}
}
