/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.advancedDataGridClasses {
	public class AdvancedDataGridRendererProvider implements IAdvancedDataGridRendererProvider {
		/**
		 * The id of the column for which the renderer is used.
		 *  If you omit this property,
		 *  you can use the columnIndex property to specify the column.
		 */
		public var column:AdvancedDataGridColumn;
		/**
		 * The column index for which the renderer is used,
		 *  where the first column is at an index of 0.
		 */
		public var columnIndex:int = -1;
		/**
		 * Specifies how many columns the renderer should span.
		 *  Set this property to 0 to span all columns.
		 *  The AdvancedDataGrid control uses this information to set the width
		 *  of the item renderer.
		 */
		public var columnSpan:int = 1;
		/**
		 * The data field in the data provider for the renderer.
		 *  This property is optional.
		 */
		public var dataField:String;
		/**
		 * Depth in the tree at which the renderer is used,
		 *  where the top-most node of the tree is at a depth of 1.
		 *  Use this property if the renderer should only be used when the tree
		 *  is expanded to a certain depth, but not for all nodes in the tree.
		 *  By default, the control uses the renderer for all levels of the tree.
		 */
		public var depth:int = -1;
		/**
		 * The ItemRenderer IFactory used to create an instance of the item renderer.
		 */
		public var renderer:IFactory;
		/**
		 * Specifies how many rows the renderer should span.
		 *  The AdvancedDataGrid control uses this information to set the height of the renderer.
		 */
		public var rowSpan:int = 1;
		/**
		 * Constructor
		 */
		public function AdvancedDataGridRendererProvider();
		/**
		 * Updates the AdvancedDataGridRendererDescription instance with information about
		 *  this AdvancedDataGridRendererProvider instance.
		 *
		 * @param data              <Object> The data item to display.
		 * @param dataDepth         <int> The depth of the data item in the AdvancedDataGrid control.
		 * @param column            <AdvancedDataGridColumn> The column associated with the item.
		 * @param description       <AdvancedDataGridRendererDescription> The AdvancedDataGridRendererDescription object populated
		 *                            with the renderer and column span information.
		 */
		public function describeRendererForItem(data:Object, dataDepth:int, column:AdvancedDataGridColumn, description:AdvancedDataGridRendererDescription):void;
	}
}
