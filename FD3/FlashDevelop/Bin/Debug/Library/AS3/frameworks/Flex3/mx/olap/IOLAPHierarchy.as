/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public interface IOLAPHierarchy extends <a href="../../mx/olap/IOLAPElement.html">IOLAPElement</a>  {
		/**
		 * The name of the all member of the hierarchy.
		 */
		public function get allMemberName():String;
		/**
		 * The children of the all member, as a list of IOLAPMember instances.
		 */
		public function get children():IList;
		/**
		 * The default member of the hierarchy.
		 *  The default member is used if the hierarchy
		 *  is used where a member is expected.
		 */
		public function get defaultMember():IOLAPMember;
		/**
		 * Specifies whether the hierarchy has an all member, true,
		 *  or not, false. If true, the all member name
		 *  is as specified by the allMemberName property.
		 */
		public function get hasAll():Boolean;
		/**
		 * All the levels of this hierarchy, as a list of IOLAPLevel instances.
		 *  The returned list might represent remote data and therefore can throw
		 *  an ItemPendingError.
		 */
		public function get levels():IList;
		/**
		 * All members of all the levels that belong to this hierarchy,
		 *  as a list of IOLAPMember instances.
		 *  The returned list might represent remote data and therefore can throw
		 *  an ItemPendingError.
		 */
		public function get members():IList;
		/**
		 * Returns the level with the given name within the hierarchy.
		 *
		 * @param name              <String> The name of the level.
		 * @return                  <IOLAPLevel> An IOLAPLevel instance representing the level,
		 *                            or null if a level is not found.
		 */
		public function findLevel(name:String):IOLAPLevel;
		/**
		 * Returns the member with the given name within the hierarchy.
		 *
		 * @param name              <String> The name of the member.
		 * @return                  <IOLAPMember> An IOLAPMember instance representing the member,
		 *                            or null if a member is not found.
		 */
		public function findMember(name:String):IOLAPMember;
	}
}
