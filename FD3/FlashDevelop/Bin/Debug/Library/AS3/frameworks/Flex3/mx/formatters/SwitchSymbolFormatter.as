/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.formatters {
	public class SwitchSymbolFormatter {
		/**
		 * Constructor.
		 *
		 * @param numberSymbol      <String (default = "#")> Character to use as the pattern character.
		 */
		public function SwitchSymbolFormatter(numberSymbol:String = "#");
		/**
		 * Creates a new String by formatting the source String
		 *  using the format pattern.
		 *
		 * @param format            <String> String that defines the user-requested pattern including.
		 * @param source            <Object> Valid number sequence
		 *                            (alpha characters are allowed if needed).
		 */
		public function formatValue(format:String, source:Object):String;
	}
}
