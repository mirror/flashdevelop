/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public interface IOLAPLevel extends <a href="../../mx/olap/IOLAPElement.html">IOLAPElement</a>  {
		/**
		 * The next child level in the hierarchy.
		 */
		public function get child():IOLAPLevel;
		/**
		 * The depth of the level in the hierarchy of the dimension.
		 */
		public function get depth():int;
		/**
		 * The hierarchy of the dimension to which this level belongs.
		 */
		public function get hierarchy():IOLAPHierarchy;
		/**
		 * The members of this level, as a list of IOLAPMember instances,
		 *  or null if a member is not found.
		 *  The list might represent remote data and therefore can throw
		 *  an ItemPendingError.
		 */
		public function get members():IList;
		/**
		 * The parent level of this level, or null if this level is not nested in another level.
		 */
		public function get parent():IOLAPLevel;
		/**
		 * Returns the members with the given name within the hierarchy.
		 *
		 * @param name              <String> The name of the member.
		 * @return                  <IList> A list of IOLAPMember instances representing the members,
		 *                            or null if a member is not found.
		 */
		public function findMember(name:String):IList;
	}
}
