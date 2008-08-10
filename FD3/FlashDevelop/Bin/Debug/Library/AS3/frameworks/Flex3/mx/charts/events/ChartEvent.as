/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.events {
	import flash.events.MouseEvent;
	import mx.charts.chartClasses.ChartBase;
	public class ChartEvent extends MouseEvent {
		/**
		 * Constructor.
		 *
		 * @param type              <String> The type of the event.
		 * @param triggerEvent      <MouseEvent (default = null)> The MouseEvent that triggered this ChartEvent.
		 * @param target            <ChartBase (default = null)> The chart on which the event was triggered.
		 */
		public function ChartEvent(type:String, triggerEvent:MouseEvent = null, target:ChartBase = null);
		/**
		 * Indicates that the user clicked the mouse button
		 *  over a chart control but not on a chart item.
		 */
		public static const CHART_CLICK:String = "chartClick";
		/**
		 * Indicates that the user double-clicked
		 *  the mouse button over a chart control but not on a chart item.
		 */
		public static const CHART_DOUBLE_CLICK:String = "chartDoubleClick";
	}
}
