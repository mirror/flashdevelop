/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	public class GroupingField {
		/**
		 * Set to true if the sort for this field should be case-insensitive.
		 */
		public function get caseInsensitive():Boolean;
		public function set caseInsensitive(value:Boolean):void;
		/**
		 * The function that compares two items during a sort of items for the
		 *  associated collection. If you specify a compareFunction
		 *  property in a Grouping object, Flex ignores any compareFunction
		 *  properties of the GroupingField objects.
		 */
		public function get compareFunction():Function;
		public function set compareFunction(value:Function):void;
		/**
		 * Set to true if the sort for this field should be
		 *  in descending order.
		 */
		public function get descending():Boolean;
		public function set descending(value:Boolean):void;
		/**
		 * A function that determines the label for this group.
		 *  By default,
		 *  the group displays the text for the field in the data that matches the
		 *  filed specified by the name property.
		 *  However, sometimes you want to group the items based on
		 *  more than one field in the data, or group based on something that is
		 *  not a simple String field.
		 *  In such a case, you specify a callback function by using
		 *  the groupingFunction property.
		 */
		public var groupingFunction:Function;
		/**
		 * A callback function to run on each group node to determine the
		 *  grouping object.
		 *  By default, a new Object will be created for group nodes.
		 */
		public var groupingObjectFunction:Function;
		/**
		 * The name of the field to be sorted.
		 */
		public function get name():String;
		public function set name(value:String):void;
		/**
		 * Specifies that if the field being sorted contains numeric
		 *  (Number/int/uint) values, or String representations of numeric values,
		 *  the comparitor uses a numeric comparison.
		 *  If this property is false, fields with String representations
		 *  of numbers are sorted using String comparison, so 100 precedes 99,
		 *  because "1" is a lower string value than "9".
		 */
		public function get numeric():Boolean;
		public function set numeric(value:Boolean):void;
		/**
		 * Array of SummaryRow instances that define the group-level summaries.
		 */
		public var summaries:Array;
		/**
		 * Constructor.
		 *
		 * @param name              <String (default = null)> The name of the property that this field uses for
		 *                            comparison.
		 *                            If the object is a simple type, pass null.
		 * @param caseInsensitive   <Boolean (default = false)> When sorting strings, tells the comparitor
		 *                            whether to ignore the case of the values.
		 * @param descending        <Boolean (default = false)> Tells the comparator whether to arrange items in
		 *                            descending order.
		 * @param numeric           <Boolean (default = false)> Tells the comparitor whether to compare sort items as
		 *                            numbers, instead of alphabetically.
		 */
		public function GroupingField(name:String = null, caseInsensitive:Boolean = false, descending:Boolean = false, numeric:Boolean = false);
	}
}
