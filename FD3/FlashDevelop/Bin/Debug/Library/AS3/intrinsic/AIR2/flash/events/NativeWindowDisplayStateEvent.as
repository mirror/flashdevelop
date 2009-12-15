package flash.events
{
	import flash.events.Event;

	/// A NativeWindow object dispatches events of the NativeWindowDisplayStateEvent class when the window display state changes.
	public class NativeWindowDisplayStateEvent extends Event
	{
		/// Defines the value of the type property of a displayStateChange event object.
		public static const DISPLAY_STATE_CHANGE : String = "displayStateChange";
		/// Defines the value of the type property of a displayStateChanging event object.
		public static const DISPLAY_STATE_CHANGING : String = "displayStateChanging";

		/// The display state of the NativeWindow after the change.
		public function get afterDisplayState () : String;

		/// The display state of the NativeWindow before the change.
		public function get beforeDisplayState () : String;

		/// Creates a copy of the NativeWindowDisplayStateEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Creates an Event object with specific information relevant to window display state events.
		public function NativeWindowDisplayStateEvent (type:String, bubbles:Boolean = true, cancelable:Boolean = false, beforeDisplayState:String = "", afterDisplayState:String = "");

		/// Returns a string that contains all the properties of the NativeWindowDisplayStateEvent object.
		public function toString () : String;
	}
}
