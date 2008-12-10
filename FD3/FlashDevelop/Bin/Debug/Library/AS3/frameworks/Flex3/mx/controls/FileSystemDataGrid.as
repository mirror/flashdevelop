package mx.controls
{
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;
	import mx.core.ClassFactory;
	import mx.core.IUITextField;
	import mx.core.ScrollPolicy;
	import mx.core.mx_internal;
	import mx.events.ListEvent;
	import mx.formatters.DateFormatter;
	import flash.display.DisplayObject;
	import flash.filesystem.File;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.FileSystemDataGrid;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListBase;
	import mx.core.IDataRenderer;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.events.FlexEvent;
	import mx.core.IUITextField;

	/**
	 *  Dispatched when the selected directory displayed by this control *  changes for any reason. * *  @eventType mx.events.FileEvent.DIRECTORY_CHANGE
	 */
	[Event(name="directoryChange", type="mx.events.FileEvent")] 
	/**
	 *  Dispatched when the user tries to change *  the directory displayed by this control. * *  <p>The user can try to change the directory *  by double-clicking a subdirectory, *  by pressing Enter or Ctrl-Down when a subdirectory is selected, *  by pressing Ctrl-Up when the control isn't displaying *  the COMPUTER directory, *  by pressing Ctrl-Left when there is a previous directory *  in the history list to navigate back to, *  or by pressing Ctrl-Right when there is a next directory *  in the history list to navigate forward to.</p> * *  <p>This event is cancelable. *  If you call <code>event.preventDefault()</code>, *  the directory is not changed.</p> * *  <p>After the <code>directory</code> property has changed *  and the <code>dataProvider</code> contains File instances *  for the items in the new directory, *  the <code>directoryChange</code> event is dispatched.</p> * *  @eventType mx.events.FileEvent.DIRECTORY_OPENING
	 */
	[Event(name="directoryChanging", type="mx.events.FileEvent")] 
	/**
	 *  Dispatched when the user chooses a file by double-clicking it *  or by selecting it and pressing Enter. * *  @eventType mx.events.FileEvent.FILE_CHOOSE
	 */
	[Event(name="fileChoose", type="mx.events.FileEvent")] 
	/**
	 *  Specifies the icon that indicates a directory. *  The default icon is located in the Assets.swf file. *  In MXML, you can use the following syntax to set this property: *  <code>directoryIcon="&#64;Embed(source='directoryIcon.jpg');"</code> * *  @default TreeNodeIcon
	 */
	[Style(name="directoryIcon", type="Class", format="EmbeddedFile", inherit="no")] 
	/**
	 *  Specifies the icon that indicates a file. *  The default icon is located in the Assets.swf file. *  In MXML, you can use the following syntax to set this property: *  <code>fileIcon="&#64;Embed(source='fileIcon.jpg');"</code> * *  @default TreeNodeIcon
	 */
	[Style(name="fileIcon", type="Class", format="EmbeddedFile", inherit="no")] 

	/**
	 *  The FileSystemDataGrid control lets you display the contents of a *  single file system directory in a data grid format. * *  <p>The information displayed for each item consists of its name *  (with optional generic icon), type, size, creation date, *  and modification date. *  To do this, FileSystemDataGrid automatically creates five columns *  (DataGridColumn instances) -- <code>nameColumn</code>, <code>typeColumn</code>, *  <code>sizeColumn</code>, <code>creationDateColumn</code>, *  and <code>modificationDateColumn</code> -- and sets *  the <code>columns</code> property to an array of these five instances. *  Each column instance is automatically configured to have an *  appropriate <code>labelFunction</code>, *  <code>sortCompareFunction</code>, etc. *  If you don't want all five columns, or if you want to change the *  order, reset the <code>columns</code> property. *  If you want to customize a column, such as by changing its *  <code>labelFunction</code>, simply reassign that property *  on the appropriate column object.</p> * *  <p>To change the displayed data, rather than using the <code>dataProvider</code> property, *  you set the <code>directory</code> property. *  The control then automatically populates the <code>dataProvider</code> *  property by enumerating the contents of that directory. *  You should not set the <code>dataProvider</code> yourself.</p> * *  <p>You set the <code>directory</code> property to a File instance, *  as the following example shows:</p> *  <pre>&lt;mx:FileSystemDataGrid directory="{File.desktopDirectory}"/&gt;</pre> * *  <p>You can set the <code>enumerationMode</code> property to specify *  whether to show files, subdirectories, or both. *  There are three ways to show both: directories first, *  files first, or intermixed.</p> * *  <p>You can set the <code>extensions</code> property *  to filter the displayed items so that only files *  with the specified extensions appear. *  The <code>showHidden</code> property determines whether the control *  displays files and subdirectories that the operating system *  normally hides. *  You can specify an additional <code>filterFunction</code> *  to perform custom filtering, and a <code>nameCompareFunction</code> *  to perform custom sorting.</p> * *  <p>Because AIR does not support file system notifications, *  this control does not automatically refresh if a file or *  subdirectory is created, deleted, moved, or renamed; *  in other words, it can display an out-of-date view of the file system. *  However, you can call <code>refresh()</code> to re-enumerate *  the current <code>directory</code>. *  You could, for example, choose to do this when you have *  performed a file operation that you know causes the control's *  view to become out-of-date, or when the user deactivates *  and reactivates your application.</p> * *  <p>You can use the <code>showIcons</code> property *  to show or hide icons, and the <code>showExtensions</code> *  property to show or hide file extensions.</p> * *  <p>The control provides two methods, <code>findItem()</code> *  and <code>findIndex()</code>, which you can use to search the *  displayed files and subdirectories to find the one *  with a specified <code>nativePath</code>.</p> * *  <p>Two properties, <code>selectedPath</code> *  and <code>selectedPaths</code>, work similarly *  to <code>selectedItem</code> and <code>selectedItems</code> *  or <code>selectedIndex</code> and <code>selectedIndices</code>, *  but let you specify the selection via <code>nativePath</code> *  strings. *  These are very useful if you need to display a directory *  with particular items preselected, since in this case *  you don't yet have the File items that the control will create *  when it enumerates the directory, and you don't know what *  their indices will be.</p> * *  <p>The control allows the user to navigate to other directories *  using the mouse or keyboard. *  The user can try to change the directory *  by double-clicking a subdirect
	 */
	public class FileSystemDataGrid extends DataGrid
	{
		/**
		 *  @copy mx.controls.FileSystemList#COMPUTER
		 */
		public static const COMPUTER : File = FileSystemControlHelper.COMPUTER;
		/**
		 *  @private     *  An undocumented class that implements functionality     *  shared by various file system components.
		 */
		local var helper : FileSystemControlHelper;
		/**
		 *  The DateFormatter object used to format the dates     *  in the Created and Modified columns.
		 */
		local var dateFormatter : DateFormatter;
		/**
		 *  The DataGridColumn representing the Created column.     *  The FileSystemDataGrid control automatically creates this column.     *     *  <p>You can set properties such as     *  <code>creationDateColumn.width</code> to customize this column.     *  To remove this column entirely, or to change the column order,     *  set the <code>columns</code> property to an array such as     *  <code>[ nameColumn, modificationDateColumn, sizeColumn ]</code>.</p>
		 */
		public var creationDateColumn : DataGridColumn;
		/**
		 *  @private     *  Storage for the dateFormatString property.
		 */
		private var _dateFormatString : String;
		/**
		 *  @private
		 */
		private var dateFormatStringOverride : String;
		/**
		 *  The DataGridColumn representing the Modified column.     *  The FileSystemDataGrid control automatically creates this column.     *     *  <p>You can set properties such as     *  <code>modificationDateColumn.width</code> to customize this column.     *  To remove this column entirely, or to change the column order,     *  set the <code>columns</code> property to an array such as     *  <code>[ nameColumn, modificationDateColumn, sizeColumn ]</code>.</p>
		 */
		public var modificationDateColumn : DataGridColumn;
		/**
		 *  The DataGridColumn representing the Name column.     *  The FileSystemDataGrid control automatically creates this column.     *     *  <p>You can set properties such as <code>nameColumn.width</code>     *  to customize this column.     *  To remove this column entirely, or to change the column order,     *  set the <code>columns</code> property to an array such as     *  <code>[ nameColumn, modificationDateColumn, sizeColumn ]</code>.</p>
		 */
		public var nameColumn : DataGridColumn;
		/**
		 *  The DataGridColumn representing the Size column.     *  The FileSystemDataGrid control automatically creates this column.     *     *  <p>You can set properties such as <code>sizeColumn.width</code>     *  to customize this column.     *  To remove this column entirely, or to change the column order,     *  set the <code>columns</code> property to an array such as     *  <code>[ nameColumn, modificationDateColumn, sizeColumn ]</code>.</p>
		 */
		public var sizeColumn : DataGridColumn;
		/**
		 *  @private     *  Storage for the sizeDisplayMode property.
		 */
		private var _sizeDisplayMode : String;
		/**
		 *  The DataGridColumn representing the Type column.     *  The FileSystemDataGrid control automatically creates this column.     *     *  <p>You can set properties such as <code>typeColumn.width</code>     *  to customize this column.     *  To remove this column entirely, or to change the column order,     *  set the <code>columns</code> property to an array such as     *  <code>[ nameColumn, modificationDateColumn, sizeColumn ]</code>.</p>
		 */
		public var typeColumn : DataGridColumn;

		/**
		 *  An Array of File objects representing directories     *  to which the user can navigate backward.     *     *  <p>The first item in this Array is the next directory backward     *  in the history list.     *  The last item is the directory furthest backward     *  in the history list.</p>     *     *  <p>This Array may contain a <code>null</code> item, which represents     *  the non-existent directory whose contents are root directories     *  such as C:\ and D:\ on Microsoft Windows.</p>     *     *  <p>The following example shows how to use this property     *  along with the FileSystemHistoryButton control     *  to implement a back button:</p>     *     *  <pre>     *  &lt;mx:FileSystemDataGrid id="fileSystemViewer" directory="{File.desktopDirectory}"/&gt;     *  &lt;mx:FileSystemHistoryButton label="Back"     *     enabled="{fileSystemViewer.canNavigateBack}"     *     dataProvider="{fileSystemViewer.backHistory}"     *     click="fileSystemViewer.navigateBack();"     *     itemClick="fileSystemViewer.navigateBack(event.index);"/&gt;</pre>     *     *  @default []	 *	 *  @see #canNavigateBack	 *  @see #navigateBack()	 *  @see mx.controls.FileSystemHistoryButton
		 */
		public function get backHistory () : Array;
		/**
		 *  A flag which is <code>true</code> if there is at least one directory     *  in the history list to which the user can navigate backward.     *     *  <p>The following example shows how to use this property     *  along with the FileSystemHistoryButton control     *  to implement a back button:</p>     *     *  <pre>     *  &lt;mx:FileSystemDataGrid id="fileSystemViewer" directory="{File.desktopDirectory}"/&gt;     *  &lt;mx:FileSystemHistoryButton label="Back"     *      enabled="{fileSystemViewer.canNavigateBack}"     *      dataProvider="{fileSystemViewer.backHistory}"     *      click="fileSystemViewer.navigateBack();"     *      itemClick="fileSystemViewer.navigateBack(event.index);"/&gt;</pre>     *     *  @default false	 *	 *  @see #backHistory	 *  @see #navigateBack()
		 */
		public function get canNavigateBack () : Boolean;
		/**
		 *  A flag which is <code>true</code> if the user can navigate down     *  into a selected directory.     *  This flag is <code>false</code> when there is no selected item     *  or when the selected item is a file rather than a directory.     *     *  <p>The following example shows how to use this property     *  along with the Button control:</p>     *     *  <pre>     *  &lt;mx:FileSystemDataGrid id="fileSystemViewer" directory="{File.desktopDirectory}"/&gt;     *  &lt;mx:Button label="Open"     *      enabled="{fileSystemViewer.canNavigateDown}"     *      click="fileSystemViewer.navigateDown();"/&gt;</pre>     *     *  @default false	 *	 *  @see #navigateDown()
		 */
		public function get canNavigateDown () : Boolean;
		/**
		 *  A flag which is <code>true</code> if there is at least one directory     *  in the history list to which the user can navigate forward.     *     *  <p>The following example shows how to use this property     *  along with the FileSystemHistoryButton control     *  to implement a forward button:</p>     *     *  <pre>     *  &lt;mx:FileSystemDataGrid id="fileSystemViewer" directory="{File.desktopDirectory}"/&gt;     *  &lt;mx:FileSystemHistoryButton label="Forward"     *      enabled="{fileSystemViewer.canNavigateForward}"     *      dataProvider="{fileSystemViewer.forwardHistory}"     *      click="fileSystemViewer.navigateForward();"     *      itemClick="fileSystemViewer.navigateForward(event.index);"/&gt;</pre>     *     *  @default false	 *	 *  @see #forwardHistory	 *  @see #navigateForward()
		 */
		public function get canNavigateForward () : Boolean;
		/**
		 *  A flag which is <code>true</code> if the user can navigate up     *  to a parent directory.     *  This flag is only <code>false</code> when this control is     *  displaying the root directories such as C:\ and D:\ on Microsoft Windows.     *  (This is the case in which the <code>directory</code>     *  property is <code>COMPUTER</code>.)     *     *  <p>The following example shows how to use this property     *  along with the Button control:</p>     *     *  <pre>     *  &lt;mx:FileSystemDataGrid id="fileSystemViewer" directory="{File.desktopDirectory}"/&gt;     *  &lt;mx:Button label="Up"     *      enabled="{fileSystemViewer.canNavigateUp}"     *      click="fileSystemViewer.navigateUp();"/&gt;</pre>     *     *  @default false	 *	 *  @see #navigateUp()
		 */
		public function get canNavigateUp () : Boolean;
		/**
		 *  A String that determines how dates in the Created and Modified     *  columns are formatted.     *  Setting this property sets the <code>formatString</code>     *  of an internal DateFormatter that this control creates.     *     *  @see mx.formatters.DateFormatter#formatString
		 */
		public function get dateFormatString () : String;
		/**
		 *  @private
		 */
		public function set dateFormatString (value:String) : void;
		/**
		 *  @copy mx.controls.FileSystemList#directory
		 */
		public function get directory () : File;
		/**
		 *  @private
		 */
		public function set directory (value:File) : void;
		/**
		 *  @copy mx.controls.FileSystemList#enumerationMode     *     *  @default FileSystemEnumerationMode.DIRECTORIES_FIRST     *     *  @see mx.controls.FileSystemEnumerationMode
		 */
		public function get enumerationMode () : String;
		/**
		 *  @private
		 */
		public function set enumerationMode (value:String) : void;
		/**
		 *  @copy mx.controls.FileSystemList#extensions     *     *  @default null
		 */
		public function get extensions () : Array;
		/**
		 *  @private
		 */
		public function set extensions (value:Array) : void;
		/**
		 *  @copy mx.controls.FileSystemList#filterFunction     *     *  @default null
		 */
		public function get filterFunction () : Function;
		/**
		 *  @private
		 */
		public function set filterFunction (value:Function) : void;
		/**
		 *  An Array of File objects representing directories     *  to which the user can navigate forward.     *     *  <p>The first item in this Array is the next directory forward     *  in the history list.     *  The last item is the directory furthest forward     *  in the history list.</p>     *     *  <p>This Array may contain a <code>null</code> item, which represents     *  the non-existent directory whose contents are root directories     *  such as C:\ and D:\ on Windows.</p>     *     *  <p>The following example shows how to use this property     *  along with the FileSystemHistoryButton control to implement a forward button:</p>     *     *  <pre>     *  &lt;mx:FileSystemDataGrid id="fileSystemViewer" directory="{File.desktopDirectory}"/&gt;     *  &lt;mx:FileSystemHistoryButton label="Forward"     *      enabled="{fileSystemViewer.canNavigateForward}"     *      dataProvider="{fileSystemViewer.forwardHistory}"     *      click="fileSystemViewer.navigateForward();"     *      itemClick="fileSystemViewer.navigateForward(event.index);"/&gt;</pre>     *     *  @default []	 *	 * @see mx.controls.FileSystemHistoryButton
		 */
		public function get forwardHistory () : Array;
		/**
		 *  @copy mx.controls.FileSystemList#nameCompareFunction     *     *  @default null
		 */
		public function get nameCompareFunction () : Function;
		/**
		 *  @private
		 */
		public function set nameCompareFunction (value:Function) : void;
		/**
		 *  @copy mx.controls.FileSystemList#selectedPath     *     *  @default null     *     *  @see mx.controls.listClasses.ListBase#selectedIndex     *  @see mx.controls.listClasses.ListBase#selectedItem
		 */
		public function get selectedPath () : String;
		/**
		 *  @private
		 */
		public function set selectedPath (value:String) : void;
		/**
		 *  @copy mx.controls.FileSystemList#selectedPaths     *     *  @default []     *     *  @see mx.controls.listClasses.ListBase#selectedIndex     *  @see mx.controls.listClasses.ListBase#selectedItem
		 */
		public function get selectedPaths () : Array;
		/**
		 *  @private
		 */
		public function set selectedPaths (value:Array) : void;
		/**
		 *  @copy mx.controls.FileSystemList#showExtensions
		 */
		public function get showExtensions () : Boolean;
		/**
		 *  @private
		 */
		public function set showExtensions (value:Boolean) : void;
		/**
		 *  @copy mx.controls.FileSystemList#showHidden
		 */
		public function get showHidden () : Boolean;
		/**
		 *  @private
		 */
		public function set showHidden (value:Boolean) : void;
		/**
		 *  @copy mx.controls.FileSystemList#showIcons
		 */
		public function get showIcons () : Boolean;
		/**
		 *  @private
		 */
		public function set showIcons (value:Boolean) : void;
		/**
		 *  A String specifying whether the Size column displays file sizes     *  in bytes or rounded up to the nearest kilobyte,     *  where a kilobyte is 1024 bytes.     *  The possible values are specified     *  by the FileSystemSizeDisplayMode class.     *     *  @see mx.controls.FileSystemSizeDisplayMode
		 */
		public function get sizeDisplayMode () : String;
		/**
		 *  @private
		 */
		public function set sizeDisplayMode (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function FileSystemDataGrid ();
		/**
		 *  @private
		 */
		protected function childrenCreated () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  @private
		 */
		protected function itemToUID (data:Object) : String;
		/**
		 *  @copy mx.controls.FileSystemList#findIndex()
		 */
		public function findIndex (nativePath:String) : int;
		/**
		 *  @copy mx.controls.FileSystemList#findItem()
		 */
		public function findItem (nativePath:String) : File;
		/**
		 *  Changes this control to display the contents     *  of the selected subdirectory.     *     *  <p>If a subdirectory is not selected, this method does nothing.</p>     *     *  <p>When this method returns, the <code>directory</code> property     *  contains the File instance for the new directory.     *  The <code>dataProvider</code> property is temporarily     *  <code>null</code> until the new directory has been enumerated.     *  After the enumeration, the <code>dataProvider</code> property     *  contains an ArrayCollection of File instances     *  for the new directory's contents.</p>     *     *  <p>The following example shows how to use this method     *  along with the Button control to create an open button:</p>     *     *  <pre>     *  &lt;mx:FileSystemDataGrid id="fileSystemViewer" directory="{File.desktopDirectory}"/&gt;     *  &lt;mx:Button label="Open"     *      enabled="{fileSystemViewer.canNavigateDown}"     *      click="fileSystemViewer.navigateDown();"/&gt;</pre>	 *	 *  @see #canNavigateDown
		 */
		public function navigateDown () : void;
		/**
		 *  Changes this control to display the contents of the next directory     *  up in the hierarchy.     *     *  <p>If this control is currently displaying root directories     *  (such as C: and D: on Microsoft Windows), this method does nothing.</p>     *     *  <p>When this method returns, the <code>directory</code> property     *  contains the File instance for the new directory.     *  The <code>dataProvider</code> property is temporarily     *  <code>null</code> until the new directory has been enumerated.     *  After the enumeration, the <code>dataProvider</code> property     *  contains an ArrayCollection of File instances     *  for the new directory's contents.</p>     *     *  <p>The following example shows how to use this property     *  along with the Button control to create an up button:</p>     *     *  <pre>     *  &lt;mx:FileSystemDataGrid id="fileSystemViewer" directory="{File.desktopDirectory}"/&gt;     *  &lt;mx:Button label="Up"     *      enabled="{fileSystemViewer.canNavigateUp}"     *      click="fileSystemViewer.navigateUp();"/&gt;</pre>	 *	 *  @see #canNavigateUp
		 */
		public function navigateUp () : void;
		/**
		 *  Changes this control to display the contents of a previously-visited     *  directory in the <code>backHistory</code> array.     *     *  <p>If the <code>backHistory</code> array is empty, or if you specify     *  an index that is not in that array, then this method does nothing.</p>     *     *  <p>When this method returns, the <code>directory</code> property     *  contains the File instance for the new directory.     *  The <code>dataProvider</code> property is temporarily     *  <code>null</code> until the new directory has been enumerated.     *  After the enumeration, the <code>dataProvider</code> property     *  contains an ArrayCollection of File instances     *  for the new directory's contents.</p>     *     *  <p>The history list is left unchanged. However, the current index     *  into it changes, which affects the <code>backHistory</code>     *  and <code>forwardHistory</code> properties.     *  They have new values as soon as this method returns.</p>     *     *  <p>The following example shows how to use this method     *  along with the FileSystemHistoryButton control to create a back button:</p>     *     *  <pre>     *  &lt;mx:FileSystemDataGrid id="fileSystemViewer" directory="{File.desktopDirectory}"/&gt;     *  &lt;mx:FileSystemHistoryButton label="Back"     *      enabled="{fileSystemViewer.canNavigateBack}"     *      dataProvider="{fileSystemViewer.backHistory}"     *      click="fileSystemViewer.navigateBack();"     *      itemClick="fileSystemViewer.navigateBack(event.index);"/&gt;</pre>     *     *  @param index The index in the <code>backHistory</code> array     *  to navigate to.     *  The default is 0, indicating the directory that is "closest back".	 *	 *  @see #backHistory	 *  @see #canNavigateBack
		 */
		public function navigateBack (index:int = 0) : void;
		/**
		 *  Changes this control to display the contents of a previously-visited     *  directory in the <code>forwardHistory</code> array.     *     *  <p>If the <code>forwardHistory</code> array is empty, or if you specify     *  an index that is not in that array, then this method does nothing.</p>     *     *  <p>When this method returns, the <code>directory</code> property     *  contains the File instance for the new directory.     *  The <code>dataProvider</code> property is temporarily     *  <code>null</code> until the new directory has been enumerated.     *  After the enumeration, the <code>dataProvider</code> property     *  contains an ArrayCollection of File instances     *  for the new directory's contents.</p>     *     *  <p>The history list is left unchanged. However, the current index     *  into it changes, which affects the <code>backHistory</code>     *  and <code>forwardHistory</code> properties.     *  They have new values as soon as this method returns.</p>     *     *  <p>The following example shows how to use this method     *  along with the FileSystemHistoryButton control to create a forward button:</p>     *     *  <pre>     *  &lt;mx:FileSystemDataGrid id="fileSystemViewer" directory="{File.desktopDirectory}"/&gt;     *  &lt;mx:FileSystemHistoryButton label="Forward"     *      enabled="{fileSystemViewer.canNavigateForward}"     *      dataProvider="{fileSystemViewer.forwardHistory}"     *      click="fileSystemViewer.navigateForward();"     *      itemClick="fileSystemViewer.navigateForward(event.index);"/&gt;</pre>     *     *  @param index The index in the <code>forwardHistory</code> array     *  to navigate to.     *  The default is 0, indicating the directory that is "closest forward".	 *	 *  @see #canNavigateForward	 *  @see #forwardHistory
		 */
		public function navigateForward (index:int = 0) : void;
		/**
		 *  @copy mx.controls.FileSystemList#navigateTo()
		 */
		public function navigateTo (directory:File) : void;
		/**
		 *  @copy mx.controls.FileSystemList#refresh()
		 */
		public function refresh () : void;
		/**
		 *  @copy mx.controls.FileSystemList#clear()
		 */
		public function clear () : void;
		/**
		 *  @private
		 */
		public function resetHistory (dir:File) : void;
		/**
		 *  @private
		 */
		private function nameSortCompareFunction (item1:File, item2:File) : int;
		/**
		 *  @private
		 */
		private function typeLabelFunction (item:File, column:DataGridColumn = null) : String;
		/**
		 *  @private
		 */
		private function typeSortCompareFunction (item1:File, item2:File) : int;
		/**
		 *  @private
		 */
		private function sizeLabelFunction (item:File, column:DataGridColumn = null) : String;
		/**
		 *  @private
		 */
		private function sizeSortCompareFunction (item1:File, item2:File) : int;
		/**
		 *  @private
		 */
		private function creationDateLabelFunction (item:File, column:DataGridColumn = null) : String;
		/**
		 *  @private
		 */
		private function modificationDateLabelFunction (item:File, column:DataGridColumn = null) : String;
		/**
		 *  @private
		 */
		private function determineWidthToDisplay (s:String) : Number;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function itemDoubleClickHandler (event:ListEvent) : void;
	}
	/**
	 *  @private
	 */
	internal class CustomDataGridColumn extends DataGridColumn
	{
		/**
		 *  Constructor.
		 */
		public function CustomDataGridColumn (columnName:String = null);
		/**
		 *  @private
		 */
		public function itemToDataTip (data:Object) : String;
	}
	/**
	 *  @private *  This helper class implements the renderer for the Name column, *  which displays an icon and a name for a File. *  We need a custom renderer because DataGridItemRenderer *  doesn't support an icon.
	 */
	internal class NameColumnRenderer extends UIComponent implements IDataRenderer
	{
		/**
		 *  @private
		 */
		private var listOwner : ListBase;
		/**
		 *  @private     *  Storage for the data property.
		 */
		private var _data : Object;
		/**
		 *  The internal IFlexDisplayObject that displays the icon in this renderer.
		 */
		protected var icon : IFlexDisplayObject;
		/**
		 *  The internal IUITextField that displays the text in this renderer.
		 */
		protected var label : IUITextField;
		/**
		 *  @private     *  Storage for the listData property.
		 */
		private var _listData : DataGridListData;

		/**
		 *  @private	 *  The baselinePosition of a NameColumnRenderer is calculated	 *  for its label.
		 */
		public function get baselinePosition () : Number;
		/**
		 *  The implementation of the <code>data</code> property     *  as defined by the IDataRenderer interface.     *  When set, it stores the value and invalidates the component     *  to trigger a relayout of the component.     *     *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  The implementation of the <code>listData</code> property     *  as defined by the IDropInListItemRenderer interface.     *     *  @see mx.controls.listClasses.IDropInListItemRenderer
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;

		/**
		 *  Constructor.
		 */
		public function NameColumnRenderer ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private     *  Apply the data and listData.     *  Create an instance of the icon if specified,     *  and set the text into the text field.
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
	}
}
