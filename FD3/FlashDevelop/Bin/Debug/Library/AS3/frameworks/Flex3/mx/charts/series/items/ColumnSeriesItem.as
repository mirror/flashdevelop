/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series.items {
	import mx.charts.ChartItem;
	import mx.charts.series.ColumnSeries;
	public class ColumnSeriesItem extends ChartItem {
		/**
		 * Holds the fill color of the item
		 */
		public var fill:IFill;
		/**
		 * The minimum value of this item converted into screen coordinates. The value of this field is undefined if the ColumnSeries is not stacked and its minField property is not set.
		 */
		public var min:Number;
		/**
		 * The minimum value of this item, filtered against the vertical axis of the containing chart.
		 *  This value is NaN if the value lies outside the axis' range.
		 *  The value of this field is undefined if the ColumnSeries is not stacked and its minField property is not set.
		 */
		public var minFilter:Number;
		/**
		 * The minimum value of this item, converted to a number by the vertical axis of the containing chart.
		 *  The value of this field is undefined if the ColumnSeries is not stacked and its minField property is not set.
		 */
		public var minNumber:Number;
		/**
		 * The miniumum value of this item.
		 *  The value of this field is undefined if the ColumnSeries is not stacked and its minField property is not set.
		 */
		public var minValue:Object;
		/**
		 * The x value of this item converted into screen coordinates.
		 */
		public var x:Number;
		/**
		 * The x value of this item, filtered against the horizontal axis of the containing chart. This value is NaN if the value lies outside the axis's range.
		 */
		public var xFilter:Number;
		/**
		 * The x value of this item, converted to a number by the horizontal axis of the containing chart.
		 */
		public var xNumber:Number;
		/**
		 * The x value of this item.
		 */
		public var xValue:Object;
		/**
		 * The y value of this item converted into screen coordinates
		 */
		public var y:Number;
		/**
		 * The y value of this item, filtered against the vertical axis of the containing chart. This value is NaN if the value lies outside the axis's range.
		 */
		public var yFilter:Number;
		/**
		 * The y value of this item, converted to a number by the vertical axis of the containing chart.
		 */
		public var yNumber:Number;
		/**
		 * The y value of this item.
		 */
		public var yValue:Object;
		/**
		 * Constructor.
		 *
		 * @param element           <ColumnSeries (default = null)> The owning series.
		 * @param data              <Object (default = null)> The item from the dataProvider that this ChartItem represents.
		 * @param index             <uint (default = 0)> The index of the item from the series's dataProvider.
		 */
		public function ColumnSeriesItem(element:ColumnSeries = null, data:Object = null, index:uint = 0);
	}
}
