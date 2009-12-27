package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;

include "../../core/Version.as"
	/**
	 *  The skin for the sort arrow in a column header in a DataGrid.
	 */
	public class DataGridSortArrow extends ProgrammaticSkin
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
		public function DataGridSortArrow ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
