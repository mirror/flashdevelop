/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series {
	import mx.charts.chartClasses.HLOCSeriesBase;
	public class CandlestickSeries extends HLOCSeriesBase {
		/**
		 * Specifies a method that returns the fill for the current chart item in the series.
		 *  If this property is set, the return value of the custom fill function takes precedence over the
		 *  fill and fills style properties.
		 *  But if it returns null, then fills and fill will be
		 *  prefered in that order.
		 */
		public function get fillFunction():Function;
		public function set fillFunction(value:Function):void;
		/**
		 * Constructor.
		 */
		public function CandlestickSeries();
		/**
		 * @param x                 <Number> 
		 * @param y                 <Number> 
		 * @param sensitivity       <Number> 
		 */
		public override function findDataPoints(x:Number, y:Number, sensitivity:Number):Array;
	}
}
