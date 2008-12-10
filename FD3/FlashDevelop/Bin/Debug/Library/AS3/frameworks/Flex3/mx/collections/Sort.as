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
	 *  Provides the sorting information required to establish a sort on an *  existing view (ICollectionView interface or class that implements the *  interface). After you assign a Sort instance to the view's *  <code>sort</code> property, you must call the view's * <code>refresh()</code> method to apply the sort criteria. * *  Typically the sort is defined for collections of complex items, that is  *  collections in which the sort is performed on one or more properties of  *  the objects in the collection. *  The following example shows this use: *  <pre><code> *     var col:ICollectionView = new ArrayCollection(); *     // In the real world, the collection would have more than one item. *     col.addItem({first:"Anders", last:"Dickerson"}); *     // Create the Sort instance. *     var sort:Sort = new Sort(); *     // Set the sort field; sort on the last name first, first name second. *     // Both fields are case-insensitive. *     sort.fields = [new SortField("last",true), new SortField("first",true)]; *       // Assign the Sort object to the view. *     col.sort = sort; *     // Apply the sort to the collection. *       col.refresh(); *  </code></pre> * *  <p>There are situations in which the collection contains simple items, like *  <code>String</code>, <code>Date</code>, <code>Boolean</code>, etc. *  In this case, apply the sort to the simple type directly. *  When constructing a sort for simple items, use a single sort field, *  and specify a <code>null</code> <code>name</code> (first) parameter *  in the SortField object constructor. *  For example: *  <pre><code> *     var col:ICollectionView = new ArrayCollection(); *     col.addItem("California"); *     col.addItem("Arizona"); *     var sort:Sort = new Sort(); *     // There is only one sort field, so use a <code>null</code> first parameter. *     sort.fields = [new SortField(null, true)]; *     col.sort = sort; *       col.refresh(); *  </code></pre> *  </p> * *  <p>The Flex implementations of the ICollectionView interface retrieve  *  all items from a remote location before executing a sort. *  If you use paging with a sorted list, apply the sort to the remote *  collection before you retrieve the data. *  </p> * *  @mxml *  *  <p>The <code>&lt;mx:Sort&gt;</code> tag has the following attributes:</p> * *  <pre> *  &lt;mx:Sort *  <b>Properties</b> *  compareFunction="<em>Internal compare function</em>" *  fields="null" *  unique="false | true" *  /&gt; *  </pre> * *  @see mx.collections.ICollectionView *  @See SortField
	 */
	public class Sort extends EventDispatcher
	{
		/**
		 *  When executing a find return the index any matching item.
		 */
		public static const ANY_INDEX_MODE : String = "any";
		/**
		 *  When executing a find return the index for the first matching item.
		 */
		public static const FIRST_INDEX_MODE : String = "first";
		/**
		 *  When executing a find return the index for the last matching item.
		 */
		public static const LAST_INDEX_MODE : String = "last";
		/**
		 *  @private	 *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private     *  Storage for the compareFunction property.
		 */
		private var _compareFunction : Function;
		/**
		 *  @private
		 */
		private var usingCustomCompareFunction : Boolean;
		/**
		 *  @private     *  Storage for the fields property.
		 */
		private var _fields : Array;
		/**
		 *  @private
		 */
		private var fieldList : Array;
		/**
		 *  @private     *  Storage for the unique property.
		 */
		private var _unique : Boolean;
		private var defaultEmptyField : SortField;
		private var noFieldsDescending : Boolean;

		/**
		 *  The method used to compare items when sorting.     *  If you specify this property, Flex ignores any <code>compareFunction</code>      *  properties that you specify in the SortField objects that you     *  use in this class.     *      *  <p>The compare function must have the following signature:</p>     *      *  <pre><code>     *     *     function [name](a:Object, b:Object, fields:Array = null):int     *     *  </code></pre>     *      *  <p>This function must return the following     *  <ul>     *        <li>-1, if <code>a</code> should appear before <code>b</code> in     *        the sorted sequence</li>     *        <li>0, if <code>a</code> equals <code>b</code></li>     *        <li>1, if <code>a</code> should appear after <code>b</code> in the     *        sorted sequence</li>     *  </ul></p>     *  <p>To return to the internal comparision function set this value to     *  <code>null</code>.</p>     * <p>     *  The <code>fields</code> array specified specifies the object fields     *  to compare.     *  Typically the algorithm will compare properties until the field list is     *  exhausted or a non zero value can be returned.     *  For example:</p>     *      *  <pre><code>     *    function myCompare(a:Object, b:Object, fields:Array = null):int     *    {     *        var result:int = 0;     *        var i:int = 0;     *        var propList:Array = fields ? fields : internalPropList;     *        var len:int = propList.length;     *        var propName:String;     *        while (result == 0 &amp;&amp; (i &lt; len))     *        {     *            propName = propList[i];     *            result = compareValues(a[propName], b[propName]);     *            i++;     *        }     *        return result;     *    }     *     *    function compareValues(a:Object, b:Object):int     *    {     *        if (a == null &amp;&amp; b == null)     *            return 0;     *     *        if (a == null)     *          return 1;     *     *        if (b == null)     *           return -1;     *     *        if (a &lt; b)     *            return -1;     *     *        if (a &gt; b)     *            return 1;     *     *        return 0;     *    }     *  </code></pre>     *     *  <p>The default value is an internal compare function that can perform      *  a string, numeric, or date comparison in ascending or descending order,      *  with case-sensitive or case-insensitive string comparisons.     *  Specify your own function only if you need a need a custom comparison algorithm.     *  This is normally only the case if a calculated field is used in a display.</p>     *      *  <p>Alternatively you can specify separate compare functions for each sort     *  field by using the SortField class <code>compare</code> property;     *  This way you can use the default comparison for some fields and a custom     *  comparison for others.</p>
		 */
		public function get compareFunction () : Function;
		/**
		 *  @private
		 */
		public function set compareFunction (value:Function) : void;
		/**
		 *  An Array of SortField objects that specifies the fields to compare.     *  The order of the SortField objects in the array determines     *  field priority order when sorting.     *  The default sort comparator checks the sort fields in array     *  order until it determinines a sort order for the two     *  fields being compared.     *     *  @default null     *      *  @see SortField
		 */
		public function get fields () : Array;
		/**
		 *  @private
		 */
		public function set fields (value:Array) : void;
		/**
		 *  Indicates if the sort should be unique.     *  Unique sorts fail if any value or combined value specified by the     *  fields listed in the fields property result in an indeterminate or     *  non-unique sort order; that is, if two or more items have identical     *  sort field values.     *     *  @default false
		 */
		public function get unique () : Boolean;
		/**
		 *  @private
		 */
		public function set unique (value:Boolean) : void;

		/**
		 *  Constructor.     *     *  <p>Creates a new Sort with no fields set and no custom comparator.</p>
		 */
		public function Sort ();
		/**
		 *  Finds the specified object within the specified array (or the insertion    *  point if asked for), returning the index if found or -1 if not.    *  The ListCollectionView class <code>find<i>xxx</i>()</code> methods use     *  this method to find the requested item; as a general rule, it is     *  easier to use these functions, and not <code>findItem()</code> to find     *  data in ListCollectionView-based objects.     *  You call the <code>findItem()</code> method directly when writing a class    *  that supports sorting, such as a new ICollectionView implementation.    *    *  @param items the Array within which to search.    *  @param values Object containing the properties to look for (or    *                the object to search for, itself).    *                The object must consist of field name/value pairs, where    *                the field names are names of fields specified by the     *                <code>SortFields</code> property, in the same order they     *                are used in that property.     *                You do not have to specify all of the fields from the     *                <code>SortFields</code> property, but you     *                cannot skip any in the order.     *                Therefore, if the <code>SortFields</code>    *                properity lists three fields, you can specify its first    *                and second fields in this parameter, but you cannot specify     *                only the first and third fields.    *  @param mode String containing the type of find to perform.    *           Valid values are    *                 <ul>    *                   <li>ANY_INDEX_MODE</li> Return any position that    *                   is valid for the values.    *                   <li>FIRST_INDEX_MODE</li> Return the position    *                   where the first occurrance of the values is found.    *                   <li>LAST_INDEX_MODE</li> Return the position    *                   where the    *                   last ocurrance of the specified values is found.    *                 </ul>    *  @param returnInsertionIndex If the method does not find an item identified    *                     by the <code>values</code> parameter, and this parameter    *                     is <code>true</code> the <code>findItem()</code>    *                     method returns the insertion point for the values,    *                     that is the point in the sorted order where you should     *                     insert the item.    *  @param compareFunction a comparator function to use to find the item.  If     *                 you do not specify this parameter, the function uses     *                 the function determined by the Sort instance's     *                 <code>compareFunction</code> property,     *                 passing in the array of fields determined    *                 by the values object and the current SortFields.    *  @return int The index in the array of the found item.    *                If the <code>returnInsertionIndex</code> parameter is    *              <code>false</code> and the item is not found, returns -1.    *                If the <code>returnInsertionIndex</code> parameter is    *              <code>true</code> and the item is not found, returns    *                the index of the point in the sorted array where the values    *              would be inserted.
		 */
		public function findItem (items:Array, values:Object, mode:String, returnInsertionIndex:Boolean = false, compareFunction:Function = null) : int;
		/**
		 *  Return whether the specified property is used to control the sort.     *  The function cannot determine a definitive answer if the sort uses a     *  custom comparitor; it always returns <code>true</code> in this case.     *     *  @param property The name of the field that to test.     *  @return Whether the property value might affect the sort outcome.     *  If the sort uses the default compareFunction, returns     *  <code>true</code> if the     *  <code>property</code> parameter specifies a sort field.     *  If the sort or any SortField uses a custom comparator,     * there's no way to know, so return <code>true</code>.
		 */
		public function propertyAffectsSort (property:String) : Boolean;
		/**
		 * Goes through all SortFields and calls reverse() on them.     * If the field was descending now it is ascending, and vice versa.     *     * <p>Note: an ICollectionView does not automatically update when the     * SortFields are modified; call its <code>refresh()</code> method to     * update the view.</p>
		 */
		public function reverse () : void;
		/**
		 *  Apply the current sort to the specified array (not a copy).     *  To prevent the array from being modified, create a copy     *  use the copy in the <code>items</code> parameter.     *     *  <p>Flex ICollectionView implementations call the <code>sort</code> method     *  automatically and ensure that the sort is performed on a copy of the     *  underlying data.</p>     *     *  @param items Array of items to sort.
		 */
		public function sort (items:Array) : void;
		/**
		 *  @private     *  A pretty printer for Sort that lists the sort fields and their     *  options.
		 */
		public function toString () : String;
		/**
		 *  @private     *  Make sure all SortFields are ready to execute their comparators.
		 */
		private function initSortFields (item:Object, buildArraySortArgs:Boolean = false) : Object;
		/**
		 *  @private     *  Compares the values specified based on the sort field options specified     *  for this sort.  The fields parameter is really just used to get the     *  number of fields to check.  We don't look at the actual values     *  to see if they match the actual sort.
		 */
		private function internalCompare (a:Object, b:Object, fields:Array = null) : int;
		/**
		 * If the sort does not have any sort fields nor a custom comparator     * just use an empty SortField object and have it use its default     * logic.
		 */
		private function noFieldsCompare (a:Object, b:Object, fields:Array = null) : int;
	}
}
