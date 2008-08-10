/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	public class CartesianTransform extends DataTransform {
		/**
		 * The height of the data area that the CartesianTransform represents,
		 *  in pixels.
		 *  The containing chart sets this property explicitly during layout.
		 *  The CartesianTransform uses this property
		 *  to map data values to screen coordinates.
		 */
		public function set pixelHeight(value:Number):void;
		/**
		 * The width of the data area that the CartesianTransform represents,
		 *  in pixels.
		 *  The containing chart sets this property explicitly during layout.
		 *  The CartesianTransform uses this property
		 *  to map data values to screen coordinates.
		 */
		public function set pixelWidth(value:Number):void;
		/**
		 * Constructor.
		 */
		public function CartesianTransform();
		/**
		 * Transforms x and y coordinates relative to the DataTransform
		 *  coordinate system into a 2-dimensional value in data space.
		 *
		 * @return                  <Array> An Array containing the transformed values.
		 */
		public override function invertTransform(... values):Array;
		/**
		 * Maps a set of numeric values representing data to screen coordinates.
		 *  This method assumes the values are all numbers,
		 *  so any non-numeric values must have been previously converted
		 *  with the mapCache() method.
		 *
		 * @param cache             <Array> An array of objects containing the data values
		 *                            in their fields.
		 *                            This is also where this function stores the converted numeric values.
		 * @param xField            <String> The field where the data values for the x axis are stored.
		 * @param xConvertedField   <String> The field where the mapped x screen coordinate
		 *                            is stored.
		 * @param yField            <String> The field where the data values for the y axis are stored.
		 * @param yConvertedField   <String> The field where the mapped y screen coordinate
		 *                            is stored.
		 */
		public override function transformCache(cache:Array, xField:String, xConvertedField:String, yField:String, yConvertedField:String):void;
		/**
		 * A String representing the horizontal axis.
		 */
		public static const HORIZONTAL_AXIS:String = "h";
		/**
		 * A String representing the vertical axis.
		 */
		public static const VERTICAL_AXIS:String = "v";
	}
}
