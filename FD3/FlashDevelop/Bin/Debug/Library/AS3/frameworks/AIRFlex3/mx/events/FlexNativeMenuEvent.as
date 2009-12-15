package mx.events
{
	import flash.events.Event;
	import flash.display.NativeMenuItem;
	import flash.display.NativeMenu;

	public class FlexNativeMenuEvent extends Event
	{
		public var index : int;
		public var item : Object;
		public static const ITEM_CLICK : String = "itemClick";
		public var label : String;
		public static const MENU_SHOW : String = "menuShow";
		public var nativeMenu : NativeMenu;
		public var nativeMenuItem : NativeMenuItem;
		public static const VERSION : String;

		public function clone () : Event;

		public function FlexNativeMenuEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = true, nativeMenu:NativeMenu = null, nativeMenuItem:NativeMenuItem = null, item:Object = null, label:String = null, index:int = -1);
	}
}
