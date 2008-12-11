package flash.display
{
	/// The NativeMenu class contains methods and properties for defining menus.
	public class NativeMenu extends flash.events.EventDispatcher
	{
		/** 
		 * [AIR] Dispatched by this NativeMenu object immediately before the menu is to be displayed.
		 * @eventType flash.events.Event.DISPLAYING
		 */
		[Event(name="displaying", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched by this NativeMenu object when one of its menu items or an item in one of its descendant submenus is selected.
		 * @eventType flash.events.Event.SELECT
		 */
		[Event(name="select", type="flash.events.Event")]

		/// [AIR] The parent menu.
		public var parent:flash.display.NativeMenu;

		/// [AIR] The number of NativeMenuItem objects in this menu.
		public var numItems:int;

		/// [AIR] The array of NativeMenuItem objects in this menu.
		public var items:Array;

		/// [AIR] Adds a menu item at the bottom of the menu.
		public function addItem(item:flash.display.NativeMenuItem):flash.display.NativeMenuItem;

		/// [AIR] Inserts a menu item at the specified position.
		public function addItemAt(item:flash.display.NativeMenuItem, index:int):flash.display.NativeMenuItem;

		/// [AIR] Reports whether this menu contains the specified menu item.
		public function containsItem(item:flash.display.NativeMenuItem):Boolean;

		/// [AIR] Gets the menu item at the specified index.
		public function getItemAt(index:int):flash.display.NativeMenuItem;

		/// [AIR] Gets the menu item with the specified name.
		public function getItemByName(name:String):flash.display.NativeMenuItem;

		/// [AIR] Removes the specified menu item.
		public function removeItem(item:flash.display.NativeMenuItem):flash.display.NativeMenuItem;

		/// [AIR] Removes and returns the menu item at the specified index.
		public function removeItemAt(index:int):flash.display.NativeMenuItem;

		/// [AIR] Removes all items fromt the menu.
		public function removeAllItems():void;

		/// [AIR] Gets the position of the specified item.
		public function getItemIndex(item:flash.display.NativeMenuItem):int;

		/// [AIR] Moves a menu item to the specified position.
		public function setItemIndex(item:flash.display.NativeMenuItem, index:int):void;

		/// [AIR] Adds a submenu to the menu by inserting a new menu item at the specified position.
		public function addSubmenuAt(submenu:flash.display.NativeMenu, index:int, label:String):flash.display.NativeMenuItem;

		/// [AIR] Adds a submenu to the menu by inserting a new menu item.
		public function addSubmenu(submenu:flash.display.NativeMenu, label:String):flash.display.NativeMenuItem;

		/// [AIR] Pops up this menu at the specified location.
		public function display(stage:flash.display.Stage, stageX:Number, stageY:Number):void;

		/// [AIR] Creates a copy of the menu and all items.
		public function clone():flash.display.NativeMenu;

	}

}

