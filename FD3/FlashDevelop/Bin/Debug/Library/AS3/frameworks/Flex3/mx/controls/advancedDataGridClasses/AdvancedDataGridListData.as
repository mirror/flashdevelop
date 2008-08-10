/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.advancedDataGridClasses {
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.core.IUIComponent;
	public class AdvancedDataGridListData extends DataGridListData {
		/**
		 * The level of the item in the AdvancedDataGrid control. The top level is 1.
		 */
		public var depth:int;
		/**
		 * A Class representing the disclosure icon for the item in the AdvancedDataGrid control.
		 */
		public var disclosureIcon:Class;
		/**
		 * Contains true if the item has children.
		 */
		public var hasChildren:Boolean;
		/**
		 * A Class representing the icon for the item in the AdvancedDataGrid control.
		 */
		public var icon:Class;
		/**
		 * The default indentation for this row of the AdvancedDataGrid control.
		 */
		public var indent:int;
		/**
		 * The data for this item in the AdvancedDataGrid control.
		 */
		public var item:Object;
		/**
		 * Contains true if the item is open and it has children.
		 */
		public var open:Boolean;
		/**
		 * Constructor.
		 *
		 * @param text              <String> Text representation of the item data.
		 * @param dataField         <String> Name of the field or property
		 *                            in the data provider associated with the column.
		 * @param columnIndex       <int> A unique identifier for the item.
		 * @param uid               <String> A reference to the AdvancedDataGrid control.
		 * @param owner             <IUIComponent> The index of the item in the data provider for the AdvancedDataGrid control.
		 * @param rowIndex          <int (default = 0)> The index of the column in the currently visible columns of the
		 *                            control.
		 */
		public function AdvancedDataGridListData(text:String, dataField:String, columnIndex:int, uid:String, owner:IUIComponent, rowIndex:int = 0);
	}
}
