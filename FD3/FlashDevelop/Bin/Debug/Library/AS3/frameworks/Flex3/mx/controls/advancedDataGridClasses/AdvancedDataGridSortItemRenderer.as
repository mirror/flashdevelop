/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.advancedDataGridClasses {
	import mx.core.UIComponent;
	import mx.controls.AdvancedDataGrid;
	public class AdvancedDataGridSortItemRenderer extends UIComponent {
		/**
		 * Returns a reference to the associated AdvancedDataGrid control.
		 */
		protected function get grid():AdvancedDataGrid;
		/**
		 * The internal UITextField object that renders the label of this Button.
		 */
		protected var label:IUITextField;
		/**
		 * Constructor
		 */
		public function AdvancedDataGridSortItemRenderer();
		/**
		 * Returns the sort information for this column from the AdvancedDataGrid control
		 *  so that the control can display the column's number in the sort sequence,
		 *  and whether the sort is ascending or descending.
		 *  The sorting information is represented by an instance of the SortInfo class,
		 *  where each column in the AdvancedDataGrid control has an associated
		 *  SortInfo instance.
		 *
		 * @return                  <SortInfo> A SortInfo instance.
		 */
		protected function getFieldSortInfo():SortInfo;
		/**
		 * Gets font styles from the AdvancedDataGrid control
		 *  and uses them to initialize the corresponding font styles for this render.
		 *  The font styles accessed in the AdvancedDataGrid control include
		 *  sortFontFamily, sortFontSize, sortFontStyle,
		 *  and sortFontWeight.
		 */
		protected function getFontStyles():void;
	}
}
