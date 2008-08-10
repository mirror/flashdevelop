/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public interface IOLAPDimension extends <a href="../../mx/olap/IOLAPElement.html">IOLAPElement</a>  {
		/**
		 * The attributes of this dimension, as a list of OLAPAttribute instances.
		 */
		public function get attributes():IList;
		/**
		 * The cube to which this dimension belongs.
		 */
		public function get cube():IOLAPCube;
		/**
		 * The default member of this dimension.
		 */
		public function get defaultMember():IOLAPMember;
		/**
		 * All the hierarchies for this dimension, as a list of IOLAPHierarchy instances.
		 */
		public function get hierarchies():IList;
		/**
		 * Contains true if this is the measures dimension,
		 *  which holds all the measure members.
		 */
		public function get isMeasure():Boolean;
		/**
		 * Returns all the members of this dimension, as a list of IOLAPMember instances.
		 *  The returned list might represent remote data and therefore can throw
		 *  an ItemPendingError.
		 */
		public function get members():IList;
		/**
		 * Returns the attribute with the given name within the dimension.
		 *
		 * @param name              <String> The name of the attribute.
		 * @return                  <IOLAPAttribute> An IOLAPAttribute instance representing the attribute,
		 *                            or null if an attribute is not found.
		 */
		public function findAttribute(name:String):IOLAPAttribute;
		/**
		 * Returns the hierarchy with the given name within the dimension.
		 *
		 * @param name              <String> The name of the hierarchy.
		 * @return                  <IOLAPHierarchy> An IOLAPHierarchy instance representing the hierarchy,
		 *                            or null if a hierarchy is not found.
		 */
		public function findHierarchy(name:String):IOLAPHierarchy;
		/**
		 * Returns the member with the given name within the dimension.
		 *
		 * @param name              <String> The name of the member.
		 * @return                  <IOLAPMember> An IOLAPMember instance representing the member,
		 *                            or null if a member is not found.
		 */
		public function findMember(name:String):IOLAPMember;
	}
}
