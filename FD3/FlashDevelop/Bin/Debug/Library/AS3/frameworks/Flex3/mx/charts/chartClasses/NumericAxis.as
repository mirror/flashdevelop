/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import mx.charts.AxisLabel;
	public class NumericAxis extends AxisBase implements IAxis {
		/**
		 * The explicitly assigned maximum value.
		 *  If no value has been assigned, this will be NaN.
		 *  Typically, calculations should be performed
		 *  with the computedMaximum field.
		 */
		protected var assignedMaximum:Number;
		/**
		 * The explicitly assigned minimum value.
		 *  If no value has been assigned, this will be NaN.
		 *  Typically calculations should be performed
		 *  with the computedMinimum field.
		 */
		protected var assignedMinimum:Number;
		/**
		 * Specifies whether Flex rounds values.
		 *  If false, Flex does not round the values
		 *  set by the minimum and maximum properties,
		 *  or modify the default minimum and
		 *  maximum values.
		 */
		public function get autoAdjust():Boolean;
		public function set autoAdjust(value:Boolean):void;
		/**
		 * Specifies whether Flex tries to keep the minimum
		 *  and maximum values rooted at zero.
		 *  If all axis values are positive, the minimum axis value is zero.
		 *  If all axis values are negative, the maximum axis value is zero.
		 */
		public function get baseAtZero():Boolean;
		public function set baseAtZero(value:Boolean):void;
		/**
		 * The computed minimum value for the axis
		 *  as long as this value is greater than 0.
		 *  If the maximum value is less than or equal to 0,
		 *  then the baseline property is the computed maximum.
		 *  If neither value is greater than 0,
		 *  then the baseline property is 0.
		 */
		public function get baseline():Number;
		/**
		 * The computed interval represented by this axis.
		 *  The computedInterval is used
		 *  by the AxisRenderer and Gridlines classes
		 *  to determine where to render tick marks and grid lines.
		 *  The NumericAxis base class watches this field for changes
		 *  to determine if the chart needs to be re-rendered.
		 *  Derived classes are responsible for computing the value
		 *  of this field.
		 */
		protected var computedInterval:Number;
		/**
		 * The computed maximum value represented by this axis.
		 *  If the user has explicitly assigned a maximum value,
		 *  the computedMaximum and
		 *  assignedMaximum properties
		 *  are usually the same.
		 *  Otherwise, the computedMaximum is generated
		 *  from the values represented in the chart.
		 */
		public var computedMaximum:Number;
		/**
		 * The computed minimum value represented by this axis.
		 *  If the user has explicitly assigned a minimum value,
		 *  the computedMinimum and
		 *  assignedMinimum properties
		 *  are usually be the same.
		 *  Otherwise, the computedMinimum is generated
		 *  from the values represented in the chart.
		 */
		public var computedMinimum:Number;
		/**
		 * An Array of DataDescription structures describing the data being represented by the chart.
		 *  An axis can use this property to generate values for properties, such as its range.
		 */
		protected function get dataDescriptions():Array;
		/**
		 * The most recent set of AxisLabel objects
		 *  generated to represent this axis.
		 *  This property is null if the axis
		 *  has been modified and requires new labels.
		 *  To guarantee that the value of the labelCache property
		 *  is correct, call the buildLabelCache() method
		 *  before accessing the labelCache property.
		 */
		protected var labelCache:Array;
		/**
		 * Called to format axis values for display as labels.
		 */
		public function get labelFunction():Function;
		public function set labelFunction(value:Function):void;
		/**
		 * The maximum value where a label should be placed.
		 *  After computing an adjusted minimum value,
		 *  many axis types expand the range of the axis further
		 *  to make room for additional rendering artifacts in the chart,
		 *  such as labels and borders.
		 *  This value represents the maximum value in the chart
		 *  before it is adjusted for these artifacts.
		 *  Typically axes generate labels to make sure
		 *  this value is labeled, rather than the adjusted maximum of the axis.
		 */
		protected var labelMaximum:Number;
		/**
		 * The minimum value where a label should be placed.
		 *  After computing an adjusted minimum value,
		 *  many axis types expand the range of the axis further
		 *  to make room for additional rendering artifacts in the chart,
		 *  such as labels and borders.
		 *  This value represents the minimum value in the chart
		 *  before it is adjusted for these artifacts.
		 *  Typically axes will generate labels to make sure
		 *  this value is labeled, rather than the adjusted minimum of the axis.
		 */
		protected var labelMinimum:Number;
		/**
		 * The most recent set of minor tick marks generated to represent this axis.
		 *  This property may be null if the axis
		 *  has been modified and requires new labels and tick marks.
		 *  Use the public accessor minorTicks
		 *  to build the minor tick marks on demand.
		 */
		protected var minorTickCache:Array;
		/**
		 * An Array of minor tick marks generated to represent this axis.
		 */
		public function get minorTicks():Array;
		/**
		 * Specifies padding that Flex adds to the calculated minimum and maximum
		 *  values for the axis when rendering the values on the screen.
		 */
		public function get padding():Number;
		public function set padding(value:Number):void;
		/**
		 * Specify a parseFunction to customize how
		 *  the values rendered by your chart are converted into numeric values.
		 *  A custom parseFunction is passed a data value
		 *  and should return a corresponding number representing the same value.
		 *  By default, this axis uses the ECMA function parseFloat().
		 */
		public function get parseFunction():Function;
		public function set parseFunction(value:Function):void;
		/**
		 * The fields of the DescribeData structure that this axis is interested in.
		 */
		protected function get requiredDescribedFields():uint;
		/**
		 * An Array of tick marks for this axis.
		 */
		protected function get ticks():Array;
		/**
		 * Constructor.
		 */
		public function NumericAxis();
		/**
		 * Adjusts the generated or assigned range of the axis's labels.
		 *  This method is called during the update cycle of the axis. Subclasses can override this method
		 *  to do special processing on the values. By default, no adjustments are made to the range.
		 *
		 * @param minValue          <Number> The computed minimum value.
		 * @param maxValue          <Number> The computed maximum value.
		 */
		protected function adjustMinMax(minValue:Number, maxValue:Number):void;
		/**
		 * Populates the labelCache property with labels representing the current
		 *  values of the axis. Subclasses must implement this function. This function is called
		 *  many times, so you should check to see if the labelCache property
		 *  is null before performing any calculations.
		 *
		 * @return                  <Boolean> true if the labels were regenerated.
		 */
		protected function buildLabelCache():Boolean;
		/**
		 * Builds an Array of positions for the minor tick marks Array that is generated by this axis.
		 *  Subclasses must implement this function. This function is  called automatically
		 *  by the NumericAxis. You should access the minorTicks property
		 *  instead of calling this function directly.
		 *
		 * @return                  <Array> An Array of positions from 0 to 1 that represent points between the axis
		 *                            minimum and maximum values where minor tick marks are rendered.
		 */
		protected function buildMinorTickCache():Array;
		/**
		 * Filters a set of values of arbitrary type
		 *  to a set of numbers that can be mapped.
		 *
		 * @param cache             <Array> An Array of objects where converted values
		 *                            are read from and stored.
		 * @param field             <String> The field of the objects in the cache Array
		 *                            containing the pre-filtered values.
		 * @param filteredString    <String> The field of the objects in the cache Array
		 *                            where filtered values should be stored.
		 */
		public function filterCache(cache:Array, field:String, filteredString:String):void;
		/**
		 * Formats values for display in DataTips.
		 *  Returns a user-readable string.
		 *
		 * @param value             <Object> The value to convert to a String.
		 * @return                  <String> The text of the DataTip.
		 */
		public function formatForScreen(value:Object):String;
		/**
		 * Determines the range to estimate what the axis labels should be.
		 *  The axis almost immediately calls the getLabels() method
		 *  to get the real values.
		 *  The axis uses the estimated values to adjust chart margins,
		 *  so any difference between the estimated labels and  actual labels
		 *  (returned from the getLabels() method) results in scaling
		 *  the labels to fit.
		 *
		 * @return                  <AxisLabelSet> An Array of AxisLabel objects.
		 */
		public function getLabelEstimate():AxisLabelSet;
		/**
		 * Gets the labels text that is rendered.
		 *  When Flex calls this method,
		 *  the axis has already determined the minimum length of the label.
		 *
		 * @param minimumAxisLength <Number> The minimum length of the axis, in pixels.
		 *                            The axis can be longer than this value, but not shorter.
		 * @return                  <AxisLabelSet> An array of AxisLabel objects.
		 */
		public function getLabels(minimumAxisLength:Number):AxisLabelSet;
		/**
		 * Protects the range against invalid values for this axis type.
		 *  This function is called during the update cycle of the axis to guarantee that invalid
		 *  ranges are not generated. Subclasses can override this class and define logic that
		 *  is appropriate to their axis type.
		 *
		 * @param min               <Number> The computed minimum value.
		 * @param max               <Number> The computed maximum value.
		 * @return                  <Array> null if no adjustment is necessary, or an Array containing the adjusted
		 *                            values of the form [min,max].
		 */
		protected function guardMinMax(min:Number, max:Number):Array;
		/**
		 * Invalidates the cached labels and tick marks that represent this axis's values.
		 *  Derived classes should call this function whenever values used in the calculation
		 *  of labels and tick marks change.
		 */
		protected function invalidateCache():void;
		/**
		 * Maps a position along the axis back to a numeric data value.
		 *
		 * @param value             <Number> The bound of the axis.
		 *                            This parameter should be between 0 and 1,
		 *                            with 0 representing the minimum bound of the axis, and 1 the maximum.
		 */
		public function invertTransform(value:Number):Object;
		/**
		 * Converts a set of values of arbitrary type
		 *  to a set of numbers that can be transformed into screen coordinates.
		 *
		 * @param cache             <Array> An Array of objects where converted values
		 *                            are read from and stored.
		 * @param field             <String> The field of the objects in the cache Array
		 *                            containing the pre-converted values.
		 * @param convertedField    <String> The field of the objects in the cache Array
		 *                            where converted values should be stored.
		 * @param indexValues       <Boolean (default = false)> This parameter is true if the values being mapped
		 *                            are index values, and false if they are natural data values.
		 */
		public function mapCache(cache:Array, field:String, convertedField:String, indexValues:Boolean = false):void;
		/**
		 * Determines how the axis handles overlapping labels.
		 *  Typically, numeric ranges return true,
		 *  while discrete value-based ranges do not.
		 *  You can can override this property by setting it directly on the axis.
		 *
		 * @return                  <Boolean> true if labels can be dropped without loss of data;
		 *                            otherwise, false.
		 */
		public function preferDropLabels():Boolean;
		/**
		 * Invoked when an AxisRenderer is unable to cleanly render
		 *  the labels without overlap, and would like the Axis object
		 *  to reduce the set of labels.
		 *  The method is passed the two labels that are overlapping.
		 *
		 * @param intervalStart     <AxisLabel> The start of the interval where labels overlap.
		 * @param intervalEnd       <AxisLabel> The end of the interval where labels overlap.
		 * @return                  <AxisLabelSet> A new label set that resolves the overlap by reducing
		 *                            the number of labels.
		 */
		public function reduceLabels(intervalStart:AxisLabel, intervalEnd:AxisLabel):AxisLabelSet;
		/**
		 * Maps a set of values from data space to screen space.
		 *
		 * @param cache             <Array> An Array of objects where mapped values
		 *                            are read from and stored.
		 * @param field             <String> The field of the objects in the cache Array
		 *                            containing the pre-mapped values.
		 * @param convertedField    <String> The field of the objects in the cache Array
		 *                            where mapped values should be stored.
		 */
		public function transformCache(cache:Array, field:String, convertedField:String):void;
		/**
		 * Updates the chart.
		 *  This can be called multiple times per frame.
		 */
		public function update():void;
	}
}
