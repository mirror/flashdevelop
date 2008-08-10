/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	public interface IOLAPQuery {
		/**
		 * Gets an axis from the query. You typically call this method to
		 *  obtain an uninitialized IOLAPQueryAxis instance, then configure the
		 *  IOLAPQueryAxis instance for the query.
		 *
		 * @param axisOridnal       <int> Specify OLAPQuery.COLUMN AXIS for a column axis,
		 *                            OLAPQuery.ROW_AXIS for a row axis,
		 *                            and OLAPQuery.SLICER_AXIS for a slicer axis.
		 * @return                  <IOLAPQueryAxis> The IOLAPQueryAxis instance.
		 */
		public function getAxis(axisOridnal:int):IOLAPQueryAxis;
		/**
		 * Sets an axis to the query.
		 *
		 * @param axisOridnal       <int> Specify OLAPQuery.COLUMN AXIS for a column axis,
		 *                            OLAPQuery.ROW_AXIS for a row axis,
		 *                            and OLAPQuery.SLICER_AXIS for a slicer axis.
		 * @param axis              <IOLAPQueryAxis> The IOLAPQueryAxis instance.
		 */
		public function setAxis(axisOridnal:int, axis:IOLAPQueryAxis):void;
	}
}
