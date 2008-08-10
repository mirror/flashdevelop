/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public final  class Number {
		/**
		 * Creates a Number object with the specified value. This constructor has the same effect
		 *  as the Number() public native function that converts an object of a different type
		 *  to a primitive numeric value.
		 *
		 * @param num               <Object> The numeric value of the Number instance being created or a value
		 *                            to be converted to a Number. The default value is 0 if num is
		 *                            not specified. Using the constructor without specifying a num parameter is not
		 *                            the same as declaring a variable of type Number with no value assigned (such as var myNumber:Number), which
		 *                            defaults to NaN. A number with no value assigned is undefined and the equivalent of
		 *                            new Number(undefined).
		 */
		public function Number(num:Object);
		/**
		 * Returns a string representation of the number in exponential notation. The string contains
		 *  one digit before the decimal point and up to 20 digits after the decimal point, as
		 *  specified by the fractionDigits parameter.
		 *
		 * @param fractionDigits    <uint> An integer between 0 and 20, inclusive, that represents the desired number of decimal places.
		 * @return                  <String> A string representation of the number in exponential notation. The string contains
		 *                            one digit before the decimal point and up to 20 digits after the decimal point, as
		 *                            specified by the fractionDigits parameter.
		 */
		AS3 function toExponential(fractionDigits:uint):String;
		/**
		 * Returns a string representation of the number in fixed-point notation.
		 *  Fixed-point notation means that the string will contain a specific number of digits
		 *  after the decimal point, as specified in the fractionDigits parameter.
		 *  The valid range for the fractionDigits parameter is from 0 to 20.
		 *  Specifying a value outside this range throws an exception.
		 *
		 * @param fractionDigits    <uint> An integer between 0 and 20, inclusive, that represents the desired number of decimal places.
		 * @return                  <String> A string representation of the number in fixed-point notation.
		 *                            Fixed-point notation means that the string will contain a specific number of digits
		 *                            after the decimal point, as specified in the fractionDigits parameter.
		 */
		AS3 function toFixed(fractionDigits:uint):String;
		/**
		 * Returns a string representation of the number either in exponential notation or in
		 *  fixed-point notation. The string will contain the number of digits specified in the
		 *  precision parameter.
		 *
		 * @param precision         <uint> An integer between 1 and 21, inclusive, that represents the desired number of digits to represent in the resulting string.
		 * @return                  <String> A string representation of the number either in exponential notation or in
		 *                            fixed-point notation. The string will contain the number of digits specified in the
		 *                            precision parameter.
		 */
		AS3 function toPrecision(precision:uint):String;
		/**
		 * Returns the string representation of the specified Number object (
		 *  myNumber
		 *  ).
		 *  If the value of the Number object is a decimal number without a leading zero (such as .4),
		 *  Number.toString() adds a leading zero (0.4).
		 *
		 * @param radix             <Number (default = 10)> Specifies the numeric base (from 2 to 36) to use for the number-to-string
		 *                            conversion. If you do not specify the radix parameter, the default value
		 *                            is 10.
		 * @return                  <String> The numeric representation of the Number object as a string.
		 */
		AS3 function toString(radix:Number = 10):String;
		/**
		 * Returns the primitive value type of the specified Number object.
		 *
		 * @return                  <Number> The primitive type value of the Number object.
		 */
		AS3 function valueOf():Number;
		/**
		 * The largest representable number (double-precision IEEE-754). This number is
		 *  approximately 1.79e+308.
		 */
		public static const MAX_VALUE:Number;
		/**
		 * The smallest representable non-negative, non-zero, number (double-precision IEEE-754). This number is
		 *  approximately 5e-324. The smallest representable number overall is actually -Number.MAX_VALUE.
		 */
		public static const MIN_VALUE:Number;
		/**
		 * The IEEE-754 value representing Not a Number (NaN).
		 */
		public static const NaN:Number;
		/**
		 * Specifies the IEEE-754 value representing negative infinity. The value of this property
		 *  is the same as that of the constant -Infinity.
		 */
		public static const NEGATIVE_INFINITY:Number;
		/**
		 * Specifies the IEEE-754 value representing positive infinity. The value of this property
		 *  is the same as that of the constant Infinity.
		 */
		public static const POSITIVE_INFINITY:Number;
	}
}
