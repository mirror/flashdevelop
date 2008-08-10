/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.display {
	import flash.events.EventDispatcher;
	public class NativeMenuItem extends EventDispatcher {
		/**
		 * Controls whether this menu item displays a checkmark.
		 */
		public function get checked():Boolean;
		public function set checked(value:Boolean):void;
		/**
		 * An arbitrary data object associated with this menu item.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * Controls whether this menu item is enabled.
		 */
		public function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		/**
		 * Reports whether this item is a menu separator line.
		 */
		public function get isSeparator():Boolean;
		/**
		 * The key equivalent for this menu item.
		 */
		public function get keyEquivalent():String;
		public function set keyEquivalent(value:String):void;
		/**
		 * The array of key codes for the key equivalent modifiers.
		 */
		public function get keyEquivalentModifiers():Array;
		public function set keyEquivalentModifiers(value:Array):void;
		/**
		 * The display string of this menu item.
		 */
		public function get label():String;
		public function set label(value:String):void;
		/**
		 * The menu that contains this item.
		 */
		public function get menu():NativeMenu;
		/**
		 * The position of the mnemonic character in the menu item label.
		 */
		public function get mnemonicIndex():int;
		public function set mnemonicIndex(value:int):void;
		/**
		 * The name of this menu item.
		 */
		public function get name():String;
		public function set name(value:String):void;
		/**
		 * The submenu associated with this menu item.
		 */
		public function get submenu():NativeMenu;
		public function set submenu(value:NativeMenu):void;
		/**
		 * Creates a new NativeMenuItem object.
		 *
		 * @param label             <String (default = "")> The display label for the item, or an empty string for separators.
		 * @param isSeparator       <Boolean (default = false)> Set to true to create a separator; set to
		 *                            false otherwise.
		 */
		public function NativeMenuItem(label:String = "", isSeparator:Boolean = false);
		/**
		 * Creates a copy of the NativeMenuItem object.
		 */
		public function clone():NativeMenuItem;
		/**
		 * Returns a string containing all the properties of the NativeMenuItem object.
		 *
		 * @return                  <String> A string containing all the properties of the Event object.
		 */
		public override function toString():String;
	}
}
