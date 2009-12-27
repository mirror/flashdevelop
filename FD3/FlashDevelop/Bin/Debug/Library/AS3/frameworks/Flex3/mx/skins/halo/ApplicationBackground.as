package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;
	import mx.utils.ColorUtil;

include "../../core/Version.as"
	/**
	 *  The skin for application background gradient.
	 */
	public class ApplicationBackground extends ProgrammaticSkin
	{
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
		public function ApplicationBackground ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
