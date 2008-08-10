/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public dynamic  class Array {
		/**
		 * A non-negative integer specifying the number of elements in the array. This property is automatically updated when new elements are added to the array. When you assign a value to an array element (for example, my_array[index] = value), if index is a number, and index+1 is greater than the length property, the length property is updated to index+1.
		 */
		public function get length():uint;
		public function set length(value:uint):void;
		/**
		 * Lets you create an array of the specified number of elements.
		 *  If you don't specify any parameters, an array containing 0 elements is created.
		 *  If you specify a number of elements, an array is created with numElements number of elements.
		 *
		 * @param numElements       <int (default = 0)> An integer that specifies the number of elements in the array.
		 */
		public function Array(numElements:int = 0);
		/**
		 * Lets you create an array that contains the specified elements.
		 *  You can specify values of any type.
		 *  The first element in an array always has an index (or position) of 0.
		 */
		public function Array(... values);
		/**
		 * Concatenates the elements specified in the parameters with the elements in an array and creates a new array. If the parameters specify an array, the elements of that array are concatenated.
		 *
		 * @return                  <Array> An array that contains the elements from this array followed by elements from
		 *                            the parameters.
		 */
		AS3 function concat(... args):Array;
		/**
		 * Executes a test function on each item in the array until an item is reached that returns false for the
		 *  specified function. You use this method to determine whether all items in an array meet a criterion, such as having values
		 *  less than a particular number.
		 *
		 * @param callback          <Function> The function to run on each item in the array. This function can contain a simple comparison (for example, item < 20) or a more complex operation, and is invoked with three arguments; the
		 *                            value of an item, the index of an item, and the Array object:
		 *                            function callback(item:*, index:int, array:Array):Boolean;
		 * @param thisObject        <* (default = null)> An object to use as this for the function.
		 * @return                  <Boolean> A Boolean value of true if all items in the array return true for the specified function; otherwise, false.
		 */
		AS3 function every(callback:Function, thisObject:* = null):Boolean;
		/**
		 * Executes a test function on each item in the array and constructs a new array for all items that return true for the specified function. If an item returns false, it is not included in the new array.
		 *
		 * @param callback          <Function> The function to run on each item in the array. This function can contain a simple comparison (for example, item < 20) or a more complex operation, and is invoked with three arguments; the
		 *                            value of an item, the index of an item, and the Array object:
		 *                            function callback(item:*, index:int, array:Array):Boolean;
		 * @param thisObject        <* (default = null)> An object to use as this for the function.
		 * @return                  <Array> A new array that contains all items from the original array that returned true.
		 */
		AS3 function filter(callback:Function, thisObject:* = null):Array;
		/**
		 * Executes a function on each item in the array.
		 *
		 * @param callback          <Function> The function to run on each item in the array. This function can contain a simple command
		 *                            (for example, a trace() statement) or a more complex operation, and is invoked with three arguments; the
		 *                            value of an item, the index of an item, and the Array object:
		 *                            function callback(item:*, index:int, array:Array):void;
		 * @param thisObject        <* (default = null)> An object to use as this for the function.
		 */
		AS3 function forEach(callback:Function, thisObject:* = null):void;
		/**
		 * Searches for an item in an array by using strict equality (===) and returns the index
		 *  position of the item.
		 *
		 * @param searchElement     <*> The item to find in the array.
		 * @param fromIndex         <int (default = 0)> The location in the array from which to start searching for the item.
		 * @return                  <int> A zero-based index position of the item in the array. If the searchElement argument
		 *                            is not found, the return value is -1.
		 */
		AS3 function indexOf(searchElement:*, fromIndex:int = 0):int;
		/**
		 * Converts the elements in an array to strings, inserts the specified separator between the
		 *  elements, concatenates them, and returns the resulting string. A nested array is always
		 *  separated by a comma (,), not by the separator passed to the join() method.
		 *
		 * @param sep               <* (default = NaN)> A character or string that separates array elements in
		 *                            the returned string. If you omit this parameter, a comma is used as the default
		 *                            separator.
		 * @return                  <String> A string consisting of the elements of an array
		 *                            converted to strings and separated by the specified parameter.
		 */
		AS3 function join(sep:*):String;
		/**
		 * Searches for an item in an array, working backward from the last item, and returns the index position of the matching item using strict equality (===).
		 *
		 * @param searchElement     <*> The item to find in the array.
		 * @param fromIndex         <int (default = 0x7fffffff)> The location in the array from which to start searching for the item. The default is the maximum
		 *                            value allowed for an index. If you do not specify fromIndex, the search starts at the last item
		 *                            in the array.
		 * @return                  <int> A zero-based index position of the item in the array. If the searchElement argument is
		 *                            not found, the return value is -1.
		 */
		AS3 function lastIndexOf(searchElement:*, fromIndex:int = 0x7fffffff):int;
		/**
		 * Executes a function on each item in an array, and constructs a new array of items corresponding to the results of the function on
		 *  each item in the original array.
		 *
		 * @param callback          <Function> The function to run on each item in the array. This function can contain a simple command (such as changing the case of an array of strings) or a more complex operation, and is invoked with three arguments; the
		 *                            value of an item, the index of an item, and the Array object:
		 *                            function callback(item:*, index:int, array:Array):void;
		 * @param thisObject        <* (default = null)> An object to use as this for the function.
		 * @return                  <Array> A new array that contains the results of the function on each item in the original array.
		 */
		AS3 function map(callback:Function, thisObject:* = null):Array;
		/**
		 * Removes the last element from an array and returns the value of that element.
		 *
		 * @return                  <*> The value of the last element (of any data type) in the specified array.
		 */
		AS3 function pop():*;
		/**
		 * Adds one or more elements to the end of an array and returns the new length of the array.
		 *
		 * @return                  <uint> An integer representing the length of the new array.
		 */
		AS3 function push(... args):uint;
		/**
		 * Reverses the array in place.
		 *
		 * @return                  <Array> The new array.
		 */
		AS3 function reverse():Array;
		/**
		 * Removes the first element from an array and returns that element. The remaining array elements are moved
		 *  from their original position, i, to i-1.
		 *
		 * @return                  <*> The first element (of any data type) in an array.
		 */
		AS3 function shift():*;
		/**
		 * Returns a new array that consists of a range of elements from the original array, without modifying the original array. The returned array includes the startIndex element and all elements up to, but not including, the endIndex element.
		 *
		 * @param startIndex        <int (default = 0)> A number specifying the index of the starting point
		 *                            for the slice. If startIndex is a negative number, the starting
		 *                            point begins at the end of the array, where -1 is the last element.
		 * @param endIndex          <int (default = 16777215)> A number specifying the index of the ending point for
		 *                            the slice. If you omit this parameter, the slice includes all elements from the
		 *                            starting point to the end of the array. If endIndex is a negative
		 *                            number, the ending point is specified from the end of the array, where -1 is the
		 *                            last element.
		 * @return                  <Array> An array that consists of a range of elements from the original array.
		 */
		AS3 function slice(startIndex:int = 0, endIndex:int = 16777215):Array;
		/**
		 * Executes a test function on each item in the array until an item is reached that returns true. Use this method to determine whether any items in an array meet a criterion, such as having a value less than a particular number.
		 *
		 * @param callback          <Function> The function to run on each item in the array. This function can contain a simple comparison (for example
		 *                            item < 20) or a more complex operation, and is invoked with three arguments; the
		 *                            value of an item, the index of an item, and the Array object:
		 *                            function callback(item:*, index:int, array:Array):Boolean;
		 * @param thisObject        <* (default = null)> An object to use as this for the function.
		 * @return                  <Boolean> A Boolean value of true if any items in the array return true for the specified function; otherwise false.
		 */
		AS3 function some(callback:Function, thisObject:* = null):Boolean;
		/**
		 * Sorts the elements in an array. This method sorts according to Unicode values. (ASCII is a subset of Unicode.)
		 *
		 * @return                  <Array> The return value depends on whether you pass any arguments, as described in
		 *                            the following list:
		 *                            If you specify a value of 4 or Array.UNIQUESORT for the sortOptions argument
		 *                            of the ...args parameter and two or more elements being sorted have identical sort fields,
		 *                            Flash returns a value of 0 and does not modify the array.
		 *                            If you specify a value of 8 or Array.RETURNINDEXEDARRAY for
		 *                            the sortOptions argument of the ...args parameter, Flash returns a sorted numeric
		 *                            array of the indices that reflects the results of the sort and does not modify the array.
		 *                            Otherwise, Flash returns nothing and modifies the array to reflect the sort order.
		 */
		AS3 function sort(... args):Array;
		/**
		 * Sorts the elements in an array according to one or more fields in the array.
		 *  The array should have the following characteristics:
		 *  The array is an indexed array, not an associative array.
		 *  Each element of the array holds an object with one or more properties.
		 *  All of the objects have at least one property in common, the values of which can be used
		 *  to sort the array. Such a property is called a field.
		 *
		 * @param fieldName         <Object> A string that identifies a field to be used as the sort value, or an
		 *                            array in which the first element represents the primary sort field, the  second represents
		 *                            the secondary sort field, and so on.
		 * @param options           <Object (default = null)> One or more numbers or names of defined constants, separated by the bitwise OR (|) operator, that change the sorting behavior. The following values are acceptable for the options parameter:
		 *                            Array.CASEINSENSITIVE
		 *                            or 1
		 *                            Array.DESCENDING
		 *                            or 2
		 *                            Array.UNIQUESORT
		 *                            or 4
		 *                            Array.RETURNINDEXEDARRAY
		 *                            or 8
		 *                            Array.NUMERIC
		 *                            or 16
		 * @return                  <Array> The return value depends on whether you pass any parameters:
		 *                            If you specify a value of 4 or Array.UNIQUESORT for the options parameter, and two or more elements being sorted have identical sort fields, a value of 0 is returned and the array is not modified.
		 *                            If you specify a value of 8 or Array.RETURNINDEXEDARRAY for the options parameter, an array is returned that reflects the results of the sort and the array is not modified.
		 *                            Otherwise, nothing is returned and the array is modified to reflect the sort order.
		 */
		AS3 function sortOn(fieldName:Object, options:Object = null):Array;
		/**
		 * Adds elements to and removes elements from an array. This method modifies the array without
		 *  making a copy.
		 *
		 * @param startIndex        <int> An integer that specifies the index of the element in the array where the insertion or
		 *                            deletion begins. You can use a negative integer to specify a position relative to the end of the array
		 *                            (for example, -1 is the last element of the array).
		 * @param deleteCount       <uint> An integer that specifies the number of elements to be deleted. This number includes the
		 *                            element specified in the startIndex parameter. If you do not specify a value for the
		 *                            deleteCount parameter, the method deletes all of the values from the startIndex
		 *                            element to the last element in the array. If the value is 0, no elements are deleted.
		 * @return                  <Array> An array containing the elements that were removed from the original array.
		 */
		AS3 function splice(startIndex:int, deleteCount:uint, ... values):Array;
		/**
		 * Returns a string that represents the elements in the specified array. Every element in the array, starting with index 0 and ending with the highest index, is converted to a concatenated string and separated by commas. In the ActionScript 3.0 implementation, this method returns the same value as the Array.toString() method.
		 *
		 * @return                  <String> A string of array elements.
		 */
		public function toLocaleString():String;
		/**
		 * Returns a string that represents the elements in the specified array. Every element in the array, starting with index 0 and ending with the highest index, is converted to a concatenated string and separated by commas. To specify a custom separator, use the Array.join() method.
		 *
		 * @return                  <String> A string of array elements.
		 */
		public function toString():String;
		/**
		 * Adds one or more elements to the beginning of an array and returns the new length of the array. The other
		 *  elements in the array are moved from their original position, i, to i+1.
		 *
		 * @return                  <uint> An integer representing the new length of the array.
		 */
		AS3 function unshift(... args):uint;
		/**
		 * Specifies case-insensitive sorting for the Array class sorting methods. You can use this constant
		 *  for the options parameter in the sort() or sortOn() method.
		 */
		public static const CASEINSENSITIVE:uint = 1;
		/**
		 * Specifies descending sorting for the Array class sorting methods.
		 *  You can use this constant for the options parameter in the sort()
		 *  or sortOn() method.
		 */
		public static const DESCENDING:uint = 2;
		/**
		 * Specifies numeric (instead of character-string) sorting for the Array class sorting methods.
		 *  Including this constant in the options
		 *  parameter causes the sort() and sortOn() methods
		 *  to sort numbers as numeric values, not as strings of numeric characters.
		 *  Without the NUMERIC constant, sorting treats each array element as a
		 *  character string and produces the results in Unicode order.
		 */
		public static const NUMERIC:uint = 16;
		/**
		 * Specifies that a sort returns an array that consists of array indices. You can use this constant
		 *  for the options parameter in the sort() or sortOn()
		 *  method, so you have access to multiple views of the array elements while the original array is unmodified.
		 */
		public static const RETURNINDEXEDARRAY:uint = 8;
		/**
		 * Specifies the unique sorting requirement for the Array class sorting methods.
		 *  You can use this constant for the options parameter in the sort() or sortOn()
		 *  method. The unique sorting option terminates the sort if any two elements
		 *  or fields being sorted have identical values.
		 */
		public static const UNIQUESORT:uint = 4;
	}
}
