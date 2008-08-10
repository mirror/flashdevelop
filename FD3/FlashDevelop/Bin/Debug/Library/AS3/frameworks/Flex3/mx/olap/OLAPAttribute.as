/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public class OLAPAttribute extends OLAPHierarchy implements IOLAPAttribute {
		/**
		 * User supplied callback function that would be used to compare
		 *  the data elements while sorting the data. By default the data
		 *  members would be compared directly.
		 */
		public var dataCompareFunction:Function;
		/**
		 * The field of the input data set that provides the data for
		 *  this OLAPAttribute instance.
		 */
		public function get dataField():String;
		public function set dataField(value:String):void;
		/**
		 * A callback function that returns the actual data for the attribute.
		 *  Use this callback function to return computed data based on the
		 *  actual data. For example, you can return the month name as a String
		 *  from actual date that represents the month as a number.
		 *  Or, you can calculate a value.
		 *  For example, your input data contains the ages of people,
		 *  such as 1, 4, 9, 10, 12, 15, or 20.
		 *  Your callback function can return an age group
		 *  that contains the age, as in 1-10, or 11-20.
		 */
		public function get dataFunction():Function;
		public function set dataFunction(value:Function):void;
		/**
		 * A callback function that returns the display name of a member element.
		 *  Flex calls this function for each member added
		 *  to the OLAPAttribute instance.
		 */
		public var displayNameFunction:Function;
		/**
		 * Contains true becasue attributes are assumed to be aggregatable
		 *  and all member is present.
		 */
		public function get hasAll():Boolean;
		public function set hasAll(value:Boolean):void;
		/**
		 * All members of all the levels that belong to this hierarchy,
		 *  as a list of IOLAPMember instances.
		 *  The returned list might represent remote data and therefore can throw
		 *  an ItemPendingError.
		 */
		public function get members():IList;
		/**
		 * Constructor.
		 *
		 * @param name              <String (default = null)> The name of the OLAPAttribute instance.
		 *                            You use this parameter to associate the OLAPAttribute instance with an OLAPLevel instance.
		 * @param displayName       <String (default = null)> The name of the attribute, as a String, which can be used for display.
		 */
		public function OLAPAttribute(name:String = null, displayName:String = null);
	}
}
