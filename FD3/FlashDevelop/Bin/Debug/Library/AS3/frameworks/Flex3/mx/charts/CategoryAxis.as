/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts {
	import mx.charts.chartClasses.AxisBase;
	import mx.charts.chartClasses.IAxis;
	public class CategoryAxis extends AxisBase implements IAxis {
		/**
		 * The baseline position for the axis.
		 *  Some series, such as ColumnSeries or AreaSeries, use this value to
		 *  define the base of a filled region when no minimum value is specified.
		 */
		public function get baseline():Number;
		/**
		 * Specifies the field of the data provider
		 *  containing the text for the labels.
		 *  If this property is null, CategoryAxis assumes
		 *  that the dataProvider contains an array of Strings.
		 */
		public function get categoryField():String;
		public function set categoryField(value:String):void;
		/**
		 * Specifies a method that returns the value that should be used as
		 *  categoryValue for current item.If this property is set, the return
		 *  value of the custom data function takes precedence over
		 *  categoryField
		 */
		public function get dataFunction():Function;
		public function set dataFunction(value:Function):void;
		/**
		 * Specifies the data source containing the label names.
		 *  The dataProvider can be an Array of Strings, an Array of Objects,
		 *  or any object that implements the IList or ICollectionView interface.
		 *  If the dataProvider is an Array of Strings,
		 *  ensure that the categoryField property
		 *  is set to null.
		 *  If the dataProvider is an Array of Objects,
		 *  set the categoryField property
		 *  to the name of the field that contains the label text.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * Specifies a function that defines the labels that are generated
		 *  for each item in the CategoryAxis's dataProvider.
		 *  If no labelFunction is provided,
		 *  the axis labels default to the value of the category itself.
		 */
		public function get labelFunction():Function;
		public function set labelFunction(value:Function):void;
		/**
		 * Specifies the padding added to either side of the axis
		 *  when rendering data on the screen.
		 *  Set to 0 to map the first category to the
		 *  very beginning of the axis and the last category to the end.
		 *  Set to 0.5 to leave padding of half the width
		 *  of a category on the axis between the beginning of the axis
		 *  and the first category and between the last category
		 *  and the end of the axis.
		 */
		public function get padding():Number;
		public function set padding(value:Number):void;
		/**
		 * Specifies the location of major tick marks on the axis,
		 *  relative to the category labels.
		 *  If true, tick marks (and any associated grid lines)
		 *  appear between the categories.
		 *  If false, tick marks appear in the middle of the category,
		 *  aligned with the label.
		 */
		public function get ticksBetweenLabels():Boolean;
		public function set ticksBetweenLabels(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function CategoryAxis();
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
