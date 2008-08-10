/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.treeClasses {
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.ListBase;
	public class TreeListData extends BaseListData {
		/**
		 * The level of the item in the tree. The top level is 1.
		 */
		public var depth:int;
		/**
		 * A Class representing the disclosure icon for the item in the Tree control.
		 */
		public var disclosureIcon:Class;
		/**
		 * Contains true if the node has children.
		 */
		public var hasChildren:Boolean;
		/**
		 * A Class representing the icon for the item in the Tree control.
		 */
		public var icon:Class;
		/**
		 * The default indentation for this row of the Tree control.
		 */
		public var indent:int;
		/**
		 * The data for this item in the Tree control.
		 */
		public var item:Object;
		/**
		 * Contains true if the node is open.
		 */
		public var open:Boolean;
		/**
		 * Constructor.
		 *
		 * @param text              <String> Text representation of the item data.
		 * @param uid               <String> A unique identifier for the item.
		 * @param owner             <ListBase> A reference to the Tree control.
		 * @param rowIndex          <int (default = 0)> The index of the item in the data provider for the Tree control.
		 * @param columnIndex       <int (default = 0)> The index of the column in the currently visible columns of the
		 *                            control.
		 */
		public function TreeListData(text:String, uid:String, owner:ListBase, rowIndex:int = 0, columnIndex:int = 0);
	}
}
