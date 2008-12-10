package mx.controls
{
	import flash.events.FileListEvent;
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import flash.ui.Keyboard;
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;
	import mx.controls.fileSystemClasses.FileSystemTreeDataDescriptor;
	import mx.controls.Tree;
	import mx.core.mx_internal;
	import mx.core.ScrollPolicy;
	import mx.events.FileEvent;
	import mx.events.ListEvent;
	import mx.events.TreeEvent;
	import mx.styles.StyleManager;
	import mx.styles.CSSStyleDeclaration;

	/**
	 *  Dispatched whenever the <code>directory</code> property changes *  for any reason. * *  @eventType mx.events.FileEvent.DIRECTORY_CHANGE
	 */
	[Event(name="directoryChange", type="mx.events.FileEvent")] 
	/**
	 *  Dispatched when the user closes an open directory node *  using the mouse of keyboard. * *  @eventType mx.events.FileEvent.DIRECTORY_CLOSING
	 */
	[Event(name="directoryClosing", type="mx.events.FileEvent")] 
	/**
	 *  Dispatched when the user opens a directory node *  using the mouse or keyboard. * *  <p>This is a cancelable event. *  If you call <code>event.preventDefault()</code>, *  this control continues to display the current directory *  rather than changing to display the subdirectory which was *  double-clicked.</p> * *  @eventType mx.events.FileEvent.DIRECTORY_OPENING
	 */
	[Event(name="directoryOpening", type="mx.events.FileEvent")] 
	/**
	 *  Dispatched when the user chooses a file by double-clicking it *  or by selecting it and pressing Enter. * *  @eventType mx.events.FileEvent.FILE_CHOOSE
	 */
	[Event(name="fileChoose", type="mx.events.FileEvent")] 

	/**
	 *  The FileSystemTree control displays the contents of a *  file system directory as a tree. * *  <p>You specify the directory whose content is displayed by setting *  the <code>directory</code> property to an instance *  of the flash.filesystem.File class. *  (File instances can represent directories as well as files.) *  Whenever this property changes for any reason, the control *  dispatches a <code>directoryChange</code> event.</p> * *  <p>You can set the <code>enumerationMode</code> property to specify *  whether to show this directory's files, its subdirectories, or both. *  There are three ways to show both files and subdirectories within *  each tree node: directories first, files first, or intermixed.</p> * *  <p>You can set the <code>extensions</code> property to filter the list *  so that only files with the specified extensions are displayed. *  (Extensions on directories are ignored.) *  You can also specify an additional filtering function of your own *  by setting the <code>filterFunction</code> property.</p> * *  <p>You can use the <code>showExtensions</code> property to show *  or hide file extensions, and the <code>showIcons</code> property *  to show or hide icons.</p> * *  <p>You can do custom-sorting within each tree node by setting *  the <code>nameCompareFunction</code> property to a function *  that compares two file or directory names.</p> * *  <p>If the user double-clicks a closed directory node, *  or clicks its disclosure icon, *  this control dispatches a <code>directoryOpening</code> event. *  If the user double-clicks an open directory node, *  or clicks its disclosure icon, *  this control dispatches a <code>directoryClosing</code> event. *  A handler can cancel either event by calling *  <code>event.preventDefault()</code> in which case the node doesn't open.</p> * *  <p>If the user double-clicks a file node, *  this control dispatches a <code>select</code> event.</p> *  *  @mxml * *  <p>The <code>&lt;mx:FileSystemTree&gt;</code> tag inherits all of the tag *  attributes of its superclass and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:FileSystemTree *    <strong>Properties</strong> *    directory="<i>null</i>" *    enumerationMode="directoriesFirst" *    extensions="<i>null</i>" *    filterFunction="<i>null</i>" *    nameCompareFunction="<i>null</i>" *    openPaths="<i>null</i>" *    selectedPath="<i>null</i>" *    selectedPaths="<i>null</i>" *    showExtensions="true" *    showHidden="false" *    showIcons="true" *  *    <strong>Events</strong> *    directoryChange="<i>No default</i>" *    directoryClosing="<i>No default</i>" *    directoryOpening="<i>No default</i>" *    fileChoose="<i>No default</i>" *  /&gt; *  </pre> *  *  @see flash.filesystem.File *  *  @playerversion AIR 1.1
	 */
	public class FileSystemTree extends Tree
	{
		/**
		 *  @copy mx.controls.FileSystemList#COMPUTER
		 */
		public static const COMPUTER : File = FileSystemControlHelper.COMPUTER;
		/**
		 *  @private
		 */
		local var helper : FileSystemControlHelper;

		/**
		 *  The directory whose contents this control displays.     *     *  <p>If you set this property to a File object representing     *  an existing directory, the <code>dataProvider</code>     *  immediately becomes <code>null</code>.     *  Later, when this control is revalidated by the LayoutManager,     *  it performs a synchronous enumeration of that directory's     *  contents and populates the <code>dataProvider</code> property     *  with an ArrayCollection of the resulting File objects     *  for the directory's files and subdirectories.</p>     *     *  <p>Setting this to a File which does not represent     *  an existing directory is an error.     *  Setting this to <code>COMPUTER</code> synchronously displays     *  the root directories, such as C: and D: on Windows.</p>     *     *  @default COMPUTER
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
		 *  @copy mx.controls.FileSystemList#nameCompareFunction     *     *  @default null
		 */
		public function get nameCompareFunction () : Function;
		/**
		 *  @private
		 */
		public function set nameCompareFunction (value:Function) : void;
		/**
		 *  An Array of <code>nativePath</code> Strings for the File items     *  representing the open subdirectories.     *  This Array is empty if no subdirectories are open.     *     *  @default []
		 */
		public function get openPaths () : Array;
		/**
		 *  @private
		 */
		public function set openPaths (value:Array) : void;
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
		 *  @copy mx.controls.FileSystemList#showExtensions     *     *  @default true
		 */
		public function get showExtensions () : Boolean;
		/**
		 *  @private
		 */
		public function set showExtensions (value:Boolean) : void;
		/**
		 *  @copy mx.controls.FileSystemList#showHidden     *     *  @default false
		 */
		public function get showHidden () : Boolean;
		/**
		 *  @private
		 */
		public function set showHidden (value:Boolean) : void;
		/**
		 *  @copy mx.controls.FileSystemList#showIcons     *     *  @default true
		 */
		public function get showIcons () : Boolean;
		/**
		 *  @private
		 */
		public function set showIcons (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function FileSystemTree ();
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private     *  The FileSystemControlHelper calls getStyle("directoryIcon")     *  and getStyle("fileIcon") because these are the style names     *  that FileSystemList and FileSystemDataGrid declare for their icons.     *  But FileSystemTree extends Tree and Tree already declares     *  the styles "folderClosedIcon" and "defaultLeafIcon"     *  for these icons, so it doesn't declare "directoryIcon"     *  and fileIcon.     *  Therefore, we map the names here.
		 */
		public function getStyle (styleProp:String) : *;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
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
		 *  Re-enumerates the current directory being displayed by this control.     *     *  <p>When this method returns, the <code>directory</code> property     *  contains the File instance for the same directory as before.     *  The <code>dataProvider</code> property is temporarily     *  <code>null</code> until the directory is re-enumerated.     *  After the enumeration, the <code>dataProvider</code> property     *  contains an ArrayCollection of File instances     *  for the directory's contents.</p>
		 */
		public function refresh () : void;
		/**
		 *  Clears the list.     *     *  <p>This method sets the <code>dataProvider</code> to <code>null</code>     *  but leaves the <code>directory</code> property unchanged.     *  You can call <code>refresh</code> to populate the list again.</p>
		 */
		public function clear () : void;
		/**
		 *  Opens a subdirectory specified by a native file system path.     *     *  <p>This method automatically opens all intervening directories     *  required to reach the specified directory.</p>     *     *  <p>If the <code>nativePath</code> doesn't specify     *  an existing file system directory, or if that     *  directory isn't within the directory that this control     *  is displaying, then this method does nothing.</p>	 *	 *  @param file A String specifying the <code>nativePath</code>     *  of a File item.
		 */
		public function openSubdirectory (nativePath:String) : void;
		/**
		 *  @private
		 */
		function openItem (item:File, async:Boolean = true) : void;
		/**
		 *  Closes a subdirectory specified by a native file system path.     *     *  <p>If the <code>nativePath</code> doesn't specify     *  a directory being displayed within this control,     *  then this method does nothing.</p>	 *     *  @param file A String specifying the <code>nativePath</code>     *  of a File item.
		 */
		public function closeSubdirectory (nativePath:String) : void;
		/**
		 *  @private
		 */
		function closeItem (item:File) : void;
		/**
		 *  @private     *     *  If any selected items are inside the closing item,     *  deselect them and select the closing item in their place.
		 */
		function fixSelectionAfterClose (item:File) : void;
		/**
		 *  @private
		 */
		private function getParentPaths (file:File) : Array;
		/**
		 *  @private
		 */
		private function modificationDateHasChanged (item:File) : Boolean;
		/**
		 *  @private
		 */
		function insertChildItems (subdirectory:File, childItems:Array) : void;
		/**
		 *  @private	 *	 *  Opens the selected node if it is a directory.     *  This method does nothing if no node is selected,     *  or if a file node is selected.
		 */
		private function openSelectedSubdirectory () : void;
		/**
		 *  @private	 *     *  Closes the selected node if it is a directory.     *  This method does nothing if no node is selected,     *  or if a file node is selected.
		 */
		private function closeSelectedSubdirectory () : void;
		/**
		 *  @private	 *  Dispatches a cancelable "directoryOpening" event	 *  and returns true if it wasn't canceled.
		 */
		private function dispatchDirectoryOpeningEvent (directory:File) : Boolean;
		/**
		 *  @private	 *  Dispatches a cancelable "directoryClosing" event	 *  and returns true if it wasn't canceled.
		 */
		private function dispatchDirectoryClosingEvent (directory:File) : Boolean;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		private function itemOpeningHandler (event:TreeEvent) : void;
		/**
		 *  @private     *  Completes an async openItem() call.
		 */
		private function directoryListingHandler (event:FileListEvent) : void;
		/**
		 *  @private
		 */
		private function itemDoubleClickHandler (event:ListEvent) : void;
	}
}
