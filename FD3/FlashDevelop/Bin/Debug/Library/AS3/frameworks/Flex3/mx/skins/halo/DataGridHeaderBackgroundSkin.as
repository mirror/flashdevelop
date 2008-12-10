package mx.skins.halo
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import mx.styles.StyleManager;
	import mx.skins.ProgrammaticSkin;

	/**
	 *  The skin for the background of the column headers in a DataGrid control. * *  @see mx.controls.DataGrid
	 */
	public class DataGridHeaderBackgroundSkin extends ProgrammaticSkin
	{
		/**
		 *  Constructor.
		 */
		public function DataGridHeaderBackgroundSkin ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
