/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series.items {
	import mx.charts.ChartItem;
	import mx.charts.chartClasses.HLOCSeriesBase;
	public class HLOCSeriesItem extends ChartItem {
		/**
		 * The close value of this item converted into screen coordinates.
		 */
		public var close:Number;
		/**
		 * The close value of this item, filtered against the vertical axis of the containing chart. This value is NaN if the value lies outside the axis's range.
		 */
		public var closeFilter:Number;
		/**
		 * The close value of this item, converted to a number by the vertical axis of the containing chart.
		 */
		public var closeNumber:Number;
		/**
		 * The close value of this item.
		 */
		public var closeValue:Object;
		/**
		 * Holds fill color of the item
		 */
		public var fill:IFill;
		/**
		 * The high value of this item converted into screen coordinates.
		 */
		public var high:Number;
		/**
		 * The high value of this item, filtered against the vertical axis of the containing chart. This value is NaN if the value lies outside the axis's range.
		 */
		public var highFilter:Number;
		/**
		 * The high value of this item, converted to a number by the vertical axis of the containing chart.
		 */
		public var highNumber:Number;
		/**
		 * The high value of this item.
		 */
		public var highValue:Object;
		/**
		 * The low value of this item converted into screen coordinates.
		 */
		public var low:Number;
		/**
		 * The low value of this item, filtered against the vertical axis of the containing chart. This value is NaN if the value lies outside the axis's range.
		 */
		public var lowFilter:Number;
		/**
		 * The low value of this item, converted to a number by the vertical axis of the containing chart.
		 */
		public var lowNumber:Number;
		/**
		 * The low value of this item.
		 */
		public var lowValue:Object;
		/**
		 * The open value of this item converted into screen coordinates.
		 */
		public var open:Number;
		/**
		 * The open value of this item, filtered against the vertical axis of the containing chart. This value is NaN if the value lies outside the axis's range.
		 */
		public var openFilter:Number;
		/**
		 * The open value of this item, converted to a number by the vertical axis of the containing chart.
		 */
		public var openNumber:Number;
		/**
		 * The open value of this item.
		 */
		public var openValue:Object;
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
		 * Constructor.
		 *
		 * @param element           <HLOCSeriesBase (default = null)> The owning series.
		 * @param data              <Object (default = null)> The item from the dataProvider that this ChartItem represents.
		 * @param index             <uint (default = 0)> The index of the item from the series's dataProvider.
		 */
		public function HLOCSeriesItem(element:HLOCSeriesBase = null, data:Object = null, index:uint = 0);
	}
}
