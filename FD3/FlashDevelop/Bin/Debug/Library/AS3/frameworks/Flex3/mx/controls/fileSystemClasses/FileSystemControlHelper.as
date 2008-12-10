package mx.controls.fileSystemClasses
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	import mx.collections.ArrayCollection;
	import mx.controls.FileSystemEnumerationMode;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.mx_internal;
	import mx.events.FileEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.DirectoryEnumeration;

	/**
	 *  @private
	 */
	public class FileSystemControlHelper
	{
		/**
		 *  @private
		 */
		public static var COMPUTER : File;
		/**
		 *  @private	 *  A reference to the FileSystemList, FileSystemDataGrid,	 *  FileSystemTree, or FileSystemComboBox using this object.
		 */
		local var owner : Object;
		/**
		 *  @private	 *  A flag indicating whether the dataProvider of the owner	 *  is hierarchical or flat.	 *  In other words, this flag is true if the owner	 *  is a FileSystemTree and false otherwise.
		 */
		local var hierarchical : Boolean;
		/**
		 *  @private
		 */
		local var resourceManager : IResourceManager;
		/**
		 *  @private	 *  Storage for the directory property.
		 */
		private var _directory : File;
		/**
		 *  @private
		 */
		private var directoryChanged : Boolean;
		/**
		 *  @private
		 */
		local var directoryEnumeration : DirectoryEnumeration;
		/**
		 *  @private	 *  Storage for the enumerationMode property.
		 */
		private var _enumerationMode : String;
		/**
		 *  @private
		 */
		private var enumerationModeChanged : Boolean;
		/**
		 *  @private	 *  Storage for the extensions property.
		 */
		private var _extensions : Array;
		/**
		 *  @private
		 */
		private var extensionsChanged : Boolean;
		/**
		 *  @private	 *  Storage for the filterFunction property.
		 */
		private var _filterFunction : Function;
		/**
		 *  @private
		 */
		private var filterFunctionChanged : Boolean;
		/**
		 *  @private
		 */
		public var history : Array;
		/**
		 *  @private
		 */
		public var historyIndex : int;
		/**
		 *  @private	 *  Storage for the nativePathToIndexMap property.
		 */
		private var _nativePathToIndexMap : Object;
		/**
		 *  @private	 *  Storage for the itemArray property.
		 */
		private var _itemArray : Array;
		/**
		 *  @private	 *  Storage for the nameCompareFunction property.
		 */
		private var _nameCompareFunction : Function;
		/**
		 *  @private
		 */
		private var nameCompareFunctionChanged : Boolean;
		/**
		 *  @private
		 */
		private var pendingOpenPaths : Array;
		/**
		 *  @private
		 */
		private var pendingSelectedPaths : Array;
		/**
		 *  @private	 *  Storage for the showExtensions property.
		 */
		private var _showExtensions : Boolean;
		/**
		 *  @private	 *  Storage for the showHidden property.
		 */
		private var _showHidden : Boolean;
		/**
		 *  @private
		 */
		private var showHiddenChanged : Boolean;
		/**
		 *  @private	 *  Storage for the showIcons property.
		 */
		private var _showIcons : Boolean;

		/**
		 *  @private
		 */
		public function get backHistory () : Array;
		/**
		 *  @private
		 */
		public function get canNavigateBack () : Boolean;
		/**
		 *  @private
		 */
		public function get canNavigateDown () : Boolean;
		/**
		 *  @private
		 */
		public function get canNavigateForward () : Boolean;
		/**
		 *  @private
		 */
		public function get canNavigateUp () : Boolean;
		/**
		 *  @private
		 */
		public function get directory () : File;
		/**
		 *  @private
		 */
		public function set directory (value:File) : void;
		/**
		 *  @private
		 */
		public function get enumerationMode () : String;
		/**
		 *  @private
		 */
		public function set enumerationMode (value:String) : void;
		/**
		 *  @private
		 */
		public function get extensions () : Array;
		/**
		 *  @private
		 */
		public function set extensions (value:Array) : void;
		/**
		 *  @private
		 */
		public function get filterFunction () : Function;
		/**
		 *  @private
		 */
		public function set filterFunction (value:Function) : void;
		/**
		 *  @private
		 */
		public function get forwardHistory () : Array;
		/**
		 *  @private	 *  Maps nativePath (String) -> index (int).	 *  This map is used to implement findIndex() as a simple lookup,	 *  so that multiple finds are fast.	 *  It is freed whenever an operation changes which items	 *  are displayed in the control, or their order,	 *  and rebuilt tne next time it or <code>items</code> is accessed.
		 */
		function get nativePathToIndexMap () : Object;
		/**
		 *  @private	 *  An array of all the File items displayed in the control,	 *  in the order in which they appear.	 *  This array is used together with <code>nativePathToIndexMap</code>	 *  to implement findItem() as a simple lookup,	 *  so that multiple finds are fast.	 *  It is freed whenever an operation changes which items	 *  are displayed in the control, or their order,	 *  and rebuilt tne next time it	 *  or <code>nativePathToIndexMap</code> is accessed.
		 */
		function get itemArray () : Array;
		/**
		 *  @private
		 */
		public function get nameCompareFunction () : Function;
		/**
		 *  @private
		 */
		public function set nameCompareFunction (value:Function) : void;
		/**
		 *  An Array of <code>nativePath</code> Strings for the File items	 *  representing the open subdirectories.     *  This Array is empty if no subdirectories are open.     *      *  @default []
		 */
		public function get openPaths () : Array;
		/**
		 *  @private
		 */
		public function set openPaths (value:Array) : void;
		/**
		 *  @private
		 */
		public function get selectedPath () : String;
		/**
		 *  @private
		 */
		public function set selectedPath (value:String) : void;
		/**
		 *  @private
		 */
		public function get selectedPaths () : Array;
		/**
		 *  @private
		 */
		public function set selectedPaths (value:Array) : void;
		/**
		 *  @private
		 */
		public function get showExtensions () : Boolean;
		/**
		 *  @private
		 */
		public function set showExtensions (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get showHidden () : Boolean;
		/**
		 *  @private
		 */
		public function set showHidden (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get showIcons () : Boolean;
		/**
		 *  @private
		 */
		public function set showIcons (value:Boolean) : void;

		/**
		 *  @private
		 */
		private static function initClass () : void;
		/**
		 *  @private
		 */
		private static function fileSystemIsCaseInsensitive () : Boolean;
		/**
		 *  Constructor.
		 */
		public function FileSystemControlHelper (owner:Object, hierarchical:Boolean);
		/**
		 *  @private
		 */
		public function commitProperties () : void;
		/**
		 *  Fills the list by enumerating the current directory	 *  and setting the dataProvider.
		 */
		function fill () : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		function setDirectory (value:File) : void;
		/**
		 *  @private
		 */
		function setDataProvider (value:Array) : void;
		/**
		 *  @private
		 */
		public function itemToUID (data:Object) : String;
		/**
		 *  @private
		 */
		public function isComputer (f:File) : Boolean;
		/**
		 *  @private
		 */
		private function getRootDirectories () : Array;
		/**
		 *  @private
		 */
		public function fileIconFunction (item:File) : Class;
		/**
		 *  @private
		 */
		public function fileLabelFunction (item:File, column:DataGridColumn = null) : String;
		/**
		 *  @private
		 */
		public function findIndex (nativePath:String) : int;
		/**
		 *  @private
		 */
		public function findItem (nativePath:String) : File;
		/**
		 *  @private	 *  This method is called whenever something happens	 *  that affects which items are displayed by the	 *  control, or the order in which they are displayed.
		 */
		function itemsChanged () : void;
		/**
		 *  @private
		 */
		private function rebuildEnumerationInfo () : void;
		/**
		 *  @private
		 */
		private function addItemToEnumerationInfo (index:int, item:File) : void;
		/**
		 *  @private
		 */
		private function enumerateItems (itemCallback:Function) : int;
		/**
		 *  @private
		 */
		private function enumerate (items:ArrayCollection, index:int, itemCallback:Function) : int;
		/**
		 *  @private
		 */
		public function navigateDown () : void;
		/**
		 *  @private
		 */
		public function navigateUp () : void;
		/**
		 *  @private
		 */
		public function navigateBack (index:int = 0) : void;
		/**
		 *  @private
		 */
		public function navigateForward (index:int = 0) : void;
		/**
		 *  @private
		 */
		private function navigateBy (n:int) : void;
		/**
		 *  @private
		 */
		public function navigateTo (directory:File) : void;
		/**
		 *  @private
		 */
		public function refresh () : void;
		/**
		 *  @private
		 */
		private function getOpenPaths () : Array;
		/**
		 *  @private	 *  Returns an Array of nativePath Strings for the selected items.	 *  This method is called by refresh() before repopulating the control.
		 */
		private function getSelectedPaths () : Array;
		/**
		 *  @private	 *  Returns the nativePath of the first visible item.	 *  This method is called by refresh() before repopulating the control.
		 */
		private function getFirstVisiblePath () : String;
		/**
		 *  @private
		 */
		private function setOpenPaths (openPaths:Array) : void;
		/**
		 *  @private	 *  Selects items whose nativePaths are in the specified Array.	 *  This method is called by refresh() after repopulating the control.
		 */
		private function setSelectedPaths (selectedPaths:Array) : void;
		/**
		 *  @private	 *  Scrolls the list to the item with the specified nativePath.	 *  This method is by refresh() after repopulating the control.
		 */
		private function setFirstVisiblePath (path:String) : Boolean;
		/**
		 *  @private
		 */
		public function clear () : void;
		/**
		 *  @private
		 */
		public function resetHistory (directory:File) : void;
		/**
		 *  @private
		 */
		private function pushHistory (directory:File) : void;
		/**
		 *  @private	 *  Returns an Array of File objects	 *  representing the path to the specified directory.	 *  The first File represents a root directory.	 *  The last File represents the specified file's parent directory.
		 */
		public function getParentChain (file:File) : Array;
		/**
		 *  @private	 *  Dispatches a cancelable "directoryChanging" event	 *  and returns true if it wasn't canceled.
		 */
		function dispatchDirectoryChangingEvent (newDirectory:File) : Boolean;
		/**
		 *  @private	 *  Dispatches a "fileChoose" event.
		 */
		function dispatchFileChooseEvent (file:File) : void;
		/**
		 *  @private
		 */
		private function getBackDirectory () : File;
		/**
		 *  @private
		 */
		private function getForwardDirectory () : File;
		/**
		 *  @private
		 */
		private function updateCompleteHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		public function itemDoubleClickHandler (event:ListEvent) : void;
		/**
		 *  @private
		 */
		public function handleKeyDown (event:KeyboardEvent) : Boolean;
	}
}
