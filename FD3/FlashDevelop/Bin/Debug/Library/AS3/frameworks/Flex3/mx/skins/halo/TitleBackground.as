package mx.skins.halo
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;

	/**
	 *  The skin for a title bar area of a Panel.
	 */
	public class TitleBackground extends ProgrammaticSkin
	{
		/**
		 *  Constructor.
		 */
		public function TitleBackground ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
