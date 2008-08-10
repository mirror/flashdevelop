/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.events {
	import flash.events.MouseEvent;
	import mx.charts.HitData;
	import mx.charts.chartClasses.ChartBase;
	public class ChartItemEvent extends MouseEvent {
		/**
		 * The first item in the hitSet array.
		 *  This is a convenience function for developers who don't care
		 *  about events corresponding to multiple items.
		 */
		public function get hitData():HitData;
		/**
		 * A set of HitData structures describing the chart items
		 *  that triggered the event.
		 *  This array is in depth order; the first item in the array
		 *  is the top-most item, and the last is the deepest.
		 */
		public var hitSet:Array;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The type of the event.
		 * @param hitSet            <Array (default = null)> An array of HitData structures describing
		 *                            the ChartItems that triggered the event.
		 * @param triggerEvent      <MouseEvent (default = null)> The MouseEvent that triggered this ChartItemEvent.
		 * @param target            <ChartBase (default = null)> The chart on which the event was triggered.
		 */
		public function ChartItemEvent(type:String, hitSet:Array = null, triggerEvent:MouseEvent = null, target:ChartBase = null);
		/**
		 * Event type constant; indicates that the selection in the chart has
		 *  changed.
		 */
		public static const CHANGE:String = "change";
		/**
		 * Event type constant; indicates that the user clicked the mouse button
		 *  over a chart item representing data in the chart.
		 */
		public static const ITEM_CLICK:String = "itemClick";
		/**
		 * Event type constant; indicates that the user double-clicked
		 *  the mouse button over a chart item representing data in the chart.
		 */
		public static const ITEM_DOUBLE_CLICK:String = "itemDoubleClick";
		/**
		 * Event type constant; indicates that the user pressed the mouse button
		 *  over a chart item representing data in the chart.
		 */
		public static const ITEM_MOUSE_DOWN:String = "itemMouseDown";
		/**
		 * Event type constant; indicates that the user moved the mouse pointer
		 *  while hovering over a chart item representing data in the chart.
		 */
		public static const ITEM_MOUSE_MOVE:String = "itemMouseMove";
		/**
		 * Event type constant; indicates that the user released the mouse button
		 *  while over  a chart item representing data in the chart.
		 */
		public static const ITEM_MOUSE_UP:String = "itemMouseUp";
		/**
		 * Event type constant; indicates that the user rolled the mouse pointer
		 *  away from a chart item representing data in the chart.
		 */
		public static const ITEM_ROLL_OUT:String = "itemRollOut";
		/**
		 * Event type constant; indicates that the user rolled the mouse pointer
		 *  over  a chart item representing data in the chart.
		 */
		public static const ITEM_ROLL_OVER:String = "itemRollOver";
	}
}
