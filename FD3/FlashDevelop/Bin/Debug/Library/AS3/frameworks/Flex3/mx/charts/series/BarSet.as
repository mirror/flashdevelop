/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series {
	import mx.charts.chartClasses.StackedSeries;
	import mx.charts.chartClasses.IBar;
	public class BarSet extends StackedSeries implements IBar {
		/**
		 * Specifies how wide to render the bars relative to the category width. A value of 1 uses the entire space, while a value of .6
		 *  uses 60% of the bar's available space.
		 *  You typically do not set this property directly.
		 *  The actual bar width used is the smaller of barWidthRatio and the maxbarWidth property
		 */
		public function get barWidthRatio():Number;
		public function set barWidthRatio(value:Number):void;
		/**
		 * Specifies how wide to draw the bars, in pixels.  The actual bar width used is the smaller of this style and the barWidthRatio property.
		 *  Clustered bars divide this space proportionally among the bars in each cluster.
		 */
		public function get maxBarWidth():Number;
		public function set maxBarWidth(value:Number):void;
		/**
		 * Specifies how far to offset the center of the bars from the center of the available space, relative the category width.
		 *  The range of values is a percentage in the range -100 to 100.
		 *  Set to 0 to center the bars in the space. Set to -50 to center the column at the beginning of the available space. You typically do not set this property directly.
		 */
		public function get offset():Number;
		public function set offset(value:Number):void;
		/**
		 * Constructor.
		 */
		public function BarSet();
		/**
		 * Updates the series data, and uses the values of the series data
		 *  it is stacking on top of so it can stack correctly.
		 */
		public override function stack():void;
	}
}
