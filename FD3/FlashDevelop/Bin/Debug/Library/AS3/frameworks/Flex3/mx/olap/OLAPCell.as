/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	public class OLAPCell implements IOLAPCell {
		/**
		 * The formatted value in the cell.
		 */
		public function get formattedValue():String;
		/**
		 * The raw value in the cell.
		 */
		public function get value():Number;
		/**
		 * Constructor
		 *
		 * @param value             <Number> The raw value in the cell.
		 * @param formattedValue    <String (default = null)> The formatted value in the cell.
		 */
		public function OLAPCell(value:Number, formattedValue:String = null);
	}
}
