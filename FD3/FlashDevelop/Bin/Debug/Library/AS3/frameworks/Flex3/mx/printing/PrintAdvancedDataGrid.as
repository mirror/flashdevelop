/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.printing {
	import mx.controls.AdvancedDataGrid;
	public class PrintAdvancedDataGrid extends AdvancedDataGrid {
		/**
		 * If true, allows some interactions with the control,
		 *  such as column resizing, column reordering, and expanding or collapsing nodes.
		 */
		public function get allowInteraction():Boolean;
		public function set allowInteraction(value:Boolean):void;
		/**
		 * The height that the PrintAdvancedDataGrid would be if the sizeToPage
		 *  property is true, meaning that the PrintAdvancedDataGrid displays only completely
		 *  viewable rows and displays no partial rows.
		 *  If the sizeToPage property
		 *  is false, the value of this property equals
		 *  the height property.
		 */
		public function get currentPageHeight():Number;
		/**
		 * If true, display the folder and leaf icons in the navigation tree.
		 */
		public function get displayIcons():Boolean;
		public function set displayIcons(value:Boolean):void;
		/**
		 * The height of the PrintAdvancedDataGrid as set by the user.
		 *  If the sizeToPage property is false,
		 *  the value of this property equals the height property.
		 */
		public function get originalHeight():Number;
		/**
		 * If true, the PrintAdvancedDataGrid readjusts its height to display
		 *  only completely viewable rows.
		 */
		public var sizeToPage:Boolean = true;
		/**
		 * Initializes the PrintAdvancedDataGrid control and all of its properties
		 *  from the specified AdvancedDataGrid control.
		 */
		public function get source():AdvancedDataGrid;
		public function set source(value:AdvancedDataGrid):void;
		/**
		 * Indicates that the data provider contains additional data rows that follow
		 *  the rows that the PrintAdvancedDataGrid control currently displays.
		 */
		public function get validNextPage():Boolean;
		/**
		 * Indicates that the data provider contains data rows that precede
		 *  the rows that the PrintAdvancedDataGrid control currently displays.
		 */
		public function get validPreviousPage():Boolean;
		/**
		 * Constructor.
		 */
		public function PrintAdvancedDataGrid();
		/**
		 * Moves to the first page of the PrintAdvancedDataGrid control,
		 *  which corresponds to the first set of visible rows.
		 */
		public function moveToFirstPage():void;
		/**
		 * Puts the next set of data rows in view;
		 *  that is, it sets the PrintAdvancedDataGrid verticalScrollPosition
		 *  property to equal verticalScrollPosition + (number of scrollable rows).
		 */
		public function nextPage():void;
		/**
		 * Puts the previous set of data rows in view;
		 *  that is, it sets the PrintAdvancedDataGrid verticalScrollPosition
		 *  property to equal verticalScrollPosition - (number of rows in the previous page).
		 */
		public function previousPage():void;
	}
}
