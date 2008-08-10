/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	public class ToggleButtonBar extends ButtonBar {
		/**
		 * Index of the selected button.
		 *  Indexes are in the range of 0, 1, 2, ..., n - 1,
		 *  where n is the number of buttons.
		 */
		public function get selectedIndex():int;
		public function set selectedIndex(value:int):void;
		/**
		 * Specifies whether the currently selected button can be deselected by
		 *  the user.
		 *  By default, the currently selected button gets deselected
		 *  automatically only when another button in the group is selected.
		 *  Setting this property to true lets the user
		 *  deselect it.
		 *  When the currently selected button is deselected,
		 *  the selectedIndex property is set to -1.
		 */
		public function get toggleOnClick():Boolean;
		public function set toggleOnClick(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function ToggleButtonBar();
	}
}
