/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public interface IOLAPSchema {
		/**
		 * All the cubes known by this schema, as a list of IOLAPCube instances.
		 *  The returned list might represent remote data and therefore can throw
		 *  an ItemPendingError.
		 */
		public function get cubes():IList;
		/**
		 * Creates an OLAP cube from the schema.
		 *
		 * @param name              <String> The name of the cube.
		 * @return                  <IOLAPCube> The IOLAPCube instance.
		 */
		public function createCube(name:String):IOLAPCube;
		/**
		 * Returns a cube specified by name.
		 *
		 * @param name              <String> The name of the cube.
		 * @return                  <IOLAPCube> The IOLAPCube instance, or null if one is not found.
		 */
		public function getCube(name:String):IOLAPCube;
	}
}
