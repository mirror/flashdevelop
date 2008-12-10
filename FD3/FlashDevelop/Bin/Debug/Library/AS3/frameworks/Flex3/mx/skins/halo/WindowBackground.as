package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;
	import mx.utils.ColorUtil;

	/**
	 *  The skin for a Window component's background gradient. *  *  @playerversion AIR 1.1
	 */
	public class WindowBackground extends ProgrammaticSkin
	{
		/**
		 *  @private
		 */
		public function get measuredHeight () : Number;
		/**
		 *  @private
		 */
		public function get measuredWidth () : Number;

		/**
		 *  Constructor
		 */
		public function WindowBackground ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
