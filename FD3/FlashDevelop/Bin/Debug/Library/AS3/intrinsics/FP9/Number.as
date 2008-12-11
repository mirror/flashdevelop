package 
{
	/// A data type representing an IEEE-754 double-precision floating-point number.
	public class Number
	{
		/// The largest representable number (double-precision IEEE-754).
		public static const MAX_VALUE:Number;

		/// The smallest representable non-negative, non-zero, number (double-precision IEEE-754).
		public static const MIN_VALUE:Number;

		/// The IEEE-754 value representing Not a Number (NaN).
		public static const NaN:Number;

		/// Specifies the IEEE-754 value representing negative infinity.
		public static const NEGATIVE_INFINITY:Number;

		/// Specifies the IEEE-754 value representing positive infinity.
		public static const POSITIVE_INFINITY:Number;

		/// Creates a Number with the specified value.
		public function Number(num:Object);

		/// Returns the string representation of this Number using the specified radix parameter as the numeric base.
		public function toString(radix:Number=10):String;

		/// Returns the primitive value type of the specified Number object.
		public function valueOf():Number;

		/// Returns a string representation of the number in fixed-point notation.
		public function toFixed(fractionDigits:uint):String;

		/// Returns a string representation of the number in exponential notation.
		public function toExponential(fractionDigits:uint):String;

		/// Returns a string representation of the number either in exponential notation or in fixed-point notation.
		public function toPrecision(precision:uint):String;

	}

}

