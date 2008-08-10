/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import flash.events.EventDispatcher;
	public class AxisBase extends EventDispatcher {
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
		public function set displayName(value:String):void;
		/**
		 * The text for the title displayed along the axis.
		 */
		public function get title():String;
		public function set title(value:String):void;
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
		 * Constructor.
		 */
		public function AxisBase();
		/**
		 * Triggers events that inform the range object
		 *  when the chart data has changed.
		 */
		public function dataChanged():void;
		/**
		 * Called by the governing DataTransform to obtain a description
		 *  of the data represented by this IChartElement.
		 *  Implementors fill out and return an Array of
		 *  mx.charts.chartClasses.DataDescription objects
		 *  to guarantee that their data is correctly accounted for
		 *  by any axes that are autogenerating values
		 *  from the displayed data (such as minimum, maximum,
		 *  interval, and unitSize).
		 *  Most element types return an Array
		 *  containing a single DataDescription.
		 *  Aggregate elements, such as BarSet and ColumnSet,
		 *  might return multiple DataDescription instances
		 *  that describe the data displayed by their subelements.
		 *  When called, the implementor describes the data
		 *  along the axis indicated by the dimension argument.
		 *  This function might be called for each axis
		 *  supported by the containing chart.
		 *
		 * @param dimension         <String> Determines the axis to get data descriptions of.
		 * @param requiredFields    <uint> A bitfield that indicates which values
		 *                            of the DataDescription object the particular axis cares about.
		 *                            Implementors can optimize by only calculating the necessary fields.
		 * @return                  <Array> An Array containing the DataDescription instances that describe
		 *                            the data that is displayed.
		 */
		protected function describeData(dimension:String, requiredFields:uint):Array;
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
	}
}
