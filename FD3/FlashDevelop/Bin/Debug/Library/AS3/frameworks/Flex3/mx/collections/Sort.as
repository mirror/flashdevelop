/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	import flash.events.EventDispatcher;
	public class Sort extends EventDispatcher {
		/**
		 * The method used to compare items when sorting.
		 *  If you specify this property, Flex ignores any compareFunction
		 *  properties that you specify in the SortField objects that you
		 *  use in this class.
		 */
		public function get compareFunction():Function;
		public function set compareFunction(value:Function):void;
		/**
		 * An Array of SortField objects that specifies the fields to compare.
		 *  The order of the SortField objects in the array determines
		 *  field priority order when sorting.
		 *  The default sort comparator checks the sort fields in array
		 *  order until it determinines a sort order for the two
		 *  fields being compared.
		 */
		public function get fields():Array;
		public function set fields(value:Array):void;
		/**
		 * Indicates if the sort should be unique.
		 *  Unique sorts fail if any value or combined value specified by the
		 *  fields listed in the fields property result in an indeterminate or
		 *  non-unique sort order; that is, if two or more items have identical
		 *  sort field values.
		 */
		public function get unique():Boolean;
		public function set unique(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function Sort();
		/**
		 * Finds the specified object within the specified array (or the insertion
		 *  point if asked for), returning the index if found or -1 if not.
		 *  The ListCollectionView class findxxx() methods use
		 *  this method to find the requested item; as a general rule, it is
		 *  easier to use these functions, and not findItem() to find
		 *  data in ListCollectionView-based objects.
		 *  You call the findItem() method directly when writing a class
		 *  that supports sorting, such as a new ICollectionView implementation.
		 *
		 * @param items             <Array> the Array within which to search.
		 * @param values            <Object> Object containing the properties to look for (or
		 *                            the object to search for, itself).
		 *                            The object must consist of field name/value pairs, where
		 *                            the field names are names of fields specified by the
		 *                            SortFields property, in the same order they
		 *                            are used in that property.
		 *                            You do not have to specify all of the fields from the
		 *                            SortFields property, but you
		 *                            cannot skip any in the order.
		 *                            Therefore, if the SortFields
		 *                            properity lists three fields, you can specify its first
		 *                            and second fields in this parameter, but you cannot specify
		 *                            only the first and third fields.
		 * @param mode              <String> String containing the type of find to perform.
		 *                            Valid values are
		 *                            ANY_INDEX_MODE Return any position that
		 *                            is valid for the values.
		 *                            FIRST_INDEX_MODE Return the position
		 *                            where the first occurrance of the values is found.
		 *                            LAST_INDEX_MODE Return the position
		 *                            where the
		 *                            last ocurrance of the specified values is found.
		 * @param returnInsertionIndex<Boolean (default = false)> If the method does not find an item identified
		 *                            by the values parameter, and this parameter
		 *                            is true the findItem()
		 *                            method returns the insertion point for the values,
		 *                            that is the point in the sorted order where you should
		 *                            insert the item.
		 * @param compareFunction   <Function (default = null)> a comparator function to use to find the item.  If
		 *                            you do not specify this parameter, the function uses
		 *                            the function determined by the Sort instance's
		 *                            compareFunction property,
		 *                            passing in the array of fields determined
		 *                            by the values object and the current SortFields.
		 * @return                  <int> int The index in the array of the found item.
		 *                            If the returnInsertionIndex parameter is
		 *                            false and the item is not found, returns -1.
		 *                            If the returnInsertionIndex parameter is
		 *                            true and the item is not found, returns
		 *                            the index of the point in the sorted array where the values
		 *                            would be inserted.
		 */
		public function findItem(items:Array, values:Object, mode:String, returnInsertionIndex:Boolean = false, compareFunction:Function = null):int;
		/**
		 * Return whether the specified property is used to control the sort.
		 *  The function cannot determine a definitive answer if the sort uses a
		 *  custom comparitor; it always returns true in this case.
		 *
		 * @param property          <String> The name of the field that to test.
		 * @return                  <Boolean> Whether the property value might affect the sort outcome.
		 *                            If the sort uses the default compareFunction, returns
		 *                            true if the
		 *                            property parameter specifies a sort field.
		 *                            If the sort or any SortField uses a custom comparator,
		 *                            there's no way to know, so return true.
		 */
		public function propertyAffectsSort(property:String):Boolean;
		/**
		 * Goes through all SortFields and calls reverse() on them.
		 *  If the field was descending now it is ascending, and vice versa.
		 */
		public function reverse():void;
		/**
		 * Apply the current sort to the specified array (not a copy).
		 *  To prevent the array from being modified, create a copy
		 *  use the copy in the items parameter.
		 *
		 * @param items             <Array> Array of items to sort.
		 */
		public function sort(items:Array):void;
		/**
		 * When executing a find return the index any matching item.
		 */
		public static const ANY_INDEX_MODE:String = "any";
		/**
		 * When executing a find return the index for the first matching item.
		 */
		public static const FIRST_INDEX_MODE:String = "first";
		/**
		 * When executing a find return the index for the last matching item.
		 */
		public static const LAST_INDEX_MODE:String = "last";
	}
}
