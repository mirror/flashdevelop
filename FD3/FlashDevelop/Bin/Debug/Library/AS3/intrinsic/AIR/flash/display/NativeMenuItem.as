package flash.display
{
	import flash.events.EventDispatcher;
	import flash.display.NativeMenu;
	import flash.events.KeyboardEvent;
	import flash.display.NativeMenuItem;

	/**
	 * Dispatched by this NativeMenuItem object immediately before the menu containing the item is displayed.
	 * @eventType flash.events.Event.DISPLAYING
	 */
	[Event(name="displaying", type="flash.events.Event")] 

	/**
	 * Dispatched whenever a menu item is selected by the user.
	 * @eventType flash.events.Event.SELECT
	 */
	[Event(name="select", type="flash.events.Event")] 

	/// The NativeMenuItem class represents a single item in a menu.
	public class NativeMenuItem extends EventDispatcher
	{
		/// Controls whether this menu item displays a checkmark.
		public function get checked () : Boolean;
		public function set checked (isChecked:Boolean) : void;

		/// An arbitrary data object associated with this menu item.
		public function get data () : Object;
		public function set data (data:Object) : void;

		/// Controls whether this menu item is enabled.
		public function get enabled () : Boolean;
		public function set enabled (isSeparator:Boolean) : void;

		/// Reports whether this item is a menu separator line.
		public function get isSeparator () : Boolean;

		/// The key equivalent for this menu item.
		public function get keyEquivalent () : String;
		public function set keyEquivalent (keyEquivalent:String) : void;

		/// The array of key codes for the key equivalent modifiers.
		public function get keyEquivalentModifiers () : Array;
		public function set keyEquivalentModifiers (modifiers:Array) : void;

		/// The display string of this menu item.
		public function get label () : String;
		public function set label (label:String) : void;

		/// The menu that contains this item.
		public function get menu () : NativeMenu;

		/// The position of the mnemonic character in the menu item label.
		public function get mnemonicIndex () : int;
		public function set mnemonicIndex (index:int) : void;

		/// The name of this menu item.
		public function get name () : String;
		public function set name (name:String) : void;

		/// The submenu associated with this menu item.
		public function get submenu () : NativeMenu;
		public function set submenu (submenu:NativeMenu) : void;

		/// Creates a copy of the NativeMenuItem object.
		public function clone () : NativeMenuItem;

		/// Creates a new NativeMenuItem object.
		public function NativeMenuItem (label:String = "", isSeparator:Boolean = false);

		/// Returns a string containing all the properties of the NativeMenuItem object.
		public function toString () : String;
	}
}
