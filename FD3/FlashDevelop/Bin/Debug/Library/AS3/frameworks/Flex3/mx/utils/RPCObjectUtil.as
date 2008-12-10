package mx.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	import flash.xml.XMLNode;
	import mx.collections.IList;

	/**
	 *  The RPCObjectUtil class is a subset of ObjectUtil, removing methods *  that create dependency issues when RPC messages are in a bootstrap loader.
	 */
	public class RPCObjectUtil
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
		/**
		 *  Returns information about the class, and properties of the class, for     *  the specified Object.     *     *  @param obj The Object to inspect.     *     *  @param exclude Array of Strings specifying the property names that should be      *  excluded from the returned result. For example, you could specify      *  <code>["currentTarget", "target"]</code> for an Event object since these properties      *  can cause the returned result to become large.     *     *  @param options An Object containing one or more properties      *  that control the information returned by this method.      *  The properties include the following:     *     *  <ul>     *    <li><code>includeReadOnly</code>: If <code>false</code>,      *      exclude Object properties that are read-only.      *      The default value is <code>true</code>.</li>     *  <li><code>includeTransient</code>: If <code>false</code>,      *      exclude Object properties and variables that have <code>[Transient]</code> metadata.     *      The default value is <code>true</code>.</li>     *  <li><code>uris</code>: Array of Strings of all namespaces that should be included in the output.     *      It does allow for a wildcard of "~~".      *      By default, it is null, meaning no namespaces should be included.      *      For example, you could specify <code>["mx_internal", "mx_object"]</code>      *      or <code>["~~"]</code>.</li>     *  </ul>     *      *  @return An Object containing the following properties:     *  <ul>     *    <li><code>name</code>: String containing the name of the class;</li>     *    <li><code>properties</code>: Sorted list of the property names of the specified object.</li>     *  </ul>
		 */
		public static function getClassInfo (obj:Object, excludes:Array = null, options:Object = null) : Object;
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
	}
}
