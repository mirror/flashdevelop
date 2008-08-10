/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import flash.events.EventDispatcher;
	public class DataTransform extends EventDispatcher {
		/**
		 * The set of axes associated with this transform.
		 */
		public function get axes():Object;
		/**
		 * The elements that are associated with this transform.
		 *  This Array includes background, series, and overlay elements
		 *  associated with the transform.
		 *  This value is assigned by the enclosing chart object.
		 */
		public function get elements():Array;
		public function set elements(value:Array):void;
		/**
		 * Constructor.
		 */
		public function DataTransform();
		/**
		 * Informs the DataTransform that some of the underlying data
		 *  being represented on the chart has changed.
		 *  The DataTransform generally has no knowledge of the source
		 *  of the underlying data being represented by the chart,
		 *  so glyphs should call this when their data changes
		 *  so that the DataTransform can recalculate range scales
		 *  based on their data.
		 *  This does not invalidate the DataTransform,
		 *  because there is no guarantee the data has changed.
		 *  The axis objects (or range objects) must trigger an invalidate event.
		 */
		public function dataChanged():void;
		/**
		 * Collects important displayed values for all elements
		 *  associated with this data transform.
		 *  Axis instances call this method to collect the values
		 *  they need to consider when auto-generating appropriate ranges.
		 *  This method returns an Array of BoundedValue objects.
		 *
		 * @param dimension         <String> The dimension to collect values for.
		 * @param requiredFields    <uint> Defines the data that are required
		 *                            by this transform.
		 * @return                  <Array> A Array of BoundedValue objects.
		 */
		public function describeData(dimension:String, requiredFields:uint):Array;
		/**
		 * Retrieves the axis instance responsible for transforming
		 *  the data dimension specified by the dimension parameter.
		 *  If no axis has been previously assigned, a default axis is created.
		 *  The default axis for all dimensions is a LinearAxis
		 *  with the autoAdjust property set to false.
		 *
		 * @param dimension         <String> The dimension whose axis is responsible
		 *                            for transforming the data.
		 * @return                  <IAxis> The axis instance.
		 */
		public function getAxis(dimension:String):IAxis;
		/**
		 * Transforms x and y coordinates relative to the DataTransform
		 *  coordinate system into a two-dimensional value in data space.
		 */
		public function invertTransform(... values):Array;
		/**
		 * Assigns an axis instance to a particular dimension of the transform.
		 *  Axis objects are assigned by the enclosing chart object.
		 *
		 * @param dimension         <String> The dimension of the transform.
		 * @param v                 <IAxis> The target axis instance.
		 */
		public function setAxis(dimension:String, v:IAxis):void;
		/**
		 * Maps a set of numeric values representing data to screen coordinates.
		 *  This method assumes the values are all numbers,
		 *  so any non-numeric values must have been previously converted
		 *  with the mapCache() method.
		 *
		 * @param cache             <Array> An array of objects containing the data values
		 *                            in their fields. This is also where this function
		 *                            will store the converted numeric values.
		 * @param xField            <String> The field where the data values for the x axis
		 *                            can be found.
		 * @param xConvertedField   <String> The field where the mapped x screen coordinate
		 *                            will be stored.
		 * @param yField            <String> The field where the data values for the y axis
		 *                            can be found.
		 * @param yConvertedField   <String> The field where the mapped y screen coordinate
		 *                            will be stored.
		 */
		public function transformCache(cache:Array, xField:String, xConvertedField:String, yField:String, yConvertedField:String):void;
	}
}
