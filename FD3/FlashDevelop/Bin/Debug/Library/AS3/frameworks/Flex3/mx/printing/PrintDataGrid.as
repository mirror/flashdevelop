/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.printing {
	import mx.controls.DataGrid;
	public class PrintDataGrid extends DataGrid {
		/**
		 * The height of PrintDataGrid that would be, if sizeToPage
		 *  property is true and PrintDataGrid displays only completely
		 *  viewable rows and no partial rows. If sizeToPage property
		 *  is true, the value of this property equals
		 *  the height property.
		 */
		public function get currentPageHeight():Number;
		/**
		 * The height of PrintDataGrid as set by the user.
		 *  If the sizeToPage property is false,
		 *  the value of this property equals the height property.
		 */
		public function get originalHeight():Number;
		/**
		 * If true, the PrintDataGrid readjusts its height to display
		 *  only completely viewable rows.
		 */
		public var sizeToPage:Boolean = true;
		/**
		 * Indicates the data provider contains additional data rows that follow
		 *  the rows that the PrintDataGrid control currently displays.
		 */
		public function get validNextPage():Boolean;
		/**
		 * Constructor.
		 */
		public function PrintDataGrid();
		/**
		 * Puts the next set of data rows in view;
		 *  that is, it sets the PrintDataGrid verticalScrollPosition
		 *  property to equal verticalScrollPosition + (number of scrollable rows).
		 */
		public function nextPage():void;
	}
}
