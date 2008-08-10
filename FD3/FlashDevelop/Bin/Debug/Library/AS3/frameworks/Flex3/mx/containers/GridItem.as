/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers {
	public class GridItem extends HBox {
		/**
		 * Number of columns of the Grid container spanned by the cell.
		 */
		public function get colSpan():int;
		public function set colSpan(value:int):void;
		/**
		 * Number of rows of the Grid container spanned by the cell.
		 *  You cannot extend a cell past the number of rows in the Grid.
		 */
		public function get rowSpan():int;
		public function set rowSpan(value:int):void;
		/**
		 * Constructor.
		 */
		public function GridItem();
	}
}
