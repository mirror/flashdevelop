/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	public interface IAutomationTabularData {
		/**
		 * Names of all columns in the data.
		 */
		public function get columnNames():Array;
		/**
		 * The index of the first visible child.
		 */
		public function get firstVisibleRow():int;
		/**
		 * The index of the last visible child.
		 */
		public function get lastVisibleRow():int;
		/**
		 * The total number of columns in the data available.
		 */
		public function get numColumns():int;
		/**
		 * The total number of rows of data available.
		 */
		public function get numRows():int;
		/**
		 * Returns the values being displayed by the component for the given data.
		 *
		 * @param data              <Object> The object representing the data.
		 * @return                  <Array> Array containing the values being displayed by the component.
		 */
		public function getAutomationValueForData(data:Object):Array;
		/**
		 * Returns a matrix containing the automation values of all parts of the components.
		 *  Should be row-major (return value is an Array of rows, each of which is
		 *  an Array of "items").
		 *
		 * @param start             <uint (default = 0)> The index of the starting child.
		 * @param end               <uint (default = 0)> The index of the ending child.
		 * @return                  <Array> A matrix containing the automation values of all parts of the components.
		 */
		public function getValues(start:uint = 0, end:uint = 0):Array;
	}
}
