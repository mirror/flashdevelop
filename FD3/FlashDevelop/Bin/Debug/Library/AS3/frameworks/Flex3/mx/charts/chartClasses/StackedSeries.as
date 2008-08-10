/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import mx.charts.HitData;
	public class StackedSeries extends Series {
		/**
		 * The grouping behavior of this series.
		 *  All stacking series support "overlaid",
		 *  "stacked", and "100%".
		 *  When the type property is "overlaid",
		 *  all sub-series are rendererd normally, with no special behavior applied.
		 *  When the type property is "stacked",
		 *  each sub-series is rendered as the sum of its data
		 *  plus the values of all previous series.
		 *  When the type property is "100%",
		 *  each sub-series is rendered as its portion of the total sum
		 *  of all series.
		 */
		public function get allowNegativeForStacked():Boolean;
		public function set allowNegativeForStacked(value:Boolean):void;
		/**
		 * Defines the labels, tick marks, and data position
		 *  for items on the x-axis.
		 *  Use either the LinearAxis class or the CategoryAxis class
		 *  to set the properties of the horizontalAxis as a child tag in MXML
		 *  or create a LinearAxis or CategoryAxis object in ActionScript.
		 */
		public function get horizontalAxis():IAxis;
		public function set horizontalAxis(value:IAxis):void;
		/**
		 * The summed totals of the stacked negative values.
		 *  This property contains a Dictionary whose keys are the values
		 *  represented by the child series along the primary axis
		 *  (for example, x axis values for a ColumnSeries, y axis values for a BarSeries),
		 *  and whose values are the summed total of all the negative child series values
		 *  at that key.
		 */
		protected var negTotalsByPrimaryAxis:Dictionary;
		/**
		 * The summed totals of the stacked positive values.
		 *  This property contains a Dictionary whose keys are the values
		 *  represented by the child series along the primary axis
		 *  (for example, x axis values for a ColumnSeries, y axis values for a BarSeries),
		 *  and whose values are the summed total of all the positive child series values
		 *  at that key.
		 */
		protected var posTotalsByPrimaryAxis:Dictionary;
		/**
		 * An array of sub-series managed by this stacking set.
		 *  These series are rendered according to the stacking behavior
		 *  of this stacking set as defined by the value
		 *  of the type property.
		 */
		public function get series():Array;
		public function set series(value:Array):void;
		/**
		 * The maximum sum represented by this stacked series.
		 */
		protected var stackedMaximum:Number;
		/**
		 * The minimum sum represented by this stacked series.
		 */
		protected var stackedMinimum:Number;
		/**
		 * The grouping behavior of this series.
		 *  All stacking series support "overlaid",
		 *  "stacked", and "100%".
		 *  When the type property is "overlaid",
		 *  all sub-series are rendererd normally, with no special behavior applied.
		 *  When the type property is "stacked",
		 *  each sub-series is rendered as the sum of its data
		 *  plus the values of all previous series.
		 *  When the type property is "100%",
		 *  each sub-series is rendered as its portion of the total sum
		 *  of all series.
		 */
		public function get type():String;
		public function set type(value:String):void;
		/**
		 * Defines the labels, tick marks, and data position
		 *  for items on the y-axis.
		 *  Use either the LinearAxis class or the CategoryAxis class
		 *  to set the properties of the horizontalAxis as a child tag in MXML
		 *  or create a LinearAxis or CategoryAxis object in ActionScript.
		 */
		public function get verticalAxis():IAxis;
		public function set verticalAxis(value:IAxis):void;
		/**
		 * Constructor.
		 */
		public function StackedSeries();
		/**
		 * Processes the Array of sub-series for display, when necessary.
		 *  This method ensures that all sub-series are added as children of this
		 *  stacking set, and applies any per-series customization that is necessary
		 *  (for example, assigning inherited data providers or clustering properties).
		 */
		protected function buildSubSeries():void;
		/**
		 * Applies any customization to a sub-series
		 *  when building the stacking behavior.
		 *  By default, this method assigns the inherited data providers
		 *  to the sub-series.
		 *  Derived classes can override this method
		 *  to apply further customization.
		 *
		 * @param g                 <IChartElement> 
		 * @param i                 <uint> 
		 */
		protected function customizeSeries(g:IChartElement, i:uint):void;
		/**
		 * Provides custom text for DataTips.
		 *  Stacking sets override the DataTip text of their contained sub-series
		 *  to display additional information related to the stacking behavior.
		 *  Derived classes must override this method to define custom DataTip text.
		 *
		 * @param hitData           <HitData> 
		 */
		protected function formatDataTip(hitData:HitData):String;
		/**
		 * Call this method to trigger a call to the buildSubSeries()
		 *  method on the next call to the commitProperties() method.
		 */
		protected function invalidateSeries():void;
		/**
		 * Call this method to trigger a regeneration of the stacked values
		 *  on the next call to the commitProperties() method.
		 */
		public function invalidateStacking():void;
		/**
		 * Updates the series data, and uses the values of the series data
		 *  it is stacking on top of so it can stack correctly.
		 */
		public function stack():void;
		/**
		 * Iterates over the individual sub-series to build the stacked values.
		 */
		protected function updateStacking():void;
	}
}
