/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.menuClasses {
	import mx.controls.Menu;
	public interface IMenuItemRenderer {
		/**
		 * The width of the branch icon
		 */
		public function get measuredBranchIconWidth():Number;
		/**
		 * The width of the icon
		 */
		public function get measuredIconWidth():Number;
		/**
		 * The width of the type icon (radio/check)
		 */
		public function get measuredTypeIconWidth():Number;
		/**
		 * A reference to this menu item renderer's Menu control,
		 *  if it contains one. This would indicate that this menu item
		 *  renderer is a branch node, capable of popping up a sub menu.
		 */
		public function get menu():Menu;
		public function set menu(value:Menu):void;
	}
}
