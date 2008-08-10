/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package mx.controls {
	import flash.filesystem.File;
	public class FileSystemComboBox extends ComboBox {
		/**
		 * A File object representing the directory
		 *  whose ancestors are to be displayed in this control.
		 *  The control displays each ancestor directory
		 *  as a separate entry in the dropdown list.
		 */
		public function get directory():File;
		public function set directory(value:File):void;
		/**
		 * The number of pixels to indent each entry in the dropdown list.
		 */
		public function get indent():int;
		public function set indent(value:int):void;
		/**
		 * A flag that determines whether icons are displayed
		 *  before the directory names in the dropdown list.
		 */
		public function get showIcons():Boolean;
		public function set showIcons(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function FileSystemComboBox();
		/**
		 * A constant that can be used as a value for the directory property,
		 *  representing a pseudo-top level directory named "Computer". This pseudo-directory
		 *  contains the root directories
		 *  (such as C:\ and D:\ on Windows or / on Macintosh).
		 */
		public static const COMPUTER:File;
	}
}
