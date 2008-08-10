/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.advancedDataGridClasses {
	public class AdvancedDataGridRendererDescription {
		/**
		 * Specifies the number of columns that the item renderer spans.
		 *  The AdvancedDataGrid control uses this information to set the width
		 *  of the item renderer.
		 *  If the columnSpan property has value of 0,
		 *  the item renderer spans the entire row.
		 */
		public var columnSpan:int;
		/**
		 * The item renderer factory.
		 */
		public var renderer:IFactory;
		/**
		 * Specifies the number of rows that the item renderer spans.
		 *  The AdvancedDataGrid control uses this information
		 *  to set the height of the item renderer.
		 */
		public var rowSpan:int;
		/**
		 * Constructor.
		 */
		public function AdvancedDataGridRendererDescription();
	}
}
