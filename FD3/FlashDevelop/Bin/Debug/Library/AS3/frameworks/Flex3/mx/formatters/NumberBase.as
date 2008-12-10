package mx.formatters
{
	/**
	 *  The NumberBase class is a utility class that contains *  general number formatting capabilities, including rounding, *  precision, thousands formatting, and negative sign formatting. *  The implementation of the formatter classes use this class. * *  @see mx.formatters.NumberFormatter *  @see mx.formatters.NumberBaseRoundType
	 */
	public class NumberBase
	{
		/**
		 *  Decimal separator character to use	 *  when parsing an input String.	 *  	 *  @default "."
		 */
		public var decimalSeparatorFrom : String;
		/**
		 *  Decimal separator character to use	 *  when outputting formatted decimal numbers.	 *  	 *  @default "."
		 */
		public var decimalSeparatorTo : String;
		/**
		 *  If <code>true</code>, the format succeeded,	 *  otherwise it is <code>false</code>.
		 */
		public var isValid : Boolean;
		/**
		 *  Character to use as the thousands separator	 *  in the input String.	 *  	 *  @default ","
		 */
		public var thousandsSeparatorFrom : String;
		/**
		 *  Character to use as the thousands separator	 *  in the output String.	 *  	 *  @default ","
		 */
		public var thousandsSeparatorTo : String;

		/**
		 *  Constructor.	 * 	 *  @param decimalSeparatorFrom Decimal separator to use	 *  when parsing an input String.	 *	 *  @param thousandsSeparatorFrom Character to use	 *  as the thousands separator in the input String.	 *	 *  @param decimalSeparatorTo Decimal separator character to use	 *  when outputting formatted decimal numbers.	 *	 *  @param thousandsSeparatorTo Character to use	 *  as the thousands separator in the output String.
		 */
		public function NumberBase (decimalSeparatorFrom:String = ".", thousandsSeparatorFrom:String = ",", decimalSeparatorTo:String = ".", thousandsSeparatorTo:String = ",");
		/**
		 *  Formats a number by rounding it. 	 *  The possible rounding types are defined by	 *  mx.formatters.NumberBaseRoundType.	 *	 *  @param value Value to be rounded.	 *	 *  @param roundType The type of rounding to perform:	 *  NumberBaseRoundType.NONE, NumberBaseRoundType.UP,	 *  NumberBaseRoundType.DOWN, or NumberBaseRoundType.NEAREST.	 *	 *  @return Formatted number.	 *	 *  @see mx.formatters.NumberBaseRoundType
		 */
		public function formatRounding (value:String, roundType:String) : String;
		/**
		 *  Formats a number by rounding it and setting the decimal precision.	 *  The possible rounding types are defined by	 *  mx.formatters.NumberBaseRoundType.	 *	 *  @param value Value to be rounded.	 *	 *  @param roundType The type of rounding to perform:	 *  NumberBaseRoundType.NONE, NumberBaseRoundType.UP,	 *  NumberBaseRoundType.DOWN, or NumberBaseRoundType.NEAREST.	 *	 *  @param precision int of decimal places to use.	 *	 *  @return Formatted number.	 *	 *  @see mx.formatters.NumberBaseRoundType
		 */
		public function formatRoundingWithPrecision (value:String, roundType:String, precision:int) : String;
		/**
		 *  Formats a number by replacing the default decimal separator, ".", 	 *  with the decimal separator specified by <code>decimalSeparatorTo</code>. 	 *	 *  @param value The String value of the Number	 *  (formatted American style ####.##).	 *	 *  @return String representation of the input where "." is replaced	 *  with the decimal formatting character.
		 */
		public function formatDecimal (value:String) : String;
		/**
		 *  Formats a number by using 	 *  the <code>thousandsSeparatorTo</code> property as the thousands separator 	 *  and the <code>decimalSeparatorTo</code> property as the decimal separator.	 *	 *  @param value Value to be formatted.	 *	 *  @return Formatted number.
		 */
		public function formatThousands (value:String) : String;
		/**
		 *  Formats a number by setting its decimal precision by using 	 *  the <code>decimalSeparatorTo</code> property as the decimal separator.	 *	 *  @param value Value to be formatted.	 *	 *  @param precision Number of decimal points to use.	 *	 *  @return Formatted number.
		 */
		public function formatPrecision (value:String, precision:int) : String;
		/**
		 *  Formats a negative number with either a minus sign (-)	 *  or parentheses ().	 *	 *  @param value Value to be formatted.	 *	 *  @param useSign If <code>true</code>, use a minus sign (-).	 *  If <code>false</code>, use parentheses ().	 *	 *  @return Formatted number.
		 */
		public function formatNegative (value:String, useSign:Boolean) : String;
		/**
		 *  Extracts a number from a formatted String.	 *  Examines the String from left to right	 *  and returns the first number sequence.	 *  Ignores thousands separators and includes the	 *  decimal and numbers trailing the decimal.	 *	 *  @param str String to parse for the numeric value.	 *	 *  @return Value, which can be a decimal.
		 */
		public function parseNumberString (str:String) : String;
	}
}
