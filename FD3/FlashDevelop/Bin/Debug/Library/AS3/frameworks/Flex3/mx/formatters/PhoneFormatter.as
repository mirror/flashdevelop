package mx.formatters
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

include "../core/Version.as"
	/**
	 *  The PhoneFormatter class formats a valid number into a phone number format,
 *  including international configurations.
 *
 *  <p>A shortcut is provided for the United States seven-digit format.
 *  If the <code>areaCode</code> property contains a value
 *  and you use the seven-digit format string, (###-####),
 *  a seven-digit value to format automatically adds the area code
 *  to the returned String.
 *  The default format for the area code is (###). 
 *  You can change this using the <code>areaCodeFormat</code> property. 
 *  You can format the area code any way you want as long as it contains 
 *  three number placeholders.</p>
 *
 *  <p>If an error occurs, an empty String is returned and a String
 *  that describes the error is saved to the <code>error</code> property.
 *  The <code>error</code> property can have one of the following values:</p>
 *
 *  <ul>
 *    <li><code>"Invalid value"</code> means an invalid numeric value is passed 
 *    to the <code>format()</code> method. The value should be a valid number 
 *    in the form of a Number or a String, or the value contains a different 
 *    number of digits than what is specified in the format String.</li>
 *    <li> <code>"Invalid format"</code> means any of the characters in the 
 *    <code>formatString</code> property do not match the allowed characters 
 *    specified in the <code>validPatternChars</code> property, 
 *    or the <code>areaCodeFormat</code> property is specified but does not
 *    contain exactly three numeric placeholders.</li>
 *  </ul>
 *  
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:PhoneFormatter&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:PhoneFormatter
 *    areaCode="-1"
 *    areaCodeFormat="(###)"
 *    formatString="(###) ###-####"
 *    validPatternChars="+()#-. "
 *  />
 *  </pre>
 *  
 *  @includeExample examples/PhoneFormatterExample.mxml
 *  
 *  @see mx.formatters.SwitchSymbolFormatter
	 */
	public class PhoneFormatter extends Formatter
	{
		/**
		 *  @private
	 *  Storage for the areaCode property.
		 */
		private var _areaCode : Object;
		/**
		 *  @private
		 */
		private var areaCodeOverride : Object;
		/**
		 *  @private
	 *  Storage for the areaCodeFormat property.
		 */
		private var _areaCodeFormat : String;
		/**
		 *  @private
		 */
		private var areaCodeFormatOverride : String;
		/**
		 *  @private
	 *  Storage for the formatString property.
		 */
		private var _formatString : String;
		/**
		 *  @private
		 */
		private var formatStringOverride : String;
		/**
		 *  @private
	 *  Storage for the validPatternChars property.
		 */
		private var _validPatternChars : String;
		/**
		 *  @private
		 */
		private var validPatternCharsOverride : String;

		/**
		 *  Area code number added to a seven-digit United States
     *  format phone number to form a 10-digit phone number.
     *  A value of <code>-1</code> means do not  
     *  prepend the area code.
     *
     *  @default -1
		 */
		public function get areaCode () : Object;
		/**
		 *  @private
		 */
		public function set areaCode (value:Object) : void;

		/**
		 *  Default format for the area code when the <code>areacode</code>
     *  property is rendered by a seven-digit format.
     *
     *  @default "(###) "
		 */
		public function get areaCodeFormat () : String;
		/**
		 *  @private
		 */
		public function set areaCodeFormat (value:String) : void;

		/**
		 *  String that contains mask characters
     *  that represent a specified phone number format.
     *
     *  @default "(###) ###-####"
		 */
		public function get formatString () : String;
		/**
		 *  @private
		 */
		public function set formatString (value:String) : void;

		/**
		 *  List of valid characters that can be used
     *  in the <code>formatString</code> property.
     *  This property is used during validation
     *  of the <code>formatString</code> property.
     *
     *  @default "+()#- ."
		 */
		public function get validPatternChars () : String;
		/**
		 *  @private
		 */
		public function set validPatternChars (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function PhoneFormatter ();

		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;

		/**
		 *  Formats the String as a phone number.
     *  If the value cannot be formatted, return an empty String 
     *  and write a description of the error to the <code>error</code> property.
     *
     *  @param value Value to format.
     *
     *  @return Formatted String. Empty if an error occurs. A description 
     *  of the error condition is written to the <code>error</code> property.
		 */
		public function format (value:Object) : String;
	}
}
