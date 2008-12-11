package flash.events
{
	/// A NativeWindow object dispatches events of the NativeWindowDisplayStateEvent class when the window display state changes.
	public class NativeWindowDisplayStateEvent extends flash.events.Event
	{
		/// [AIR] Defines the value of the type property of a displayStateChanging event object.
		public static const DISPLAY_STATE_CHANGING:String = "displayStateChanging";

		/// [AIR] Defines the value of the type property of a displayStateChange event object.
		public static const DISPLAY_STATE_CHANGE:String = "displayStateChange";

		/// [AIR] The display state of the NativeWindow before the change.
		public var beforeDisplayState:String;

		/// [AIR] The display state of the NativeWindow after the change.
		public var afterDisplayState:String;

		/// [AIR] Creates an Event object with specific information relevant to window display state events.
		public function NativeWindowDisplayStateEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, beforeDisplayState:String, afterDisplayState:String);

		/// [AIR] Creates a copy of the NativeWindowDisplayStateEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// [AIR] Returns a string that contains all the properties of the NativeWindowDisplayStateEvent object.
		public function toString():String;

	}

}

