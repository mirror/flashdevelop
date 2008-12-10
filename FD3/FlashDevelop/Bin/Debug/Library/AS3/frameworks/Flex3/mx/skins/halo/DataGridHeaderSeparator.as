package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;

	/**
	 *  The skin for the separator between column headers in a DataGrid.
	 */
	public class DataGridHeaderSeparator extends ProgrammaticSkin
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
		public function DataGridHeaderSeparator ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
