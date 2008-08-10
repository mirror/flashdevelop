/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts {
	import mx.charts.chartClasses.IChartElement;
	public class HitData {
		/**
		 * The chart item described by the hit data.
		 *  A chart item represents the data a series uses
		 *  to describe an individual item from its dataProvider.
		 */
		public var chartItem:ChartItem;
		/**
		 * An RGB value that can be used to associate an on-screen
		 *  representation of the associated chartItem.
		 *  DataTips use this field to help render their data.
		 */
		public var contextColor:uint = 0;
		/**
		 * A function provided by the HitData creator
		 *  to generate a user-suitable String for display on screen
		 *  that describes the referenced item.
		 */
		public var dataTipFunction:Function;
		/**
		 * A description of the associated item for display on screen.
		 */
		public function get displayText():String;
		/**
		 * Specifies the distance between the data item on the screen
		 *  and the location of the mouse pointer, in pixels.
		 */
		public var distance:Number;
		/**
		 * Specifies the chart element rendering this data item
		 *  that generated the HitData structure.
		 */
		public function get element():IChartElement;
		/**
		 * Specifies a unique identifier representing the data point.
		 *  You can use this identifier to test for equality
		 *  between two HitData objects.
		 *  If two different chart elements represent the same dataProvider entry,
		 *  they will have two different identifiers.
		 */
		public var id:Number;
		/**
		 * Specifies the data item that the HitData structure describes.
		 */
		public var item:Object;
		/**
		 * Specifies the X coordinate of the data item on the screen.
		 */
		public var x:Number;
		/**
		 * Specifies the Y coordinate of the data item on the screen.
		 */
		public var y:Number;
		/**
		 * Constructor.
		 *
		 * @param id                <Number> Specifies a unique identifier representing the data point.
		 * @param distance          <Number> Specifies the distance between the data item
		 *                            on the screen and the location of the mouse pointer, in pixels.
		 * @param x                 <Number> Specifies the x coordinate of the data item on the screen.
		 * @param y                 <Number> Specifies the y coordinate of the data item on the screen.
		 * @param chartItem         <ChartItem> The chart item described by the hit data.
		 */
		public function HitData(id:Number, distance:Number, x:Number, y:Number, chartItem:ChartItem);
	}
}
