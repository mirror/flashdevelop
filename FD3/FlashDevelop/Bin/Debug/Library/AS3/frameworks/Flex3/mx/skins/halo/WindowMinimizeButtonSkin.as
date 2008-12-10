package mx.skins.halo
{
	import flash.system.Capabilities;
	import mx.controls.Image;
	import mx.core.UIComponent;
	import mx.states.SetProperty;
	import mx.states.State;

	/**
	 *  The skin for the minimize button in the TitleBar *  of a WindowedApplication or Window. *  *  @playerversion AIR 1.1
	 */
	public class WindowMinimizeButtonSkin extends UIComponent
	{
		private static var macMinUpSkin : Class;
		private static var winMinUpSkin : Class;
		private static var macMinOverSkin : Class;
		private static var winMinOverSkin : Class;
		private static var macMinDownSkin : Class;
		private static var winMinDownSkin : Class;
		private static var macMinDisabledSkin : Class;
		private static var winMinDisabledSkin : Class;
		/**
		 *  @private
		 */
		private var isMac : Boolean;
		/**
		 *  @private
		 */
		private var skinImage : Image;

		/**
		 *  @private
		 */
		public function get measuredHeight () : Number;
		/**
		 *  @private
		 */
		public function get measuredWidth () : Number;

		/**
		 *  Constructor.
		 */
		public function WindowMinimizeButtonSkin ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		private function initializeStates () : void;
	}
}
