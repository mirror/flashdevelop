/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import flash.geom.Point;
	public class PolarTransform extends DataTransform {
		/**
		 * The origin of the polar transform.
		 *  This point is used by associated series to convert data units
		 *  to screen coordinates.
		 */
		public function get origin():Point;
		/**
		 * The radius used by the transform to convert data units
		 *  to polar coordinates.
		 */
		public function get radius():Number;
		/**
		 * Constructor.
		 */
		public function PolarTransform();
		/**
		 * Sets the width and height that the PolarTransfor uses
		 *  when calculating origin and radius.
		 *  The containing chart calls this method.
		 *  It should not generally be called directly.
		 *
		 * @param width             <Number> 
		 * @param height            <Number> 
		 */
		public function setSize(width:Number, height:Number):void;
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
		public override function transformCache(cache:Array, xField:String, xConvertedField:String, yField:String, yConvertedField:String):void;
		/**
		 * A string representing the angular axis.
		 */
		public static const ANGULAR_AXIS:String = "a";
		/**
		 * A string representing the radial axis.
		 */
		public static const RADIAL_AXIS:String = "r";
	}
}
