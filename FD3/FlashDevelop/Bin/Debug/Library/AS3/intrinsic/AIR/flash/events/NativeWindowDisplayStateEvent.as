package flash.events
{
	import flash.events.Event;

	/// A NativeWindow object dispatches events of the NativeWindowDisplayStateEvent class when the window display state changes.
	public class NativeWindowDisplayStateEvent extends Event
	{
		/// [AIR] Defines the value of the type property of a displayStateChange event object.
		public static const DISPLAY_STATE_CHANGE : String = "displayStateChange";
		/// [AIR] Defines the value of the type property of a displayStateChanging event object.
		public static const DISPLAY_STATE_CHANGING : String = "displayStateChanging";

		/// [AIR] The display state of the NativeWindow after the change.
		public function get afterDisplayState () : String;

		/// [AIR] The display state of the NativeWindow before the change.
		public function get beforeDisplayState () : String;

		/// [AIR] Creates a copy of the NativeWindowDisplayStateEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// [AIR] Returns a string that contains all the properties of the NativeWindowDisplayStateEvent object.
		public function toString () : String;
	}
}
