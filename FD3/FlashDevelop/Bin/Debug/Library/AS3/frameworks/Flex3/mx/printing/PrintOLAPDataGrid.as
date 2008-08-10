/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.printing {
	import mx.controls.OLAPDataGrid;
	public class PrintOLAPDataGrid extends OLAPDataGrid {
		/**
		 * If true, allows some interactions with the control,
		 *  such as column resizing.
		 */
		public function get allowInteraction():Boolean;
		public function set allowInteraction(value:Boolean):void;
		/**
		 * The height that the PrintOLAPDataGrid would be if the sizeToPage
		 *  property is true, meaning that the PrintOLAPDataGrid displays only completely
		 *  viewable rows and displays no partial rows.
		 *  If the sizeToPage property
		 *  is false, the value of this property equals
		 *  the height property.
		 */
		public function get currentPageHeight():Number;
		/**
		 * The height of the PrintOLAPDataGrid as set by the user.
		 *  If the sizeToPage property is false,
		 *  the value of this property equals the height property.
		 */
		public function get originalHeight():Number;
		/**
		 * If true, the PrintOLAPDataGrid readjusts its height to display
		 *  only completely viewable rows.
		 */
		public var sizeToPage:Boolean = true;
		/**
		 * Initializes the PrintOLAPDataGrid control and all of its properties
		 *  from the specified OLAPDataGrid control.
		 */
		public function get source():OLAPDataGrid;
		public function set source(value:OLAPDataGrid):void;
		/**
		 * Indicates that the data provider contains additional data rows that follow
		 *  the rows that the PrintOLAPDataGrid control currently displays.
		 */
		public function get validNextPage():Boolean;
		/**
		 * Indicates that the data provider contains data rows that precede
		 *  the rows that the PrintOLAPDataGrid control currently displays.
		 */
		public function get validPreviousPage():Boolean;
		/**
		 * Constructor.
		 */
		public function PrintOLAPDataGrid();
		/**
		 * Moves to the first page of the PrintOLAPDataGrid control,
		 *  which corresponds to the first set of visible rows.
		 */
		public function moveToFirstPage():void;
		/**
		 * Puts the next set of data rows in view;
		 *  that is, it sets the PrintOLAPDataGrid verticalScrollPosition
		 *  property to equal verticalScrollPosition + (number of scrollable rows).
		 */
		public function nextPage():void;
		/**
		 * Puts the previous set of data rows in view;
		 *  that is, it sets the PrintOLAPDataGrid verticalScrollPosition
		 *  property to equal verticalScrollPosition - (number of rows in the previous page).
		 */
		public function previousPage():void;
	}
}
