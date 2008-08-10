/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.renderers {
	import mx.skins.ProgrammaticSkin;
	import mx.core.IDataRenderer;
	public class CrossItemRenderer extends ProgrammaticSkin implements IDataRenderer {
		/**
		 * The chartItem that this itemRenderer is displaying.
		 *  This value is assigned by the owning series
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * The thickness of the cross rendered, in pixels.
		 *  To create cross renderers of other widths, developers should extend
		 *  this class and change this value in the derived class' constructor.
		 */
		public var thickness:Number = 3;
		/**
		 * Constructor
		 */
		public function CrossItemRenderer();
	}
}
