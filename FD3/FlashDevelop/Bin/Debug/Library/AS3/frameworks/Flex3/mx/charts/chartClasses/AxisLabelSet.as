/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	public class AxisLabelSet {
		/**
		 * When returned from the getLabelEstimate() method,
		 *  set to true if the estimate accurately represents
		 *  the final labels to be rendered. This property is irrelevant
		 *  in other contexts.
		 */
		public var accurate:Boolean;
		/**
		 * An array of AxisLabel objects
		 *  representing the values of the generating axis.
		 */
		public var labels:Array;
		/**
		 * An array of values from 0 to 1
		 *  representing where to place minor tick marks along the axis.
		 */
		public var minorTicks:Array;
		/**
		 * An array of values from 0 to 1
		 *  representing where to place tick marks along the axis.
		 */
		public var ticks:Array;
		/**
		 * Constructor.
		 */
		public function AxisLabelSet();
	}
}
