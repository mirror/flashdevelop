/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	public class ObjectUtil {
		/**
		 * Compares the Objects and returns an integer value
		 *  indicating if the first item is less than greater than or equal to
		 *  the second item.
		 *  This method will recursively compare properties on nested objects and
		 *  will return as soon as a non-zero result is found.
		 *  By default this method will recurse to the deepest level of any property.
		 *  To change the depth for comparison specify a non-negative value for
		 *  the depth parameter.
		 *
		 * @param a                 <Object> Object.
		 * @param b                 <Object> Object.
		 * @param depth             <int (default = -1)> Indicates how many levels should be
		 *                            recursed when performing the comparison.
		 *                            Set this value to 0 for a shallow comparison of only the primitive
		 *                            representation of each property.
		 *                            For example:
		 *                            var a:Object = {name:"Bob", info:[1,2,3]};
		 *                            var b:Object = {name:"Alice", info:[5,6,7]};
		 *                            var c:int = ObjectUtil.compare(a, b, 0);
		 *                            In the above example the complex properties of a and
		 *                            b will be flattened by a call to toString()
		 *                            when doing the comparison.
		 *                            In this case the info property will be turned into a string
		 *                            when performing the comparison.
		 * @return                  <int> Return 0 if a and b are null, NaN, or equal.
		 *                            Return 1 if a is null or greater than b.
		 *                            Return -1 if b is null or greater than a.
		 */
		public static function compare(a:Object, b:Object, depth:int = -1):int;
		/**
		 * Copies the specified Object and returns a reference to the copy.
		 *  The copy is made using a native serialization technique.
		 *  This means that custom serialization will be respected during the copy.
		 *
		 * @param value             <Object> Object that should be copied.
		 * @return                  <Object> Copy of the specified Object.
		 */
		public static function copy(value:Object):Object;
		/**
		 * Compares the two Date objects and returns an integer value
		 *  indicating if the first Date object is before, equal to,
		 *  or after the second item.
		 *
		 * @param a                 <Date> Date object.
		 * @param b                 <Date> Date object.
		 * @return                  <int> 0 if a and b
		 *                            are null or equal;
		 *                            1 if a is null
		 *                            or before b;
		 *                            -1 if b is null
		 *                            or before a.
		 */
		public static function dateCompare(a:Date, b:Date):int;
		/**
		 * Returns information about the class, and properties of the class, for
		 *  the specified Object.
		 *
		 * @param obj               <Object> The Object to inspect.
		 * @param excludes          <Array (default = null)> Array of Strings specifying the property names that should be
		 *                            excluded from the returned result. For example, you could specify
		 *                            ["currentTarget", "target"] for an Event object since these properties
		 *                            can cause the returned result to become large.
		 * @param options           <Object (default = null)> An Object containing one or more properties
		 *                            that control the information returned by this method.
		 *                            The properties include the following:
		 *                            includeReadOnly: If false,
		 *                            exclude Object properties that are read-only.
		 *                            The default value is true.
		 *                            includeTransient: If false,
		 *                            exclude Object properties and variables that have [Transient] metadata.
		 *                            The default value is true.
		 *                            uris: Array of Strings of all namespaces that should be included in the output.
		 *                            It does allow for a wildcard of "*".
		 *                            By default, it is null, meaning no namespaces should be included.
		 *                            For example, you could specify ["mx_internal", "mx_object"]
		 *                            or ["*"].
		 * @return                  <Object> An Object containing the following properties:
		 *                            name: String containing the name of the class;
		 *                            properties: Sorted list of the property names of the specified object.
		 */
		public static function getClassInfo(obj:Object, excludes:Array = null, options:Object = null):Object;
		/**
		 * Uses getClassInfo and examines the metadata information to
		 *  determine whether a property on a given object has the specified
		 *  metadata.
		 *
		 * @param obj               <Object> The object holding the property.
		 * @param propName          <String> The property to check for metadata.
		 * @param metadataName      <String> The name of the metadata to check on the property.
		 * @param excludes          <Array (default = null)> If any properties need to be excluded when generating class info. (Optional)
		 * @param options           <Object (default = null)> If any options flags need to changed when generating class info. (Optional)
		 * @return                  <Boolean> true if the property has the specified metadata.
		 */
		public static function hasMetadata(obj:Object, propName:String, metadataName:String, excludes:Array = null, options:Object = null):Boolean;
		/**
		 * Returns true if the object reference specified
		 *  is a simple data type. The simple data types include the following:
		 *  String
		 *  Number
		 *  uint
		 *  int
		 *  Boolean
		 *  Date
		 *  Array
		 *
		 * @param value             <Object> Object inspected.
		 * @return                  <Boolean> true if the object specified
		 *                            is one of the types above; false otherwise.
		 */
		public static function isSimple(value:Object):Boolean;
		/**
		 * Compares two numeric values.
		 *
		 * @param a                 <Number> First number.
		 * @param b                 <Number> Second number.
		 * @return                  <int> 0 is both numbers are NaN.
		 *                            1 if only a is a NaN.
		 *                            -1 if only b is a NaN.
		 *                            -1 if a is less than b.
		 *                            1 if a is greater than b.
		 */
		public static function numericCompare(a:Number, b:Number):int;
		/**
		 * Compares two String values.
		 *
		 * @param a                 <String> First String value.
		 * @param b                 <String> Second String value.
		 * @param caseInsensitive   <Boolean (default = false)> Specifies to perform a case insensitive compare,
		 *                            true, or not, false.
		 * @return                  <int> 0 is both Strings are null.
		 *                            1 if only a is null.
		 *                            -1 if only b is null.
		 *                            -1 if a precedes b.
		 *                            1 if b precedes a.
		 */
		public static function stringCompare(a:String, b:String, caseInsensitive:Boolean = false):int;
		/**
		 * Pretty-prints the specified Object into a String.
		 *  All properties will be in alpha ordering.
		 *
		 * @param value             <Object> Object to be pretty printed.
		 * @param namespaceURIs     <Array (default = null)> Array of namespace URIs for properties
		 *                            that should be included in the output.
		 *                            By default only properties in the public namespace will be included in
		 *                            the output.
		 *                            To get all properties regardless of namespace pass an array with a
		 *                            single element of ".
		 * @param exclude           <Array (default = null)> Array of the property names that should be
		 *                            excluded from the output.
		 *                            Use this to remove data from the formatted string.
		 * @return                  <String> String containing the formatted version
		 *                            of the specified object.
		 */
		public static function toString(value:Object, namespaceURIs:Array = null, exclude:Array = null):String;
	}
}
