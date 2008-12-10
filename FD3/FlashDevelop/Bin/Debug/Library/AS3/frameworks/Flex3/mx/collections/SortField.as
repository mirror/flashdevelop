package mx.collections
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.collections.errors.SortError;
	import mx.core.mx_internal;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.ObjectUtil;

	/**
	 *  Provides the sorting information required to establish a sort on a field *  or property in an existing view. *  Typically the sort is defined for collections of complex items, that is items *  in which the sort is performed on properties of those objects. *  As in the following example: *  *  <pre><code> *     var col:ICollectionView = new ArrayCollection(); *     col.addItem({first:"Anders", last:"Dickerson"}); *     var sort:Sort = new Sort(); *     sort.fields = [new SortField("first", true)]; *     col.sort = sort; *  </code></pre> *  *  There are situations in which the collection contains simple items, like *  <code>String</code>, <code>Date</code>, <code>Boolean</code>, etc. *  In this case, sorting should be applied to the simple type directly. *  When constructing a sort for this situation only a single sort field is *  required and should not have a <code>name</code> specified. *  For example: *  *  <pre><code> *     var col:ICollectionView = new ArrayCollection(); *     col.addItem("California"); *     col.addItem("Arizona"); *     var sort:Sort = new Sort(); *     sort.fields = [new SortField(null, true)]; *     col.sort = sort; *  </code></pre> *  *  @mxml * *  <p>The <code>&lt;mx:SortField&gt;</code> tag has the following attributes:</p> * *  <pre> *  &lt;mx:SortField *  <b>Properties</b> *  caseInsensitive="false" *  compareFunction="<em>Internal compare function</em>" *  descending="false" *  name="null" *  numeric="null" *  /&gt; *  </pre>
	 */
	public class SortField extends EventDispatcher
	{
		/**
		 *  @private	 *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private     *  Storage for the caseInsensitive property.
		 */
		private var _caseInsensitive : Boolean;
		/**
		 *  @private     *  Storage for the compareFunction property.
		 */
		private var _compareFunction : Function;
		private var _usingCustomCompareFunction : Boolean;
		/**
		 *  @private     *  Storage for the descending property.
		 */
		private var _descending : Boolean;
		/**
		 *  @private     *  Storage for the name property.
		 */
		private var _name : String;
		/**
		 *  @private     *  Storage for the numeric property.
		 */
		private var _numeric : Object;

		/**
		 *  Specifies whether the sort for this field should be case insensitive.     *     *  @default false
		 */
		public function get caseInsensitive () : Boolean;
		/**
		 *  @private
		 */
		public function set caseInsensitive (value:Boolean) : void;
		/**
		 *  The function that compares two items during a sort of items for the     *  associated collection. If you specify a <code>compareFunction</code>	 *  property in a Sort object, Flex ignores any <code>compareFunction</code>	 *  properties of the Sort's SortField objects.     *  <p>The compare function must have the following signature:</p>     *     *  <p><code>function myCompare(a:Object, b:Object):int</code></p>     *     *  <p>This function must return the following values:</p>	 * 	 *   <ul>     *        <li>-1, if <code>a</code> should appear before <code>b</code> in     *        the sorted sequence</li>     *        <li>0, if <code>a</code> equals <code>b</code></li>     *        <li>1, if <code>a</code> should appear after <code>b</code> in the     *        sorted sequence</li>     *  </ul>     *     *  <p>The default value is an internal compare function that can perform 	 *  a string, numeric, or date comparison in ascending or descending order, 	 *  with case-sensitive or case-insensitive string comparisons.     *  Specify your own function only if you need a need a custom comparison algorithm.     *  This is normally only the case if a calculated field is used in a display.</p>     *
		 */
		public function get compareFunction () : Function;
		/**
		 *  @private
		 */
		public function set compareFunction (c:Function) : void;
		/**
		 * True if this SortField uses a custom comparitor function.
		 */
		function get usingCustomCompareFunction () : Boolean;
		/**
		 *  Specifies whether the this field should be sorted in descending     *  order.     *     *  <p> The default value is <code>false</code> (ascending).</p>
		 */
		public function get descending () : Boolean;
		/**
		 *  @private
		 */
		public function set descending (value:Boolean) : void;
		/**
		 *  The name of the field to be sorted.     *     *  @default null
		 */
		public function get name () : String;
		/**
		 *  @private
		 */
		public function set name (n:String) : void;
		/**
		 *  Specifies that if the field being sorted contains numeric     *  (number/int/uint) values, or string representations of numeric values, 	 *  the comparitor use a numeric comparison.     *  If this property is <code>false</code>, fields with string representations	 *  of numbers are sorted using strings comparison, so 100 precedes 99, 	 *  because "1" is a lower string value than "9".     *  If this property is <code>null</code>, the first data item	 *  is introspected to see if it is a number or string and the sort	 *  proceeds based on that introspection     *     *  @default false
		 */
		public function get numeric () : Object;
		/**
		 *  @private
		 */
		public function set numeric (value:Object) : void;

		/**
		 *  Constructor.     *     *  @param name The name of the property that this field uses for     *              comparison.     *              If the object is a simple type, pass <code>null</code>.     *  @param caseInsensitive When sorting strings, tells the comparitor     *              whether to ignore the case of the values.     *  @param descending Tells the comparator whether to arrange items in     *              descending order.     *  @param numeric Tells the comparitor whether to compare sort items as     *              numbers, instead of alphabetically.
		 */
		public function SortField (name:String = null, caseInsensitive:Boolean = false, descending:Boolean = false, numeric:Object = null);
		function internalCompare (a:Object, b:Object) : int;
		/**
		 * Build up the options argument that could be used to Array.sortOn.    * Return -1 if this SortField shouldn't be used in the method.
		 */
		function getArraySortOnOptions () : int;
		/**
		 *  @private     *  This method allows us to determine what underlying data type we need to     *  perform comparisions on and set the appropriate compare method.     *  If an option like numeric is set it will take precedence over this aspect.
		 */
		function initCompare (obj:Object) : void;
		/**
		 * Reverse the criteria for this sort field.     * If the field was sorted in descending order, for example, sort it     * in ascending order.     *     * <p>Note: an ICollectionView does not automatically update when the     * SortFields are modified; call its <code>refresh()</code> method to     * update the view.</p>
		 */
		public function reverse () : void;
		/**
		 *  @private     *  A pretty printer for Sort that lists the sort fields and their     *  options.
		 */
		public function toString () : String;
		private function nullCompare (a:Object, b:Object) : int;
		/**
		 * Pull the numbers from the objects and call the implementation.
		 */
		private function numericCompare (a:Object, b:Object) : int;
		/**
		 * Pull the date objects from the values and compare them.
		 */
		private function dateCompare (a:Object, b:Object) : int;
		/**
		 * Pull the strings from the objects and call the implementation.
		 */
		private function stringCompare (a:Object, b:Object) : int;
		/**
		 * Pull the values out fo the XML object, then compare     * using the string or numeric comparator depending     * on the numeric flag.
		 */
		private function xmlCompare (a:Object, b:Object) : int;
	}
}
