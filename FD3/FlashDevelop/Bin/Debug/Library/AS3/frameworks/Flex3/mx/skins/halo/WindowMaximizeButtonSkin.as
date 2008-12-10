package mx.skins.halo
{
	import flash.system.Capabilities;
	import mx.controls.Image;
	import mx.core.UIComponent;
	import mx.states.SetProperty;
	import mx.states.State;

	/**
	 *  The skin for the maximize button in the TitleBar *  of a WindowedApplication or Window. *  *  @playerversion AIR 1.1
	 */
	public class WindowMaximizeButtonSkin extends UIComponent
	{
		private static var macMaxUpSkin : Class;
		private static var winMaxUpSkin : Class;
		private static var macMaxOverSkin : Class;
		private static var winMaxOverSkin : Class;
		private static var macMaxDownSkin : Class;
		private static var winMaxDownSkin : Class;
		private static var macMaxDisabledSkin : Class;
		private static var winMaxDisabledSkin : Class;
		private static var winRestoreUpSkin : Class;
		private static var winRestoreDownSkin : Class;
		private static var winRestoreOverSkin : Class;
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
		public function WindowMaximizeButtonSkin ();
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
