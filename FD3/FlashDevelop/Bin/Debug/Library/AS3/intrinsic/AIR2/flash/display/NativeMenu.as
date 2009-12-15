package flash.display
{
	import flash.events.EventDispatcher;
	import flash.display.Stage;
	import flash.display.NativeMenuItem;
	import flash.display.NativeMenu;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	/**
	 * Dispatched by this NativeMenu object immediately before the menu is to be displayed.
	 * @eventType flash.events.Event.DISPLAYING
	 */
	[Event(name="displaying", type="flash.events.Event")] 

	/**
	 * Dispatched by this NativeMenu object when one of its menu items or an item in one of its descendant submenus is selected.
	 * @eventType flash.events.Event.SELECT
	 */
	[Event(name="select", type="flash.events.Event")] 

	/// The NativeMenu class contains methods and properties for defining menus.
	public class NativeMenu extends EventDispatcher
	{
		/// The array of NativeMenuItem objects in this menu.
		public function get items () : Array;
		public function set items (itemArray:Array) : void;

		/// The number of NativeMenuItem objects in this menu.
		public function get numItems () : int;

		/// The parent menu.
		public function get parent () : NativeMenu;

		/// Adds a menu item at the bottom of the menu.
		public function addItem (item:NativeMenuItem) : NativeMenuItem;

		/// Inserts a menu item at the specified position.
		public function addItemAt (item:NativeMenuItem, index:int) : NativeMenuItem;

		/// Adds a submenu to the menu by inserting a new menu item.
		public function addSubmenu (submenu:NativeMenu, label:String) : NativeMenuItem;

		/// Adds a submenu to the menu by inserting a new menu item at the specified position.
		public function addSubmenuAt (submenu:NativeMenu, index:int, label:String) : NativeMenuItem;

		/// Creates a copy of the menu and all items.
		public function clone () : NativeMenu;

		/// Reports whether this menu contains the specified menu item.
		public function containsItem (item:NativeMenuItem) : Boolean;

		public function dispatchContextMenuSelect (event:MouseEvent) : *;

		/// Pops up this menu at the specified location.
		public function display (stage:Stage, stageX:Number, stageY:Number) : void;

		/// Gets the menu item at the specified index.
		public function getItemAt (index:int) : NativeMenuItem;

		/// Gets the menu item with the specified name.
		public function getItemByName (name:String) : NativeMenuItem;

		/// Gets the position of the specified item.
		public function getItemIndex (item:NativeMenuItem) : int;

		public function NativeMenu ();

		/// Removes all items fromt the menu.
		public function removeAllItems () : void;

		/// Removes the specified menu item.
		public function removeItem (item:NativeMenuItem) : NativeMenuItem;

		/// Removes and returns the menu item at the specified index.
		public function removeItemAt (index:int) : NativeMenuItem;

		/// Moves a menu item to the specified position.
		public function setItemIndex (item:NativeMenuItem, index:int) : void;
	}
}
