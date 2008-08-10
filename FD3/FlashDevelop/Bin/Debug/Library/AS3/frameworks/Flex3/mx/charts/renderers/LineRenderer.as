/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.renderers {
	import mx.skins.ProgrammaticSkin;
	import mx.core.IDataRenderer;
	public class LineRenderer extends ProgrammaticSkin implements IDataRenderer {
		/**
		 * The chart item that this renderer represents.
		 *  LineRenderers assume that this value is an instance of LineSeriesItem.
		 *  This value is assigned by the owning series.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * Constructor.
		 */
		public function LineRenderer();
	}
}
