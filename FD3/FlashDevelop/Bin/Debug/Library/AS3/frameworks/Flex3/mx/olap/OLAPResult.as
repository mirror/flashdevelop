/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	public class OLAPResult implements IOLAPResult {
		/**
		 * An Array of IOLAPResultAxis instances that represent all the axes of the query.
		 */
		public function get axes():Array;
		/**
		 * An Array of Arrays that contains the value of each cell of the result.
		 *  A cell is an intersection of a row and a column axis position.
		 */
		protected var cellData:Array;
		/**
		 * Specifies a column axis.
		 *  Use this property as a value of the axisOrdinal argument
		 *  to the getAxis() method.
		 */
		public static var COLUMN_AXIS:int = 0;
		/**
		 * The query whose result is represented by this object.
		 */
		public function get query():IOLAPQuery;
		public function set query(value:IOLAPQuery):void;
		/**
		 * Specifies a row axis.
		 *  Use this property as a value of the axisOrdinal argument
		 *  to the getAxis() method.
		 */
		public static var ROW_AXIS:int = 1;
		/**
		 * Specifies a slicer axis.
		 *  Use this property as a value of the axisOrdinal argument
		 *  to the getAxis() method.
		 */
		public static var SLICER_AXIS:int = 2;
		/**
		 * Returns an axis of the query result.
		 *
		 * @param axisOrdinal       <int> Specify OLAPQuery.COLUMN AXIS for a column axis,
		 *                            OLAPQuery.ROW_AXIS for a row axis,
		 *                            and OLAPQuery.SLICER_AXIS for a slicer axis.
		 * @return                  <IOLAPResultAxis> The IOLAPQueryAxis instance.
		 */
		public function getAxis(axisOrdinal:int):IOLAPResultAxis;
		/**
		 * Returns a cell at the specified location in the query result.
		 *
		 * @param x                 <int> The column of the query result.
		 * @param y                 <int> The row of the query result.
		 * @return                  <IOLAPCell> An IOLAPCell instance representing the cell.
		 */
		public function getCell(x:int, y:int):IOLAPCell;
		/**
		 * Returns true if the row contains data.
		 *
		 * @param rowIndex          <int> The index of the row in the result.
		 * @return                  <Boolean> true if the row contains data,
		 *                            and false if not.
		 */
		public function hasRowData(rowIndex:int):Boolean;
	}
}
