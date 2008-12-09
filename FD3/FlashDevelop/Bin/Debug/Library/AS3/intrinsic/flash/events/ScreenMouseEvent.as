package flash.events
{
	/// The SystemTrayIcon object dispatches events of type ScreenMouseEvent in response to mouse interaction.
	public class ScreenMouseEvent extends flash.events.MouseEvent
	{
		/// [AIR] The X position of the click in screen coordinates.
		public var screenX:Number;

		/// [AIR] The Y position of the click in screen coordinates.
		public var screenY:Number;

		/// [AIR] Constructor for ScreenMouseEvent objects.
		public function ScreenMouseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, screenX:Number=unknown, screenY:Number=unknown, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false, buttonDown:Boolean=false, commandKey:Boolean=false, controlKey:Boolean=false);

		/// [AIR] Creates a copy of the ScreenMouseEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// [AIR] Returns a string that contains all the properties of the ScreenMouseEvent object.
		public function toString():String;

	}

}

