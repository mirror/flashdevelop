/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	import mx.core.IFlexDisplayObject;
	import flash.geom.Point;
	public interface IChartElement2 extends IChartElement, IFlexDisplayObject, IBitmapDrawable, IEventDispatcher {
		/**
		 * Converts a tuple of data values to an x-y coordinate on screen.
		 *  Call this function to transform data on to the screen
		 *  using the same transform that the individual elements go through.
		 *  For example, to create a custom highlight for a data region of a chart,
		 *  you might use this function to determine the on-screen coordinates
		 *  of the range of interest.
		 *
		 * @return                  <Point> Coordinates that are relative to the chart.
		 */
		public function dataToLocal(... dataValues):Point;
		/**
		 * Returns an array of HitData of the items of all the underlying
		 *  objects that implement IChartElement2 whose dataTips
		 *  are to be shown when showAllDataTips is set
		 *  to true on chart.
		 *
		 * @return                  <Array> The HitData objects describing the data points
		 */
		public function getAllDataPoints():Array;
		/**
		 * Converts a coordinate on screen to a tuple of data values.
		 *  Call this function to determine what data values
		 *  a particular point on-screen represents.
		 *
		 * @param pt                <Point> The Point to convert.
		 * @return                  <Array> The tuple of data values.
		 */
		public function localToData(pt:Point):Array;
	}
}
