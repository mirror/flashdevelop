/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public interface IOLAPCube {
		/**
		 * All dimensions in the cube, as a list of IOLAPDimension instances.
		 */
		public function get dimensions():IList;
		/**
		 * The name of the OLAP cube.
		 */
		public function get name():String;
		/**
		 * Aborts a query that has been submitted for execution.
		 *
		 * @param query             <IOLAPQuery> The query to abort.
		 */
		public function cancelQuery(query:IOLAPQuery):void;
		/**
		 * Aborts the current cube refresh, if one is executing.
		 */
		public function cancelRefresh():void;
		/**
		 * Queues an OLAP query for execution.
		 *  After you call the refresh() method to update the cube,
		 *  you must wait for a complete event
		 *  before you call the execute() method.
		 *
		 * @param query             <IOLAPQuery> The query to execute, represented by an IOLAPQuery instance.
		 * @return                  <AsyncToken> An AsyncToken instance.
		 */
		public function execute(query:IOLAPQuery):AsyncToken;
		/**
		 * Returns the dimension with the given name within the OLAP cube.
		 *
		 * @param name              <String> The name of the dimension.
		 * @return                  <IOLAPDimension> An IOLAPDimension instance representing the dimension,
		 *                            or null if a dimension is not found.
		 */
		public function findDimension(name:String):IOLAPDimension;
		/**
		 * Refreshes the cube from the data provider.
		 *  After setting the cube's schema, you must call this method to build the cube.
		 */
		public function refresh():void;
	}
}
