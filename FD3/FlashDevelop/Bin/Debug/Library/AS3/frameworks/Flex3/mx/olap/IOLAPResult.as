/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	public interface IOLAPResult {
		/**
		 * An Array of IOLAPResultAxis instances that represent all the axes of the query.
		 */
		public function get axes():Array;
		/**
		 * The query whose result is represented by this object.
		 */
		public function get query():IOLAPQuery;
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
	}
}
