/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	public class DataDescription {
		/**
		 * An Array of BoundedValue objects describing the data in the element.
		 *  BoundedValues are data points that have extra space reserved
		 *  around the datapoint in the chart's data area.
		 *  If requested, a chart element fills this property
		 *  with whatever BoundedValues are necessary
		 *  to ensure enough space is visible in the chart data area.
		 *  For example, a ColumnSeries that needs 20 pixels
		 *  above each column to display a data label.
		 */
		public var boundedValues:Array;
		/**
		 * The maximum data value displayed by the element.
		 */
		public var max:Number;
		/**
		 * The minimum data value displayed by the element.
		 */
		public var min:Number;
		/**
		 * The minimum interval, in data units,
		 *  between any two values displayed by the element.
		 */
		public var minInterval:Number;
		/**
		 * The amount of padding, in data units, that the element requires
		 *  beyond its min/max values to display its full values correctly .
		 */
		public var padding:Number;
		/**
		 * Constructor.
		 */
		public function DataDescription();
		/**
		 * A bitflag passed by the axis to an element's describeData() method.
		 *  If this flag is set, the element sets the
		 *  boundedValues property.
		 */
		public static const REQUIRED_BOUNDED_VALUES:uint = 0x2;
		/**
		 * A bitflag passed by the axis to an element's describeData() method.
		 *  If this flag is set, the element sets the
		 *  minInterval property.
		 */
		public static const REQUIRED_MIN_INTERVAL:uint = 0x1;
		/**
		 * A bitflag passed by the axis to an element's describeData() method.
		 *  If this flag is set, the element sets the
		 *  DescribeData.min and DescribeData.max properties.
		 */
		public static const REQUIRED_MIN_MAX:uint = 0x4;
		/**
		 * A bitflag passed by the axis to an element's describeData() method.
		 *  If this flag is set, the element sets the
		 *  DescribeData.padding property.
		 */
		public static const REQUIRED_PADDING:uint = 0x8;
	}
}
