package mx.skins.halo
{
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	import mx.core.EdgeMetrics;
	import mx.core.UIComponent;
	import mx.skins.Border;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;

	/**
	 *  The skin for all the states of a Tab in a TabNavigator or TabBar.
	 */
	public class TabSkin extends Border
	{
		/**
		 *  @private
		 */
		private static var cache : Object;
		/**
		 *  @private	 *  Storage for the borderMetrics property.
		 */
		private var _borderMetrics : EdgeMetrics;
		private static var tabnavs : Object;

		/**
		 *  @private
		 */
		public function get borderMetrics () : EdgeMetrics;
		/**
		 *  @private
		 */
		public function get measuredWidth () : Number;
		/**
		 *  @private
		 */
		public function get measuredHeight () : Number;

		/**
		 *  @private	 *  Several colors used for drawing are calculated from the base colors	 *  of the component (themeColor, borderColor and fillColors).	 *  Since these calculations can be a bit expensive,	 *  we calculate once per color set and cache the results.
		 */
		private static function calcDerivedStyles (themeColor:uint, borderColor:uint, falseFillColor0:uint, falseFillColor1:uint, fillColor0:uint, fillColor1:uint) : Object;
		/**
		 *  Constructor.
		 */
		public function TabSkin ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
		private static function isTabNavigator (parent:Object) : Boolean;
	}
}
