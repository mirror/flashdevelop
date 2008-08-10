/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.geom {
	public class Point {
		/**
		 * The length of the line segment from (0,0) to this point.
		 */
		public function get length():Number;
		/**
		 * The horizontal coordinate of the point. The default value is 0.
		 */
		public var x:Number;
		/**
		 * The vertical coordinate of the point. The default value is 0.
		 */
		public var y:Number;
		/**
		 * Creates a new point. If you pass no parameters to this method, a point is created at (0,0).
		 *
		 * @param x                 <Number (default = 0)> The horizontal coordinate.
		 * @param y                 <Number (default = 0)> The vertical coordinate.
		 */
		public function Point(x:Number = 0, y:Number = 0);
		/**
		 * Adds the coordinates of another point to the coordinates of this point to create a new point.
		 *
		 * @param v                 <Point> The point to be added.
		 * @return                  <Point> The new point.
		 */
		public function add(v:Point):Point;
		/**
		 * Creates a copy of this Point object.
		 *
		 * @return                  <Point> The new Point object.
		 */
		public function clone():Point;
		/**
		 * Returns the distance between pt1 and pt2.
		 *
		 * @param pt1               <Point> The first point.
		 * @param pt2               <Point> The second point.
		 * @return                  <Number> The distance between the first and second points.
		 */
		public static function distance(pt1:Point, pt2:Point):Number;
		/**
		 * Determines whether two points are equal. Two points are equal if they have the same x and
		 *  y values.
		 *
		 * @param toCompare         <Point> The point to be compared.
		 * @return                  <Boolean> A value of true if the object is equal to this Point object; false if it is not equal.
		 */
		public function equals(toCompare:Point):Boolean;
		/**
		 * Determines a point between two specified points. The parameter f
		 *  determines where the new interpolated point is located relative to the two end points
		 *  specified by parameters pt1 and pt2. The closer the value of the parameter
		 *  f is to 1.0, the closer the interpolated point is to the
		 *  first point (parameter pt1). The closer the value of the parameter f is
		 *  to 0, the closer the interpolated point is to the second point (parameter pt2).
		 *
		 * @param pt1               <Point> The first point.
		 * @param pt2               <Point> The second point.
		 * @param f                 <Number> The level of interpolation between the two points. Indicates where the new point will be, along the line
		 *                            between pt1 and pt2. If f=1, pt1 is returned; if
		 *                            f=0, pt2 is returned.
		 * @return                  <Point> The new, interpolated point.
		 */
		public static function interpolate(pt1:Point, pt2:Point, f:Number):Point;
		/**
		 * Scales the line segment between (0,0) and the current point to a set length.
		 *
		 * @param thickness         <Number> The scaling value. For example, if the current point is (0,5),
		 *                            and you normalize it to 1, the point returned is at (0,1).
		 */
		public function normalize(thickness:Number):void;
		/**
		 * Offsets the Point object by the specified amount. The value of dx is added
		 *  to the original value of x to create the new x value. The value
		 *  of dy is added to the original value of y to create the new y value.
		 *
		 * @param dx                <Number> The amount by which to offset the horizontal coordinate, x.
		 * @param dy                <Number> The amount by which to offset the vertical coordinate, y.
		 */
		public function offset(dx:Number, dy:Number):void;
		/**
		 * Converts a pair of polar coordinates to a Cartesian point coordinate.
		 *
		 * @param len               <Number> The length coordinate of the polar pair.
		 * @param angle             <Number> The angle, in radians, of the polar pair.
		 * @return                  <Point> The Cartesian point.
		 */
		public static function polar(len:Number, angle:Number):Point;
		/**
		 * Subtracts the coordinates of another point from the coordinates of this point to create a new
		 *  point.
		 *
		 * @param v                 <Point> The point to be subtracted.
		 * @return                  <Point> The new point.
		 */
		public function subtract(v:Point):Point;
		/**
		 * Returns a string that contains the values of the x and y coordinates.
		 *  The string has the form "(x=x, y=y)", so calling the toString()
		 *  method for a point at 23,17 would return "(x=23, y=17)".
		 *
		 * @return                  <String> The string representation of the coordinates.
		 */
		public function toString():String;
	}
}
