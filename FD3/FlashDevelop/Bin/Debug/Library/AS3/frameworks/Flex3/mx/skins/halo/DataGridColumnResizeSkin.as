package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;

include "../../core/Version.as"
	/**
	 *  The skin for the column resizer in a DataGrid.
	 */
	public class DataGridColumnResizeSkin extends ProgrammaticSkin
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
		 *  Constructor.
		 */
		public function DataGridColumnResizeSkin ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
