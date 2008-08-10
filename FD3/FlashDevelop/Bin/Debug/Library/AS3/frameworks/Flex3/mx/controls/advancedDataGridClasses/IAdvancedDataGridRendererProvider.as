/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.advancedDataGridClasses {
	public interface IAdvancedDataGridRendererProvider {
		/**
		 * Updates the IAdvancedDataGridRendererDescription instance with
		 *  information about this IAdvancedDataGridRendererProvider.
		 *
		 * @param data              <Object> The data item to display.
		 * @param dataDepth         <int> The depth of the data item in the AdvancedDataGrid control.
		 * @param column            <AdvancedDataGridColumn> The column associated with the item.
		 * @param description       <AdvancedDataGridRendererDescription> The AdvancedDataGridRendererDescription object
		 *                            populated with the renderer and column span information.
		 */
		public function describeRendererForItem(data:Object, dataDepth:int, column:AdvancedDataGridColumn, description:AdvancedDataGridRendererDescription):void;
	}
}
