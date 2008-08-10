/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.desktop {
	public class Clipboard {
		/**
		 * An array of strings containing the names of the data formats available
		 *  in this Clipboard object.
		 */
		public function get formats():Array;
		/**
		 * The operating system clipboard.
		 */
		public static function get generalClipboard():Clipboard;
		/**
		 * Creates an empty Clipboard object.
		 */
		public function Clipboard();
		/**
		 * Deletes all data representations from this Clipboard object.
		 */
		public function clear():void;
		/**
		 * Deletes the data representation for the specified format.
		 *
		 * @param format            <String> The data format to remove.
		 */
		public function clearData(format:String):void;
		/**
		 * Gets the clipboard data if data in the specified format is present.
		 *
		 * @param format            <String> The data format to return. The format string can contain one of the standard
		 *                            names defined in the ClipboardFormats class, or an application-defined name.
		 * @param transferMode      <String (default = NaN)> Specifies whether to return a reference or serialized copy
		 *                            when an application-defined data format is accessed. The value must be one
		 *                            of the names defined in the ClipboardTransferMode class. This value is
		 *                            ignored for the standard data formats.
		 * @return                  <Object> An object of the type corresponding to the data format.
		 */
		public function getData(format:String, transferMode:String):Object;
		/**
		 * Checks whether data in the specified format exists in this Clipboard object.
		 *
		 * @param format            <String> The format type to check.
		 * @return                  <Boolean> true, if data in the specified format is present.
		 */
		public function hasFormat(format:String):Boolean;
		/**
		 * Adds a representation of the information to be transferred in the specified data format.
		 *
		 * @param format            <String> The information to add.
		 * @param data              <Object> The format of the data.
		 * @param serializable      <Boolean (default = true)> Specify true for objects that can be serialized (and deserialized).
		 * @return                  <Boolean> true if the data was succesfully set;
		 *                            false otherwise.
		 */
		public function setData(format:String, data:Object, serializable:Boolean = true):Boolean;
		/**
		 * Adds a reference to a handler function that produces the data for the specified format on demand.
		 *  Use this method to defer creation or rendering of the data until it is actually accessed.
		 *
		 * @param format            <String> A function that returns the data to be tranfered when called.
		 * @param handler           <Function> The format of the data.
		 * @param serializable      <Boolean (default = true)> Specify true if the object returned by handler
		 *                            can be serialized (and deserialized).
		 * @return                  <Boolean> true if the handler was succesfully set;
		 *                            false otherwise.
		 */
		public function setDataHandler(format:String, handler:Function, serializable:Boolean = true):Boolean;
	}
}
