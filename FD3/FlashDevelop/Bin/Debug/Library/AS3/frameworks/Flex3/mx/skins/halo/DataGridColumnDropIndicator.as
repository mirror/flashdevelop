package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;
	import mx.utils.ColorUtil;

include "../../core/Version.as"
	/**
	 *  The skin for the column drop indicator in a DataGrid.
	 */
	public class DataGridColumnDropIndicator extends ProgrammaticSkin
	{
		/**
		 *  Constructor.
		 */
		public function DataGridColumnDropIndicator ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
