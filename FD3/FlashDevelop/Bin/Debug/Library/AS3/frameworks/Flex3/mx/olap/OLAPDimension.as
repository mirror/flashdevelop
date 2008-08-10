/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public class OLAPDimension extends OLAPElement implements IOLAPDimension {
		/**
		 * The attributes of this dimension, as a list of OLAPAttribute instances.
		 */
		public function get attributes():IList;
		public function set attributes(value:IList):void;
		/**
		 * The cube to which this dimension belongs.
		 */
		public function get cube():IOLAPCube;
		public function set cube(value:IOLAPCube):void;
		/**
		 * The default member of this dimension.
		 */
		public function get defaultMember():IOLAPMember;
		/**
		 * Processes the input Array and initializes the attributes
		 *  and hierarchies properties based on the elements of the Array.
		 *  Attributes are represented in the Array by instances of the OLAPAttribute class,
		 *  and hierarchies are represented by instances of the OLAPHierarchy class.
		 */
		public function set elements(value:Array):void;
		/**
		 * All the hierarchies for this dimension, as a list of IOLAPHierarchy instances.
		 */
		public function get hierarchies():IList;
		public function set hierarchies(value:IList):void;
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
		 * Constructor
		 *
		 * @param name              <String (default = null)> The name of the OLAP dimension that includes the OLAP schema hierarchy of the element.
		 * @param displayName       <String (default = null)> The name of the OLAP dimension, as a String, which can be used for display.
		 */
		public function OLAPDimension(name:String = null, displayName:String = null);
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
