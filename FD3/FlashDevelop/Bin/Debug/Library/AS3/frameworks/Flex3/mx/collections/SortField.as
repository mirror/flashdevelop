/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	import flash.events.EventDispatcher;
	public class SortField extends EventDispatcher {
		/**
		 * Specifies whether the sort for this field should be case insensitive.
		 */
		public function get caseInsensitive():Boolean;
		public function set caseInsensitive(value:Boolean):void;
		/**
		 * The function that compares two items during a sort of items for the
		 *  associated collection. If you specify a compareFunction
		 *  property in a Sort object, Flex ignores any compareFunction
		 *  properties of the Sort's SortField objects.
		 */
		public function get compareFunction():Function;
		public function set compareFunction(value:Function):void;
		/**
		 * Specifies whether the this field should be sorted in descending
		 *  order.
		 */
		public function get descending():Boolean;
		public function set descending(value:Boolean):void;
		/**
		 * The name of the field to be sorted.
		 */
		public function get name():String;
		public function set name(value:String):void;
		/**
		 * Specifies that if the field being sorted contains numeric
		 *  (number/int/uint) values, or string representations of numeric values,
		 *  the comparitor use a numeric comparison.
		 *  If this property is false, fields with string representations
		 *  of numbers are sorted using strings comparison, so 100 precedes 99,
		 *  because "1" is a lower string value than "9".
		 *  If this property is null, the first data item
		 *  is introspected to see if it is a number or string and the sort
		 *  proceeds based on that introspection
		 */
		public function get numeric():Object;
		public function set numeric(value:Object):void;
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
		 * @param numeric           <Object (default = null)> Tells the comparitor whether to compare sort items as
		 *                            numbers, instead of alphabetically.
		 */
		public function SortField(name:String = null, caseInsensitive:Boolean = false, descending:Boolean = false, numeric:Object = null);
		/**
		 * Reverse the criteria for this sort field.
		 *  If the field was sorted in descending order, for example, sort it
		 *  in ascending order.
		 */
		public function reverse():void;
	}
}
