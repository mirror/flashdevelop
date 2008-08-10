/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.listClasses {
	public class ListBaseSelectionData {
		/**
		 * If true, then the index property is an approximate value and not the exact value.
		 */
		public var approximate:Boolean;
		/**
		 * The data Object that is selected (selectedItem)
		 */
		public var data:Object;
		/**
		 * The index in the data provider of the selected item. (may be approximate)
		 */
		public var index:int;
		/**
		 * Constructor.
		 *
		 * @param data              <Object> The data Object that is selected
		 * @param index             <int> The index in the data provider of the selected item. (may be approximate)
		 * @param approximate       <Boolean> If true, then the index property is an approximate value and not the exact value.
		 */
		public function ListBaseSelectionData(data:Object, index:int, approximate:Boolean);
	}
}
