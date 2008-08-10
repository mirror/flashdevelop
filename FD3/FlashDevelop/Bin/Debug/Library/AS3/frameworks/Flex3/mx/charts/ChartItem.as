/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts {
	import flash.events.EventDispatcher;
	import mx.charts.chartClasses.IChartElement;
	public class ChartItem extends EventDispatcher {
		/**
		 * Defines the appearance of the ChartItem.
		 *  The currentState property can be set to none, rollOver,
		 *  selected, disabled, focusSelected, and focused.
		 */
		public function get currentState():String;
		public function set currentState(value:String):void;
		/**
		 * The series or element that owns the ChartItem.
		 */
		public var element:IChartElement;
		/**
		 * The index of the data from the series' data provider
		 *  that the ChartItem represents.
		 */
		public var index:int;
		/**
		 * The item from the series' data provider that the ChartItem represents.
		 */
		public var item:Object;
		/**
		 * The instance of the chart's itemRenderer
		 *  that represents this ChartItem.
		 */
		public var itemRenderer:IFlexDisplayObject;
		/**
		 * Constructor.
		 *
		 * @param element           <IChartElement (default = null)> The series or element to which the ChartItem belongs.
		 * @param item              <Object (default = null)> The item from the series' data provider
		 *                            that the ChartItem represents.
		 * @param index             <uint (default = 0)> The index of the data from the series' data provider
		 *                            that the ChartItem represents.
		 */
		public function ChartItem(element:IChartElement = null, item:Object = null, index:uint = 0);
		/**
		 * Returns a copy of this ChartItem.
		 */
		public function clone():ChartItem;
		/**
		 * Value that indicates the ChartItem appears disabled and cannot be selected.
		 */
		public static const DISABLED:String = "disabled";
		/**
		 * Value that indicates the ChartItem has focus but does not appear to be selected.
		 */
		public static const FOCUSED:String = "focused";
		/**
		 * Value that indicates the ChartItem appears to have focus and appears to be selected.
		 */
		public static const FOCUSEDSELECTED:String = "focusedSelected";
		/**
		 * Value that indicates the ChartItem does not appear to be selected, does not have focus, and is not being rolled over.
		 */
		public static const NONE:String = "none";
		/**
		 * Value that indicates the ChartItem appears as if the mouse was over it.
		 */
		public static const ROLLOVER:String = "rollOver";
		/**
		 * Value that indicates the ChartItem appears selected but does not have focus.
		 */
		public static const SELECTED:String = "selected";
	}
}
