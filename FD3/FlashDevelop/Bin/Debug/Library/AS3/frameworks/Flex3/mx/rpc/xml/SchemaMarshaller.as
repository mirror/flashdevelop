package mx.rpc.xml
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import mx.utils.Base64Encoder;
	import mx.utils.Base64Decoder;
	import mx.utils.HexEncoder;
	import mx.utils.HexDecoder;
	import mx.utils.StringUtil;

	/**
	 * FIXME: Derivations and restrictions need to be considered in addition * to base schema types *  * @private
	 */
	public class SchemaMarshaller
	{
		/**
		 * A Boolean flag to determines whether ActionScript ByteArrays should be     * serialized as base64Binary or hexBinary when specific XML Schema type     * information has not been provided. The default is true meaning     * base64Binary.     *      * @see flash.utils.ByteArray
		 */
		public static var byteArrayAsBase64Binary : Boolean;
		/**
		 * A RegEx pattern to help replace all whitespace characters in the content     * of certain simple types with #x20 (space) characters. The XML Schema     * specification defines whitespace as #x9 (tab), #xA (line feed) and     * #xD (carriage return).
		 */
		public static var whitespaceReplacePattern : RegExp;
		/**
		 * A RegEx pattern to help collapse all consecutive whitespace characters in     * the content of certain simple types to a single #x20 (space) character.     * The XML Schema specification defines whitespace as #x9 (tab),     * #xA (line feed) and #xD (carriage return).
		 */
		public static var whitespaceCollapsePattern : RegExp;
		/**
		 * A RegEx pattern to help trim all leading and trailing spaces in the     * content of certain simple types. For whitespace <code>collapse</code>,     * this RegEx is executed after the whitespaceCollapsePattern RegEx has     * been executed.
		 */
		public static var whitespaceTrimPattern : RegExp;
		public static const FLOAT_MAX_VALUE : Number = (Math.pow(2, 24) - 1) * Math.pow(2, 104);
		public static const FLOAT_MIN_VALUE : Number = Math.pow(2, -149);
		public static const LONG_MAX_VALUE : Number = 9223372036854775807;
		public static const LONG_MIN_VALUE : Number = -9223372036854775808;
		public static const SHORT_MAX_VALUE : Number = 32767;
		public static const SHORT_MIN_VALUE : Number = -32768;
		public static const BYTE_MAX_VALUE : Number = 127;
		public static const BYTE_MIN_VALUE : Number = -128;
		public static const ULONG_MAX_VALUE : Number = 18446744073709551615;
		public static const USHORT_MAX_VALUE : Number = 65535;
		public static const UBYTE_MAX_VALUE : Number = 255;
		private var marshallers : Object;
		private var unmarshallers : Object;
		private var constants : SchemaConstants;
		private var datatypes : SchemaDatatypes;
		private var _validating : Boolean;

		/**
		 * Determines whether this marshaller will throw errors for input that     * violates the specified format or restrictions for the associated type.     * Type errors are still thrown for unexpected input types.
		 */
		public function get validating () : Boolean;
		public function set validating (value:Boolean) : void;

		public function SchemaMarshaller (constants:SchemaConstants, datatypes:SchemaDatatypes);
		/**
		 * This function converts an ActionScript value to a String for XML     * simple content based on a built-in XML Schema type. If a type is not     * provided, the <code>anyType</code> is assumed.
		 */
		public function marshall (value:*, type:QName = null, restriction:XML = null) : *;
		/**
		 * This function converts XML simple content (formatted based on a built-in     * XML Schema type) to an ActionScript value. If a type is not provided,      * the <code>anyType</code> is assumed.
		 */
		public function unmarshall (value:*, type:QName = null, restriction:XML = null) : *;
		/**
		 * In the case of XML Schema ur-types such as <code>anyType</code> and     * <code>anySimpleType</code> we try to guess what the equivalent XML Schema     * simple datatype should be based on the ActionScript type. As a last      * resort, the <code>string</code> datatype is used.
		 */
		public function marshallAny (value:*, type:QName = null, restriction:XML = null) : *;
		public function marshallBase64Binary (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * The boolean schema type allows the string values 'true' or     * '1' for true values and 'false' or '0' for false values. This     * marshaller, by default, represents values using 'true' or false.     * If a String value of '1' or '0' is passed, however, it is preserved.
		 */
		public function marshallBoolean (value:*, type:QName = null, restriction:XML = null) : String;
		public function marshallDatetime (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * FIXME: Handle precision and exponent restrictions.
		 */
		public function marshallDecimal (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * FIXME: Handle precision and exponent restrictions.
		 */
		public function marshallDouble (value:*, type:QName = null, restriction:XML = null) : String;
		public function marshallDuration (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * FIXME: Handle precision and exponent restrictions.
		 */
		public function marshallFloat (value:*, type:QName = null, restriction:XML = null) : String;
		public function marshallGregorian (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * The schema type hexBinary represents arbitrary hex-encoded binary data.     * Each binary octet is encoded as a character tuple consisting of two     * hexadecimal digits (which is treated case insensitively although     * capital letters A-F are always used on encoding). These tuples are     * added to a String to serialize the binary data.
		 */
		public function marshallHexBinary (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * The schema type integer is dervied from the decimal type via restrictions     * by fixing the value of fractionDigits to be 0 and disallowing the     * trailing decimal point. The schema types long, int, short, byte are     * derived from integer by restricting the maxInclusive and minInclusive     * properties. Other types such as nonPositiveInteger, negativeInteger,     * nonNegativeInteger, positiveInteger, unsignedLong, unsignedInt,     * unsignedShort and unsignedByte are also dervied from integer through     * similar restrictions.     *      * This method first calls parses the <code>value</code> as a Number. It     * then uses <code>Math.floor()</code> on the number to remove any fraction     * digits and then checks that the result is within the specified     * <code>min</code> and <code>max</code> for the type. Note that decimal     * values are not rounded. This method handles integers longer than 32-bit     * so ActionScript int or uint types are not used internally.
		 */
		public function marshallInteger (value:*, type:QName = null, restriction:XML = null) : String;
		public function marshallString (value:*, type:QName = null, restriction:XML = null) : String;
		public function unmarshallAny (value:*, type:QName = null, restriction:XML = null) : *;
		public function unmarshallBase64Binary (value:*, type:QName = null, restriction:XML = null) : ByteArray;
		public function unmarshallBoolean (value:*, type:QName = null, restriction:XML = null) : Boolean;
		public function unmarshallDate (value:*, type:QName = null, restriction:XML = null) : Object;
		/**
		 * Handles dateTime and time types.
		 */
		public function unmarshallDatetime (value:*, type:QName = null, restriction:XML = null) : Object;
		public function unmarshallDecimal (value:*, type:QName = null, restriction:XML = null) : Number;
		public function unmarshallDouble (value:*, type:QName = null, restriction:XML = null) : Number;
		public function unmarshallDuration (value:*, type:QName = null, restriction:XML = null) : *;
		public function unmarshallFloat (value:*, type:QName = null, restriction:XML = null) : Number;
		public function unmarshallGregorian (value:*, type:QName = null, restriction:XML = null) : *;
		public function unmarshallHexBinary (value:*, type:QName = null, restriction:XML = null) : ByteArray;
		public function unmarshallInteger (value:*, type:QName = null, restriction:XML = null) : Number;
		public function unmarshallString (value:*, type:QName = null, restriction:XML = null) : String;
		public static function guessSimpleType (value:*) : *;
		private static function specialNumber (value:Number) : String;
		/**
		 * For simple types with the whitespace restriction <code>collapse</code>     * all occurrences of #x9 (tab), #xA (line feed) and #xD (carriage return)     * are replaced with #x20 (space), then consecutive spaces are collapsed     * to a single space, then finally the leading and trailing spaces are     * trimmed.
		 */
		private static function whitespaceCollapse (value:*) : String;
		/**
		 * For simple types with the whitespace restriction <code>replace</code>     * all occurrences of #x9 (tab), #xA (line feed) and #xD (carriage return)     * are replaced with #x20 (space).
		 */
		private static function whitespaceReplace (value:*) : String;
		private function registerMarshallers () : void;
	}
}
