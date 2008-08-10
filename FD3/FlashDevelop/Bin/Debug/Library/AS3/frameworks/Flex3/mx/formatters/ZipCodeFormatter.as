/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.formatters {
	public class ZipCodeFormatter extends Formatter {
		/**
		 * The mask pattern.
		 *  Possible values are "#####-####",
		 *  "##### ####", "#####",
		 *  "###-###" and "### ###".
		 */
		public function get formatString():String;
		public function set formatString(value:String):void;
		/**
		 * Constructor.
		 */
		public function ZipCodeFormatter();
		/**
		 * Formats the String by using the specified format.
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
