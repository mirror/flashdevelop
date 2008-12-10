package mx.skins.halo
{
	import flash.system.Capabilities;
	import mx.core.UIComponent;
	import mx.controls.Image;
	import mx.states.SetProperty;
	import mx.states.State;

	/**
	 *  The skin for the close button in the TitleBar *  of a WindowedApplication or Window. *  *  @playerversion AIR 1.1
	 */
	public class WindowCloseButtonSkin extends UIComponent
	{
		private static var macCloseUpSkin : Class;
		private static var winCloseUpSkin : Class;
		private static var macCloseOverSkin : Class;
		private static var winCloseOverSkin : Class;
		private static var macCloseDownSkin : Class;
		private static var winCloseDownSkin : Class;
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
		public function WindowCloseButtonSkin ();
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
