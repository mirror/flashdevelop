/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public class OLAPMember extends OLAPElement implements IOLAPMember {
		/**
		 * The children of this member, as a list of IOLAPMember instances.
		 */
		public function get children():IList;
		/**
		 * The field of the input data set that provides
		 *  the data for this OLAPMember instance.
		 */
		public function get dataField():String;
		public function set dataField(value:String):void;
		/**
		 * The dimension to which this member belongs.
		 */
		public function get dimension():IOLAPDimension;
		public function set dimension(value:IOLAPDimension):void;
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
		public function set level(value:IOLAPLevel):void;
		/**
		 * The parent of this member.
		 */
		public function get parent():IOLAPMember;
		public function set parent(value:IOLAPMember):void;
		/**
		 * The unique name of the OLAP element in the cube.
		 *  For example, "[Time][Year][2007]" is a unique name,
		 *  where 2007 is the element name belonging to the "Year" level of the "Time" dimension.
		 */
		public function get uniqueName():String;
		/**
		 * Constructor
		 *
		 * @param name              <String (default = null)> The name of the OLAP element that includes the OLAP schema hierarchy of the element.
		 *                            For example, "Time_Year", where "Year" is a level of the "Time" dimension in an OLAP schema.
		 * @param displayName       <String (default = null)> The name of the OLAP member, as a String, which can be used for display.
		 */
		public function OLAPMember(name:String = null, displayName:String = null);
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
