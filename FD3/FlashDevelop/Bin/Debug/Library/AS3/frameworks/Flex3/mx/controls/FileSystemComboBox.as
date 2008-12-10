package mx.controls
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.text.TextLineMetrics;
	import mx.collections.CursorBookmark;
	import mx.controls.ComboBox;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;
	import mx.core.ClassFactory;
	import mx.core.mx_internal;
	import mx.events.FileEvent;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	import flash.display.DisplayObject;
	import flash.filesystem.File;
	import mx.controls.FileSystemComboBox;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;
	import mx.controls.listClasses.ListItemRenderer;
	import mx.core.mx_internal;

	/**
	 *  Dispatched when the selected directory displayed by this control *  changes for any reason. * *  @eventType mx.events.FileEvent.DIRECTORY_CHANGE
	 */
	[Event(name="directoryChange", type="mx.events.FileEvent")] 
	/**
	 *  Specifies the icon that indicates *  the root directories of the computer. *  There is no default icon. *  In MXML, you can use the following syntax to set this property: *  <code>computerIcon="&#64;Embed(source='computerIcon.jpg');"</code> * *  @default null
	 */
	[Style(name="computerIcon", type="Class", format="EmbeddedFile", inherit="no")] 
	/**
	 *  Specifies the icon that indicates a directory. *  The default icon is located in the Assets.swf file. *  In MXML, you can use the following syntax to set this property: *  <code>directoryIcon="&#64;Embed(source='directoryIcon.jpg');"</code> * *  @default TreeNodeIcon
	 */
	[Style(name="directoryIcon", type="Class", format="EmbeddedFile", inherit="no")] 

	/**
	 *  The FileSystemComboBox control defines a combo box control for *  navigating up the chain of ancestor directories from a specified *  directory in a file system. *  You often use this control with the FileSystemList and FileSystemTree *  controls to change the current directory displayed by those controls. * *  <p>Unlike the standard ComboBox control, to populate the FileSystemComboBox control's *  <code>dataProvider</code> property, *  you set the <code>directory</code> property. *  This control then automatically sets the <code>dataProvider</code> *  property to an ArrayCollection of File objects *  that includes all the ancestor directories of the specified directory, *  starting with the <code>COMPUTER</code> File *  and ending with the specified directory.</p> * *  <p>When you select an entry in the dropdown list, *  this control dispatches a <code>change</code> event. *  After the event is dispatched data provider, and consequently the dropdown list, *  contain the selected directory's ancestors.</p> *  *  @mxml * *  <p>The <code>&lt;mx:FileSystemComboBox&gt;</code> tag inherits all of the tag *  attributes of its superclass and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:FileSystemComboBox *    <strong>Properties</strong> *    directory="<i>null</i>" *    indent="8" *    showIcons="true" *  *    <strong>Styles</strong> *    computerIcon="<i>null</i>" *    directoryIcon="<i>TreeNodeIcon</i>" *  *    <strong>Events</strong> *    directoryChange="<i>No default</i>" *  /&gt; *  </pre> *  *  @see flash.filesystem.File *  @see mx.controls.FileSystemList *  @see mx.controls.FileSystemTree *  *  @playerversion AIR 1.1
	 */
	public class FileSystemComboBox extends ComboBox
	{
		/**
		 *  A constant that can be used as a value for the <code>directory</code> property,	 *  representing a pseudo-top level directory named "Computer". This pseudo-directory     *  contains the root directories     *  (such as C:\ and D:\ on Windows or / on Macintosh).
		 */
		public static const COMPUTER : File = FileSystemControlHelper.COMPUTER;
		/**
		 *  @private     *  An undocumented class that implements functionality     *  shared by various file system components.
		 */
		local var helper : FileSystemControlHelper;
		/**
		 *  @private     *  Storage for the directory property.
		 */
		private var _directory : File;
		/**
		 *  @private
		 */
		private var directoryChanged : Boolean;
		/**
		 *  @private     *  Storage for the indent property.
		 */
		private var _indent : int;
		/**
		 *  @private     *  Storage for the showIcons property.
		 */
		private var _showIcons : Boolean;

		/**
		 *  A File object representing the directory     *  whose ancestors are to be displayed in this control.     *  The control displays each ancestor directory     *  as a separate entry in the dropdown list.     *     *  @default null
		 */
		public function get directory () : File;
		/**
		 *  @private
		 */
		public function set directory (value:File) : void;
		/**
		 *  The number of pixels to indent each entry in the dropdown list.     *     *  @default 8
		 */
		public function get indent () : int;
		/**
		 *  @private
		 */
		public function set indent (value:int) : void;
		/**
		 *  A flag that determines whether icons are displayed     *  before the directory names in the dropdown list.     *     *  @default true
		 */
		public function get showIcons () : Boolean;
		/**
		 *  @private
		 */
		public function set showIcons (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function FileSystemComboBox ();
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  @private
		 */
		protected function calculatePreferredSizeFromData (count:int) : Object;
		/**
		 *  @private     *  Returns an Array of File objects     *  representing the path to the specified directory.     *  The first File represents a root directory.     *  The last File represents the specified file's parent directory.
		 */
		private function getParentChain (file:File) : Array;
		/**
		 *  @private     *  When the user chooses a directory along the path,     *  change this control to display the path to that directory.
		 */
		private function changeHandler (event:Event) : void;
	}
	/**
	 *  @private
	 */
	internal class FileSystemComboBoxRenderer extends ListItemRenderer
	{
		/**
		 *  Constructor.
		 */
		public function FileSystemComboBoxRenderer ();
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		private function getNestLevel (item:File) : int;
	}
}
