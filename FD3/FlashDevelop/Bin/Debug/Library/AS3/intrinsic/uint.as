package 
{
	/// The uint class provides methods for working with a data type representing a 32-bit unsigned integer.
	public class uint
	{
		/// The largest representable 32-bit unsigned integer, which is 4,294,967,295.
		public static const MAX_VALUE:uint;

		/// The smallest representable unsigned integer, which is 0.
		public static const MIN_VALUE:uint;

		/// Creates a new uint object.
		public function uint(num:Object);

		/// Returns the string representation of a uint object.
		public function toString(radix:uint):String;

		/// Returns the primitive uint type value of the specified uint object.
		public function valueOf():uint;

		/// Returns a string representation of the number in fixed-point notation.
		public function toFixed(fractionDigits:uint):String;

		/// Returns a string representation of the number in exponential notation.
		public function toExponential(fractionDigits:uint):String;

		/// Returns a string representation of the number either in exponential notation or in fixed-point notation.
		public function toPrecision(precision:uint):String;

	}

}

