package mx.formatters
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

include "../core/Version.as"
	/**
	 *  The CurrencyFormatter class formats a valid number as a currency value.
 *  It adjusts the decimal rounding and precision, the thousands separator, 
 *  and the negative sign; it also adds a currency symbol.
 *  You place the currency symbol on either the left or the right side
 *  of the value with the <code>alignSymbol</code> property.
 *  The currency symbol can contain multiple characters,
 *  including blank spaces.
 *  
 *  <p>If an error occurs, an empty String is returned and a String that describes 
 *  the error is saved to the <code>error</code> property. The <code>error</code> 
 *  property can have one of the following values:</p>
 *
 *  <ul>
 *    <li><code>"Invalid value"</code> means an invalid numeric value is passed to 
 *    the <code>format()</code> method. The value should be a valid number in the 
 *    form of a Number or a String.</li>
 *    <li><code>"Invalid format"</code> means one of the parameters contains an unusable setting.</li>
 *  </ul>
 *  
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:CurrencyFormatter&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:CurrencyFormatter
 *    alignSymbol="left|right" 
 *    currencySymbol="$"
 *    decimalSeparatorFrom="."
 *    decimalSeparatorTo="."
 *    precision="-1"
 *    rounding="none|up|down|nearest"
 *    thousandsSeparatorFrom=","
 *    thousandsSeparatorTo=","
 *    useNegativeSign="true|false"
 *    useThousandsSeparator="true|false"
 *	/>  
 *  </pre>
 *  
 *  @includeExample examples/CurrencyFormatterExample.mxml
 *  
 *  @see mx.formatters.NumberBase
 *  @see mx.formatters.NumberBaseRoundType
	 */
	public class CurrencyFormatter extends Formatter
	{
		/**
		 *  @private
	 *  Storage for the alignSymbol property.
		 */
		private var _alignSymbol : String;
		/**
		 *  @private
		 */
		private var alignSymbolOverride : String;
		/**
		 *  @private
	 *  Storage for the currencySymbol property.
		 */
		private var _currencySymbol : String;
		/**
		 *  @private
		 */
		private var currencySymbolOverride : String;
		/**
		 *  @private
	 *  Storage for the decimalSeparatorFrom property.
		 */
		private var _decimalSeparatorFrom : String;
		/**
		 *  @private
		 */
		private var decimalSeparatorFromOverride : String;
		/**
		 *  @private
	 *  Storage for the decimalSeparatorTo property.
		 */
		private var _decimalSeparatorTo : String;
		/**
		 *  @private
		 */
		private var decimalSeparatorToOverride : String;
		/**
		 *  @private
	 *  Storage for the precision property.
		 */
		private var _precision : Object;
		/**
		 *  @private
		 */
		private var precisionOverride : Object;
		/**
		 *  @private
	 *  Storage for the rounding property.
		 */
		private var _rounding : String;
		/**
		 *  @private
		 */
		private var roundingOverride : String;
		/**
		 *  @private
	 *  Storage for the thousandsSeparatorFrom property.
		 */
		private var _thousandsSeparatorFrom : String;
		/**
		 *  @private
		 */
		private var thousandsSeparatorFromOverride : String;
		/**
		 *  @private
	 *  Storage for the thousandsSeparatorTo property.
		 */
		private var _thousandsSeparatorTo : String;
		/**
		 *  @private
		 */
		private var thousandsSeparatorToOverride : String;
		/**
		 *  @private
	 *  Storage for the useNegativeSign property.
		 */
		private var _useNegativeSign : Object;
		/**
		 *  @private
		 */
		private var useNegativeSignOverride : Object;
		/**
		 *  @private
	 *  Storage for the useThousandsSeparator property.
		 */
		private var _useThousandsSeparator : Object;
		/**
		 *  @private
		 */
		private var useThousandsSeparatorOverride : Object;

		/**
		 *  Aligns currency symbol to the left side or the right side
	 *  of the formatted number.
     *  Permitted values are <code>"left"</code> and <code>"right"</code>.
	 *
     *  @default "left"
		 */
		public function get alignSymbol () : String;
		/**
		 *  @private
		 */
		public function set alignSymbol (value:String) : void;

		/**
		 *  Character to use as a currency symbol for a formatted number.
     *  You can use one or more characters to represent the currency 
	 *  symbol; for example, "$" or "YEN".
	 *  You can also use empty spaces to add space between the 
	 *  currency character and the formatted number.
	 *  When the number is a negative value, the currency symbol
	 *  appears between the number and the minus sign or parentheses.
	 *
     *  @default "$"
		 */
		public function get currencySymbol () : String;
		/**
		 *  @private
		 */
		public function set currencySymbol (value:String) : void;

		/**
		 *  Decimal separator character to use
	 *  when parsing an input string.
	 *
     *  @default "."
		 */
		public function get decimalSeparatorFrom () : String;
		/**
		 *  @private
		 */
		public function set decimalSeparatorFrom (value:String) : void;

		/**
		 *  Decimal separator character to use
	 *  when outputting formatted decimal numbers.
	 *
     *  @default "."
		 */
		public function get decimalSeparatorTo () : String;
		/**
		 *  @private
		 */
		public function set decimalSeparatorTo (value:String) : void;

		/**
		 *  Number of decimal places to include in the output String.
	 *  You can disable precision by setting it to <code>-1</code>.
	 *  A value of <code>-1</code> means do not change the precision. For example, 
	 *  if the input value is 1.453 and <code>rounding</code> 
	 *  is set to <code>NumberBaseRoundType.NONE</code>, return 1.453.
	 *  If <code>precision</code> is -1 and you set some form of 
	 *  rounding, return a value based on that rounding type.
	 *
     *  @default -1
		 */
		public function get precision () : Object;
		/**
		 *  @private
		 */
		public function set precision (value:Object) : void;

		/**
		 *  How to round the number.
	 *  In ActionScript, the value can be <code>NumberBaseRoundType.NONE</code>, 
	 *  <code>NumberBaseRoundType.UP</code>,
	 *  <code>NumberBaseRoundType.DOWN</code>, or <code>NumberBaseRoundType.NEAREST</code>.
	 *  In MXML, the value can be <code>"none"</code>, 
	 *  <code>"up"</code>, <code>"down"</code>, or <code>"nearest"</code>.
	 *
	 *  @default NumberBaseRoundType.NONE
 	 *
	 *  @see mx.formatters.NumberBaseRoundType
		 */
		public function get rounding () : String;
		/**
		 *  @private
		 */
		public function set rounding (value:String) : void;

		/**
		 *  Character to use as the thousands separator
	 *  in the input String.
	 *
     *  @default ","
		 */
		public function get thousandsSeparatorFrom () : String;
		/**
		 *  @private
		 */
		public function set thousandsSeparatorFrom (value:String) : void;

		/**
		 *  Character to use as the thousands separator
	 *  in the output string.
	 *
     *  @default ","
		 */
		public function get thousandsSeparatorTo () : String;
		/**
		 *  @private
		 */
		public function set thousandsSeparatorTo (value:String) : void;

		/**
		 *  If <code>true</code>, format a negative number 
	 *  by preceding it with a minus "-" sign.
	 *  If <code>false</code>, format the number
	 *  surrounded by parentheses, for example (400).
	 *
     *  @default true
		 */
		public function get useNegativeSign () : Object;
		/**
		 *  @private
		 */
		public function set useNegativeSign (value:Object) : void;

		/**
		 *  If <code>true</code>, split the number into thousands increments
	 *  by using a separator character.
	 *
     *  @default true
		 */
		public function get useThousandsSeparator () : Object;
		/**
		 *  @private
		 */
		public function set useThousandsSeparator (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function CurrencyFormatter ();

		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;

		/**
		 *  Formats <code>value</code> as currency.
	 *  If <code>value</code> cannot be formatted, return an empty String 
	 *  and write a description of the error to the <code>error</code> property.
	 *
     *  @param value Value to format.
	 *
     *  @return Formatted string. Empty if an error occurs.
		 */
		public function format (value:Object) : String;
	}
}
