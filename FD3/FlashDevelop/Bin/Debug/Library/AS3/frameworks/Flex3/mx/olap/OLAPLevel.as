/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public class OLAPLevel extends OLAPElement implements IOLAPLevel {
		/**
		 * The attribute connected to this level, as an instance of OLAPAttribute.
		 */
		public function get attribute():OLAPAttribute;
		/**
		 * The name of the attribute to be used at this level.
		 *  The value of this property corresponds to the value of the
		 *  OLAPAttribute.name property for the corresponding attribute.
		 */
		public function get attributeName():String;
		public function set attributeName(value:String):void;
		/**
		 * The next child level in the hierarchy.
		 */
		public function get child():IOLAPLevel;
		/**
		 * The field of the input data set
		 *  that provides the data for this OLAPLevel instance.
		 */
		public function get dataField():String;
		/**
		 * The depth of the level in the hierarchy of the dimension.
		 */
		public function get depth():int;
		/**
		 * The hierarchy of the dimension to which this level belongs.
		 */
		public function get hierarchy():IOLAPHierarchy;
		public function set hierarchy(value:IOLAPHierarchy):void;
		/**
		 * The members of this level, as a list of IOLAPMember instances,
		 *  or null if a member is not found.
		 *  The list might represent remote data and therefore can throw
		 *  an ItemPendingError.
		 */
		public function get members():IList;
		/**
		 * The value of the name property of the
		 *  OLAPAttribute instance associated with this OLAPLevel instance.
		 *  Even though this property is writable, its value is determned by the OLAPAttribute instance
		 *  associated with the level and cannot be set.
		 */
		public function get name():String;
		public function set name(value:String):void;
		/**
		 * The parent level of this level, or null if this level is not nested in another level.
		 */
		public function get parent():IOLAPLevel;
		/**
		 * The unique name of the OLAP element in the cube.
		 *  For example, "[Time][Year][2007]" is a unique name,
		 *  where 2007 is the element name belonging to the "Year" level of the "Time" dimension.
		 */
		public function get uniqueName():String;
		/**
		 * Constructor
		 *
		 * @param name              <String (default = null)> The name of the OLAP level that includes the OLAP schema hierarchy of the element.
		 *                            For example, "Time_Year", where "Year" is a level of the "Time" dimension in an OLAP schema.
		 * @param displayName       <String (default = null)> The name of the OLAP level, as a String, which can be used for display.
		 */
		public function OLAPLevel(name:String = null, displayName:String = null);
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
