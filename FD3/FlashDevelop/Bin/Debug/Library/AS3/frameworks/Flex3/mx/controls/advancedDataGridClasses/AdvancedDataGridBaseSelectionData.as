/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.advancedDataGridClasses {
	public class AdvancedDataGridBaseSelectionData {
		/**
		 * If true, the rowIndex and columnIndex
		 *  properties contain approximate values, and not the exact value.
		 */
		public var approximate:Boolean;
		/**
		 * The column index in the data provider of the selected cell.
		 *  This value is approximate if the approximate property is true.
		 */
		public var columnIndex:int;
		/**
		 * The data Object from the data provider that represents the selected cell.
		 */
		public var data:Object;
		/**
		 * The row index in the data provider of the selected cell.
		 *  This value is approximate if the approximate property is true.
		 */
		public var rowIndex:int;
		/**
		 * Constructor.
		 *
		 * @param data              <Object> The data Object that represents the selected cell.
		 * @param rowIndex          <int> The index in the data provider of the selected item.
		 *                            This value may be approximate.
		 * @param columnIndex       <int> The column index of the selected cell.
		 * @param approximate       <Boolean> If true, the index property
		 *                            contains an approximate value and not the exact value.
		 */
		public function AdvancedDataGridBaseSelectionData(data:Object, rowIndex:int, columnIndex:int, approximate:Boolean);
	}
}
