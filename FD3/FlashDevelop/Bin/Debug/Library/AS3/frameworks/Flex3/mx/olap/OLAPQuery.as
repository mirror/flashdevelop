/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	public class OLAPQuery implements IOLAPQuery {
		/**
		 * The axis of the Query as an Array of OLAPQueryAxis instances.
		 *  A query can have three axes: column, row, and slicer.
		 */
		public function get axes():Array;
		public function set axes(value:Array):void;
		/**
		 * Specifies a column axis.
		 *  Use this property as a value of the axisOrdinal argument
		 *  to the getAxis() method.
		 */
		public static var COLUMN_AXIS:int = 0;
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
