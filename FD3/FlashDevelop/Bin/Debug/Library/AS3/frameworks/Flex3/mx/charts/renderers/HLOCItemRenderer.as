/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.renderers {
	import mx.skins.ProgrammaticSkin;
	import mx.core.IDataRenderer;
	public class HLOCItemRenderer extends ProgrammaticSkin implements IDataRenderer {
		/**
		 * The chart item that this renderer represents.
		 *  HLOCItemRenderers assume this value
		 *  is an instance of HLOCSeriesItem.
		 *  This value is assigned by the owning series.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * Constructor.
		 */
		public function HLOCItemRenderer();
	}
}
