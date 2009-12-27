package mx.controls.treeClasses
{
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.ListBase;

include "../../core/Version.as"
	/**
	 *  The TreeListData class defines the data type of the <code>listData</code> property 
 *  implemented by drop-in item renderers or drop-in item editors for the Tree control. 
 *  All drop-in item renderers and drop-in item editors must implement the 
 *  IDropInListItemRenderer interface, which defines the <code>listData</code> property.
 *
 *  <p>While the properties of this class are writable, you should considered them to 
 *  be read only. They are initialized by the Tree class, and read by an item renderer 
 *  or item editor. Changing these values can lead to unexpected results.</p>
 *
 *  @see mx.controls.listClasses.IDropInListItemRenderer
	 */
	public class TreeListData extends BaseListData
	{
		/**
		 *  The level of the item in the tree. The top level is 1.
		 */
		public var depth : int;
		/**
		 *  A Class representing the disclosure icon for the item in the Tree control.
		 */
		public var disclosureIcon : Class;
		/**
		 *  Contains <code>true</code> if the node has children.
		 */
		public var hasChildren : Boolean;
		/**
		 *  A Class representing the icon for the item in the Tree control.
		 */
		public var icon : Class;
		/**
		 *  The default indentation for this row of the Tree control.
		 */
		public var indent : int;
		/**
		 *  The data for this item in the Tree control.
		 */
		public var item : Object;
		/**
		 *  Contains <code>true</code> if the node is open.
		 */
		public var open : Boolean;

		/**
		 *  Constructor.
	 *
	 *  @param text Text representation of the item data.
	 *
	 *  @param uid A unique identifier for the item.
	 *
	 *  @param owner A reference to the Tree control.
	 *
	 *  @param rowIndex The index of the item in the data provider for the Tree control.
	 * 
	 *  @param columnIndex The index of the column in the currently visible columns of the 
     *  control.
	 *
		 */
		public function TreeListData (text:String, uid:String, owner:ListBase, rowIndex:int = 0, columnIndex:int = 0);
	}
}
