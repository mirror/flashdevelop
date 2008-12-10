package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;

	/**
	 *  The skin for the drop indicator of a list-based control.
	 */
	public class ListDropIndicator extends ProgrammaticSkin
	{
		/**
		 *  Should the skin draw a horizontal line or vertical line.	 *  Default is horizontal.
		 */
		public var direction : String;

		/**
		 *  Constructor.
		 */
		public function ListDropIndicator ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
