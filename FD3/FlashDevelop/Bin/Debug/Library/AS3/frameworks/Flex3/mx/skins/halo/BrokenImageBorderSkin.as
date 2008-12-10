package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;

	/**
	 *  The skin for the border of a SWFLoader or Image component when the content *  could not be loaded.
	 */
	public class BrokenImageBorderSkin extends ProgrammaticSkin
	{
		/**
		 *  Constructor.
		 */
		public function BrokenImageBorderSkin ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
