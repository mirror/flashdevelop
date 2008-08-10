/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public class DragSource {
		/**
		 * Contains the formats of the drag data, as an Array of Strings.
		 *  Set this property using the addData()
		 *  or addHandler() methods.
		 *  The default value depends on data added to the DragSource object.
		 */
		public function get formats():Array;
		/**
		 * Constructor.
		 */
		public function DragSource();
		/**
		 * Adds data and a corresponding format String to the drag source.
		 *  This method does not return a value.
		 *
		 * @param data              <Object> Object that specifies the drag data.
		 *                            This can be any object, such as a String, a DataProvider, and so on.
		 * @param format            <String> String that specifies a label that describes
		 *                            the format for this data.
		 */
		public function addData(data:Object, format:String):void;
		/**
		 * Adds a handler that is called when data
		 *  for the specified format is requested.
		 *  This is useful when dragging large amounts of data.
		 *  The handler is only called if the data is requested.
		 *  This method does not return a value.
		 *
		 * @param handler           <Function> Function that specifies the handler
		 *                            called to request the data.
		 *                            This function must return the data in the specified format.
		 * @param format            <String> String that specifies the format for this data.
		 */
		public function addHandler(handler:Function, format:String):void;
		/**
		 * Retrieves the data for the specified format.
		 *  If the data was added with the addData() method,
		 *  it is returned directly.
		 *  If the data was added with the addHandler() method,
		 *  the handler function is called to return the data.
		 *
		 * @param format            <String> String that specifies a label that describes
		 *                            the format for the data to return.
		 * @return                  <Object> An Object
		 *                            containing the data in the requested format.
		 *                            If you drag multiple items, the returned value is an Array.
		 *                            For a list control, the returned value is always an Array,
		 *                            even if it contains a single item.
		 */
		public function dataForFormat(format:String):Object;
		/**
		 * Returns true if the data source contains
		 *  the requested format; otherwise, it returns false.
		 *
		 * @param format            <String> String that specifies a label that describes the format
		 *                            for the data.
		 * @return                  <Boolean> true if the data source contains
		 *                            the requested format.
		 */
		public function hasFormat(format:String):Boolean;
	}
}
