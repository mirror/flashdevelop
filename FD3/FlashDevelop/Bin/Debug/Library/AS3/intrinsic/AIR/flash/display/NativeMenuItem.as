package flash.display
{
	/// The NativeMenuItem class represents a single item in a menu.
	public class NativeMenuItem extends flash.events.EventDispatcher
	{
		/** 
		 * [AIR] Dispatched by this NativeMenuItem object immediately before the menu containing the item is displayed.
		 * @eventType flash.events.Event.DISPLAYING
		 */
		[Event(name="displaying", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched whenever a menu item is selected by the user.
		 * @eventType flash.events.Event.SELECT
		 */
		[Event(name="select", type="flash.events.Event")]

		/// [AIR] The menu that contains this item.
		public var menu:flash.display.NativeMenu;

		/// [AIR] The name of this menu item.
		public var name:String;

		/// [AIR] Reports whether this item is a menu separator line.
		public var isSeparator:Boolean;

		/// [AIR] Controls whether this menu item is enabled.
		public var enabled:Boolean;

		/// [AIR] Controls whether this menu item displays a checkmark.
		public var checked:Boolean;

		/// [AIR] The display string of this menu item.
		public var label:String;

		/// [AIR] The key equivalent for this menu item.
		public var keyEquivalent:String;

		/// [AIR] The array of key codes for the key equivalent modifiers.
		public var keyEquivalentModifiers:Array;

		/// [AIR] The position of the mnemonic character in the menu item label.
		public var mnemonicIndex:int;

		/// [AIR] The submenu associated with this menu item.
		public var submenu:flash.display.NativeMenu;

		/// [AIR] An arbitrary data object associated with this menu item.
		public var data:Object;

		/// [AIR] Creates a new NativeMenuItem object.
		public function NativeMenuItem(label:String, isSeparator:Boolean=false);

		/// [AIR] Creates a copy of the NativeMenuItem object.
		public function clone():flash.display.NativeMenuItem;

		/// [AIR] Returns a string containing all the properties of the NativeMenuItem object.
		public function toString():String;

	}

}

