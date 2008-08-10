/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.formatters {
	public class DateFormatter extends Formatter {
		/**
		 * The mask pattern.
		 */
		public function get formatString():String;
		public function set formatString(value:String):void;
		/**
		 * Constructor.
		 */
		public function DateFormatter();
		/**
		 * Generates a date-formatted String from either a date-formatted String or a Date object.
		 *  The formatString property
		 *  determines the format of the output String.
		 *  If value cannot be formatted, return an empty String
		 *  and write a description of the error to the error property.
		 *
		 * @param value             <Object> Date to format. This can be a Date object,
		 *                            or a date-formatted String such as "Thursday, April 22, 2004".
		 * @return                  <String> Formatted String. Empty if an error occurs. A description
		 *                            of the error condition is written to the error property.
		 */
		public override function format(value:Object):String;
		/**
		 * Converts a date that is formatted as a String into a Date object.
		 *  Month and day names must match the names in mx.formatters.DateBase.
		 *
		 * @param str               <String> Date that is formatted as a String.
		 * @return                  <Date> Date object.
		 */
		protected static function parseDateString(str:String):Date;
	}
}
