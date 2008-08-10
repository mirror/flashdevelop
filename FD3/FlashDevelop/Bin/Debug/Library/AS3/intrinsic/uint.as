/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public final  class uint {
		/**
		 * Creates a new uint object. You can create a variable of uint type and assign it a literal value. The new uint() constructor is primarily used
		 *  as a placeholder. A uint object is not the same as the
		 *  uint() function, which converts a parameter to a primitive value.
		 *
		 * @param num               <Object> The numeric value of the uint object being created,
		 *                            or a value to be converted to a number. If num is not provided,
		 *                            the default value is 0.
		 */
		public function uint(num:Object);
		/**
		 * Returns a string representation of the number in exponential notation. The string contains
		 *  one digit before the decimal point and up to 20 digits after the decimal point, as
		 *  specified by the fractionDigits parameter.
		 *
		 * @param fractionDigits    <uint> An integer between 0 and 20, inclusive, that represents the desired number of decimal places.
		 * @return                  <String> A string representation of the number in exponential notation.
		 *                            The string contains one digit before the decimal point and up to 20 digits after the decimal point,
		 *                            as specified by the fractionDigits parameter.
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
		 * Returns the string representation of a uint object.
		 *
		 * @param radix             <uint> Specifies the numeric base (from 2 to 36) to use for the
		 *                            number-to-string conversion. If you do not specify the radix
		 *                            parameter, the default value is 10.
		 * @return                  <String> The string representation of the uint object.
		 */
		AS3 function toString(radix:uint):String;
		/**
		 * Returns the primitive uint type value of the specified
		 *  uint object.
		 *
		 * @return                  <uint> The primitive uint type value of this uint
		 *                            object.
		 */
		AS3 function valueOf():uint;
		/**
		 * The largest representable 32-bit unsigned integer, which is 4,294,967,295.
		 */
		public static const MAX_VALUE:uint = 4294967295;
		/**
		 * The smallest representable unsigned integer, which is 0.
		 */
		public static const MIN_VALUE:uint = 0;
	}
}
