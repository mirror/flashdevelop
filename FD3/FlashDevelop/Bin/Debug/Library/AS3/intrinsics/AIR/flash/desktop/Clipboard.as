package flash.desktop
{
	/// The Clipboard class provides a container for transferring data and objects through the clipboard and through drag-and-drop operations (AIR only).
	public class Clipboard
	{
		/// [AIR] The operating system clipboard.
		public var generalClipboard:flash.desktop.Clipboard;

		/// [AIR] An array of strings containing the names of the data formats available in this Clipboard object.
		public var formats:Array;

		/// [AIR] Creates an empty Clipboard object.
		public function Clipboard();

		/// [AIR] Deletes all data representations from this Clipboard object.
		public function clear():void;

		/// [AIR] Deletes the data representation for the specified format.
		public function clearData(format:String):void;

		/// [AIR] Adds a representation of the information to be transferred in the specified data format.
		public function setData(format:String, data:Object, serializable:Boolean=true):Boolean;

		/// [AIR] Adds a reference to a handler function that produces the data for the specified format on demand.
		public function setDataHandler(format:String, handler:Function, serializable:Boolean=true):Boolean;

		/// [AIR] Gets the clipboard data if data in the specified format is present.
		public function getData(format:String, transferMode:String=originalPreferred):Object;

		/// [FP10] Checks whether data in the specified format exists in this Clipboard object.
		public function hasFormat(format:String):Boolean;

	}

}

