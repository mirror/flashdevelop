/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public interface IOLAPMember extends IOLAPElement {
		/**
		 * The children of this member, as a list of IOLAPMember instances.
		 */
		public function get children():IList;
		/**
		 * The hierarchy to which this member belongs.
		 */
		public function get hierarchy():IOLAPHierarchy;
		/**
		 * Returns true if this is the all member of a hierarchy.
		 */
		public function get isAll():Boolean;
		/**
		 * Returns true if this member represents a measure of a dimension.
		 */
		public function get isMeasure():Boolean;
		/**
		 * The level to which this member belongs.
		 */
		public function get level():IOLAPLevel;
		/**
		 * The parent of this member.
		 */
		public function get parent():IOLAPMember;
		/**
		 * Returns a child of this member with the given name.
		 *
		 * @param name              <String> The name of the member.
		 * @return                  <IOLAPMember> A list of IOLAPMember instances representing the member,
		 *                            or null if a member is not found.
		 */
		public function findChildMember(name:String):IOLAPMember;
	}
}
