/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.dataGridClasses {
	import mx.controls.listClasses.BaseListData;
	import mx.core.IUIComponent;
	public class DataGridListData extends BaseListData {
		/**
		 * Name of the field or property in the data provider associated with the column.
		 */
		public var dataField:String;
		/**
		 * Constructor.
		 *
		 * @param text              <String> Text representation of the item data.
		 * @param dataField         <String> Name of the field or property
		 *                            in the data provider associated with the column.
		 * @param columnIndex       <int> The column index of the item in the
		 *                            columns for the DataGrid control.
		 * @param uid               <String> A unique identifier for the item.
		 * @param owner             <IUIComponent> A reference to the DataGrid control.
		 * @param rowIndex          <int (default = 0)> The index of the item in the data provider
		 *                            for the DataGrid control.
		 */
		public function DataGridListData(text:String, dataField:String, columnIndex:int, uid:String, owner:IUIComponent, rowIndex:int = 0);
	}
}
