/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	public final  class ChartState {
		/**
		 * The chart is currently running transitions to hide the old chart data.
		 */
		public static const HIDING_DATA:uint = 2;
		/**
		 * No state. The chart is simply showing its data.
		 */
		public static const NONE:uint = 0;
		/**
		 * The display of data has changed in the chart,
		 *  and it is about to begin a transition to hide the current data.
		 */
		public static const PREPARING_TO_HIDE_DATA:uint = 1;
		/**
		 * The chart has finished any transitions to hide the old data,
		 *  and is preparing to run transitions to display the new data
		 */
		public static const PREPARING_TO_SHOW_DATA:uint = 3;
		/**
		 * The chart is currently running transitions to show the new chart data.
		 */
		public static const SHOWING_DATA:uint = 4;
	}
}
