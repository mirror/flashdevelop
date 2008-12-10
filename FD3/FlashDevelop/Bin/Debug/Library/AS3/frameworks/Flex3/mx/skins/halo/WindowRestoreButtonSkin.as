package mx.skins.halo
{
	import flash.system.Capabilities;
	import mx.controls.Image;
	import mx.core.UIComponent;
	import mx.states.SetProperty;
	import mx.states.State;

	/**
	 *  The skin for the restore button in the TitleBar *  of a WindowedApplication or Window. *  *  @playerversion AIR 1.1
	 */
	public class WindowRestoreButtonSkin extends UIComponent
	{
		private static var winRestoreUpSkin : Class;
		private static var winRestoreDownSkin : Class;
		private static var winRestoreOverSkin : Class;
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
		public function WindowRestoreButtonSkin ();
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
