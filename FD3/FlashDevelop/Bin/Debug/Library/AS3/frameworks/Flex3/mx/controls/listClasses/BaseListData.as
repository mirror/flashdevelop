/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.listClasses {
	import mx.core.IUIComponent;
	public class BaseListData {
		/**
		 * The index of the column of the List-based control relative
		 *  to the currently visible columns of the control, where the first column
		 *  is at an index of 1.
		 */
		public var columnIndex:int;
		/**
		 * The textual representation of the item data, based on the list class's
		 *  itemToLabel() method.
		 */
		public var label:String;
		/**
		 * A reference to the list object that owns this item.
		 *  This should be a ListBase-derived class.
		 *  This property is typed as IUIComponent so that drop-ins
		 *  like Label and TextInput don't have to have dependencies
		 *  on List and all of its dependencies.
		 */
		public var owner:IUIComponent;
		/**
		 * The index of the row of the DataGrid, List, or Tree control relative
		 *  to the currently visible rows of the control, where the first row
		 *  is at an index of 1.
		 *  For example, you click on an item in the control and rowIndex
		 *  is set to 3.
		 *  You then scroll the control to change the row's position in the visible rows
		 *  of the control, and then click on the same row as before.
		 *  The rowIndex now contains a different value corresponding to
		 *  the new index of the row in the currently visible rows.
		 */
		public var rowIndex:int;
		/**
		 * The unique identifier for this item.
		 */
		public function get uid():String;
		public function set uid(value:String):void;
		/**
		 * Constructor.
		 *
		 * @param label             <String> The textual representation of the item data.
		 * @param uid               <String> A unique identifier.
		 * @param owner             <IUIComponent> A reference to the list control.
		 * @param rowIndex          <int (default = 0)> The index of the row in the currently visible rows of the control.
		 * @param columnIndex       <int (default = 0)> The index of the column in the currently visible columns of the
		 *                            control.
		 */
		public function BaseListData(label:String, uid:String, owner:IUIComponent, rowIndex:int = 0, columnIndex:int = 0);
	}
}
