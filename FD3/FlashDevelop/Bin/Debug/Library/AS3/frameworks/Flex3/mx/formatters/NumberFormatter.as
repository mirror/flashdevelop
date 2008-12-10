package mx.formatters
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

	/**
	 *  The NumberFormatter class formats a valid number *  by adjusting the decimal rounding and precision, *  the thousands separator, and the negative sign. * *  <p>If you use both the <code>rounding</code> and <code>precision</code> *  properties, rounding is applied first, and then you set the decimal length *  by using the specified <code>precision</code> value. *  This lets you round a number and still have a trailing decimal; *  for example, 303.99 = 304.00.</p> * *  <p>If an error occurs, an empty String is returned and a String *  describing  the error is saved to the <code>error</code> property. *  The <code>error</code>  property can have one of the following values:</p> * *  <ul> *    <li><code>"Invalid value"</code> means an invalid numeric value is passed to  *    the <code>format()</code> method. The value should be a valid number in the  *    form of a Number or a String.</li> *    <li><code>"Invalid format"</code> means one of the parameters *    contain an unusable setting.</li> *  </ul> *   *  @mxml *   *  <p>The <code>&lt;mx:NumberFormatter&gt;</code> tag *  inherits all of the tag attributes of its superclass, *  and adds the following tag attributes:</p> *   *  <pre> *  &lt;mx:NumberFormatter *    decimalSeparatorFrom="." *    decimalSeparatorTo="." *    precision="-1" *    rounding="none|up|down|nearest" *    thousandsSeparatorFrom="," *    thousandsSeparatorTo="," *    useNegativeSign="true|false" *    useThousandsSeparator="true|false"/>   *  </pre> *   *  @includeExample examples/NumberFormatterExample.mxml *   *  @see mx.formatters.NumberBase *  @see mx.formatters.NumberBaseRoundType
	 */
	public class NumberFormatter extends Formatter
	{
		/**
		 *  @private	 *  Storage for the decimalSeparatorFrom property.
		 */
		private var _decimalSeparatorFrom : String;
		/**
		 *  @private
		 */
		private var decimalSeparatorFromOverride : String;
		/**
		 *  @private	 *  Storage for the decimalSeparatorTo property.
		 */
		private var _decimalSeparatorTo : String;
		/**
		 *  @private
		 */
		private var decimalSeparatorToOverride : String;
		/**
		 *  @private	 *  Storage for the precision property.
		 */
		private var _precision : Object;
		/**
		 *  @private
		 */
		private var precisionOverride : Object;
		/**
		 *  @private	 *  Storage for the rounding property.
		 */
		private var _rounding : String;
		/**
		 *  @private
		 */
		private var roundingOverride : String;
		/**
		 *  @private	 *  Storage for the thousandsSeparatorFrom property.
		 */
		private var _thousandsSeparatorFrom : String;
		/**
		 *  @private
		 */
		private var thousandsSeparatorFromOverride : String;
		/**
		 *  @private	 *  Storage for the thousandsSeparatorTo property.
		 */
		private var _thousandsSeparatorTo : String;
		/**
		 *  @private
		 */
		private var thousandsSeparatorToOverride : String;
		/**
		 *  @private	 *  Storage for the useNegativeSign property.
		 */
		private var _useNegativeSign : Object;
		/**
		 *  @private
		 */
		private var useNegativeSignOverride : Object;
		/**
		 *  @private	 *  Storage for the useThousandsSeparator property.
		 */
		private var _useThousandsSeparator : Object;
		/**
		 *  @private
		 */
		private var useThousandsSeparatorOverride : Object;

		/**
		 *  Decimal separator character to use	 *  when parsing an input String.	 *	 *  @default "."
		 */
		public function get decimalSeparatorFrom () : String;
		/**
		 *  @private
		 */
		public function set decimalSeparatorFrom (value:String) : void;
		/**
		 *  Decimal separator character to use	 *  when outputting formatted decimal numbers.	 *	 *  @default "."
		 */
		public function get decimalSeparatorTo () : String;
		/**
		 *  @private
		 */
		public function set decimalSeparatorTo (value:String) : void;
		/**
		 *  Number of decimal places to include in the output String.	 *  You can disable precision by setting it to <code>-1</code>.	 *  A value of <code>-1</code> means do not change the precision. For example, 	 *  if the input value is 1.453 and <code>rounding</code> 	 *  is set to <code>NumberBaseRoundType.NONE</code>, return a value of 1.453.	 *  If <code>precision</code> is <code>-1</code> and you have set some form of 	 *  rounding, return a value based on that rounding type.	 *	 *  @default -1
		 */
		public function get precision () : Object;
		/**
		 *  @private
		 */
		public function set precision (value:Object) : void;
		/**
		 *  Specifies how to round the number.     *	 *  <p>In ActionScript, you can use the following constants to set this property: 	 *  <code>NumberBaseRoundType.NONE</code>, <code>NumberBaseRoundType.UP</code>,	 *  <code>NumberBaseRoundType.DOWN</code>, or <code>NumberBaseRoundType.NEAREST</code>.     *  Valid MXML values are "down", "nearest", "up", and "none".</p>	 *	 *  @default NumberBaseRoundType.NONE 	 *	 *  @see mx.formatters.NumberBaseRoundType
		 */
		public function get rounding () : String;
		/**
		 *  @private
		 */
		public function set rounding (value:String) : void;
		/**
		 *  Character to use as the thousands separator	 *  in the input String.	 *	 *  @default ","
		 */
		public function get thousandsSeparatorFrom () : String;
		/**
		 *  @private
		 */
		public function set thousandsSeparatorFrom (value:String) : void;
		/**
		 *  Character to use as the thousands separator	 *  in the output String.	 *	 *  @default ","
		 */
		public function get thousandsSeparatorTo () : String;
		/**
		 *  @private
		 */
		public function set thousandsSeparatorTo (value:String) : void;
		/**
		 *  If <code>true</code>, format a negative number 	 *  by preceding it with a minus "-" sign.	 *  If <code>false</code>, format the number	 *  surrounded by parentheses, for example (400).	 *	 *  @default true
		 */
		public function get useNegativeSign () : Object;
		/**
		 *  @private
		 */
		public function set useNegativeSign (value:Object) : void;
		/**
		 *  If <code>true</code>, split the number into thousands increments	 *  by using a separator character.	 *	 *  @default true
		 */
		public function get useThousandsSeparator () : Object;
		/**
		 *  @private
		 */
		public function set useThousandsSeparator (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function NumberFormatter ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Formats the number as a String.	 *  If <code>value</code> cannot be formatted, return an empty String 	 *  and write a description of the error to the <code>error</code> property.	 *     *  @param value Value to format.	 *     *  @return Formatted String. Empty if an error occurs.
		 */
		public function format (value:Object) : String;
	}
}
