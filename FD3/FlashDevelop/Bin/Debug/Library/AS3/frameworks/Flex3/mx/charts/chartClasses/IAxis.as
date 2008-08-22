/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import flash.events.IEventDispatcher;
	import mx.charts.AxisLabel;
	public interface IAxis extends IEventDispatcher {
		/**
		 * The baseline position for the axis.
		 *  Some series, such as ColumnSeries or AreaSeries, use this value to
		 *  define the base of a filled region when no minimum value is specified.
		 */
		public function get baseline():Number;
		/**
		 * The data provider assigned to the enclosing chart.
		 *  Axis types that are data provider-based can choose to inherit
		 *  the data provider associated with the enclosing chart.
		 *  If an axis is shared among multiple charts,
		 *  the value of this property is undefined
		 *  (most likely it will be the last data provider assigned
		 *  to one of the associated charts).
		 */
		public function set chartDataProvider(value:Object):void;
		/**
		 * The name of the axis.
		 *  If set, Flex uses this name to format DataTip controls.
		 */
		public function get displayName():String;
		/**
		 * The text for the title displayed along the axis.
		 */
		public function get title():String;
		/**
		 * The size of one unit of data as represented by this axis.
		 *  This value is used by various series types to help in rendering.
		 *  The ColumnSeries class, for example, uses this value
		 *  to determine how wide columns should be rendered.
		 *  Different axis types return different values,
		 *  sometimes dependent on the data being represented.
		 *  The DateTimeAxis class, for example, might return the number
		 *  of milliseconds in a day, or a year, depending on the data
		 *  that is rendered in the chart.
		 *  Because this value is dependant on collecting the represented data,
		 *  custom series cannot assume this value is accurate in their
		 *  updateData() or updateMapping() methods.
		 */
		public function get unitSize():Number;
		/**
		 * Triggers events that inform the range object
		 *  when the chart data has changed.
		 */
		public function dataChanged():void;
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
		 * Each DataTransform that makes use of an axis
		 *  registers itself with that axis.
		 *  The axis is responsible for informing the transform
		 *  when its relevant values have changed.
		 *  It should also request values from the transform
		 *  when it wants to autogenerate minimum and maximum values.
		 *
		 * @param transform         <DataTransform> The DataTransform to register.
		 * @param dimensionName     <String> The name of the dimension.
		 */
		public function registerDataTransform(transform:DataTransform, dimensionName:String):void;
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
		 * Each DataTransform that makes use of an axis
		 *  registers itself with that axis.
		 *  The axis is responsible for informing the transform
		 *  when its relevant values have changed.
		 *  It should also request values from the transform
		 *  when it wants to autogenerate minimum and maximum values.
		 *
		 * @param transform         <DataTransform> The DataTransform to unregister.
		 */
		public function unregisterDataTransform(transform:DataTransform):void;
		/**
		 * Updates the chart.
		 *  This can be called multiple times per frame.
		 */
		public function update():void;
	}
}
