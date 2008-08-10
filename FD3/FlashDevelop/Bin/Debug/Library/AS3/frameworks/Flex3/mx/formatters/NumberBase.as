/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.formatters {
	public class NumberBase {
		/**
		 * Decimal separator character to use
		 *  when parsing an input String.
		 */
		public var decimalSeparatorFrom:String;
		/**
		 * Decimal separator character to use
		 *  when outputting formatted decimal numbers.
		 */
		public var decimalSeparatorTo:String;
		/**
		 * If true, the format succeeded,
		 *  otherwise it is false.
		 */
		public var isValid:Boolean = false;
		/**
		 * Character to use as the thousands separator
		 *  in the input String.
		 */
		public var thousandsSeparatorFrom:String;
		/**
		 * Character to use as the thousands separator
		 *  in the output String.
		 */
		public var thousandsSeparatorTo:String;
		/**
		 * Constructor.
		 *
		 * @param decimalSeparatorFrom<String (default = ".")> Decimal separator to use
		 *                            when parsing an input String.
		 * @param thousandsSeparatorFrom<String (default = ",")> Character to use
		 *                            as the thousands separator in the input String.
		 * @param decimalSeparatorTo<String (default = ".")> Decimal separator character to use
		 *                            when outputting formatted decimal numbers.
		 * @param thousandsSeparatorTo<String (default = ",")> Character to use
		 *                            as the thousands separator in the output String.
		 */
		public function NumberBase(decimalSeparatorFrom:String = ".", thousandsSeparatorFrom:String = ",", decimalSeparatorTo:String = ".", thousandsSeparatorTo:String = ",");
		/**
		 * Formats a number by replacing the default decimal separator, ".",
		 *  with the decimal separator specified by decimalSeparatorTo.
		 *
		 * @param value             <String> The String value of the Number
		 *                            (formatted American style ####.##).
		 * @return                  <String> String representation of the input where "." is replaced
		 *                            with the decimal formatting character.
		 */
		public function formatDecimal(value:String):String;
		/**
		 * Formats a negative number with either a minus sign (-)
		 *  or parentheses ().
		 *
		 * @param value             <String> Value to be formatted.
		 * @param useSign           <Boolean> If true, use a minus sign (-).
		 *                            If false, use parentheses ().
		 * @return                  <String> Formatted number.
		 */
		public function formatNegative(value:String, useSign:Boolean):String;
		/**
		 * Formats a number by setting its decimal precision by using
		 *  the decimalSeparatorTo property as the decimal separator.
		 *
		 * @param value             <String> Value to be formatted.
		 * @param precision         <int> Number of decimal points to use.
		 * @return                  <String> Formatted number.
		 */
		public function formatPrecision(value:String, precision:int):String;
		/**
		 * Formats a number by rounding it.
		 *  The possible rounding types are defined by
		 *  mx.formatters.NumberBaseRoundType.
		 *
		 * @param value             <String> Value to be rounded.
		 * @param roundType         <String> The type of rounding to perform:
		 *                            NumberBaseRoundType.NONE, NumberBaseRoundType.UP,
		 *                            NumberBaseRoundType.DOWN, or NumberBaseRoundType.NEAREST.
		 * @return                  <String> Formatted number.
		 */
		public function formatRounding(value:String, roundType:String):String;
		/**
		 * Formats a number by rounding it and setting the decimal precision.
		 *  The possible rounding types are defined by
		 *  mx.formatters.NumberBaseRoundType.
		 *
		 * @param value             <String> Value to be rounded.
		 * @param roundType         <String> The type of rounding to perform:
		 *                            NumberBaseRoundType.NONE, NumberBaseRoundType.UP,
		 *                            NumberBaseRoundType.DOWN, or NumberBaseRoundType.NEAREST.
		 * @param precision         <int> int of decimal places to use.
		 * @return                  <String> Formatted number.
		 */
		public function formatRoundingWithPrecision(value:String, roundType:String, precision:int):String;
		/**
		 * Formats a number by using
		 *  the thousandsSeparatorTo property as the thousands separator
		 *  and the decimalSeparatorTo property as the decimal separator.
		 *
		 * @param value             <String> Value to be formatted.
		 * @return                  <String> Formatted number.
		 */
		public function formatThousands(value:String):String;
		/**
		 * Extracts a number from a formatted String.
		 *  Examines the String from left to right
		 *  and returns the first number sequence.
		 *  Ignores thousands separators and includes the
		 *  decimal and numbers trailing the decimal.
		 *
		 * @param str               <String> String to parse for the numeric value.
		 * @return                  <String> Value, which can be a decimal.
		 */
		public function parseNumberString(str:String):String;
	}
}
