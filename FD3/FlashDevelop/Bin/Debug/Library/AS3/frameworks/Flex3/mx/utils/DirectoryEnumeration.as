package mx.utils
{
	import flash.filesystem.File;
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;

	/**
	 *  @private *  *  The DirectoryEnumeration class supports filtering and sorting *  a list of File instances representing the files and directories *  in a file system directory. *  *  @playerversion AIR 1.1
	 */
	public class DirectoryEnumeration
	{
		/**
		 *  @private	 *  A hash table for looking up extensions quickly.
		 */
		private var extensionsSet : Object;
		/**
		 *  @private
		 */
		private var _collection : ArrayCollection;
		/**
		 *  @private	 *  Storage for the enumerationMode property.
		 */
		private var _enumerationMode : String;
		/**
		 *  @private	 *  Storage for the extensions property.
		 */
		private var _extensions : Array;
		/**
		 *  @private	 *  Storage for the filterFunction property.
		 */
		private var _filterFunction : Function;
		/**
		 *  @private	 *  Storage for the nameCompareFunction property.
		 */
		private var _nameCompareFunction : Function;
		/**
		 *  @private	 *  Storage for the showHidden property.
		 */
		private var _showHidden : Boolean;
		private var _source : Array;

		/**
		 *  An ArrayCollection representing a filtered and sorted view     *  of the <code>source</code> Array of File instances.     *  The filtering is determined by the <code>enumerationMode</code>,     *  <code>extensions</code>, <code>filterFunction</code> properties,     *  and <code>showHidden</code> properties.     *  The sorting is determined by the <code>enumerationMode</code>     *  and <code>nameCompareFunction</code> properties.
		 */
		public function get collection () : ArrayCollection;
		/**
		 *  A String specifying whether the <code>collection</code>     *  includes only files, only subdirectories, or both.     *  In the case that both are included,     *  it also specifies whether the subdirectories are ordered     *  before, after, or mixed in with the files.     *  The possible values are specified     *  by the DirectoryEnumerationMode class.     *      *  <p>You must call <code>refresh()</code> after setting     *  this property to change the <code>collection</code>.</p>     *      *  <p>This property affects which subdirectories     *  and files are in the <code>collection</code>.     *  However, it does not affect which File instances     *  are the <code>source</code> property; it works     *  by changing the behavior of the <code>fileFilterFunction()</code>     *  that is applied to the <code>source</code>.</p>     *      *  @default DirectoryEnumerationMode.DIRECTORIES_FIRST     *     *  @see mx.utils.DirectoryEnumerationMode
		 */
		public function get enumerationMode () : String;
		/**
		 *  @private
		 */
		public function set enumerationMode (value:String) : void;
		/**
		 *  An Array of extensions specifying which files     *  are included in the <code>collection</code>     *  If this property is set, for example,     *  to <code>[ "htm", "html" ]</code>,     *  then only files with these extensions are included.     *      *  <p>Extensions are considered case-insensitive     *  and the preceding dot is optional.     *  For example, specifying <code>".HTML"</code>     *  is equivalent to specifying <code>"html"</code>. </p>     *      *  <p>Directories are not subject to extension filtering,     *  even if they have names containing dots.</p>     *      *  <p>The <code>enumerationMode</code> and <code>filterFunction</code>     *  properties are also involved in determining which files     *  are included in the <code>collection</code>.     *  For example, if this property is <code>[ ".htm", ".html" ]</code>,     *  an .html file will not be included if the     *  <code>enumerationMode</code> property is     *  <code>DirectoryEnumerationMode.DIRECTORIES_ONLY</code>,     *  or if the <code>filterFunction</code> returns <code>false</code>     *  for the file.</p>     *      *  <p>If this property is <code>null</code>, no extension filtering     *  occurs, and all files are included.     *  If this property is an empty Array, all extensions are filtered out     *  and no files with extensions are included.</p>     *      *  <p>You must call <code>refresh()</code> after setting     *  this property to change the <code>collection</code>.</p>     *      *  <p>Although this property affects which files are included,     *  it does not affect which File instances are in the     *  <code>source</code> property; it works     *  by changing the behavior of the <code>fileFilterFunction()</code>     *  that is applied to the <code>source</code>.</p>     *      *  @default null
		 */
		public function get extensions () : Array;
		/**
		 *  @private
		 */
		public function set extensions (value:Array) : void;
		/**
		 *  A callback Function that you can use to perform additional filtering,     *  after the <code>enumerationMode</code> and <code>extensions</code>     *  properties have been applied, to determine which files     *  and subdirectories are included in the <code>collection</code>.     *     *  <p>This function must have the following signature:</p>     *      *  <pre>function myFilterFunction(file:File):Boolean</pre>     *      *  <p>This function should return <code>true</code> to include	 *  the specified file or subdirectory.</p>     *     *  <p>To ensure that every enumerated file and subdirectory is passed     *  to this function, the <code>enumerationMode</code> property must     *  not be <code>DirectoryEnumerationMode.FILES_ONLY</code> or     *  <code>DirectoryEnumerationMode.DIRECTORIES_ONLY</code>,     *  and the <code>extensions</code> property must be <code>null</code>.     *  Otherwise, these properties will cause pre-filtering to occur     *  before this filter function is called.</p>     *       *  <p>You must call <code>refresh()</code> after setting     *  this property to change the <code>collection</code>.</p>     *      *  @default null
		 */
		public function get filterFunction () : Function;
		/**
		 *  @private
		 */
		public function set filterFunction (value:Function) : void;
		/**
		 *  A callback Function that you can use to change how file and subdirectory     *  names are compared in order to produce the sort order.     *     *  <p>This function must have the following signature:</p>     *      *  <pre>function myNameCompareFunction(name1:String, name2:String):int</pre>     *      *  <p>It returns <code>-1</code> if <code>name1</code> should sort before     *  <code>name2</code>, <code>1</code> if <code>name1</code> should     *  sort after <code>name2</code>, and <code>0</code> if the names     *  are the same.</p>     *     *  <p>If you do not set this property, this class performs     *  a case-insensitive, locale-dependent comparison of the two names,     *  by first calling the String method <code>toLocaleLowerCase()</code>     *  on each name and then comparing them with the <code>&lt;</code>     *  and <code>&gt;</code> operators.</p>     *     *  <p>If you have set <code>enumerationMode</code> to either     *  <code>DirectoryEnumerationMode.FILES_FIRST</code> or     *  <code>DirectoryEnumerationMode.DIRECTORIES_FIRST</code>,     *  then this method will be used to compare names only within     *  the separate groups of files and directories.</p>     *      *  @default null
		 */
		public function get nameCompareFunction () : Function;
		/**
		 *  @private
		 */
		public function set nameCompareFunction (value:Function) : void;
		/**
		 *  A flag that specifies whether files and directories     *  that the operating system considers hidden	 *  are included in the <code>collection</code>.     *  Set this property to <code>true</code>     *  to include hidden files and directories.     *     *  @default false
		 */
		public function get showHidden () : Boolean;
		/**
		 *  @private
		 */
		public function set showHidden (value:Boolean) : void;
		/**
		 *  The source of data for the <code>collection</code>.	 * 	 *  <p>This class expects this property to be set to an Array	 *  of File instances representing the files and directories	 *  in a single file system directory.	 *  You can obtain such an Array by calling the	 *  <code>listDirectory()</code> or <code>listDirectoryAsync()</code>	 *  of the File class.</p>
		 */
		public function get source () : Array;
		/**
		 *  @private
		 */
		public function set source (value:Array) : void;

		/**
		 *  Constructor.     *      *  @param source An Array of File instances representing     *  the files and subdirectories in a file system directory.
		 */
		public function DirectoryEnumeration (source:Array = null);
		/**
		 *  Filters and sorts the <code>source</code> Array of File instances	 *  to produce the <code>collection</code>, as specified by the	 *  <code>enumerationMode</code>, <code>extensions</code>,	 *  <code>filterFunction</code>, <code>nameCompareFunction</code>,	 *  and <code>showHidden</code> properties.
		 */
		public function refresh () : void;
		/**
		 *  The filter function that is actually applied to filter	 *  the <code>source</code Array to produce the <code>collection</code>.	 * 	 *  <p>At the end of its processing, this method calls your	 *  <code>filterFunction</code> if one is specified.</p>
		 */
		public function fileFilterFunction (file:File) : Boolean;
		/**
		 *  The comparison function that is actually applied to sort	 *  the <code>source</code Array to produce the <code>collection</code>.	 * 	 *  <p>At the end of its processing, this method calls your	 *  <code>nameCompareFunction</code> if one is specified.</p>
		 */
		public function fileCompareFunction (file1:File, file2:File, fields:Array = null) : int;
		/**
		 *  Performs a case-insensitive, locale-dependent comparison	 *  of two file or directory names, using the String method	 *  <code>toLocaleLowerCase()</code>.
		 */
		protected function defaultNameCompareFunction (name1:String, name2:String) : int;
	}
}
