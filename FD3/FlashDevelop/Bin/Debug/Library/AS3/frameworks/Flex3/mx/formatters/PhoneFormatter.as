/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.formatters {
	public class PhoneFormatter extends Formatter {
		/**
		 * Area code number added to a seven-digit United States
		 *  format phone number to form a 10-digit phone number.
		 *  A value of -1 means do not
		 *  prepend the area code.
		 */
		public function get areaCode():Object;
		public function set areaCode(value:Object):void;
		/**
		 * Default format for the area code when the areacode
		 *  property is rendered by a seven-digit format.
		 */
		public function get areaCodeFormat():String;
		public function set areaCodeFormat(value:String):void;
		/**
		 * String that contains mask characters
		 *  that represent a specified phone number format.
		 */
		public function get formatString():String;
		public function set formatString(value:String):void;
		/**
		 * List of valid characters that can be used
		 *  in the formatString property.
		 *  This property is used during validation
		 *  of the formatString property.
		 */
		public function get validPatternChars():String;
		public function set validPatternChars(value:String):void;
		/**
		 * Constructor.
		 */
		public function PhoneFormatter();
		/**
		 * Formats the String as a phone number.
		 *  If the value cannot be formatted, return an empty String
		 *  and write a description of the error to the error property.
		 *
		 * @param value             <Object> Value to format.
		 * @return                  <String> Formatted String. Empty if an error occurs. A description
		 *                            of the error condition is written to the error property.
		 */
		public override function format(value:Object):String;
	}
}
