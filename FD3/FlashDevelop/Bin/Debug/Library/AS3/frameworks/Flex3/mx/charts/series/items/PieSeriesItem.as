/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series.items {
	import mx.charts.ChartItem;
	import mx.charts.series.PieSeries;
	public class PieSeriesItem extends ChartItem {
		/**
		 * The angle, in radians, that this wedge subtends.
		 */
		public var angle:Number;
		/**
		 * The fill value associated with this wedge of the PieChart control.
		 */
		public var fill:IFill;
		/**
		 * The distance of the inner edge of this wedge from its origin, measured in pixels. If 0, the wedge should come to a point at the origin.
		 */
		public var innerRadius:Number;
		/**
		 * The angle of the label, in radians, for this wedge.
		 */
		public var labelAngle:Number;
		/**
		 * The value this wedge represents converted into screen coordinates
		 */
		public var number:Number;
		/**
		 * The origin, relative to the PieSeries's coordinate system, of this wedge.
		 */
		public var origin:Point;
		/**
		 * The distance of the outer edge of this wedge from its origin, measured in pixels.
		 */
		public var outerRadius:Number;
		/**
		 * The percentage this value represents of the total pie.
		 */
		public var percentValue:Number;
		/**
		 * The start angle, in radians, of this wedge.
		 */
		public var startAngle:Number;
		/**
		 * The value this wedge represents from the PieSeries' dataProvider.
		 */
		public var value:Object;
		/**
		 * Constructor.
		 *
		 * @param element           <PieSeries (default = null)> The owning series.
		 * @param data              <Object (default = null)> The item from the dataProvider that this ChartItem represents .
		 * @param index             <uint (default = 0)> The index of the item from the series's dataProvider.
		 */
		public function PieSeriesItem(element:PieSeries = null, data:Object = null, index:uint = 0);
	}
}
