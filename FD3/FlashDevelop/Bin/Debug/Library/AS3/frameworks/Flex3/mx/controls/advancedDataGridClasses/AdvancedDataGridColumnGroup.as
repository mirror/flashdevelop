/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.advancedDataGridClasses {
	public class AdvancedDataGridColumnGroup extends AdvancedDataGridColumn {
		/**
		 * An Array of AdvancedDataGridColumn instances that define the columns
		 *  of the column group.
		 */
		public var children:Array;
		/**
		 * Specifies whether the child columns can be dragged to reposition them in the group.
		 *  If false, child columns cannot be reordered even if
		 *  the AdvancedDataGridColumn.dragEnabled property is set
		 *  to true for a child column.
		 */
		public var childrenDragEnabled:Boolean = true;
		/**
		 * Constructor.
		 *
		 * @param columnName        <String (default = null)> The name of the field in the data provider
		 *                            associated with the column group, and the text for the header cell of this
		 *                            column.  This is equivalent to setting the dataField
		 *                            and headerText properties.
		 */
		public function AdvancedDataGridColumnGroup(columnName:String = null);
		/**
		 * Returns the data from the data provider for the specified Object.
		 *
		 * @param data              <Object> The data provider element.
		 * @return                  <*> The data from the data provider for the specified Object.
		 */
		public function itemToData(data:Object):*;
	}
}
