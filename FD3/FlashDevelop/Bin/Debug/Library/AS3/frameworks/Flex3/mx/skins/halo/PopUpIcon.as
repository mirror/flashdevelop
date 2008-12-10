package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.core.mx_internal;
	import mx.skins.ProgrammaticSkin;

	/**
	 *  The skin for all the states of the icon in a PopUpButton.
	 */
	public class PopUpIcon extends ProgrammaticSkin
	{
		/**
		 *  @private
		 */
		local var arrowColor : uint;

		/**
		 *  @private
		 */
		public function get measuredWidth () : Number;
		/**
		 *  @private
		 */
		public function get measuredHeight () : Number;

		/**
		 *  Constructor
		 */
		public function PopUpIcon ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
