/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.display {
	import flash.events.EventDispatcher;
	public class NativeMenu extends EventDispatcher {
		/**
		 * The array of NativeMenuItem objects in this menu.
		 */
		public function get items():Array;
		/**
		 * The number of NativeMenuItem objects in this menu.
		 */
		public function get numItems():int;
		/**
		 * The parent menu.
		 */
		public function get parent():NativeMenu;
		/**
		 * Adds a menu item at the bottom of the menu.
		 *
		 * @param item              <NativeMenuItem> The NativeMenuItem object to add at the bottom of the menu.
		 */
		public function addItem(item:NativeMenuItem):NativeMenuItem;
		/**
		 * Inserts a menu item at the specified position.
		 *
		 * @param item              <NativeMenuItem> The NativeMenuItem object to insert.
		 * @param index             <int> The (zero-based) position in menu
		 *                            at which to insert the menu item.
		 */
		public function addItemAt(item:NativeMenuItem, index:int):NativeMenuItem;
		/**
		 * Adds a submenu to the menu by inserting a new menu item.
		 *
		 * @param submenu           <NativeMenu> The NativeMenu object that defines the submenu to be added.
		 * @param label             <String> The display label for the menu item to be added.
		 * @return                  <NativeMenuItem> The NativeMenuItem object created for the submenu.
		 */
		public function addSubmenu(submenu:NativeMenu, label:String):NativeMenuItem;
		/**
		 * Adds a submenu to the menu by inserting a new menu item at the
		 *  specified position.
		 *
		 * @param submenu           <NativeMenu> The NativeMenu object that defines the submenu to be added.
		 * @param index             <int> The position in the items array of this
		 *                            menu at which to insert the menu item to be added.
		 * @param label             <String> The display label for the menu item to be added.
		 * @return                  <NativeMenuItem> The NativeMenuItem object created for the submenu.
		 */
		public function addSubmenuAt(submenu:NativeMenu, index:int, label:String):NativeMenuItem;
		/**
		 * Creates a copy of the menu and all items.
		 */
		public function clone():NativeMenu;
		/**
		 * Reports whether this menu contains the specified menu item.
		 *
		 * @param item              <NativeMenuItem> The NativeMenuItem object to look up.
		 * @return                  <Boolean> true if item is in this menu.
		 */
		public function containsItem(item:NativeMenuItem):Boolean;
		/**
		 * Pops up this menu at the specified location.
		 *
		 * @param stage             <Stage> The Stage object on which to display this menu.
		 * @param stageX            <Number> The number of horizontal pixels, relative to the origin
		 *                            of stage, at which to display this menu.
		 * @param stageY            <Number> The number of vertical pixels, relative to the origin
		 *                            of stage, at which to display this menu.
		 */
		public function display(stage:Stage, stageX:Number, stageY:Number):void;
		/**
		 * Gets the menu item at the specified index.
		 *
		 * @param index             <int> The (zero-based) position of the item to return.
		 * @return                  <NativeMenuItem> The NativeMenuItem object at the specified position in the menu.
		 */
		public function getItemAt(index:int):NativeMenuItem;
		/**
		 * Gets the menu item with the specified name.
		 *
		 * @param name              <String> The string to look up.
		 * @return                  <NativeMenuItem> The NativeMenuItem object with the specified name or
		 *                            null, if no such item exists in the menu.
		 */
		public function getItemByName(name:String):NativeMenuItem;
		/**
		 * Gets the position of the specified item.
		 *
		 * @param item              <NativeMenuItem> The NativeMenuItem object to look up.
		 * @return                  <int> The (zero-based) position of the specified item in this menu
		 *                            or null, if the item is not in this menu.
		 */
		public function getItemIndex(item:NativeMenuItem):int;
		/**
		 * Removes the specified menu item.
		 *
		 * @param item              <NativeMenuItem> The NativeMenuItem object to remove from this menu.
		 */
		public function removeItem(item:NativeMenuItem):NativeMenuItem;
		/**
		 * Removes and returns the menu item at the specified index.
		 *
		 * @param index             <int> The (zero-based) position of the item to remove.
		 * @return                  <NativeMenuItem> The NativeMenuItem object removed.
		 */
		public function removeItemAt(index:int):NativeMenuItem;
		/**
		 * Moves a menu item to the specified position.
		 *
		 * @param item              <NativeMenuItem> The NativeMenuItem object to move.
		 * @param index             <int> The (zero-based) position in the menu to which to move the
		 *                            item.
		 */
		public function setItemIndex(item:NativeMenuItem, index:int):void;
	}
}
