/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public class OLAPResultAxis implements IOLAPResultAxis {
		/**
		 * A list of IOLAPAxisPosition instances,
		 *  where each position represents a point along the axis.
		 */
		public function get positions():IList;
		public function set positions(value:IList):void;
		/**
		 * Adds a position to the axis of the query result.
		 *
		 * @param p                 <IOLAPAxisPosition> The IOLAPAxisPosition instance that represents the position.
		 */
		public function addPosition(p:IOLAPAxisPosition):void;
		/**
		 * Removes a position from the axis of the query result.
		 *
		 * @param p                 <IOLAPAxisPosition> The IOLAPAxisPosition instance that represents the position.
		 * @return                  <Boolean> true if the position is removed from the axis,
		 *                            and false if not.
		 */
		public function removePosition(p:IOLAPAxisPosition):Boolean;
	}
}
