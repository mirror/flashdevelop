/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public final  class Math {
		/**
		 * Computes and returns an absolute value for the number specified by the
		 *  parameter val.
		 *
		 * @param val               <Number> The number whose absolute value is returned.
		 * @return                  <Number> The absolute value of the specified paramater.
		 */
		public static function abs(val:Number):Number;
		/**
		 * Computes and returns the arc cosine of the number specified in the
		 *  parameter val, in radians.
		 *
		 * @param val               <Number> A number from -1.0 to 1.0.
		 * @return                  <Number> The arc cosine of the parameter val.
		 */
		public static function acos(val:Number):Number;
		/**
		 * Computes and returns the arc sine for the number specified in the
		 *  parameter val, in radians.
		 *
		 * @param val               <Number> A number from -1.0 to 1.0.
		 * @return                  <Number> A number between negative pi divided by 2 and positive pi
		 *                            divided by 2.
		 */
		public static function asin(val:Number):Number;
		/**
		 * Computes and returns the value, in radians, of the angle whose tangent is
		 *  specified in the parameter val. The return value is between
		 *  negative pi divided by 2 and positive pi divided by 2.
		 *
		 * @param val               <Number> A number that represents the tangent of an angle.
		 * @return                  <Number> A number between negative pi divided by 2 and positive
		 *                            pi divided by 2.
		 */
		public static function atan(val:Number):Number;
		/**
		 * Computes and returns the angle of the point y/x in
		 *  radians, when measured counterclockwise from a circle's x axis
		 *  (where 0,0 represents the center of the circle). The return value is between
		 *  positive pi and negative pi. Note that the first parameter to atan2 is always the y coordinate.
		 *
		 * @param y                 <Number> The y coordinate of the point.
		 * @param x                 <Number> The x coordinate of the point.
		 * @return                  <Number> A number.
		 */
		public static function atan2(y:Number, x:Number):Number;
		/**
		 * Returns the ceiling of the specified number or expression. The ceiling of a
		 *  number is the closest integer that is greater than or equal to the number.
		 *
		 * @param val               <Number> A number or expression.
		 * @return                  <Number> An integer that is both closest to, and greater than or equal to, the parameter
		 *                            val.
		 */
		public static function ceil(val:Number):Number;
		/**
		 * Computes and returns the cosine of the specified angle in radians. To
		 *  calculate a radian, see the overview of the Math class.
		 *
		 * @param angleRadians      <Number> A number that represents an angle measured in radians.
		 * @return                  <Number> A number from -1.0 to 1.0.
		 */
		public static function cos(angleRadians:Number):Number;
		/**
		 * Returns the value of the base of the natural logarithm (e), to the
		 *  power of the exponent specified in the parameter val. The
		 *  constant Math.E can provide the value of e.
		 *
		 * @param val               <Number> The exponent; a number or expression.
		 * @return                  <Number> e to the power of the parameter val.
		 */
		public static function exp(val:Number):Number;
		/**
		 * Returns the floor of the number or expression specified in the parameter
		 *  val. The floor is the closest integer that is less than or equal
		 *  to the specified number or expression.
		 *
		 * @param val               <Number> A number or expression.
		 * @return                  <Number> The integer that is both closest to, and less than or equal to, the parameter
		 *                            val.
		 */
		public static function floor(val:Number):Number;
		/**
		 * Returns the natural logarithm of the parameter val.
		 *
		 * @param val               <Number> A number or expression with a value greater than 0.
		 * @return                  <Number> The natural logarithm of parameter val.
		 */
		public static function log(val:Number):Number;
		/**
		 * Evaluates val1 and val2 (or more values) and returns the largest value.
		 *
		 * @param val1              <Number> A number or expression.
		 * @param val2              <Number> A number or expression.
		 * @return                  <Number> The largest of the parameters val1 and val2 (or more values).
		 */
		public static function max(val1:Number, val2:Number, ... rest):Number;
		/**
		 * Evaluates val1 and val2 (or more values) and returns the smallest value.
		 *
		 * @param val1              <Number> A number or expression.
		 * @param val2              <Number> A number or expression.
		 * @return                  <Number> The smallest of the parameters val1 and val2 (or more values).
		 */
		public static function min(val1:Number, val2:Number, ... rest):Number;
		/**
		 * Computes and returns val1 to the power of val2.
		 *
		 * @param val1              <Number> A number to be raised by the power of the parameter val2.
		 * @param val2              <Number> A number specifying the power that the parameter val1 is raised by.
		 * @return                  <Number> The value of val1 raised to the power of val2.
		 */
		public static function pow(val1:Number, val2:Number):Number;
		/**
		 * Returns a pseudo-random number n, where 0 <= n < 1. The number returned is calculated in an undisclosed manner, and pseudo-random because the calculation inevitably contains some element of non-randomness.
		 *
		 * @return                  <Number> A pseudo-random number.
		 */
		public static function random():Number;
		/**
		 * Rounds the value of the parameter val up or down to the nearest
		 *  integer and returns the value. If val is equidistant
		 *  from its two nearest integers (that is, if the number ends in .5), the value
		 *  is rounded up to the next higher integer.
		 *
		 * @param val               <Number> The number to round.
		 * @return                  <Number> The parameter val rounded to the nearest whole number.
		 */
		public static function round(val:Number):Number;
		/**
		 * Computes and returns the sine of the specified angle in radians. To
		 *  calculate a radian, see the overview of the Math class.
		 *
		 * @param angleRadians      <Number> A number that represents an angle measured in radians.
		 * @return                  <Number> A number; the sine of the specified angle (between -1.0 and 1.0).
		 */
		public static function sin(angleRadians:Number):Number;
		/**
		 * Computes and returns the square root of the specified number.
		 *
		 * @param val               <Number> A number or expression greater than or equal to 0.
		 * @return                  <Number> If the parameter val is greater than or equal to zero, a number; otherwise NaN (not a number).
		 */
		public static function sqrt(val:Number):Number;
		/**
		 * Computes and returns the tangent of the specified angle. To calculate a
		 *  radian, see the overview of the Math class.
		 *
		 * @param angleRadians      <Number> A number that represents an angle measured in radians.
		 * @return                  <Number> The tangent of the parameter angleRadians.
		 */
		public static function tan(angleRadians:Number):Number;
		/**
		 * A mathematical constant for the base of natural logarithms, expressed as e.
		 *  The approximate value of e is 2.71828182845905.
		 */
		public static const E:Number = 2.71828182845905;
		/**
		 * A mathematical constant for the natural logarithm of 10, expressed as log10,
		 *  with an approximate value of 2.302585092994046.
		 */
		public static const LN10:Number = 2.302585092994046;
		/**
		 * A mathematical constant for the natural logarithm of 2, expressed as log2,
		 *  with an approximate value of 0.6931471805599453.
		 */
		public static const LN2:Number = 0.6931471805599453;
		/**
		 * A mathematical constant for the base-10 logarithm of the constant e (Math.E),
		 *  expressed as loge, with an approximate value of 0.4342944819032518.
		 */
		public static const LOG10E:Number = 0.4342944819032518;
		/**
		 * A mathematical constant for the base-2 logarithm of the constant e, expressed
		 *  as log2e, with an approximate value of 1.442695040888963387.
		 */
		public static const LOG2E:Number = 1.442695040888963387;
		/**
		 * A mathematical constant for the ratio of the circumference of a circle to its diameter,
		 *  expressed as pi, with a value of 3.141592653589793.
		 */
		public static const PI:Number = 3.141592653589793;
		/**
		 * A mathematical constant for the square root of one-half, with an approximate
		 *  value of 0.7071067811865476.
		 */
		public static const SQRT1_2:Number = 0.7071067811865476;
		/**
		 * A mathematical constant for the square root of 2, with an approximate
		 *  value of 1.4142135623730951.
		 */
		public static const SQRT2:Number = 1.4142135623730951;
	}
}
