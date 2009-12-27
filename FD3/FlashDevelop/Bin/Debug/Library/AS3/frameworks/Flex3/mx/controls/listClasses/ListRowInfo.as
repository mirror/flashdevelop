package mx.controls.listClasses
{
include "../../core/Version.as"
	/**
	 *  Used by the list-based classes to store information about their IListItemRenderers.
 *
 *  @see mx.controls.listClasses.ListBase#rowInfo
	 */
	public class ListRowInfo
	{
		/**
		 *  The item in the dataprovider.
		 */
		public var data : Object;
		/**
		 *  The height of the row including margins.
		 */
		public var height : Number;
		/**
		 *  The last Y value for the renderer.
	 *  Used in Tree's open/close effects.
		 */
		public var itemOldY : Number;
		/**
		 *  The last Y value for the row.
	 *  Used in Tree's open/close effects.
		 */
		public var oldY : Number;
		/**
		 *  The unique identifier of the item in the dataProvider
		 */
		public var uid : String;
		/**
		 *  The y-position value for the row.
		 */
		public var y : Number;

		/**
		 *  Constructor.
	 *
	 *  @param y The y-position value for the row.
	 *
	 *  @param height The height of the row including margins.
	 *
	 *  @param uid The unique identifier of the item in the dataProvider
	 *
	 *  @param data The item in the dataprovider.
		 */
		public function ListRowInfo (y:Number, height:Number, uid:String, data:Object = null);
	}
}
