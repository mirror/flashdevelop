/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	public class Grouping {
		/**
		 * The method used to compare items when sorting.
		 *  If you specify this property, Flex ignores any compareFunction
		 *  properties that you specify in the SortField objects that you
		 *  use in this class.
		 */
		public function get compareFunction():Function;
		public function set compareFunction(value:Function):void;
		/**
		 * An Array of GroupingField objects that specifies the fields
		 *  used to group the data.
		 *  The order of the GroupingField objects in the Array determines
		 *  field priority order when sorting.
		 */
		public function get fields():Array;
		public function set fields(value:Array):void;
		/**
		 * A callback function to run on each group node to determine the
		 *  grouping object.
		 *  By default, a new Object will be created for group nodes.
		 */
		public var groupingObjectFunction:Function;
		/**
		 * The name of the field added to the flat data
		 *  to create the hierarchy.
		 *  The value of the top nodes (nodes representing the group fields)
		 *  in every group will be represented
		 *  by this property.
		 *  Use this property to specify a different name.
		 */
		public var label:String = "GroupLabel";
		/**
		 * Constructor.
		 */
		public function Grouping();
	}
}
