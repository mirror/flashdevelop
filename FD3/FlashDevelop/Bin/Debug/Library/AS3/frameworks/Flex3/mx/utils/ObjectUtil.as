package mx.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.xml.XMLNode;
	import mx.collections.IList;

	/**
	 *  The ObjectUtil class is an all-static class with methods for *  working with Objects within Flex. *  You do not create instances of ObjectUtil; *  instead you simply call static methods such as the  *  <code>ObjectUtil.isSimple()</code> method.
	 */
	public class ObjectUtil
	{
		/**
		 *  Array of properties to exclude from debugging output.
		 */
		private static var defaultToStringExcludes : Array;
		/**
		 * @private
		 */
		private static var refCount : int;
		/**
		 * @private
		 */
		private static var CLASS_INFO_CACHE : Object;

		/**
		 *  Compares the Objects and returns an integer value      *  indicating if the first item is less than greater than or equal to     *  the second item.     *  This method will recursively compare properties on nested objects and     *  will return as soon as a non-zero result is found.     *  By default this method will recurse to the deepest level of any property.     *  To change the depth for comparison specify a non-negative value for     *  the <code>depth</code> parameter.     *     *  @param a Object.     *     *  @param b Object.     *     *  @param depth Indicates how many levels should be      *  recursed when performing the comparison.     *  Set this value to 0 for a shallow comparison of only the primitive      *  representation of each property.     *  For example:<pre>     *  var a:Object = {name:"Bob", info:[1,2,3]};     *  var b:Object = {name:"Alice", info:[5,6,7]};     *  var c:int = ObjectUtil.compare(a, b, 0);</pre>     *     *  <p>In the above example the complex properties of <code>a</code> and      *  <code>b</code> will be flattened by a call to <code>toString()</code>     *  when doing the comparison.     *  In this case the <code>info</code> property will be turned into a string     *  when performing the comparison.</p>     *     *  @return Return 0 if a and b are null, NaN, or equal.      *  Return 1 if a is null or greater than b.      *  Return -1 if b is null or greater than a.
		 */
		public static function compare (a:Object, b:Object, depth:int = -1) : int;
		/**
		 *  Copies the specified Object and returns a reference to the copy.     *  The copy is made using a native serialization technique.      *  This means that custom serialization will be respected during the copy.     *     *  <p>This method is designed for copying data objects,      *  such as elements of a collection. It is not intended for copying      *  a UIComponent object, such as a TextInput control. If you want to create copies      *  of specific UIComponent objects, you can create a subclass of the component and implement      *  a <code>clone()</code> method, or other method to perform the copy.</p>     *      *  @param value Object that should be copied.     *      *  @return Copy of the specified Object.
		 */
		public static function copy (value:Object) : Object;
		/**
		 *  Returns <code>true</code> if the object reference specified     *  is a simple data type. The simple data types include the following:     *  <ul>     *    <li><code>String</code></li>     *    <li><code>Number</code></li>     *    <li><code>uint</code></li>     *    <li><code>int</code></li>     *    <li><code>Boolean</code></li>     *    <li><code>Date</code></li>     *    <li><code>Array</code></li>     *  </ul>     *     *  @param value Object inspected.     *     *  @return <code>true</code> if the object specified     *  is one of the types above; <code>false</code> otherwise.
		 */
		public static function isSimple (value:Object) : Boolean;
		/**
		 *  Compares two numeric values.     *      *  @param a First number.     *      *  @param b Second number.     *     *  @return 0 is both numbers are NaN.      *  1 if only <code>a</code> is a NaN.     *  -1 if only <code>b</code> is a NaN.     *  -1 if <code>a</code> is less than <code>b</code>.     *  1 if <code>a</code> is greater than <code>b</code>.
		 */
		public static function numericCompare (a:Number, b:Number) : int;
		/**
		 *  Compares two String values.     *      *  @param a First String value.     *      *  @param b Second String value.     *     *  @param caseInsensitive Specifies to perform a case insensitive compare,      *  <code>true</code>, or not, <code>false</code>.     *     *  @return 0 is both Strings are null.      *  1 if only <code>a</code> is null.     *  -1 if only <code>b</code> is null.     *  -1 if <code>a</code> precedes <code>b</code>.     *  1 if <code>b</code> precedes <code>a</code>.
		 */
		public static function stringCompare (a:String, b:String, caseInsensitive:Boolean = false) : int;
		/**
		 *  Compares the two Date objects and returns an integer value      *  indicating if the first Date object is before, equal to,      *  or after the second item.     *     *  @param a Date object.     *     *  @param b Date object.     *     *  @return 0 if <code>a</code> and <code>b</code>     *  are <code>null</code> or equal;      *  1 if <code>a</code> is <code>null</code>     *  or before <code>b</code>;      *  -1 if <code>b</code> is <code>null</code>     *  or before <code>a</code>.
		 */
		public static function dateCompare (a:Date, b:Date) : int;
		/**
		 *  Pretty-prints the specified Object into a String.     *  All properties will be in alpha ordering.     *  Each object will be assigned an id during printing;     *  this value will be displayed next to the object type token     *  preceded by a '#', for example:     *     *  <pre>     *  (mx.messaging.messages::AsyncMessage)#2.</pre>     *     *  <p>This id is used to indicate when a circular reference occurs.     *  Properties of an object that are of the <code>Class</code> type will     *  appear only as the assigned type.     *  For example a custom definition like the following:</p>     *     *  <pre>     *    public class MyCustomClass {     *      public var clazz:Class;     *    }</pre>     *      *  <p>With the <code>clazz</code> property assigned to <code>Date</code>     *  will display as shown below:</p>     *      *  <pre>     *   (somepackage::MyCustomClass)#0     *      clazz = (Date)</pre>     *     *  @param obj Object to be pretty printed.     *      *  @param namespaceURIs Array of namespace URIs for properties      *  that should be included in the output.     *  By default only properties in the public namespace will be included in     *  the output.     *  To get all properties regardless of namespace pass an array with a      *  single element of "*".     *      *  @param exclude Array of the property names that should be      *  excluded from the output.     *  Use this to remove data from the formatted string.     *      *  @return String containing the formatted version     *  of the specified object.     *     *  @example     *  <pre>     *  // example 1     *  var obj:AsyncMessage = new AsyncMessage();     *  obj.body = [];     *  obj.body.push(new AsyncMessage());     *  obj.headers["1"] = { name: "myName", num: 15.3};     *  obj.headers["2"] = { name: "myName", num: 15.3};     *  obj.headers["10"] = { name: "myName", num: 15.3};     *  obj.headers["11"] = { name: "myName", num: 15.3};     *  trace(ObjectUtil.toString(obj));     *     *  // will output to flashlog.txt     *  (mx.messaging.messages::AsyncMessage)#0     *    body = (Array)#1     *      [0] (mx.messaging.messages::AsyncMessage)#2     *        body = (Object)#3     *        clientId = (Null)     *        correlationId = ""     *        destination = ""     *        headers = (Object)#4     *        messageId = "378CE96A-68DB-BC1B-BCF7FFFFFFFFB525"     *        sequenceId = (Null)     *        sequencePosition = 0     *        sequenceSize = 0     *        timeToLive = 0     *        timestamp = 0     *    clientId = (Null)     *    correlationId = ""     *    destination = ""     *    headers = (Object)#5     *      1 = (Object)#6     *        name = "myName"     *        num = 15.3     *      10 = (Object)#7     *        name = "myName"     *        num = 15.3     *      11 = (Object)#8     *        name = "myName"     *        num = 15.3     *      2 = (Object)#9     *        name = "myName"     *        num = 15.3     *    messageId = "1D3E6E96-AC2D-BD11-6A39FFFFFFFF517E"     *    sequenceId = (Null)     *    sequencePosition = 0     *    sequenceSize = 0     *    timeToLive = 0     *    timestamp = 0     *     *  // example 2 with circular references     *  obj = {};     *  obj.prop1 = new Date();     *  obj.prop2 = [];     *  obj.prop2.push(15.2);     *  obj.prop2.push("testing");     *  obj.prop2.push(true);     *  obj.prop3 = {};     *  obj.prop3.circular = obj;     *  obj.prop3.deeper = new ErrorMessage();     *  obj.prop3.deeper.rootCause = obj.prop3.deeper;     *  obj.prop3.deeper2 = {};     *  obj.prop3.deeper2.deeperStill = {};     *  obj.prop3.deeper2.deeperStill.yetDeeper = obj;     *  trace(ObjectUtil.toString(obj));     *     *  // will output to flashlog.txt     *  (Object)#0     *    prop1 = Tue Apr 26 13:59:17 GMT-0700 2005     *    prop2 = (Array)#1     *      [0] 15.2     *      [1] "testing"     *      [2] true     *    prop3 = (Object)#2     *      circular = (Object)#0     *      dee
		 */
		public static function toString (value:Object, namespaceURIs:Array = null, exclude:Array = null) : String;
		/**
		 *  This method cleans up all of the additional parameters that show up in AsDoc     *  code hinting tools that developers shouldn't ever see.     *  @private
		 */
		private static function internalToString (value:Object, indent:int = 0, refs:Dictionary = null, namespaceURIs:Array = null, exclude:Array = null) : String;
		/**
		 *  @private     *  This method will append a newline and the specified number of spaces     *  to the given string.
		 */
		private static function newline (str:String, n:int = 0) : String;
		private static function internalCompare (a:Object, b:Object, currentDepth:int, desiredDepth:int, refs:Dictionary) : int;
		/**
		 *  Returns information about the class, and properties of the class, for     *  the specified Object.     *     *  @param obj The Object to inspect.     *     *  @param exclude Array of Strings specifying the property names that should be      *  excluded from the returned result. For example, you could specify      *  <code>["currentTarget", "target"]</code> for an Event object since these properties      *  can cause the returned result to become large.     *     *  @param options An Object containing one or more properties      *  that control the information returned by this method.      *  The properties include the following:     *     *  <ul>     *    <li><code>includeReadOnly</code>: If <code>false</code>,      *      exclude Object properties that are read-only.      *      The default value is <code>true</code>.</li>     *  <li><code>includeTransient</code>: If <code>false</code>,      *      exclude Object properties and variables that have <code>[Transient]</code> metadata.     *      The default value is <code>true</code>.</li>     *  <li><code>uris</code>: Array of Strings of all namespaces that should be included in the output.     *      It does allow for a wildcard of "~~".      *      By default, it is null, meaning no namespaces should be included.      *      For example, you could specify <code>["mx_internal", "mx_object"]</code>      *      or <code>["~~"]</code>.</li>     *  </ul>     *      *  @return An Object containing the following properties:     *  <ul>     *    <li><code>name</code>: String containing the name of the class;</li>     *    <li><code>properties</code>: Sorted list of the property names of the specified object,     *    or references to the original key if the specified object is a Dictionary</li>     *  </ul>
		 */
		public static function getClassInfo (obj:Object, excludes:Array = null, options:Object = null) : Object;
		/**
		 * Uses <code>getClassInfo</code> and examines the metadata information to     * determine whether a property on a given object has the specified      * metadata.     *      * @param obj The object holding the property.     * @param propName The property to check for metadata.     * @param metadataName The name of the metadata to check on the property.     * @param excludes If any properties need to be excluded when generating class info. (Optional)     * @param options If any options flags need to changed when generating class info. (Optional)     * @return true if the property has the specified metadata.
		 */
		public static function hasMetadata (obj:Object, propName:String, metadataName:String, excludes:Array = null, options:Object = null) : Boolean;
		/**
		 *  @private
		 */
		private static function internalHasMetadata (metadataInfo:Object, propName:String, metadataName:String) : Boolean;
		/**
		 *  @private
		 */
		private static function recordMetadata (properties:XMLList) : Object;
		/**
		 *  @private
		 */
		private static function getCacheKey (o:Object, excludes:Array = null, options:Object = null) : String;
		/**
		 *  @private
		 */
		private static function arrayCompare (a:Array, b:Array, currentDepth:int, desiredDepth:int, refs:Dictionary) : int;
		/**
		 * @private
		 */
		private static function byteArrayCompare (a:ByteArray, b:ByteArray) : int;
		/**
		 *  @private
		 */
		private static function listCompare (a:IList, b:IList, currentDepth:int, desiredDepth:int, refs:Dictionary) : int;
	}
}
