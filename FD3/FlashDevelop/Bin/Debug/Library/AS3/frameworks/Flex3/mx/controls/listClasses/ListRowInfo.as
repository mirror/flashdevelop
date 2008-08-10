/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.listClasses {
	public class ListRowInfo {
		/**
		 * The item in the dataprovider.
		 */
		public var data:Object;
		/**
		 * The height of the row including margins.
		 */
		public var height:Number;
		/**
		 * The last Y value for the renderer.
		 *  Used in Tree's open/close effects.
		 */
		public var itemOldY:Number;
		/**
		 * The last Y value for the row.
		 *  Used in Tree's open/close effects.
		 */
		public var oldY:Number;
		/**
		 * The unique identifier of the item in the dataProvider
		 */
		public var uid:String;
		/**
		 * The y-position value for the row.
		 */
		public var y:Number;
		/**
		 * Constructor.
		 *
		 * @param y                 <Number> The y-position value for the row.
		 * @param height            <Number> The height of the row including margins.
		 * @param uid               <String> The unique identifier of the item in the dataProvider
		 * @param data              <Object (default = null)> The item in the dataprovider.
		 */
		public function ListRowInfo(y:Number, height:Number, uid:String, data:Object = null);
	}
}
