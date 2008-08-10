/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.formatters {
	public class NumberFormatter extends Formatter {
		/**
		 * Decimal separator character to use
		 *  when parsing an input String.
		 */
		public function get decimalSeparatorFrom():String;
		public function set decimalSeparatorFrom(value:String):void;
		/**
		 * Decimal separator character to use
		 *  when outputting formatted decimal numbers.
		 */
		public function get decimalSeparatorTo():String;
		public function set decimalSeparatorTo(value:String):void;
		/**
		 * Number of decimal places to include in the output String.
		 *  You can disable precision by setting it to -1.
		 *  A value of -1 means do not change the precision. For example,
		 *  if the input value is 1.453 and rounding
		 *  is set to NumberBaseRoundType.NONE, return a value of 1.453.
		 *  If precision is -1 and you have set some form of
		 *  rounding, return a value based on that rounding type.
		 */
		public function get precision():Object;
		public function set precision(value:Object):void;
		/**
		 * Specifies how to round the number.
		 */
		public function get rounding():String;
		public function set rounding(value:String):void;
		/**
		 * Character to use as the thousands separator
		 *  in the input String.
		 */
		public function get thousandsSeparatorFrom():String;
		public function set thousandsSeparatorFrom(value:String):void;
		/**
		 * Character to use as the thousands separator
		 *  in the output String.
		 */
		public function get thousandsSeparatorTo():String;
		public function set thousandsSeparatorTo(value:String):void;
		/**
		 * If true, format a negative number
		 *  by preceding it with a minus "-" sign.
		 *  If false, format the number
		 *  surrounded by parentheses, for example (400).
		 */
		public function get useNegativeSign():Object;
		public function set useNegativeSign(value:Object):void;
		/**
		 * If true, split the number into thousands increments
		 *  by using a separator character.
		 */
		public function get useThousandsSeparator():Object;
		public function set useThousandsSeparator(value:Object):void;
		/**
		 * Constructor.
		 */
		public function NumberFormatter();
		/**
		 * Formats the number as a String.
		 *  If value cannot be formatted, return an empty String
		 *  and write a description of the error to the error property.
		 *
		 * @param value             <Object> Value to format.
		 * @return                  <String> Formatted String. Empty if an error occurs.
		 */
		public override function format(value:Object):String;
	}
}
